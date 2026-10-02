# Active Directory Administration — Home Lab

A hands-on Active Directory home lab demonstrating domain controller deployment, DNS-based domain connectivity, OU design, domain-joined client administration, and PowerShell-based user provisioning.

Built with Oracle VirtualBox, Windows Server, and a Windows client.

## 💡 Background & Motivation

Having provided frontline Active Directory support in an enterprise environment, I built this lab to strengthen my understanding of the infrastructure behind day-to-day identity and access administration.

The lab focuses on practical administration tasks: deploying AD DS, designing an OU structure, provisioning users in bulk, joining a Windows client to the domain, and validating authentication and DNS connectivity.

---

## 📑 Contents

- [Objective](#-objective)
- [Lab Architecture](#-lab-architecture)
- [Prerequisites](#-prerequisites)
- [Lab Steps](#-lab-steps)
- [Bulk User Provisioning](#-bulk-user-provisioning)
- [Validation & Testing](#-validation--testing)
- [Scripts](#-scripts)
- [Skills Demonstrated](#-skills-demonstrated)
- [Notes](#-notes)

---

## 🎯 Objective

Simulate a small enterprise Active Directory environment end-to-end:

1. Deploy a Windows Server domain controller.
2. Install and configure Active Directory Domain Services.
3. Create an OU structure for users.
4. Provision multiple user accounts with PowerShell.
5. Join a Windows client to the domain.
6. Validate DNS resolution, domain authentication, and first-logon password enforcement.

---

## 🏗 Lab Architecture

| Component | Role | Software |
|---|---|---|
| Host machine | Hypervisor | Oracle VirtualBox |
| VM 1 | Domain Controller | Windows Server + AD DS |
| VM 2 | Domain-joined client | Windows 10 |

```text
[ Host: Oracle VirtualBox ]
        |
        |-- VM 1: Windows Server
        |      └── Domain Controller
        |          └── Active Directory Domain Services
        |
        └-- VM 2: Windows Client
               └── Joined to the AD domain
```

The lab domain used in the original build is `mydomain.com`.

---

## ✅ Prerequisites

- [Oracle VirtualBox](https://www.virtualbox.org/)
- Windows Server evaluation ISO
- Windows 10 ISO
- 8 GB+ host RAM recommended when running both VMs
- Active Directory Domain Services PowerShell module

---

## 🪜 Lab Steps

### 1. Install & Configure Windows Server

Create the Windows Server VM in VirtualBox, install Windows Server, configure the server hostname, and assign a suitable static network configuration.

### 2. Deploy Active Directory Domain Services

Install the AD DS role and promote the server to a domain controller, creating the lab forest/domain.

### 3. Create the OU Structure

Create the `Employees` OU used by the provisioning script.

> The repository documents the OU structure that is actually used by the automation rather than claiming additional OUs that are not required by the script.

### 4. Bulk-Provision Users with PowerShell

Use [`New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) to import user names from [`data/users.csv`](data/users.csv) and create accounts in the target OU.

The script:

- Imports user data from CSV.
- Validates the CSV structure.
- Verifies that the target OU exists.
- Checks whether each SAM account name already exists.
- Prompts for a temporary password instead of storing one in the repository.
- Creates enabled accounts.
- Requires users to change the temporary password at first logon.
- Reports created and skipped accounts.

### 5. Join the Windows Client to the Domain

Configure the Windows client to use the domain controller for DNS, join it to the lab domain, and authenticate with a provisioned domain account.

### 6. Validate the Environment

The original lab validation included:

1. **User account verification:** Confirmed the provisioned accounts in Active Directory Users and Computers (`dsa.msc`).
2. **DNS and connectivity:** Used `ping` and `nslookup` against the lab domain from the Windows client.
3. **Domain authentication:** Logged into the client using a provisioned domain account.
4. **First-logon password change:** Confirmed that the initial password-change requirement was enforced.

---

## 📦 Bulk User Provisioning

### CSV format

The provisioning input uses a simple two-column structure:

```csv
FirstName,LastName
Example,User
Another,User
```

The included [`data/users.csv`](data/users.csv) contains sample lab users.

### Run the script

From PowerShell on the domain controller or an authorised management workstation:

```powershell
.\scripts\New-BulkADUsers.ps1 `
    -CsvPath .\data\users.csv `
    -DomainName mydomain.com `
    -TargetOU "OU=Employees,DC=mydomain,DC=com"
```

The script prompts for the temporary password at runtime. No password is stored in the repository.

---

## 📜 Scripts

| File | Purpose |
|---|---|
| [`scripts/New-BulkADUsers.ps1`](scripts/New-BulkADUsers.ps1) | Validates CSV input and bulk-creates AD user accounts in the target OU |
| [`data/users.csv`](data/users.csv) | Sample user provisioning data for the lab |

---

## 🧠 Skills Demonstrated

- Windows Server administration
- Active Directory Domain Services (AD DS)
- Active Directory Users and Computers
- Organizational Unit design
- DNS and domain connectivity
- Domain-joined Windows client administration
- PowerShell automation
- Bulk user provisioning
- User lifecycle administration
- Virtualisation with Oracle VirtualBox

---

## 📝 Notes

This repository represents a controlled home-lab environment. Domain names, user data, and infrastructure settings are intentionally simplified for demonstration and learning.

The provisioning script is designed for lab and controlled administrative environments. Production deployments should use an organisation's approved identity-management process, credential-management controls, naming standards, and delegated permissions.
