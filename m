Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1DKE3P01983
	for linux-mips-outgoing; Wed, 13 Feb 2002 12:14:03 -0800
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1DKDm901953
	for <linux-mips@oss.sgi.com>; Wed, 13 Feb 2002 12:13:50 -0800
Received: from delllaptop (whnat1.weiderpub.com [65.115.104.67])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g1DJDme02025
	for <linux-mips@oss.sgi.com>; Wed, 13 Feb 2002 11:13:48 -0800
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: NFS ROOT Problem - boot  (newbie)
Date: Wed, 13 Feb 2002 11:07:44 -0800
Message-ID: <002f01c1b4c1$b7c4cb60$6d1510ac@delllaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am relatively new to this.  I am trying to boot to an nfs root on my
PC RedHat 7.2 box.  I downloaded the nfs image from ftp.mips.org
(nfsroot.mips.redhat7.1.eb-01.00.tar.gz).  I have a working 2.4.3 kernel
that I have installed on a SGI.  I need to boot to the nfs image so that
I can install to a local drive.  I have setup nfs on my PC RedHat 7.2
box and it is working.   When I boot the kernel on my SGI as follows:

>> boot nfsroot=192.168.0.75:mips ip=192.168.0.50

I get the following:

---

1503232+0+147092 entry: 0x880025a8
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00002310
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
Linux version 2.4.3 (flo@paradigm) (gcc version 3.0 20010303
(prerelease)) #1 Thu Apr 12 22:38:03
CEST 2001
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 00193000 @ 08002000 (reserved)
 memory: 005ab000 @ 08195000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 03800000 @ 08800000 (usable)
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=scsi(0)disk(1)rdisk(0)partition(0)
nfsroot=192.168.0.75:mips ip=192.168.0.50
Calibrating system timer... 900000 [180.00 MHz CPU]
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 179.81 BogoMIPS
Memory: 60056k/63148k available (1311k kernel code, 3092k reserved, 83k
data, 72k init)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard reset failed, no ACK
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
block: queued sectors max/low 39482kB/13160kB, 128 slots per queue
sgiseeq.c: David S. Miller (dm@engr.sgi.com)

eth0: SGI Seeq8003 08:00:69:0a:31:7a
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Apr 12 2001 at 22:38:57
scsi0 : SGI WD93
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: IBM
DORS-32160    Rev: W80D
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST51080N  Rev: 0950
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
SCSI device sda: 4197405 512-byte hdwr sectors (2149 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 2070235 512-byte hdwr sectors (1060 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IP-Config: Guessing netmask 255.255.255.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.0.75
Looking up port of RPC 100005/2 on 192.168.0.75
VFS: Mounted root (nfs filesystem) readonly.
Freeing prom memory: 768kb freed
Freeing unused kernel memory: 72k freed
nfs: server 192.168.0.75 not responding, still trying

---

It seems that it initially finds the root on the nfs box but it never
get to do an init.  It just stops and waits...  Do I need to modify any
setting manually on my NFS image in order for the kernel to boot?

Thanks
--
Robert Rusek
