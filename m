Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA466809 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 13:22:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA06540 for linux-list; Tue, 6 Jan 1998 13:22:00 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA06530 for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 13:21:58 -0800
Received: from informatik.uni-koblenz.de ([141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA24183
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 13:21:56 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA22583
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 22:21:51 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id KAA03844;
	Tue, 6 Jan 1998 10:33:03 +0100
Message-ID: <19980106103147.49369@uni-koblenz.de>
Date: Tue, 6 Jan 1998 06:31:47 +0100
To: linux-mips@fnet.fr
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: gcc -shared ... -lc ?
References: <19980106001619.35362@alpha.franken.de> <m0xpMZT-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <m0xpMZT-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Tue, Jan 06, 1998 at 12:08:38AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 06, 1998 at 12:08:38AM +0000, Alan Cox wrote:

> > > This is a binutils 2.7 bug.  Upgrading to 2.8.1 solves the problem.
> > 
> > this is with binutils-2.8.1
> 
> Oh good its not me seeing things. Ralf - could there be two sets of your
> binutils-2.8.1 one working one not and could you maybe post MD5 hashes
> of your binaries you know work ?

Right now I suspect a packaging problem because for me everything is working
fine.  Maybe one of you could verify that it's actually the ld from binutils
2.8.1 that is installed on your systems rsp. contained in the packages you've
used to install?  Check the output of ``ld -v''.

I'll post the MD5 sums later when I return home.

  Ralf
