Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id PAA53271 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 15:58:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA05310 for linux-list; Fri, 27 Feb 1998 15:58:10 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA05284 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 15:58:05 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA21907
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 15:58:04 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id AAA10056;
	Sat, 28 Feb 1998 00:58:02 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA03598; Sat, 28 Feb 1998 00:58:00 +0100
Message-ID: <19980228005759.07317@uni-koblenz.de>
Date: Sat, 28 Feb 1998 00:57:59 +0100
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grimsy@varberg.se>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <19980227192553.12373@uni-koblenz.de> <Pine.LNX.3.96.980228002935.8121A-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.980228002935.8121A-100000@calypso.saturn>; from Ulf Carlsson on Sat, Feb 28, 1998 at 12:42:15AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Feb 28, 1998 at 12:42:15AM +0100, Ulf Carlsson wrote:

> On Fri, 27 Feb 1998 ralf@uni-koblenz.de wrote:
> 
> > The exact bug is that one of the cache maintenance routines in
> > include/asm-mips/r4kcache.h uses there wrong cachop for flushing the
> > cache.
> 
> Oh.
> 
> > > understand what you mean, sorry :)  Well, this is not a big problem for me
> > > anyway. The .68 kernel works. The main problem is the one with the
> >            
> > .68 isn't supposed to work.  The memory is laid out such that the buggy
> > cache routine has a bit less of effect.
> 
> Hm, ok. But why is .68 on ftp.linux.sgi.com if it doesn't work, or isn't
> even supposed to work?

It's only supposed to fail for your configuration.

> > > harddrives (detecting them, but with the size of 0Mb, and the kernel can't
> > > read the partition tables), and the one with the kernel paging request it
> > > can't handle. Any ideas? 
> > 
> > Should all be the cache effect.
> 
> Doesn't it work for your?

Since I'm doing the thing it will always work for my hardware (hint, hint ...)

> I have some questions concerning the MIPS/Linux project. I think the FAQ
> on the homepage is obsolete (sorry, you must have answered these questions
> 100 times by now :)
> 
> Is it possible to use MIPS/Linux yet, or is it too buggy? How much of the

It's good for month of uptime.  Some apps are not that reliable.

> X code is done? Are any of the SGI special devices, such as the cool
> functions on the video card supported yet? Which kernel runs

Linux supports what god wanted to be supported, text mode :-)

> linux.sgi.com (this one seems to be quite stable).

It's called IRIX :-)

(And yes, the machine had over half a year uptime.  The IRIX developers on
the list will apreciate your praise :-)

  Ralf
