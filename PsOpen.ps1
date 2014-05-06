$solutions = @{}

$favSolutions = $PSScriptRoot + '\favs.xml'
if(Test-Path $favSolutions) {
    $solutions = Import-CliXml $favSolutions 
}

function Open-Solution($name = '*', $path = '.') {
    if ($name -ne '*') {
        handleSolutionName($name)
        return
    }

    $sln = Get-ChildItem $path "$name.sln" -Recurse | Select-Object -First 1;
    startSolution($sln)
}

function Find-Solutions($path = '.') {
    $slns = Get-ChildItem $path "*.sln" -Recurse

}

# Many thanks to Jeremy Skinner's posthttp://www.jeremyskinner.co.uk/2010/03/07/using-git-with-windows-powershell/
function TabExpansion($line, $lastWord) {
    $LineBlocks = [regex]::Split($line, '[|;]')
    $lastBlock = $LineBlocks[-1]

    switch -regex ($lastBlock) {
        'Open-Solution (.*)' { handleTab($lastBlock) }
    }
}

function handleTab($lastBlock) {
    $solutions.Keys | sort
}

function handleSolutionName($name) {
    $fullName = $solutions.Get_Item($name)
    if ($fullName) {
        $sln = Get-Item $fullName
        startSolution $sln
    }
}

function startSolution($sln) {
    if ($sln) {
        Write-Host "Opening " $sln.Name " now ..."
        # start $sln.FullName
        Write-Host "VS " $sln.FullName
        
        rememberSolution($sln)

        return
    }

    Write-Host "Cannot find the solution file" 
}

function rememberSolution($sln) {
    $solutions = Import-CliXml $favSolutions 
    if (!$solutions.ContainsKey($sln.Name)) {
        $solutions.Add($sln.Name, $sln.FullName)
    }
    
    $solutions | Export-CliXml -Path $favSolutions
}

