Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA57450 for <linux-archive@neteng.engr.sgi.com>; Fri, 4 Dec 1998 07:51:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA77070
	for linux-list;
	Fri, 4 Dec 1998 07:49:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA69575
	for <linux@engr.sgi.com>;
	Fri, 4 Dec 1998 07:48:58 -0800 (PST)
	mail_from (andreas@aks-csd.ac.rwth-aachen.de)
Received: from aks-csd.ac.rwth-aachen.de (aks-csd.ac.RWTH-Aachen.DE [134.130.100.95]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA01084
	for <linux@engr.sgi.com>; Fri, 4 Dec 1998 07:48:53 -0800 (PST)
	mail_from (andreas@aks-csd.ac.rwth-aachen.de)
Received: from aks-csd (andreas@localhost [127.0.0.1])
	by aks-csd.ac.rwth-aachen.de (8.8.8/8.8.8) with SMTP id QAA19151
	for <linux@engr.sgi.com>; Fri, 4 Dec 1998 16:49:15 +0100
From: Andreas Gaffke-Administrator <andreas@aks-csd.ac.rwth-aachen.de>
To: linux@cthulhu.engr.sgi.com
Subject: Linux on a Indigo R4000?
Date: Fri, 4 Dec 1998 16:27:36 +0100
X-Mailer: KMail [version 0.7.9]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <98120416491400.19078@aks-csd>
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I´m new to this list, so please forgive any stupid questions ;-))

I´ve been trying to get an old "Indigo R4000" to run Linux... unfortunaly
without much success. I started out with the "Hardhat-5.1" distribution from the
linux.sgi site. I set up a 2GB disk with a "root" layout under IRIX 4.0.5F and
setup bootpd/tftpd on  a Pentium-II-Linux box. So far, so good!

When I try to boot the linux kernel from the "PROM" monitor, I get the
following output:

>> version
PROM Monitor SGI Version 4.0.5D Rev A IP20, Aug 17, 1992 (BE)
>> boot -f bootp()aks-csd:/vmlinux
Setting $netaddr to 134.130.100.90 (from server aks-csd)
Obtaining /vmlinux from server aks-csd

Cannot load bootp()aks-csd:/vmlinux.
Unable to load bootp()aks-csd:/vmlinux: execute format error
>>

Here is the output of the "hinv" command under IRIX 4.0.5:
----------
1 50 MHZ IP20 Processor
FPU: MIPS R4010 Floating Point Chip Revision: 0.0
CPU: MIPS R4000 Processor Chip Revision: 2.2
On-board serial ports: 2
Data cache size: 8 Kbytes
Instruction cache size: 8 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Main memory size: 32 Mbytes
Integral Ethernet: ec0, version 0
CDROM: unit 6 on SCSI controller 0
Tape drive: unit 5 on SCSI controller 0: QIC 150
Disk drive / removable media: unit 3 on SCSI controller 0: 720K/1.44M floppy
Disk drive: unit 2 on SCSI controller 0
Disk drive: unit 1 on SCSI controller 0
Integral SCSI controller 0: Version WD33C93B, revision C
Iris Audio Processor: revision 10
Graphics board: GR2-XS24 with Z-buffer             
-----------

What could be the problem? Is there a chance to get Linux up and running on
this hardware?

I´d appreciate some tips!

Thanks,

Andreas



--

+---------------------------------------------------------+
|   Dr. Andreas Gaffke         Tel/FAX: ++49+241 911646   |
|   Lousbergstr. 57            ICQ: 23487004:AndreasG     |
|   D-52072 Aachen                                        |
|   Germany                                               |
|                                                         |
|        e-Mail: andreas.gaffke@ac.rwth-aachen.de         |
|                                                         |
|  ***  Microsoft: it´s not a bug, it´s a feature.  ***   |
|                                                         |
+---------------------------------------------------------+
