# Overlay Network

An example of creating multiple L2 networks, one on each of the nodes. Each network contains
2 network namespaces (containers), connected via a bridge, and have different subnets. The 
containers are connected via an overlay network implemented with a tuntap device and a UDP
cnnection between hosts.

![Diagram](./diagram.jpg)

Create the 2 VMs (container-networking-1 and container-networking-2):

```
vagrant up
```

-or-

```
$ multipass launch
Launched: meticulous-hairtail

$ multipass info meticulous-hairtail
 Name:           meticulous-hairtail
 State:          Running
 IPv4:           192.168.64.2
 Release:        Ubuntu 22.04.3 LTS
 Image hash:     0b565888914c (Ubuntu 22.04 LTS)
 CPU(s):         1
 Load:           0.20 0.09 0.03
 Disk usage:     1.4GiB out of 4.8GiB
 Memory usage:   141.5MiB out of 962.4MiB
 Mounts:         --
```

SSH to each node (VM) in turn, and run the setup script to create the network namespaces connected via a bridge: 

```
vagrant ssh container-networking-[12]
./setup.sh
```

-or-

```
$ multipass exec meticulous-hairtail -- bash
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@meticulous-hairtail:~$ ./setup.sh
```

To test the connectivity between the containers within and node, and across nodes, run the following:

```
./test.sh
```

To teardown the network:

```
./teardown.sh
```

To test the entire flow, i.e. setup - run the tests - teardown, from your machine, run the following:

```
make
```
