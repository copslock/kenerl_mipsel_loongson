Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id IAA01820 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 08:39:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA14741 for linux-list; Wed, 14 Jan 1998 08:35:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA14726 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 08:35:23 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA00579
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 08:35:20 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA07711;
	Wed, 14 Jan 1998 11:38:18 -0500
Date: Wed, 14 Jan 1998 11:38:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: The world's worst RPM
In-Reply-To: <19980114112844.01873@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980114112448.2369D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 14 Jan 1998 ralf@uni-koblenz.de wrote:
> On Wed, Jan 14, 1998 at 01:43:00AM -0500, Alex deVries wrote:
> > I have generated the world's worst RPM for util-linux, which is much
> > needed, since it contains fdisk.
> > I had to kludge some things; util-linux is truly an awful thing.  It
> > contains things like hwclock, which sets the clock on ISA bus only
> > machines.  This is designed only for sparc, alpha and i386 _ONLY_.
> You must be talking about clock.  As I remember hwclock is using some
> /dev/rtc and should be portable.  Anyway, all the world is using the
> same rtc from Dallas Semiconductor, so ...

On closer inspection it's just a matter of doing something like:

#ifdef ISA_BUS
(ISA specific routines that use iopl())
#endif

Yes, it is fixable.

> Suicide doesn't look like a bad alternative to cleaning the diffs.  And
> it's not your fault.  Actually I rememer that somebody already put his
> mental health on the game, there is a glibc patch for util-linux floating
> around.

Yeah.  Those are in the source RPM, and I'm using them.  There's a lot of
#ifdef __SPARC__  or similiar statements that need to be fixed for mips.

I really think this should be broken into multiple packages.

- Alex
