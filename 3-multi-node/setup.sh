#!/bin/bash -e

. env.sh

echo "Creating the namespaces"
sudo ip netns add $CON1
sudo ip netns add $CON2

echo "Creating the veth pairs"
sudo ip link add veth10 type veth peer name veth11
sudo ip link add veth20 type veth peer name veth21

echo "Adding the veth pairs to the namespaces"
sudo ip link set veth11 netns $CON1
sudo ip link set veth21 netns $CON2

echo "Configuring the interfaces in the network namespaces with IP address"
sudo ip netns exec $CON1 ip addr add $IP1/24 dev veth11
sudo ip netns exec $CON2 ip addr add $IP2/24 dev veth21

echo "Enabling the interfaces inside the network namespaces"
sudo ip netns exec $CON1 ip link set dev veth11 up
sudo ip netns exec $CON2 ip link set dev veth21 up

echo "Creating the bridge"
sudo ip link add name $BRIF type bridge

echo "Adding the network namespaces interfaces to the bridge"
sudo ip link set dev veth10 master $BRIF
sudo ip link set dev veth20 master $BRIF

echo "Assigning the IP address to the bridge"
sudo ip addr add $BRIDGE_IP/24 dev $BRIF

echo "Enabling the bridge"
sudo ip link set dev $BRIF up

echo "Enabling the interfaces connected to the bridge"
sudo ip link set dev veth10 up
sudo ip link set dev veth20 up

echo "Setting the loopback interfaces in the network namespaces"
sudo ip netns exec $CON1 ip link set lo up
sudo ip netns exec $CON2 ip link set lo up

echo "Setting the default route in the network namespaces"
sudo ip netns exec $CON1 ip route add default via $BRIDGE_IP dev veth11
sudo ip netns exec $CON2 ip route add default via $BRIDGE_IP dev veth21

# ------------------- Step 3 Specific Setup --------------------- #

echo "Setting the route on the node to reach the network namespaces on the other node"
sudo ip route add $TO_BRIDGE_SUBNET via $TO_NODE_IP dev $BRDEV

echo "Enables IP forwarding on the node"
sudo sysctl -w net.ipv4.ip_forward=1
