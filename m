Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA02362 for <linux-archive@neteng.engr.sgi.com>; Thu, 6 Aug 1998 14:46:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA43006
	for linux-list;
	Thu, 6 Aug 1998 14:44:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA41325
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Aug 1998 14:44:39 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07268
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Aug 1998 14:44:35 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z4Xpc-0027nsC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 6 Aug 1998 23:44:20 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z4XpJ-002OmuC; Thu, 6 Aug 98 23:44 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02082;
	Thu, 6 Aug 1998 21:25:52 +0200
Message-ID: <19980806212551.61171@alpha.franken.de>
Date: Thu, 6 Aug 1998 21:25:51 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Takeshi Hakamada <hakamada@nsg.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Compiling kernel on HardHat
References: <19980806161325E.hakamada@nsg.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980806161325E.hakamada@nsg.sgi.com>; from Takeshi Hakamada on Thu, Aug 06, 1998 at 04:13:25PM +0900
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 06, 1998 at 04:13:25PM +0900, Takeshi Hakamada wrote:
> I tried to compile kernel on HardHat using RPM kernel(2.1.100) source,
> I can't build kernel due to following error.
> In arch/mips/sgi/kernel/setup.c, 
> 
> setup.c:18: asm/vector.h: No such file or directory

that's already fixed in the CVS repository. You just have to remove
the #include in setup.c.

> Error message shows that I need to have include/asm/vector.h.
> How can I get vector.h? Do I have to get latest kernel source from
> ftp.linux.sgi.com?

As this should be the only change, you don't need to.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
