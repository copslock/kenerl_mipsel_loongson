Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA02778 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Jan 1998 22:43:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA02063 for linux-list; Tue, 13 Jan 1998 22:40:06 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA02051 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 22:40:04 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA04511
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 22:39:57 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA28263
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 01:43:00 -0500
Date: Wed, 14 Jan 1998 01:43:00 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: The world's worst RPM
Message-ID: <Pine.LNX.3.95.980114013153.10190J-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I have generated the world's worst RPM for util-linux, which is much
needed, since it contains fdisk.

I had to kludge some things; util-linux is truly an awful thing.  It
contains things like hwclock, which sets the clock on ISA bus only
machines.  This is designed only for sparc, alpha and i386 _ONLY_.

Anyway, I kludged it into compiling, but I really had to guess on the
parameters for the disk operations.  Fdisk compiles and works, but I can't
really test it as I need both disks on my system.  Could somebody give it
a try?

Also, it has things like more , write and mkswap. Yay! I now have swap
space!

So, give it a try, or clean up my diff files.

- Alex

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
