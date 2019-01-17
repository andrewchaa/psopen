$solutions = @{}; 

if (Test-Path $env:USERPROFILE/ps-open.xml) {
    $solutions = Import-CliXml $env:USERPROFILE/ps-open.xml
}

if ((Test-Path Function:\TabExpansion) -and (Test-Path Function:\TabExpansionBackupForPsOpen) -eq $false) {
    Rename-Item Function:\TabExpansion TabExpansionBackupForPsOpen
}

function Open-Solution($name) {
    if ($name) {
        start $solutions."$name"
    } else {
        Write-Host "Plase use tab completion to find the solution name"
        Write-Host "To discover all solutions, please run Find-Solution"
    }
}

function Find-Solutions($path = '.') {
    $solutions = @{}
    $solutions = Get-ChildItem $path -Recurse -Filter *.sln | 
        %{ Write-Host Discovering $_.Name; @{($_.Name -replace "ClearBank.") = $_.FullName }}
    
    $solutions | Export-CliXml -Path $env:USERPROFILE\ps-open.xml
}

function handleTab($lastBlock) {
    switch -regex ($lastBlock) {
        'Open-SOlution (.*)$' {
            $solutions.Keys | Where { $_ -Like $matches[1] + '*' } | sort
        }
    }
}

function TabExpansion($line, $lastWord) {
    $LineBlocks = [regex]::Split($line, '[|;]')
    $lastBlock = $LineBlocks[-1]

    switch -regex ($lastBlock) {
        'Open-Solution (.*)' { handleTab($lastBlock) }

        default { if (Test-Path Function:\TabExpansionBackupForPsOpen) { TabExpansionBackupForPsOpen $line $lastWord } }
    }
}


