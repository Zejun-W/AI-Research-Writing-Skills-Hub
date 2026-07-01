param(
    [string]$CommitMessage = "docs: update repository catalog",
    [switch]$SkipPagesCheck
)

$ErrorActionPreference = "Stop"

$Repo = "Zejun-W/AI-Research-Writing-Skills-Hub"
$RepoUrl = "https://github.com/$Repo"
$RemoteUrl = "$RepoUrl.git"
$PagesUrl = "https://zejun-w.github.io/AI-Research-Writing-Skills-Hub/"
$Description = "A bilingual curated hub of AI research writing prompts, skills, agents, and academic workflows for Codex, Claude Code, Cursor, and other AI coding assistants."

function Find-CommandPath {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [string[]]$FallbackPaths = @()
    )

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }

    foreach ($path in $FallbackPaths) {
        if ($path -and (Test-Path -LiteralPath $path)) {
            return $path
        }
    }

    throw "$Name is not installed or not available in PATH."
}

function Run {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(ValueFromRemainingArguments = $true)][string[]]$Rest
    )

    & $FilePath @Rest
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed: $FilePath $($Rest -join ' ')"
    }
}

function Run-Gh {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Rest)
    Run $script:Gh @Rest
}

function Invoke-Quiet {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(ValueFromRemainingArguments = $true)][string[]]$Rest
    )

    $previous = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        & $FilePath @Rest > $null 2> $null
        return $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previous
    }
}

function Has-GhRepo {
    return ((Invoke-Quiet $script:Gh repo view $Repo) -eq 0)
}

function Get-RelativePath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $full = [System.IO.Path]::GetFullPath($Path)
    $root = [System.IO.Path]::GetFullPath($script:ProjectRoot)
    $rootUri = New-Object System.Uri(($root.TrimEnd('\') + '\'))
    $fileUri = New-Object System.Uri($full)
    return [System.Uri]::UnescapeDataString($rootUri.MakeRelativeUri($fileUri).ToString()).Replace('/', '\')
}

function Test-IgnoredByGit {
    param([Parameter(Mandatory = $true)][string]$Path)

    return ((Invoke-Quiet $script:Git check-ignore -q -- $Path) -eq 0)
}

function Test-TrackedByGit {
    param([Parameter(Mandatory = $true)][string]$Path)

    return ((Invoke-Quiet $script:Git ls-files --error-unmatch -- $Path) -eq 0)
}

function Assert-NoSensitiveFiles {
    $patterns = @(
        '(^|\\)\.env(\..*)?$',
        '\.token$',
        '\.key$',
        '(^|\\)credentials\.json$',
        '(^|\\)cookies\.json$',
        '(^|\\)__pycache__(\\|$)',
        '(^|\\)node_modules(\\|$)',
        '(^|\\)\.DS_Store$',
        '(^|\\)Thumbs\.db$'
    )

    $blocked = New-Object System.Collections.Generic.List[string]
    Get-ChildItem -LiteralPath $script:ProjectRoot -Force -Recurse -File | ForEach-Object {
        if ($_.FullName -like "$script:ProjectRoot\.git\*") {
            return
        }

        $relative = Get-RelativePath $_.FullName
        foreach ($pattern in $patterns) {
            if ($relative -match $pattern) {
                if ((Test-TrackedByGit $relative) -or -not (Test-IgnoredByGit $relative)) {
                    $blocked.Add($relative)
                }
                break
            }
        }
    }

    if ($blocked.Count -gt 0) {
        throw "Sensitive or generated files would be committed: $($blocked -join ', '). Add them to .gitignore or untrack them before publishing."
    }
}

function Ensure-Origin {
    $existing = & $script:Git remote get-url origin 2>$null
    if ($LASTEXITCODE -ne 0) {
        Run $script:Git remote add origin $RemoteUrl
        return
    }

    if ($existing -ne $RemoteUrl) {
        Write-Host "Updating origin from $existing to $RemoteUrl"
        Run $script:Git remote set-url origin $RemoteUrl
    }
}

function Ensure-PagesConfigured {
    if ((Invoke-Quiet $script:Gh api "repos/$Repo/pages") -eq 0) {
        if ((Invoke-Quiet $script:Gh api --method PUT "repos/$Repo/pages" --field build_type=workflow) -ne 0) {
            throw "GitHub Pages exists, but could not be switched to workflow build type."
        }
        return
    }

    if ((Invoke-Quiet $script:Gh api --method POST "repos/$Repo/pages" --field build_type=workflow) -ne 0) {
        throw "GitHub Pages could not be initialized with workflow build type."
    }
}

function Test-PagesUrl {
    if ($SkipPagesCheck) {
        Write-Host "Skipping Pages HTTP check."
        return
    }

    for ($i = 1; $i -le 6; $i++) {
        try {
            $response = Invoke-WebRequest -Uri $PagesUrl -UseBasicParsing -TimeoutSec 20
            if ([int]$response.StatusCode -ge 200 -and [int]$response.StatusCode -lt 400) {
                Write-Host "GitHub Pages is reachable: $PagesUrl"
                return
            }
        }
        catch {
            if ($i -eq 6) {
                throw "GitHub Pages is not reachable yet: $($_.Exception.Message)"
            }
            Start-Sleep -Seconds 15
        }
    }
}

$script:ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -LiteralPath $script:ProjectRoot

$script:Git = Find-CommandPath "git"
$script:Gh = Find-CommandPath "gh" @(
    "C:\Program Files\GitHub CLI\gh.exe",
    "$env:LOCALAPPDATA\Programs\GitHub CLI\gh.exe"
)

Write-Host "Project: $script:ProjectRoot"
Run $script:Git --version
Run $script:Gh --version

Run-Gh auth status
$login = & $script:Gh api user --jq ".login"
if ($LASTEXITCODE -ne 0 -or $login -ne "Zejun-W") {
    throw "GitHub CLI must be logged in as Zejun-W. Current account: $login"
}
Run-Gh auth setup-git

if (-not (Test-Path -LiteralPath ".git")) {
    Run $script:Git init
}

Run $script:Git branch -M main
Ensure-Origin

if (-not (Has-GhRepo)) {
    Run-Gh repo create $Repo --public --description $Description
}
else {
    $visibility = & $script:Gh repo view $Repo --json isPrivate --jq ".isPrivate"
    if ($LASTEXITCODE -eq 0 -and $visibility -eq "true") {
        Run-Gh repo edit $Repo --visibility public --accept-visibility-change-consequences
    }
}

Assert-NoSensitiveFiles

if ((Invoke-Quiet $script:Git fetch origin main) -eq 0) {
    Write-Host "Fetched origin/main. Push will remain non-forced."
}

Run $script:Git add -A
& $script:Git diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "No local changes to commit."
}
else {
    Run $script:Git commit -m $CommitMessage
}

Run $script:Git push -u origin main

try {
    Ensure-PagesConfigured
}
catch {
    Write-Warning "Could not configure Pages through API yet: $($_.Exception.Message)"
}

try {
    Run-Gh workflow run pages.yml --repo $Repo --ref main
}
catch {
    Write-Warning "Could not manually trigger pages.yml. It may already be running from the push: $($_.Exception.Message)"
}

Run-Gh run list --repo $Repo --limit 5
Test-PagesUrl

Write-Host "Repository: $RepoUrl"
Write-Host "GitHub Pages: $PagesUrl"
