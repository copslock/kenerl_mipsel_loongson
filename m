Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA76110 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 18:00:54 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA22543
	for linux-list;
	Wed, 19 Aug 1998 18:00:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA28152
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 18:00:46 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de ([141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA06697
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 18:00:44 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA11921
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Aug 1998 03:00:39 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA00810;
	Thu, 20 Aug 1998 02:28:18 +0200
Message-ID: <19980820022818.D388@uni-koblenz.de>
Date: Thu, 20 Aug 1998 02:28:18 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Merging for 2.1.116...
References: <Pine.LNX.3.96.980818205222.15702E-100000@lager.engsoc.carleton.ca> <19980819233429.57253@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980819233429.57253@alpha.franken.de>; from Thomas Bogendoerfer on Wed, Aug 19, 1998 at 11:34:29PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Aug 19, 1998 at 11:34:29PM +0200, Thomas Bogendoerfer wrote:

> On Tue, Aug 18, 1998 at 08:54:22PM -0400, Alex deVries wrote:
> > Is someone going to take to task merging our latest kernel into 2.1.116?
> 
> I exchanged some emails with Ralf, and he said, that he has started merging
> with .115. I've commited the newport abscon and g364 fbcon driver, so
> he could even test the merged sources:-) But I haven't heard anything since
> then from him about the merge.
> 
> > It would be really good to get everything in for 2.2.
> 
> I doubt, that we will be able to merge all the stuff. But we will see.

The code freeze has become a real freeze.  Luckily we won't have to touch
sensitive parts of the kernel except a couple of rather simple mm changes.

> > I don't mind taking a stab at it, although I'm supposed to be packing for
> > my move to Toronto in two weeks (finally!).
> 
> looks like moving time everywhere. I'll move most of my stuff next
> weekend.

I've just finished merging and debugging .111.  The new console code is
nice, Thomas.  It accelerated the Indy console from Sun 3 style performance
to too fast to read performance.  Things that I noticed

 - bb is still broken when using aalib's Linux console driver
 - We seem to have an off by one error.  The topmost scanline is also being
   displayed at the bottom of the screen.
 - The display as programmed by Linux is somewhat offseted from IRIX's.  Bad
   because one has to reduce the size of the display and still the display
   will wander around when switching between operating systems.
 - I broke the esp driver.

  Ralf
