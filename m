Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f852GUt10517
	for linux-mips-outgoing; Tue, 4 Sep 2001 19:16:30 -0700
Received: from mother.pmc-sierra.bc.ca (father.pmc-sierra.bc.ca [216.241.224.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f852GPd10511
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 19:16:25 -0700
Received: (qmail 4288 invoked by uid 104); 5 Sep 2001 02:16:19 -0000
Received: from Manoj_Ekbote@pmc-sierra.com by father with qmail-scanner-0.93 (uvscan: v4.0.70/v4074. . Clean. Processed in 0.412005 secs); 04/09/2001 19:16:19
Received: from unknown (HELO procyon.pmc-sierra.bc.ca) (134.87.115.1)
  by father.pmc-sierra.bc.ca with SMTP; 5 Sep 2001 02:16:18 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by procyon.pmc-sierra.bc.ca (jason/8.11.6) with ESMTP id f852GIM20218
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 19:16:18 -0700 (PDT)
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2653.19)
	id <RBMNSV2H>; Tue, 4 Sep 2001 19:17:38 -0700
Message-ID: <DC10067A2F4A5944B7811FCF59ABB114744FA1@sjc2exm01>
From: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: ramdisk support failing
Date: Tue, 4 Sep 2001 19:17:32 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am trying to load a kernel with ramdisk support linked in it. It is a 2.4.5 kernel, ported for Ocelot board running a PMC RM7000 chip.
The kernel hangs while trying to load the "init" process. The "init" is actually the sash program. I have placed the init in /sbin, /sbin and /etc.The "execve" in setup.c returns ENOEXEC while running /sbin/init. The CONFIG_BINFMT_ELF is set in the .config file.
The init has the x attribute.

Here's the output:

>g root=/dev/ram
...........
...........
Initial ramdisk at: 0x80285000 (1161262 bytes)
...........

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd v1.8

pty: 256 Unix98 ptys configured

Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled

ttyS00 at 0x0000 (irq = 4) is a ST16650

block: queued sectors max/low 83088kB/27696kB, 256 slots per queue

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

SCSI subsystem driver Revision: 1.00

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 1024 buckets, 8Kbytes

TCP: Hash tables configured (established 8192 bind 16384)

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1134k freed

EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended

VFS: Mounted root (ext2 filesystem).

Freeing unused kernel memory: 72k freed

/sbin/init failed..8           <------ ENOEXEC returned by execve("init")

etc/init failed...14

/bin/init failed...14

Kernel panic: No init found.  Try passing init= option to kernel.


Any ideas?
Manoj
