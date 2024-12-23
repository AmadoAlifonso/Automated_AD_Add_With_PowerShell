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
Write-Host "Your full name is: $fullName"

#Create User AD account
New-ADUser -Name $fullName -GivenName $fName -Initials $mInital -Surname $lName -DisplayName $fullname -UserPrincipalName $uName -AccountPassword (ConvertTo-SecureString Def@ultUserP@ssw0rd -AsPlainText -Force) -SamAccountName $uName

$pause = Read-Host "Anything else?"
