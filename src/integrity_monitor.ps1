Function CalculateHash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA256
    # This return: Algorithm used, Hash and Path
    return $filehash
}

Function DeleteMonitoredIfAlreadyExist() {
    $exist = Test-Path -Path "INSERT_PATH_HERE\monitored.txt"
    if ($exist) {
        Remove-Item -Path "INSERT_PATH_HERE\monitored.txt"
    }
}

Write-Host " "
Write-Host "What would you like to do?"
Write-Host "1) Add new file"
Write-Host "2) Begin monitoring"
Write-Host " "

$choise = Read-Host -Prompt "Enter '1' or '2'"

if ($choise -eq "1")
{
    # Delete monitored.txt if it already exists
    DeleteMonitoredIfAlreadyExist

    # Calculate Hash from the file and store it in monitored.txt
    Write-Host "Adding a new file . . ." -ForegroundColor Cyan
    Write-Host " "

    # Collect all files in target folder
    $target = Read-Host -Prompt "Enter folder directory"
    $files = Get-ChildItem -Path $target

    # For each file calculate the hash and save it
    foreach ($i in $files) {
        $hash = CalculateHash $i.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath "INSERT_PATH_HERE\monitored.txt" -Append
    }
}

elseif ($choise -eq "2")
{
    # Check if monitored.txt exists
    $exist = Test-Path -Path "INSERT_PATH_HERE\monitored.txt"
    if ($exist) {

        # Begin monitoring files saved in monitored.txt
        Write-Host "Starting monitoring . . ." -ForegroundColor Green
        Write-Host " "
    
        # Load path|hash from monitored.txt and store them in a dictionary
        $hashDictionary = @{}
    
        # Get-Content read each line separately
        $files = Get-Content -Path "INSERT_PATH_HERE\monitored.txt"

        foreach ($i in $files) {
            # Split function returns an array, so we put the path as the index and the hash as the value of the dictionary
            $hashDictionary.add($i.Split("|")[0],$i.Split("|")[1])
        }

        # Continuously monitor files
        while ($true) {
            Start-Sleep -Seconds 1
        
            $files = Get-ChildItem -Path $target

            foreach ($i in $files) {
                $hash = CalculateHash $i.FullName
            
                if ($hashDictionary[$hash.Path] -eq $null) {
                    # A file has been created
                    Write-Host "$($hash.Path) has been created!" -ForegroundColor Green
                }

                else {
                    if ($hashDictionary[$hash.Path] -eq $hash.Hash) {
                        # Nothing has changed
                    }

                    else {
                        # A file has been compromised
                        Write-Host "$($hash.Path) has been compromised!" -ForegroundColor Red
                    }
                }
            }

            foreach ($key in $hashDictionary.Keys) {
                $stillExist = Test-Path -Path $key
                if (-Not $stillExist) {
                    # One of the monitored file has been deleted
                    Write-Host "$($key) has been deleted!" -ForegroundColor Red
                }
            }
        }
    }

    # If monitored.txt doesn't exists
    else {
        Write-Host "Error: There are no files to monitor, please add files first"
    }
}

else
{
    # The user didn't choose a possible option

    Write-Host "Error: You didn't choose a valid option" -ForegroundColor Yellow
}
