Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA13640; Sat, 22 Jun 1996 20:19:58 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA22390 for linux-list; Sun, 23 Jun 1996 03:19:17 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA22384 for <linux@cthulhu.engr.sgi.com>; Sat, 22 Jun 1996 20:19:15 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA13617; Sat, 22 Jun 1996 20:19:15 -0700
Date: Sat, 22 Jun 1996 20:19:15 -0700
Message-Id: <199606230319.UAA13617@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: what I am up to...
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I've just checked in last night an initial serial driver for the
INDY.  Since this machine (as do some other SGI's) have the Zilog85C30
on board, I just took my Sparc driver and hacked it a little.
Currently it works well as the console, and some initial tests with
KGDB show that it is ok for the KGDB packets as well.  KGDB needs some
work on the host end of things before I can use it very much.

I'm cleaning up the source tree.  The end result will hopefully be a
single kernel which can work flawlessly on any Mips CPU variant.  I
know what need to be done for this to work.  In the end the goal is to
be able to fire up the same Linux kernel on _any_ SGI piece of
hardware and it just works, just like the Sparc kernel does.

More to come...

Later,
David S. Miller
dm@sgi.com
