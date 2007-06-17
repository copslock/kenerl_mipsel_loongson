Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2007 18:02:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:420 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023024AbXFQRCJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Jun 2007 18:02:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5HGsHl6031402;
	Sun, 17 Jun 2007 17:54:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5H04mxs030862;
	Sun, 17 Jun 2007 01:04:48 +0100
Date:	Sun, 17 Jun 2007 01:04:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Message-ID: <20070617000448.GA30807@linux-mips.org>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164024053-git-send-email-fbuihuu@gmail.com> <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 14, 2007 at 09:29:13PM +0900, Atsushi Nemoto wrote:

> I think this to_tm() cleanup should be done in separate patch.
> 
> Maybe selecting RTC_LIB in Kconfig and replace all to_tm() calls with
> 
> 	rtc_time_to_tm(tim, tm);
> 	tm->tm_year += 1900;
> 
> would be enough.

Looks good to me, done.

  Ralf

[MIPS] Switch from to_tm to rtc_time_to_tm

This replaces the MIPS-specific to_tm function with the generic
rtc_time_to_tm function.  The big difference between the two functions is
that rtc_time_to_tm uses epoch 70 while to_tm uses 1970, so the result of
rtc_time_to_tm needs to be fixed up.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/Kconfig                      |    1 
 arch/mips/ddb5xxx/common/rtc_ds1386.c  |    5 +--
 arch/mips/kernel/time.c                |   48 ---------------------------------
 arch/mips/momentum/jaguar_atx/setup.c  |    8 ++++-
 arch/mips/momentum/ocelot_3/setup.c    |    8 ++++-
 arch/mips/momentum/ocelot_c/setup.c    |    8 ++++-
 arch/mips/pmc-sierra/yosemite/setup.c  |    8 ++++-
 arch/mips/sgi-ip22/ip22-time.c         |    6 ++--
 arch/mips/sibyte/swarm/rtc_m41t81.c    |    3 +-
 arch/mips/sibyte/swarm/rtc_xicor1241.c |    3 +-
 arch/mips/tx4938/common/rtc_rx5c348.c  |    4 +-
 include/asm-mips/time.h                |    7 ----
 12 files changed, 36 insertions(+), 73 deletions(-)

Index: linux-time/arch/mips/Kconfig
===================================================================
--- linux-time.orig/arch/mips/Kconfig
+++ linux-time/arch/mips/Kconfig
@@ -3,6 +3,7 @@ config MIPS
 	default y
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
+	select RTC_LIB
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
Index: linux-time/include/asm-mips/time.h
===================================================================
--- linux-time.orig/include/asm-mips/time.h
+++ linux-time/include/asm-mips/time.h
@@ -49,13 +49,6 @@ extern void (*mips_timer_ack)(void);
 extern struct clocksource clocksource_mips;
 
 /*
- * to_tm() converts system time back to (year, mon, day, hour, min, sec).
- * It is intended to help implement rtc_set_time() functions.
- * Copied from PPC implementation.
- */
-extern void to_tm(unsigned long tim, struct rtc_time *tm);
-
-/*
  * the corresponding low-level timer interrupt routine.
  */
 extern irqreturn_t ll_timer_interrupt(int irq, void *dev_id);
Index: linux-time/arch/mips/momentum/jaguar_atx/setup.c
===================================================================
--- linux-time.orig/arch/mips/momentum/jaguar_atx/setup.c
+++ linux-time/arch/mips/momentum/jaguar_atx/setup.c
@@ -176,8 +176,12 @@ int rtc_mips_set_time(unsigned long sec)
 	struct rtc_time tm;
 	unsigned long flags;
 
-	/* convert to a more useful format -- note months count from 0 */
-	to_tm(sec, &tm);
+	/*
+	 * Convert to a more useful format -- note months count from 0
+	 * and years from 1900
+	 */
+	rtc_time_to_tm(sec, &tm);
+	tm.tm_year += 1900;
 	tm.tm_mon += 1;
 
 	spin_lock_irqsave(&rtc_lock, flags);
Index: linux-time/arch/mips/tx4938/common/rtc_rx5c348.c
===================================================================
--- linux-time.orig/arch/mips/tx4938/common/rtc_rx5c348.c
+++ linux-time/arch/mips/tx4938/common/rtc_rx5c348.c
@@ -86,8 +86,8 @@ int rtc_mips_set_time(unsigned long t)
 	struct rtc_time tm;
 	u8 year, month, day, hour, minute, second, century;
 
-	/* convert */
-	to_tm(t, &tm);
+	rtc_time_to_tm(t, &tm);			/* convert */
+	tm.tm_year += 1900;
 
 	year = tm.tm_year % 100;
 	month = tm.tm_mon+1;	/* tm_mon starts from 0 to 11 */
Index: linux-time/arch/mips/ddb5xxx/common/rtc_ds1386.c
===================================================================
--- linux-time.orig/arch/mips/ddb5xxx/common/rtc_ds1386.c
+++ linux-time/arch/mips/ddb5xxx/common/rtc_ds1386.c
@@ -90,9 +90,8 @@ static int rtc_mips_set_time(unsigned lo
 	byte &= 0x3f;
 	WRITE_RTC(0xB, byte);
 
-	/* convert */
-	to_tm(t, &tm);
-
+	rtc_time_to_tm(t, &tm);			/* convert */
+	tm.tm_year += 1900;
 
 	/* check each field one by one */
 	year = BIN2BCD(tm.tm_year - EPOCH);
Index: linux-time/arch/mips/kernel/time.c
===================================================================
--- linux-time.orig/arch/mips/kernel/time.c
+++ linux-time/arch/mips/kernel/time.c
@@ -431,53 +431,5 @@ void __init time_init(void)
 #endif /* CONFIG_MIPS_MT_SMTC */
 }
 
-#define FEBRUARY		2
-#define STARTOFTIME		1970
-#define SECDAY			86400L
-#define SECYR			(SECDAY * 365)
-#define leapyear(y)		((!((y) % 4) && ((y) % 100)) || !((y) % 400))
-#define days_in_year(y)		(leapyear(y) ? 366 : 365)
-#define days_in_month(m)	(month_days[(m) - 1])
-
-static int month_days[12] = {
-	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
-};
-
-void to_tm(unsigned long tim, struct rtc_time *tm)
-{
-	long hms, day, gday;
-	int i;
-
-	gday = day = tim / SECDAY;
-	hms = tim % SECDAY;
-
-	/* Hours, minutes, seconds are easy */
-	tm->tm_hour = hms / 3600;
-	tm->tm_min = (hms % 3600) / 60;
-	tm->tm_sec = (hms % 3600) % 60;
-
-	/* Number of years in days */
-	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-		day -= days_in_year(i);
-	tm->tm_year = i;
-
-	/* Number of months in days left */
-	if (leapyear(tm->tm_year))
-		days_in_month(FEBRUARY) = 29;
-	for (i = 1; day >= days_in_month(i); i++)
-		day -= days_in_month(i);
-	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i - 1;		/* tm_mon starts from 0 to 11 */
-
-	/* Days are what is left over (+1) from all that. */
-	tm->tm_mday = day + 1;
-
-	/*
-	 * Determine the day of week
-	 */
-	tm->tm_wday = (gday + 4) % 7;	/* 1970/1/1 was Thursday */
-}
-
 EXPORT_SYMBOL(rtc_lock);
-EXPORT_SYMBOL(to_tm);
 EXPORT_SYMBOL(rtc_mips_set_time);
Index: linux-time/arch/mips/momentum/ocelot_3/setup.c
===================================================================
--- linux-time.orig/arch/mips/momentum/ocelot_3/setup.c
+++ linux-time/arch/mips/momentum/ocelot_3/setup.c
@@ -162,8 +162,12 @@ int rtc_mips_set_time(unsigned long sec)
 	struct rtc_time tm;
 	unsigned long flags;
 
-	/* convert to a more useful format -- note months count from 0 */
-	to_tm(sec, &tm);
+	/*
+	 * Convert to a more useful format -- note months count from 0
+	 * and years from 1900
+	 */
+	rtc_time_to_tm(sec, &tm);
+	tm.tm_year += 1900;
 	tm.tm_mon += 1;
 
 	spin_lock_irqsave(&rtc_lock, flags);
Index: linux-time/arch/mips/momentum/ocelot_c/setup.c
===================================================================
--- linux-time.orig/arch/mips/momentum/ocelot_c/setup.c
+++ linux-time/arch/mips/momentum/ocelot_c/setup.c
@@ -170,8 +170,12 @@ int rtc_mips_set_time(unsigned long sec)
 	struct rtc_time tm;
 	unsigned long flags;
 
-	/* convert to a more useful format -- note months count from 0 */
-	to_tm(sec, &tm);
+	/*
+	 * Convert to a more useful format -- note months count from 0
+	 * and years from 1900
+	 */
+	rtc_time_to_tm(sec, &tm);
+	tm.tm_year += 1900;
 	tm.tm_mon += 1;
 
 	spin_lock_irqsave(&rtc_lock, flags);
Index: linux-time/arch/mips/pmc-sierra/yosemite/setup.c
===================================================================
--- linux-time.orig/arch/mips/pmc-sierra/yosemite/setup.c
+++ linux-time/arch/mips/pmc-sierra/yosemite/setup.c
@@ -99,8 +99,12 @@ int rtc_mips_set_time(unsigned long sec)
 	struct rtc_time tm;
 	unsigned long flags;
 
-	/* convert to a more useful format -- note months count from 0 */
-	to_tm(sec, &tm);
+	/*
+	 * Convert to a more useful format -- note months count from 0
+	 * and years from 1900
+	 */
+	rtc_time_to_tm(sec, &tm);
+	tm.tm_year += 1900;
 	tm.tm_mon += 1;
 
 	spin_lock_irqsave(&rtc_lock, flags);
Index: linux-time/arch/mips/sgi-ip22/ip22-time.c
===================================================================
--- linux-time.orig/arch/mips/sgi-ip22/ip22-time.c
+++ linux-time/arch/mips/sgi-ip22/ip22-time.c
@@ -30,7 +30,7 @@
 #include <asm/sgi/ip22.h>
 
 /*
- * note that mktime uses month from 1 to 12 while to_tm
+ * Note that mktime uses month from 1 to 12 while rtc_time_to_tm
  * uses 0 to 11.
  */
 unsigned long read_persistent_clock(void)
@@ -67,10 +67,10 @@ int rtc_mips_set_time(unsigned long tim)
 	unsigned int save_control;
 	unsigned long flags;
 
-	to_tm(tim, &tm);
+	rtc_time_to_tm(tim, &tm);
 
 	tm.tm_mon += 1;		/* tm_mon starts at zero */
-	tm.tm_year -= 1940;
+	tm.tm_year -= 40;
 	if (tm.tm_year >= 100)
 		tm.tm_year -= 100;
 
Index: linux-time/arch/mips/sibyte/swarm/rtc_m41t81.c
===================================================================
--- linux-time.orig/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ linux-time/arch/mips/sibyte/swarm/rtc_m41t81.c
@@ -146,7 +146,8 @@ int m41t81_set_time(unsigned long t)
 	struct rtc_time tm;
 	unsigned long flags;
 
-	to_tm(t, &tm);
+	/* Note we don't care about the century */
+	rtc_time_to_tm(t, &tm);
 
 	/*
 	 * Note the write order matters as it ensures the correctness.
Index: linux-time/arch/mips/sibyte/swarm/rtc_xicor1241.c
===================================================================
--- linux-time.orig/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ linux-time/arch/mips/sibyte/swarm/rtc_xicor1241.c
@@ -115,7 +115,8 @@ int xicor_set_time(unsigned long t)
 	int tmp;
 	unsigned long flags;
 
-	to_tm(t, &tm);
+	rtc_time_to_tm(t, &tm);
+	tm.tm_year += 1900;
 
 	spin_lock_irqsave(&rtc_lock, flags);
 	/* unlock writes to the CCR */
