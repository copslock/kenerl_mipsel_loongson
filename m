Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA01257; Thu, 20 Jun 1996 11:12:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA16912 for linux-list; Thu, 20 Jun 1996 18:12:23 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA16875 for <linux@cthulhu.engr.sgi.com>; Thu, 20 Jun 1996 11:12:20 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA01241 for <linux@neteng.engr.sgi.com>; Thu, 20 Jun 1996 11:12:19 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id LAA24562; Thu, 20 Jun 1996 11:12:19 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id LAA24532; Thu, 20 Jun 1996 11:12:17 -0700
Date: Thu, 20 Jun 1996 11:12:17 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606201812.LAA24532@fir.esd.sgi.com>
To: alambie@wellington.sgi.com (Alistair Lambie)
Cc: linux@neteng.engr.sgi.com
Subject: Re: Kernel doesn't work on 200MHz Indy
In-Reply-To: <199606201102.XAA02623@soyuz.wellington.sgi.com>
References: <199606201102.XAA02623@soyuz.wellington.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie writes:
 > Just incase anyone is interested:
 > 
 > I was able to boot Davids kernel on my Indy when I only had a 100MHz R4600PC,
 > but know I've upgraded to a 200MHz R4400SC it dies!  Looks like something
 > to do with the memory controller...

      There is no way the kernel could work on an R4000 or R4400 without 
changes to the cache routines, as well as the addition of certain workarounds
for processor errata.  Stick to R4600 and R5000 processors for the time being.
I asked David to start with the R4600, because the workarounds for the errata
are far simpler, and because it and the R5000 are the volume processors for
Indy.  It will not be all that hard to add R4000 and R4400 support, but there
are several messy workarounds to implement, so it is more interesting to get
a complete system working on an R4600 or R5000.

...
 > PS - It only gives a BogoMIPS reading of 103.63, which is around what I got
 >      when it was a 100MHz chip.

      That is to be expected.  BogoMIPS is essentiall 2 times the number of
times one can execute a loop like this:

	la	a0,0x7FFFFFFF
1:	bltz	a0,1b
	addu	a0,-1

On an R3000, R4600, or R5000, the branch executes in two cycles (counting one
for the branch delay slot), so BogoMIPS equals the processor clock rate.
On an R4000 or R4400, the branch executes in four cycles (counting one for
the branch delay slot), so BogoMIPS equals one half the processor clock rate.
There appears to be a small error in the current logic for calibrating
the processor clock rate, which accounts for the BogoMIPS being 103.63 instead
of 100.00.
