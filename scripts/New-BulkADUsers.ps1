<#
    New-BulkADUsers.ps1

    Bulk-creates Active Directory user accounts.
    Run on the domain controller (or any machine with the ActiveDirectory
    module) as a user with rights to create accounts in the target OU.

    Usage:
        On your Domain Controller VM, click the Start menu, search for PowerShell, right-click Windows PowerShell and select Run as administrator.
        Copy the PowerShell script, paste it directly into the console window and press Enter.
#>

Import-Module ActiveDirectory

# Target path set directly to your Employees OU
$TargetOU = "OU=Employees,DC=mydomain,DC=com"
$DefaultPassword = ConvertTo-SecureString "_P@ssword1" -AsPlainText -Force

$UserList = @(
    "Lungelo Ngwane",
    "Noluthando Ngwane",
    "Langelihle Nxumalo",
    "Amahle Nxumalo",
    "Lwandile Dlamini",
    "Bongiwe Ngcobo",
    "Njabulo Ngwenya",
    "Ntuthuko Madondo",
    "Malusi Sabela",
    "Sanele Dlamini",
    "Sipho Ngwenya",
    "Sipho Lacage",
    "Nondumiso Mtshali",
    "Zinhle Masuku",
    "Anele Manchi",
    "Njabulo Ngcobo",
    "Sambulo Buthelezi",
    "Sphamandla Mazibuko"
)

foreach ($FullName in $UserList) {
    $Parts = $FullName.Trim() -split "\s+"
    $FirstName = $Parts[0]
    $LastName  = $Parts[1]

    $SamAccountName = "$FirstName.$LastName".ToLower()
    $UserPrincipalName = "$SamAccountName@mydomain.com"

    if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'") {
        Write-Host "User '$SamAccountName' already exists. Skipping..." -ForegroundColor Yellow
    } else {
        New-ADUser `
            -Name $FullName `
            -GivenName $FirstName `
            -Surname $LastName `
            -DisplayName $FullName `
            -SamAccountName $SamAccountName `
            -UserPrincipalName $UserPrincipalName `
            -AccountPassword $DefaultPassword `
            -ChangePasswordAtLogon $true `
            -Enabled $true `
            -Path $TargetOU

        Write-Host "Successfully created user: $FullName ($SamAccountName)" -ForegroundColor Green
    }
}


