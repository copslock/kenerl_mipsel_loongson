Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA69018 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Mar 1999 02:48:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA23518
	for linux-list;
	Fri, 12 Mar 1999 02:47:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA30469
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 12 Mar 1999 02:47:33 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA03735
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Mar 1999 05:47:27 -0500 (EST)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id LAA04052;
	Fri, 12 Mar 1999 11:47:07 +0100 (MET)
Received: from aisa.fi.muni.cz (aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id LAA21524;
	Fri, 12 Mar 1999 11:47:06 +0100 (MET)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id LAA10931;
	Fri, 12 Mar 1999 11:47:06 +0100 (MET)
Date: Fri, 12 Mar 1999 11:47:05 +0100
From: Honza Pazdziora <adelton@informatics.muni.cz>
To: linux@cthulhu.engr.sgi.com
Subject: Attempt for R10000 devel
Message-ID: <19990312114705.C3024@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain
X-Mailer: Mutt 0.95.3i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello,

we have been provided for limited period of time an Origin200 from
Petr Mosnicka to see what would be possible to do with the thing. We
have IRIX running on that machine and other Indys around, 6.5, 6.2
and 5.3. We have egcs-1.1.1 on that machine that looks like
supporting 64 bit code.

I'd not call this a "project" since we are by no means sure we would
be able to move an inch, but we will try. So this is not an announce
but merely an asking for guidlines and opinions. At the moment, compiling
a simple code that could be run from the prom seems to be the primary
goal (or isn't it?). Is it true that by taking code from
arch/mips/kernel/head.S and arch/mips/arc we should be able to get an
ELF that the prom should be able to run? Does anybody have such
a piece code that we could start with?

Is it feasible or are we just mad? Having said we, there are four
guys here, two having decent experience writing device drivers, one
being The Czech Linux guru. We have experience with IRIX and running
HardHat on Indys. Any info that might get us moving is greately
appreciated.

bash# hinv
1 180 MHZ IP27 Processor
CPU: MIPS R10000 Processor Chip Revision: 2.6
FPU: MIPS R10010 Floating Point Chip Revision: 0.0
Main memory size: 64 Mbytes
Instruction cache size: 32 Kbytes
Data cache size: 32 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Integral SCSI controller 0: Version QL1040B, single ended
  Disk drive: unit 1 on SCSI controller 0
Integral SCSI controller 1: Version QL1040B, single ended
  CDROM: unit 6 on SCSI controller 1
Integral SCSI controller 2: Version QL1040B (rev. 2), single ended
IOC3 serial port: tty1
IOC3 serial port: tty2
IOC3 parallel port: plp1
Integral Fast Ethernet: ef0, version 1, module 1, slot MotherBoard, pci 2
Origin 200 base I/O, module 1 slot 1
IOC3 external interrupts: 1

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
 make vmlinux.exe			-- SGI Visual Workstation Howto
------------------------------------------------------------------------
