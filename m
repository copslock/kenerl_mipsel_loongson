Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA183138 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 16:08:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id QAA1382323 for linux-list; Fri, 6 Mar 1998 16:07:36 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA1396752 for <linux@engr.sgi.com>; Fri, 6 Mar 1998 16:07:35 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id QAA05601
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 16:07:33 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA28567
	for <linux@engr.sgi.com>; Sat, 7 Mar 1998 01:07:30 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA25996;
	Sat, 7 Mar 1998 01:03:53 +0100
Message-ID: <19980307010349.20397@uni-koblenz.de>
Date: Sat, 7 Mar 1998 01:03:49 +0100
To: linux@cthulhu.engr.sgi.com
Subject: NTP, once more
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Sigh,

it's sometimes useful not to cleanup mailfolders.  The following patch
provided by Mark Salter ages ago should fix the problem.  It definately
fixes a serious problem and makes the kernel print warnings in case of
another; I just haven't tested if this fixes xntpd.

  Ralf

>From owner-linux@cthulhu.engr.sgi.com  Thu Aug 14 00:15:32 1997
Received: from sgi.sgi.com (SGI.COM [192.48.153.1]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id AAA19735 for <ralf@mailhost.uni-koblenz.de>; Thu, 14 Aug 1997 00:15:22 +0200 (MEST)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA07825; Wed, 13 Aug 1997 15:14:18 -0700
	env-from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA23089 for linux-list; Wed, 13 Aug 1997 15:09:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA23083 for <linux@cthulhu.engr.sgi.com>; Wed, 13 Aug 1997 15:09:42 -0700
Received: from gatekeeper.qms.com (gatekeeper.qms.com [161.33.3.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id PAA06378
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 Aug 1997 15:09:39 -0700
	env-from (marks@sun470.sun470.rd.qms.com)
Received: from sun470.rd.qms.com (sun470.qms.com) by gatekeeper.qms.com (4.1/SMI-4.1)
	id AA02346; Wed, 13 Aug 97 17:09:34 CDT
Received: from speedy.rd.qms.com by sun470.rd.qms.com (4.1/SMI-4.1)
	id AA23850; Wed, 13 Aug 97 17:09:32 CDT
Received: by speedy.rd.qms.com (8.8.2) id RAA31518; Wed, 13 Aug 1997 17:09:32 -0500
Date: Wed, 13 Aug 1997 17:09:32 -0500
Message-Id: <199708132209.RAA31518@speedy.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>
To: linux@cthulhu.engr.sgi.com
Subject: clock skew and ethernet timeouts
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Status: RO


I've been taking a look at the problem with frequent ethernet
transmit timeouts. In addition to the timeouts, I've also seen
an occasional duplicate packet being sent in response to pings
coming from another machine. I'm debugging somewhat in the dark
because I don't have documentation on the indy's DMA controller
although the sgihpc.h file has been helpful.

I also noticed that the linux time of day clock falls behind
real time whenever these timeouts occur. I decided to take a
look at this side of the problem and discovered that interrupts
are being turned off for extended periods of time. I modified
the timer interrupt handler to print a message if it detects
a missed system tick. Sure enough, every ethernet timeout is
accompanied by a message coming from the timer interrupt. The
message indicates that the timer interrupt was held off for
as much as 45ms!


Here's the change I made to indy_timer_interrupt() in indy_timers.c:

	/* Ack timer and compute new compare. */
#if 0
	r4k_cur = (read_32bit_cp0_register(CP0_COUNT) + r4k_offset);
#else
	count = read_32bit_cp0_register(CP0_COUNT);
	if ((count - r4k_cur) >= r4k_offset) {
		printk("missed heartbeat: r4k_cur[0x%x] count[0x%x]\n",
		       r4k_cur, count);
		r4k_cur = count + r4k_offset;
	}
	else
	    r4k_cur += r4k_offset;
#endif


The original code which calculates the next value for the CP0_COMPARE
register introduces skew by basing it on the current value of the 
CP0_COUNT register rather than the previous CP0_COMPARE value. But as
it turns out, that little bit of skew is preferable to the large 
skew that would result whenever the timer interrupt is held off too
long.

Anyway, I'm going to be away from the office until 19 August, so I'll
pick it up then unless someone else finds it first. It seems likely
that the enet timeouts are the result of interrupts being turned off
too long, but if that's not the case, can someone point me to some
documentation for the indy's dma controller? I have some suspicions
of race conditions when setting up new DMA buffers, but I'd like to
have a document before I try various fixes.

--
Mark Salter
marks@sun470.rd.qms.com
