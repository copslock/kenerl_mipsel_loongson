Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA457099 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Dec 1997 15:55:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA01335 for linux-list; Fri, 5 Dec 1997 15:55:05 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA01329; Fri, 5 Dec 1997 15:55:03 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA02883; Fri, 5 Dec 1997 15:54:59 -0800
Date: Fri, 5 Dec 1997 15:54:59 -0800
Message-Id: <199712052354.PAA02883@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Warner Losh <imp@village.org>
Cc: ariel@cthulhu.engr.sgi.com (Ariel Faigon),
        mike@contract.kent.edu (Mike Acar), linux@cthulhu.engr.sgi.com
Subject: Re: M$ 's strategy against Linux: nightmare scenario 
In-Reply-To: <199712052246.PAA12296@harmony.village.org>
References: <199712052220.OAA60317@oz.engr.sgi.com>
	<199712052246.PAA12296@harmony.village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Warner Losh writes:
...
 > BTW, there are some folks around here getting rid of Indigo's with a
 > fair amount of disk/memory on them (2G disk, 64M memory) with
 > monitors.  They are currently up for bid.  How different are these
 > beasts than the Indy?  Would Linux run on them?  What would be a fair
 > price to bid on them?

      The Indigo R4000 is pretty close to the Indy in many respects,
although the I/O and graphics are earlier generation in the same family.
The Indigo (R3000) has similar graphics and I/O, but is of course an
R3000, and the memory controller is a different design.  Linux could
run on either, but more porting would be required.  Many of the drivers
could be shared, with some adjustments, but the graphics would definitely
require significant work.
