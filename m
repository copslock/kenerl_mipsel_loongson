Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA41049 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 10:33:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA28335
	for linux-list;
	Fri, 17 Jul 1998 10:31:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA64289;
	Fri, 17 Jul 1998 10:31:13 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA10016; Fri, 17 Jul 1998 10:30:59 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id TAA28341;
	Fri, 17 Jul 1998 19:29:57 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA01837; Fri, 17 Jul 1998 19:29:55 +0200
Message-ID: <19980717192954.16464@uni-koblenz.de>
Date: Fri, 17 Jul 1998 19:29:54 +0200
From: ralf@uni-koblenz.de
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        Igor Loncarevic <anubis@BanjaLuka.NET>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: What about...
References: <Pine.LNX.3.95.980717012356.5792A-100000@lager.engsoc.carleton.ca> <adevries@engsoc.carleton.ca> <9807162230.ZM17359@xtp.engr.sgi.com> <199807171411.HAA11412@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199807171411.HAA11412@fir.engr.sgi.com>; from William J. Earl on Fri, Jul 17, 1998 at 07:11:42AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 17, 1998 at 07:11:42AM -0700, William J. Earl wrote:

> Greg Chesson writes:
>  > Alex is right.
>  > Linux on Origin 2000 would be a huge project - not just a port.
> ...
> 
>      Note that the reason it would be a big project is not so much the
> hardware itself, but rather the scale of the system.  IRIX needed a lot
> of infrastructure work to be useful on very large system with a very large
> number of I/O buses and devices.  That is, a toy port would not be all
> that giant a project, but it would not be particularly useful.  If there
> were a good linux on some other very large ccNUMA machine, then an Origin
> port would be much simpler.  By "good", I mean a linux which scale well
> for large (greater than 32) processor and I/O count (many I/O buses
> and thousands of disk).  It expect such a linux will happen eventually,
> but not yet.

Actually some people begin to be interested in Linux for huge installations.
For example a bank recently offer us some machine time on a maximum
configuration (64 CPU, 64GB RAM) E10000 for porting Linux.  This didn't
happen (yet?) for other reasons, but it shows that there is interest.

For the time being most large Linux installations are based on the Beowulf
clustering software - and I think place 318 on the list on the top 500 list
of supercomputer installations is quite remarkable for something which's
OS software is being shipped for USD 29.95 by RedHat.

Anyway, as far as our MIPS port goes we first need to implement SMP at
all before we should think about scaling.  More about Linux in general -
most people are currentl using Linux/SMP on dual processors, few on
quad CPU systems and even fewer on larger systems.  This is about where
the market of Linux and it's limits are.  But the tradition of Linux
shows that technology for which a demand exists will be developed sooner
or later.  Where Linux technology exists, usually a market will develop.
So far I see a demand for older SGI SMP systems, Origin 200 systems (quite
some inquiries) but not yet for Origin 2000 systems.

  Ralf
