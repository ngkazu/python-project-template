<#
.SYNOPSIS
    このひな型から、指定した名前で新しいプロジェクトフォルダを生成する。

.PARAMETER Name
    生成するプロジェクト名（フォルダ名 兼 README.md のタイトルに使用）。

.PARAMETER Destination
    生成先の親フォルダ。省略時はこのテンプレートの一つ上の階層。

.EXAMPLE
    .\create_project.ps1 -Name my-new-project
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [string]$Destination = (Split-Path $PSScriptRoot -Parent)
)

# 生成先には含めないもの（このスクリプト自身・生成物・キャッシュ類）
$exclude = @(
    '.git', '.venv', 'build', 'dist',
    '.pytest_cache', '.ruff_cache', '.mypy_cache', '__pycache__',
    (Split-Path $PSCommandPath -Leaf)
)

$target = Join-Path $Destination $Name
if (Test-Path $target) {
    throw "生成先が既に存在します: $target"
}

New-Item -ItemType Directory -Path $target | Out-Null

Get-ChildItem -Path $PSScriptRoot -Force |
    Where-Object { $exclude -notcontains $_.Name } |
    ForEach-Object { Copy-Item -Path $_.FullName -Destination $target -Recurse }

# コピー時に混入した __pycache__ 等のキャッシュを除去
Get-ChildItem -Path $target -Recurse -Force -Directory -Include '__pycache__' |
    Remove-Item -Recurse -Force

# build/ dist/ は README.md のみ引き継ぐ（.gitignore の例外設定に合わせる）
foreach ($dir in @('build', 'dist')) {
    New-Item -ItemType Directory -Path (Join-Path $target $dir) -Force | Out-Null
    Copy-Item -Path (Join-Path $PSScriptRoot "$dir\README.md") -Destination (Join-Path $target "$dir\README.md")
}

$readme = Join-Path $target 'README.md'
(Get-Content $readme -Raw) -replace '^# python-project-template', "# $Name" |
    Set-Content $readme -NoNewline

Write-Host "生成しました: $target"
