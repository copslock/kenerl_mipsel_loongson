Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA16808; Thu, 19 Jun 1997 12:24:47 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA19257 for linux-list; Thu, 19 Jun 1997 12:23:53 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA19245 for <linux@engr.sgi.com>; Thu, 19 Jun 1997 12:23:51 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id MAA11531; Thu, 19 Jun 1997 12:23:50 -0700
Date: Thu, 19 Jun 1997 12:23:50 -0700
Message-Id: <199706191923.MAA11531@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Good news: no more begging for HW
In-Reply-To: <199706180032.CAA10448@informatik.uni-koblenz.de>
References: <9706171715.ZM15632@sgi.com>
	<199706180032.CAA10448@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > > Probably the first thing to do would be to get the go ahead for a proof of
 > > concept only (under NDA) probably using an old indy. If this proves impossible
 > > from either the technical or political pov's then we need to re-think.
 > > 
 > > I personaly don't think we have much chance unless we go to NDA and even then
 > > its going to be really hard to get buy-in.
 > 
 > I guess a workable model for the current technology like O2 etc. would be
 > that SGI gives documentation out under NDA to the developer(s).  After
 > a certain time (I think about 18 month or two years) after which a product
 > generation is obsoleted by successors the source and hopefully even the
 > documentation may be published freely.
...

    O2 is actually simpler.  We would have to document how to set up
the display engine (which copies the frame buffer to the screen), but,
since O2 is UMA, a purely software X rendering engine will work just
fine.  I doubt there will be much concern about X, and the software
OpenGL reference implementation is widely available.  I believe that
most internal concerns are about the optimized hardware-dependent GL
implementations, where software advances are a competitive issue.
(For example, we just released an updated set of GL libraries for O2
which increased performance by 30% on the same hardware.)  In that
case, since the graphics pipeline is conceptually the same on all our
platforms, the optimized algorithms do not become obsolete, just
because a particular product is obsolete.

    I expect that there is room for a reasonable compromise here, without
having to get into the complications of NDAs and the like, given that
the initial goal, at least, is to get a simple X port done.
