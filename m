Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA05422 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 14:35:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA12222 for linux-list; Tue, 2 Dec 1997 14:33:54 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA12198; Tue, 2 Dec 1997 14:33:52 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA05434; Tue, 2 Dec 1997 14:33:41 -0800
Date: Tue, 2 Dec 1997 14:33:41 -0800
Message-Id: <199712022233.OAA05434@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: cypher <cypher@vertigo.cs.indiana.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <19971202231009.32146@grass.uni-koblenz.de>
References: <Pine.LNX.3.95.971202161948.10955B-100000@vertigo.cs.indiana.edu>
	<19971202231009.32146@grass.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > On Tue, Dec 02, 1997 at 04:50:40PM -0500, cypher wrote:
...
 > Actually aside of the Linux developers like me there are also SGI engineers
 > interested in Linux as well as some ties on this list, so posting here was
 > a right thing to do.

      I am one of the SGI engineers, and I would like to be able to release
the O2 specifications.  Releasing the Indy specifications basically happened
when we had started shipping O2, and the Indy was thus obsolete as a hardware
product.  I expect it would be easy to get approval when O2 is no longer
shipping, but doing it now will take some persuasion.

 > I can well imagine that way can be found under which an O2 port could become
 > reality.  It's probably most important that customers (== $$$) ask for Linux
 > for their boxes and that word has to spread upto the higher managment.

       This is precisely correct.  If enough large customers ask for it,
it will happen.  The problem so far has been persuading management that
very many people would consider SGI boxes with Linux.  Part of the
problem is that a simple Linux port leaves much of the special features
of the SGI system unused, and really exploiting the graphics and digital
media features is a major project, when SGI already has too many projects
underway.  

 > > Right now I am basically in position (not officially supported by the
 > > university of course, but there not telling me not to do it either, if you
 > > know what I mean) where I've been given and Indy and an O2 to work on
 > > porting Linux while on the clock.
 >
 > I suggest to work on the Indy.  There is Indy code that just needs a bit of
 > polishing and debugging, but essentially we're relativly close.  Working for
 > the O2 would mean that you'll aside of a bigger technical task you'll also
 > have to solve a political problem.

      O2 is also a bigger technical problem, even with specifications in hand.
The drivers are actually easier than for Indy, but really exploiting the
O2 capabilities in graphics and digital media required a lot of enhancements
to the memory management, since O2 is a UMA system.  You could do a dumb
port, with a fixed frame buffer size, but then most of the O2 is wasted.
