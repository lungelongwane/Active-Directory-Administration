# 05 — PowerShell Administration

## Why PowerShell is used

PowerShell makes repetitive Windows and Active Directory administration tasks scriptable and repeatable. In this lab it is used to demonstrate bulk user provisioning rather than creating every account manually.

## Active Directory module

The provisioning script imports the Active Directory module:

    Import-Module ActiveDirectory

## Commands demonstrated

| Command | Purpose |
|---|---|
| Import-Csv | Reads provisioning data |
| Get-ADUser | Checks whether an account exists |
| Get-ADOrganizationalUnit | Validates the target OU |
| New-ADUser | Creates the user account |
| Test-Path | Validates the CSV path |
| Read-Host -AsSecureString | Collects the temporary password without storing it in the script |

## Script design

The script uses mandatory parameters, input validation, strict mode, error handling, duplicate detection, counters for created and skipped users, and a parameter hashtable for New-ADUser.

## Administration principle

Automation should reduce repetitive work while validating inputs and reporting failures clearly.
