Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3711489 for <linux-archive@neteng.engr.sgi.com>; Mon, 4 May 1998 12:33:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA19245003
	for linux-list;
	Mon, 4 May 1998 12:32:34 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA20141573
	for <linux@engr.sgi.com>;
	Mon, 4 May 1998 12:32:32 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA11211
	for <linux@engr.sgi.com>; Mon, 4 May 1998 12:32:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-13.uni-koblenz.de [141.26.249.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA11041
	for <linux@engr.sgi.com>; Mon, 4 May 1998 21:32:19 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA08277;
	Mon, 4 May 1998 21:32:05 +0200
Message-ID: <19980504213205.32754@uni-koblenz.de>
Date: Mon, 4 May 1998 21:32:05 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: tim@cobaltmicro.com, linux@cthulhu.engr.sgi.com
Subject: Re: Hanging.
References: <19980504085711.44483@uni-koblenz.de> <Pine.LNX.3.95.980504130914.11760G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980504130914.11760G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, May 04, 1998 at 01:14:21PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, May 04, 1998 at 01:14:21PM -0400, Alex deVries wrote:

> On Mon, 4 May 1998 ralf@uni-koblenz.de wrote:
> > On Sun, May 03, 1998 at 10:15:27PM -0400, Alex deVries wrote:
> > > Alright. I got it about once an hour today, which is tough to live with.
> > > I think I'll go and compile RPMs on Zach's Qube instead...
> > Cobalt Qube is little endian ...
> 
> I stand corrected, I'd misunderstood.
> 
> There'll be a pretty large problem with Qube users using the version of
> RPM that ships with it, since those think they're 'mips', which is
> actually 'mipseb' now. 
> 
> Anyone know anybody at Cobalt Micro who does their distribution
> development? We need to sort this problem out somehow. Their machines
> should ship with a later release of RPM, and their packages should ship
> as mipsel.

I cc this to Tim.  DaveM is also reading this list, so they'll know.
The problem isn't too bad.  One new rpm binaries have been installed those
will know about mipsel/mipseb.  And we _had_ to break compatibility,
remember the purpose was to make the two flavours and the old ``mips''
flavour different and distinguishable from each other.

If this ends up being a problem one can still add apropriate entries to
/usr/lib/rpmrc or using the --ignore-arch option.

> Oh, and there'll be a huge batch of mipseb binary RPMs ported from the
> contrib directory on ftp.redhat.com.  Details later. 

Cool.

  Ralf
