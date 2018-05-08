# In the notification setting (Execute Program), use the following as parameters with the script:
#
# '%device' '%name' '%status' '%sensor' '%message' '%host' '%group' '%priority'
#
# Copy/paste as depicted...

### Put your telegram token in here!
$regel = "https://api.telegram.org/bot<telegram-token-here>/sendmessage?chat_id=<insert-chat-id>&text="
###

### Create log file, just in case, adjust path!
$Logfile = "d:\Scripts\LogAlerts.log" 
###

Param(	[String]$ServerName,
		[String]$AlertName,
		[String]$AlertStatus,
		[String]$AlertSensor,
		[String]$AlertMessage,
		[String]$AlertHost,
		[String]$AlertGroup,
		[String]$AlertPriority	)

start-sleep -s 1

$AlertFQDN = $AlertHost

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " Server: " + $ServerName
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertName: " + $AlertName
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertSatus: " + $AlertStatus
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertSensor: " + $AlertSensor
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertMessage: " + $AlertMessage
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertHost: " + $AlertHost
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertFQDN: " + $AlertFQDN
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertGroup: " + $AlertGroup
Add-content $Logfile -value $Logstring

$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
$Logstring = $DateTime + " AlertPriority: " + $AlertPriority
Add-content $Logfile -value $Logstring

if($AlertHost -eq 'Onbekend')
{
	$DateTime = Get-Date -Uformat "%y-%m-%d %H:%M:%S" 
	$Logstring = $DateTime + " Server is onbekend: " + $Onbekend
	Add-content $Logfile -value $Logstring
}
	
$LogString =  "Servername: " 	+ $ServerName + " | "
$LogString += "AlertName: " 	+ $AlertName + " | "
$LogString += "AlertSatus: " 	+ $AlertSatus + " | "
$LogString += "AlertSensor: " 	+ $AlertSensor + " | "
$LogString += "AlertMessage: " 	+ $AlertMessage + " | "
$LogString += "AlertHost: " 	+ $AlertHost + " | "
$LogString += "AlertFQDN: " 	+ $AlertFQDN

$regel += $Logstring

# Replaxce annoying characters
$regel = $regel -replace "%", "%25"
$regel = $regel -replace "<b>", ""
$regel = $regel -replace "</b>", ""
$regel = $regel -replace "<br/>", ""
$regel = $regel -replace "\n", ""

# Write log file
$regel | Out-File -filepath $Logfile -append

# Open Telegram API URL
$page = (New-Object System.Net.WebClient).DownloadString($regel)
