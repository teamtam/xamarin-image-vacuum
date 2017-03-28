#
# Module manifest for module 'FileSystemHelper'
#
# Generated by: Benjamin Tam
#
# Generated on: 28/03/2017
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'FileSystemHelper.psm1'

# Version number of this module.
ModuleVersion = '0.9'

# ID used to uniquely identify this module
GUID = '6bfba4c4-e713-4c33-91fa-249bc68819c1'

# Author of this module
Author = 'Benjamin Tam'

# Copyright statement for this module
Copyright = '(c) 2017 Benjamin Tam. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Internal helper module used by XamarinImageImporter to work with the file system.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Get-Filename',
    'Copy-Image',
    'Copy-ImageAndRename'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/teamtam/xamarin-image-importer/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/teamtam/xamarin-image-importer'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

