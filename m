Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA69579 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 14:56:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA78597
	for linux-list;
	Wed, 17 Jun 1998 14:56:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA26777;
	Wed, 17 Jun 1998 14:56:26 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id OAA21039; Wed, 17 Jun 1998 14:56:23 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id XAA26884;
	Wed, 17 Jun 1998 23:56:21 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id XAA22805;
	Wed, 17 Jun 1998 23:56:19 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id XAA07993;
	Wed, 17 Jun 1998 23:56:20 +0200 (MET DST)
Message-Id: <199806172156.XAA07993@aisa.fi.muni.cz>
Subject: Re: (fwd) linux SEGV details (another one)
In-Reply-To: <19980617212049.B410@uni-koblenz.de> from "ralf@uni-koblenz.de" at "Jun 17, 98 09:20:49 pm"
To: ralf@uni-koblenz.de
Date: Wed, 17 Jun 1998 23:56:20 +0200 (MET DST)
Cc: ariel@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> > I have noticed another problem. Linux happily mounts the same
> > swap-file twice and if the system needs to swap, kswapd starts to run
> > at 60% CPU (or more) and the system slows down to death.
> 
> On what kernel did this happen?  Some Linux kernels in the 2.1.x series

2.1.99 from the RH 5.1 Alpha 1 distribution (the original /vmlinux).

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
