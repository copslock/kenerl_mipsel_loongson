Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA135275 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 05:58:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA13707 for linux-list; Mon, 24 Nov 1997 05:56:21 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA13693 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 05:56:19 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA21013
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 05:56:14 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
From: ralf@lappi.waldorf-gmbh.de
Received: from lappi.waldorf-gmbh.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA00935
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 14:55:41 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id OAA14335;
	Mon, 24 Nov 1997 14:18:04 +0100
Message-ID: <19971124141804.17724@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 14:18:04 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: Libc in CVS
References: <19971124120549.01585@lappi.waldorf-gmbh.de> <m0xZwiw-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xZwiw-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Mon, Nov 24, 1997 at 11:30:41AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Nov 24, 1997 at 11:30:41AM +0000, Alan Cox wrote:
> > > With luck it'll also fix the rpm-2.4.8 core dump bug which seems to be
> > > bad linking.
> > 
> > My rpm has never dumped core but it was complaining about nonexisting
> > users while creating the binary rpm file even though the user was
> > existing thus failing to build.  That rpm problem is fixed.
> 
> Yep thats the bug - I also got some crashes. It was caused by getpw* failing
> in peculiar ways. My RPM binary has its own 

For rpm the trick is easy, just don't use a static linked binary.
Unfortunately the Redhat guys seem to think static binaries are a good
idea and install a static rpm by default.  Which it is not, not even
without a buggy dynamic linker.

> > All the source RPM packages on linus are known to build and work for
> > little endian targets.  Some of them, for example ncompress, have special
> > modifications to support big endian targets.
> 
> Im actually trying to build a full RedHat 5.0 by early December so Im picking
> up your changes to stuff like bash indirectly via redhat on the whole. I can
> then merge anything that escaped and together we can make sure they are in 
> RH5.1.

Ok.  I stopped communicating with the Redhat guys shortly before I left the
US.  Essentially they received a part of the patches that I don't classify
as ugly hacks or work in progress.

Some more packages like the binutils, gcc or libc are based on different
versions and we should try to base our work on the same versions as Redhat
does.

> Obviously as of about Dec1 the amount of answers I can get from RedHat will
> noise dive for a couple of months

:-)

  Ralf
