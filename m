Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2828667 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 14:08:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA7532777
	for linux-list;
	Fri, 3 Apr 1998 14:07:59 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id OAA7530199;
	Fri, 3 Apr 1998 14:07:55 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA21512; Fri, 3 Apr 1998 14:07:50 -0800
Date: Fri, 3 Apr 1998 14:07:50 -0800
Message-Id: <199804032207.OAA21512@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-kernel@vger.rutgers.edu
Subject: Re: VCE exceptions
In-Reply-To: <19980403232741.05512@uni-koblenz.de>
References: <19980402225314.63238@uni-koblenz.de>
	<199804022141.NAA01565@fir.engr.sgi.com>
	<19980403003623.50122@uni-koblenz.de>
	<199804022315.PAA01986@fir.engr.sgi.com>
	<19980403135245.23593@uni-koblenz.de>
	<199804031911.LAA21028@fir.engr.sgi.com>
	<19980403232741.05512@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > Anyway, we have to deal with the problem and I'm going to hope the people
 > that actually have machines with SC/MC CPUs were the hardware detects the
 > problem for us will help me by running test kernels.
...

     They can help by having the hardware show some of the cases where
the software is doing the wrong thing, but a reliable system will require
a solution which works on an R5000 or R4600, where there is no hardware detection.
That is, in most cases where an R4000SC would give you a VCE, an R5000 will
give you corrupted data (in general, not every time).  The solution needs
to be correct by construction, not by testing.
