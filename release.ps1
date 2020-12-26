$Version = (Get-Date -AsUTC -Format "yyyy.MM.dd.HHmm")

Write-Host "Tag will be $Version"
Write-Host

git tag $Version
git push --tags