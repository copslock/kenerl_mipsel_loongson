Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA13597; Wed, 28 May 1997 13:11:38 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA02573 for linux-list; Wed, 28 May 1997 13:11:12 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA02556 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 13:11:10 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA12023 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 13:10:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA02465 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 13:10:47 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA25029
	for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 13:10:44 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id OAA27164;
	Wed, 28 May 1997 14:49:01 -0500
Date: Wed, 28 May 1997 14:49:01 -0500
Message-Id: <199705281949.OAA27164@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: davem@caip.rutgers.edu
CC: shaver@neon.ingenia.ca, ariel@sgi.com, linux@yon.engr.sgi.com
In-reply-to: <199705281818.OAA02400@darkwing.rutgers.edu>
	(davem@caip.rutgers.edu)
Subject: Re: hardware independent hinv
X-Windows: Form follows malfunction.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> The solaris dynamic linker does this at run time, it collapses
> together only the functions/data which your program could ever
> reference into one contiguous chunk of pages.  

Mhm, you mean, it moves the functions and data around?  This looks
interesting.  How does the Solaris linker find this out?

On the presentation at Usenix, they used feed the profiling
information into this executable-reorganizer program and the output
was this "optimized" executable.

Actually, I just found the program, from the cord(1) man page: 

     In the example below, a program foo is run through pixie(1) which
     generates foo.pixie.  The instrumented executable is run and prof is used
     to produce a feedback file from the profiled data.  Cord is then used to
     reorder the procedures in foo, generating a new binary foo.cord.

            pixie foo
            foo.pixie
            prof -pixie -feedback foo
            cord foo foo.fb

Pretty cool.

In the paper they presented some other optimizations to dynamically
linked programs.  Let me see if I can get the paper from the Usenix
site.

Cheers,
Miguel.
