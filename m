Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id EAA13102 for <linux-archive@neteng.engr.sgi.com>; Sun, 25 Jan 1998 04:25:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA17415 for linux-list; Sun, 25 Jan 1998 04:22:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA17410 for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 04:22:04 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA29467
	for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 04:22:02 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xwR4D-00286GC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 25 Jan 1998 13:21:37 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xwR41-002OiUC; Sun, 25 Jan 98 13:21 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id MAA02143;
	Sun, 25 Jan 1998 12:47:32 +0100
Message-ID: <19980125124731.10567@alpha.franken.de>
Date: Sun, 25 Jan 1998 12:47:31 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@mailhost.uni-koblenz.de
Cc: Oliver Frommel <oliver@aec.at>, Mike Shaver <shaver@netscape.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <34C6E304.680D7541@netscape.com> <Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at> <19980123045725.54480@uni-koblenz.de> <19980123232420.65169@alpha.franken.de> <19980124141627.19289@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.85
In-Reply-To: <19980124141627.19289@uni-koblenz.de>; from ralf@mailhost.uni-koblenz.de on Sat, Jan 24, 1998 at 02:16:27PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > is there a way to do a raw disk access via ARC firmware ? Mabye we could
> > use some bits from SILO (Sparc Linux Loader) and get ext2fs access this
> > way. 
> 
> That´s one way.  Another would be to do it like the Alpha Milo.

which would be IMHO a real overkill (Alpha Milo is nearly a complete
Linux kernel with some special stuff for bringing up the hardware). It 
makes sense for Alphas as there are ARC only machines out, and the 
ARC PAL code isn't suited for Linux. So you have to replace the PAL code and
after that the ARC firmware isn't able to do anything, so Alpha Milo has 
to boot the kernel itself. To this it needs to access the hardware and
as the Linux drivers has already been available, why not use them ?
Alpha Milo can also be used as the real firmware on some Alpha boards 
(I've flashed Alpha Milo, so my Alpha doesn't see any ARC stuff).
For Mips Milo we don't need to change PAL code change or other strange
stuff and with raw partition access we can do all what we want.

> Raw access should work by accessing something like
> scsi(0)disk(0)rdisk(1)partition(0) or so.  Milo should actually already
> provide all the framework required for easy implementation of ext2fs
> access.

good, I will to some tests:-)

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
