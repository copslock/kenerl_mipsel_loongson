Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA243237 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 09:23:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA23407 for linux-list; Thu, 4 Dec 1997 09:22:19 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA23375; Thu, 4 Dec 1997 09:22:14 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA26372; Thu, 4 Dec 1997 09:22:12 -0800
Date: Thu, 4 Dec 1997 09:22:12 -0800
Message-Id: <199712041722.JAA26372@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Greg Chesson" <greg@xtp.engr.sgi.com>
Cc: "David Chatterton" <chatz@omen.melbourne.sgi.com>,
        Lige Hensley <ligeh@carpediem.com>, Chris Carlson <cwcarlson@home.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <9712040903.ZM8161@xtp.engr.sgi.com>
References: <Pine.SGI.3.96.971204001929.20475A-100000@barramunda>
	<9712041708.ZM8190@omen.melbourne.sgi.com>
	<chatz@omen.melbourne.sgi.com>
	<9712040903.ZM8161@xtp.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Greg Chesson writes:
 > I've been reading the O2 thread with great interest.
 > 
 > It seems to me that a "vanilla" port of Linux on the O2 is quite feasible.
 > Several writers have agreed.
 > 
 > But full support in Linux for extremem platform-dependent multimedia
 > hardware is problematic.  This has also been mentioned by several writers,
 > some of whom developed the OS code.  The problems are twofold: it would
 > be a non-trivial task even with full documentation to provide complete
 > support for O2 hardware since the job would require as much new invention
 > as it would require porting, and second- full disclosure
 > of the inner workings is viewed as too much of a giveaway to present
 > and future competitors.
 > 
 > Makes me wonder whether the Indy port of Linux could be ratcheted into
 > a vanilla port for the O2, and then perhaps SGI could produce binary
 > loadable drivers for the missing bits.

      For IRIX, most of the O2 work was really in areas which, in
linux, would be reasonably general purpose.  In particular, being able
to allocate large pages (64 KB tiles on O2) at any time, no matter how
long the system has been running, was a major change, and would be
useful for performance reasons on any system with variable page size,
since it helps ordinary programs with large address spaces on
large-memory systems, as well as supporting the O2 graphics and
digital media.  Similarly, having solid time-scheduled realtime
support is broadly useful.  For digital media, one needs a reasonably
portable API, and applications on top of it, which supports high
performance.  With those facilities in hand, doing the drivers is not
all that difficult.  Providing those facilities, however, is a substantial
project, and not especially tied to SGI hardware.

     In graphics, if linux winds up with an IRIX-compatible kernel
graphics driver on some SGI boxes, the IRIX Xsgi, libgl.so, and
libGL.so platform-specific binaries could run on linux.  Note that
each of our systems comes with a license for the then-current version
of these components, so loading linux does not preclude using the IRIX
components, although, at present, they may not be shipped in a linux
distribution.  Since they are only useful on SGI hardware, perhaps SGI
could make arrangements to permit "stable" binaries to be included in
linux distributions for selected platforms.
