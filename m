Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA58922 for <linux-archive@neteng.engr.sgi.com>; Mon, 25 Jan 1999 12:32:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA82918
	for linux-list;
	Mon, 25 Jan 1999 12:31:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA29122
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 25 Jan 1999 12:31:32 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup89-3-7.swipnet.se [130.244.89.39]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01364
	for <linux@cthulhu.engr.sgi.com>; Mon, 25 Jan 1999 15:31:26 -0500 (EST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m105y79-00158gC@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Thu, 28 Jan 1999 21:32:35 +0100 (CET) 
Date: Thu, 28 Jan 1999 21:32:35 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL2 support.
Message-ID: <19990128213235.A2872@bun.falkenberg.se>
Mail-Followup-To: Alex deVries <adevries@engsoc.carleton.ca>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990128195021.A897@bun.falkenberg.se> <Pine.LNX.3.96.990125141925.21345M-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.LNX.3.96.990125141925.21345M-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 25, 1999 at 02:27:12PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I'll merge them with a modern kernel and make sure that it all builds
> properly.  That should be done in the next 30 hours.  Woo! Finally! Kernel
> work!

As you wish. I have actually merged it before, I can send you an old patch so
you can see what it should look like.

> > And this line should actually be:
> > } *h2_ctrl = (hal2_ctrl_regs *) KSEG1ADDR(H2_CTRL_PIO);
> 
> Okay.  Why's that?

Because it has to be in the virtual address space.

> Anyway, I'll get this code into the kernel so we have a way to debug it in
> a distributed fashion.  It's clear there'll be problems with it; we'll get
> through that over time.

Great..

- Ulf
