Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA04931 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Jul 1998 08:01:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA46313
	for linux-list;
	Fri, 3 Jul 1998 08:00:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA85068
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Jul 1998 08:00:17 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA14596
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Jul 1998 08:00:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id QAA08316
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Jul 1998 16:59:59 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id QAA00742;
	Fri, 3 Jul 1998 16:58:56 +0200
Message-ID: <19980703165855.C435@uni-koblenz.de>
Date: Fri, 3 Jul 1998 16:58:55 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: tcsh
References: <19980622110139.F418@uni-koblenz.de> <19980703005927.48187@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980703005927.48187@alpha.franken.de>; from Thomas Bogendoerfer on Fri, Jul 03, 1998 at 12:59:27AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 03, 1998 at 12:59:27AM +0200, Thomas Bogendoerfer wrote:

> On Mon, Jun 22, 1998 at 11:01:39AM +0200, ralf@uni-koblenz.de wrote:
> > maybe anybody feels like debugging the tcsh rpm.  The lack of having
> > a properly working csh keep several other packages from building
> > without trickery.
> 
> ok, I'm pretty close. After debugging tcsh for more than three hours,
> it looks like this is a kernel bug. I've traced it down to the following
> code in sh.proc.c:
> 
> xprintf ("pp before sigpause %x\n",pp);
>         /* (void) sigpause(sigblock((sigmask_t) 0) &~ sigmask(SIGCHLD)); */
>         (void) sigpause(omask & ~sigmask(SIGCHLD));
> xprintf ("pp after sigpause %x\n",pp);
> 
> pp gets clobbered by sigpause. I'll have a fast look at the kernel, maybe
> it's easy to spot the bug.

Same result here, I found that even minimal modifications make the
sympthoms go away.

Sigpause() is a libc routine in libc/sysdeps/posix/sigpause.c; it's either
using sigprocmask(2) or sigsuspend(2).

  Ralf
