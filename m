Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA21331; Wed, 28 May 1997 11:24:05 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA03252 for linux-list; Wed, 28 May 1997 11:23:49 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA03243 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 11:23:48 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11332 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 11:23:46 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA03233 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 11:23:45 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA21233
	for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 11:23:44 -0700
	env-from (davem@caip.rutgers.edu)
Received: from darkwing.rutgers.edu (darkwing.rutgers.edu [128.6.111.4])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with ESMTP id OAA27325;
	Wed, 28 May 1997 14:19:55 -0400 (EDT)
Received: (davem@localhost) by darkwing.rutgers.edu (8.8.4/8.6.9) id OAA02400; Wed, 28 May 1997 14:18:27 -0400
Date: Wed, 28 May 1997 14:18:27 -0400
Message-Id: <199705281818.OAA02400@darkwing.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: miguel@nuclecu.unam.mx
CC: shaver@neon.ingenia.ca, ariel@sgi.com, linux@yon.engr.sgi.com
In-reply-to: <199705281742.MAA24940@athena.nuclecu.unam.mx> (message from
	Miguel de Icaza on Wed, 28 May 1997 12:42:17 -0500)
Subject: Re: hardware independent hinv
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Wed, 28 May 1997 12:42:17 -0500
   From: Miguel de Icaza <miguel@nuclecu.unam.mx>

   I also saw some printed slides on some program that seemed to let
   you move related functions together in the binary to avoid page
   faults.  Can not really tell, as they were flipping trough them
   really quick.

   I remember attending a presentation at Usenix where they talked
   about this very feature.  This is something else we want in our
   binutils.

The solaris dynamic linker does this at run time, it collapses
together only the functions/data which your program could ever
reference into one contiguous chunk of pages.  I haven't worked out
the complete set of details of how this is done completely at run
time, and efficiently as well, but I have spoken to Eric Youngdale and
other Linux userland experts about this trick.
