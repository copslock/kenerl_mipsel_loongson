Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA38131 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 23:16:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA93917
	for linux-list;
	Tue, 16 Feb 1999 23:14:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (kilimanjaro.engr.sgi.com [150.166.49.139])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA89025;
	Tue, 16 Feb 1999 23:14:34 -0800 (PST)
	mail_from (wombat@kilimanjaro.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1]) by kilimanjaro.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id XAA09589; Tue, 16 Feb 1999 23:14:33 -0800 (PST)
Message-Id: <199902170714.XAA09589@kilimanjaro.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy 
In-reply-to: Your message of "Wed, 17 Feb 99 02:08:36 EST."
             <Pine.LNX.3.96.990217020751.6350A-100000@lager.engsoc.carleton.ca> 
Date: Tue, 16 Feb 99 23:14:32 -0800
From: Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Right, meant to do that the first time and forgot:

In IRIX,
% hinv
Iris Audio Processor: version A2 revision 4.1.0
1 175 MHZ IP22 Processor
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
CPU: MIPS R4400 Processor Chip Revision: 6.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
Main memory size: 64 Mbytes
Vino video: unit 0, revision 0, IndyCam not connected
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 2 on SCSI controller 0
  Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 24-bit


In Linux,
% cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V6.0
system type             : SGI Indy
BogoMIPS                : 87.24
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 12424
VCEI exceptions         : 37454
