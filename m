Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA49508 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 11:21:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA64800
	for linux-list;
	Fri, 17 Jul 1998 11:20:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA82176;
	Fri, 17 Jul 1998 11:20:31 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA12327; Fri, 17 Jul 1998 11:19:54 -0700
Date: Fri, 17 Jul 1998 11:19:54 -0700
Message-Id: <199807171819.LAA12327@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Greg Chesson" <greg@xtp.engr.sgi.com>
Cc: ralf@uni-koblenz.de, Alex deVries <adevries@engsoc.carleton.ca>,
        Igor Loncarevic <anubis@BanjaLuka.NET>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: What about...
In-Reply-To: <9807171101.ZM18755@xtp.engr.sgi.com>
References: <Pine.LNX.3.95.980717012356.5792A-100000@lager.engsoc.carleton.ca>
	<adevries@engsoc.carleton.ca>
	<9807162230.ZM17359@xtp.engr.sgi.com>
	<199807171411.HAA11412@fir.engr.sgi.com>
	<19980717192954.16464@uni-koblenz.de>
	<9807171101.ZM18755@xtp.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Greg Chesson writes:
...
 > Linux has proven to be worthwhile as a node controller in an MPP architecture -
 > that's what a Beowolf is.  But that does not make it ready for SMP nodes
 > that scale to large numbers.  It seems wasteful to program a large scale
 > ccNUMA machine the same way as a Beowolf cluster: you'd be throwing away
 > most of the capabilities of the hardware.  That's why I don't
 > think it is interesting or particularly useful... unless a massive amount
 > of work went into rewriting the io and memory management subsystems,
 > not to mention scheduling, administration, etc.
...

     I expect that much of the work will gradually happen in linux, once
the remaining small-CPU-count issues are resolved.  Right now, there
is no shortage of interesting problems to attack.  :-)

     One possible way to approach the large-CPU-count space with linux
is to indeed run multiple linux kernels, one per node in a ccNUMA
machine, and add a distributed OS layer at a fairly high level.  If it
is not underway already somewhere, I would expect someone to take up
the project as a graduate school project.  Some systems of this sort
have been built or attempted, with varying degrees of success.  Given
the linux bias toward small and simple, a linux-based distributed OS
might actually work.

     One important ingredient in such a system, which would be
valuable immediately for clusters, would be a efficient distributed
volume manager and file system.  

     In any case, trying to port linux straight to a large ccNUMA 
(or even a large SMP) system would be a lot of effort for limited
return at present.
