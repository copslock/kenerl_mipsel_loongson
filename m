Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA50755 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 12:55:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA31503
	for linux-list;
	Wed, 25 Nov 1998 12:54:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA91017;
	Wed, 25 Nov 1998 12:54:27 -0800 (PST)
	mail_from (pjlahaie@elenuial.atlsci.com)
Received: from elenuial.atlsci.com (elenuial.atlsci.com [209.151.14.9]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02691; Wed, 25 Nov 1998 12:54:24 -0800 (PST)
	mail_from (pjlahaie@elenuial.atlsci.com)
Received: (from pjlahaie@localhost)
	by elenuial.atlsci.com (8.8.7/8.8.7) id PAA03607;
	Wed, 25 Nov 1998 15:51:54 -0500
Date: Wed, 25 Nov 1998 15:51:54 -0500 (EST)
From: <pjlahaie@atlsci.com>
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
cc: Olivier Galibert <galibert@pobox.com>, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
In-Reply-To: <199811252037.MAA37649@oz.engr.sgi.com>
Message-ID: <Pine.LNX.4.04.9811251542540.3207-100000@elenuial.atlsci.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 25 Nov 1998, Ariel Faigon wrote:

> I've seen way much higher numbers.  They are not official, and
> are not supposed to be used in sales situations, but were obtained
> in our labs with XFS and arrays that were designed and tuned to
> maximize bandwidth and to prove that XFS is not the bottleneck.
> I believe they also used fiberchannel etc.   Anyway, there are
> some much greater experts on this subject on this list if they
> care to give the details.

    I was under the impression the O2k memory bandwidth was limited to
~800MB/s.  If so, even if you can read 4GB/s what are you foing to do with
it?  It would have to go over the CrayLink "network" and that doesn't do
4GB/s.  The only way I can see 4GB/s disk throughput is multiple of the
node accessing "local" drives and adding all the bandwidth together.

						- Paul
