Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PC4MRw001949
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 05:04:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PC4MmU001948
	for linux-mips-outgoing; Thu, 25 Jul 2002 05:04:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PC3pRw001933
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 05:03:51 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA374
          for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 05:04:55 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@oss.sgi.com>
Subject: O2 boot howto
Date: Thu, 25 Jul 2002 05:08:12 -0700
Message-ID: <011301c233d3$f353d9f0$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I wrote up a howto on how to boot the O2 (R10k) in my case via bootp from a
Linux server PC and mount an NFS root file system. I hope somebody can find
it useful. I had to gather the answers on how to do this from a couple of
guys and do a lot of reading..so maybe this will help the next guy out. :)

Steve
--
Linux/O2 HOWTO

Steven Seeger
sseeger@stellartec.com

July 24, 2002

This FAQ describes booting the SGI O2 over the network from a server PC
running dhcpd, and mounting an NFS root filesystem from that PC. This
document will be covered in two steps: the O2 setup, and the PC setup.

1. Copyright

Copyright (c) 2002 Steven Seeger.

Permission is granted to copy, distribute and/or modify this document under
the terms of the GNU Free Documentation License, Version 1.1 or any later
version published by the Free Software Foundation; with the Invariant
Sections being Copyright, with no Front-Cover Texts and with no Back-Cover
Texts.

A copy of the GNU Free Documentation License is available on the World Wide
Web at http://www.gnu.org/copyleft/fdl.html You can also obtain it by
writing to the

Free Software Foundation, Inc.
  59 Temple Place - Suite 330
  Boston, MA 02111-1307
  USA

2. Linux/MIPS net resources.

Please see http://oss.sgi.com/mips/mips-howto.html for information on
obtaining the latest Linux/MIPS kernel sources. Also contains anonymous CVS
and FTP info.

For information on building a serial cable, see
http://oss.sgi.com/mips/i2-howto.html.

3. Setting up the PC

The PC will need to run tftpd, dhcpd (or a standalone bootpd), and NFS
mountd. You can connect the O2 and the PC together with a crossover cable,
or you can connect the O2 to your network. My computer is a PC based Linux
box running RedHat 7.2, and all examples that follow will relate to RH 7.2
and xinetd.

3.1 dhcpd

The dhcpd service is used to respond to the bootp protocol that the O2 will
want to use for booting. In my situation, I have the O2 on my network but
also have a router that connects the whole house and provides DHCP for it.
The example dhcpd.conf file has IP address leasing disabled. Setting the
O2's IP is described in detail in the next section.

The dhcpd RPM that is floating around as of this writing for RedHat 7.2 does
not seem to work with the O2. Upgrading to the latest version of dhcpd from
http://www.isc.org seemed to fix my problem. The example /etc/dhcpd.conf
file below shows my situation here at home where my house is networked on a
192.168.1.0 network with a 255.255.255.0 subnet. My O2 is set to
192.168.1.10.

3.1.1 Example dhcpd.conf

# dhcpd.conf
#
# Sample configuration file for ISC dhcpd
#

# option definitions common to all supported networks...

#the following line is required for dhcpd version 3.0p1
ddns-update-style ad-hoc;

option subnet-mask 255.255.255.0;
default-lease-time 0;
max-lease-time 0;
subnet 192.168.1.0 netmask 255.255.255.0 {
#nothing in here...no ip leasing
}

# Fixed IP addresses can also be specified for hosts.   These addresses
# should not also be listed as being available for dynamic assignment.
# Hosts for which fixed IP addresses have been specified can boot using
# BOOTP or DHCP.   Hosts for which no fixed address is specified can only
# be booted with DHCP, unless there is an address range on the subnet
# to which a BOOTP client is connected which has the dynamic-bootp flag
# set.

#the O2 goes here. I gave mine the IP 192.168.1.10
#use printenv in the O2's command monitor and look at eaddr for the MAC
address (hardware ethernet)

host sgio2 {
  hardware ethernet 08:00:69:0c:79:db;
  fixed-address 192.168.1.10;
  filename "vmlinux";
}


3.1.2 tftpd, xinetd, and portmap

In the example dhcpd.conf file above, notice the filename="vmlinux" line.
That line tells the O2 what filename to get from your tftpd. The current RPM
for RedHat 7.2 tftp works fine for my O2 and can be found on
http://rpmfind.net if you don't have it. This version for RH runs under
xinetd and xinetd must be enabled along with portmapper for it to work. (You
can run serviceconf in X to configure these services.)

There is no configuration needed for tftpd. Just install the rpm and start
the service in serviceconf along with portmap and xinetd. At a prompt type
"service xinetd restart" and it will begin running. By default, tftpd wants
to service a directory on /tftpboot. (Command line to start in.tfptd should
have -s /tftpboot (or whatever your tftp directory is) on it.)

The "vmlinux" file will go in that /tftpboot directory. If you have no
"vmlinux" file suitable for booting your O2, then scroll up and click on
that link to oss.sgi.com. :)

In order to portmap to function properly, the following lines should be
added to your /etc/hosts.allow file:

portmap:ALL
tftpd:ALL

If you don't want to give access to all IP addresses, then you can replace
ALL with whatever is suitable as well as use wildcards (ex 192.168.1.*)

In order to be sure that your tftpd works properly, you can test it with
your tftp client. Connect to localhost and try to get a file from your
/tftpboot dir. If that works, then you're almost good to go. For example:

tftp localhost
get vmlinux

If it receives the file successfully, then you're set.

If your O2 doesn't seem able to connect to the tftpd, then add the following
line to your /etc/sysctl.conf file:

net.ipv4.ip_no_pmtu_disc = 1

or type at a prompt:

echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc

3.1.3 NFS and mountd

In order to mount a root fs from your O2, you need to set up mountd. The nfs
service should be started in serviceconf. The following line should be added
to /etc/hosts.allow:

mountd:ALL

In /etc/exports, add:

/pathname/rootfsdir       192.168.1.0/255.255.255.0(rw,no_root_squash)

(The IP above is the whole subnet for your network.)

That will export the /pathname/rootfsdir to the O2 if the O2's IP is set to
192.168.1.10. This will give it read-write access, and treat root on the O2
the same as root on your server PC's drive.

If you want to make sure your system has mountd up and running, connect to
your rootfs by typing at a prompt:

mount localhost:/pathname/rootfsdir /mntdir

If it mounts, then you should be good to go with your O2.

For more information on NFS root, look for the diskless-root-nfs-HOWTO.

4 Setting up the O2

Turn on your O2 and marvel at its sleek stylish case while you wait 45
seconds for it to actually do something. When the monitor finally displays
something, press ESC when the "STOP FOR MAINTENANCE" button appears. Press
'5' to go into the COMMAND MONITOR.

4.1 IP

Type the following in the command monitor:

setenv netaddr 192.168.1.10

That will set your O2 to the IP address listed above. Choose whichever is
appropriate for you.

4.2 Envs

The PROM in the O2 will pass some of its env vars to the Linux kernel. To
properly boot your system, type the following on the command monitor:

setenv OSLoadOptions "nfsroot=SERVER_IP:/pathname/rootfs ip=O2_IP:SERVER_IP"
setenv OSLoadPartition /dev/nfs

So if your O2 is 192.168.1.10, and your server linux PC is 192.168.1.103,
and the pathname to your O2's rootfs on your linux PC is /root/sgifs type:

setenv OSLoadOptions "nfsroot=192.168.1.103:/root/sgifs
ip=192.168.1.10:192.168.1.103"

4.3 Bootp

To boot your O2 and its Linux kernel, type the following:

bootp():

You should see the following from the O2:

Setting $netaddr to 192.168.1.10 (from server)
Obtaining from server
(some numbers)

If bootp(): just hangs, then your Linux PC's dhcpd server isn't set up
properly. If the first line appears but not the second, then tftpd is not
working. Check your Linux PC's /var/log/messages to see what's going on with
your RPC services. You can also type "rpcinfo -p" on your server PC to make
sure portmap and mountd are running. TFTPD won't show up there, but if
portmap is running you should be fine.

If you're lucky, the O2 will get the whole vmlinux file from your Linux PC,
and then display a message like "entry point 0x80200000" and then boot! You
should see the FB come up with the Tux logo.

If your file system doesn't remount as read-write, you probably forgot to
put an entry in /etc/fstab on the root filesystem you're trying to use. (Not
the server's /etc/fstab, but the one in the SGI's fs.) I did that, so I
figured I'd throw that in here. :)
