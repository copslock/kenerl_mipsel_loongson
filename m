Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA82775 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Jul 1998 16:02:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA73087
	for linux-list;
	Thu, 2 Jul 1998 16:01:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA29838
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Jul 1998 16:01:40 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA26838
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Jul 1998 16:01:38 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yrsMC-0027qSC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 3 Jul 1998 01:01:36 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yrsM6-002PSdC; Fri, 3 Jul 98 01:01 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03624;
	Fri, 3 Jul 1998 00:59:28 +0200
Message-ID: <19980703005927.48187@alpha.franken.de>
Date: Fri, 3 Jul 1998 00:59:27 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: tcsh
References: <19980622110139.F418@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980622110139.F418@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Jun 22, 1998 at 11:01:39AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jun 22, 1998 at 11:01:39AM +0200, ralf@uni-koblenz.de wrote:
> maybe anybody feels like debugging the tcsh rpm.  The lack of having
> a properly working csh keep several other packages from building
> without trickery.

ok, I'm pretty close. After debugging tcsh for more than three hours,
it looks like this is a kernel bug. I've traced it down to the following
code in sh.proc.c:

xprintf ("pp before sigpause %x\n",pp);
        /* (void) sigpause(sigblock((sigmask_t) 0) &~ sigmask(SIGCHLD)); */
        (void) sigpause(omask & ~sigmask(SIGCHLD));
xprintf ("pp after sigpause %x\n",pp);

pp gets clobbered by sigpause. I'll have a fast look at the kernel, maybe
it's easy to spot the bug.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
