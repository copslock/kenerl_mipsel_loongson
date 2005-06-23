Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 19:41:48 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.201]:40658 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225541AbVFWSl3> convert rfc822-to-8bit;
	Thu, 23 Jun 2005 19:41:29 +0100
Received: by wproxy.gmail.com with SMTP id 57so987199wri
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 11:40:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m0exbWnOMMUeBL2D2CeTmXqulZkbITU+IbGjhTdBQX+Fa4JCAFlcCkq930ULGsW7OabBUGvN7ejETVqzmkmH35GTKbisZV++e7axEc3hwGhxQ1RcSRiXScAXoEpFD1jA5cQHj8x2haJQdQPZM0CcMNgTTf6QqI+8/+VuxzUhpjo=
Received: by 10.54.32.67 with SMTP id f67mr1351626wrf;
        Thu, 23 Jun 2005 11:40:30 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 23 Jun 2005 11:40:30 -0700 (PDT)
Message-ID: <2db32b7205062311405b2de842@mail.gmail.com>
Date:	Thu, 23 Jun 2005 11:40:30 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
Subject: Re: booting error on db1550 for kernel 2.4.31
Cc:	linux-mips@linux-mips.org
In-Reply-To: <42BA62AA.9040602@cypou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720506221648eed011b@mail.gmail.com>
	 <42BA62AA.9040602@cypou.net>
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Here you go:

Start = 0x802e0040, range = (0x80100000,0x8031cfff), format = SREC
CPU revision is: 03030200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Linux version 2.4.31 (rolf@DBServer) (gcc version
2.96-sdelinuxmips-040127) #4 Wed Jun 22 16:26:37 PDT 2005
AMD Alchemy Au1550/Db1550 Board
Au1550 AA (PRId 03030200) @ 396MHZ
BCLK switching enabled!
Determined physical RAM map:
 memory: 0c000000 @ 00000000 (usable)
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=dhcp nfsroot=10.200.0.198:/nfsroot/mipsel
console=ttyS0,115200 usb_ohci=base:0x14020000,len:0x100000,irq:26
calculating r4koff... 003c6cc0(3960000)
CPU frequency 396.00 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 395.67 BogoMIPS
Memory: 191100k/196608k available (1906k kernel code, 5508k reserved,
124k data, 112k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x8031c668
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
00:0b.0 Class 0104: 1103:0007 (rev 02)
        I/O at 0x00000300 [size=0x8]
        I/O at 0x00000308 [size=0x4]
        I/O at 0x00000310 [size=0x8]
        I/O at 0x00000318 [size=0x4]
        I/O at 0x00000400 [size=0x100]
Non-coherent PCI accesses enabled
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
pty: 256 Unix98 ptys configured
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 8) is a 16550
ttyS02 at 0xb1400000 (irq = 9) is a 16550
loop: loaded (max 8 devices)
au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb0500000, irq 27
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb0510000, irq 28
eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
eth1: Using AMD 79C874 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdk: probing with STATUS(0x10) instead of ALTSTATUS(0x00)
hdk: IRQ probe failed (0xfffbbf7e)
hdk: probing with STATUS(0x10) instead of ALTSTATUS(0x32)
hdk: IRQ probe failed (0xfffbbf7e)
hdl: probing with STATUS(0x10) instead of ALTSTATUS(0x00)
hdl: IRQ probe failed (0xfffbbf7e)
hdl: probing with STATUS(0x10) instead of ALTSTATUS(0x00)
hdl: IRQ probe failed (0xfffbbf7e)
Au1550 psc audio: DAC: DMA16, ADC: DMA17
ac97_codec: AC97 Audio codec, id: 0x8384:0x7652 (SigmaTel STAC9752/53)
Au1550 psc audio: AC'97 Base/Extended ID = 6a90/0a05
usb.c: registered new driver hub
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 255.255.255.255, my address is 10.200.1.52
IP-Config: Complete:
      device=eth0, addr=10.200.1.52, mask=255.255.0.0, gw=10.200.0.1,
     host=10.200.1.52, domain=sel, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=10.200.0.198, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.200.0.198
Looking up port of RPC 100005/1 on 10.200.0.198
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 112k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.78 booting
			Welcome to Red Hat Linux
		Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
modprobe: modprobe: Can't open dependencies file
/lib/modules/2.4.31/modules.dep (No such file or directory)
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
Setting clock  (localtime): Wed Dec 31 16:00:13 PST 1969 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname localhost.localdomain:  [  OK  ]
Checking root filesystem
fsck: fsck.root: not found
fsck: Error 2 while executing fsck.root for none
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Finding module dependencies:  depmod: Can't open
/lib/modules/2.4.31/modules.dep for writing
[FAILED]
Checking filesystems
Checking all file systems.
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]

localhost.localdomain login: root
Password: 


On 6/23/05, Cyprien Laplace <cyprien@cypou.net> wrote:
> rolf liu wrote:
> 
> >I compiled the kernel 2.4.31 using sde tools. Download linux to db1550
> >through yamon. but the kernel can't find the NFS root. I tried the NFS
> >system from other linux box, and the NFS is ok. Who met this same
> >problem?
> >
> >Looking up port of RPC 100003/2 on 10.200.0.198
> >RPC: sendmsg returned error 128
> >portmap: RPC call returned error 128
> >Root-NFS: Unable to get nfsd port number from server, using default
> >Looking up port of RPC 100005/1 on 10.200.0.198
> >RPC: sendmsg returned error 128
> >portmap: RPC call returned error 128
> >Root-NFS: Unable to get mountd port number from server, using default
> >RPC: sendmsg returned error 128
> >mount: RPC call returned error 128
> >Root-NFS: Server returned error -128 while mounting /nfsroot/mipsel
> >VFS: Unable to mount root fs via NFS, trying floppy.
> >kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno = 2
> >VFS: Cannot open root device "" or 02:00
> >Please append a correct "root=" boot option
> >Kernel panic: VFS: Unable to mount root fs on 02:00
> >
> >Thanks for the suggestion
> >
> >
> >
> What cmdline did you give to the kernel ?
> Had it an IP address ?
> Can you tcpdump your local ethernet traffic ? Is there any correct ARP
> traffic ?
> 
> Regards,
> Cyp
> 
>
