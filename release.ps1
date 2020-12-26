$version = (Get-Date -format "yyyy.MM.dd.HHmm")

Write-Host "Tag will be $version"
Write-Host

git tag $version
git push --tags