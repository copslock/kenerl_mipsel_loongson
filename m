Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA60815 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 14:31:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA11397 for linux-list; Mon, 12 Jan 1998 14:27:35 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA11383 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 14:27:33 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA20974
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 14:27:31 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xrsKJ-0027eoC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 12 Jan 1998 23:27:23 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xrpKi-002OiOC; Mon, 12 Jan 98 20:15 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id TAA00979;
	Mon, 12 Jan 1998 19:37:55 +0100
Message-ID: <19980112193755.38339@alpha.franken.de>
Date: Mon, 12 Jan 1998 19:37:55 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: some glibc issues...
References: <Pine.LNX.3.95.980111174623.26800D-100000@lager.engsoc.carleton.ca> <19980112013541.24300@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980112013541.24300@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Jan 12, 1998 at 01:35:41AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > - exactly what's wrong with using -lbsd now?
> 
> It simply doesn't exist anymore.  RedHat on kludges things by making
> libbsd.a a link to libbsd-compat.a.  That's a broken attempt to keep
> Makefiles alive because -D_BSD_SOURCE needs to be added to CFLAGS for
> BSD code anyway ...

but that's not enough for getpgrp and getpgrp. These function have
different arguments in *BSD.

> > - why does sys/mount.h have no MS_ defines in it now?
> 
> Duh?  It does have them ...

really ? 

[root@mips sys]# grep MS_ /usr/include/sys/mount.h 
[root@mips sys]# 

Not in my sys/mount.h.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
