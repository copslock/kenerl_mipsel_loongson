Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA82293 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Jul 1998 06:18:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA33750
	for linux-list;
	Thu, 9 Jul 1998 06:17:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA59082
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Jul 1998 06:17:31 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA18041
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 06:17:28 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id PAA09736
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 15:17:26 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id PAA13546
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 15:17:24 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id PAA02524
	for linux@cthulhu.engr.sgi.com; Thu, 9 Jul 1998 15:17:22 +0200 (MET DST)
Message-Id: <199807091317.PAA02524@aisa.fi.muni.cz>
Subject: Lmbench for RH 5.1
In-Reply-To: <19980624090439.B1937@w3.org> from Daniel Veillard at "Jun 24, 98 09:04:39 am"
To: linux@cthulhu.engr.sgi.com
Date: Thu, 9 Jul 1998 15:17:22 +0200 (MET DST)
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello,

I wanted to do benchmarks on my Indy. The versions 1.0 and 1.1 fail
when compiling lat_ctx.c with assembler messages:
Error: Branch out of range on lines 4189 and 40323. When I try to
compile it with -O2, it starts optimizing but doesn't seem to finish.

The version 2beta6 of lmbench complains about missing
linux/autoconf.h.

This is RH 5.1 Alpha 1 installer with Alpha 2 RPM's placed over the
Alpha 1 ones, with gcc from redhat-5.0 (Alex, we should put gcc
to the distribution). Do you have any idea what to do with any
of these problems? Or do you have precompiled lmbench somewhere?

Thanks,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
