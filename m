Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA22434; Fri, 13 Jun 1997 15:01:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA22967 for linux-list; Fri, 13 Jun 1997 15:01:34 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA22949; Fri, 13 Jun 1997 15:01:31 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA27706; Fri, 13 Jun 1997 15:01:24 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id WAA13633;
	Fri, 13 Jun 1997 22:53:03 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id XAA04791; Fri, 13 Jun 1997 23:52:05 +0200
Message-Id: <199706132152.XAA04791@kernel.panic.julia.de>
Subject: Re: Userland loader / run time loader
To: lm@neteng.engr.sgi.com (Larry McVoy)
Date: Fri, 13 Jun 1997 23:52:05 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, shaver@neon.ingenia.ca,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199706132102.OAA18708@neteng.engr.sgi.com> from "Larry McVoy" at Jun 13, 97 02:02:24 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Can someone give me some info on what has been done or needs to be done to
> have a 100% self hosting Linux development suite on MIPS?  Last I checked,
> it was missing the loader & rld.  Is that still true?  If so, do we know
> why it is hard?  I have someone that may be willing to fix this if it is
> still a problem.  Thanks.

The development suite is fully useable for bootstrapping itself.  Check
the little endian rpm packages on my workstation kernel.panic.julia.de;
they all were built from unchanged RedHat 4.1 source packages and use
shared libraries.

Aside of a possibility to load the kernel from an ext2fs filesystem the
most urgent thing we need currently is debugging, debugging ...

Things look different if we're talking about 64bit.  Last time I checked
with the Kazumoto Koshima who did a 64bit Hurd port to Sony NeWS the
64bit linker was still not what I'd call reliable ...

  Ralf
