Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA07030 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 13:18:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA36510
	for linux-list;
	Wed, 19 Aug 1998 13:17:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA38846
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 13:17:22 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca ([134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA28570
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 13:17:16 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA01541;
	Wed, 19 Aug 1998 16:16:52 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 19 Aug 1998 16:16:52 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ulf Carlsson <grim@zigzegv.ml.org>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: [PATCH] sc
In-Reply-To: <199808192003.WAA13671@calypso.saturn>
Message-ID: <Pine.LNX.3.96.980819161628.4406D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


If there's no objections from the MIPS kernel hackers here, I'll apply
this to the CVS.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Wed, 19 Aug 1998, Ulf Carlsson wrote:

> Date: Wed, 19 Aug 1998 22:03:05 +0200 (CEST)
> From: Ulf Carlsson <grim@zigzegv.ml.org>
> To: linux@cthulhu.engr.sgi.com
> Subject: [PATCH] sc
> 
> Hi,
> 
> Here's the patch for SC, still some BUS Errors when using the network device
> (bootp doesn't work), sometimes even without obvious reason.
> 
> - Ulf
> 
