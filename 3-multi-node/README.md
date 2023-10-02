# Multi Node Network

An example of creating multiple L2 networks, one on each of the nodes. Each network contains
2 network namespaces (containers), connected via a bridge, and have different subnets. The 
containers are connected via static routing rules set on each of the nodes.

![Diagram](./diagram.jpg)

Create the 2 VMs (3-multi-node-1 and 3-multi-node-2):

```
vagrant up
```
-or-

Create the 2 VMs (multi-node-1 and multi-node-2):
```
$ multipass launch --cpus 2 --disk 5G --memory 1G --name "multi-node-1"
Launched: multi-node-1

$ multipass info multi-node-1
Name:           multi-node-1
State:          Running
IPv4:           192.168.64.2
Release:        Ubuntu 22.04.3 LTS
Image hash:     0b565888914c (Ubuntu 22.04 LTS)
CPU(s):         2
Load:           0.02 0.13 0.08
Disk usage:     1.4GiB out of 4.8GiB
Memory usage:   146.7MiB out of 962.3MiB
Mounts:         --


$ multipass launch --cpus 2 --disk 5G --memory 1G --name "multi-node-1"
Launched: multi-node-2

$ multipass info multi-node-2
Name:           multi-node-2
State:          Running
IPv4:           192.168.64.3
Release:        Ubuntu 22.04.3 LTS
Image hash:     0b565888914c (Ubuntu 22.04 LTS)
CPU(s):         2
Load:           0.08 0.10 0.06
Disk usage:     1.4GiB out of 4.8GiB
Memory usage:   144.8MiB out of 962.3MiB
Mounts:         --
```

SSH to each node (VM) in turn, and run the setup script to create the network namespaces connected via a bridge: 

```
vagrant ssh 3-multi-node-[12]
cd /vagrant
./setup.sh
```
-or-

Then to connect to them, for e.g.:
```
$ multipass exec multi-node-1 -- bash
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@multi-node-1:~$ ./setup.sh
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
