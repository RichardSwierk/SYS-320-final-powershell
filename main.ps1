function outputs
{
    param([int]$num,[string]$path)
    switch($num)
    {
        1{
            Clear-Host
            Write-Host -ForegroundColor Magenta 'File has been saved to '$path'.cvs'
            Read-Host 'Press ENTER to continue...'
            System-Admin
        }
        2{
            Clear-Host
            Write-Host -ForegroundColor Red 'ERROR: File did not save. Please try again'
            Read-Host 'Press ENTER to continue...'
            List-Processes
        }
        3{
            Clear-Host
            Write-Host -ForegroundColor Red 'ERROR: The path that you entered does not exists. Please try again'
            Read-Host 'Press ENTER to continue...'
            List-Processes
        }
        4{
            Clear-Host
            Write-Host -ForegroundColor Yellow 'Enter the filename and loction to save the file'
            Write-Host -ForegroundColor Yellow 'Leave blank to not save the output'
            Write-Host -ForegroundColor Yellow 'EX: C:\Users\Username\Documents\filename'
            $path=Read-Host 'Filename and location'
            return $path
        }
    }
}
function List-Processes
{
    Clear-Host
    Write-Host -ForegroundColor Green 'Enter the name of the process'
    Write-Host -ForegroundColor Green 'Leave blank if you want to see all running processes'
    $processName=Read-Host 'Enter Process name'
    if(!$processName)
    {
        $path=outputs -num 4
        if(!$path)
        {
            Clear-Host
            Get-Process
            Read-Host 'Press ENTER to return to the System Admin Menu'
            System-Admin
        }else{
            $path=$path.replace('/','\')
            $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
            if($PathExists -eq $True)
            {
                Get-Process | Out-File $path'.cvs'
                $fileExists=test-path $path'.cvs'
                if($fileExists -eq $True)
                {
                    outputs -num 1 -path $path
                }else{
                    outputs -num 2
                }
            }else{
                outputs -num 3
            }
        }
    }else{
        $processActive=Get-Process $processName -ErrorAction SilentlyContinue
        if(!$processActive)
        {
            Clear-Host
            Write-Host -ForegroundColor Red 'ERROR: Process '$processName' is not running'
            Read-Host 'Press ENTER to return to the System Admin Menu'
            System-Admin
        }else{
            $path=outputs -num 4
            if(!$path)
            {
                Clear-Host
                Get-Process $processName
                Read-Host 'Press ENTER to continue...'
                System-Admin
            }else{
                $path=$path.replace('/','\')
                $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
                if($PathExists -eq $True)
                {
                    Get-Process $processName | Out-File $path'.cvs'
                    $fileExists=test-path $path'.cvs'
                    if($fileExists -eq $True)
                    {
                        outputs -num 1 -path $path
                    }else{
                        outputs -num 2
                    }
                }else{
                    outputs -num 3
                }
            }
        }
    }
}

function List-Services
{
    Clear-Host
    Write-Host -ForegroundColor Green 'Enter the name of the service'
    Write-Host -ForegroundColor Green 'Leave blank if you want to see all running services'
    $serviceName=Read-Host 'Enter service name'
    if(!$serviceName)
    {
        $path=outputs -num 4
        if(!$path)
        {
            Clear-Host
            Get-Service | Where-Object {$_.Status -eq "Running"}
            Read-Host 'Press Enter to return to the Systen Admin Menu'
            System-Admin
        }else{
            $path=$path.replace('/','\')
            $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
            if($PathExists -eq $True)
            {
                Get-Service | Where-Object {$_.Status -eq "Running"} | out-file $path'.cvs'
                $fileExists=test-path $path'.cvs'
                if($fileExists -eq $True)
                {
                    outputs -num 1 -path $path
                }else{
                    outputs -num 2
                }
            }else{
                outputs -num 3
            }
        }
    }else{
        $serviceActive=Get-Service -Name $serviceName -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq "Running"}
        if(!$serviceActive)
        {
            Clear-Host
            Write-Host -ForegroundColor Red 'ERROR: Service '$serviceName' is not running'
            Read-Host 'Press ENTER to return to the System Admin Menu'
            System-Admin
        }else{
            $path=outputs -num 4
            if(!$path)
            {
                Clear-Host
                Get-Service -Name $servieName | Where-Object {$_.Status -eq "Running"}
                Read-Host 'Press ENTER to continue...'
                System-Admin
            }else{
                $path=$path.replace('/','\')
                $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
                if($PathExists -eq $True)
                {
                    Get-Service -Name $serviceName | Out-File $path'.cvs'
                    $fileExists=test-path $path'.cvs'
                    if($fileExists -eq $True)
                    {
                        outputs -num 1 -path $path
                    }else{
                        outputs -num 2
                    }
                }else{
                    outputs -num 3
                }
            }
        }
    }
}

function List-Packages
{
    Clear-Host
    Write-Host -ForegroundColor Green 'Enter the name of the package'
    Write-Host -ForegroundColor Green 'Leave blank if you want to see all installed packages'
    $packageName=Read-Host 'Enter Package name'
    if(!$packageName)
    {
        $path=outputs -num 4
        if(!$path)
        {
            Clear-Host
            Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, InstallDate, DisplayVersion | Format-Table –AutoSize 
            Read-Host 'Press ENTER to return to the System Admin Menu'
            System-Admin
        }else{
            $path=$path.replace('/','\')
            $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
            if($PathExists -eq $True)
            {
                Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, InstallDate, DisplayVersion | Format-Table –AutoSize | Out-File $path'.cvs'
                $fileExists=test-path $path'.cvs'
                if($fileExists -eq $True)
                {
                    outputs -num 1 -path $path
                }else{
                    outputs -num 2
                }
            }else{
                outputs -num 3
            }
        }
    }else{
        $packageActive=Get-Package -Name $packageName -ErrorAction SilentlyContinue
        if(!$packageActive)
        {
            Clear-Host
            Write-Host -ForegroundColor Red 'ERROR: Package '$packageName' is not installed'
            Read-Host 'Press ENTER to return to the System Admin Menu'
            System-Admin
        }else{
            $path=outputs -num 4
            if(!$path)
            {
                Clear-Host
                Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, InstallDate, DisplayVersion | Where-object {$_.DisplayName -eq $packageName}
                Read-Host 'Press ENTER to continue...'
                System-Admin
            }else{
                $path=$path.replace('/','\')
                $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
                if($PathExists -eq $True)
                {
                    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, InstallDate, DisplayVersion | Where-object {$_.DisplayName -eq $packageName} | Out-File $path'.cvs'
                    $fileExists=test-path $path'.cvs'
                    if($fileExists -eq $True)
                    {
                        outputs -num 1 -path $path
                    }else{
                        outputs -num 2
                    }
                }else{
                    outputs -num 3
                }
            }
        }
    }
}

function List-SysInfo
{
    Clear-Host
    $path=outputs -num 4
    if(!$path)
    {
        Clear-Host
        Get-PSDrive -PSProvider "FileSystem" | select Name,MaxCapacity,Used,Free,Root
        Get-WmiObject -class "Win32_PhysicalMemoryArray" | select Name,MaxCapacity
        Get-WMIObject win32_Processor | select nameRead-Host 'Press ENTER to return to the System Admin Menu'
        System-Admin
    }else{
        $path=$path.replace('/','\')
        $PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
        if($PathExists -eq $True)
        {
            $disk=Get-PSDrive -PSProvider "FileSystem" | select Name,MaxCapacity,Used,Free,Root
            $ram=Get-WmiObject -class "Win32_PhysicalMemoryArray" | select Name,MaxCapacity
            $cpu=Get-WMIObject win32_Processor | select name
            $disk,$ram,$cpu | out-file $path'.cvs'
            $fileExists=test-path $path'.cvs'
            if($fileExists -eq $True)
            {
                outputs -num 1 -path $path
            }else{
                outputs -num 2
            }
        }else{
            outputs -num 3
        }
    }
}

function CheckLogName
{
	clear-host
	$logName=Read-Host 'Enter the name of log'
	$CheckIfExists=Get-EventLog -logname $logName -ErrorAction SilentlyContinue
	if(!$CheckIfExists)
	{
		Clear-host
		Write-host -foregroundcolor red 'The log Name you entered does not exist. Please try again'
		Read-Host 'Press ENTER to continue'
		CheckLogName
	}
	return
}

function List-EventLogs
{
	$keyword=''
	$timeAfter=''
	$timeBefore=''
	Clear-Host
	$logName=CheckLogName
	Clear-Host
	$numEvents=Read-Host 'Enter the number of events to display'
	Clear-Host
	Write-host 'Pick an option by entering the number of the option that you want'
	Write-host '1. Keyword search'
	Write-Host '2. timeframe search'
	$option=read-host 'Pick an option'
	switch($option)
	{
		1{
			Clear-Host
			$keyword=read-host 'Enter a keyword'
		}
		2{
			Clear-Host
			Write-host 'Ex: 1/17/2019 08:00:00'
			$timeAfter=Read-Host 'Enter a time to look at events after that time'
			$timeBefore=Read-host'Enter time to look at events before that time'
		}
	}
	$path=outputs -num 4
	if(!$path)
	{
		if(!$keyword)
		{
			$checkError=Get-EventLog -logname $logName -Newest $numEvents -After $timeAfter -Before $timeBefore -ErrorAction SilentlyContinue
			if($checkError -eq $True)
			{
				Clear-host
				$checkError
				Read-Host 'Press ENTER to return to System Admin Menu'
				System-Admin
			}else{
				Clear-host
				Write-host -ForegroundColor -Red 'ERROR the paramaters you entered do not return any results'
				read-host 'Press ENTER to return to System Admin Menu'
				System-Admin
			}
		}elseif(!$timeAfter)
		{
			$CheckError=Get-EventLog -logname $logName -Newest $numEvents -Message $Keyword
			if($checkError -eq $True)
			{
				Clear-host
				$checkError
				Read-Host 'Press ENTER to return to System Admin Menu'
				System-Admin
			}else{
				Clear-host
				Write-host -ForegroundColor -Red 'ERROR the paramaters you entered do not return any results'
				read-host 'Press ENTER to return to System Admin Menu'
				System-Admin
			}
		}
	}else{
        $path=$path.replace('/','\')
		$PathExists=Test-Path $path.Substring(0,$path.LastIndexOf('\'))
		if($PathExists -eq $True)
		{
			if(!$keyword)
			{
				$checkError=Get-EventLog -logname $logName -Newest $numEvents -After $timeAfter -Before $timeBefore -ErrorAction SilentlyContinue
				if($checkError -eq $True)
				{
					$checkError | out-file $path'.cvs'
				}else{
					Clear-host
					Write-host -ForegroundColor -Red 'ERROR the paramaters you entered do not return any results'
					read-host 'Press ENTER to return to System Admin Menu'
					System-Admin
				}
			}elseif(!$timeAfter)
			{
				$CheckError=Get-EventLog -logname $logName -Newest $numEvents -Message $Keyword
				if($checkError -eq $True)
				{
					$checkError | out-file $path'.cvs'
				}else{
					Clear-host
					Write-host -ForegroundColor -Red 'ERROR the paramaters you entered do not return any results'
					read-host 'Press ENTER to return to System Admin Menu'
					System-Admin
				}
			}
			$fileExists=test-path $path'.cvs'
			if($fileExists -eq $True)
			{
				outputs -num 1 -path $path
			}else{
				outputs -num 2
			}
		}else{
			outputs -num 3
		}
	}
}

function System-Admin
{
    Clear-Host
    Write-Host -ForegroundColor Yellow '==================== System Admin ===================='
    Write-Host -ForegroundColor Green '   To select an option enter the options number    '
    Write-Host -ForegroundColor Green '1: List all running processes'
    Write-Host -ForegroundColor Green '2: List all running services'
    Write-Host -ForegroundColor Green '3: List all installed packages'
    Write-Host -ForegroundColor Green '4: List the processor, amount of RAM, mounted disks, disk space available, and disk space used'
    Write-Host -ForegroundColor Green '5: List the available Windows Event Logs'
    Write-Host -ForegroundColor Green '6: Return to the Main Menu'
    Write-Host -ForegroundColor Green '7: Exit'
    $selection=Read-Host 'Make a selection'
    switch($selection)
    {
        '1' {List-Processes} 
        '2' {List-Services}
        '3' {List-Packages}
        '4' {List-SysInfo}
        '5' {List-EventLogs}
        '6' {MainMenu}
        '7' {return}
    }
}

function Search-Vulnerabilities
{
    Clear-Host
}

function Security-Admin
{
    Clear-Host
    Write-Host -ForegroundColor Yellow '==================== Security Admin ===================='
    Write-Host -ForegroundColor Green '   To select an option enter the options number    '
    Write-Host -ForegroundColor Green '1: Search for recent security vulnerabilities identified by the NVD project'
    Write-Host -ForegroundColor Green '2: Return the main menu'
    Write-Host -ForegroundColor Green '3: Exit'
    $selection=Read-Host 'Make a selection'
    switch($selection)
    {
        '1' {Search-Vulnerabilities} 
        '2' {MainMenu}
        '3' {return}
    }
}

function MainMenu
{
    Clear-Host
    Write-Host -ForegroundColor Yellow '==================== Main Menu ===================='
    Write-Host -ForegroundColor Green '   To select an option enter the options number    '
    Write-Host -ForegroundColor Green '1: System Admin'
    Write-Host -ForegroundColor Green '2: Security Admin'
    Write-Host -ForegroundColor Green '3: Exit'
    $selection=Read-Host 'Make a selection'
    switch($selection)
    {
        '1' {System-Admin} 
        '2' {Security-Admin}
        '3' {return}
    }
}
MainMenu
