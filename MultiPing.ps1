Function Start-MultiPing
{
<#
   
.DESCRIPTION
   MultiPing will generate a html based report to help troubleshoot network problems.
   You can set multiple target to ping. Script will report a html based ping chart report 
   that can help you to troubleshoot latency related issues.
       
.PARAMETER FirstAddress
   Define first remote IP to ping. Default value: 8.8.8.8

.PARAMETER SecondAddress
   Define second remote IP to ping. Default value: 192.168.0.1

.PARAMETER ThirdAddress
   Define third remote IP to ping. Default value: irishtimes.com

.PARAMETER FourthAddress
   Define fourth remote IP to ping. Default value: www.bbc.com
   
.PARAMETER ReportName
   Define the name of the report that will be generated. Default value: PingStatistics.HhmlChart.html

.EXAMPLE
    Start-Multiping

.EXAMPLE
    Start-MultiPing -FirstAddress 4.4.4.4

.EXAMPLE    
    Start-MultiPing -FirstAddress 4.4.4.4 -ReportName Test.Report

#>

    param([string]$FirstAddress="8.8.8.8",[string]$SecondAddress="192.168.0.1",[string]$ThirdAddress="irishtimes.com",[string]$FourthAddress="www.bbc.com", [string]$ReportName="PingStatistics.HhmlChart.html")

    if(-not $ReportName.EndsWith(".html"))
    {
        $ReportName=$ReportName+".html"
    }

    #Define background process for multiple simultaneous ping
    $BGPing={
        param($TargetAddress, $Path)
        Clear-Host
        ping $TargetAddress -t | DateEcho | Tee-Object -FilePath $path
    }

    try{
        clear-host
        #get server ip from user
        #$Customserver =Read-host "Please specify IP address of target server"
        #get work path
        Write-Host "-------------------------------------------------" -ForegroundColor Yellow
        write-host "You can stop script any time with pressing CTRL+C" -ForegroundColor Yellow
        Write-Host "-------------------------------------------------" -ForegroundColor Yellow
        
        $ansver=read-host ("`nDo you want to save log to desktop?[Y/N]")
        if($ansver.ToLower() -eq "y")
        {
            cd $env:userprofile\desktop
        }
        $CurrentLocation=Get-Location
        #Start background processes
        $BGJobPingToGoogle=Start-Job $BGPing -ArgumentList $FirstAddress, $($CurrentLocation.Path+"\PingOutput.$FirstAddress.log")
        $BGJobPingToGateway=Start-Job $BGPing -ArgumentList $SecondAddress, $($CurrentLocation.Path+"\PingOutput.$SecondAddress.log")
        $BGJobPingToMetIe=Start-Job $BGPing -ArgumentList $ThirdAddress, $($CurrentLocation.Path+"\PingOutput.$ThirdAddress.log")
        $BGJobPingToCustomserver=Start-Job $BGPing -ArgumentList $FourthAddress, $($CurrentLocation.Path+"\PingOutput.$FourthAddress.log")
        #Monitor state in every second
        do
        {
            $BGJobPingToGoogle | Receive-Job
            $BGJobPingToCustomserver | Receive-Job
                    sleep 1
        }while($true)
    }
    finally
    {
       
        #Clean up background processes
    
        Write-host "`n----------------------------------Script will stop within 15 min----------------------------------"
        #kill all subshells
        Get-Job | Stop-Job
        Get-Job | Remove-Job
        Write-host "Multi Ping script has been stopped."
        Write-host "Ping file analyzing running"
        Write-host "This can take up to 15 min depend on length of ping log" -ForegroundColor Yellow


        #Collect all ping log files
        $ListOFFiles = ls | where name -Like *PingOutput* | where LastWriteTime -gt $((get-date).AddHours(-1))

        #Generate html div that will mark the location of the graphs
        $divTarget=Generate-Target $ListOFFiles 

        #Generate data from ping logs
        $Data=Generate-DataWithDefinition $ListOFFiles -LogType WindowsWithDate

    
        $Initiator=Generate-HTMLChartInitiator $ListOFFiles 
        $GeneratedHtml=Generate-HtmlChart -DataLines $Data -TargetDiv $divTarget -GraphInitiater $Initiator
        $GeneratedHtml | Out-File $ReportName -Encoding utf8

    
        Write-host "`n----------------------------------Summary generation completed------------------------------------"
    
        write-host "You can find logs in `n$($CurrentLocation.Path)\PingOutput.$FirstAddress.log`n$($CurrentLocation.Path)\PingOutput.$SecondAddress.log`n$($CurrentLocation.Path)\PingOutput.$ThirdAddress.log`n$($CurrentLocation.Path)\PingOutput.$FourthAddress.log`n`nAlso graph summary in:`n$($CurrentLocation.Path)\$ReportName"
    }
}