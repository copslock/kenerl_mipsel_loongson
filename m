Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA64450 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Jun 1999 11:48:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA56889
	for linux-list;
	Thu, 17 Jun 1999 11:45:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA63754
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Jun 1999 11:45:20 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id LAA06002
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Jun 1999 11:45:18 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 8015 invoked from network); 17 Jun 1999 18:45:14 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 17 Jun 1999 18:45:14 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <NCDWK62R>; Thu, 17 Jun 1999 14:39:41 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC07EA0E@BART>
From: Mike Hill <mikehill@hgeng.com>
To: linux@cthulhu.engr.sgi.com
Subject: Booting an Indigo2
Date: Thu, 17 Jun 1999 14:39:40 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Sorry, this looks familiar.  Here's what I get in my serial console:

PROMLIB: Total free ram 65839104 bytes (64296K,62MB)
CPU: MIPS-R4000 FPU<MIPS-R4000FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes)
Primary data cache 8kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.2.1 (root@binkley) (gcc version egcs-2.90.27 980315
(egcs-1.0.2 release)) #4 Wed Jun 16 22:03:59 EDT 1999
MC: SGI memory controller Revision 3
calculating r4koff... 0007a203(500227)
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 49.87 BogoMIPS
Memory: 60952k/196140k available (1120k kernel code, 2188k data)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5 
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jun 16 1999 at 22:16:18
scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST31200N  Rev: 9278
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2077833 [1014 MB] [1.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:07:c9:47 
IP-Config: Got BOOTP answer from 192.168.1.6, my address is 192.168.1.95
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5 sda6
Looking up port of RPC 100003/2 on 192.168.1.6
Looking up port of RPC 100005/1 on 192.168.1.6
Root-NFS: Server returned error -13 while mounting /usr/src/installfs
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Oops: 0000
$0 : 00000000 1004fc01 00000001 00000001
$4 : 8812f604 00000000 00000000 00000000
$8 : 1004fc00 1000001f 1004fc01 00000000
$12: 881101a0 00000030 00000000 abf3b000
$16: 88159fa0 8833fe30 8800a2a0 8bfff938
$20: a8747590 9fc4a744 00000000 9fc4a744
$24: 00000000 00000000
$28: 8833e000 8833fe10 9fc4a88c 880f57b4
epc   : 880f51f8
Status: 1004fc02
Cause : 00000808
Process swapper (pid: 1, stackpage=8833e000)
Stack: 9fc4a88c 880f510c 0000000a 0000013d 20000800 8bf27000 880f57b4
880f5780
       1004fc01 00000000 881101a0 00000030 00000000 abf3b000 00000000
1004fc01
       00000000 8812fc9c 8814f7cc 00000000 1004fc01 1004fc00 0000fc00
ffff00ff
       1004fc01 00000000 881101a0 00000030 00000000 abf3b000 00000000
8bf27000
       8800a2a0 8bfff938 a8747590 9fc4a744 00000000 9fc4a744 00000000
00000000
       00000037 ...
Call Trace: [<880f510c>] [<880f57b4>] [<880f5780>] [<881101a0>] [<881101a0>]
[<8800a2a0>] [<8802952c>] [<880295d4>] [<880f9270>] [<880fb690>]
[<8800a2a0>] [<880f15b0>] [<8800a2a0>] [<8800a2a0>] [<8800a2b0>]
[<88029c0c>] [<880f6778>] [<8800ff6c>] [<8800ff5c>]
Code: 24630001  ac820078  ae030000 <8ce50010> 8ce20000  00c02021  0040f809
02203021  8e020000 
Aiee, killing interrupt handler



...and here's the hinv output:

Iris Audio Processor: version A2 revision 1.1.0
1 100 MHZ IP22 Processor
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
CPU: MIPS R4000 Processor Chip Revision: 3.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 8 Kbytes
Instruction cache size: 8 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
Main memory size: 64 Mbytes
EISA bus: adapter 0
Integral Ethernet: ec0, version 1
Integral SCSI controller 1: Version WD33C93B, revision D
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 1 on SCSI controller 0
Graphics board: GR3-XZ


My external hard drive doesn't seem to be detected (but that's okay, IRIX
doesn't like it either).

Mike
