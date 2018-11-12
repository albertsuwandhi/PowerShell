#--Albert Suwandhi--
#--Export all users of security groups listed in a text file

$groups = Get-Content D:\groups.txt

$list= foreach ( $group in $groups) { 
#List all group members (Enabled Account only)
#Get-ADGroupMember $group|get-aduser| Where {$_.Enabled -eq $True}|Select-Object $group,Name,Enabled| Format-Table

#Uncomment below line to list all group members (Enabled and Disabled)
Get-ADGroupMember $group|get-aduser|Select-Object $group,Name,Enabled| Format-Table
}
$list | Out-File D:\GroupMember.txt
