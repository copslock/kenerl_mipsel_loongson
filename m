Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2TAUqv06280
	for linux-mips-outgoing; Fri, 29 Mar 2002 02:30:52 -0800
Received: from bunny.shuttle.de (bunny.shuttle.de [193.174.247.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2TAUOq06257;
	Fri, 29 Mar 2002 02:30:24 -0800
Received: by bunny.shuttle.de (Postfix, from userid 112)
	id 59B2E4E567; Fri, 29 Mar 2002 11:32:44 +0100 (CET)
Date: Fri, 29 Mar 2002 11:32:44 +0100
To: linux-mips@oss.sgi.com
Cc: devfs@oss.sgi.com
Subject: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020329103244.GA15765@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: raoul@shuttle.de (Raoul Borenius)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm not sure if this is a devfs or mips problem so I'm sending it
to both lists.

I just compiled my own mips-kernel from oss.sgi.com:/cvs to get
devfs-support. Unfortunately there seems to be a problem with the
serial-driver at least in the linux_2_4 branch:

SGI Zilog8530 serial driver version 1.00
devfs_register(ttyS): could not append to parent, err: -17
devfs_register(cua): could not append to parent, err: -17
tty00 at 0xbfbd9830 (irq = 29) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 29) is a Zilog8530

The result is that the directories /dev/tts and /dev/cua are missing.

There are only the files /dev/ttS and /dev/cua which can be used to get
access to the first serial port.

I have attached the full dmesg output at the end.

Regards

Raoul

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE 
CPU revision is: 00002020
FPU revision is: 00002020
Primary instruction cache 16kb, linesize 32 bytes.
Primary data cache 16kb, linesize 32 bytes.
Linux version 2.4.18-cvs-mips-20020328 (root@testserv) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Thu Mar 28 21:59:35 CET 2002
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 0020d000 @ 08002000 (usable)
 memory: 0000d000 @ 0820f000 (reserved)
 memory: 00524000 @ 0821c000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 09800000 @ 08800000 (usable)
On node 0 totalpages: 73728
zone(0): 73728 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 console=/dev/ttyS0 ro auto
Calibrating system timer... 665000 [133.00 MHz CPU]
NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9 revision A, cmap revision D, bt445 revision D
NG1: Screensize 1024x768
Console: colour SGI Newport 128x48
zs0: console input
Console: ttyS0 (Zilog8530), 9600 baud
Calibrating delay loop... 132.71 BogoMIPS
Memory: 156664k/163012k available (1370k kernel code, 6348k reserved, 164k data, 68k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
initialize_kbd: Keyboard reset failed, no ACK
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
block: 128 slots per queue, batch=32
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0b:17:50 
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Mar 28 2002 at 22:18:11
scsi0 : SGI WD93
 sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model: DORS-32160        Rev: WA6A
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE ST51080N  Rev: 0950
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
Partition check:
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3 p4 p5
SCSI device sdb: 2070235 512-byte hdwr sectors (1060 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3 p4
SGI Zilog8530 serial driver version 1.00
devfs_register(ttyS): could not append to parent, err: -17
devfs_register(cua): could not append to parent, err: -17
tty00 at 0xbfbd9830 (irq = 29) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 29) is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing prom memory: 768kb freed
Freeing unused kernel memory: 68k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 262176k swap-space (priority -1)

--mYCpIKhGyMATD0i+--
