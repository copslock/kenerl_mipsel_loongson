Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA3426401 for <linux-archive@neteng.engr.sgi.com>; Mon, 4 May 1998 10:16:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA20163973
	for linux-list;
	Mon, 4 May 1998 10:14:35 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA20102643
	for <linux@engr.sgi.com>;
	Mon, 4 May 1998 10:14:32 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id KAA11585
	for <linux@engr.sgi.com>; Mon, 4 May 1998 10:14:31 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA16103;
	Mon, 4 May 1998 13:14:21 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 4 May 1998 13:14:21 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Hanging.
In-Reply-To: <19980504085711.44483@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980504130914.11760G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 4 May 1998 ralf@uni-koblenz.de wrote:
> On Sun, May 03, 1998 at 10:15:27PM -0400, Alex deVries wrote:
> > Alright. I got it about once an hour today, which is tough to live with.
> > I think I'll go and compile RPMs on Zach's Qube instead...
> Cobalt Qube is little endian ...

I stand corrected, I'd misunderstood.

There'll be a pretty large problem with Qube users using the version of
RPM that ships with it, since those think they're 'mips', which is
actually 'mipseb' now. 

Anyone know anybody at Cobalt Micro who does their distribution
development? We need to sort this problem out somehow. Their machines
should ship with a later release of RPM, and their packages should ship
as mipsel.

Oh, and there'll be a huge batch of mipseb binary RPMs ported from the
contrib directory on ftp.redhat.com.  Details later. 

- Alex
