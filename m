Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA80213 for <linux-archive@neteng.engr.sgi.com>; Fri, 16 Oct 1998 12:46:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA27903
	for linux-list;
	Fri, 16 Oct 1998 12:45:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA95104
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 16 Oct 1998 12:45:31 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup122-1-42.swipnet.se [130.244.122.42]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09377
	for <linux@cthulhu.engr.sgi.com>; Fri, 16 Oct 1998 12:45:28 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: by zigzegv.ml.org
	via sendmail from stdin
	id <m0zUFpz-000w6YC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Fri, 16 Oct 1998 21:46:59 +0200 (CEST) 
Message-ID: <19981016214659.A2754@zigzegv.ml.org>
Date: Fri, 16 Oct 1998 21:46:59 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
To: Jeff Coffin <jcoffin@sv.usweb.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3ww618s88.fsf@lil.sv.usweb.com> <19981016001717.B2072@zigzegv.ml.org> <m3pvbt8k2y.fsf@lil.sv.usweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <m3pvbt8k2y.fsf@lil.sv.usweb.com>; from Jeff Coffin on Thu, Oct 15, 1998 at 04:46:29PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Oct 15, 1998 at 04:46:29PM -0700, Jeff Coffin wrote:

> > It would probably not make much difference, "Warning: unable to open
> > an initial console" isn't caused by a gfx board neither an old
> > kernel, but from an incorrect /dev/console. 
> 
> That's what I thought.  I was speculating that the hardware trouble
> was causing the kerel hangs.

Are we sure that the XZ chipset you have is supported? Get a newport one :)

> > I'm currently running hardhat diskless, I'm only using the IRIX
> > harddrive when I boot (the bootp command is loaded from the
> > harddrive). 
> 
> Not from the PROM?  How does that work?  (I'm new to SGI's and getting
> IRIX up at all from just a CD and a new hard drive was a "learning
> experience") 

I thought the bootp command was loaded from the IRIX partition, because it
didn't work when I removed the IRIX harddrive, atleast it didn't with my old
PROM.  It claimed that it couldn't find the bootp() command - maybe I'm out of
my mind, I'll check next time I remove the cover...

- Ulf
