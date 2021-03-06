#
# Module manifest for module 'PowerShellEditorServices.Atom'
#
# Generated by: Patrick Meinecke
#
# Generated on: 1/21/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PowerShellEditorServices.Atom.psm1'

# Version number of this module.
ModuleVersion = '0.1.0'

# ID used to uniquely identify this module
GUID = '4084ea34-bc27-4814-b727-af9ee66b2c79'

# Author of this module
Author = 'Patrick Meinecke'

# Company or vendor of this module
CompanyName = 'Community'

# Copyright statement for this module
Copyright = '(c) 2018 Patrick Meinecke. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Provides support for the ide-powershell Atom package.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Invoke-AtomCommand'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# List of all files packaged with this module
FileList = 'Public\Invoke-AtomCommand.ps1',
           'Private\AwaitTask.ps1'
           'bin\Core\PowerShellEditorServices.Atom.dll',
           'bin\Desktop\PowerShellEditorServices.Atom.dll',
           'PowerShellEditorServices.Atom.psd1',
           'PowerShellEditorServices.Atom.psm1'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/SeeminglyScience/PowerShellEditorServices.Atom/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/SeeminglyScience/PowerShellEditorServices.Atom'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

}



