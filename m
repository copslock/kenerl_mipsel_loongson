Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA60836 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 14:30:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA11416 for linux-list; Mon, 12 Jan 1998 14:27:38 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA11406 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 14:27:37 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA20992
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 14:27:35 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xrsKF-0027efC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 12 Jan 1998 23:27:19 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xrpKi-002OiNC; Mon, 12 Jan 98 20:15 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id TAA00995;
	Mon, 12 Jan 1998 19:56:23 +0100
Message-ID: <19980112195622.35682@alpha.franken.de>
Date: Mon, 12 Jan 1998 19:56:22 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: "K." <conradp@cse.unsw.edu.au>, linux@cthulhu.engr.sgi.com
Subject: Re: crtbegin.o, crtend.o
References: <Pine.GSO.3.95.980112161052.11350F-100000@l4-00.orchestra.cse.unsw.EDU.AU> <19980112095804.26411@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980112095804.26411@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Jan 12, 1998 at 09:58:04AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > um... can anyone point out where these files can be obtained? In our
> > recent install, (Indy R4600) made from the root-be-0.01 root filesystem
> > with the recent binutils-2.8.1-2, they are missing. We hacked out dummy
> > object files (crtbegin has a __main() which calls main() and crtend is
> > empty) and we can successfully compile simple programs; but before we turn
> > our attention to compiling nastier pieces of code we would like to check
> > that we have not tainted our /usr/lib :)
> 
> Upgrade your system with all the rpm packages.  root-0.01 was my first
> collection of Indy executables and basically_every_ ELF file has bugs in
> it ...

but at least with the little endian gcc rpm you want get crtbegin.o and
crtend.o, because they are missing. Neither x86, alpha nor sparc have such
files (at least not in gcc), so they are missing from the redhat .spec file.
Sorry for the late bug report.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
