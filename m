Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id CAA05968 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 02:32:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA00761 for linux-list; Wed, 14 Jan 1998 02:32:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA00757 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 02:32:00 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA14667
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 02:31:55 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id LAA13033
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 11:31:51 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA04742;
	Wed, 14 Jan 1998 11:28:44 +0100
Message-ID: <19980114112844.01873@uni-koblenz.de>
Date: Wed, 14 Jan 1998 11:28:44 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: The world's worst RPM
References: <Pine.LNX.3.95.980114013153.10190J-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980114013153.10190J-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jan 14, 1998 at 01:43:00AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 01:43:00AM -0500, Alex deVries wrote:

> I have generated the world's worst RPM for util-linux, which is much
> needed, since it contains fdisk.
> 
> I had to kludge some things; util-linux is truly an awful thing.  It
> contains things like hwclock, which sets the clock on ISA bus only
> machines.  This is designed only for sparc, alpha and i386 _ONLY_.

You must be talking about clock.  As I remember hwclock is using some
/dev/rtc and should be portable.  Anyway, all the world is using the
same rtc from Dallas Semiconductor, so ...

> Anyway, I kludged it into compiling, but I really had to guess on the
> parameters for the disk operations.  Fdisk compiles and works, but I can't
> really test it as I need both disks on my system.  Could somebody give it
> a try?
> 
> Also, it has things like more , write and mkswap. Yay! I now have swap
> space!
> 
> So, give it a try, or clean up my diff files.

Suicide doesn't look like a bad alternative to cleaning the diffs.  And
it's not your fault.  Actually I rememer that somebody already put his
mental health on the game, there is a glibc patch for util-linux floating
around.

  Ralf
