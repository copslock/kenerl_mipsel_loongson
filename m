Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA45335 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 13:19:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA83238
	for linux-list;
	Wed, 25 Nov 1998 13:18:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.61.141])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA60993;
	Wed, 25 Nov 1998 13:18:22 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA22913; Wed, 25 Nov 1998 13:18:12 -0800
Date: Wed, 25 Nov 1998 13:18:12 -0800
Message-Id: <199811252118.NAA22913@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: <pjlahaie@atlsci.com>
Cc: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        Olivier Galibert <galibert@pobox.com>, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
In-Reply-To: <Pine.LNX.4.04.9811251542540.3207-100000@elenuial.atlsci.com>
References: <199811252037.MAA37649@oz.engr.sgi.com>
	<Pine.LNX.4.04.9811251542540.3207-100000@elenuial.atlsci.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

pjlahaie@atlsci.com writes:
 > On Wed, 25 Nov 1998, Ariel Faigon wrote:
 > 
 > > I've seen way much higher numbers.  They are not official, and
 > > are not supposed to be used in sales situations, but were obtained
 > > in our labs with XFS and arrays that were designed and tuned to
 > > maximize bandwidth and to prove that XFS is not the bottleneck.
 > > I believe they also used fiberchannel etc.   Anyway, there are
 > > some much greater experts on this subject on this list if they
 > > care to give the details.
 > 
 >     I was under the impression the O2k memory bandwidth was limited to
 > ~800MB/s.  If so, even if you can read 4GB/s what are you foing to do with
 > it?  It would have to go over the CrayLink "network" and that doesn't do
 > 4GB/s.  The only way I can see 4GB/s disk throughput is multiple of the
 > node accessing "local" drives and adding all the bandwidth together.

       A single node is only 800 MB/s, but an 8P Origin 2000 has four nodes,
and a 32P has 16 nodes.  The router network bandwidth scales with the number
of nodes, so the memory bandwidth of a 32P Origin 2000 is far more than enough
for 4 GB/s.  If you attach the drives to multiple controllers on multiple
nodes, then it is easy to stripe across them with the volume manager to
get high bandwidth.  The volume manager does requests in parallel, so it
is not a bottleneck.

     The Origin architecture does not have a central bus, so it is not bus
limited.  Just add boxes until the bandwidth is enough for what you need.
