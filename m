Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA409829 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Jan 1998 15:19:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA14651 for linux-list; Mon, 5 Jan 1998 15:17:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA14639 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 15:17:24 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA09600
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 15:17:23 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xpLlp-0027VZC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 6 Jan 1998 00:17:21 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xpLli-002OhsC; Tue, 6 Jan 98 00:17 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA04549;
	Tue, 6 Jan 1998 00:16:21 +0100
Message-ID: <19980106001619.35362@alpha.franken.de>
Date: Tue, 6 Jan 1998 00:16:19 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: gcc -shared ... -lc ?
References: <19980105184510.65220@alpha.franken.de> <19980105220916.59435@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980105220916.59435@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Jan 05, 1998 at 10:09:16PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > So it looks like the ld for alpha and i386 don't include the whole libc
> > when linked with the comand line above. Any hints ?
> 
> This is a binutils 2.7 bug.  Upgrading to 2.8.1 solves the problem.

this is with binutils-2.8.1

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
