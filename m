Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA69264 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 09:30:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA76767
	for linux-list;
	Tue, 26 Jan 1999 09:29:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA76293
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Jan 1999 09:29:53 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup84-9-2.swipnet.se [130.244.84.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA01282
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Jan 1999 09:29:50 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m105CBI-00158gC@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Tue, 26 Jan 1999 18:21:40 +0100 (CET) 
Date: Tue, 26 Jan 1999 18:21:40 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Parallel port support.
Message-ID: <19990126182139.B414@bun.falkenberg.se>
Mail-Followup-To: Alex deVries <adevries@engsoc.carleton.ca>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <Pine.LNX.3.96.990126120139.12068J-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.LNX.3.96.990126120139.12068J-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Jan 26, 1999 at 12:03:08PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I've never seen any documentation of the parallel port that hangs off of

I'm curious as well.

> I'm thinking this is a pretty easy device driver to write for testing that
> the pbus code works well.  It'd help out with HAL2 support.

We don't need any special support for the PBUS when it comes to HAL2, and
there's no special PBUS code written. Everything is done directly by
reading/writing to the PBUS PIO registers, and they don't need any kind of
setup. This is not difficult at all. What's more complicated is to setup the
PBUS DMA, but the parallel port doesn't use DMA.

It would be nice to have parallel port support, but the reason to write it is
_not_ to make it easier to build the HAL2 driver. Write it anyway :)

- Ulf
