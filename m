Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA58136 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 14:26:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA19286
	for linux-list;
	Wed, 25 Nov 1998 14:25:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.61.141])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id OAA39193;
	Wed, 25 Nov 1998 14:25:30 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA23152; Wed, 25 Nov 1998 14:25:24 -0800
Date: Wed, 25 Nov 1998 14:25:24 -0800
Message-Id: <199811252225.OAA23152@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: alexvk@vostok.engr.sgi.com (Alex Kozlov)
Cc: pjlahaie@atlsci.com, ariel@cthulhu.engr.sgi.com, galibert@pobox.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: help offered
In-Reply-To: <199811252213.OAA07424@vostok.engr.sgi.com>
References: <Pine.LNX.4.04.9811251542540.3207-100000@elenuial.atlsci.com>
	<199811252213.OAA07424@vostok.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex Kozlov writes:
 > pjlahaie@atlsci.com wrote:
 > >
 > >     I was under the impression the O2k memory bandwidth was limited to
 > > ~800MB/s.  If so, even if you can read 4GB/s what are you foing to do with
 > > it?  It would have to go over the CrayLink "network" and that doesn't do
 > > 4GB/s.  The only way I can see 4GB/s disk throughput is multiple of the
 > > node accessing "local" drives and adding all the bandwidth together.
 > > 
 > 
 > I thought craylink is 6 GB/s:
 > 
 > cl0: flags=4041<UP,RUNNING,DRVRLOCK>
 >         inet 192.0.2.113 netmask 0xffffff00 
 >         speed 6.40 Gbit/s
 > 
 > Is it not true in practice?

     Yes, but I think the "4GB/s" was "4 gigabytes/second".  The link is
about 800 megabytes/second (6.4 gigabits/second).
