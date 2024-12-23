function Create-User
{
#Collect users first name
$fName = Read-Host "Enter First Name"

#Collect last name
$lname = Read-Host "Enter Last Name"

#Collect user middle name
$mName = Read-Host "Enter Middle Name"

#Confirm Users Name
Write-Host "Confirm that this is your full name: $fName $mName $lName"

#Get users first initial
$fInitial = $fName.Substring(0, 1)

#Get users middle initial
$mInitial = $mName.Substring(0, 1)

#Generate username
$uName = $lName + $fInitial + $mInitial

#Create full Name 
$fullName = "$fName $mInitial $lname"

Write-Host "your User will be: $uName"
Write-Host "Your full name is: $fName"

#Create User AD account
New-ADUser -Name $fullName -GivenName $fName -Initials $mInital -Surname $lName -DisplayName $fullName -UserPrincipalName $uName -AccountPassword (ConvertTo-SecureString Def@ultUserP@ssw0rd -AsPlainText -Force) -SamAccountName $uName -Enabled $true

$domainHost = Read-Host "Does $fName require Domain admin privileges?"
if($domainhost -eq "Yes")
{
    net group "Domain Admins" $uName /add /domain
}
 
$remoteHost = Read-Host "Does $fName require remote desktop user privileges?"
if($remoteHost -eq "Yes")
{
    net localgroup "Remote Desktop Users" $uName /add
}

$adminHost = Read-Host "does $fName require local Administrator privileges?"
if($adminHost -eq "Yes")
{
    net localgroup Administrators $uName /add
}
}


function Remove-User
{
    $uName=Read-Host "Please provide username for user that needs to be deleted"
    Remove-ADUser -Identity $uName
}


$Uprompt = Read-Host "Are we making or deleting a user? Enter Make or Delete"

if($Uprompt -eq "Make")
{
Create-User
} elseif($Uprompt -eq "Delete")
{
Remove-User
}

$pause = Read-Host "Anything else?"
