Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA05591; Mon, 14 Apr 1997 11:14:36 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA18278 for linux-list; Mon, 14 Apr 1997 11:13:45 -0700
Received: from titian.engr.sgi.com (titian.engr.sgi.com [150.166.240.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA18266 for <linux@cthulhu.engr.sgi.com>; Mon, 14 Apr 1997 11:13:43 -0700
Received: from localhost by titian.engr.sgi.com via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <linux@cthulhu.engr.sgi.com> id LAA19102; Mon, 14 Apr 1997 11:13:43 -0700
Message-Id: <199704141813.LAA19102@titian.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: How big is the Linux/MIPS kernel?
Date: Mon, 14 Apr 1997 11:13:43 -0700
From: Mike McDonald <mikemac@titian.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


  Could someone tell me how big the kernel is for the MIPS chip? I
need a rough estimate of the size of a minimal kernel with networking
support, probably no file systems nor disks. A project I'm working on
is currently using VxWorks. We're suppose to add a bunch of large, off
the shelf software components to it and I'm worried about running
everything in one unprotected address space. (All it takes is the web
browser to hickup and the box will crash. But hey, no one has ever
heard of a web browser crashing!) Does anyone have an estimate of the
process switching time? That's one of the things the hardware types
harp about for their multimedia apps.

  Thanks

  Mike McDonald
  mikemac@engr.sgi.com
