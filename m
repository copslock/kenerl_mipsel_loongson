Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA03811; Tue, 23 Apr 1996 13:20:59 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id NAA15112; Tue, 23 Apr 1996 13:20:53 -0700
Received: from ares.esd.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id NAA15105; Tue, 23 Apr 1996 13:20:52 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id NAA24196; Tue, 23 Apr 1996 13:20:51 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id NAA20245; Tue, 23 Apr 1996 13:20:50 -0700
Date: Tue, 23 Apr 1996 13:20:50 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199604232020.NAA20245@fir.esd.sgi.com>
To: Mike McDonald <mikemac@titian.engr.sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: David Miller is on the list 
In-Reply-To: <199604231951.MAA01292@titian>
References: <199604231951.MAA01292@titian>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike McDonald writes:
 > 
 > 
 >   A dumb question, what exactly is the purpose of porting Linux to
 > SGI/Mips boxes? At one time, it was proposed as a way that all of the
 > people how just got dropped from support to maintain there machine's
 > usefull life. Now, people are talking about embedding linux in
 > printers and Nintendo boxes! Or as an alternative to Irix on our
 > current machines. Personally, I think the port should concentrate on
 > R3K boxes with/without graphics. (It'd be nice if we could release the
 > info so that X11R6 could be built on the old boxes.) The port should
 > be a 32 bit port. (Does gcc even support 64 bit MIPS 27 ISA?) It also
 > be nice if the R3K port would also work on the R4K machines that are
 > fading away, ie. Indy's, Indigo2's.

     Different people have different motivations, and you have heard
some of them.  My main interest is in two parts.  First, on
current-production low-end workstations, I would like to compare linux
performance to IRIX performance.  If linux is much better on most
measures, in ways which matter to end users, then we would need to
consider it as a choice for low-end systems.  If it is better only in
some dimensions, then we can use it as an existence proof that there
are ways to improve IRIX in those dimensions.  It is hard to compare
software running on different hardware, but software running on
identical hardware is directly comparable.

     Second, I believe that UNIX-based systems are gratuitously incompatible,
compared to NT, and that this is an impediment to competing against NT in
low-end servers and workstations.  Since most efforts to standardize 
interfaces and administration for UNIX systems have been very slow and
incomplete, due to conflicting interests of the vendors involved, I would
like to try using linux as a vehicle for creating a de facto standard.
Where appropriate, we should give away some enabling technology, such
as Web-based administration scripts.  We really compete on application
performance.  Trying compete in areas such as administrative commands,
which are peripheral to the user's main interests, is, on balance, almost 
certainly counterproductive.  This will be even more the case as we begin
selling into larger installations (with a large number of units, not the
odd one or two systems we often sell at present).

     linux for older boxes is a fine thing, and not unduly difficult
to do, at least on the workstations, but there are a lot more
R4000-and-better boxes out there now.  As for embedded systems, there
are actually pretty decent real time systems, some with POSIX
compliance, which support MIPS processors.  I doubt that the success
of MIPS processors in embedded systems is much limited by software
availability.
