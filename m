Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA306850 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 15:35:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA24836 for linux-list; Thu, 4 Dec 1997 15:33:05 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA24821; Thu, 4 Dec 1997 15:33:02 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA27062; Thu, 4 Dec 1997 15:33:01 -0800
Date: Thu, 4 Dec 1997 15:33:01 -0800
Message-Id: <199712042333.PAA27062@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: "William J. Earl" <wje@fir.engr.sgi.com>,
        Greg Chesson <greg@xtp.engr.sgi.com>,
        David Chatterton <chatz@omen.melbourne.sgi.com>,
        Lige Hensley <ligeh@carpediem.com>, Chris Carlson <cwcarlson@home.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <19971204230122.18229@uni-koblenz.de>
References: <Pine.SGI.3.96.971204001929.20475A-100000@barramunda>
	<9712041708.ZM8190@omen.melbourne.sgi.com>
	<chatz@omen.melbourne.sgi.com>
	<9712040903.ZM8161@xtp.engr.sgi.com>
	<199712041722.JAA26372@fir.engr.sgi.com>
	<19971204230122.18229@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > Indeed - and you're pointing to what I consider _the_ problem with
 > current Linux kernels.  Linux uses the ``buddy system'' described by
 > Donald Knuth's ``Algorithems And Data Structures'' to maintain it's
 > free pages.  This algorithem results in massive fragmentation even
 > after a short uptime.

     Are you saying that linux uses the buddy system for all of memory,
or just for the kernel heap?  (I would be surprised if it were used
for other than the kernel heap, although that is bad enough.)  

...
 > For my 8mb PC this may mean it will sometime stop NFS serving when
 > nothing else is running at the same time just because the compile I
 > was running before resulted in completly fragmented memory leaving
 > no chunks bigger than a single 4kb page.  Unfortunately there is nothing
 > that 100% prevents this to happen under all circumstances on machines
 > with more memory.  I've seen reports of machines with >128mb of memory
 > having 2mb of free memory left all in 4kb chunks.

      One thing we do in IRIX is to always allocate kernel heap buffers
of 1 page or larger as an integral set of pages, mapped into kernel
virtual space, but not part of the main kernel heap (which is used only
for smaller buffers).  Except for fragmentation of the kernel mapped
space pool (a pool of address space, not real memory), this guarantees
you can always get large buffers if pages are available.  Fragmentation
of smaller buffers of course requires a better heap manager, although
using zone allocation (where a zone has blocks all of the same size,
and there are zones for most popular sizes) helps a lot and is also
faster than using the regular heap manager.

...
 > As far as technical documentation about the O2 goes - does a model like
 > 
 >  - full disclosure of documentation under a NDA to some Linux developers
 >  - the NDA would contain an expiration date, maybe one or two years, after
 >    which the covered information can be disclosed because SGI does no
 >    longer consider nondisclosure a vital for it's bussines.
 >  - disclosure as binaries:
 >    Parts that are considered to be based on information that SGI thinks
 >    should not be disclosed could be made available as binaries.
 >  - disclosure as source code:
 >    This would be drivers for disk/network (as I understand SGI doesn't
 >    consider this part of the O2 to be too valuable) and a part of the
 >    technical details about GFX that allow to implement a reasonable ASCII
 >    console, maybe a simple X server and to spread these components as
 >    source.
 > 
 > sound acceptable?  While I believe we should currently not try to go for
 > an O2 port because we still have same homework to do, I also think it's
 > important that we find a solution that allows Linux to be used on SGI
 > boxes before they can be considered old iron like the Indy.

      We (the SGI people on the list) will have to talk with the
general manager for the O2 platform.  I personally think that would be
ok.  As I mentioned in my earlier message, a lot of the IRIX value
added for O2 is in essentially generic facilities, not in the
device-dependent drivers, and we already tell customers in high level
terms about the overall architecture (such as the unified memory for
graphics and I/O), so there is not much in the hardware documentation
which needs to be treated as a trade secret.  Conceptually, the O2 graphics
pipeline is fully described by the OpenGL reference (software) implementation
and specification, so the hardware value added is in the internals
of the implementation, not in the interface (which is essentially
a large part of the OpenGL pipeline).
