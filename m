Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 17:35:12 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:62353 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225245AbTHDQfG>; Mon, 4 Aug 2003 17:35:06 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA20158;
	Mon, 4 Aug 2003 18:34:58 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 4 Aug 2003 18:34:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] 2.6: More time fixes: do_gettimeofday() & do_settimeofday()
Message-ID: <Pine.GSO.3.96.1030804183025.17066H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Here is the respective update for the trunk.  OK?

 I think the code in the trunk and in the 2.4 branch can be further
unified.  Removing syntactic inconsistencies will lead to easier
cross-version maintenance.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.6.0-test2-20030804-mips-timeofday-1
diff -up --recursive --new-file linux-mips-2.6.0-test2-20030804.macro/arch/mips/kernel/time.c linux-mips-2.6.0-test2-20030804/arch/mips/kernel/time.c
--- linux-mips-2.6.0-test2-20030804.macro/arch/mips/kernel/time.c	Thu Jul 31 14:54:57 2003
+++ linux-mips-2.6.0-test2-20030804/arch/mips/kernel/time.c	Mon Aug  4 15:28:28 2003
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/param.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
@@ -76,18 +77,21 @@ int (*rtc_set_mmss)(unsigned long);
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long seq;
+	unsigned long lost;
 	unsigned long usec, sec;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
+
 		usec = do_gettimeoffset();
-		{
-			unsigned long lost = jiffies - wall_jiffies;
-			if (lost)
-				usec += lost * (1000000 / HZ);
-		}
+
+		lost = jiffies - wall_jiffies;
+		if (lost)
+			usec += lost * TICK_SIZE;
+
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
+
 	} while (read_seqretry(&xtime_lock, seq));
 
 	while (usec >= 1000000) {
@@ -108,14 +112,15 @@ int do_settimeofday(struct timespec *tv)
 		return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
+
 	/*
-	 * This is revolting. We need to set "xtime" correctly. However, the
-	 * value in this location is the value at the most recent update of
-	 * wall time.  Discover what correction gettimeofday() would have
+	 * This is revolting.  We need to set "xtime" correctly.  However,
+	 * the value in this location is the value at the most recent update
+	 * of wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
 	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
+	nsec -= (jiffies - wall_jiffies) * tick_nsec;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
@@ -123,10 +128,11 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
+	time_adjust = 0;			/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
+
 	write_sequnlock_irq(&xtime_lock);
 
 	return 0;
