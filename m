Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id AAA183147 for <linux-archive@neteng.engr.sgi.com>; Tue, 27 Jan 1998 00:09:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA17657 for linux-list; Tue, 27 Jan 1998 00:05:16 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA17650; Tue, 27 Jan 1998 00:05:13 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA23487; Tue, 27 Jan 1998 00:05:11 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id DAA27504;
	Tue, 27 Jan 1998 03:05:05 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 27 Jan 1998 03:05:05 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: "William J. Earl" <wje@fir.engr.sgi.com>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: More on modules...
In-Reply-To: <19980127074155.62514@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980127030324.27412A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 27 Jan 1998 ralf@uni-koblenz.de wrote:
> On Mon, Jan 26, 1998 at 05:51:40PM -0800, William J. Earl wrote:
> >       I wonder if the kernel is properly synchronzing the I-cache with
> > the D-cache after loading the module.  In general, you need to
> > writeback the primary D-cache and invalidate the primary I-cache for
> > the range of addresses occupied by the driver (or simply
> > index-writeback-invalidate all of the D-cache and index-invalidate all
> > of the I-cache, if the driver is larger than the cache size).  
> 
> Yes, we do that properly.

> Alex, when compiling modules, does the compiler pass the flag -mlong-jumps?

No, but it does compile them with -mlong-calls.

- Alex "damned insomnia" deVries
