Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA83741 for <linux-archive@neteng.engr.sgi.com>; Mon, 25 Jan 1999 11:27:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA16687
	for linux-list;
	Mon, 25 Jan 1999 11:26:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA09840
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 25 Jan 1999 11:26:03 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03738
	for <linux@cthulhu.engr.sgi.com>; Mon, 25 Jan 1999 14:26:01 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA04677;
	Mon, 25 Jan 1999 14:27:12 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 25 Jan 1999 14:27:12 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ulf Carlsson <ulfc@bun.falkenberg.se>
cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL2 support.
In-Reply-To: <19990128195021.A897@bun.falkenberg.se>
Message-ID: <Pine.LNX.3.96.990125141925.21345M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 28 Jan 1999, Ulf Carlsson wrote:
> > Do you mind if I cvs upload them to the SGI kernel mailing list?
> CVS upload them to the mailing list, I don't get your point here. I have CVS
> access so I may upload them if I want to, and I can post it to the mailing list
> if you want me to. But it feels like too much people would laugh at me if I
> posted it at the moment.. I'll atleast get it through the compiler once again.

I'll merge them with a modern kernel and make sure that it all builds
properly.  That should be done in the next 30 hours.  Woo! Finally! Kernel
work!

> Does something else bother you than the incorrect type? I can't see anything
> else being wrong here.

No, but I just scanned the code quickly.

> And this line should actually be:
> } *h2_ctrl = (hal2_ctrl_regs *) KSEG1ADDR(H2_CTRL_PIO);

Okay.  Why's that?

Anyway, I'll get this code into the kernel so we have a way to debug it in
a distributed fashion.  It's clear there'll be problems with it; we'll get
through that over time.

- Alex
