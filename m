Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA59820; Wed, 13 Aug 1997 15:10:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
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
