Received:  by oss.sgi.com id <S42289AbQHNLlQ>;
	Mon, 14 Aug 2000 04:41:16 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53495 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42186AbQHNLkw>;
	Mon, 14 Aug 2000 04:40:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA17800;
	Mon, 14 Aug 2000 13:39:48 +0200 (MET DST)
Date:   Mon, 14 Aug 2000 13:39:47 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: NTP support code updates
Message-ID: <Pine.GSO.3.96.1000814132107.7256R-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Wondering why my RTC's time drifts away when the NTP daemon is running I
discovered to my surprise that our NTP support code is still of 2.0
vintage and simply does not work.  As a result set_rtc_mmss() does not get
called at all.

 The following patch updates the relevant code for both MIPS and MIPS64
to match the rest of the kernel.  I've only tested the DEC path but
changes are straightforward and should work for all variations.

 [Hmm, now my dispersion changes between 1 and 0.1 -- the set_rtc_mmss() 
function resets the RTC's divider and as a result further timer interrupts
do not arrive exactly at the right time.  This probably cannot be avoided
(apart from by disabling set_rtc_mmss()) but the code needs to be updated
regardless.]

 Comments are welcomed, as usually.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/baget/time.c linux-mips-2.4.0-test5-20000731/arch/mips/baget/time.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/baget/time.c	Tue Mar 28 04:26:01 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/baget/time.c	Sat Aug 12 21:47:26 2000
@@ -76,21 +76,22 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-        unsigned long flags;
+	unsigned long flags;
 
-        save_and_cli(flags);
-        *tv = xtime;
-        restore_flags(flags);
+	save_and_cli(flags);
+	*tv = xtime;
+	restore_flags(flags);
 }
 
 void do_settimeofday(struct timeval *tv)
 {
-        unsigned long flags;
+	unsigned long flags;
   
-        save_and_cli(flags);
-        xtime = *tv;
-        time_state = TIME_BAD;
-        time_maxerror = MAXPHASE;
-        time_esterror = MAXPHASE;
-        restore_flags(flags);
-} 
+	save_and_cli(flags);
+	xtime = *tv;
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+	restore_flags(flags);
+}
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/time.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/time.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/time.c	Wed Jul 12 04:25:56 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/time.c	Sat Aug 12 21:58:23 2000
@@ -187,6 +187,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 	write_lock_irq(&xtime_lock);
+
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
@@ -199,10 +200,13 @@
 		tv->tv_usec += 1000000;
 		tv->tv_sec--;
 	}
+
 	xtime = *tv;
-	time_state = TIME_BAD;
-	time_maxerror = MAXPHASE;
-	time_esterror = MAXPHASE;
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+
 	write_unlock_irq(&xtime_lock);
 }
 
@@ -307,13 +311,15 @@
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
 	read_lock(&xtime_lock);
-	if (time_state != TIME_BAD && xtime.tv_sec > last_rtc_update + 660 &&
-	    xtime.tv_usec > 500000 - (tick >> 1) &&
-	    xtime.tv_usec < 500000 + (tick >> 1)) {
+	if ((time_status & STA_UNSYNC) == 0
+	    && xtime.tv_sec > last_rtc_update + 660
+	    && xtime.tv_usec >= 500000 - tick / 2
+	    && xtime.tv_usec <= 500000 + tick / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
-			last_rtc_update = xtime.tv_sec - 600;	/* do it again in 60 s */
+			/* do it again in 60 s */
+			last_rtc_update = xtime.tv_sec - 600;
	}
 	/* As we return to user mode fire off the other CPU schedulers.. this is
 	   basically because we don't yet share IRQ's around. This message is
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/sgi/kernel/indy_timer.c linux-mips-2.4.0-test5-20000731/arch/mips/sgi/kernel/indy_timer.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/sgi/kernel/indy_timer.c	Tue Mar 28 04:26:13 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/sgi/kernel/indy_timer.c	Sat Aug 12 21:25:13 2000
@@ -290,8 +290,9 @@
 {
 	write_lock_irq(&xtime_lock);
 	xtime = *tv;
-	time_state = TIME_BAD;
-	time_maxerror = MAXPHASE;
-	time_esterror = MAXPHASE;
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
 	write_unlock_irq(&xtime_lock);
 }
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips64/sgi-ip22/ip22-timer.c linux-mips-2.4.0-test5-20000731/arch/mips64/sgi-ip22/ip22-timer.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips64/sgi-ip22/ip22-timer.c	Mon Mar 27 04:26:15 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips64/sgi-ip22/ip22-timer.c	Sat Aug 12 21:32:29 2000
@@ -288,8 +288,9 @@
 {
 	write_lock_irq(&xtime_lock);
 	xtime = *tv;
-	time_state = TIME_BAD;
-	time_maxerror = MAXPHASE;
-	time_esterror = MAXPHASE;
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
 	write_unlock_irq(&xtime_lock);
 }
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips64/sgi-ip27/ip27-timer.c linux-mips-2.4.0-test5-20000731/arch/mips64/sgi-ip27/ip27-timer.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips64/sgi-ip27/ip27-timer.c	Thu Jul 13 04:26:16 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips64/sgi-ip27/ip27-timer.c	Sat Aug 12 21:33:21 2000
@@ -206,9 +206,9 @@
 
 	xtime = *tv;
 	time_adjust = 0;		/* stop active adjtime() */
-	time_state = TIME_BAD;
-	time_maxerror = MAXPHASE;
-	time_esterror = MAXPHASE;
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
 	write_unlock_irq(&xtime_lock);
 }
 
