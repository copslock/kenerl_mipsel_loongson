Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA67933 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Apr 1999 12:25:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA73210
	for linux-list;
	Tue, 13 Apr 1999 12:23:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA37366
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Apr 1999 12:23:47 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup89-6-10.swipnet.se [130.244.89.90]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA07177
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 12:23:45 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id VAA26056;
	Tue, 13 Apr 1999 21:23:14 +0200
Date: Tue, 13 Apr 1999 21:23:13 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Isaacson <adisaacs@mtu.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: Resources in X11 port
Message-ID: <19990413212313.A26025@bun.falkenberg.se>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Isaacson <adisaacs@mtu.edu>, linux@cthulhu.engr.sgi.com
References: <19990413125254.A20170@mtu.edu> <m10X8aD-0007TvC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <m10X8aD-0007TvC@the-village.bc.nu>; from Alan Cox on Tue, Apr 13, 1999 at 08:10:52PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Apr 13, 1999 at 08:10:52PM +0100, Alan Cox wrote:
> > If you (the porters) are willing to wait until June to have publicly
> > distributable code, you should develop for the 4.0 branch rather than
> > the 3.3 branch.  There are a lot of useful new features in the new
> > code base, and the new design is quite a bit easier to code for than
> > the old.
> 
> Actually I wonder if it will be.

I got an email from the X team today which told me that pulic release date for
a beta snapshot of 4.0 still is set to June.

> Not having seen the code because of the silly XFree about beta releases its
> hard to be sure. The X folks I talked to all pointed me at the 8514 driver -
> which is very similar in many ways to the SGI cards - both are designed for
> X11, both have no direct frame buffer access and they have fairly similar
> concepts.

That 8514 driver is certainly a good driver to look at while writing a driver
for the SGI cards, but it's generally a bad idea to just rip the code off. I
have at least not had much luck doing success hacks.

The 8514 driver is also a quite old driver and it's not using the new interfaces
in for Xserver.

> I would urge btw that anyone working on an XFree SGI driver releases it under
> a license like the NPL so that the XFree people can't hide it in a locked away
> beta release in future.

The copyright still remains to the person who wrote the code, and even if the
code is locked away in a beta release, it's possible for the writer himself to
make his own code public (i think).

- Ulf
