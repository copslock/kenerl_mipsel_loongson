Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA44552 for <linux-archive@neteng.engr.sgi.com>; Fri, 21 Aug 1998 16:26:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA81844
	for linux-list;
	Fri, 21 Aug 1998 16:25:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA17902
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Aug 1998 16:25:51 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08201
	for <linux@cthulhu.engr.sgi.com>; Fri, 21 Aug 1998 16:25:51 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zA0Yz-0027u3C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 22 Aug 1998 01:25:45 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zA0Yp-002PFfC; Sat, 22 Aug 98 01:25 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA04170;
	Sat, 22 Aug 1998 01:22:31 +0200
Message-ID: <19980822012231.32311@alpha.franken.de>
Date: Sat, 22 Aug 1998 01:22:31 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Merging for 2.1.116...
References: <Pine.LNX.3.96.980818205222.15702E-100000@lager.engsoc.carleton.ca> <19980819233429.57253@alpha.franken.de> <19980820022818.D388@uni-koblenz.de> <19980820084451.40712@alpha.franken.de> <19980821022824.C4209@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980821022824.C4209@uni-koblenz.de>; from ralf@uni-koblenz.de on Fri, Aug 21, 1998 at 02:28:24AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Aug 21, 1998 at 02:28:24AM +0200, ralf@uni-koblenz.de wrote:
> Never seen that happen on my machine.  I had the problem that the two topmost
> lines were wrapped to the bottom.  Changing the screen size in <asm/bootinfo.h>
> to 160 x 64 fixed that.

cool, you are now using the resolution for which the console was written for.
Sorry, I forgot to tell you this. Without the 64 lines the scrolling stuff
doesn't work properly.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
