Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA81595 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 18:58:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA30280
	for linux-list;
	Fri, 17 Jul 1998 18:58:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA62135;
	Fri, 17 Jul 1998 18:57:36 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA10789; Fri, 17 Jul 1998 18:57:34 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA16818;
	Sat, 18 Jul 1998 03:57:29 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA01512;
	Sat, 18 Jul 1998 03:57:15 +0200
Message-ID: <19980718035715.D378@uni-koblenz.de>
Date: Sat, 18 Jul 1998 03:57:15 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>,
        Greg Chesson <greg@xtp.engr.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        Igor Loncarevic <anubis@BanjaLuka.NET>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: What about...
References: <Pine.LNX.3.95.980717012356.5792A-100000@lager.engsoc.carleton.ca> <adevries@engsoc.carleton.ca> <9807162230.ZM17359@xtp.engr.sgi.com> <199807171411.HAA11412@fir.engr.sgi.com> <19980717192954.16464@uni-koblenz.de> <9807171101.ZM18755@xtp.engr.sgi.com> <199807171819.LAA12327@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199807171819.LAA12327@fir.engr.sgi.com>; from William J. Earl on Fri, Jul 17, 1998 at 11:19:54AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 17, 1998 at 11:19:54AM -0700, William J. Earl wrote:

>      I expect that much of the work will gradually happen in linux, once
> the remaining small-CPU-count issues are resolved.  Right now, there
> is no shortage of interesting problems to attack.  :-)

Actually I'd hate it if Linux'd be ``finished'' ...

>      One possible way to approach the large-CPU-count space with linux
> is to indeed run multiple linux kernels, one per node in a ccNUMA
> machine, and add a distributed OS layer at a fairly high level.  If it
> is not underway already somewhere, I would expect someone to take up
> the project as a graduate school project.  Some systems of this sort
> have been built or attempted, with varying degrees of success.  Given
> the linux bias toward small and simple, a linux-based distributed OS
> might actually work.

I don't know the exact technical details but something similar has already
been done back in '95 (?) when some guys in Australia ported Linux to
Fujitsu's AP1000.  That's of course a different architecture and a
multikernel approach makes much more sense there.

>      One important ingredient in such a system, which would be
> valuable immediately for clusters, would be a efficient distributed
> volume manager and file system.  

Hans Reiser is currently working on a new filesystem with alot of fresh
ideas.  In some aspects what he is aiming at is similar to XFS, in some
aspects not.  He basically started on a white sheet of paper with his design,
so his team's code isn't contaminated by old ideas.  His work looks pretty
promising.  Among his plans is also the implementation of a distributed
filesystem.  Current benchmarks are looking pretty good, in fact in
some cases extremly good.  The URL to checkout for interested people is
http://idiom.com/~beverly/reiserfs.html.

>      In any case, trying to port linux straight to a large ccNUMA 
> (or even a large SMP) system would be a lot of effort for limited
> return at present.

Explecitly not talking about the MIPS port - I think it makes sense in
working on porting to machines beyond what we currently scale to.  But
I agree about the ``large'' thing.

  Ralf
