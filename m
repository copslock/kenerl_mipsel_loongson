Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA64639 for <linux-archive@neteng.engr.sgi.com>; Fri, 10 Oct 1997 16:41:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA16314 for linux-list; Fri, 10 Oct 1997 16:41:04 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16307 for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 16:41:02 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA14271
	for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 16:41:00 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id TAA20332 for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 19:41:19 -0400
Date: Fri, 10 Oct 1997 19:41:19 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: make zImage, and initrd...
In-Reply-To: <Pine.LNX.3.95.971009185152.20315W-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.95.971010192929.364D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm working on adding the ramdisk and initrd features to the kernel.  It
compiles, which is pretty good for my first kernel patch.

But, I have no way to actually test it.  The kernel needs to find the
offset of the ramdisk in the first 11 bits of one of the boot headers, so
the kernel needs to be less than 2047k.

This wouldn't normally be a problem, but doing a 'make zImage' tells me
that:
./mkboot zImage.tmp zImage
Input file isn't a little endian ELF file
make[1]: *** [zImage] Error 1

What would be required to make mkboot handle zImage, or bzImage?

In the meantime, I will try to strip down a kernel to below 2047k.  My
current one is 2347.

Any other ideas?

- Alex
