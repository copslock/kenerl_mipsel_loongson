Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id PAA50699 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 15:42:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA00176 for linux-list; Fri, 27 Feb 1998 15:40:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA00155 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 15:40:26 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA13416
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 15:40:25 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup162-3-31.swipnet.se [130.244.162.159]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id XAA11048; Fri, 27 Feb 1998 23:47:04 GMT
Date: Sat, 28 Feb 1998 00:42:15 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <19980227192553.12373@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980228002935.8121A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 27 Feb 1998 ralf@uni-koblenz.de wrote:

> The exact bug is that one of the cache maintenance routines in
> include/asm-mips/r4kcache.h uses there wrong cachop for flushing the
> cache.

Oh.

> > understand what you mean, sorry :)  Well, this is not a big problem for me
> > anyway. The .68 kernel works. The main problem is the one with the
>            
> .68 isn't supposed to work.  The memory is laid out such that the buggy
> cache routine has a bit less of effect.

Hm, ok. But why is .68 on ftp.linux.sgi.com if it doesn't work, or isn't
even supposed to work?

> > harddrives (detecting them, but with the size of 0Mb, and the kernel can't
> > read the partition tables), and the one with the kernel paging request it
> > can't handle. Any ideas? 
> 
> Should all be the cache effect.

Doesn't it work for your?

I have some questions concerning the MIPS/Linux project. I think the FAQ
on the homepage is obsolete (sorry, you must have answered these questions
100 times by now :)

Is it possible to use MIPS/Linux yet, or is it too buggy? How much of the
X code is done? Are any of the SGI special devices, such as the cool
functions on the video card supported yet? Which kernel runs
linux.sgi.com (this one seems to be quite stable).

Maybe I'll join the project (if you allow me to). I don't know if I have
the time right now, quite busy programming for a demo project.

/Ulf Carlsson

-----------------------------------------
-     grimsy - http://grimsy.ml.org     -
-----------------------------------------
