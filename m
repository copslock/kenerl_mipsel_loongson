Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA06155 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 00:24:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA13396
	for linux-list;
	Thu, 16 Jul 1998 00:23:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA93795
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 00:23:51 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA05121
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 00:23:49 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id JAA06329;
	Thu, 16 Jul 1998 09:23:45 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id JAA29936;
	Thu, 16 Jul 1998 09:23:42 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id JAA29043;
	Thu, 16 Jul 1998 09:23:38 +0200 (MET DST)
Message-Id: <199807160723.JAA29043@aisa.fi.muni.cz>
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <Pine.LNX.3.95.980715180435.22020I-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 15, 98 06:13:15 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 16 Jul 1998 09:23:37 +0200 (MET DST)
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
> > About 3 packages before end, the install failed with Out of memory,
> > Install exited abnormally, messages about signal, etc.
> 
> That's a problem.  How much memory do you have?

32 MB.

> > So I rebooted and tried just with networked WS and development, this
> > failed in about 60 % with Install exited abnormally.
> 
> What package was installing at the time the install broke?

ncurses4, I believe.

> > The third attempt I did was only 126 packages of base and networked
> > WS, this finished fine.
> 
> Good.
> 
> > After booting the new kernel, I get Unable to open an initial console.
> 
> Did you pass a root= variable to the kernel when booting?  You should
> normally have to do something like:
> 
> boot vmlinux root=/dev/sdb1

Yes, sure. I do $linux ;-)

> Does the kernel see the partitions on your disk?

Yes, upto there everything is fine. The Unable to open an initial
console message comes after the message about freeing kernel memory
-- 44kB. The system however seems to be doing something after that
-- at least accoring to the sound of the disk. It works and then it
goes silent. When I boot init=/bin/bash, I again get the Unable to
open an initial console message and then nothing, but the while
before the disk goes silent is shorter. So I assume the prompt is
somewhere out there.

Interesting thing (for me, anyway ;-): when I tried to boot the old
kernel (RH 5.1 A 1, 2.1.99), I got the same message about initial
console. So there must be something wrong on the root filesystem.

During the isntallation, I was not able to run a single process (like
mount or cat, all end with Segmentation fault). When I booted to
Upgrade, I was able to work with the /mnt filesystem just fine. I
thought the initial console could be caused by a missing /etc/inittab
but it's there. What could be the case? The upgrade fails with signal
8 when it should start installing the first selected package, but
before that I can work rather well (just tried ls, cat, mount) with
the filesystem, so I could fix the initial console problem, if I knew
how ;-)

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
