Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA462876 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Dec 1997 16:20:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA10013 for linux-list; Fri, 5 Dec 1997 16:18:14 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA09933 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Dec 1997 16:18:02 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA08523
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Dec 1997 16:17:57 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA16538;
	Fri, 5 Dec 1997 19:15:18 -0500
Date: Fri, 5 Dec 1997 19:15:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
To: RPM-List <rpm-list@redhat.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: A question about architecture and byte order.
In-Reply-To: <Pine.LNX.3.95.971202130437.18862D-100000@lacrosse.redhat.com>
Message-ID: <Pine.LNX.3.95.971205184148.13449G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, 2 Dec 1997, Erik Troan wrote:
> No you're probably right -- I just know nothing about mips ;-) Any objections
> to a mipsel arch folks?

There's been no objections to having a mipsel architecture, so it's safe
to assume that we can go ahead.

Because this isn't reported in uname, there'll have to be some additions
made to ./configure to test the default byte order, and set the arch to
mips or mipsel accordingly. 

Also, it looks like there's going to have to be some work done on
lib/rpmrc.c in defaultMachine().

I'll work on patches for those over the weekend, they shouldn't be
difficult to do.

Now, as for mipsbi, the architecture that would be able to run both mips
and mipsel... I think the only way to test this is to attempt to run
binaries of both byteorders.  I don't quite know how to do this without
including precompiled binaries of both byteorders.  Maybe something like
including a precompiled stream of bytes.  It'll be ugly, though.  Please
let me know if you know of a non-OS specific way of doing this.

- A


      Alex deVries          Rent this space for a $5 donation 
  System Administrator      to EngSoc per day.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
