Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA179436 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 22:48:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA08679 for linux-list; Mon, 26 Jan 1998 22:45:19 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA08672; Mon, 26 Jan 1998 22:45:17 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA06608; Mon, 26 Jan 1998 22:45:15 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-18.uni-koblenz.de [141.26.249.18])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id HAA29092;
	Tue, 27 Jan 1998 07:45:13 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id HAA06851;
	Tue, 27 Jan 1998 07:41:55 +0100
Message-ID: <19980127074155.62514@uni-koblenz.de>
Date: Tue, 27 Jan 1998 07:41:55 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: More on modules...
References: <Pine.LNX.3.95.980126194243.20316I-100000@lager.engsoc.carleton.ca> <199801270151.RAA09867@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801270151.RAA09867@fir.engr.sgi.com>; from William J. Earl on Mon, Jan 26, 1998 at 05:51:40PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 26, 1998 at 05:51:40PM -0800, William J. Earl wrote:

>  > But, I use the term 'work' with a grain of salt; the modules appear to
>  > load, but I get errors like:
>  > Illegal instruction at c000c0d0 ra=88034ed4
>  > Unable to handle kernel paging request at virtual address c0008113, epc ==
>  > c000c0d8, ra == 88034ed4
>  > Killed
> ...
> 
>       I wonder if the kernel is properly synchronzing the I-cache with
> the D-cache after loading the module.  In general, you need to
> writeback the primary D-cache and invalidate the primary I-cache for
> the range of addresses occupied by the driver (or simply
> index-writeback-invalidate all of the D-cache and index-invalidate all
> of the I-cache, if the driver is larger than the cache size).  

Yes, we do that properly.

Alex, when compiling modules, does the compiler pass the flag -mlong-jumps?

  Ralf
