Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2174797 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Mar 1998 13:45:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA4690919
	for linux-list;
	Fri, 27 Mar 1998 13:44:46 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA4183661
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 27 Mar 1998 13:44:44 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id NAA11596
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Mar 1998 13:44:43 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id QAA07937; Fri, 27 Mar 1998 16:51:55 -0500
Date: Fri, 27 Mar 1998 16:59:26 -0500
Message-Id: <199803272159.QAA18195@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: ralf@uni-koblenz.de
Cc: Dong Liu <dliu@npiww.com>, linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
In-Reply-To: <19980327220550.50946@uni-koblenz.de>
References: <199803272025.PAA16215@pluto.npiww.com>
	<19980327220550.50946@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > 
 > The addresses 0x800cbfdc / 0x800cbfbc are not valid kernel addresses on
 > the Indy.  Is it possible you wrote them down wrong?  0x880cbfdc /
 > 0x880cbfbc however would make sense and are indeed in the sgiseeq driver.
 > I'll take a closer look at it.

Sorry, my mistake, they are 0x880cbfdc 0x880cbfbc

 > > 
 > > Another thing it didn't get the right capacity of scsi disk.
 > 
 > Are you shure?  Some peopple got fooled by the 1024 vs. 1024 bytes per
 > kb isue ...  Or are the numbers way off?

This what I got

sda: sector size 0 reported, assume 512
SCSI device sda: hdwr sector= 512 bytes, Sectors=1 [0 MB][0.0 GB]

:=)

 > 
 > There is a command named ``hinv'' under IRIX.  Can you mail me the output?

Here it is

1 100 MHZ IP22 Processor
FPU: MIPS R4010 Floating Point Chip Revision: 0.0
CPU: MIPS R4000 Processor Chip Revision: 3.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 8 Kbytes
Instruction cache size: 8 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Main memory size: 64 Mbytes
Iris Audio Processor: version A2 revision 4.1.0
Integral Ethernet: ec0, version 1
Disk drive / removable media: unit 2 on SCSI controller 0
Disk drive: unit 1 on SCSI controller 0
Integral SCSI controller 0: Version WD33C93B, revision D
Graphics board: Indy 24-bit
Vino video: unit 0, revision 0, Indycam connected
