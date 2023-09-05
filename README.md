# Active Directory Home Lab

## Project Overview

**Active Directory** stores information about objects on the network and makes this information easily accessible for administrators and users. It uses structured data store as the basis for a logical, hierarchical organization of directory information.

**Active Directory Domain Service** stores information about user accounts and allows authorized users on the same network to access this information.

This home lab project aims to help us to get more familiar with Microsoft Active Directory Domain Services (AD DS). We will be setting up a virtual network with two virtual machines within the network: one hosting the AD DS, and the other will be the designated client pc connecting to it.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/active-directory_0.jpg)
<br>
<br>

## Project Architecture

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Active%20Directory%20Project.drawio.jpg)
<br>
<br>

What we will be doing:

1. Create a Windows Server 2019 VirtualBox VM with two Network Interface Adaptors
   
   1. One NIC will be external facing and provide Network Address Translation (NAT)
   
   2. One NIC will be internal facing and provide network connectivity to the client computers on the internal network

2. Install and configure Active Directory Domain Service

3. Install and configure Remote Access and its subsidiary routing function.

4. Install and configure DHCP server

5. Create an administrator Organizational Unit (OU) and create a new user with Domain Admins access

6. Create an AD User OU and create 400 users using PowerShell script

7. Create a Windows 10 client VM connected to the internal network

8. Use one of credentials created on the AD server to log on to the domain network.
<br>

## Project Process

The PowerShell script and generated name text file used in this project are included in this repository. To use the PowerShell script, you will need to change the file paths to match that of your own.

[Download link to Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads)

[Download link to Windows Server 2019 ISO image](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019))

[Download link to Windows 10 Pro ISO image](https://www.microsoft.com/en-us/software-download/windows10ISO))

<br>

### Oracle VirtualBox

To start, we will need to install VirtualBox and VirtualBox Extension Pack. 

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/virtualBox-download.png)
<br>
<br>

### Install Windows Server 2019

Start the VirtualBox and create a new VM for Windows Server 2019

- Create one NIC adapter for External network

- Create one NIC adapter for Internal network

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows%20Server%202019%20Download.png)

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20VirtualBox%20Setting.gif)
<br>
<br>

### Install VirtualBox Guest Additions

Once we've initialized Windows Server 2019. We need to install VirtualBox Guest Additions. This will allow a much smoother user experience. Without it, you will find a lot delay in your input timing and unable to resize the VirtualBox window.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20Guest%20Addition%20Installation.gif)
<br>
<br>

### Configure Network Adapters

Before we install Active Directory, we need to first configure our network adapters according to our architecture diagram.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20NIC%20Setting.gif)
<br>
<br>

### Install and Configure AD DS

Once we've properly configured our network adapters, we can move on to install AD DS for our VM.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20ADDS%20Installation.gif)
<br>
<br>

### Install and Configure Remote Access and Routing Module

Next, we need to install and configure the Remote Access module and configure routing for proper network address translation (NAT).

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20RAS%20NAT%20Installation.gif)
<br>
<br>

### Install and Configure DHCP

Next, let's set up the DHCP server so we can assign IP addresses to connected client devices.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20DHCP%20Installation.gif)
<br>
<br>

### Create Domain Admin Account

Let's create a domain admin account so that we don't have to use the local administrator account to log into the server.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20Creating%20Domain%20Admin.gif)
<br>
<br>

### Create Directory User Accounts using PowerShell Script

To save ourselves time to have to create user accounts manually, we can use PowerShell script to do this for us. The PowerShell script is included in the repository.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/WindowsDC%20Creating%20AD%20Users.gif)
<br>
<br>

### Install and Configure Windows 10 VM

Now let's create a Windows 10 VM. Make sure you choose to install Windows 10 Pro or Enterprise edition for this VM. Windows Home Edition does not have the "Domain Join" capability. Make sure to set the NIC to use Internal network instead of the default NAT during the set up process.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-10/Windows%2010%20Pro%20ISO%20download%20Trick.gif)

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-10/Windows%2010%20Installation.gif)
<br>
<br>

### Verify Network Connectivity

Inside our newly created Windows 10 VM, let's make sure the network is working properly. Use `ipconfig` in the command prompt to display our network information. Here we can see that we have a proper IP address of `172.16.0.100` and our client VM is connected to the network gateway we've set up in the AD server `172.16.0.1`. We are able to send and receive echo pings and replies to our host domain (WinDC.io) as well as outside network (ie. google.com).

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-10/Windows%2010%20Network%20Testing.gif)
<br>
<br>

### Configure the Client PC to join the AD DS domain

Now that we have verified the network connectivity, we can use one of the credentials we've created using PowerShell script to join our Domain Service (WinDC.io).

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-10/Windows%2010%20Domain%20Join.gif)
<br>
<br>

### Verify Successful Client PC access to AD DS

Lastly, let's go into the DHCP server to verify that we have successfully leased an IP address from our pool of IP addresses `172.16.0.100 - 200`. Let's also make sure that the client PC is successfully joined our domain service.

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Windows-DC/Windows%20DC%20Verify%20Domain%20Join.gif)
<br>
<br>

### Final Result

Now we have successfully set up a Home Lab running Active Directory Domain Service in a private network. Nice!

<br>

![](https://github.com/thesimonjiang/Active-Directory-Homelab-Project/blob/0bd6758679dcd9f48ad6232210747fd918cb3950/Graphics/Active%20Directory%20Final%20Result.png)
