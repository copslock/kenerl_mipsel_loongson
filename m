Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA06332; Tue, 25 Jun 1996 06:44:35 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA20004 for linux-list; Tue, 25 Jun 1996 13:44:31 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA19995 for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jun 1996 06:44:29 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA06325; Tue, 25 Jun 1996 06:44:15 -0700
Date: Tue, 25 Jun 1996 06:44:15 -0700
Message-Id: <199606251344.GAA06325@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: alambie@wellington.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <9606251335.ZM2026@windy.wellington.sgi.com>
	(alambie@wellington.sgi.com)
Subject: Re: Userland binaries
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: "Alistair Lambie" <alambie@wellington.sgi.com>
   Date: Tue, 25 Jun 1996 13:35:33 +0000

   Being miles away in New Zealand it is kind of hard to know who is
   doing what!

I wasn't far from there last week ;-) (for those who do not know I
gave two talks in Manchester England last week)

   I have been playing around with cross compiling userland binaries.
   But before I get carried away here are some questions:

   1. Is anyone already doing this?

Not that I know of.

   2. Should we set up a repository so we don't all spend our time
   doing the same
      thing?

Good idea.

   3. I have used the the cross compiler from ftp.fnet.fr.  The libc I
   have used is
      the gnu one that has just appeared on ftp.fnet.fr in the last
      week.  Are these the right ones to be using (they only allow
      static linking)?

This should be correct.  That libc snapshot probably only does static
binaries, the developers have initial 'hello world' type shared
binaries working from what I hear so expect some more about this
soon.  I'll update the list on any progress on shared libraries I hear
about myself.

   4. If several people are doing this maybe we should coordinate the
   effort so
      we don't all do the same packages.

Another good idea. ;-)

Later,
David S. Miller
dm@sgi.com
