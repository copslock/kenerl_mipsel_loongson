Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA17635 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 May 1999 16:35:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA13185
	for linux-list;
	Sat, 1 May 1999 16:33:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA02867
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 May 1999 16:33:06 -0700 (PDT)
	mail_from (jcoffin@sv.usweb.com)
Received: from sv.usweb.com (null-client16.sf.usweb.com [207.138.177.16] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id TAA03720
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 May 1999 19:33:05 -0400 (EDT)
	mail_from (jcoffin@sv.usweb.com)
Received: (qmail 16255 invoked by uid 500); 1 May 1999 23:40:55 -0000
To: ulfc@thepuffingroup.com
CC: linux@cthulhu.engr.sgi.com
Subject: RE: Yet Closer
From: Jeff Coffin <jcoffin@sv.usweb.com>
Date: 01 May 1999 16:40:54 -0700
Message-ID: <m3n1zouznd.fsf@chuck.sv.usweb.com>
X-Mailer: Gnus v5.5/Emacs 20.3
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Don't you see anything at all, or does it hang after freeing PROM
> memory? There was a problem with the PROM memory freeing on newer
> PROM's, which Thomas recently solved. I don't think he has uploaded
> a new kernel since then..

>  I can probably upload a new one if this is your problem. 

I think it's something else.  Here's what I get (this is from ralf's
suggestion, didn't quite work for me) :


>> boot vmlinux root=/dev/sdb1 init=/bin/sh
115360+19584+3136+334528+42744d+4248+6368 entry: 0x8bfa8850
ARCH: SGI-IP22
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 65839104 bytes (64296K,62MB)
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00002310
Primary instruction cache 32kb, linesize 32 bytes)
Primary data cache 32kb, linesize 32 bytes)
Linux version 2.2.1 (tsbogend@james.franken.de) (gcc version 2.7.2.3) #519 Mon 9
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
calculating r4koff... 000dbd55(900437)
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 179.81 BogoMIPS
Memory: 60908k/196140k available (1172k kernel code, 2208k data)
Checking for 'wait' instruction...  available.                                  POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
initialize_kbd: Keyboard reset failed, no ACK
SGI Zilog8530 serial driver version 1.00
Keyboard timeout[2]
Keyboard timeout[2]
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
pty: 256 Unix98 ptys configured
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
RAM disk driver initialized:  16 RAM disks of 4096K size
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Mar 29 1999 at 01:13:15
scsi0 : SGI WD93
scsi : 1 host.                                                                  sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: IBM DORS-32160  D
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST31055N        2
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2069860 [1010 MB] [1.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:43:7c
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.254.20, my address is 192.168.254.30
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 0k freed
Freeing unused kernel memory: 52k freed
Warning: unable to open an initial console.

 
--jeff
