Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA3148819 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 May 1998 19:15:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA19358994
	for linux-list;
	Sun, 3 May 1998 19:13:26 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA19793267
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 3 May 1998 19:13:23 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id TAA13001
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 May 1998 19:13:22 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA27715;
	Sun, 3 May 1998 22:13:17 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 3 May 1998 22:13:17 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 updated RPMS for SGI/Linux
In-Reply-To: <19980503144744.11223@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980503220946.26416B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 3 May 1998 ralf@uni-koblenz.de wrote:
> On Sat, May 02, 1998 at 08:56:08PM -0400, Alex deVries wrote:
> > > >    ld.so-1.9.5-2.mipseb.rpm
> It actually be changed to prevent it from being building on MIPS and others
> which have no use for it.

Yup.  I'll get those fixes in.

> Does this mean that the mipsel/mipseb modifications are now distributed with
> RedHat's sources?

Not now, and not in RH 5.1.  Once RH 5.1 is out, I'll be feeding fixes
back to RH.  Both Erik Troan and Alan have said they'll handle fixes.

- Alex
