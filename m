Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA52215 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 23:48:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA11055
	for linux-list;
	Wed, 19 Aug 1998 23:47:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA90911
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 23:47:49 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA22807
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 23:47:39 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z9OVO-0027nxC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 20 Aug 1998 08:47:30 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z9OVG-002OnYC; Thu, 20 Aug 98 08:47 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id IAA01020;
	Thu, 20 Aug 1998 08:44:51 +0200
Message-ID: <19980820084451.40712@alpha.franken.de>
Date: Thu, 20 Aug 1998 08:44:51 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Merging for 2.1.116...
References: <Pine.LNX.3.96.980818205222.15702E-100000@lager.engsoc.carleton.ca> <19980819233429.57253@alpha.franken.de> <19980820022818.D388@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980820022818.D388@uni-koblenz.de>; from ralf@uni-koblenz.de on Thu, Aug 20, 1998 at 02:28:18AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 20, 1998 at 02:28:18AM +0200, ralf@uni-koblenz.de wrote:
> I've just finished merging and debugging .111.  The new console code is
> nice, Thomas.  It accelerated the Indy console from Sun 3 style performance
> to too fast to read performance.  Things that I noticed

thanks.

>  - bb is still broken when using aalib's Linux console driver

I'll have a look at it.

>  - We seem to have an off by one error.  The topmost scanline is also being
>    displayed at the bottom of the screen.

upps, never noticed that. There is another known bug in the console.
If you insert a character sometimes the character gets painted twice, one
at the correct position, the other at the end of the line.

>  - The display as programmed by Linux is somewhat offseted from IRIX's.  Bad
>    because one has to reduce the size of the display and still the display
>    will wander around when switching between operating systems.

I had to do this, otherwise we lose speed. I haven't found a solution, yet.
If I find one, we can also do other console resolutions.

>  - I broke the esp driver.

how that ? I thought there were only changes, which are already in our
tree (I guess your talking about NCR53C9x).

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
