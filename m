Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03152; Wed, 28 May 1997 09:11:07 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA26290 for linux-list; Wed, 28 May 1997 09:10:48 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26282 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 09:10:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA10632 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 09:10:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26192 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 09:10:28 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA08903
	for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 09:10:23 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id RAA06220;
	Wed, 28 May 1997 17:06:05 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id SAA31716; Wed, 28 May 1997 18:03:20 +0200
Message-Id: <199705281603.SAA31716@kernel.panic.julia.de>
Subject: Re: hardware independent hinv
To: ariel@sgi.com
Date: Wed, 28 May 1997 18:03:20 +0200 (MET DST)
Cc: linux@yon.engr.sgi.com
In-Reply-To: <199705281517.IAA10342@yon.engr.sgi.com> from "Ariel Faigon" at May 28, 97 08:17:44 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Just forwarding since it sounds someone hopes that Linux/MIPS
> will some day have a HW independent hinv... - Ariel

Larry has shown me a perl script on his Linux/i386 box which does just
this.  I intend to supply the information required by such a script
via the proc filesystem.

  Ralf

> ----- Forwarded message from Dave Olson -----
> 
> >From olson@anchor  Mon May 12 13:50:21 1997
> Date: Mon, 12 May 1997 13:50:18 -0700
> From: olson@anchor (Dave Olson)
> Message-Id: <199705122050.NAA26767@anchor.engr.sgi.com>
> To: olson@anchor (Dave Olson), scotth@sgi.com
> Subject: Re: missing machfile
> Cc: swmgr@swmgr, breyer@swmgr, ariel@cthulhu
> References: <199705121525.IAA23143@swmgr.engr.sgi.com>
>     <199705121714.KAA23773@anchor.engr.sgi.com>
>     <199705121854.LAA18312@anchor.engr.sgi.com>
> 
> |  I would assume that hinv is hardware-dependent, because of the
> |  mapping issues?  Or is it table driven off of an analogue of the machtab?
> 
> Still all compiled in.  Bug/rfe open for years now about making it table
> driven.
> 
> |  Unfortunately, nothing better is generally available across
> |  platforms and releases.
> 
> Yes, and that's something that would be nice to fix.  Maybe linux will
> do it, and we can copy them.
> 
> |  D> Lots, for any non-trivial app.  They don't have to, but often want to.
> |  
> |  ???  Non-trivial as in "big and powerful", or as in "gets close to
> |  the hardware"?  I would argue that emacs and perl both fit the
> 
> Both/either.  Not all  big apps, of course.
> 
> |  I was looking at the options to uname, specifically "-p".  Based
> |  upon the man page, shouldn't `uname -p` return "mips3" instead of
> |  "mips" for my IP22?  That is one obvious meaning for:

Q: what exactly does that IP?? notation stand for?  Internal model names,
CPU modules, ???

> Yes, but then you break even more of the configure scripts.  Again,
> a no-win situation.

You're absolutely right.  For just that reason I changed the output for
little endian MIPS boxes from mipsel to mips a long time ago though
mipsel is logic when thinking of the generic GNU configuration names.

> |  I was just curious is there was somehow we could make life easier
> |  for configure scripts to port software for IRIX...  On the other
> |  hand, we generally only get bad comments about /bin/install, and at
> |  least we *don't* get comments like:

After the last few days I can say that porting to IRIX is a quite boring
job; most things just work.  Only ssh makes problem.  Solved by using
GCC (snapshot) instead of SGI's cc.

> Using cpp is a horrible solution...

Tell the people who invented imake ...

> |  It is hard to add functionality without breaking stuff.
> 
> A programmer's lament, if I ever heard one!

Or break what's broken ...

  Ralf
