Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA04899; Wed, 2 Jul 1997 19:22:12 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA05749 for linux-list; Wed, 2 Jul 1997 19:21:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA05745 for <linux@cthulhu.engr.sgi.com>; Wed, 2 Jul 1997 19:21:54 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA28615
	for <linux@relay.engr.sgi.com>; Wed, 2 Jul 1997 19:21:52 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id VAA09901;
	Wed, 2 Jul 1997 21:06:42 -0500
Date: Wed, 2 Jul 1997 21:06:42 -0500
Message-Id: <199707030206.VAA09901@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: IRIX include file definitions copyrights.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   I am a little worried that probably it is not a good idea to just
copy shamelessly the structures and contant definitions from the
/usr/include/sys files for implementing the Linux GFX/RRM. 

   Right now I have included a "----BEGIN-COPY-PASTE----" and a
"----END-COPY-PASTE----" comments to my asm/gfx.h and my asm/rmm.h
noting explicitly where the stuff has just been copy and pasted and
not massaged, but I wonder if it is ok to merge this into the GPLed
Linux kernel.

   Comments?

cheers,
Miguel.
