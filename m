Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA139943; Sat, 9 Aug 1997 11:48:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA01089 for linux-list; Sat, 9 Aug 1997 11:47:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA01079; Sat, 9 Aug 1997 11:47:28 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA01908; Sat, 9 Aug 1997 11:47:26 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id NAA14036;
	Sat, 9 Aug 1997 13:46:20 -0500
Date: Sat, 9 Aug 1997 13:46:20 -0500
Message-Id: <199708091846.NAA14036@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: jwiede@blammo.engr.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <9708081041.ZM971@blammo.engr.sgi.com>
	(jwiede@blammo.engr.sgi.com)
Subject: Re: Linux GGI and Linux/SGI
X-Lost: In case of doubt, make it sound convincing
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Are there any plans to move (maybe it's already there) the
> SGI version of Linux to a GGI-model design?
> (see http://synergy.foo.net/~ggi/)

It is nice, but they assume that a frame buffer is available on the
system, the GGI acceleration features are not even close to what the
low end Indy machines have, they are too general acceleration
features.  

We will support the direct rendering interface on Linux/SGI, which
will take care of using the nice SGI hardware. 

Miguel.
