Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA106000 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Dec 1997 10:06:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA26437 for linux-list; Wed, 3 Dec 1997 10:00:27 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA26320; Wed, 3 Dec 1997 10:00:14 -0800
Received: from vertigo.cs.indiana.edu (vertigo.cs.indiana.edu [129.79.243.150]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA27542; Wed, 3 Dec 1997 10:00:02 -0800
	env-from (cypher@vertigo.cs.indiana.edu)
Received: from localhost (cypher@localhost)
	by vertigo.cs.indiana.edu (8.8.5/8.8.5) with SMTP id NAA15179;
	Wed, 3 Dec 1997 13:28:33 -0500
Date: Wed, 3 Dec 1997 13:28:33 -0500 (EST)
From: cypher <cypher@vertigo.cs.indiana.edu>
To: John Wiederhirn <jwiede@blammo.engr.sgi.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <9712021646.ZM11626@blammo.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.971203132017.15095A-100000@vertigo.cs.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Tue, 2 Dec 1997, John Wiederhirn wrote:

> As I've commented before, the problem isn't so much in getting the
> kernel working (and working quickly).  The problem comes the second
> you need to deal with graphics.  Given the O2's onboard multimedia
> hardware, the situation only gets more complex.
> 
> Right now, there is no effective hardware abstraction mechanism in
> Linux for graphics/multimedia.  With the Indy's rather simple gfx
> capabilities, that isn't a tremendous hardship.  The hardship comes
> when you are managing things like graphics pipelines, or hardware
> that has very specific requirements for memory allocation and
> alignment (and access).  Many of the necessary pieces simply do not
> currently exist in the Linux kernel services.

I would definately agree here, but don't get me wrong. I'm not looking for
a quick solution. I think part of what makes Linux so great is that when
it does get ported to a new platform, the kernel learns something new.
What I mean is that by porting to the 02 and allowing Linux to develope a 
good "hardware abstraction mechanism" or better memory management or the
various other internals that allow it to run well on an 02 would also give
Linux as UNIX an advantage over the other UNIXes that only run on one or
two platforms. Don't mistake what I say to mean that ever change we make
the kernel for the O2 will improve Linux on every other platform, but now
and then something will improve other code, just like some code used for
other platforms will help improve the Linux on the various SGI platforms.

> While it would be possible to move these needs out to the X server
> to some extent, not all of them can be handled that way (in specific,
> the memory issues).  Further, there isn't really anything like
> uniform functionality in Linux X servers for handling things such
> as video I/O, genlocking, etc.  They exist in 3rd party servers,
> but then the cooperation requirement rises again.

If there is one thing I have learned it is never to say never or isn't or
can't when talking to a group of Linux hackers... 

> Now, having said all that, I do believe the problem is solvable.
> I think that with some modifications of the Linux kernel, it would
> be quite possible to get the necessary abstraction to support
> either an IRIX or customized third-party X server.  Further, it
> would be nice if something equivalent to the SGI DMedia libraries
> were available on Linux (with similar hardware abstraction), since
> this is an area where simply put, Linux is FAR behind Windows{95,NT}
> and SGI (and others).

I'm glad you think it is... 

> Getting Linux on O2 probably isn't too difficult.  Getting USEFUL
> O2/Octane/Onyx2 2D/3D graphics and multimedia under Linux would
> be god-awful difficult with the current kernel/X situation.

But not impossible ;-)

---
Todd M. Shrider                         Unix Workstation Support Group
(812)855-2627                           2711 E. 10th Street
tshrider@indiana.edu                    Indiana University,
http://www.uwsg.indiana.edu/            Bloomington, IN 47408-2671
---
 find my pgp public key at http://www.cs.indiana.edu/~tshrider
