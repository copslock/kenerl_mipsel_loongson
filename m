Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id FAA695159 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 05:46:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA29911 for linux-list; Fri, 27 Feb 1998 05:46:08 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA29894 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 05:46:06 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA25711
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 05:46:05 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup174-3-17.swipnet.se [130.244.174.145]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id NAA04018; Fri, 27 Feb 1998 13:52:25 GMT
Date: Fri, 27 Feb 1998 14:47:48 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <19980226235300.23817@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980227143143.6574D-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 26 Feb 1998 ralf@uni-koblenz.de wrote:

> > System: IP22
> > Processor: 100 Mhz R4000, with FPU
> > Primary I-cache size: 8 kbytes
> > Primary d-cache size: 8 kbytes
> > Secondary cache size: 1024 Kbytes
> 
> So this must be a R4000SC CPU.  The CPU support code for it is buggy, that's
> why it it's working.

It's _not_ working. And I would like to know why it isn't working.  (ok, I
understand what you mean, sorry :)  Well, this is not a big problem for me
anyway. The .68 kernel works. The main problem is the one with the
harddrives (detecting them, but with the size of 0Mb, and the kernel can't
read the partition tables), and the one with the kernel paging request it
can't handle. Any ideas? 

> Fixes probably coming next week; as think are looking I'll have a hell lot
> of time again by then.

Great, next week.. (feels like one year).

/Ulf Carlsson.

-----------------------------------------
-     grimsy - http://grimsy.ml.org     -
-----------------------------------------
