Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA00580; Fri, 27 Jun 1997 17:21:19 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA26412 for linux-list; Fri, 27 Jun 1997 17:19:52 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA26373 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Jun 1997 17:19:47 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA03618
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Jun 1997 17:18:23 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id TAA21239;
	Fri, 27 Jun 1997 19:03:50 -0500
Date: Fri, 27 Jun 1997 19:03:50 -0500
Message-Id: <199706280003.TAA21239@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Small question regarind gfx api.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


In the /usr/include/sys/gfx.h file some of the ioctls that are
supported for /dev/graphics are tagged with a comment that says that
you have to be the board owner to issue those commands.

My question is: how do you become the board owner?  

Right now my X server uses a single file descriptor for /dev/graphics
for all of the boards attached to the system, since it appears to me
that every GFX ioctl requires the board number on which it operates.

Miguel.
