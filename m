Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id MAA507933 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Jan 1998 12:52:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA27221 for linux-list; Thu, 29 Jan 1998 12:49:53 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA27214 for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 12:49:51 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA15319
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 12:49:49 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xy0u8-0027lnC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 29 Jan 1998 21:49:44 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xy0tr-002Oj9C; Thu, 29 Jan 98 21:49 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA01922;
	Thu, 29 Jan 1998 21:27:05 +0100
Message-ID: <19980129212705.29618@alpha.franken.de>
Date: Thu, 29 Jan 1998 21:27:05 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: strange problem with my oli M700
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm trying to read the firmware prom of my Olivetti M700 (Magnum 4000 clone).
When access the address 0x9fc00000 (which is the KSEG0 address of the prom)
the box freezes immidiately. Does anybody know why ? And how could I access
the prom otherwise ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
