Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA1109792 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Mar 1998 11:39:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA3871283 for linux-list; Thu, 12 Mar 1998 11:37:39 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA3871484 for <linux@engr.sgi.com>; Thu, 12 Mar 1998 11:37:31 -0800 (PST)
Received: from sparc.life.nthu.edu.tw ([140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA12651
	for <linux@engr.sgi.com>; Thu, 12 Mar 1998 11:37:28 -0800 (PST)
	mail_from (tonywu@life.nthu.edu.tw)
Received: from localhost (tonywu@localhost)
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) with SMTP id DAA24088
	for <linux@engr.sgi.com>; Fri, 13 Mar 1998 03:35:37 +0800 (CST)
Date: Fri, 13 Mar 1998 03:35:36 +0800 (CST)
From: "Tony C. Wu" <tonywu@life.nthu.edu.tw>
X-Sender: tonywu@sparc
To: linux@cthulhu.engr.sgi.com
Subject: Getting Started ..... NOT
Message-ID: <Pine.GSO.3.96.980313030936.24023A-100000@sparc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

After the 101st failure on getting sgi-linux to work on our poor SGI indy,
I decided to beg you guys for a clue. I used installer-0.10d and
root-be-0.03-cpio. I followed every step listed in the INSTALL that came
with installer-0.10d. 

1. ./mke2fs /dev/dsk/dks0d2s0			ok
2. ./installer /dev/dsk/dks0d2s0		ok
3. MAKEDEV					ok
4. cpio root-be-0.03-cpio			ok
5. exit						ok
6. ./e2fsck -fy /dev/dsk/dks0d2s0		fixed some errors, ok
7. gzip -d vmlinux-2.1.65.efs.gz /vmlinux	ok

>> boot vmlinux root=/dev/sdb1			failed.

I tried every pre-compiled kernel that's in the pub/test dir of
ftp.linux.sgi.com pub/test, but all failed.

2.1.65 gave: bus error
2.1.72 gave: blank screen
2.1.72_NOSL: put me in repair fs mode, but i can't change anything.
             It said it couldn't read superblock on /dev/sdb
 

Here's what hinv says about our indy.
---- HINV -------------------------------------------------------------
Iris Audio Processor: version A2 revision 4.1.0
1 100 MHZ IP22 Processor
FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
CPU: MIPS R4600 Processor Chip Revision: 2.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Main memory size: 64 Mbytes
Vino video: unit 0, revision 0, IndyCam not connected
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 2 on SCSI controller 0
  Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 8-bit
---------------------------------------------------------------------

Any help is appreciated.
Thanks,
--
Tony C. Wu 
System administrator            Email: tonywu@life.nthu.edu.tw
Dept. of Life Sciences          Voice: +886-3-574-2772
NTHU, Hsin-Chu, Taiwan            Fax: +886-3-571-5934
