Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA153936 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 17:54:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA20791 for linux-list; Mon, 26 Jan 1998 17:51:43 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA20780; Mon, 26 Jan 1998 17:51:41 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA09867; Mon, 26 Jan 1998 17:51:40 -0800
Date: Mon, 26 Jan 1998 17:51:40 -0800
Message-Id: <199801270151.RAA09867@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: More on modules...
In-Reply-To: <Pine.LNX.3.95.980126194243.20316I-100000@lager.engsoc.carleton.ca>
References: <Pine.LNX.3.95.980126194243.20316I-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > The modutils in the CVS appears to work; I'll get an RPM out tonight for
 > others.
 > 
 > But, I use the term 'work' with a grain of salt; the modules appear to
 > load, but I get errors like:
 > Illegal instruction at c000c0d0 ra=88034ed4
 > Unable to handle kernel paging request at virtual address c0008113, epc ==
 > c000c0d8, ra == 88034ed4
 > Killed
...

      I wonder if the kernel is properly synchronzing the I-cache with
the D-cache after loading the module.  In general, you need to
writeback the primary D-cache and invalidate the primary I-cache for
the range of addresses occupied by the driver (or simply
index-writeback-invalidate all of the D-cache and index-invalidate all
of the I-cache, if the driver is larger than the cache size).  
