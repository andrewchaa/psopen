function Open-Solution($solutionName = '*', $path = '.') {
    $sln = Get-ChildItem $path "$solutionName.sln" -Recurse | Select-Object -First 1;
    if ($sln) {
        Write-Host "Opening " $sln.Name " now ..."
        start $sln.FullName
    }
}
