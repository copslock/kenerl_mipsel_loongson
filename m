Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA2648299 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 08:30:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA6918308
	for linux-list;
	Thu, 2 Apr 1998 08:28:32 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA6942555
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 08:28:29 -0800 (PST)
Received: from calypso.saturn (dialup166-3-7.swipnet.se [130.244.166.135]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA08697
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 08:28:26 -0800 (PST)
	mail_from (grimsy@zigzegv.ml.org)
Received: (from grimsy@localhost)
	by calypso.saturn (8.8.8/8.8.8/Debian/GNU) id TAA00404;
	Thu, 2 Apr 1998 19:31:00 +0200
Date: Thu, 2 Apr 1998 19:31:00 +0200
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
Message-Id: <199804021731.TAA00404@calypso.saturn>
To: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: kernel panic
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello again... we're updating the internet connection to my mail server so
I can't read what you've written today. But I've downloaded patch-3 of the
sgi-kernel. I get further, but it still doesn't work.. well, I think it's
almost fixed now. Here's the output:

IP-Config: Got BOOTP answer from 192.168.0.1, my address is 192.168.0.3
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3
VFS: Mounted root (ext2 filesystem) readonly.
Warning: unable to open an initial console.
Got vced at 8801a2a4.
Kernel panic: Caught VCE exception - should not happen

That's the end of it.. tell me if you need some info above those lines..
Can it be my partition which is screwed? I reinstalled sgi-linux two days ago...

We're atleast getting somewhere! Great work :-)

- Ulf
