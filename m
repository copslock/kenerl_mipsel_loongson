Received: from cthulhu.engr.sgi.com ([192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA10481; Thu, 31 Jul 1997 22:06:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA15446 for linux-list; Thu, 31 Jul 1997 17:42:11 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA15209 for <linux@cthulhu.engr.sgi.com>; Thu, 31 Jul 1997 17:40:57 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA10929
	for <linux@cthulhu.engr.sgi.com>; Thu, 31 Jul 1997 16:54:06 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id SAA04021;
	Thu, 31 Jul 1997 18:51:27 -0500
Date: Thu, 31 Jul 1997 18:51:27 -0500
Message-Id: <199707312351.SAA04021@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Linux/SGI: SHMIQ Cache aliasing problems.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   I am running into a strange problem with the SHMIQ driver.  I am
allocating a set of pages in the kernel space with vmalloc and then
mapping those pages into the user address space by loading the page
tables for the process with pointers to this region.

   This is needed, since the kernel should be able to put new values
into the shmiq and the userland process can just be busy-waiting for
changes to the head/tail pointers in the SHMIQ.

   Now, I marked the pages as being non-cachable for both the kernel
and the userland, but still, some changes made by the kernel to the
shared region are not picked up by the userland program.

   Note that the userland program always detects when the kernel has
moved the tail of the shmiq, but when actually accessing the event,
sometimes I get zeros on an event that should have other values).

   According to a book I got here, the r4000 uses a direct mapped
virtual cache and I was concerned that the aliasing problems may come
up in this case, so the question is: do I have to flush the caches
even if my pages have the non-cacheable bits turned on for both sides?

Cheers,
Miguel.
