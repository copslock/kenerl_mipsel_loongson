Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 08:58:53 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17089 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224821AbTGVH6u>; Tue, 22 Jul 2003 08:58:50 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA00949;
	Tue, 22 Jul 2003 09:58:47 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 09:58:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: [patch] Generic time fixes
Message-ID: <Pine.GSO.3.96.1030722093500.607A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 In preparation to merging DECstation's time support with the generic
version I did the following clean-ups to generic time support.  Most of
these are coding style fixes (which might have already been fixed by
someone else during past two days -- I haven't been able to study the
changes), but there are a few code changes (detailed below) as well.

 Before I proceed further I need to get an aswer to the following
question: why do we use rtc_set_time() for NTP RTC updates instead of
rtc_set_mmss() like most other architectures do?  Traditionally Linux only
updated minutes and seconds in this context and I don't think we need to
do anything more.  And setting minutes and seconds only is way, way
faster. Which might not matter that much every 11 minutes, except doing
things slowly here incurs a disruption in the latency of the timer
interrupt, which NTP might not like and the slow calculation of the RTC
time causes less precise time being stored in the RTC chip. 

 It's already questionable whether the update should be done at all (this
was discussed zillion of times at the NTP group) and it disrupts
timekeeping of the DECstation severely, but given the current choice, I'd
prefer to make it as lightweight as possible.

 Here are the changes done:

1. Explicit variable initializations that used zero or NULL are removed.

2. Inline assembly returns a result in "hi" instead of doing an explicit
"mfhi"; clobbers for "lo" and "accum" are added.

3. local_timer_interrupt() is called with arguments passed from the above
instead of fake ones (although "irq" and "dev_id" could be completely
removed here; in the next iteration, I suppose). 

4. ISO C initializers for timer_irqaction; improves readability.

5. Leap years are handled properly.

6. Missing "extern" qualifiers for function declarations are added.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-20030711-mips-time-0
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/arch/mips/kernel/time.c linux-mips-2.4.21-20030711/arch/mips/kernel/time.c
--- linux-mips-2.4.21-20030711.macro/arch/mips/kernel/time.c	2003-04-23 02:56:41.000000000 +0000
+++ linux-mips-2.4.21-20030711/arch/mips/kernel/time.c	2003-07-21 20:28:39.000000000 +0000
@@ -1,9 +1,10 @@
 /*
  * Copyright 2001 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (c) 2003  Maciej W. Rozycki
  *
  * Common time service routines for MIPS machines. See
- * Documents/MIPS/README.txt.
+ * Documentation/mips/time.README.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -70,7 +71,7 @@ void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
 
-	read_lock_irqsave (&xtime_lock, flags);
+	read_lock_irqsave(&xtime_lock, flags);
 	*tv = xtime;
 	tv->tv_usec += do_gettimeoffset();
 
@@ -81,7 +82,7 @@ void do_gettimeofday(struct timeval *tv)
 	if (jiffies - wall_jiffies)
 		tv->tv_usec += USECS_PER_JIFFY;
 
-	read_unlock_irqrestore (&xtime_lock, flags);
+	read_unlock_irqrestore(&xtime_lock, flags);
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -91,7 +92,7 @@ void do_gettimeofday(struct timeval *tv)
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	write_lock_irq(&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
@@ -111,7 +112,7 @@ void do_settimeofday(struct timeval *tv)
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	write_unlock_irq(&xtime_lock);
 }
 
 
@@ -128,14 +129,11 @@ void do_settimeofday(struct timeval *tv)
  */
 
 
-/* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
-
 /* usecs per counter cycle, shifted to left by 32 bits */
-static unsigned int sll32_usecs_per_cycle=0;
+static unsigned int sll32_usecs_per_cycle;
 
 /* how many counter cycles in a jiffy */
-static unsigned long cycles_per_jiffy=0;
+static unsigned long cycles_per_jiffy;
 
 /* Cycle counter value at the previous timer interrupt.. */
 static unsigned int timerhi, timerlo;
@@ -165,34 +163,33 @@ unsigned long fixed_rate_gettimeoffset(v
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
 
-	__asm__("multu\t%1,%2\n\t"
-	        "mfhi\t%0"
-	        :"=r" (res)
-	        :"r" (count),
-	         "r" (sll32_usecs_per_cycle));
+	__asm__("multu	%1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (sll32_usecs_per_cycle)
+		: "lo", "accum");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
 	 * the result so that we'll get a timer that is monotonic.
 	 */
 	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY-1;
+		res = USECS_PER_JIFFY - 1;
 
 	return res;
 }
 
 /*
- * Cached "1/(clocks per usec)*2^32" value.
+ * Cached "1/(clocks per usec) * 2^32" value.
  * It has to be recalculated once each jiffy.
  */
 static unsigned long cached_quotient;
 
 /* Last jiffy when calibrate_divXX_gettimeoffset() was called. */
-static unsigned long last_jiffies = 0;
+static unsigned long last_jiffies;
 
 
 /*
- * This is copied from dec/time.c:do_ioasic_gettimeoffset() by Mercij.
+ * This is copied from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
  */
 unsigned long calibrate_div32_gettimeoffset(void)
 {
@@ -210,7 +207,7 @@ unsigned long calibrate_div32_gettimeoff
 			unsigned long r0;
 			do_div64_32(r0, timerhi, timerlo, tmp);
 			do_div64_32(quotient, USECS_PER_JIFFY,
-			            USECS_PER_JIFFY_FRAC, r0);
+				    USECS_PER_JIFFY_FRAC, r0);
 			cached_quotient = quotient;
 		}
 	}
@@ -221,9 +218,10 @@ unsigned long calibrate_div32_gettimeoff
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
 
-	__asm__("multu  %2,%3"
-	        : "=l" (tmp), "=h" (res)
-	        : "r" (count), "r" (quotient));
+	__asm__("multu  %1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (quotient)
+		: "lo", "accum");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -247,27 +245,24 @@ unsigned long calibrate_div64_gettimeoff
 
 	if (tmp && last_jiffies != tmp) {
 		last_jiffies = tmp;
-		__asm__(".set\tnoreorder\n\t"
-	        ".set\tnoat\n\t"
-	        ".set\tmips3\n\t"
-	        "lwu\t%0,%2\n\t"
-	        "dsll32\t$1,%1,0\n\t"
-	        "or\t$1,$1,%0\n\t"
-	        "ddivu\t$0,$1,%3\n\t"
-	        "mflo\t$1\n\t"
-	        "dsll32\t%0,%4,0\n\t"
-	        "nop\n\t"
-	        "ddivu\t$0,%0,$1\n\t"
-	        "mflo\t%0\n\t"
-	        ".set\tmips0\n\t"
-	        ".set\tat\n\t"
-	        ".set\treorder"
-	        :"=&r" (quotient)
-	        :"r" (timerhi),
-	         "m" (timerlo),
-	         "r" (tmp),
-	         "r" (USECS_PER_JIFFY));
-	        cached_quotient = quotient;
+		__asm__(".set	push\n\t"
+			".set	noreorder\n\t"
+			".set	noat\n\t"
+			".set	mips3\n\t"
+			"lwu	%0,%2\n\t"
+			"dsll32	$1,%1,0\n\t"
+			"or	$1,$1,%0\n\t"
+			"ddivu	$0,$1,%3\n\t"
+			"mflo	$1\n\t"
+			"dsll32	%0,%4,0\n\t"
+			"nop\n\t"
+			"ddivu	$0,%0,$1\n\t"
+			"mflo	%0\n\t"
+			".set	pop"
+			: "=&r" (quotient)
+			: "r" (timerhi), "m" (timerlo),
+			  "r" (tmp), "r" (USECS_PER_JIFFY));
+		cached_quotient = quotient;
 	}
 
 	/* Get last timer tick in absolute kernel time */
@@ -276,18 +271,17 @@ unsigned long calibrate_div64_gettimeoff
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
 
-	__asm__("multu\t%1,%2\n\t"
-	        "mfhi\t%0"
-	        :"=r" (res)
-	        :"r" (count),
-	         "r" (quotient));
+	__asm__("multu	%1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (quotient)
+		: "lo", "accum");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
 	 * the result so that we'll get a timer that is monotonic.
 	 */
 	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY-1;
+		res = USECS_PER_JIFFY - 1;
 
 	return res;
 }
@@ -317,8 +311,8 @@ void local_timer_interrupt(int irq, void
 			 * put them into the last histogram slot, so if
 			 * present, they will show up as a sharp peak.
 			 */
-			if (pc > prof_len-1)
-			pc = prof_len-1;
+			if (pc > prof_len - 1)
+				pc = prof_len - 1;
 			atomic_inc((atomic_t *)&prof_buffer[pc]);
 		}
 	}
@@ -345,7 +339,7 @@ void timer_interrupt(int irq, void *dev_
 
 		/* check to see if we have missed any timer interrupts */
 		if ((count - expirelo) < 0x7fffffff) {
-			/* missed_timer_count ++; */
+			/* missed_timer_count++; */
 			expirelo = count + cycles_per_jiffy;
 			write_c0_compare(expirelo);
 		}
@@ -365,7 +359,7 @@ void timer_interrupt(int irq, void *dev_
 	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	read_lock (&xtime_lock);
+	read_lock(&xtime_lock);
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
@@ -373,11 +367,11 @@ void timer_interrupt(int irq, void *dev_
 		if (rtc_set_time(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
-			last_rtc_update = xtime.tv_sec - 600;
 			/* do it again in 60 s */
+			last_rtc_update = xtime.tv_sec - 600;
 		}
 	}
-	read_unlock (&xtime_lock);
+	read_unlock(&xtime_lock);
 
 	/*
 	 * If jiffies has overflowed in this timer_interrupt we must
@@ -396,7 +390,7 @@ void timer_interrupt(int irq, void *dev_
 	 * In SMP mode, local_timer_interrupt() is invoked by appropriate
 	 * low-level local timer interrupt handler.
 	 */
-	local_timer_interrupt(0, NULL, regs);
+	local_timer_interrupt(irq, dev_id, regs);
 
 #else	/* CONFIG_SMP */
 
@@ -463,18 +457,15 @@ asmlinkage void ll_local_timer_interrupt
  *	c) enable the timer interrupt
  */
 
-void (*board_time_init)(void) = NULL;
-void (*board_timer_setup)(struct irqaction *irq) = NULL;
+void (*board_time_init)(void);
+void (*board_timer_setup)(struct irqaction *irq);
 
-unsigned int mips_counter_frequency = 0;
+unsigned int mips_counter_frequency;
 
 static struct irqaction timer_irqaction = {
-	timer_interrupt,
-	SA_INTERRUPT,
-	0,
-	"timer",
-	NULL,
-	NULL
+	.handler = timer_interrupt,
+	.flags = SA_INTERRUPT,
+	.name = "timer",
 };
 
 void __init time_init(void)
@@ -541,15 +532,15 @@ void __init time_init(void)
 #define STARTOFTIME		1970
 #define SECDAY			86400L
 #define SECYR			(SECDAY * 365)
-#define leapyear(year)		((year) % 4 == 0)
-#define days_in_year(a)		(leapyear(a) ? 366 : 365)
-#define days_in_month(a)	(month_days[(a) - 1])
+#define leapyear(y)		((!((y) % 4) && ((y) % 100)) || !((y) % 400))
+#define days_in_year(y)		(leapyear(y) ? 366 : 365)
+#define days_in_month(m)	(month_days[(m) - 1])
 
 static int month_days[12] = {
 	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
 };
 
-void to_tm(unsigned long tim, struct rtc_time * tm)
+void to_tm(unsigned long tim, struct rtc_time *tm)
 {
 	long hms, day, gday;
 	int i;
@@ -564,16 +555,16 @@ void to_tm(unsigned long tim, struct rtc
 
 	/* Number of years in days */
 	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-	day -= days_in_year(i);
+		day -= days_in_year(i);
 	tm->tm_year = i;
 
 	/* Number of months in days left */
 	if (leapyear(tm->tm_year))
-	days_in_month(FEBRUARY) = 29;
+		days_in_month(FEBRUARY) = 29;
 	for (i = 1; day >= days_in_month(i); i++)
-	day -= days_in_month(i);
+		day -= days_in_month(i);
 	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i-1;	/* tm_mon starts from 0 to 11 */
+	tm->tm_mon = i - 1;		/* tm_mon starts from 0 to 11 */
 
 	/* Days are what is left over (+1) from all that. */
 	tm->tm_mday = day + 1;
@@ -581,7 +572,7 @@ void to_tm(unsigned long tim, struct rtc
 	/*
 	 * Determine the day of week
 	 */
-	tm->tm_wday = (gday + 4) % 7; /* 1970/1/1 was Thursday */
+	tm->tm_wday = (gday + 4) % 7;	/* 1970/1/1 was Thursday */
 }
 
 EXPORT_SYMBOL(rtc_lock);
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/arch/mips64/kernel/time.c linux-mips-2.4.21-20030711/arch/mips64/kernel/time.c
--- linux-mips-2.4.21-20030711.macro/arch/mips64/kernel/time.c	2003-04-23 02:56:48.000000000 +0000
+++ linux-mips-2.4.21-20030711/arch/mips64/kernel/time.c	2003-07-21 20:28:39.000000000 +0000
@@ -1,9 +1,10 @@
 /*
  * Copyright 2001 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (c) 2003  Maciej W. Rozycki
  *
  * Common time service routines for MIPS machines. See
- * Documents/MIPS/README.txt.
+ * Documentation/mips/time.README.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -70,7 +71,7 @@ void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
 
-	read_lock_irqsave (&xtime_lock, flags);
+	read_lock_irqsave(&xtime_lock, flags);
 	*tv = xtime;
 	tv->tv_usec += do_gettimeoffset();
 
@@ -81,7 +82,7 @@ void do_gettimeofday(struct timeval *tv)
 	if (jiffies - wall_jiffies)
 		tv->tv_usec += USECS_PER_JIFFY;
 
-	read_unlock_irqrestore (&xtime_lock, flags);
+	read_unlock_irqrestore(&xtime_lock, flags);
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -91,7 +92,7 @@ void do_gettimeofday(struct timeval *tv)
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	write_lock_irq(&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
@@ -111,7 +112,7 @@ void do_settimeofday(struct timeval *tv)
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	write_unlock_irq(&xtime_lock);
 }
 
 
@@ -128,14 +129,11 @@ void do_settimeofday(struct timeval *tv)
  */
 
 
-/* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
-
 /* usecs per counter cycle, shifted to left by 32 bits */
-static unsigned int sll32_usecs_per_cycle=0;
+static unsigned int sll32_usecs_per_cycle;
 
 /* how many counter cycles in a jiffy */
-static unsigned long cycles_per_jiffy=0;
+static unsigned long cycles_per_jiffy;
 
 /* Cycle counter value at the previous timer interrupt.. */
 static unsigned int timerhi, timerlo;
@@ -165,34 +163,33 @@ unsigned long fixed_rate_gettimeoffset(v
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
 
-	__asm__("multu\t%1,%2\n\t"
-	        "mfhi\t%0"
-	        :"=r" (res)
-	        :"r" (count),
-	         "r" (sll32_usecs_per_cycle));
+	__asm__("multu	%1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (sll32_usecs_per_cycle)
+		: "lo", "accum");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
 	 * the result so that we'll get a timer that is monotonic.
 	 */
 	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY-1;
+		res = USECS_PER_JIFFY - 1;
 
 	return res;
 }
 
 /*
- * Cached "1/(clocks per usec)*2^32" value.
+ * Cached "1/(clocks per usec) * 2^32" value.
  * It has to be recalculated once each jiffy.
  */
 static unsigned long cached_quotient;
 
 /* Last jiffy when calibrate_divXX_gettimeoffset() was called. */
-static unsigned long last_jiffies = 0;
+static unsigned long last_jiffies;
 
 
 /*
- * This is copied from dec/time.c:do_ioasic_gettimeoffset() by Mercij.
+ * This is copied from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
  */
 unsigned long calibrate_div32_gettimeoffset(void)
 {
@@ -210,7 +207,7 @@ unsigned long calibrate_div32_gettimeoff
 			unsigned long r0;
 			do_div64_32(r0, timerhi, timerlo, tmp);
 			do_div64_32(quotient, USECS_PER_JIFFY,
-			            USECS_PER_JIFFY_FRAC, r0);
+				    USECS_PER_JIFFY_FRAC, r0);
 			cached_quotient = quotient;
 		}
 	}
@@ -221,9 +218,10 @@ unsigned long calibrate_div32_gettimeoff
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
 
-	__asm__("multu  %2,%3"
-	        : "=l" (tmp), "=h" (res)
-	        : "r" (count), "r" (quotient));
+	__asm__("multu  %1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (quotient)
+		: "lo", "accum");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -247,27 +245,24 @@ unsigned long calibrate_div64_gettimeoff
 
 	if (tmp && last_jiffies != tmp) {
 		last_jiffies = tmp;
-		__asm__(".set\tnoreorder\n\t"
-	        ".set\tnoat\n\t"
-	        ".set\tmips3\n\t"
-	        "lwu\t%0,%2\n\t"
-	        "dsll32\t$1,%1,0\n\t"
-	        "or\t$1,$1,%0\n\t"
-	        "ddivu\t$0,$1,%3\n\t"
-	        "mflo\t$1\n\t"
-	        "dsll32\t%0,%4,0\n\t"
-	        "nop\n\t"
-	        "ddivu\t$0,%0,$1\n\t"
-	        "mflo\t%0\n\t"
-	        ".set\tmips0\n\t"
-	        ".set\tat\n\t"
-	        ".set\treorder"
-	        :"=&r" (quotient)
-	        :"r" (timerhi),
-	         "m" (timerlo),
-	         "r" (tmp),
-	         "r" (USECS_PER_JIFFY));
-	        cached_quotient = quotient;
+		__asm__(".set	push\n\t"
+			".set	noreorder\n\t"
+			".set	noat\n\t"
+			".set	mips3\n\t"
+			"lwu	%0,%2\n\t"
+			"dsll32	$1,%1,0\n\t"
+			"or	$1,$1,%0\n\t"
+			"ddivu	$0,$1,%3\n\t"
+			"mflo	$1\n\t"
+			"dsll32	%0,%4,0\n\t"
+			"nop\n\t"
+			"ddivu	$0,%0,$1\n\t"
+			"mflo	%0\n\t"
+			".set	pop"
+			: "=&r" (quotient)
+			: "r" (timerhi), "m" (timerlo),
+			  "r" (tmp), "r" (USECS_PER_JIFFY));
+		cached_quotient = quotient;
 	}
 
 	/* Get last timer tick in absolute kernel time */
@@ -276,18 +271,17 @@ unsigned long calibrate_div64_gettimeoff
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
 
-	__asm__("multu\t%1,%2\n\t"
-	        "mfhi\t%0"
-	        :"=r" (res)
-	        :"r" (count),
-	         "r" (quotient));
+	__asm__("multu	%1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (quotient)
+		: "lo", "accum");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
 	 * the result so that we'll get a timer that is monotonic.
 	 */
 	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY-1;
+		res = USECS_PER_JIFFY - 1;
 
 	return res;
 }
@@ -317,8 +311,8 @@ void local_timer_interrupt(int irq, void
 			 * put them into the last histogram slot, so if
 			 * present, they will show up as a sharp peak.
 			 */
-			if (pc > prof_len-1)
-			pc = prof_len-1;
+			if (pc > prof_len - 1)
+				pc = prof_len - 1;
 			atomic_inc((atomic_t *)&prof_buffer[pc]);
 		}
 	}
@@ -345,7 +339,7 @@ void timer_interrupt(int irq, void *dev_
 
 		/* check to see if we have missed any timer interrupts */
 		if ((count - expirelo) < 0x7fffffff) {
-			/* missed_timer_count ++; */
+			/* missed_timer_count++; */
 			expirelo = count + cycles_per_jiffy;
 			write_c0_compare(expirelo);
 		}
@@ -365,7 +359,7 @@ void timer_interrupt(int irq, void *dev_
 	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	read_lock (&xtime_lock);
+	read_lock(&xtime_lock);
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
@@ -373,11 +367,11 @@ void timer_interrupt(int irq, void *dev_
 		if (rtc_set_time(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
-			last_rtc_update = xtime.tv_sec - 600;
 			/* do it again in 60 s */
+			last_rtc_update = xtime.tv_sec - 600;
 		}
 	}
-	read_unlock (&xtime_lock);
+	read_unlock(&xtime_lock);
 
 	/*
 	 * If jiffies has overflowed in this timer_interrupt we must
@@ -396,7 +390,7 @@ void timer_interrupt(int irq, void *dev_
 	 * In SMP mode, local_timer_interrupt() is invoked by appropriate
 	 * low-level local timer interrupt handler.
 	 */
-	local_timer_interrupt(0, NULL, regs);
+	local_timer_interrupt(irq, dev_id, regs);
 
 #else	/* CONFIG_SMP */
 
@@ -463,18 +457,15 @@ asmlinkage void ll_local_timer_interrupt
  *	c) enable the timer interrupt
  */
 
-void (*board_time_init)(void) = NULL;
-void (*board_timer_setup)(struct irqaction *irq) = NULL;
+void (*board_time_init)(void);
+void (*board_timer_setup)(struct irqaction *irq);
 
-unsigned int mips_counter_frequency = 0;
+unsigned int mips_counter_frequency;
 
 static struct irqaction timer_irqaction = {
-	timer_interrupt,
-	SA_INTERRUPT,
-	0,
-	"timer",
-	NULL,
-	NULL
+	.handler = timer_interrupt,
+	.flags = SA_INTERRUPT,
+	.name = "timer",
 };
 
 void __init time_init(void)
@@ -541,15 +532,15 @@ void __init time_init(void)
 #define STARTOFTIME		1970
 #define SECDAY			86400L
 #define SECYR			(SECDAY * 365)
-#define leapyear(year)		((year) % 4 == 0)
-#define days_in_year(a)		(leapyear(a) ? 366 : 365)
-#define days_in_month(a)	(month_days[(a) - 1])
+#define leapyear(y)		((!((y) % 4) && ((y) % 100)) || !((y) % 400))
+#define days_in_year(y)		(leapyear(y) ? 366 : 365)
+#define days_in_month(m)	(month_days[(m) - 1])
 
 static int month_days[12] = {
 	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
 };
 
-void to_tm(unsigned long tim, struct rtc_time * tm)
+void to_tm(unsigned long tim, struct rtc_time *tm)
 {
 	long hms, day, gday;
 	int i;
@@ -564,16 +555,16 @@ void to_tm(unsigned long tim, struct rtc
 
 	/* Number of years in days */
 	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-	day -= days_in_year(i);
+		day -= days_in_year(i);
 	tm->tm_year = i;
 
 	/* Number of months in days left */
 	if (leapyear(tm->tm_year))
-	days_in_month(FEBRUARY) = 29;
+		days_in_month(FEBRUARY) = 29;
 	for (i = 1; day >= days_in_month(i); i++)
-	day -= days_in_month(i);
+		day -= days_in_month(i);
 	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i-1;	/* tm_mon starts from 0 to 11 */
+	tm->tm_mon = i - 1;		/* tm_mon starts from 0 to 11 */
 
 	/* Days are what is left over (+1) from all that. */
 	tm->tm_mday = day + 1;
@@ -581,7 +572,7 @@ void to_tm(unsigned long tim, struct rtc
 	/*
 	 * Determine the day of week
 	 */
-	tm->tm_wday = (gday + 4) % 7; /* 1970/1/1 was Thursday */
+	tm->tm_wday = (gday + 4) % 7;	/* 1970/1/1 was Thursday */
 }
 
 EXPORT_SYMBOL(rtc_lock);
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/include/asm-mips/time.h linux-mips-2.4.21-20030711/include/asm-mips/time.h
--- linux-mips-2.4.21-20030711.macro/include/asm-mips/time.h	2003-07-16 01:17:24.000000000 +0000
+++ linux-mips-2.4.21-20030711/include/asm-mips/time.h	2003-07-21 21:02:58.000000000 +0000
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2001, 2002, MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (c) 2003  Maciej W. Rozycki
  *
  * include/asm-mips/time.h
  *     header file for the new style time.c file and time services.
@@ -13,7 +14,7 @@
  */
 
 /*
- * Please refer to Documentation/MIPS/time.README.
+ * Please refer to Documentation/mips/time.README.
  */
 
 #ifndef _ASM_TIME_H
@@ -24,7 +25,7 @@
 #include <linux/rtc.h>                  /* for struct rtc_time */
 
 /*
- * RTC ops.  By default, they point a no-RTC functions.
+ * RTC ops.  By default, they point to no-RTC functions.
  *	rtc_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
  *	rtc_set_time - reverse the above translation and set time to RTC.
  */
@@ -36,12 +37,12 @@ extern int (*rtc_set_time)(unsigned long
  * It is intended to help implement rtc_set_time() functions.
  * Copied from PPC implementation.
  */
-extern void to_tm(unsigned long tim, struct rtc_time * tm);
+extern void to_tm(unsigned long tim, struct rtc_time *tm);
 
 /*
  * do_gettimeoffset(). By default, this func pointer points to
  * do_null_gettimeoffset(), which leads to the same resolution as HZ.
- * Higher resolution versions are vailable, which gives ~1us resolution.
+ * Higher resolution versions are available, which give ~1us resolution.
  */
 extern unsigned long (*do_gettimeoffset)(void);
 
@@ -58,17 +59,17 @@ extern void timer_interrupt(int irq, voi
 /*
  * the corresponding low-level timer interrupt routine.
  */
-asmlinkage void ll_timer_interrupt(int irq, struct pt_regs *regs);
+extern asmlinkage void ll_timer_interrupt(int irq, struct pt_regs *regs);
 
 /*
  * profiling and process accouting is done separately in local_timer_interrupt
  */
-void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-asmlinkage void ll_local_timer_interrupt(int irq, struct pt_regs *regs);
+extern void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern asmlinkage void ll_local_timer_interrupt(int irq, struct pt_regs *regs);
 
 /*
  * board specific routines required by time_init().
- * board_time_init is defaulted to NULL and can remains so.
+ * board_time_init is defaulted to NULL and can remain so.
  * board_timer_setup must be setup properly in machine setup routine.
  */
 struct irqaction;
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/include/asm-mips64/time.h linux-mips-2.4.21-20030711/include/asm-mips64/time.h
--- linux-mips-2.4.21-20030711.macro/include/asm-mips64/time.h	2003-01-11 19:23:38.000000000 +0000
+++ linux-mips-2.4.21-20030711/include/asm-mips64/time.h	2003-07-21 21:02:58.000000000 +0000
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2001, 2002, MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (c) 2003  Maciej W. Rozycki
  *
  * include/asm-mips/time.h
  *     header file for the new style time.c file and time services.
@@ -13,7 +14,7 @@
  */
 
 /*
- * Please refer to Documentation/MIPS/time.README.
+ * Please refer to Documentation/mips/time.README.
  */
 
 #ifndef _ASM_TIME_H
@@ -24,7 +25,7 @@
 #include <linux/rtc.h>                  /* for struct rtc_time */
 
 /*
- * RTC ops.  By default, they point a no-RTC functions.
+ * RTC ops.  By default, they point to no-RTC functions.
  *	rtc_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
  *	rtc_set_time - reverse the above translation and set time to RTC.
  */
@@ -36,12 +37,12 @@ extern int (*rtc_set_time)(unsigned long
  * It is intended to help implement rtc_set_time() functions.
  * Copied from PPC implementation.
  */
-extern void to_tm(unsigned long tim, struct rtc_time * tm);
+extern void to_tm(unsigned long tim, struct rtc_time *tm);
 
 /*
  * do_gettimeoffset(). By default, this func pointer points to
  * do_null_gettimeoffset(), which leads to the same resolution as HZ.
- * Higher resolution versions are vailable, which gives ~1us resolution.
+ * Higher resolution versions are available, which give ~1us resolution.
  */
 extern unsigned long (*do_gettimeoffset)(void);
 
@@ -58,17 +59,17 @@ extern void timer_interrupt(int irq, voi
 /*
  * the corresponding low-level timer interrupt routine.
  */
-asmlinkage void ll_timer_interrupt(int irq, struct pt_regs *regs);
+extern asmlinkage void ll_timer_interrupt(int irq, struct pt_regs *regs);
 
 /*
  * profiling and process accouting is done separately in local_timer_interrupt
  */
-void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-asmlinkage void ll_local_timer_interrupt(int irq, struct pt_regs *regs);
+extern void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern asmlinkage void ll_local_timer_interrupt(int irq, struct pt_regs *regs);
 
 /*
  * board specific routines required by time_init().
- * board_time_init is defaulted to NULL and can remains so.
+ * board_time_init is defaulted to NULL and can remain so.
  * board_timer_setup must be setup properly in machine setup routine.
  */
 struct irqaction;
