Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA148097 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Dec 1997 14:32:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA26860 for linux-list; Wed, 3 Dec 1997 14:31:36 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA26849 for <linux@engr.sgi.com>; Wed, 3 Dec 1997 14:31:34 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA24793; Wed, 3 Dec 1997 14:31:33 -0800
Date: Wed, 3 Dec 1997 14:31:33 -0800
Message-Id: <199712032231.OAA24793@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <Pine.LNX.3.95.971203161250.15277A-100000@dv123s34.lawrence.ks.us>
References: <199712032119.OAA14390@harmony.village.org>
	<Pine.LNX.3.95.971203161250.15277A-100000@dv123s34.lawrence.ks.us>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Chad Campbell writes:
 > On Wed, 3 Dec 1997, Warner Losh wrote:
 > > But one does have to ask the question of WHY?  What can you get from
 > > an N64 that would make it worth running Linux on it?
 > I don't know much about the N64, but it should have at least two game
 > controller ports for a keyboard and a mouse, and I think I heard that
 > there were storage devices available for it.  With an upgrade to 8 MB, it
 > sounds like it could possibly be made into a cheap NC or WebTV type of
 > product.  Of course, as others have mentioned, any kernel port is valuable
 > at least in the sense that we might learn something new which could aid in
 > the design of kernels for other architectures.

      I have heard of several companies using Linux as a sort of embedded
OS, as would be the case when using it on N64 to build an NC or WebTV device.
One interesting area for development, both in the embedded space, and on
the SGI workstations, would be in regard to realtime support, which is
needed for digital media.  By realtime, I mean not fast interrupt response,
but rather precisely scheduled repetitive events (such as driving the Indy
audio ports every 1 ms. with at most 0.9 ms delay no matter what else is
going on).  
