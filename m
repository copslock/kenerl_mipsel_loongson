Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA638643 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 13:48:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA25551 for linux-list; Thu, 26 Feb 1998 13:46:07 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA25531 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 13:46:05 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA08382
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 13:46:04 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0y8B7x-0027cnC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 26 Feb 1998 22:46:01 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0y8B7l-002OuHC; Thu, 26 Feb 98 22:45 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA01653;
	Thu, 26 Feb 1998 22:42:54 +0100
Message-ID: <19980226224253.20580@alpha.franken.de>
Date: Thu, 26 Feb 1998 22:42:53 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Ulf Carlsson <grimsy@varberg.se>, linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <Pine.LNX.3.96.980226120308.3903B-100000@calypso.saturn> <199802261734.JAA25332@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <199802261734.JAA25332@fir.engr.sgi.com>; from William J. Earl on Thu, Feb 26, 1998 at 09:34:05AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> As I understand it, the currently checked-in source must be recompiled
> to provide R4600/R5000 PC and SC versions for Indy, and those versions
> may not be fully tested on all R4000 and R4400 revisions.  In the not
> distant future, a single kernel will likely support all the processors,
> as does the IRIX kernel, but that is more work than just selecting
> the processor type at compile time.

the R4000PC part of the .72 current works at least on my Magnum clone. But
I've got an error report, that my kernel doesn't work on a Magnum with a
R4000SC. So I guess it's really related to the processor handling in the
kernel.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
