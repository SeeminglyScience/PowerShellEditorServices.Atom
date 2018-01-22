#requires -Version 5.1

[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string] $Configuration = 'Debug',

    [switch] $Force
)

$moduleName = 'PowerShellEditorServices.Atom'
$testModuleManifestSplat = @{
    ErrorAction   = 'Ignore'
    WarningAction = 'Ignore'
    Path          = "$PSScriptRoot\module\$moduleName.psd1"
}

$manifest = Test-ModuleManifest @testModuleManifestSplat

$script:Settings = @{
    Name          = $moduleName
    Manifest      = $manifest
    Version       = $manifest.Version
    ShouldTest    = $true
    PSESVersion   = '1.5.0'
}

$script:Folders  = @{
    PowerShell = "$PSScriptRoot\module"
    CSharp     = "$PSScriptRoot\src\PSToolsmiths.PowerShell.Atom"
    Build      = '{0}\src\PSToolsmiths.PowerShell.Atom\bin\{1}' -f $PSScriptRoot, $Configuration
    Release    = '{0}\Release\{1}\{2}' -f $PSScriptRoot, $moduleName, $manifest.Version
    Docs       = "$PSScriptRoot\docs"
    Test       = "$PSScriptRoot\test"
    Results    = "$PSScriptRoot\testresults"
}

$script:Discovery = @{
    HasDocs       = Test-Path ('{0}\{1}\*.md' -f $Folders.Docs, $PSCulture)
    HasTests      = Test-Path ('{0}\*.Tests.ps1' -f $Folders.Test)
    IsUnix        = $PSVersionTable.PSEdition -eq "Core" -and -not $IsWindows
}

$tools = "$PSScriptRoot\tools"
$script:GetDotNet = Get-Command $tools\GetDotNet.ps1
$script:AssertModule = Get-Command $tools\AssertRequiredModule.ps1
$script:AssertPSES = Get-Command $tools\AssertPSES.ps1

task AssertDotNet {
    $script:dotnet = & $GetDotNet -Unix:$Discovery.IsUnix
}

task AssertPSES {
    & $AssertPSES -RequiredVersion $Settings.PSESVersion
}

task AssertRequiredModules {
    & $AssertModule Pester 4.1.1 -Force:$Force.IsPresent
    & $AssertModule InvokeBuild 5.0.0 -Force:$Force.IsPresent
    & $AssertModule platyPS 0.9.0 -Force:$Force.IsPresent
}

# TODO: Look into replacing this junk with PSDepend
task AssertDevDependencies -Jobs AssertDotNet, AssertRequiredModules, AssertPSES

task Clean {
    if ($PSScriptRoot -and (Test-Path $PSScriptRoot\Release)) {
        Remove-Item $PSScriptRoot\Release -Recurse
    }

    $null = New-Item $Folders.Release -ItemType Directory
    if (Test-Path $Folders.Results) {
        Remove-Item $Folders.Results -Recurse
    }

    $null = New-Item $Folders.Results -ItemType Directory
    & $dotnet clean
}

task BuildDocs -If { $Discovery.HasDocs } {
    $sourceDocs  = "$PSScriptRoot\docs\$PSCulture"
    $releaseDocs = '{0}\{1}' -f $Folders.Release, $PSCulture

    $null = New-Item $releaseDocs -ItemType Directory -Force -ErrorAction SilentlyContinue
    $null = New-ExternalHelp -Path $sourceDocs -OutputPath $releaseDocs
}

task BuildDll {
    if (-not $Discovery.IsUnix) {
        & $dotnet build --configuration $Configuration --framework net452
    }
    & $dotnet build --configuration $Configuration --framework netcoreapp2.0
}

task CopyToRelease  {
    $powershellSource  = '{0}\*' -f $Folders.PowerShell
    $release           = $Folders.Release
    $releaseDesktopBin = "$release\bin\Desktop"
    $releaseCoreBin    = "$release\bin\Core"
    $sourceDesktopBin  = '{0}\net452\{1}*' -f $Folders.Build, $Settings.Name
    $sourceCoreBin     = '{0}\netcoreapp2.0\{1}*' -f $Folders.Build, $Settings.Name
    Copy-Item -Path $powershellSource -Destination $release -Recurse -Force

    if (-not $Discovery.IsUnix) {
        $null = New-Item $releaseDesktopBin -Force -ItemType Directory
        Copy-Item -Path $sourceDesktopBin -Destination $releaseDesktopBin -Force
    }

    $null = New-Item $releaseCoreBin -Force -ItemType Directory
    Copy-Item -Path $sourceCoreBin -Destination $releaseCoreBin -Force
}

task Build -Jobs AssertDevDependencies, Clean, BuildDll, CopyToRelease, BuildDocs

task . Build

