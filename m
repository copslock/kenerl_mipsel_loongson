Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 13:05:44 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:31161 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225207AbTHAMFl>; Fri, 1 Aug 2003 13:05:41 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA06657;
	Fri, 1 Aug 2003 14:04:30 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 1 Aug 2003 14:04:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] More time fixes: do_gettimeofday() & do_settimeofday()
Message-ID: <Pine.GSO.3.96.1030801134735.3800D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Here are fixes for do_gettimeofday() and do_settimeofday() not taking the
wall time and the value of tick properly into account.  OK to apply? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-20030725-mips-timeofday-0
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/arch/mips/kernel/time.c linux-mips-2.4.21-20030725/arch/mips/kernel/time.c
--- linux-mips-2.4.21-20030725.macro/arch/mips/kernel/time.c	2003-07-25 02:56:34.000000000 +0000
+++ linux-mips-2.4.21-20030725/arch/mips/kernel/time.c	2003-07-31 21:27:18.000000000 +0000
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/param.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
@@ -70,22 +71,23 @@ int (*rtc_set_mmss)(unsigned long);
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long flags, lost;
 
 	read_lock_irqsave(&xtime_lock, flags);
+
 	*tv = xtime;
 	tv->tv_usec += do_gettimeoffset();
-
 	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
+	 * xtime is atomically updated in timer_bh.  jiffies - wall_jiffies
+	 * is nonzero if the timer bottom half hasn't executed yet.
 	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+	lost = jiffies - wall_jiffies;
+	if (lost)
+		tv->tv_usec += lost * tick;
 
 	read_unlock_irqrestore(&xtime_lock, flags);
 
-	if (tv->tv_usec >= 1000000) {
+	while (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
 		tv->tv_sec++;
 	}
@@ -95,18 +97,20 @@ void do_settimeofday(struct timeval *tv)
 {
 	write_lock_irq(&xtime_lock);
 
-	/* This is revolting. We need to set the xtime.tv_usec
-	 * correctly. However, the value in this location is
-	 * is value at the last tick.
-	 * Discover what correction gettimeofday
-	 * would have done, and then undo it!
+	/*
+	 * This is revolting.  We need to set "xtime" correctly.  However,
+	 * the value in this location is the value at the most recent update
+	 * of wall time.  Discover what correction gettimeofday() would have
+	 * done, and then undo it!
 	 */
 	tv->tv_usec -= do_gettimeoffset();
+	tv->tv_usec -= (jiffies - wall_jiffies) * tick;
 
-	if (tv->tv_usec < 0) {
+	while (tv->tv_usec < 0) {
 		tv->tv_usec += 1000000;
 		tv->tv_sec--;
 	}
+
 	xtime = *tv;
 	time_adjust = 0;			/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
