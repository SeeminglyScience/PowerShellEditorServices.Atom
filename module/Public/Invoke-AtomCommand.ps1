function Invoke-AtomCommand {
    <#
    .EXTERNALHELP PowerShellEditorServices.Atom-help.xml
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )
    process {
        $requestTask = $ATOM_MESSENGER.MessageSender.SendRequest(
            <# requestType:     #> [PSToolsmiths.PowerShell.Atom.Requests.AtomCommandInvocationRequest]::Type,
            <# requestParams:   #> $Name,
            <# waitForResponse: #> $true)

        $null = $requestTask | AwaitTask
    }
}
