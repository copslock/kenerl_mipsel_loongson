Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA496402 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Nov 1997 17:46:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA14080 for linux-list; Thu, 27 Nov 1997 17:43:19 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA14075; Thu, 27 Nov 1997 17:43:12 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA10319; Thu, 27 Nov 1997 17:43:10 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA17773;
	Fri, 28 Nov 1997 02:43:08 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA08848;
	Fri, 28 Nov 1997 00:47:06 +0100
Message-ID: <19971128004706.49234@uni-koblenz.de>
Date: Fri, 28 Nov 1997 00:47:06 +0100
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
Cc: David Kostal <kron@informatics.muni.cz>,
        SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Problems with booting SGI/Linux
References: <199711271811.TAA11711@anxur.fi.muni.cz> <199711272254.OAA27112@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <199711272254.OAA27112@oz.engr.sgi.com>; from Ariel Faigon on Thu, Nov 27, 1997 at 02:54:20PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Nov 27, 1997 at 02:54:20PM -0800, Ariel Faigon wrote:

> Could someone help David on this ?
> Is this a R4600 PC vs SC thing ?
> A known hardware bug in R4600 PC ?

> :Hallo,
> :I've tried to run sgi/linux on our INDY/R4600PC 100MHz, but I was
> :unable to boot the kernel. I used kernel from
> :test/vmlinux-970916-efs.gz . The booting process stoped after while. 
> :I use this kernel, because I wasn't able to cross-compile my own
> :kernel.
> :I send you the messages (handly) rewriten from the console. Can you,
> :please, lat me know, where was problem? If you wil need more info or
> :more tests on my Indy, I will do it.

> :PROMLIB: SGI ARCS firmware Version1 Revision 10
> :PROMLIB: Total free ram 31502336 bytes (...)
> :ARCH: SGI-IP22
> :CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
> :Loading R4000 MNV routines
> :CPU revision is: 00002020
                        ^^^^
That's a R4600 V2.0.  The kernel sources/binaries on Linus don't handle
the silicon bugs of this beast correctly.  I fixed the problem this
morning testing them on a SNI RM200.  For a proof of the test I compiled
X a couple of times; the box now looks stable even under high load.  Will
commit the bug fixes shortly.

The Indy actually seems to show the problem somewhere during or after the
initialisation of the serial driver but by my experience this CPU bug
causes all sorts of symptoms indicating everything else ...

  Ralf
