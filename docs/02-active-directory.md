# 02 — Active Directory Administration

## Core concepts used in this lab

### Domain

A domain provides the identity and administration boundary for the lab environment.

### Domain Controller

The domain controller hosts Active Directory Domain Services and handles domain authentication and directory services.

### Organizational Units

Organizational Units provide a way to organise and administer directory objects. This lab uses an Employees OU as the target for bulk user provisioning.

### User accounts

The lab creates accounts with a first name, last name, display name, SAM account name, User Principal Name, enabled status, temporary password, and first-logon password change requirement.

## Administration workflow

    User data
       ↓
    CSV validation
       ↓
    Check existing account
       ↓
    Create AD account
       ↓
    Place account in Employees OU
       ↓
    Require password change
       ↓
    Authenticate on domain-joined client

## Useful PowerShell commands

    Get-ADUser -Identity username

    Get-ADUser -Filter *

    Get-ADOrganizationalUnit -Filter 'Name -eq "Employees"'

    Get-ADUser -Identity username -Properties *

These commands are examples for administration and investigation. The repository's provisioning script is the primary automation demonstrated by this project.
