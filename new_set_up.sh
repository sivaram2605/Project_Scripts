#!/bin/bash
/sbin/ip li add dummy_lo type dummy
echo "#!/bin/sh -e" > /etc/rc.local
echo "/sbin/ip li add dummy_lo type dummy" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
echo "auto dummy_lo" >> /etc/network/interfaces
echo "iface dummy_lo inet static" >> /etc/network/interfaces
vi /tmp/conf_1
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "network 1.1.1.0" >> /etc/network/interfaces
echo "gateway 1.1.1.1" >> /etc/network/interfaces
vi /tmp/conf_1


