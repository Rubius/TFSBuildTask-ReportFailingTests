[cmdletbinding()]
param(
    [string]$vsTestVersion
    )

[Reflection.Assembly]::LoadWithPartialName("System.Xml.Linq") | Out-Null

Write-Host "Entering script ReportFailingTests.ps1"  

#uncomment to debug locally
#$workingDirectory = "d:\Work\vsts-tasks-master\"

foreach ($path in @($Env:COMMON_TESTRESULTSDIRECTORY, [System.IO.Path]::Combine($Env:BUILD_SOURCESDIRECTORY, "TestResults"))) {
    $trxFiles = [System.IO.Directory]::GetFiles($path, "*.trx")
    Write-Host "Checking: $path"

    if ($trxFiles.Length -gt 0) {
        break;
    }
}

if ($trxFiles.Length -gt 0) 
{
	$trx = $trxFiles[0]
	Write-Host "Parsing trx $trx"  	

	$doc = [System.Xml.Linq.XDocument]::Load($trx)
	
	$result = $doc.Root.Elements() | where {$_.Name.LocalName -eq "Results" } | select -First 1
	$tests = $result.Elements() | where {$_.Name.LocalName -eq "UnitTestResult" } 
	$failedTests = $tests | where {$_.Attribute("outcome").Value -eq "Failed"} 

	#limit to 10, because otherwise errors are not included in the emailed log
        foreach ($test in $failedTests | select -First 10) 
	{
		$error = "##vso[task.logissue type=error;]" + $test.Attribute("testName").Value.Trim()
		Write-Host $error
	}
} else {
    Write-Host "No test results (*.trx) files found"
}
 
Write-Host "Leaving script ReportFailingTests.ps1"