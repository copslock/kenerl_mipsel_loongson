Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA186699 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 13:42:17 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA12076 for linux-list; Mon, 24 Nov 1997 13:41:04 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA11939 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 13:40:59 -0800
Received: from dm.cobaltmicro.com ([209.19.61.51]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA06143
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 13:40:54 -0800
	env-from (davem@dm.cobaltmicro.com)
Received: (from davem@localhost)
	by dm.cobaltmicro.com (8.8.7/8.8.7) id NAA00677;
	Mon, 24 Nov 1997 13:35:29 -0800
Date: Mon, 24 Nov 1997 13:35:29 -0800
Message-Id: <199711242135.NAA00677@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: ewt@redhat.com
CC: linux-mips@fnet.fr, alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-reply-to: <Pine.LNX.3.95.971124105430.7590F-100000@lacrosse.redhat.com>
	(message from Erik Troan on Mon, 24 Nov 1997 10:55:25 -0500 (EST))
Subject: Re: Libc in CVS
References:  <Pine.LNX.3.95.971124105430.7590F-100000@lacrosse.redhat.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Mon, 24 Nov 1997 10:55:25 -0500 (EST)
   From: Erik Troan <ewt@redhat.com>

   A static RPM has saved my ass *many* times, and it would
   irresponsible for us not to ship it static. Glibc ought to be able
   to generate static binaries. If it can't, it's broken.

That was a nice thing back in the pre-glibc days.  But since so many
static binaries (including RPM) pull in the NIS stuff dynamically via
dlopen() due to how GLIBC works, your ass will no longer get saved the
way it used to.

Later,
David S. Miller
davem@dm.cobaltmicro.com
