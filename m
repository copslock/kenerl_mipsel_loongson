Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA13463; Tue, 29 Jul 1997 13:13:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA04832 for linux-list; Tue, 29 Jul 1997 13:12:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA04680 for <linux@cthulhu.engr.sgi.com>; Tue, 29 Jul 1997 13:12:36 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA04137
	for <linux@cthulhu.engr.sgi.com>; Tue, 29 Jul 1997 12:37:01 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id OAA11767;
	Tue, 29 Jul 1997 14:34:55 -0500
Date: Tue, 29 Jul 1997 14:34:55 -0500
Message-Id: <199707291934.OAA11767@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: /dev/usema and /dev/usemaclone device drivers
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   I am trying to figure out how the /dev/usema and /dev/usemaclone
devices work on IRIX.  These devices are used by the IRIX Xsgi server,
so, well, we need to support them.  

   I have read the manual page for the devices, but they suggest that
people should not be using this device directly, so it does not go
into any detail about the inner working of it.

   So, I would appreciate information on what this device is supposed
to do and how the libc uses this to provide the spinlocks and
semaphores.  Should be pretty easy to figure out how part of the
interface by looking at the libc implementation for the usinit,
usnewlock and usnewsema functions.

Cheers,
Miguel.
