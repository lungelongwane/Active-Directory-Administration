# Active Directory Administration — Home Lab

A hands-on home lab project demonstrating core Active Directory administration skills: standing up a domain controller, structuring an organizational unit hierarchy, and provisioning users at scale with PowerShell.

Built in Oracle VirtualBox using Windows Server as a domain controller and a Windows client joined to the domain.

---

## 📑 Contents

- [Objective](#-objective)
- [Lab Architecture](#-lab-architecture)
- [Prerequisites](#-prerequisites)
- [Steps](#-steps)
- [Scripts](#-scripts)
- [Skills Demonstrated](#-skills-demonstrated)
- [Reference](#-reference)

---

## 🎯 Objective

Simulate a small enterprise domain environment end-to-end: deploy a domain controller, design an OU structure, and bulk-provision user accounts with PowerShell — the same fundamentals used to onboard employees in a production Active Directory environment.

## 🏗 Lab Architecture

| Component | Role | Software |
|---|---|---|
| Host machine | Hypervisor | Oracle VirtualBox |
| VM 1 | Domain Controller | Windows Server (AD DS, DNS) |
| VM 2 | Domain-joined client | Windows 10/11 |

```
[ Host: Oracle VirtualBox ]
        |
        |-- VM 1: Windows Server  --> Domain Controller (AD DS + DNS)
        |                              Domain: corp.local
        |
        |-- VM 2: Windows Client  --> Joined to corp.local, logs in as a
                                       domain user created via PowerShell
```

## ✅ Prerequisites

- [Oracle VirtualBox](https://www.virtualbox.org/)
- Windows Server ISO (evaluation edition)
- Windows 10/11 ISO
- 8GB+ RAM recommended on the host to run both VMs comfortably

## 🪜 Steps

### 1. Install & Configure the Windows Server VM
Create the VM in VirtualBox, install Windows Server, assign a static IP, and set the machine name.

*Screenshot: [`screenshots/01-server-install.png`](screenshots/) — VM creation and initial server setup*

### 2. Promote to Domain Controller (AD DS)
Install the Active Directory Domain Services role and promote the server to a domain controller, creating a new forest (`corp.local`).

*Screenshot: [`screenshots/02-adds-promotion.png`](screenshots/) — AD DS installation and promotion wizard*

### 3. Design the OU Structure
Create an organizational unit hierarchy to reflect a small company structure (e.g. `Employees`, `IT`, `Finance`), setting up the containers users will be provisioned into.

*Screenshot: [`screenshots/03-ou-structure.png`](screenshots/) — OU hierarchy in Active Directory Users and Computers*

### 4. Bulk-Create Users with PowerShell
Use the [`New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) script to provision multiple user accounts from a CSV file in a single run — the same approach used for onboarding batches of employees.

*Screenshot: [`screenshots/04-bulk-users.png`](screenshots/) — script output and resulting accounts in AD*

### 5. Join the Client VM to the Domain
Configure the Windows client VM to use the domain controller for DNS, join it to `corp.local`, and log in as one of the newly created domain users.

*Screenshot: [`screenshots/05-domain-join.png`](screenshots/) — successful domain join and login*

### 6. Verify & Test
Confirm group policy application, name resolution, and that the provisioned users can authenticate and access the domain as expected.

*Screenshot: [`screenshots/06-verification.png`](screenshots/) — verification steps*

## 📜 Scripts

| Script | Purpose |
|---|---|
| [`New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) | Bulk-creates AD user accounts from a CSV file, assigns them to an OU, sets a default password, and forces a password change at first logon |
| [`Users.csv`](scripts/Users.csv) | Sample input data for the bulk-creation script |

## 🧠 Skills Demonstrated

Windows Server · Active Directory Domain Services · DNS · Organizational Unit design · Group Policy fundamentals · PowerShell scripting · User lifecycle management · VirtualBox virtualization

## 📚 Reference

Lab based on the general approach covered in ["How to Setup a Basic Home Lab Running Active Directory (Oracle VirtualBox) | Add Users w/PowerShell"](https://www.youtube.com/results?search_query=how+to+setup+a+basic+home+lab+running+active+directory+oracle+virtualbox+add+users+w+powershell), adapted and documented in my own words as part of my IT portfolio.
