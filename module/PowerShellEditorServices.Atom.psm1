Import-LocalizedData -BindingVariable Strings -FileName Strings -ErrorAction Ignore

if (-not $PSVersionTable.PSEdition -or $PSVersionTable.PSEdition -eq 'Desktop') {
    Import-Module "$PSScriptRoot/bin/Desktop/PowerShellEditorServices.Atom.dll"
} else {
    Import-Module "$PSScriptRoot/bin/Core/PowerShellEditorServices.Atom.dll"
}

$script:ATOM_MESSENGER = [PSToolsmiths.PowerShell.Atom.Requests.AtomCommandInvocationRequest].Assembly.GetType(
    'PSToolsmiths.PowerShell.Atom.Messenger')::Create($psEditor)

# Include all function files.
Get-ChildItem $PSScriptRoot\Public\*.ps1, $PSScriptRoot\Private\*.ps1 | ForEach-Object {
    . $PSItem.FullName
}

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-* -Cmdlet *-*

