<#
.SYNOPSIS
    Bulk-creates Active Directory user accounts from a CSV file.

.DESCRIPTION
    Creates enabled user accounts in the specified OU, assigns a temporary
    password, and requires a password change at first logon.

    Run on the domain controller, or on a management workstation with the
    ActiveDirectory PowerShell module and appropriate permissions.

.CSV FORMAT
    FirstName,LastName
    Lungelo,Ngwane
    Example,User

.EXAMPLE
    New-BulkADUsers.ps1 -CsvPath .\users.csv -DomainName mydomain.com -TargetOU "OU=Employees,DC=mydomain,DC=com"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$CsvPath,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$DomainName,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$TargetOU
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory

if (-not (Test-Path -LiteralPath $CsvPath -PathType Leaf)) {
    throw "CSV file not found: $CsvPath"
}

if (-not (Get-ADOrganizationalUnit -Identity $TargetOU -ErrorAction SilentlyContinue)) {
    throw "Target OU was not found: $TargetOU"
}

$Users = Import-Csv -LiteralPath $CsvPath

if (-not $Users) {
    throw "The CSV file contains no users."
}

$RequiredColumns = @("FirstName", "LastName")
$MissingColumns = $RequiredColumns | Where-Object {
    $_ -notin $Users[0].PSObject.Properties.Name
}

if ($MissingColumns) {
    throw "CSV is missing required column(s): $($MissingColumns -join ', ')"
}

$DefaultPassword = Read-Host "Enter the temporary password for the new accounts" -AsSecureString

$Created = 0
$Skipped = 0

foreach ($User in $Users) {
    $FirstName = $User.FirstName.Trim()
    $LastName  = $User.LastName.Trim()

    if ([string]::IsNullOrWhiteSpace($FirstName) -or [string]::IsNullOrWhiteSpace($LastName)) {
        Write-Warning "Skipping row with a missing first or last name."
        $Skipped++
        continue
    }

    $FullName = "$FirstName $LastName"
    $SamAccountName = ("{0}.{1}" -f $FirstName, $LastName).ToLowerInvariant()
    $UserPrincipalName = "$SamAccountName@$DomainName"

    $ExistingUser = Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue

    if ($ExistingUser) {
        Write-Host "User '$SamAccountName' already exists. Skipping..." -ForegroundColor Yellow
        $Skipped++
        continue
    }

    $NewUserParams = @{
        Name                  = $FullName
        GivenName             = $FirstName
        Surname               = $LastName
        DisplayName           = $FullName
        SamAccountName        = $SamAccountName
        UserPrincipalName     = $UserPrincipalName
        AccountPassword       = $DefaultPassword
        ChangePasswordAtLogon = $true
        Enabled               = $true
        Path                  = $TargetOU
    }

    New-ADUser @NewUserParams

    Write-Host "Created: $FullName ($SamAccountName)" -ForegroundColor Green
    $Created++
}

Write-Host ""
Write-Host "Provisioning complete. Created: $Created | Skipped: $Skipped" -ForegroundColor Cyan
