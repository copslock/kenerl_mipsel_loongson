Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA543990 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Jan 1998 16:05:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA29344 for linux-list; Thu, 29 Jan 1998 16:02:47 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA29339 for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 16:02:46 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA06445
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 16:02:45 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xy3us-0027e9C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 30 Jan 1998 01:02:42 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xy3um-002Oj6C; Fri, 30 Jan 98 01:02 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02373;
	Fri, 30 Jan 1998 00:00:33 +0100
Message-ID: <19980130000032.48964@alpha.franken.de>
Date: Fri, 30 Jan 1998 00:00:32 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: strange problem with my oli M700
References: <19980129212705.29618@alpha.franken.de> <19980129221750.18001@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980129221750.18001@uni-koblenz.de>; from ralf@uni-koblenz.de on Thu, Jan 29, 1998 at 10:17:50PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jan 29, 1998 at 10:17:50PM +0100, ralf@uni-koblenz.de wrote:
> On Thu, Jan 29, 1998 at 09:27:05PM +0100, Thomas Bogendoerfer wrote:
> 
> > I'm trying to read the firmware prom of my Olivetti M700 (Magnum 4000 clone).
> > When access the address 0x9fc00000 (which is the KSEG0 address of the prom)
> > the box freezes immidiately. Does anybody know why ? And how could I access
> > the prom otherwise ?
> 
> Did you try uncached accesses via KSEG1?  I wouldn't wonder if the used
> PROMs can't cope with the bursts generated for filling a cacheline.

uncached access works. Thanks.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
