Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA1308877 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 11:52:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA01549 for linux-list; Fri, 5 Sep 1997 11:51:11 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA01531 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 11:51:05 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA19075 for <linux@fir.engr.sgi.com>; Fri, 5 Sep 1997 11:51:03 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA01517 for <linux@fir.engr.sgi.com>; Fri, 5 Sep 1997 11:51:01 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA21300
	for <linux@fir.engr.sgi.com>; Fri, 5 Sep 1997 11:49:28 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id NAA07307;
	Fri, 5 Sep 1997 13:42:08 -0500
Date: Fri, 5 Sep 1997 13:42:08 -0500
Message-Id: <199709051842.NAA07307@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: miguel@nuclecu.unam.mx
CC: linux@fir.engr.sgi.com
In-reply-to: <199709050245.VAA03103@athena.nuclecu.unam.mx> (message from
	Miguel de Icaza on Thu, 4 Sep 1997 21:45:31 -0500)
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
X-Windows: The problem for your problem.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


IRIX unsolved misteries -- second update.

I said:

>     Ok, it seems our irix_elfmap routine is just fine, I just found
> out with a simple test case that the code is trying to access memory
> from the location at 0x200000 which is making my IRIX executables
> crash (this one is crashing inside usinit ()).

I was debatting this with my bed sheets this morning and I believe
that this page may be a special trick for IRIX sproc()ed binaries.
Probably I should also turn off the cache on this page.

Miguel.
