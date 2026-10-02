# 06 — Active Directory Troubleshooting

This guide provides a practical troubleshooting workflow based on the components demonstrated in the lab.

## Problem: Client cannot resolve the domain

### Checks

    ipconfig /all
    nslookup mydomain.com
    ping mydomain.com

### Investigate

- Is the client using the correct DNS server?
- Can the client reach the domain controller?
- Is DNS running on the server?
- Is the domain name correct?

## Problem: Client cannot join the domain

1. Confirm client network connectivity.
2. Confirm DNS points to the domain controller.
3. Verify nslookup for the lab domain.
4. Verify the domain controller is reachable.
5. Confirm the domain name is correct.
6. Retry the domain join after correcting the underlying issue.

## Problem: User cannot authenticate

1. Confirm the user exists in Active Directory.
2. Confirm the account is enabled.
3. Check the username.
4. Check whether the account is locked.
5. Confirm the client remains joined to the domain.
6. Confirm DNS and network connectivity.
7. Check whether a temporary password change is required.

Useful command:

    Get-ADUser -Identity username -Properties Enabled,LockedOut,PasswordExpired

## Problem: Bulk provisioning does not create users

Check the CSV path, required columns, target OU, existing accounts, permissions, and availability of the Active Directory PowerShell module.

## Troubleshooting principle

Work from the bottom up:

    Network
      ↓
    DNS
      ↓
    Domain controller reachability
      ↓
    Active Directory object
      ↓
    Account state
      ↓
    Authentication

This helps isolate whether a failure is caused by connectivity, directory configuration, account state, or authentication.
