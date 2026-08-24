<#
    New-BulkADUsers.ps1

    Bulk-creates Active Directory user accounts from a CSV file.
    Run on the domain controller (or any machine with the ActiveDirectory
    module) as a user with rights to create accounts in the target OU.

    Usage:
        .\New-BulkADUsers.ps1 -CsvPath .\Users.csv -DefaultPassword 'ChangeMe123!' -OU 'OU=Employees,DC=corp,DC=local'
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$CsvPath,

    [Parameter(Mandatory = $true)]
    [string]$DefaultPassword,

    [Parameter(Mandatory = $true)]
    [string]$OU
)

Import-Module ActiveDirectory

$SecurePassword = ConvertTo-SecureString $DefaultPassword -AsPlainText -Force
$Users = Import-Csv -Path $CsvPath

foreach ($User in $Users) {
    $SamAccountName    = ("$($User.FirstName.Substring(0,1))$($User.LastName)").ToLower()
    $UserPrincipalName = "$SamAccountName@corp.local"
    $DisplayName       = "$($User.FirstName) $($User.LastName)"

    if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue) {
        Write-Warning "Skipped $DisplayName - account '$SamAccountName' already exists"
        continue
    }

    New-ADUser `
        -Name $DisplayName `
        -GivenName $User.FirstName `
        -Surname $User.LastName `
        -SamAccountName $SamAccountName `
        -UserPrincipalName $UserPrincipalName `
        -Path $OU `
        -Department $User.Department `
        -AccountPassword $SecurePassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    Write-Output "Created $DisplayName ($SamAccountName) in $OU"
}

Write-Output "Done. $($Users.Count) accounts processed."
