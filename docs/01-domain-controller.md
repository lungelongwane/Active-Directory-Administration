# 01 — Domain Controller Setup

## Purpose

This guide documents the domain controller portion of the Active Directory home lab.

## Lab role

The Windows Server VM acts as the domain controller and provides Active Directory Domain Services (AD DS) for the lab domain.

## Configuration workflow

1. Create a Windows Server VM in Oracle VirtualBox.
2. Install Windows Server.
3. Configure the server name and static network settings.
4. Install the Active Directory Domain Services role.
5. Promote the server to a domain controller.
6. Create the lab domain and forest.
7. Verify that Active Directory management tools are available.

## Validation

The lab was validated by confirming the domain controller was providing the Active Directory environment, resolving the lab domain from the Windows client, joining the client to the domain, and authenticating with a provisioned domain account.

## Related tools

- Server Manager
- Active Directory Users and Computers (dsa.msc)
- PowerShell
- nslookup
- ping

> Lab note: The domain used in this project is mydomain.com. It is a local lab domain.
