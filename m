Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA58541 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 14:19:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA21270
	for linux-list;
	Wed, 25 Nov 1998 14:18:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA27317;
	Wed, 25 Nov 1998 14:18:20 -0800 (PST)
	mail_from (pjlahaie@elenuial.atlsci.com)
Received: from elenuial.atlsci.com (elenuial.atlsci.com [209.151.14.9]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00399; Wed, 25 Nov 1998 14:18:17 -0800 (PST)
	mail_from (pjlahaie@elenuial.atlsci.com)
Received: (from pjlahaie@localhost)
	by elenuial.atlsci.com (8.8.7/8.8.7) id RAA03647;
	Wed, 25 Nov 1998 17:15:48 -0500
Date: Wed, 25 Nov 1998 17:15:47 -0500 (EST)
From: <pjlahaie@atlsci.com>
To: Alex Kozlov <alexvk@vostok.engr.sgi.com>
cc: ariel@cthulhu.engr.sgi.com, galibert@pobox.com, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
In-Reply-To: <199811252213.OAA07424@vostok.engr.sgi.com>
Message-ID: <Pine.LNX.4.04.9811251713471.3207-100000@elenuial.atlsci.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 25 Nov 1998, Alex Kozlov wrote:

> I thought craylink is 6 GB/s:
                        ^^^^
> 
> cl0: flags=4041<UP,RUNNING,DRVRLOCK>
>         inet 192.0.2.113 netmask 0xffffff00 
>         speed 6.40 Gbit/s
                     ^^^^

    Those a bits, not bytes.  So 6.40Gb is 0.8GB/s.

						- Paul
