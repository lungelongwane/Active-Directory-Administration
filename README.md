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
| VM 2 | Domain-joined client | Windows 10/11 |

```
[ Host: Oracle VirtualBox ]
        |
        |-- VM 1: Windows Server  --> Domain Controller (AD DS + DNS)
        |                              Domain: mydomain.com
        |
        |-- VM 2: Windows Client  --> Joined to corp.local, logs in as a
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
Confirm group policy application, name resolution, and that the provisioned users can authenticate and access the domain as expected.


## 📜 Scripts

| Script | Purpose |
|---|---|
| [`New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) | Bulk-creates AD user accounts, assigns them to an OU, sets a default password and forces a password change at first logon |


## 🧠 Skills Demonstrated

Windows Server Administration · Active Directory Domain Services · DNS · DHCP · Organizational Unit design · Group Policy fundamentals · PowerShell scripting · User lifecycle management · virtualization

