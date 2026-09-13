
### DC Setup Completed
<img width="1920" height="1031" alt="image" src="https://github.com/user-attachments/assets/283d511f-d520-43b8-b06a-41a863bce6b1" />
</br>

### Added Roles and Features
<img width="1902" height="1012" alt="image" src="https://github.com/user-attachments/assets/a11457e7-ce07-4948-a193-defca1a5eb65" />
</br>

### Proof the AD works
<img width="1915" height="1005" alt="image" src="https://github.com/user-attachments/assets/1178c6ff-9132-4c42-9446-5d75dafd40a5" />
</br>

### Network Configurations
<p> ipconfig</br>
Ran this to confirm the VM's IP address, subnet mask, and default gateway were correctly assigned so it could communicate on the network.
</p>
<img width="1026" height="917" alt="image" src="https://github.com/user-attachments/assets/5d825a92-8742-4d95-8277-f4799e6cb019" />
</br></br>

<p> 
Resolve-DnsName mydomain.local</br>
nslookup mydomain.local</br>
Ran these to verify the VM could resolve the domain name to the domain controller's IP address, since DNS resolution has to work before a domain join can succeed.
</p>
<img width="887" height="303" alt="image" src="https://github.com/user-attachments/assets/330a9994-ea92-41c6-8830-d2f5f59f9d43" />
</br></br>

<p>
Test-Connection -ComputerName mydomain.com -Count 4</br> 
Test-NetConnection -ComputerName mydomain.com -Port 389</br>
Ran these to confirm the VM could reach the domain controller over the network and that the LDAP port (389) used for Active Directory communication was open and responding.
</p>
<img width="850" height="563" alt="image" src="https://github.com/user-attachments/assets/5602c1cb-d681-402b-87ef-98b22db02ec1" />
</br></br>

<p>
Get-NetAdapter</br>
Get-NetIPConfiguration</br>
Ran these to check that the VM's network adapter was active and correctly configured with the right IP settings before attempting the domain join.
</p>
<img width="846" height="818" alt="image" src="https://github.com/user-attachments/assets/935449ac-bd28-4b7e-9322-39168bca5189" />


