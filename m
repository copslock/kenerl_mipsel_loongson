Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA183459 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 16:18:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id QAA1406549 for linux-list; Fri, 6 Mar 1998 16:18:14 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id QAA1386604 for <linux@engr.sgi.com>; Fri, 6 Mar 1998 16:18:12 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA13149; Fri, 6 Mar 1998 16:18:11 -0800
Date: Fri, 6 Mar 1998 16:18:11 -0800
Message-Id: <199803070018.QAA13149@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: NTP, once more
In-Reply-To: <19980307010349.20397@uni-koblenz.de>
References: <19980307010349.20397@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > From: Mark Salter <marks@sun470.sun470.rd.qms.com>
 > To: linux@cthulhu.engr.sgi.com
 > Subject: clock skew and ethernet timeouts
...
 > I also noticed that the linux time of day clock falls behind
 > real time whenever these timeouts occur. I decided to take a
 > look at this side of the problem and discovered that interrupts
 > are being turned off for extended periods of time. I modified
 > the timer interrupt handler to print a message if it detects
 > a missed system tick. Sure enough, every ethernet timeout is
 > accompanied by a message coming from the timer interrupt. The
 > message indicates that the timer interrupt was held off for
 > as much as 45ms!
 > 
 > 
 > Here's the change I made to indy_timer_interrupt() in indy_timers.c:
 > 
 > 	/* Ack timer and compute new compare. */
 > #if 0
 > 	r4k_cur = (read_32bit_cp0_register(CP0_COUNT) + r4k_offset);
 > #else
 > 	count = read_32bit_cp0_register(CP0_COUNT);
 > 	if ((count - r4k_cur) >= r4k_offset) {
 > 		printk("missed heartbeat: r4k_cur[0x%x] count[0x%x]\n",
 > 		       r4k_cur, count);
 > 		r4k_cur = count + r4k_offset;
 > 	}
 > 	else
 > 	    r4k_cur += r4k_offset;
 > #endif
...

     I have not checked the source, but is the workaround for the R4000
count/compare bug in read_32bit_cp0_register(CP0_COUNT)?  If not,
every once in a while you will lose count/compare interrupts for about
84 seconds on a 100 MHZ R4000.  Note that this bug does not apply
to any other processor.  The bug is that the processor fails to
signal an interrupt if $count is read at exactly the cycle that
$count == $compare.  Since $compare is commonly not that far ahead
of $count when one is using it for timer interrupts, this is far more
likely than it might seem at first thought.  

      The workaround I did in IRIX, for R4000 only, was to keep a
shadow copy of $compare, and, with interrupts disabled, fetch $count
and see if it was very close to the shadow value of $compare (to allow
for the possibility that "close" counted in R4000 bugs as well as in
horseshoes :-) ), and, if so, whether the timer interrupt was pending
in $sr.  If the timer was not pending, I would then enter a loop where
it would set $compare a little ahead of the current $count, and then
wait a few cycles for the interrupt to turn on in $sr, retrying with a
larger window if I missed the window on the first try.  It is
important to have interrupts off (mfc0 $a0,C0_SR; mtc0 zero,C0_SR)
while doing this workaround to avoid all sorts of races with higher
level code and also minimize unexpected cache misses (which greatly
affect the timing).
