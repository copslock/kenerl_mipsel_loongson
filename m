Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11207; Thu, 10 Apr 1997 11:03:27 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA25154 for linux-list; Thu, 10 Apr 1997 11:01:49 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA25148 for <linux@cthulhu.engr.sgi.com>; Thu, 10 Apr 1997 11:01:47 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA02138 for linux@engr; Thu, 10 Apr 1997 10:58:03 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199704101758.KAA02138@yon.engr.sgi.com>
Subject: Re: Why Linux on SGI
To: linux@cthulhu.engr.sgi.com
Date: Thu, 10 Apr 1997 10:58:03 -0700 (PDT)
In-Reply-To: <199704101606.SAA10912@kernel.panic.julia.de> from "Ralf Baechle" at Apr 10, 97 06:06:14 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:As promised, here is Miguel's answer.
:
:  Ralf
:

Miguel's answer is excellent. For the non-SGI'ers on the list
I just would like to add:

1) IRIX has many features that important customers require
   (e.g. trusted IRIX capabilities, real time scheduling
    and many more) that actually make it slower than Linux
   (in general). As a vendor SGI is committed to support
   these features from low end to high end for a long time
   to come. IRIX is big. Linux is smaller and faster.
   Once we have Linux running and we'll start running simple
   benchmarks you'll see this very clearly. Another big feature
   for our customers is XFS. Linux doesn't support a safe file
   system, IRIX does (try to turn off your Linux box and you
   lost a lot of stuff, unlike on IRIX with XFS.

2) IRIX needs to run on machines that are incredibly different:
   from uniprocessors through SMP (which Linux is now getting at)
   to the S2MP model (no shared bus: Origin family) every feature
   added to support S2MP (the Origin line) may potentially complicate
   and slow down the uP desktop case. SGI customers demand
   one source base. They want to compile on O2 and run on Origin.
   Linux is just starting to get a feel for how complex is SMP
   vs. uP so it'll naturally run great on a uP but wouldn't be
   able to take advantage of the most scalable architecture of
   the Origins. As we've learned this requires rewriting large
   parts of your kernel from scratch. Which is why SGI is doing
   Cellular IRIX
   http://www.sgi.com/Technology/Irix6.4/cellular_irix6.4tr.html

3) IRIX runs only on SGIs and to get upgrades you need to
   pay for support. Linux runs on many platforms. It is free
   The common source base gives it a great advantage for people
   who have mixed envs. It is affordable and ideal for hackers.
   it has a big and fast growing following.

4) IRIX has no chance of beating M$oft. Linux doesn't either
   but it has a bit more. Just kidding.

The guy who said "SGI has hundreds of highly paid engineers
tuning IRIX to run fast on MIPS" simply misses the issues.
They are much more complex than that.

Both Linux and IRIX have their place. Each of them is good
at different things. People should have a choice between SGI
taking care of all their needs and the alternative to have
full control of their software.

Linux on SGI should prosper.

-- 
Peace, Ariel
