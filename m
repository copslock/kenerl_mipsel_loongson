Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA44908 for <linux-archive@neteng.engr.sgi.com>; Sat, 5 Sep 1998 13:36:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA59458
	for linux-list;
	Sat, 5 Sep 1998 13:35:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA46833
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 5 Sep 1998 13:35:52 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08607
	for <linux@cthulhu.engr.sgi.com>; Sat, 5 Sep 1998 13:35:51 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zFP3k-0027wyC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 5 Sep 1998 22:35:48 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zFP3f-002P50C; Sat, 5 Sep 98 22:35 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA19528;
	Sat, 5 Sep 1998 22:33:07 +0200
Message-ID: <19980905223307.15653@alpha.franken.de>
Date: Sat, 5 Sep 1998 22:33:07 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: SCSI problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm trying to narrow down the SCSI problems, which some people are seeing.
I did some test with a DAT drive and got also problems. Right now my Indy
is running with a normal kernel but with SCSI dma disabled. And I didn't
see any problems. So could anybody try to start the kernel with following
setup option added:

wd33c93=nodma:1

Of course this decreases the SCSI speed, but I want know, if we get rid
of the problems. If I'm on the right track, I suspect some problems with
DMA/cache flushing.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
