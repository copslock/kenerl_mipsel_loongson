Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA12110 for <linux-archive@neteng.engr.sgi.com>; Sat, 30 Jan 1999 18:41:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA24909
	for linux-list;
	Sat, 30 Jan 1999 18:40:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [130.62.245.44])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA32052
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 30 Jan 1999 18:40:01 -0800 (PST)
	mail_from (shm@cthulhu.engr.sgi.com)
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA91226 for <linux@cthulhu>; Sat, 30 Jan 1999 18:40:00 -0800 (PST)
Date: Sat, 30 Jan 1999 18:40:00 -0800
From: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
To: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Secondary Cache status ?
Message-ID: <Pine.SGI.4.05.9901301837180.86262-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


first off, sorry for the long delay in this, Alex, Ulf and Ralf .. I know
I was supposed to come back and let you guys know whether the secondary
cache thingy worked or not ..

Well it got a lot further, but here is where it stopped ..

>> boot bootp():/vmlinux
130768+22320+3184+341792+48560d+4604+6816 entry: 0x8df2c0d0
Setting $netaddr to 130.62.245.46 (from server agd-linux.engr.sgi.com)
Obtaining /vmlinux from server agd-linux.engr.sgi.com
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 98869248 bytes (96552K,94MB)
ARCH: SGI-IP22
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes)
Primary data cache 16kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2) #29
Thu Jul 9 22:19:39 EDT 1998
MC: SGI memory controller Revision 3
calculating r4koff... 000d567c(874108)
zs0: console input
zs0: console I/O
Calibrating delay loop... 87.24 BogoMIPS
Memory: 92264k/228396k available (1216k kernel code, 3064k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Starting kswapd v 1.5 
Adv: about to run setup()
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
Ramdisk driver initialized : 16 ramdisks of 4096K size
loop: registered device at major 7
WD93: Driver version 1.25 compiled on Jul  7 1998 at 16:59:57
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST32430N  Rev: 0240
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST31230N  Rev: 0272
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0
GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2070235 [1010 MB] [1.0
GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:dd:db 
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 130.62.245.101, my address is
130.62.245.46
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
Looking up port of RPC 100003/2 on 130.62.245.101
Looking up port of RPC 100005/1 on 130.62.245.101
VFS: Mounted root (nfs filesystem).
Adv: done running setup()
Freeing unused kernel memory: 44k freed
Warning: unable to open an initial console.
nfs: server 130.62.245.101 not responding, still trying
nfs: server 130.62.245.101 OK
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt
Scheduling in interrupt

When I ran it from the system console (graphics, as opposed to serial) ..
I also saw a message saying ..

page fault from irq handler : 0000 

(seems to be in sync with the above Scheduling ... message) ..

let me know if there is anything I can do ..


thanx
