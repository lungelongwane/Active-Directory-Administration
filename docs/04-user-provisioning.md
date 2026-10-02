# 04 — User Provisioning

## Overview

The repository includes a PowerShell automation workflow for provisioning multiple Active Directory users from CSV input.

Script: scripts/New-BulkADUsers.ps1

Input: data/users.csv

## CSV format

    FirstName,LastName
    Example,User
    Another,User

## What the script validates

- The CSV exists.
- The target OU exists.
- The CSV contains the required columns.
- Each row contains a first and last name.
- The SAM account name is not already in use.

## Account creation

For each valid user, the script creates an enabled account in the target OU and requires the user to change the temporary password at first logon.

The temporary password is entered interactively and is not stored in the repository.

## Running the automation

    .\scripts\New-BulkADUsers.ps1 -CsvPath .\data\users.csv -DomainName mydomain.com -TargetOU "OU=Employees,DC=mydomain,DC=com"

## Operational considerations

For production, account provisioning should follow the organisation's approved identity-management process, naming standards, delegated permissions, credential controls, and auditing requirements.

This script is designed as a controlled home-lab demonstration.
