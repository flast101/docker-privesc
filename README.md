
# Abusing Docker Weak Configuration

Exploring a classic...

### Containers

Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (container images are typically tens of MBs in size), can handle more applications and require fewer VMs and Operating systems. 

### VM



# Abusing Docker Weak Configuration

Exploring a classic...


## Quick Definition

![18d65e7fbb7b600ad02fc7cdc8b0a3df.png](:/0b1177fc74ae45aba34d495bb059a129)

Containers

Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. 

VM

Virtual machines (VMs) are an abstraction of physical hardware turning one server into many servers. The hypervisor allows multiple VMs to run on a single machine. Each VM includes a full copy of an operating system, the application, necessary binaries and libraries.

## 1- Possible Vulnerability - Real Facts

- By default, any machine container is run with root privileges (ie. you have root privileges inside the container).
- Containters data changes are not persistent. We usually mount a host directory to access persistent data from the container.

Vuln : What happens if you mount host root in the container ?

## 2- GTFBins

https://gtfobins.github.io/gtfobins/docker/

... with comments

## 3- Exploiting The Vulnerability


## 4- Bash Script


## 5- Mitigation
