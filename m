Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 04:07:47 +0100 (BST)
Received: from smtpr3.tom.com ([IPv6:::ffff:202.108.255.198]:61777 "HELO
	tom.com") by linux-mips.org with SMTP id <S8224808AbVIADHY>;
	Thu, 1 Sep 2005 04:07:24 +0100
Received: from [192.168.10.105] (unknown [218.94.38.156])
	by bjapp3 (Coremail) with SMTP id QQA7EcxxFkNZACac.1
	for <linux-mips@linux-mips.org>; Thu, 01 Sep 2005 11:13:28 +0800 (CST)
X-Originating-IP: [218.94.38.156]
Message-ID: <431671CF.8070906@tom.com>
Date:	Thu, 01 Sep 2005 11:13:19 +0800
From:	Zhuang Yuyao <ihollo@tom.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [ADMtek 5120] 64M sdram on board but only 16M is deteted and usable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ihollo@tom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihollo@tom.com
Precedence: bulk
X-list: linux-mips

Hi,

I've just upgraded the SDRAM on my adm5120 board from 16M to 64M, but 
while the board is booting, it still reports that only 16M sdram is 
availible.
Since I do not have the source code of the bootloader, is there any way 
to let the board to boot with 64M sdram, or should I change to another 
bootloader?

Thanks very much.

Here is the boot message.
Linux version 2.6.12 (root@debian) (gcc version 3.4.2) #28 Wed Aug 31 
20:51:01 MDT 2005
CPU revision is: 0001800b
ADM5120 board setup
Determined physical RAM map:
 memory: 00b0b000 @ 004f5000 (usable)
Built 1 zonelists
Kernel command line:
Primary instruction cache 8kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 128 (order: 7, 2048 bytes)
CPU clock: 175MHz
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 11136k/11308k available (2369k kernel code, 160k reserved, 375k 
data, 2004k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
System has PCI BIOS
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
ADM5120 LED & GPIO driver
ttyS0 at I/O 0x12600000 (irq = 1) is a ADM5120
ttyS1 at I/O 0x12800000 (irq = 2) is a ADM5120
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 7168K size 1024 blocksize
PPP generic driver version 2.4.2
NET: Registered protocol family 24
eth0: ADM5120 switch port0
eth1: ADM5120 switch port1
eth2: ADM5120 switch port2
eth3: ADM5120 switch port3
eth4: ADM5120 switch port4
eth5: ADM5120 switch port5
ADM5120 board flash (0x400000 at 0x1fc00000)
ADM5120: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 1 MTD partitions on "ADM5120":
0x003e0000-0x00400000 : "p1"
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (128 buckets, 1024 max) - 248 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.6 loaded successfully
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
Ebtables v2.0 registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Freeing unused kernel memory: 2101563k freed
Algorithmics/MIPS FPU Emulator v1.5
Mounting filesystems...

Please press Enter to activate this console.


While booted with pre-compiled image from 
http://sharon.esrac.ele.tue.nl/users/pe1rxq/linux-adm/vmlinuz-20050329.
The boot message looks like this (Still can not find the higher memory):

Linux version 2.6.12-rc1 (pe1rxq@laptop) (gcc version 3.4.2) #120 Mon 
Mar 28 01:10:40 CEST 2005
CPU revision is: 0001800b
ADM5120 board setup
System has PCI BIOS
Determined physical RAM map:
 memory: 00d1c000 @ 002e4000 (usable)
Built 1 zonelists
Kernel command line:
Primary instruction cache 8kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 128 (order: 7, 2048 bytes)
CPU clock: 175MHz
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 13244k/13424k available (1908k kernel code, 160k reserved, 315k 
data, 628k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing Cryptographic API
ADM5120 LED & GPIO driver
ttyS0 at I/O 0x12600000 (irq = 1) is a ADM5120
ttyS1 at I/O 0x12800000 (irq = 2) is a ADM5120
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: ADM5120 switch port0
eth1: ADM5120 switch port1
eth2: ADM5120 switch port2
eth3: ADM5120 switch port3
eth4: ADM5120 switch port4
eth5: ADM5120 switch port5
ADM5120 board flash (0x200000 at 0x1fc00000)
ADM5120: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
adm5120-hcd adm5120-hcd: new USB bus registered, assigned bus number 1
usb usb1: Product: adm5120-hcd
usb usb1: Manufacturer: Linux 2.6.12-rc1 adm5120-hcd
usb usb1: SerialNumber: adm5120-hcd
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
NET: Registered protocol family 17
Freeing unused kernel memory: 2099720k freed
Algorithmics/MIPS FPU Emulator v1.5
Relaxen und vatch das blinkenlights!!!
Mounting filesystems...

*********************************
 Its alive!!!!!!!!!!!!!!!!!!!!!!
*********************************
