#--Albert Suwandhi--
#--Export all users of security groups found under specific OU.

$TXT_Path = Read-Host -Prompt 'Input the exported text file location (Ex: D:\GroupMember.txt) '
$OU_Input = Read-Host -Prompt 'Input the OU name under DC=ds,DC=smart-tbk,DC=com ' 
# Please Change Below DC Parameters 
$OU = "OU=$OU_Input,DC=country,DC=domain,DC=com"
$Groups =  Get-ADGroup -Filter * -SearchBase $OU
Write-Host Found $Groups.Count Security Groups under $OU

#List the Security Groups
<#
foreach ($group in $Groups.name){
Write-Host $group
}
#>

$list= foreach ($group in $Groups.name) { 
Try{
#List all group members (Enabled Account only)
#Get-ADGroupMember -Identity $group|get-aduser| Where {$_.Enabled -eq $True}|Select-Object $group,Name,Enabled| Format-Table

#Uncomment below line to list all group members (Enabled and Disabled)
Get-ADGroupMember -Identity $group|get-aduser|Select-Object $group,Name,Enabled| Format-Table
Write-Host Listing the members of $group completed!
}
Catch{
$ErrorMessage = $_.Exception.Message
Write-Host Error occured : $ErrorMessage
Break
}
}
$list | Out-File $TXT_Path
Write-Host COMPLETED!! Please check $TXT_Path
