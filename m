Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id UAA658892 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 Nov 1997 20:31:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA00688 for linux-list; Sat, 29 Nov 1997 20:24:03 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA00684 for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 20:24:01 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA20962
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 20:23:59 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-24.uni-koblenz.de [141.26.249.24])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA27582
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 05:23:57 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA15206;
	Sun, 30 Nov 1997 01:25:56 +0100
Message-ID: <19971130012555.40529@uni-koblenz.de>
Date: Sun, 30 Nov 1997 01:25:55 +0100
To: Michael Hill <mike@mdhill.tor.hookup.net>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Problems with booting SGI/Linux
References: <9711291503.ZM1726@mdhill.tor.hookup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <9711291503.ZM1726@mdhill.tor.hookup.net>; from Michael Hill on Sat, Nov 29, 1997 at 03:03:47PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Nov 29, 1997 at 03:03:47PM -0500, Michael Hill wrote:

> > > :PROMLIB: SGI ARCS firmware Version1 Revision 10
> > > :PROMLIB: Total free ram 31502336 bytes (...)
> > > :ARCH: SGI-IP22
> > > :CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
> > > :Loading R4000 MNV routines
> > > :CPU revision is: 00002020
> >                         ^^^^
> 
> Ditto (for the most part).
> 
> > That's a R4600 V2.0.  The kernel sources/binaries on Linus don't handle
> > the silicon bugs of this beast correctly.  I fixed the problem this
> > morning testing them on a SNI RM200.  For a proof of the test I compiled
> > X a couple of times; the box now looks stable even under high load.  Will
> > commit the bug fixes shortly.

Bad luck, my box is still not stable even though this bug has been fixed.

> This is a huge relief since I didn't know what to try next (haven't been able
> to compile a kernel).  Ralf,  where can I access your committed bug fixes?
> Any chance of someone posting a compiled kernel incorporating these to
> ftp.linux.sgi.com?

I'm working on it.  There are several issues that will take me a couple
of days to work them out.  My two main projects are

 - rebuilding RedHat 4.9.1 for big endian MIPS (like the Indy).  This is
   the most urgent part and I'm working (well, my Indy ...) on it.
 - my kernel tree has diverged significantly from what were publishing
   on Linus.  Have to merge them both.

You can usually get the bugfixes from the kernel sources/binaries available
on Linus.  The last one is a bit old, though ...

  Ralf
