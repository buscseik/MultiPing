# MultiPing
   MultiPing will generate a html based report to help troubleshoot network problems.
   You can set multiple target to ping. Script will report a html based ping chart report 
   that can help you to troubleshoot latency related issues.

### Install dependencies
```
Install-Module UsefulTools
Install-Module Log2Chart
```

### Installation
```
Install-Module MultiPing
```
### Parameters
* FirstAddress: Define first remote IP to ping. Default value: 8.8.8.8
* SecondAddress: Define second remote IP to ping. Default value: 192.168.0.1
* ThirdAddress: Define third remote IP to ping. Default value: irishtimes.com
* FourthAddress: Define fourth remote IP to ping. Default value: www.bbc.com
* ReportName: Define the name of the report that will be generated. Default value: PingStatistics.HhmlChart.html

### Examples
```
    Start-Multiping
    Start-MultiPing -FirstAddress 4.4.4.4
    Start-MultiPing -FirstAddress 4.4.4.4 -ReportName Test.Report
```
