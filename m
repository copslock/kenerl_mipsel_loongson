Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id MAA630549 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 Nov 1997 12:07:48 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA25461 for linux-list; Sat, 29 Nov 1997 12:04:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA25448 for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 12:04:34 -0800
Received: from mdhill.tor.hookup.net (mdhill.tor.hookup.net [165.154.15.186]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA20558
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 12:04:30 -0800
	env-from (mike@mdhill.tor.hookup.net)
Received: (from mike@localhost) by mdhill.tor.hookup.net (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA01728 for linux@cthulhu.engr.sgi.com; Sat, 29 Nov 1997 15:03:48 -0500
From: "Michael Hill" <mike@mdhill.tor.hookup.net>
Message-Id: <9711291503.ZM1726@mdhill.tor.hookup.net>
Date: Sat, 29 Nov 1997 15:03:47 -0500
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Problems with booting SGI/Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>
> > :PROMLIB: SGI ARCS firmware Version1 Revision 10
> > :PROMLIB: Total free ram 31502336 bytes (...)
> > :ARCH: SGI-IP22
> > :CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
> > :Loading R4000 MNV routines
> > :CPU revision is: 00002020
>                         ^^^^

Ditto (for the most part).

> That's a R4600 V2.0.  The kernel sources/binaries on Linus don't handle
> the silicon bugs of this beast correctly.  I fixed the problem this
> morning testing them on a SNI RM200.  For a proof of the test I compiled
> X a couple of times; the box now looks stable even under high load.  Will
> commit the bug fixes shortly.

This is a huge relief since I didn't know what to try next (haven't been able
to compile a kernel).  Ralf,  where can I access your committed bug fixes?  Any
chance of someone posting a compiled kernel incorporating these to
ftp.linux.sgi.com?

Thanks,

Mike

--
Michael Hill
Toronto, Canada
mdhill@hookup.net
