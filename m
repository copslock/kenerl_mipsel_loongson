Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA810770 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Mar 1998 14:14:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA3227427 for linux-list; Wed, 11 Mar 1998 14:12:55 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA3185627; Wed, 11 Mar 1998 14:12:45 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA05741; Wed, 11 Mar 1998 14:12:43 -0800 (PST)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from uhland (ralf@uhland.uni-koblenz.de [141.26.4.63])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id XAA05213;
	Wed, 11 Mar 1998 23:12:41 +0100 (MET)
Received: by uhland (SMI-8.6/KO-2.0)
	id XAA01748; Wed, 11 Mar 1998 23:12:40 +0100
Message-ID: <19980311231239.11868@uni-koblenz.de>
Date: Wed, 11 Mar 1998 23:12:39 +0100
From: ralf@uni-koblenz.de
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: CVS Update@linus.linux.sgi.com: linux
References: <199803111521.HAA27172@linus.linux.sgi.com> <199803111755.JAA14604@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199803111755.JAA14604@fir.engr.sgi.com>; from William J. Earl on Wed, Mar 11, 1998 at 09:55:38AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 11, 1998 at 09:55:38AM -0800, William J. Earl wrote:

> Ralf Baechle writes:
> ...
>  > 	o The calculated values for r4k_offset are still off by ~480 from the
>  > 	theoretical values.  That means we're going to loose about 46 s per
>  > 	day.  Are the crystals that bad or is there still a bug hidden
>  > 	somewhere?  Maybe an option to set r4k_offset to a user supplied
>  > 	value might help?
> ...
> 
>       The crystals may well be off from exactly 100 MHZ.  Since the
> frequency is high, a small percentage error adds up over a long
> period.  I believe that the crystals for the CPU clock are chosen for
> stability, not for highly accurate specific frequency (unlike, say,
> the crystal in a watch).  You pretty much have to calibrate the CPU
> clock using the Dallas calendar clock.  The intent in IRIX, although
> sometimes broken, is to use the Dallas clock to correct drift in the
> CPU clock, if an external time base (via NTP or the like) is not
> being used.  

The question is whether the Dallas chip or the i8254 timer has the more
accurate clock.  A couple of the Dallas chips I've seen are so bad that
xntp would not be able to sync via NTP, so the i8454 clock seems to be
preferable as the clock source.  Another thing is that when using NTP
Linux uses the software clock in the kernel and writes that time regularly
back into the CMOS.

Afaik the limit for synchronisation via xntp / NTP is a failsynchronisation
between the two clocks of about 300ppm.  The current Linux kernel is at
about 500ppm on my Indy and I sometimes see xntpd loosing synchronisation
on the Indy.  I haven't researched this but I suppose the software PLL in
xntpd ``unlocks'' now and then.

I wonder how well NTP works over a typical AX.25 link ...

  Ralf
