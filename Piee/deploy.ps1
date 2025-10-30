<#
Deploy helper (PowerShell).
Usage:
  .\deploy.ps1 -RepoName MyRepo -Public

Requirements:
- git installed
- GitHub CLI (`gh`) installed and authenticated for automatic repo creation (optional but recommended)

What it does:
- Initializes git if needed, commits current files, creates a GitHub repo (via `gh`) or instructs manual repo creation,
- Pushes to `main` and prints the repo URL.
#>

param(
    [string]$RepoName = $(Split-Path -Leaf (Get-Location)),
    [switch]$Public,
    [string]$RemoteName = 'origin',
    [string]$Branch = 'main'
)

function Ensure-GitCommit {
    if (!(Test-Path .git)) { git init; Write-Host "Initialized git repository." -ForegroundColor Cyan }
    git add -A
    try { git commit -m "Initial commit" } catch { Write-Host "No changes to commit or commit failed." -ForegroundColor Yellow }
}

Write-Host "Preparing to deploy folder: $(Get-Location)" -ForegroundColor Cyan
Ensure-GitCommit

if (Get-Command gh -ErrorAction SilentlyContinue) {
    $visibility = $Public ? '--public' : '--private'
    Write-Host "Creating repository on GitHub (requires gh auth)..." -ForegroundColor Green
    gh repo create $RepoName $visibility --source=. --remote=$RemoteName --push --confirm
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Repository created and pushed." -ForegroundColor Green
    } else {
        Write-Host "gh create failed. Please create a repo manually and add remote." -ForegroundColor Red
    }
} else {
    Write-Host "GitHub CLI (gh) not found. Creating local repo only. Create a GitHub repo and run:" -ForegroundColor Yellow
    Write-Host "  git remote add origin https://github.com/<you>/$RepoName.git" -ForegroundColor Gray
    Write-Host "  git push -u origin $Branch" -ForegroundColor Gray
}

Write-Host "If you want automatic GitHub Pages deployment, enable Pages in the repository settings or use the provided GitHub Actions workflow included in .github/workflows/pages.yml" -ForegroundColor Cyan
