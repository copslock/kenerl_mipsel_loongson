Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA56151 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 02:50:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA21461866
	for linux-list;
	Fri, 8 May 1998 02:49:33 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA22106595
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 02:49:30 -0700 (PDT)
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id CAA17220
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 02:49:27 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id FAA01399; Fri, 8 May 1998 05:48:27 -0400
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri,  8 May 1998 05:48:26 -0400 (EDT)
To: linux@cthulhu.engr.sgi.com
Subject: RE: Making Progress
In-Reply-To: <Pine.LNX.3.95.980507131537.20653F-100000@lager.engsoc.carleton.ca>
References: <60222E63C9F4D011915F00A02435011C126253@BART>
	<Pine.LNX.3.95.980507131537.20653F-100000@lager.engsoc.carleton.ca>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <13650.53876.373554.664836@mdhill.interlog.com>
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > Hmmm.  Odd.  Can you give us the results of a 'hinv'?
 > 
Iris Audio Processor: version A2 revision 4.1.0
1 133 MHZ IP22 Processor
FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
CPU: MIPS R4600 Processor Chip Revision: 2.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Main memory size: 32 Mbytes
Vino video: unit 0, revision 0
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 4 on SCSI controller 0
  Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 8-bit

Here's this morning's result from 'boot /vmlinux root=/dev/sdb
ip=none':

[snip]
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 1070496 [522 MB]
[0.5 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2400302 [1172 MB]
[1.2 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:07:e3:0d
Sending BOOTP and RARP requests............. timed out!
IP-Config: Auto-configuration of network failed.
Partition check:
[end]

Next I'll try adding a partition to be checked.

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
