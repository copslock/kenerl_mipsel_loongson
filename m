Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 12:13:46 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:26797 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225193AbTGXLNn>; Thu, 24 Jul 2003 12:13:43 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA11563;
	Thu, 24 Jul 2003 13:13:35 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 24 Jul 2003 13:13:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030723100043.M3135@mvista.com>
Message-ID: <Pine.GSO.3.96.1030724130418.10709B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 23 Jul 2003, Jun Sun wrote:

> Most people seem to be happy with getting hwclock working.  rtc_set_time()
> does allow a low-oevrhead way to implement a generic rtc driver which
> makes hwclock happy.

 Well, some people are not most people and they want a full-featured
implementation as described in Documentation/rtc.txt.

> I like see mc146818rtc related RTC go away eventually, but we don't have to 
> agree on that right now.

 You'll need to convince guys at the LKML first (me inclusive ;-) ).  If
you write a clean and full-featured replacement, you'll most likely be
welcome.

> You can either include it in your next patch (if one is coming).  Or
> just let me know and I will flesh it out and check it in.

 Here is an optimized replacement I'm going to check in -- OK?  Ralf?

 I'm working on further changes, but there is no point in coalescing
self-contained changes.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-20030711-mips-mmss-0
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/arch/mips/kernel/time.c linux-mips-2.4.21-20030711/arch/mips/kernel/time.c
--- linux-mips-2.4.21-20030711.macro/arch/mips/kernel/time.c	2003-07-21 20:28:39.000000000 +0000
+++ linux-mips-2.4.21-20030711/arch/mips/kernel/time.c	2003-07-24 08:22:52.000000000 +0000
@@ -62,6 +62,7 @@ static int null_rtc_set_time(unsigned lo
 
 unsigned long (*rtc_get_time)(void) = null_rtc_get_time;
 int (*rtc_set_time)(unsigned long) = null_rtc_set_time;
+int (*rtc_set_mmss)(unsigned long);
 
 
 /*
@@ -364,7 +365,7 @@ void timer_interrupt(int irq, void *dev_
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
 	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
-		if (rtc_set_time(xtime.tv_sec) == 0) {
+		if (rtc_set_mmss(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
 			/* do it again in 60 s */
@@ -473,6 +474,9 @@ void __init time_init(void)
 	if (board_time_init)
 		board_time_init();
 
+	if (!rtc_set_mmss)
+		rtc_set_mmss = rtc_set_time;
+
 	xtime.tv_sec = rtc_get_time();
 	xtime.tv_usec = 0;
 
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/arch/mips64/kernel/time.c linux-mips-2.4.21-20030711/arch/mips64/kernel/time.c
--- linux-mips-2.4.21-20030711.macro/arch/mips64/kernel/time.c	2003-07-21 20:28:39.000000000 +0000
+++ linux-mips-2.4.21-20030711/arch/mips64/kernel/time.c	2003-07-24 08:22:52.000000000 +0000
@@ -62,6 +62,7 @@ static int null_rtc_set_time(unsigned lo
 
 unsigned long (*rtc_get_time)(void) = null_rtc_get_time;
 int (*rtc_set_time)(unsigned long) = null_rtc_set_time;
+int (*rtc_set_mmss)(unsigned long);
 
 
 /*
@@ -364,7 +365,7 @@ void timer_interrupt(int irq, void *dev_
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
 	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
-		if (rtc_set_time(xtime.tv_sec) == 0) {
+		if (rtc_set_mmss(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
 			/* do it again in 60 s */
@@ -473,6 +474,9 @@ void __init time_init(void)
 	if (board_time_init)
 		board_time_init();
 
+	if (!rtc_set_mmss)
+		rtc_set_mmss = rtc_set_time;
+
 	xtime.tv_sec = rtc_get_time();
 	xtime.tv_usec = 0;
 
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/include/asm-mips/time.h linux-mips-2.4.21-20030711/include/asm-mips/time.h
--- linux-mips-2.4.21-20030711.macro/include/asm-mips/time.h	2003-07-21 21:02:58.000000000 +0000
+++ linux-mips-2.4.21-20030711/include/asm-mips/time.h	2003-07-24 08:24:08.000000000 +0000
@@ -28,9 +28,12 @@
  * RTC ops.  By default, they point to no-RTC functions.
  *	rtc_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
  *	rtc_set_time - reverse the above translation and set time to RTC.
+ *	rtc_set_mmss - similar to rtc_set_time, but only min and sec need
+ *			to be set.  Used by RTC sync-up.
  */
 extern unsigned long (*rtc_get_time)(void);
 extern int (*rtc_set_time)(unsigned long);
+extern int (*rtc_set_mmss)(unsigned long);
 
 /*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
diff -up --recursive --new-file linux-mips-2.4.21-20030711.macro/include/asm-mips64/time.h linux-mips-2.4.21-20030711/include/asm-mips64/time.h
--- linux-mips-2.4.21-20030711.macro/include/asm-mips64/time.h	2003-07-21 21:02:58.000000000 +0000
+++ linux-mips-2.4.21-20030711/include/asm-mips64/time.h	2003-07-24 08:24:08.000000000 +0000
@@ -28,9 +28,12 @@
  * RTC ops.  By default, they point to no-RTC functions.
  *	rtc_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
  *	rtc_set_time - reverse the above translation and set time to RTC.
+ *	rtc_set_mmss - similar to rtc_set_time, but only min and sec need
+ *			to be set.  Used by RTC sync-up.
  */
 extern unsigned long (*rtc_get_time)(void);
 extern int (*rtc_set_time)(unsigned long);
+extern int (*rtc_set_mmss)(unsigned long);
 
 /*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
