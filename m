Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA745109 for <linux-archive@neteng.engr.sgi.com>; Sun, 30 Nov 1997 22:47:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA12203 for linux-list; Sun, 30 Nov 1997 22:45:30 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA12195 for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 22:45:27 -0800
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA29609
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 22:45:26 -0800
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id AAA12762;
	Mon, 1 Dec 1997 00:45:16 -0600
Date: Mon, 1 Dec 1997 00:45:16 -0600
Message-Id: <199712010645.AAA12762@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: ralf@uni-koblenz.de
CC: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
In-reply-to: <19971130025848.64926@thoma.uni-koblenz.de> (message from Ralf
	Baechle on Sun, 30 Nov 1997 02:58:48 +0100)
Subject: Re: A report from the battle field...
X-FileLength: are infinite where infinity is set to 255 characters
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > - mingetty: 
> > unix_gc: deferred due to low memory
> 
> Uh?  Never saw that one.

he is using a 4+ month old kernel. This has been fixed in the CVS for
a long time now.  It was caused because of my vmalloc mistake.

Miguel.
