Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA712339 for <linux-archive@neteng.engr.sgi.com>; Sun, 30 Nov 1997 17:46:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA12977 for linux-list; Sun, 30 Nov 1997 17:44:16 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA12939 for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 17:44:06 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA09400
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 17:44:02 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA13237
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 20:41:41 -0500
Date: Sun, 30 Nov 1997 20:41:40 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: More news...
In-Reply-To: <19971130172918.59762@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.971130202217.22956K-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


First, the good:

I have a lot working now. inetd works fine, apache is beautiful, and I can
telnet into my machine.  Yay!  Finally, I can work from elsewhere in the
world.

My machine is a lot faster now that I don't have to be on the console.
I'm lead to believe it's the display driver that's slow, not the whole
machine.  It "feels" like a P100 now.

The bad news:

Still more libc problems, but I'll quit whining about that since Ralf
kindly told me to cross cross my own.  I'm looking at my cross-compiler
problems now.

Next problem:
I was running a ./configure for the nfs-server package, and I got a few
segfaults, followed by many copies of this on the console:

release_dev: pty1: read/write wait queue active!

and finally:
Got a bus error IRQ, shouldn't happen yet
and a freeze.

- Alex

      Alex deVries          Rent this space for a $5 donation 
  System Administrator      to EngSoc per day.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
