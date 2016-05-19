[cmdletbinding()]
param(
    [string]$vsTestVersion
    )

[Reflection.Assembly]::LoadWithPartialName("System.Xml.Linq") | Out-Null

Write-Verbose "Entering script ReportFailingTests.ps1"  

#uncomment to debug locally
#$workingDirectory = "d:\Work\vsts-tasks-master\"
$testResultsDirectory = $Env:COMMON_TESTRESULTSDIRECTORY

$trxFiles = [System.IO.Directory]::GetFiles($testResultsDirectory, "*.trx")

if ($trxFiles.Length -gt 0) 
{
	$trx = $trxFiles[0]
	Write-Verbose "Parsing trx $trx"  	

	$doc = [System.Xml.Linq.XDocument]::Load($trx)
	
	$result = $doc.Root.Elements() | where {$_.Name.LocalName -eq "Results" } | select -First 1
	$tests = $result.Elements() | where {$_.Name.LocalName -eq "UnitTestResult" } 
	$failedTests = $tests | where {$_.Attribute("outcome").Value -eq "Failed"} 

	#limit to 10, because otherwise errors are not included in the emailed log
        foreach ($test in $failedTests | select -First 10) 
	{
		Write-Host "##vso[task.logissue type=error;]" $test.Attribute("testName").Value
	}
}
 
Write-Verbose "Leaving script ReportFailingTests.ps1"