Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA05511; Wed, 11 Jun 1997 18:22:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA28917 for linux-list; Wed, 11 Jun 1997 18:22:25 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA28892 for <linux@cthulhu.engr.sgi.com>; Wed, 11 Jun 1997 18:22:20 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA03109 for <linux@yon.engr.sgi.com>; Wed, 11 Jun 1997 18:21:52 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA28740 for <linux@yon.engr.sgi.com>; Wed, 11 Jun 1997 18:21:44 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA19287
	for <linux@yon.engr.sgi.com>; Wed, 11 Jun 1997 18:21:40 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id UAA27828;
	Wed, 11 Jun 1997 20:10:40 -0500
Date: Wed, 11 Jun 1997 20:10:40 -0500
Message-Id: <199706120110.UAA27828@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@yon.engr.sgi.com
In-reply-to: <199705281603.SAA31716@kernel.panic.julia.de> (message from Ralf
	Baechle on Wed, 28 May 1997 18:03:20 +0200 (MET DST))
Subject: My first project on the Indy.
X-Windows: The art of incompetence.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   I got my Indy up and running now.  My very first project would be
to work on the Linux boot loader.

   I just happily found that there are two disks on the machine, so I
will smash the second one with my boot loader tests.  

   Now, where can I find information about the boot process on the
SGI?  I want to know what does the PROM load from the disk (I bet it
loads the first sectors and jumps to them, right?), and where the code
is loaded.  

   I happilly found that a program called Insight Library comes with
the system and has a lot of information on using the PROM, which is
what I am reading now to find out any debugging facilities in there.

   Some time ago, (maybe Larry or Ariel) mentioned that it would be
possible to get me a copy of the boot loader for Irix.

Cheers,
Miguel.
