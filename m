Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA61752; Fri, 18 Jul 1997 11:44:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA23194 for linux-list; Fri, 18 Jul 1997 11:43:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA23180 for <linux@engr.sgi.com>; Fri, 18 Jul 1997 11:43:54 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA12218
	for <linux@engr.sgi.com>; Fri, 18 Jul 1997 11:43:53 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id OAA07214; Fri, 18 Jul 1997 14:43:30 -0400
Date: Fri, 18 Jul 1997 14:43:30 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Shaver <shaver@neon.ingenia.ca>
cc: Linux/SGI list <linux@cthulhu.engr.sgi.com>
Subject: Re: Pointers on how to get started
In-Reply-To: <199707181813.OAA20228@neon.ingenia.ca>
Message-ID: <Pine.LNX.3.95.970718142505.27101O-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 18 Jul 1997, Mike Shaver wrote:
> Thus spake Alex deVries:
> > How are things on the native booting front?
> 
> I can boot bogomips off of local disk, but I'm seeing some wierdness
> with users and groups that I can't explain (via NFS and ext2).  I'd
> like to get strace working so I can debug it more.

Further questions:

1. What's a good kernel to use for this, and can someone tell me where I
can find a pre-compiled version of it? I suspect until the problems on
2.1.45 are fixed, newbies should be using something older.

2. Could someone either produce an RPM for an xcompiling gcc host=i386
target=mips-linux, or send me a tarball?  I'd be happy to make it into an
RPM.  Same goes for binutils.

3. Exactly what hardware will this run on?  All I've heard thus far is
work on SGI Indy's.  Has there been any expereience on anything else?  I
know Ralf has run Linux on a lot of different MIPS machines, but for the
sake of SGI Linux I think we should restrict ourselves to SGI only
hardware.

4. Can someone tell me about how to configure an Indy to boot via bootp? I
don't yet have access to manuals.

- Alex
