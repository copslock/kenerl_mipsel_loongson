Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA76361 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Mar 1999 15:29:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA45081
	for linux-list;
	Fri, 26 Mar 1999 15:28:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA60171
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Mar 1999 15:28:18 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07550
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Mar 1999 15:28:14 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Qg4z-0027U4C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 27 Mar 1999 00:31:57 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10Qg1C-002OsqC; Sat, 27 Mar 99 00:28 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03542
	for linux@cthulhu.engr.sgi.com; Sat, 27 Mar 1999 00:23:22 +0100
Message-ID: <19990327002321.A3539@alpha.franken.de>
Date: Sat, 27 Mar 1999 00:23:21 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: Help needed to solve SCSI problem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm now total stuck with the remaining SCSI problem, and need some help.

I have a really broken cdrom drive. With this cdrom I'm able produce a
scsi timeout, which will cause a hang of the complete machine. I've
traced the problem a little bit further, and detected, that I get
interrupts on interrupt vector 0 (it's named VECTOR_GIO0 in the Irix
header files). I always see 17 irq 0 then the machine hangs completly.

Please, could someone tell what this interrupt means, so I can either
solve it by servicing the interrupt the right way or avoid it by doing 
something else ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
