Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2003 22:22:06 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54257 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225073AbTDUVWF>;
	Mon, 21 Apr 2003 22:22:05 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3LLM3E28029;
	Mon, 21 Apr 2003 14:22:03 -0700
Date: Mon, 21 Apr 2003 14:22:03 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: [PATCH] loosing time with CPU counter timer
Message-ID: <20030421142203.H22394@mvista.com>
References: <20030414171655.G1642@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030414171655.G1642@mvista.com>; from jsun@mvista.com on Mon, Apr 14, 2003 at 05:16:55PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2003 at 05:16:55PM -0700, Jun Sun wrote:
> 
> This patch fixes an ancient timer bug.
> 
> If one uses CPU counter as the system timer, it looses time
> over the time.
> 
> Basically, timer_interrupt() does the following when it serves
> an cpu counter interrupt (only relavent part shown);
> 
> 0) interrupt happens
> 1) read cpu counter;
> 2) add it with cycles_per_jiffy, and set the value to compare
>    register.
> 
> The problem is that cpu counter could increase between 0) and 1),
> say by delta units.  Then the next timer interrupt is set to
> t0 + delta + cycles_per_unit, instead of t0 + cycles_per_unit,
> (where t0 is the current timer interrupt time)
> 
> Similar bug also exists in old-time.c, but anybody really cares? :)
> Especially it has been there for quite a while ....
> 
<snip>

After a refreshing weekend I realize there exists a much more
elegant fix for the problem.  :) See the patch attached.

Unfortuately I have already checked in the not-so-elegant fix.
So the actual patch to check in this time will be diff between 
this one and the previous patch.

Comments?

Jun


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk1

diff -u arch/mips/kernel/time.c ./arch/mips/kernel/time.c
--- arch/mips/kernel/time.c	17 Apr 2003 22:50:37 -0000
+++ ./arch/mips/kernel/time.c	Mon Apr 21 14:02:06 2003
@@ -140,6 +140,9 @@
 /* Cycle counter value at the previous timer interrupt.. */
 static unsigned int timerhi, timerlo;
 
+/* expirelo is the count value for next CPU timer interrupt */
+static unsigned int expirelo;
+
 /* last time when xtime and rtc are sync'ed up */
 static long last_rtc_update;
 
@@ -335,22 +338,21 @@
 	if (cpu_has_counter) {
 		unsigned int count;
 
-		/*
-		 * The cycle counter is only 32 bit which is good for about
-		 * a minute at current count rates of upto 150MHz or so.
-		 */
+		/* ack timer interrupt, and try to set next interrupt */
+		expirelo += cycles_per_jiffy;
+		write_c0_compare(expirelo);
 		count = read_c0_count();
-		timerhi += (count < timerlo);   /* Wrap around */
-		timerlo = count;
 
-		/*
-		 * set up for next timer interrupt - no harm if the machine
-		 * is using another timer interrupt source.
-		 * Note that writing to COMPARE register clears the interrupt
-		 */
-		write_c0_compare(
-					  count + cycles_per_jiffy);
+		/* check to see if we have missed any timer interrupts */
+		if ((count - expirelo) < 0x7fffffff) {
+			/* missed_timer_count ++; */
+			expirelo = count + cycles_per_jiffy;
+			write_c0_compare(expirelo);
+		}
 
+		/* Update timerhi/timerlo for intra-jiffy calibration. */
+		timerhi += count < timerlo;	/* Wrap around */
+		timerlo = count;
 	}
 
 	/*
@@ -504,8 +506,6 @@
 
 	/* caclulate cache parameters */
 	if (mips_counter_frequency) {
-		u32 count;
-
 		cycles_per_jiffy = mips_counter_frequency / HZ;
 
 		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq */
@@ -518,9 +518,9 @@
 		 * For those using cpu counter as timer,  this sets up the
 		 * first interrupt
 		 */
-		count = read_c0_count();
-		write_c0_compare(
-					  count + cycles_per_jiffy);
+		write_c0_compare(cycles_per_jiffy);
+		write_c0_count(0);
+		expirelo = cycles_per_jiffy;
 	}
 
 	/*

--a8Wt8u1KmwUX3Y2C--
