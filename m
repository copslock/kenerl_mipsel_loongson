Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA02675; Mon, 16 Jun 1997 10:34:24 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA18180 for linux-list; Mon, 16 Jun 1997 10:34:01 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA18166 for <linux@engr.sgi.com>; Mon, 16 Jun 1997 10:33:58 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA14313; Mon, 16 Jun 1997 10:33:59 -0700
Date: Mon, 16 Jun 1997 10:33:59 -0700
Message-Id: <199706161733.KAA14313@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Userland loader / run time loader
In-Reply-To: <199706140312.WAA17152@athena.nuclecu.unam.mx>
References: <Pine.LNX.3.95.970613194626.15021G-100000@lager.engsoc.carleton.ca>
	<199706140312.WAA17152@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > > To address the needs of us lowly folk who have fewer than 2 MIPS boxes[1],
 > > which endian are we going to be supporting first?  It would be _very_
 > > pleasant to be able to run all these binaries that Ralf has prepared. 
 > 
 > Some time ago, someone mentioned that making the kernel support both
 > big endian and little endian binaries in RISC/os consumed too much of
 > their time. 
 >
 > The time we will spend trying to get this bloating hack into the
 > kernel could be easily spent on some more productive things.  

     I reported on the RISC/os experience.  It wasn't so much that it
took too much time, but rather that it was hard to support on the SVR3
kernel interface, due to the messy definition of the streams interface
at the system call level.  It is much easier if you can assume only
dynamically linked binaries, as in SVR4, and you can do much (although
not all) of the work in user mode, and much of the rest of the work
can happen as a side-effect of copyin/copyout.

 > I will put together a root file system and a bunch of rpms soonish
 > (ie, that is, as soon as I boot my Indy into Linux).

     That is clearly more expedient than trying to do bi-endian binary
support.  Once the source-level endian issues are resolved (and most
should already be resolved in any GNU sources), having both litte-
and big-endian binaries and file systems is fairly simple.
