Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA615450 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 Nov 1997 16:50:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA15756 for linux-list; Sat, 29 Nov 1997 16:47:23 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA15750 for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 16:47:13 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA22840
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 16:47:07 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA05327
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 19:44:47 -0500
Date: Sat, 29 Nov 1997 19:44:47 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: A report from the battle field...
In-Reply-To: <19971128161417.23781@thoma.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.971129193017.26978E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


My machine is now almost fully self-hosting. It's an Indy with a 4600
version 2.0 CPU, running Mike's EFS kernel 2.1.55.

Okay, two significant bugs I'd like to report:

1. When I try to FTP a lot of files to it, it complains about "eth0: ".  I
guess it's just going too quick.  The file then becomes corrupt.  The
somewhat odd solution is for me to FTP the file over a slower network.
Instead of grabbing the file from the machine 30cm away, I grab it from
ftp.linux.sgi.com, and it's fine. Would someone by chance have a newer
precompiled kernel?

2. Execution errors on various programs:
- bash: 
do_page_fault() #2: sending SIGSEGV to bash for illegal readaccess
from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)
- pico (part of pine):
do_page_fault() #2: sending SIGSEGV to pico for illegal readaccess from
from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)
- mingetty: 
unix_gc: deferred due to low memory

All these binaries are from the RPMs.

And other things:
- /proc/cpuinfo says it's a blazing 137.63 Bogomips, but if feels about
like a 486-33. Perhaps this means nothing. Also, under "system type" it
says "You'd like to know unknown".  Let me tell you, I _know_ what it's
like to be unknown.
- when I try and do a control-alt-delete, it says that it's flushing the
cache, and that's it.

- Alex

      Alex deVries          Rent this space for a $5 donation 
  System Administrator      to EngSoc per day.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
