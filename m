Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA92283 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 05:06:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA65511
	for linux-list;
	Sun, 4 Oct 1998 05:05:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA54352
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Oct 1998 05:05:53 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from ruvild.bun.falkenberg.se ([194.236.80.7]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA01234
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 05:05:52 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (really [130.244.178.228]) by bun.falkenberg.se
	via in.smtpd with smtp (ident grim using rfc1413)
	id <m0zPmz7-002vJBC@ruvild.bun.falkenberg.se> (Debian Smail3.2.0.101)
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 14:09:57 +0200 (CEST) 
Date: Sun, 4 Oct 1998 14:06:40 +0200 (CEST)
From: Ulf Carlsson <grim@zigzegv.ml.org>
X-Sender: grim@calypso.saturn
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: HAL2
In-Reply-To: <m0zPnb2-000aNTC@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.981004140033.2695B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, 4 Oct 1998, Alan Cox wrote:

> > level applications. The implementation of my HAL2 driver will exist in
> > kernel space, and a user level library will provide higher level interface
> > to the applications (the same interface as libaudio.a in IRIX). Do we know
> > what the interface between libaudio.a and the Irix kernel looks like or am
> > I free to do what I want?
> > 
> > The code I've written so far is based upon this idea.
> > 
> > Is this the Right Thing to do it?
> 
> Not IMHO, well not unless it also supports the sound ioctls that every
> other Linux platform does as well. 

If you run Linux on a sparc, it provides access to an interface,
/dev/audio, similar to the one you find in Solaris (I don't have Solaris,
but the include file, asm-sparc/audioio.h tells me that it does). 

You just told me that you thought my way to do it was an incorrect way og
doing it, tell me how it should be done instead. 

- Ulf
