function open($path = '.') {
    $sln = ls $path *.sln -Rec | select -First 1;
    if ($sln) {
        start $sln.FullName 
        # write-host $sln.FullName 
    }
}
