Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id MAA455825 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 12:19:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA20494 for linux-list; Tue, 6 Jan 1998 12:18:30 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA20485 for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 12:18:28 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA05804
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 12:18:26 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xpfSB-0027YbC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 6 Jan 1998 21:18:23 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xpfRx-002Og1C; Tue, 6 Jan 98 21:18 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA01497;
	Tue, 6 Jan 1998 21:11:54 +0100
Message-ID: <19980106211154.11378@alpha.franken.de>
Date: Tue, 6 Jan 1998 21:11:54 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: gcc -shared ... -lc ?
References: <19980105184510.65220@alpha.franken.de> <19980105220916.59435@uni-koblenz.de> <19980106001619.35362@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980106001619.35362@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Jan 06, 1998 at 12:16:19AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 06, 1998 at 12:16:19AM +0100, Thomas Bogendoerfer wrote:
> > > So it looks like the ld for alpha and i386 don't include the whole libc
> > > when linked with the comand line above. Any hints ?
> > 
> > This is a binutils 2.7 bug.  Upgrading to 2.8.1 solves the problem.
> 
> this is with binutils-2.8.1

Ok, I've found the problem. The installed binutils are 2.8.1, but the
binutils gcc used were 2.7. They got used by gcc, because they were in
/usr/mipsel-linux/bin. I've removed them and all works fine now.

Sorry for the false alarm.

Thomas.


-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
