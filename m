Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA44634 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 11:02:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA80204
	for linux-list;
	Fri, 17 Jul 1998 11:01:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA27969
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 11:01:45 -0700 (PDT)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id LAA18757; Fri, 17 Jul 1998 11:01:43 -0700
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9807171101.ZM18755@xtp.engr.sgi.com>
Date: Fri, 17 Jul 1998 11:01:42 -0700
In-Reply-To: ralf@uni-koblenz.de
        "Re: What about..." (Jul 17,  7:29pm)
References: <Pine.LNX.3.95.980717012356.5792A-100000@lager.engsoc.carleton.ca> 
	<adevries@engsoc.carleton.ca> 
	<9807162230.ZM17359@xtp.engr.sgi.com> 
	<199807171411.HAA11412@fir.engr.sgi.com> 
	<19980717192954.16464@uni-koblenz.de>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: ralf@uni-koblenz.de, "William J. Earl" <wje@fir.engr.sgi.com>
Subject: Re: What about...
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        Igor Loncarevic <anubis@BanjaLuka.NET>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf,

Beowolf machines don't have adequate IO for applications other than
things that resemble Linpack.  The teraflop machine at Sandia would like
to generate output every 5 or 10 minutes, but it takes an hour to get
the computation result out of the machine. Beowolf machines tend to not
have adequate bisection bandwidth more many kinds of codes.  Anything that
requires a cornerturn (transpose) is a good example.  Also, Beowolf machines
tend to run a single code for many hours: they don't multiplex well,
or sometimes at all.  But multiplexing and adapting to a dynamic load
is expected of many large scale machines and that requires some OS support
not found in the single-cpu or small-cpu-count OS or existing middleware.

 We cannot afford to build
machines that are good only for Linpack.... it is better
to build a Beowolf cluster if that is the best fit for the job.
It is rather ignorant to think that because something like Beowolf can do some
some types of applications well, that some software work can make it do
all jobs well.  That's like saying a Volkswagon could go 300 kph
if you drive carefully.

Linux has proven to be worthwhile as a node controller in an MPP architecture -
that's what a Beowolf is.  But that does not make it ready for SMP nodes
that scale to large numbers.  It seems wasteful to program a large scale
ccNUMA machine the same way as a Beowolf cluster: you'd be throwing away
most of the capabilities of the hardware.  That's why I don't
think it is interesting or particularly useful... unless a massive amount
of work went into rewriting the io and memory management subsystems,
not to mention scheduling, administration, etc.

g


-- 
Greg Chesson
