Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05960; Tue, 11 Jun 1996 10:39:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA11605 for linux-list; Tue, 11 Jun 1996 17:38:57 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA11600 for <linux@cthulhu.engr.sgi.com>; Tue, 11 Jun 1996 10:38:56 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA05955; Tue, 11 Jun 1996 10:38:50 -0700
Date: Tue, 11 Jun 1996 10:38:50 -0700
Message-Id: <199606111738.KAA05955@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: alambie@wellington.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199606110013.MAA03444@soyuz.wellington.sgi.com>
	(alambie@wellington.sgi.com)
Subject: Re: Is this a silly idea?
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: alambie@wellington.sgi.com (Alistair Lambie)
   Date: Tue, 11 Jun 1996 12:13:36 +1200 (NZT)

   I'm not sure what the best way to attack this would be, but my
   guess is that we need to put the common filesystem in Irix, as I
   would pick that it would be difficult to get the buyin to port one
   of our filesystems to Linux.

I planned on hacking xfs _and_ efs implementations into Linux.

   Several questions:

   1. Is this sensible (or is there already a way of doing this)?

   2. If it is sensible, what should we do (type of fs etc)?

   3. Does anyone know how easy this is (I'm not sure whether I'm
   brave enough!)?

Also, I wouldn't mind seeing an ext2 implementation in IRIX, I could
probably hack up an initial read-only kernel module implementation in
a very short amount of time.

This is all only a matter of someone sitting behind the screen and
whacking away at the code for 2 or 3 days, nothing more.  I'd rather
concentrate on getting bootstrapped at this point, but after that I'll
probably hack on something like xfs/efs or whatever.

Later,
David S. Miller
dm@sgi.com
