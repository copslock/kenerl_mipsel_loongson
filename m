Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA15694; Wed, 28 May 1997 11:05:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA27964 for linux-list; Wed, 28 May 1997 11:04:35 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA27941 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 11:04:29 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11207 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 11:03:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA27707 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 11:03:40 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA15016
	for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 11:03:31 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id MAA24940;
	Wed, 28 May 1997 12:42:17 -0500
Date: Wed, 28 May 1997 12:42:17 -0500
Message-Id: <199705281742.MAA24940@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: shaver@neon.ingenia.ca
CC: ariel@sgi.com, linux@yon.engr.sgi.com
In-reply-to: <199705281535.LAA28810@neon.ingenia.ca> (message from Mike Shaver
	on Wed, 28 May 1997 11:35:27 -0400 (EDT))
Subject: Re: hardware independent hinv
X-Lost: In case of doubt, make it sound convincing
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > Just forwarding since it sounds someone hopes that Linux/MIPS
> > will some day have a HW independent hinv... - Ariel
> 
> Do they need more than the /proc stuff?
> Larry has a perl version of hinv that reads from /proc/whatever, I
> seem to recall.

Yesterday I went to see some guy running the University's new Origin
machine, and they showed me some monitoring tools on IRIX, very
impressive tools.  I want them on Linux :-).

There was this lovely tool that showed the memory map, with the
details on the usage.  You could click on say, Emacs, and get a map of
where Emacs pages were, and it seemed like it could read the symbol
table information from the process as well (it showed: "No symbols for
this page").

I also saw some printed slides on some program that seemed to let you
move related functions together in the binary to avoid page faults.
Can not really tell, as they were flipping trough them really quick.

I remember attending a presentation at Usenix where they talked about
this very feature.  This is something else we want in our binutils.

Miguel.
