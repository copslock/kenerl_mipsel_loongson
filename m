Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id UAA603766 for <linux-archive@neteng.engr.sgi.com>; Wed, 7 Jan 1998 20:41:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA16476 for linux-list; Wed, 7 Jan 1998 20:37:51 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16467 for <linux@engr.sgi.com>; Wed, 7 Jan 1998 20:37:42 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA09868
	for <linux@engr.sgi.com>; Wed, 7 Jan 1998 20:37:40 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-05.uni-koblenz.de [141.26.249.5])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA10952
	for <linux@engr.sgi.com>; Thu, 8 Jan 1998 05:37:38 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA07154;
	Wed, 7 Jan 1998 20:30:18 +0100
Message-ID: <19980107202902.00124@uni-koblenz.de>
Date: Wed, 7 Jan 1998 20:29:02 +0100
To: "K." <conradp@cse.unsw.edu.au>
Cc: "Andrew John O'Brien" <andrewo@cse.unsw.edu.au>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: r4600 no L2 cache kernel
References: <19980107061739.06864@uni-koblenz.de> <Pine.GSO.3.95.980107162404.25951L-100000@bell07.orchestra.cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.GSO.3.95.980107162404.25951L-100000@bell07.orchestra.cse.unsw.EDU.AU>; from K. on Wed, Jan 07, 1998 at 04:45:18PM +1100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 07, 1998 at 04:45:18PM +1100, K. wrote:

> > I'm currently extremly overloaded by my job.  Let me see if I can find
> > time to do something for your before the weekend.
> 
> thanks for the tip about patching the stock FSF binutils-2.8.1 - we
> managed to get a kernel compiled without ld errors (as of about half an
> hour ago) and now we're trying to get it to boot with the installer etc.
> (It booted via bootp until some nfs errors, without going into a spin or
> panic, so all is looking good - we're seeing if we can get it to boot
> straight of disk before reconfiguring nfs, as we'll need to boot of disk
> eventually...)
> 
> Hopefully then we should be able to get it booting ourselves shortly.
> Thanks for the offer, we'll be sure to let you know if we screw up and
> need to make use of it!

Btw, I took a closer look at the warnings that your binutils were
generating.  As it looks all binutils 2.x MIPS assemblers so far have the 
bug that they mark the symbolic reference to a undefined function as
a reference to data.  Your new linker now throws warnings for this.

Don't worry about this bug, it shouldn't have any effect.  The bug that
was actually crashing the kernel when built with your linker version
must be something else.

  Ralf
