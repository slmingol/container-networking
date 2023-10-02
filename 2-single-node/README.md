# Single Node Network

An example of creating a single L2 network on one node, containing 
2 network namespaces (containers), connected via a bridge.

![Diagram](./diagram.jpg)

Create the VM (container-networking):

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

SSH to the node (VM) and run the setup script to create the network namespaces connected via bridge: 

```
vagrant ssh container-networking-[12]
cd /vagrant
./setup.sh
```

-or-

```
$ multipass exec meticulous-hairtail -- bash
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@meticulous-hairtail:~$ ./setup.sh
```

To test the connectivity between the containers within the node, run the following:

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
