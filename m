Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA2315508 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 20:31:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id UAA15382610
	for linux-list;
	Wed, 22 Apr 1998 20:29:49 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA15401870
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 20:29:47 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id UAA19420
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 20:29:37 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA16862;
	Wed, 22 Apr 1998 23:28:52 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 22 Apr 1998 23:28:52 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
In-Reply-To: <19980423051757.03333@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980422232333.13362D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 23 Apr 1998 ralf@uni-koblenz.de wrote:
> > > Alex, still working on porting Redhat 5.0?  5.1 ante portas ...
> > When the 5.1 SRPMs start rolling out by the end of the month, I'll start
> > building them. I'vea 'spare' 3GB SCSI disk, so things should be a lot
> > easier to do than last time. It would be ultra cool if we could get the
> > whole thing ported over a number of days after RH 5.1 comes out.
> 
> Ok.  In that case we should add a fat readme that RH 5.0 is incomplete and
> 4.9.1 should be used or maybe even rm -rf redhat-5.0/.  It's confusing
> people.

Yes, it is confusing.  Especially because there are just gaping holes in
packages (like glibc) for 5.0.  

But I wouldn't say that 5.0 is broken, just that the missing things need
to come from 4.9.1.

Anyway, it'll all be fixed when we go through and redo all of 5.1.  We can
make sure that we include everything like glibc.

> > Hm.  I also have a Mac IIcx to distract me.
> Your Indy is _way_ faster than that brick ;-)

It's amazing how hack value can outshine performance. Some people think
it's what keeps the i386 port of Linux alive.

- Alex
