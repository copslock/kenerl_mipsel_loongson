Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA415842 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Dec 1997 09:18:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA26202 for linux-list; Fri, 5 Dec 1997 09:18:03 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26189 for <linux@engr.sgi.com>; Fri, 5 Dec 1997 09:17:56 -0800
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA07744
	for <linux@engr.sgi.com>; Fri, 5 Dec 1997 09:17:53 -0800
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id LAA07167;
	Fri, 5 Dec 1997 11:15:24 -0600
Date: Fri, 5 Dec 1997 11:15:24 -0600
Message-Id: <199712051715.LAA07167@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux-mips@fnet.fr
CC: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
In-reply-to: <19971202200147.44637@uni-koblenz.de> (ralf@uni-koblenz.de)
Subject: Re: vmalloc hacks
X-Windows: You'll envy the dead.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello Ralf,

> So you'll have to make vmalloc a real function again or you'll break the
> binary compatibility with modules.  Ok, not very much an issue.

Probably sched.c just needs to include vmalloc.h, that should get rid
of this problem.

Miguel.
