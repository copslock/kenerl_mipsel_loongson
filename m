Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA495907 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Feb 1998 15:19:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA29610 for linux-list; Wed, 25 Feb 1998 15:19:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29560 for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 15:19:21 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA12722
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 15:19:17 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA08467;
	Wed, 25 Feb 1998 18:19:17 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 25 Feb 1998 18:19:17 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Shaver <shaver@netscape.com>
cc: Ulf Carlsson <grimsy@varberg.se>, linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <34F4A1E2.4E6E6A28@netscape.com>
Message-ID: <Pine.LNX.3.95.980225181711.28713D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 25 Feb 1998, Mike Shaver wrote:
> Ulf Carlsson wrote:
> > Great, but can't someone put a precompiled _new_ kernel somewhere on
> > ftp.linux.sgi.com since everyone can't crosscompile?
> My xcompiler setup got removed to make space for the sanitized
> communicator source free, but I'll clear that out and reinstall it later
> today.  In the meantime, could someone else build that tarball?  Alex?

I'm not going to get into the xcompiler unless I have to, and I don't.

But, there are .72 binaries in:
ftp://ftp.linux.sgi.com/pub/test/

There's two different onces; vmlinux-indy-2.1.72.tar.gz for machines with
an scache; vmlinux-indy-noL2-2.1.72.tar.gz for those without L2.

Uh, I *think* they work.  If they don't let me know and I'll compile one.  

- alex
