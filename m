Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2692900 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 15:18:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA7091077
	for linux-list;
	Thu, 2 Apr 1998 15:15:12 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA7086217;
	Thu, 2 Apr 1998 15:15:04 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA01986; Thu, 2 Apr 1998 15:15:03 -0800
Date: Thu, 2 Apr 1998 15:15:03 -0800
Message-Id: <199804022315.PAA01986@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
In-Reply-To: <19980403003623.50122@uni-koblenz.de>
References: <19980402225314.63238@uni-koblenz.de>
	<199804022141.NAA01565@fir.engr.sgi.com>
	<19980403003623.50122@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Thu, Apr 02, 1998 at 01:41:02PM -0800, William J. Earl wrote:
 > 
 > >  > Another way to finally eleminate the virtual coherency problem from
 > >  > KSEG0's landscape would be to actually use 8 pages as an array of
 > >  > empty_zero_pages[], so we would be able to map one wherever we want
 > >  > such that we never run into virtual coherency trouble.
 > > 
 > >       For an always-zero page, this is the best solution.  At a small
 > > cost in memory, you get far less overhead.
 > 
 > Indeed, 16ns on a 250Mhz machine for every exception that goes via the
 > general exception vector _plus_ the actual vce / vci handling, that sucks.
 > I just wonder why those exceptions have been implemented at all?
 > 
 > They may help somewhat in debugging operating systems, but in our situation
 > they're nervragging by their mere existance.

     In the R10000, the hardware does the VCE correction.  On the R4000PC, R4600,
and R5000, we have to avoid the problem in software, since the hardware
does not detect conflicts.   The motivation, and the reason that IRIX
depends on VCEs on the R4000 and R4400, was to make it easier to port
R3000 operating systems to the R4000.  If you don't have infrastructure
to control virtual aliasing (where a single page is mapped read-write at
two distinct virtual addresses with differing primary cache virtual indexes),
you get wrong answers with VCE (whether handled in software or hardware).
At MIPS, with the Magnum 4000PC under RISC/os, and at SGI, with the
Indy R4000PC (and later R4600 and R5000), I modified RISC/os and IRIX to
control virtual aliasing, but only for those platforms without hardware
VCE detection (in order to minimize time to market).  

    Note that taking a K0SEG address for a physical page which is also mapped
to user space can easily cause a VCE, since there is a good chance that
the K0SEG virtual index differs from the user space virtual index, unless
you match physical page color to virtual page color when allocating pages.
Note that you have to do that for any pages which must be accessible in
the general exception handler, since you cannot handle a VCE in the
exception handler.
