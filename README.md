# Active Directory Administration — Home Lab

A hands-on home lab project demonstrating core Active Directory administration skills: standing up a domain controller, structuring an organizational unit hierarchy, and provisioning users at scale with PowerShell.

Built in Oracle VirtualBox using Windows Server as a domain controller and a Windows client joined to the domain.

### 💡 Background & Motivation

Having provided frontline Active Directory support in an Enterprise environment, I built this lab to bridge the gap between day-to-day administration and foundational infrastructure engineering. Supporting existing AD environments
is essential, but building one from the ground up—from initial forest setup and OU architecture to automated PowerShell provisioning—provided a deeper, end-to-end understanding of how 
identity management, DNS, DHCP and domain trust boundaries interact under the hood.

---

## 📑 Contents

- [Objective](#-objective)
- [Lab Architecture](#-lab-architecture)
- [Prerequisites](#-prerequisites)
- [Steps](#-steps)
- [Images](#-Images)
- [Scripts](#-scripts)
- [Skills Demonstrated](#-skills-demonstrated)

---

## 🎯 Objective

Simulate a small enterprise domain environment end-to-end: deploy a domain controller, design an OU structure and bulk-provision user accounts with PowerShell — the same fundamentals used to onboard employees in a production Active Directory environment.

## 🏗 Lab Architecture

| Component | Role | Software |
|---|---|---|
| Host machine | Hypervisor | Oracle VirtualBox |
| VM 1 | Domain Controller | Windows Server (AD DS) |
| VM 2 | Domain-joined client | Windows 10 |

```
[ Host: Oracle VirtualBox ]
        |
        |-- VM 1: Windows Server  --> Domain Controller (AD DS)
        |                              Domain: mydomain.com
        |
        |-- VM 2: Windows Client  --> Joined to mydomain.com, logs in as a
                                       domain user created via PowerShell
```

## ✅ Prerequisites

- [Oracle VirtualBox](https://www.virtualbox.org/)
- Windows Server ISO (evaluation edition)
- Windows 10 ISO
- 8GB+ RAM recommended on the host to run both VMs comfortably


## 🪜 Steps

### 1. Installed & Configured the Windows Server VM
Create the VM in VirtualBox, install Windows Server, assign a static IP and set the machine name.

### 2. Promoted to Domain Controller (AD DS)
Install the Active Directory Domain Services role and promote the server to a domain controller, creating a new forest.

### 3. Designed the OU Structure
Create an organizational unit hierarchy to reflect a small company structure (`Employees`, `IT`, `Finance`), setting up the containers users will be provisioned into.

### 4. Bulk-Created Users with PowerShell
Use the [`New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) script to provision multiple user accounts from a CSV file in a single run — the same approach used for onboarding batches of employees.

### 5. Joined the Client VM to the Domain
Configure the Windows client VM to use the domain controller for DNS, join it to `mydomain.com`, and log in as one of the newly created domain users.

### 6. Verify & Test
To confirm the Active Directory deployment and user provisioning were successful:

1. **User Account Verification:** Refreshed Active Directory Users and Computers (`dsa.msc`) and verified all 18 accounts were present in `OU=Employees,DC=mydomain,DC=com`.
2. **DNS & Network Connectivity:** Tested `ping mydomain.com` and `nslookup mydomain.com` from the Windows Client VM to verify DNS resolution via the Domain Controller.
3. **Domain Authentication:** Logged into the Windows Client VM using the newly provisioned account `lungelo.ngwane` with the temporary password `_P@ssword1`.
4. **First-Logon Password Reset:** Verified that Active Directory successfully enforced the password change prompt upon the initial logon attempt on the client machine.


## 📜 Scripts

| Script | Purpose |
|---|---|
| [`New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) | Bulk-creates AD user accounts, assigns them to an OU, sets a default password and forces a password change at first logon |


## 🧠 Skills Demonstrated

Windows Server Administration · Active Directory Domain Services · DNS · DHCP · Organizational Unit design · Group Policy fundamentals · PowerShell scripting · User lifecycle management · virtualization

