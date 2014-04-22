function open($path = '.') {
    $sln = ls $path *.sln -Rec | select -First 1;
    if ($sln) {
        Write-Host "Opening " $sln.Name " now ..."
        start $sln.FullName 
    }
}
