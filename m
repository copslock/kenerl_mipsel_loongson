Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA646722 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 Nov 1997 18:03:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA20123 for linux-list; Sat, 29 Nov 1997 17:59:03 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA20118 for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 17:58:53 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA00840
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 17:58:52 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id CAA25214;
	Sun, 30 Nov 1997 02:58:51 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id CAA14351; Sun, 30 Nov 1997 02:58:49 +0100
Message-ID: <19971130025848.64926@thoma.uni-koblenz.de>
Date: Sun, 30 Nov 1997 02:58:48 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: A report from the battle field...
References: <19971128161417.23781@thoma.uni-koblenz.de> <Pine.LNX.3.95.971129193017.26978E-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.971129193017.26978E-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, Nov 29, 1997 at 07:44:47PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Nov 29, 1997 at 07:44:47PM -0500, Alex deVries wrote:
> 
> My machine is now almost fully self-hosting. It's an Indy with a 4600
> version 2.0 CPU, running Mike's EFS kernel 2.1.55.
> 
> Okay, two significant bugs I'd like to report:
> 
> 1. When I try to FTP a lot of files to it, it complains about "eth0: ".  I
> guess it's just going too quick.  The file then becomes corrupt.  The
> somewhat odd solution is for me to FTP the file over a slower network.
> Instead of grabbing the file from the machine 30cm away, I grab it from
> ftp.linux.sgi.com, and it's fine. Would someone by chance have a newer
> precompiled kernel?
> 
> 2. Execution errors on various programs:
> - bash: 
> do_page_fault() #2: sending SIGSEGV to bash for illegal readaccess
> from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)
> - pico (part of pine):
> do_page_fault() #2: sending SIGSEGV to pico for illegal readaccess from
> from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)

The new libc plus rebuilding the binary should fix this problem.

> - mingetty: 
> unix_gc: deferred due to low memory

Uh?  Never saw that one.

> All these binaries are from the RPMs.
> 
> And other things:
> - /proc/cpuinfo says it's a blazing 137.63 Bogomips, but if feels about
> like a 486-33. Perhaps this means nothing.

I think it's something with the console.  Similar the wd33c93 driver, it
gives me the same feeling as my Amiga running Linux 68k.  Well, a bit
better, but that driver seems a bit suspect.

> Also, under "system type" it
> says "You'd like to know unknown".  Let me tell you, I _know_ what it's
> like to be unknown.

I'll take a look at it.

> - when I try and do a control-alt-delete, it says that it's flushing the
> cache, and that's it.

I found that the ARC firmware of the Indy crashes when called with L2
cache enabled.  It's probably some similar problem.

What is the official way to reset the Indy?

  Ralf
