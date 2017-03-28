﻿[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]$image,
	
    [Parameter(Mandatory=$True)]
    [string]$iosProject,

    [Parameter(Mandatory=$False)]
    [string]$iosResources,

    [Parameter(Mandatory=$False)]
    [bool]$move = $False
)

[string]$script:iosResourcesDirectoryName = $iosResources
[string]$script:iosImage1 = $image
[string]$script:iosImage2 = ""
[string]$script:iosImage3 = ""

function Test-Parameters()
{
    $parametersOk = $True

    if (!(Test-Path $image))
    {
        $parametersOk = $False
        Write-Error "Did not find $image"
    }
    if (!($image.EndsWith(".png")))
    {
        $parametersOk = $False
        Write-Error "$image is not a .png"
    }

    if (!(Test-Path $iosProject))
    {
        $parametersOk = $False
        Write-Error "Did not find $iosProject"
    }
    if (!($iosProject.EndsWith(".csproj")))
    {
        $parametersOk = $False
        Write-Error "$iosProject is not a .csproj"
    }

    if (!([string]::IsNullOrEmpty($iosResources)))
    {
        if (!(Test-Path $iosResources))
        {
            $parametersOk = $False
            Write-Error "Did not find $iosResources"
        }
    }
    elseif (Test-Path $iosProject)
    {
        $iosProjectDirectory = Get-Item (Get-Item $iosProject).DirectoryName
        $script:iosResourcesDirectoryName = $iosProjectDirectory.ToString() + "\Resources"
    }

    return $parametersOk
}

function Copy-ImagesToResources()
{
    $script:iosImage1 = Copy-Image $image $script:iosResourcesDirectoryName $move

    $script:iosImage2 = $image.Substring(0, $image.Length - 4) + "@2x.png"
    $script:iosImage2 = Copy-Image $script:iosImage2 $script:iosResourcesDirectoryName $move

    $script:iosImage3 = $image.Substring(0, $image.Length - 4) + "@3x.png"
    $script:iosImage3 = Copy-Image $script:iosImage3 $script:iosResourcesDirectoryName $move
}

function Add-ImagesToProject()
{
    $projectXml = [xml](Get-Content $iosProject)

    $nsmgr = Get-Namespace $projectXml

    #$itemGroup = Get-BundleResourceItemGroup $projectXml $nsmgr
    #Write-Debug $itemGroup.GetType()
    $firstItemGroupNode = $projectXml.SelectNodes("//a:BundleResource", $nsmgr)[1]
    [System.Xml.XmlElement]$itemGroup
    if ($firstItemGroupNode)
    {
        $itemGroup = $firstItemGroupNode.ParentNode
    }
    else
    {
        $itemGroup = $projectXml.CreateElement("ItemGroup", $xmlns)
        $x = $projectXml.Project.AppendChild($itemGroup)
    }

    Add-BundleResource $projectXml $nsmgr $itemGroup $script:iosImage1 $iosProject
    if (Test-Path $script:iosImage2)
    {
        Add-BundleResource $projectXml $nsmgr $itemGroup $script:iosImage2 $iosProject
    }
    if (Test-Path $script:iosImage3)
    {
        Add-BundleResource $projectXml $nsmgr $itemGroup $script:iosImage3 $iosProject
    }

    $projectXml.Save($iosProject)
}

Import-Module -Name .\'FileSystem.psm1' # -Verbose -Force
Import-Module -Name .\'Project.psm1' # -Verbose -Force

$parametersOk = Test-Parameters
if ($parametersOk)
{
    Copy-ImagesToResources
    Add-ImagesToProject
}
else
{
    exit 1
}