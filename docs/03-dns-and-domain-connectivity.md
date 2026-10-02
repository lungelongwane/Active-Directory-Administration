# 03 — DNS & Domain Connectivity

## Why DNS matters

Active Directory depends heavily on DNS for locating domain services. A domain-joined Windows client therefore needs to resolve the Active Directory domain and required records.

## Lab workflow

The Windows client was configured to use the domain controller for DNS and was then joined to the lab domain.

## Validation commands

    nslookup mydomain.com

This checks whether the client can resolve the lab domain through DNS.

    ping mydomain.com

This provides a basic connectivity check. A successful ping alone does not prove that Active Directory is functioning.

## Troubleshooting sequence

1. Check the client's IP configuration.
2. Confirm the DNS server points to the appropriate domain controller.
3. Run nslookup against the lab domain.
4. Check connectivity to the domain controller.
5. Confirm DNS and AD DS services are running on the server.
6. Retry the domain operation after correcting the network or DNS issue.

## Important distinction

DNS resolution and network connectivity are prerequisites for many domain operations, but they are not by themselves proof of successful domain authentication.
