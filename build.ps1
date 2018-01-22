[CmdletBinding()]
param(
    [switch] $Force
)
end {
    & "$PSScriptRoot\tools\AssertRequiredModule.ps1" InvokeBuild 5.0.0 -Force:$Force.IsPresent
    $invokeBuildSplat = @{
        Task = 'PreRelease'
        File = "$PSScriptRoot/PowerShellEditorServices.Atom.build.ps1"
        Force = $Force.IsPresent
        Configuration = 'Release'
    }

    Invoke-Build @invokeBuildSplat
}
