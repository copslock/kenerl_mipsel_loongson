Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA83490 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 10:46:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA08675 for linux-list; Sat, 10 Jan 1998 10:42:11 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA08659 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 10:42:08 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA00790
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 10:42:07 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA13728
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 19:42:05 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA01137;
	Sat, 10 Jan 1998 19:39:04 +0100
Message-ID: <19980110193903.62137@uni-koblenz.de>
Date: Sat, 10 Jan 1998 19:39:03 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: RedHat 5.0 RPMs for SGI...
References: <Pine.LNX.3.95.980109143918.55A-100000@lager.engsoc.carleton.ca> <m0xr5TY-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <m0xr5TY-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Sat, Jan 10, 1998 at 06:17:40PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jan 10, 1998 at 06:17:40PM +0000, Alan Cox wrote:

> > I'm in the middle of churning out the RH 5.0 RPMs, and I'll upload them
> > into a seperate directory on linus than the others. The only difference
> > with these and many of the RPM's already on linus is that they're built
> > against the latest glibc, and they're from the RH 5.0 install, not 4.9.1.
> 
> Ok. I'll work with you on that from Monday. Ive got the fixes for several
> RH5 SRPMS to build with mips.  Glibc 2.0.6 should fix the argv[0] bug
> and the -lbsd problems too so much more should build

That one actually has been fixed months ago in the CVS ...

  Ralf
