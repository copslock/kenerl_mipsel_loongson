Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA58027 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 14:13:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA07671
	for linux-list;
	Wed, 25 Nov 1998 14:13:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from vostok.engr.sgi.com (vostok.engr.sgi.com [150.166.42.39])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA30128;
	Wed, 25 Nov 1998 14:13:04 -0800 (PST)
	mail_from (alexvk@vostok.engr.sgi.com)
Received: (from alexvk@localhost) by vostok.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id OAA07424; Wed, 25 Nov 1998 14:13:04 -0800 (PST)
From: alexvk@vostok.engr.sgi.com (Alex Kozlov)
Message-Id: <199811252213.OAA07424@vostok.engr.sgi.com>
Subject: Re: help offered
In-Reply-To: <Pine.LNX.4.04.9811251542540.3207-100000@elenuial.atlsci.com> from "pjlahaie@atlsci.com" at "Nov 25, 98 03:51:54 pm"
To: pjlahaie@atlsci.com
Date: Wed, 25 Nov 1998 14:13:03 -0800 (PST)
Cc: ariel@cthulhu.engr.sgi.com, galibert@pobox.com, linux@cthulhu.engr.sgi.com
WWW-page: http://robotics.stanford.edu/~alexvk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

pjlahaie@atlsci.com wrote:
>
>     I was under the impression the O2k memory bandwidth was limited to
> ~800MB/s.  If so, even if you can read 4GB/s what are you foing to do with
> it?  It would have to go over the CrayLink "network" and that doesn't do
> 4GB/s.  The only way I can see 4GB/s disk throughput is multiple of the
> node accessing "local" drives and adding all the bandwidth together.
> 

I thought craylink is 6 GB/s:

cl0: flags=4041<UP,RUNNING,DRVRLOCK>
        inet 192.0.2.113 netmask 0xffffff00 
        speed 6.40 Gbit/s

Is it not true in practice?

-- 
Alexander V. Kozlov | alexvk@engr.sgi.com | (650) 933-8493
