# Network Namespace

An example of creating a simple network namespace connected
to the host via a veth pair.

![Diagram](./diagram.jpg)

Create the VM:

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

SSH to the VM and run the setup script to create the network namespace and the veth pair: 

```
vagrant ssh
./setup.sh
```

-or-

```
$ multipass exec meticulous-hairtail -- bash
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@meticulous-hairtail:~$ ./setup.sh
```

To test the connectivity between the node and the namespace, run the following:

```
./test.sh
```

For an example of running a process inside of the network namespace, run the following:

```
sudo ip netns exec con python3 -m http.server 8000 &
```

This will run the Python simple HTTP file server. From the default network namespace,
it can be called as follows:

```
curl 172.16.0.1:8000
```

To kill the python file server process:

```
sudo pkill python3
```

To teardown the network:

```
./teardown.sh
```

To test the entire flow, i.e. setup - run the tests - teardown, from your machine, run the following:

```
make
```
