Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA408085 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Mar 1998 09:56:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id JAA486734 for linux-list; Wed, 11 Mar 1998 09:55:40 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id JAA2281055 for <linux@engr.sgi.com>; Wed, 11 Mar 1998 09:55:39 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA14604; Wed, 11 Mar 1998 09:55:38 -0800
Date: Wed, 11 Mar 1998 09:55:38 -0800
Message-Id: <199803111755.JAA14604@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@linus.linux.sgi.com (Ralf Baechle)
CC: linux@cthulhu.engr.sgi.com
Subject: Re: CVS Update@linus.linux.sgi.com: linux
In-Reply-To: <199803111521.HAA27172@linus.linux.sgi.com>
References: <199803111521.HAA27172@linus.linux.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
...
 > 	o The calculated values for r4k_offset are still off by ~480 from the
 > 	theoretical values.  That means we're going to loose about 46 s per
 > 	day.  Are the crystals that bad or is there still a bug hidden
 > 	somewhere?  Maybe an option to set r4k_offset to a user supplied
 > 	value might help?
...

      The crystals may well be off from exactly 100 MHZ.  Since the
frequency is high, a small percentage error adds up over a long
period.  I believe that the crystals for the CPU clock are chosen for
stability, not for highly accurate specific frequency (unlike, say,
the crystal in a watch).  You pretty much have to calibrate the CPU
clock using the Dallas calendar clock.  The intent in IRIX, although
sometimes broken, is to use the Dallas clock to correct drift in the
CPU clock, if an external time base (via NTP or the like) is not
being used.  
