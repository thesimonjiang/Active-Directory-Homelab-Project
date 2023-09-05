# Active Directory User Creation PowerShell Script
# Made by Simon Jiang. https://github.com/thesimonjiang
# Original PowerShell Script from Josh Madakor: https://github.com/joshmadakor1

# To make this script to work on your own system: you need replace the "YOUR_FILE_PATH"
# with your own username text file's path.
# You can use "https://www.name-generator.org.uk" to generate your names

# Set the default password for all users. They will have the option to change it when they log on.
$PASSWORD_FOR_USERS = "Password123"

# Use the name list text file you've created.
$USER_FIRST_LAST_LIST = Get-Content Your_FILE_PATH

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
New-ADOrganizationalUnit -Name AD_USERS -ProtectedFromAccidentalDeletion $false

foreach ($n in $USER_FIRST_LAST_LIST) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor DarkGray -ForegroundColor Yellow
    
    New-ADUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=AD_USERS,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
}