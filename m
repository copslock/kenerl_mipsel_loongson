Received:  by oss.sgi.com id <S305260AbQDAMfp>;
	Sat, 1 Apr 2000 04:35:45 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:17462 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQDAMf0>;
	Sat, 1 Apr 2000 04:35:26 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA25881; Sat, 1 Apr 2000 04:30:45 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA23385; Sat, 1 Apr 2000 04:35:25 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA29977
	for linux-list;
	Sat, 1 Apr 2000 04:20:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA30858
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 04:20:22 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA04245
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 04:20:19 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A8B8E7F3; Sat,  1 Apr 2000 14:20:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 70C738FC3; Sat,  1 Apr 2000 14:10:30 +0200 (CEST)
Date:   Sat, 1 Apr 2000 14:10:30 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: boot/nfsroot probles
Message-ID: <20000401141030.F3970@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Ok,
after i got a binary kernel bootable on the indigo2 i am now a couple
steps further - It seems i have problems with the hardhat userspace


-------------------------
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
PROMLIB: Total free ram 131911680 bytes (128820K,125MB)
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes)
Primary data cache 16kb, linesize 16 bytes)
Secondary cache sized at 2048K linesize 128
Linux version 2.3.21 (vince@orws5.apgea.army.mil) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #11 Wed Jan 12 16:38:45 EST 2000
MC: SGI memory controller Revision 3
calculating r4koff... 0013145a(1250394)
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 124.93 BogoMIPS
Memory: 122912k/260664k available (1264k kernel code, 4608k data)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (established 8192 bind 16384)
Starting kswapd v1.6
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
pty: 256 Unix98 ptys configured
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jan 12 2000 at 16:41:47
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jan 12 2000 at 16:41:47
scsi0 : SGI WD93
scsi1 : SGI WD93
scsi : 2 hosts.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: QUANTUM XP32150
 Rev: S89C
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4404489 [2150 MB] [2.2 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:04:b9
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 195.71.97.227, my address is 195.71.97.231
Partition check:
 sda: sda1 sda2 sda3 sda4
Looking up port of RPC 100003/2 on 195.71.97.230
Looking up port of RPC 100005/1 on 195.71.97.230
VFS: Mounted root (NFS filesystem) readonly.
Freeing prom memory: 768k freed
Freeing unused kernel memory: 48k freed
Warning: unable to open an initial console.
-------------------------

The last line is strictly optional - I see this if i remove the /dev/console
node (major 5 minor 1 )

Giving different combinations of init=/bin/sh init=/usr/bin/ash 
console=ttyS0,9600 

I see a bit nfs traffic in the tcpdump but this stops after 2-3 seconds
so i am a bit lost where the problem might be ...

I suppose a console/userspace problem ... (And now its raining ...)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
