# Exit 0 if the vault changed since last successful sync, 1 if not.
# With -Save: store the current hash as the last synced state.
param([switch]$Save)
$vault = 'C:\Users\tobi4\Documents\Obsidian Vault'
$stateFile = Join-Path $PSScriptRoot '.last-sync-hash'

$files = Get-ChildItem -LiteralPath $vault -Recurse -File -Force |
  Where-Object { $_.FullName -notmatch '\\.obsidian(\|$)' -and $_.FullName -notmatch '\\.trash(\|$)' } |
  Sort-Object FullName
$sb = New-Object System.Text.StringBuilder
foreach ($f in $files) {
  $rel = $f.FullName.Substring($vault.Length)
  $h = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash
  [void]$sb.AppendLine("$rel|$h")
}
$sha = [System.Security.Cryptography.SHA256]::Create()
$current = [BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($sb.ToString()))) -replace '-', ''

if ($Save) { Set-Content -LiteralPath $stateFile -Value $current -Encoding ascii; exit 0 }
$last = if (Test-Path -LiteralPath $stateFile) { (Get-Content -LiteralPath $stateFile -Raw).Trim() } else { '' }
if ($current -eq $last) { exit 1 } else { exit 0 }
