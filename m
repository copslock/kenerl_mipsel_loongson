Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id PAA49057 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 15:22:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA22307 for linux-list; Fri, 27 Feb 1998 15:20:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA22302 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 15:20:35 -0800
Received: from uni-koblenz.de (praia.bofh.de [195.78.185.18]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA26129
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 15:20:27 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA01455;
	Fri, 27 Feb 1998 19:25:54 +0100
Message-ID: <19980227192553.12373@uni-koblenz.de>
Date: Fri, 27 Feb 1998 19:25:53 +0100
To: Ulf Carlsson <grimsy@varberg.se>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <19980226235300.23817@uni-koblenz.de> <Pine.LNX.3.96.980227143143.6574D-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980227143143.6574D-100000@calypso.saturn>; from Ulf Carlsson on Fri, Feb 27, 1998 at 02:47:48PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Feb 27, 1998 at 02:47:48PM +0100, Ulf Carlsson wrote:

> > > System: IP22
> > > Processor: 100 Mhz R4000, with FPU
> > > Primary I-cache size: 8 kbytes
> > > Primary d-cache size: 8 kbytes
> > > Secondary cache size: 1024 Kbytes
> > 
> > So this must be a R4000SC CPU.  The CPU support code for it is buggy, that's
> > why it it's working.
> 
> It's _not_ working. And I would like to know why it isn't working.  (ok, I

The exact bug is that one of the cache maintenance routines in
include/asm-mips/r4kcache.h uses there wrong cachop for flushing the
cache.

> understand what you mean, sorry :)  Well, this is not a big problem for me
> anyway. The .68 kernel works. The main problem is the one with the
           
.68 isn't supposed to work.  The memory is laid out such that the buggy
cache routine has a bit less of effect.

> harddrives (detecting them, but with the size of 0Mb, and the kernel can't
> read the partition tables), and the one with the kernel paging request it
> can't handle. Any ideas? 

Should all be the cache effect.

> > Fixes probably coming next week; as think are looking I'll have a hell lot
> > of time again by then.
> 
> Great, next week.. (feels like one year).

Next week starts tonite.  Linux/MIPS industries going back online ...

  Ralf  (Getting coffee and milk ...)
