Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3460560 for <linux-archive@neteng.engr.sgi.com>; Fri, 1 May 1998 12:46:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA18718654
	for linux-list;
	Fri, 1 May 1998 12:45:50 -0700 (PDT)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id MAA17161629;
	Fri, 1 May 1998 12:45:48 -0700 (PDT)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id MAA23172; Fri, 1 May 1998 12:45:48 -0700
Date: Fri, 1 May 1998 12:45:48 -0700
Message-Id: <199805011945.MAA23172@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Hanging.
In-Reply-To: <Pine.LNX.3.95.980501153605.22853E-100000@lager.engsoc.carleton.ca>
References: <199805011929.MAA23116@fir.engr.sgi.com>
	<Pine.LNX.3.95.980501153605.22853E-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > On Fri, 1 May 1998, William J. Earl wrote:
 > >      Is this an R4000?  If so, it might be the count/compare erratum, if
 > > the linux kernel does not have the workaround for it yet.  (I haven't
 > > checked the linux sources.)
 > 
 > This is an R4600.  How would I check if there were that patch applied?

     The problem I have in mind cannot occur on an R4600.  The modification
is to the routine which fetches $count.  On the R4000, if you are depending
on the $compare match interrupt, you have to check for the possibility
that $count equalled $compare when you fetched it, since that causes
the interrupt to not happen.  In that case, you have to fake the
interrupt in some way, or have to wait for $count to wrap (about 84 seconds
at 100 MHZ).  IRIX just checks to see if the fetched copy of $count
is close to a shadow copy $compare.  If it is, and if the clock interrupt
request bit is off (this being done with interrupts disabled), we
set $compare a little head of the current $count and spin until the
interrupt bit goes on (with some care to avoid getting stuck if we
lose the race in terms of setting $compare ahead of $count).  Again,
all this only applies to the R4000, not to the R4400, R4600, or R5000.
