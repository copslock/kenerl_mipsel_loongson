Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA25523 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 07:12:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA69624
	for linux-list;
	Fri, 17 Jul 1998 07:11:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id HAA34220;
	Fri, 17 Jul 1998 07:11:53 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id HAA11412; Fri, 17 Jul 1998 07:11:42 -0700
Date: Fri, 17 Jul 1998 07:11:42 -0700
Message-Id: <199807171411.HAA11412@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Igor Loncarevic <anubis@BanjaLuka.NET>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: What about...
In-Reply-To: <9807162230.ZM17359@xtp.engr.sgi.com>
References: <Pine.LNX.3.95.980717012356.5792A-100000@lager.engsoc.carleton.ca>
	<adevries@engsoc.carleton.ca>
	<9807162230.ZM17359@xtp.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Greg Chesson writes:
 > Alex is right.
 > Linux on Origin 2000 would be a huge project - not just a port.
...

     Note that the reason it would be a big project is not so much the
hardware itself, but rather the scale of the system.  IRIX needed a lot
of infrastructure work to be useful on very large system with a very large
number of I/O buses and devices.  That is, a toy port would not be all
that giant a project, but it would not be particularly useful.  If there
were a good linux on some other very large ccNUMA machine, then an Origin
port would be much simpler.  By "good", I mean a linux which scale well
for large (greater than 32) processor and I/O count (many I/O buses
and thousands of disk).  It expect such a linux will happen eventually,
but not yet.
