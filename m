Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA84511 for <linux-archive@neteng.engr.sgi.com>; Thu, 20 Aug 1998 17:31:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA24377
	for linux-list;
	Thu, 20 Aug 1998 17:30:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA73324
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Aug 1998 17:30:27 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA15825
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Aug 1998 17:31:32 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-28.uni-koblenz.de [141.26.249.28])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA05259
	for <linux@cthulhu.engr.sgi.com>; Fri, 21 Aug 1998 02:31:28 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA04682;
	Fri, 21 Aug 1998 02:28:24 +0200
Message-ID: <19980821022824.C4209@uni-koblenz.de>
Date: Fri, 21 Aug 1998 02:28:24 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Merging for 2.1.116...
References: <Pine.LNX.3.96.980818205222.15702E-100000@lager.engsoc.carleton.ca> <19980819233429.57253@alpha.franken.de> <19980820022818.D388@uni-koblenz.de> <19980820084451.40712@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980820084451.40712@alpha.franken.de>; from Thomas Bogendoerfer on Thu, Aug 20, 1998 at 08:44:51AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 20, 1998 at 08:44:51AM +0200, Thomas Bogendoerfer wrote:

> >  - We seem to have an off by one error.  The topmost scanline is also being
> >    displayed at the bottom of the screen.
> 
> upps, never noticed that. There is another known bug in the console.
> If you insert a character sometimes the character gets painted twice, one
> at the correct position, the other at the end of the line.

Never seen that happen on my machine.  I had the problem that the two topmost
lines were wrapped to the bottom.  Changing the screen size in <asm/bootinfo.h>
to 160 x 64 fixed that.

> >  - The display as programmed by Linux is somewhat offseted from IRIX's.  Bad
> >    because one has to reduce the size of the display and still the display
> >    will wander around when switching between operating systems.
> 
> I had to do this, otherwise we lose speed. I haven't found a solution, yet.
> If I find one, we can also do other console resolutions.

  Ralf
