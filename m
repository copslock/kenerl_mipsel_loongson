Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA77485 for <linux-archive@neteng.engr.sgi.com>; Fri, 4 Dec 1998 09:07:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA65781
	for linux-list;
	Fri, 4 Dec 1998 09:05:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.61.141])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA66071
	for <linux@engr.sgi.com>;
	Fri, 4 Dec 1998 09:05:56 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA19037; Fri, 4 Dec 1998 09:05:49 -0800
Date: Fri, 4 Dec 1998 09:05:49 -0800
Message-Id: <199812041705.JAA19037@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Andreas Gaffke-Administrator <andreas@aks-csd.ac.rwth-aachen.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on a Indigo R4000?
In-Reply-To: <98120416491400.19078@aks-csd>
References: <98120416491400.19078@aks-csd>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Andreas Gaffke-Administrator writes:
...
 > >> version
 > PROM Monitor SGI Version 4.0.5D Rev A IP20, Aug 17, 1992 (BE)
 > >> boot -f bootp()aks-csd:/vmlinux
 > Setting $netaddr to 134.130.100.90 (from server aks-csd)
 > Obtaining /vmlinux from server aks-csd
 > 
 > Cannot load bootp()aks-csd:/vmlinux.
 > Unable to load bootp()aks-csd:/vmlinux: execute format error
 > >>

      You have to load sash first (and probably an IRIX 6.2 or later
sash at that), because the IP20 prom only knows how to load MIPS ECOFF
binaries, not ELF binaries.  The newer sash knows how to load ELF.

	sash
	boot -f bootp()aks-csd:/vmlinux

Alternately, you could use some tool to produce an ECOFF executable
from the ELF executable, sufficient to allow the PROM to load it.
(The PROM expects only the most basic information, so such a tool
does not have to be very sophisticated.)

     Beyond that, the IP20 is not completely compatible with the Indy
(IP24, IRIX IP22 kernel) and Indigo2 (IP22), although it shares the
same memory controller, and most of the work on Linux/MIPS so far
has been on the Indy.  The graphics are often different, and the I/O
controller is an older revision, compared to Indy, which is not
completely compatible.  The graphics card you have is also different
from the basic Newport (XL) graphics on Indy, and is probably not yet
supported.

      I have been talking with people within SGI about providing
documentation and downloadable firmware for the various graphics cards
and for platforms other than Indy, but I don't yet have final
agreement.  Also, some of these machines were built quite a long time
ago (yours was probably built in 1992), so locating some of the
documentation is quite an effort.  


 > Here is the output of the "hinv" command under IRIX 4.0.5:
 > ----------
 > 1 50 MHZ IP20 Processor
 > FPU: MIPS R4010 Floating Point Chip Revision: 0.0
 > CPU: MIPS R4000 Processor Chip Revision: 2.2
 > On-board serial ports: 2
 > Data cache size: 8 Kbytes
 > Instruction cache size: 8 Kbytes
 > Secondary unified instruction/data cache size: 1 Mbyte
 > Main memory size: 32 Mbytes
 > Integral Ethernet: ec0, version 0
 > CDROM: unit 6 on SCSI controller 0
 > Tape drive: unit 5 on SCSI controller 0: QIC 150
 > Disk drive / removable media: unit 3 on SCSI controller 0: 720K/1.44M flo=
 > ppy
 > Disk drive: unit 2 on SCSI controller 0
 > Disk drive: unit 1 on SCSI controller 0
 > Integral SCSI controller 0: Version WD33C93B, revision C
 > Iris Audio Processor: revision 10
 > Graphics board: GR2-XS24 with Z-buffer            =20
 > -----------
 > 
 > What could be the problem? Is there a chance to get Linux up and running =
 > on
 > this hardware?
 > 
 > I=B4d appreciate some tips!
 > 
 > Thanks,
 > 
 > Andreas
 > 
 > 
 > 
 > --
 > 
 > +---------------------------------------------------------+
 > |   Dr. Andreas Gaffke         Tel/FAX: ++49+241 911646   |
 > |   Lousbergstr. 57            ICQ: 23487004:AndreasG     |
 > |   D-52072 Aachen                                        |
 > |   Germany                                               |
 > |                                                         |
 > |        e-Mail: andreas.gaffke@ac.rwth-aachen.de         |
 > |                                                         |
 > |  ***  Microsoft: it=B4s not a bug, it=B4s a feature.  ***   |
 > |                                                         |
 > +---------------------------------------------------------+
