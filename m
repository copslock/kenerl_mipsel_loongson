Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA21828; Fri, 20 Jun 1997 01:56:15 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA18012 for linux-list; Fri, 20 Jun 1997 01:55:47 -0700
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA18005 for <linux@cthulhu.engr.sgi.com>; Fri, 20 Jun 1997 01:55:44 -0700
Received: (from fisher@localhost) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) id BAA14655; Fri, 20 Jun 1997 01:55:39 -0700
From: fisher@hollywood.engr.sgi.com (William Fisher)
Message-Id: <199706200855.BAA14655@hollywood.engr.sgi.com>
Subject: Re: Getting X on Linux/SGI
To: lm@neteng.engr.sgi.com (Larry McVoy)
Date: Fri, 20 Jun 1997 01:55:31 -0800 (PDT)
Cc: sca@refugee.engr.sgi.com, carlson@heaven.newport.sgi.com,
        linux@cthulhu.engr.sgi.com,
        fisher@hollywood.engr.sgi.com (William Fisher)
In-Reply-To: <199706200734.AAA18987@neteng.engr.sgi.com> from "Larry McVoy" at Jun 20, 97 00:34:26 am
Reply-To: fisher@sgi.com
X-Mailer: ELM [version 2.4 PL3]
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> : "Christopher W. Carlson" <carlson@heaven.newport.sgi.com> writes:
> : >My point was that SGI is into making hardware.  That's how it started
> : >and that is still its main focus.  Yes, it is true that our software
> : >is very important because it takes advantage of the proprietary stuff
> : >in the hardware, but the main income for SGI is hardware.
> : 
> : How many people buy the hardware and program the bare metal?
> 
> We own MIPS.  MIPS sold or licensed 19.2 million chips last year.  About
> 19 million of those were of the type "program the bare metal".
> 
> Much of the Linux/MIPS interest is for embedded systems.  We should have
> done this years ago, there is no reason why not to do it other than NIH.
> 
	If the demand for Linux on MIPS chips is comming from the "embedded"
	systems then things sure have changed since the early days of
	MIPS Computer Systems. The embedded market in 1992-1996 was
	NOT asking us for Linux, since it was very sensitive to running
	small real-time kernels. In fact nearly all of the original
	chips vendors who licensed the chips used the PROM code, remote
	dbx, compilers, etc. which were sold/licensed to the chip vendors
	for resell to the embedded customers.

	If fact the original VP of embedded system marketing at MIPS was
	Chet Silvestri, now VP of SPARC embedded systems at SUN. Chet
	was very familar with embedded systems having worked at Intel
	on numerous automobile systems, real-time process control, etc.
	
	Nearly all of those systems were nearly bare metal software
	environments since we had numerous talks with Chet at MIPS
	about software features that would propell the business.
	NONE of those customers wanted anything to do with any flavor
	of Unix, Linux, BSD, System V, etc.

	In fact Hunter-Ready and the other real-time kernels weren't that
	popular with the hard core real-time/embedded folks.

	Hence I would like to here more about larry's definition of
	"embedded systems" because they sure don't sound like any
	that our semiconductor partners sell to.

	I would like to see Linux on the low end of the SGI workstations
	for two reasons; One as an existance proof that a lightweigth
	Unix can be shown to run very fast on our hardware and secondly
	for sale to either universities or other research labs that want
	source code and want to hack. I don't think it will sell that many
	machines but it can't hurt.

	I personally believe that the popularity of Linux on ALPHA is
	pushed by the Digital Semiconductor Division and they will do
	anything to sell chips and Digital systems. I think it is
	similar behavior that you see in both IBM's Semiconductor Division
	and at the Motorola's Semiconductor Division with the PowerPC.
	That being they have no particular religion on any software or
	OS, anything that moves chips is alright with them.

-- Bill
