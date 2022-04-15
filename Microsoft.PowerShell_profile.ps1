Set-Alias -Name "make" -Value "gnumake"

Register-ArgumentCompleter -CommandName "Start-VM" -ParameterName "Name" -ScriptBlock {
	param($commandName, $parameterName, $wordToComplete)
	Get-VM -name $wordToComplete* | Select-Object -ExpandProperty "Name"
}

Register-ArgumentCompleter -CommandName "ssh" -Native -ScriptBlock {
	param($wordToComplete)
	Get-Content "~/.ssh/config" `
	| Select-String -Pattern "^Host $wordToComplete" `
	| ForEach-Object { $_ -replace "host ", "" } `
	| Sort-Object -Unique
}
