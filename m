Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA822745 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Mar 1998 15:39:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA3435327 for linux-list; Wed, 11 Mar 1998 15:37:47 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id PAA3454953; Wed, 11 Mar 1998 15:37:45 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA15304; Wed, 11 Mar 1998 15:37:40 -0800
Date: Wed, 11 Mar 1998 15:37:40 -0800
Message-Id: <199803112337.PAA15304@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: CVS Update@linus.linux.sgi.com: linux
In-Reply-To: <19980311231239.11868@uni-koblenz.de>
References: <199803111521.HAA27172@linus.linux.sgi.com>
	<199803111755.JAA14604@fir.engr.sgi.com>
	<19980311231239.11868@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Wed, Mar 11, 1998 at 09:55:38AM -0800, William J. Earl wrote:
 > 
 > > Ralf Baechle writes:
 > > ...
 > >  > 	o The calculated values for r4k_offset are still off by ~480 from the
 > >  > 	theoretical values.  That means we're going to loose about 46 s per
 > >  > 	day.  Are the crystals that bad or is there still a bug hidden
 > >  > 	somewhere?  Maybe an option to set r4k_offset to a user supplied
 > >  > 	value might help?
 > > ...
 > > 
 > >       The crystals may well be off from exactly 100 MHZ.  Since the
 > > frequency is high, a small percentage error adds up over a long
 > > period.  I believe that the crystals for the CPU clock are chosen for
 > > stability, not for highly accurate specific frequency (unlike, say,
 > > the crystal in a watch).  You pretty much have to calibrate the CPU
 > > clock using the Dallas calendar clock.  The intent in IRIX, although
 > > sometimes broken, is to use the Dallas clock to correct drift in the
 > > CPU clock, if an external time base (via NTP or the like) is not
 > > being used.  
 > 
 > The question is whether the Dallas chip or the i8254 timer has the more
 > accurate clock.  A couple of the Dallas chips I've seen are so bad that
 > xntp would not be able to sync via NTP, so the i8454 clock seems to be
 > preferable as the clock source.  Another thing is that when using NTP
 > Linux uses the software clock in the kernel and writes that time regularly
 > back into the CMOS.

    Yes, when using NTP, updating the CMOS from the kernel is the right
thing to do; IRIX is also supposed to do that, although that is also sometimes
broken.

 > Afaik the limit for synchronisation via xntp / NTP is a failsynchronisation
 > between the two clocks of about 300ppm.  The current Linux kernel is at
 > about 500ppm on my Indy and I sometimes see xntpd loosing synchronisation
 > on the Indy.  I haven't researched this but I suppose the software PLL in
 > xntpd ``unlocks'' now and then.
...

      If the Dallas is drifting much more than a cheap digital watch,
it is probably sick, especially if the drift is most pronounced when the
system is powered off.  I have seen both Indys and PCs with that problem
(including my 486 notebook running linux).
