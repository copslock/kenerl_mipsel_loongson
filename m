Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA44643 for <linux-archive@neteng.engr.sgi.com>; Tue, 25 May 1999 07:06:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA02372
	for linux-list;
	Tue, 25 May 1999 07:04:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA78854
	for <linux@engr.sgi.com>;
	Tue, 25 May 1999 07:04:39 -0700 (PDT)
	mail_from (martin.solli@paintbox.no)
Received: from mail.paintbox.no (mail.paintbox.no [193.215.245.25]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA01200
	for <linux@engr.sgi.com>; Tue, 25 May 1999 07:04:37 -0700 (PDT)
	mail_from (martin.solli@paintbox.no)
Received: by PBOX_OSLO with Internet Mail Service (5.5.2232.9)
	id <K8FVHL3R>; Tue, 25 May 1999 16:05:28 +0200
Message-ID: <3B2A814C9979D2119CC600A0C9AACD9919B3DF@PBOX_OSLO>
From: Martin Solli <martin.solli@paintbox.no>
To: "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Hardhat on the Indy
Date: Tue, 25 May 1999 16:05:20 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I know this has been discussed serveral times on the mailing list (I've read
the archives), but somehow the info didn't help me much booting my Indy.

The boot server: A Pentium box running Red Hat 5.2 and kernel 2.2.8
The NFS server: A solaris 2.5.1 box
The kernel image for the Indy: vmlinux-indy-2.2.1-990329
(also tried vmlinux from hardhat, vmlinux-indy-990212 and
vmlinux-indy-initrd-990313)

My boot command:
boot bootp():/vmlinux-indy-2.2.1-990329
nfsroot=193.215.244.135:/prod/martin/hardhat/mipseb

The Indy:
---
jonas:~$ hinv
CPU: MIPS R4400 Processor Chip Revision: 5.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
1 150 MHZ IP22 Processor
Main memory size: 128 Mbytes
Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
Instruction cache size: 16 Kbytes
Data cache size: 16 Kbytes
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 1 on SCSI controller 0
  Disk drive: unit 2 on SCSI controller 0
  CDROM: unit 4 on SCSI controller 0
On-board serial ports: 2
On-board bi-directional parallel port
Graphics board: Indy 24-bit
Integral Ethernet: ec0, version 1
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Iris Audio Processor: version A2 revision 4.1.0
Vino video: unit 0, revision 0, IndyCam connected
---


Here's what the kernel says after checking the hard drive partitions:
---
Looking up port of RPC 100003/2 on 193.215.244.135
Looking up port of RPC 100005/1 on 193.215.244.135
VFS: Mounted root (nfs filesystem).
Adv: done running setup()
Freeing unused kernel memory: 44k freed
page fault from irq handler: 0000
$0 : 00000000 88180000 0000062d 00000000
$4 : 00000000 1004fc00 00000000 00000000
$8 : 00000000 00000000 00000000 00046098
$12: 358d667d 8ff14874 8ff14800 00000000
$16: 8ff25000 8ff100e0 0000062d 881523c8
$20: aff25040 bfb94000 00000000 bfbd4000
$24: 00000000 8ff4fb58
$28: 88000000 88009d90 0000000e 880e3f38
eoc   : 880e3e74
Status: 1004fc02
Cause : 00000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing
---

Then it hangs. Suggestions? Fixes? Comments?

Thanks a lot! :)

--
.\\artin 
