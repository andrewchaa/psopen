$solutions = @{}

# Many thanks to Jeremy Skinner's posthttp://www.jeremyskinner.co.uk/2010/03/07/using-git-with-windows-powershell/
function handleSolutionName($name) {
    $fullName = $solutions.Get_Item($name)
    if ($fullName) {
        return Get-Item $fullName
    }

    return Get-ChildItem $path "$name.sln" -Recurse | Select-Object -First 1;
}

function rememberSolution($sln) {
    if (Test-Path $favSolutions) {
        $solutions = Import-CliXml $favSolutions 
    }

    if ($solutions -and !$solutions.ContainsKey($sln.Name)) {
        $solutions.Add($sln.Name, $sln.FullName)
    }
    
    $solutions | Export-CliXml -Path $favSolutions
}

function startSolution($sln) {
    if ($sln) {
        Write-Host "Opening " $sln.Name " now ..."
        start $sln.FullName
        # Write-Host "VS " $sln.FullName
        
        rememberSolution($sln)

        return
    }

    Write-Host "Cannot find the solution file" 
}

function Open-Solution($name = '*', $path = '.') {
    if ($name -ne '*') {

        $sln = handleSolutionName($name)
        if ($sln) {
            startSolution($sln)
            return
        }
    }

    $sln = Get-ChildItem $path "$name.sln" -Recurse | Select-Object -First 1;
    startSolution($sln)
}

function handleTab($lastBlock) {
    switch -regex ($lastBlock) {
        'Open-SOlution (.*)$' {
            $solutions.Keys | Where { $_ -Like $matches[1] + '*' } | sort
        }
    }
    
}

function Find-Solutions($path = '.') {
    $slns = Get-ChildItem $path "*.sln" -Recurse

}


$favSolutions = $PSScriptRoot + '\favs.xml'
if(Test-Path $favSolutions) {
    $solutions = Import-CliXml $favSolutions 
}

if (Test-Path Function:\TabExpansion) {
    Rename-Item Function:\TabExpansion TabExpansionBackupForPsOpen
}

function TabExpansion($line, $lastWord) {
    $LineBlocks = [regex]::Split($line, '[|;]')
    $lastBlock = $LineBlocks[-1]

    switch -regex ($lastBlock) {
        'Open-Solution (.*)' { handleTab($lastBlock) }

        default { if (Test-Path Function:\TabExpansionBackupForPsOpen) { TabExpansionBackupForPsOpen $line $lastWord } }
    }
}


