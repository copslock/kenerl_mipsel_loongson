Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA06917 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 00:17:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA34128
	for linux-list;
	Fri, 17 Jul 1998 00:16:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA47202
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 00:16:20 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA28417
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 00:16:18 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id JAA28953;
	Fri, 17 Jul 1998 09:16:11 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id JAA03803;
	Fri, 17 Jul 1998 09:16:09 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id JAA24626;
	Fri, 17 Jul 1998 09:16:10 +0200 (MET DST)
Message-Id: <199807170716.JAA24626@aisa.fi.muni.cz>
Subject: Re: Installing noarch packages
In-Reply-To: <Pine.LNX.3.95.980716140918.6127E-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 16, 98 02:10:59 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 17 Jul 1998 09:16:10 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> there's a problem with /usr/lib/rpmrc then.  It should have a line like:
> arch_compat: mipseb: noarch

This was there already.

> If that doesn't work, try adding:
> arch_compat: mips: noarch

This fixed the problem. Thanks,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
