Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA54805 for <linux-archive@neteng.engr.sgi.com>; Sun, 25 Jan 1998 22:07:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA11091 for linux-list; Sun, 25 Jan 1998 22:04:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA11075 for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 22:04:31 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA25265
	for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 22:04:28 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA27346
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 01:05:14 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 26 Jan 1998 01:05:14 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Boot flags in the kernel.
Message-ID: <Pine.LNX.3.95.980126004413.18537A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm not sure if what I'm trying to do is possible. I'm trying to implement
the same rootflags that are passwd within the kernel image in i386 into
the MIPS kernel. 

In i386 there's a portion of the boot image reserved for these flags;
they're things like console type, initial filesystem, initial ramdisk
location, etc.  

It's traditionally been more important to have this feature in i386
because there wasn't anything nice like the PROMs on MIPS or Sparcs.

But, there _is a good reason to have it; for install or rescue images it's
nice to be able to boot with compressed initial ramdisk within the same
boot image without having to pass the ramdisk offset on command line
manually.

Where in the kernel would we put this data?

- Alex

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
