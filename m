Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2005 16:47:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:19925 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225407AbVIFPrX>; Tue, 6 Sep 2005 16:47:23 +0100
Received: from localhost (p4135-ipad30funabasi.chiba.ocn.ne.jp [221.184.79.135])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E53A285B0; Wed,  7 Sep 2005 00:54:08 +0900 (JST)
Date:	Wed, 07 Sep 2005 00:55:17 +0900 (JST)
Message-Id: <20050907.005517.25909840.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	spodstavin@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: a patch for generic MIPS RTC
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61L.0509051620020.29615@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61L.0509051204140.29615@blysk.ds.pg.gda.pl>
	<20050905.224534.25910293.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.61L.0509051620020.29615@blysk.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 5 Sep 2005 16:25:32 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> said:

macro>  I'm not sure all chips actually require it.  Certainly the
macro> null function does not, so that spinlock would incur an
macro> unnecessary overhead.  Therefore yes, it should be board- or
macro> chip-dependent.

OK, and I also found some rtc routines might take a few SECONDS,
therefore protecting whole these rtc routines entirely with spinlock
is really bad idea.

How about this (untested) one?

* Get rid of inconsistent declarations from include/asm-mips/rtc.h
* Get rid of mips_rtc_lock.
* Use rtc_lock (and disable irq) to protect HW access in each rtc routines.

diff -ur linux-mips/arch/mips/ddb5xxx/common/rtc_ds1386.c linux/arch/mips/ddb5xxx/common/rtc_ds1386.c
--- linux-mips/arch/mips/ddb5xxx/common/rtc_ds1386.c	2004-08-14 19:56:00.000000000 +0900
+++ linux/arch/mips/ddb5xxx/common/rtc_ds1386.c	2005-09-06 19:57:17.000000000 +0900
@@ -41,7 +41,9 @@
 	u8 byte;
 	u8 temp;
 	unsigned int year, month, day, hour, minute, second;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* let us freeze external registers */
 	byte = READ_RTC(0xB);
 	byte &= 0x3f;
@@ -70,6 +72,7 @@
 		/* 24 hour format */
 		hour = BCD2BIN(temp & 0x3f);
 	}
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, minute, second);
 }
@@ -81,7 +84,9 @@
 	u8 byte;
 	u8 temp;
 	u8 year, month, day, hour, minute, second;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* let us freeze external registers */
 	byte = READ_RTC(0xB);
 	byte &= 0x3f;
@@ -133,6 +138,7 @@
 	if (second != READ_RTC(0x1)) {
 		WRITE_RTC(0x1, second);
 	}
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/dec/time.c linux/arch/mips/dec/time.c
--- linux-mips/arch/mips/dec/time.c	2004-08-14 19:55:59.000000000 +0900
+++ linux/arch/mips/dec/time.c	2005-09-06 19:57:26.000000000 +0900
@@ -37,10 +37,25 @@
 #include <asm/dec/machtype.h>
 
 
+/*
+ * Returns true if a clock update is in progress
+ */
+static inline unsigned char dec_rtc_is_updating(void)
+{
+	unsigned char uip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return uip;
+}
+
 static unsigned long dec_rtc_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec, real_year;
 	int i;
+	unsigned long flags;
 
 	/* The Linux interpretation of the DS1287 clock register contents:
 	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
@@ -49,11 +64,12 @@
 	 */
 	/* read RTC exactly on falling edge of update flag */
 	for (i = 0; i < 1000000; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+		if (dec_rtc_is_updating())
 			break;
 	for (i = 0; i < 1000000; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+		if (!dec_rtc_is_updating())
 			break;
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* Isn't this overkill?  UIP above should guarantee consistency */
 	do {
 		sec = CMOS_READ(RTC_SECONDS);
@@ -78,6 +94,7 @@
 	 */
 	real_year = CMOS_READ(RTC_DEC_YEAR);
 	year += real_year - 72 + 2000;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, mon, day, hour, min, sec);
 }
@@ -95,6 +112,8 @@
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char save_control, save_freq_select;
 
+	/* irq are locally disabled here */
+	spin_lock(&rtc_lock);
 	/* tell the clock it's being set */
 	save_control = CMOS_READ(RTC_CONTROL);
 	CMOS_WRITE((save_control | RTC_SET), RTC_CONTROL);
@@ -141,6 +160,7 @@
 	 */
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+	spin_unlock(&rtc_lock);
 
 	return retval;
 }
diff -ur linux-mips/arch/mips/ite-boards/generic/time.c linux/arch/mips/ite-boards/generic/time.c
--- linux-mips/arch/mips/ite-boards/generic/time.c	2005-08-30 11:01:59.000000000 +0900
+++ linux/arch/mips/ite-boards/generic/time.c	2005-09-06 19:57:42.000000000 +0900
@@ -149,15 +149,15 @@
 it8172_rtc_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	unsigned int flags;
+	unsigned long flags;
 
 	/* avoid update-in-progress. */
 	for (;;) {
-		local_irq_save(flags);
+		spin_lock_irqsave(&rtc_lock, flags);
 		if (! (CMOS_READ(RTC_REG_A) & RTC_UIP))
 			break;
 		/* don't hold intr closed all the time */
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 	}
 
 	/* Read regs. */
@@ -170,7 +170,7 @@
 		hw_to_bin(*rtc_century_reg) * 100;
 
 	/* restore interrupts */
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, mon, day, hour, min, sec);
 }
@@ -179,18 +179,18 @@
 it8172_rtc_set_time(unsigned long t)
 {
 	struct rtc_time tm;
-	unsigned int flags;
+	unsigned long flags;
 
 	/* convert */
 	to_tm(t, &tm);
 
 	/* avoid update-in-progress. */
 	for (;;) {
-		local_irq_save(flags);
+		spin_lock_irqsave(&rtc_lock, flags);
 		if (! (CMOS_READ(RTC_REG_A) & RTC_UIP))
 			break;
 		/* don't hold intr closed all the time */
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 	}
 
 	*rtc_century_reg = bin_to_hw(tm.tm_year/100);
@@ -202,7 +202,7 @@
 	CMOS_WRITE(bin_to_hw(tm.tm_year%100), RTC_YEAR);
 
 	/* restore interrupts */
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/jmr3927/common/rtc_ds1742.c linux/arch/mips/jmr3927/common/rtc_ds1742.c
--- linux-mips/arch/mips/jmr3927/common/rtc_ds1742.c	2004-08-14 19:55:33.000000000 +0900
+++ linux/arch/mips/jmr3927/common/rtc_ds1742.c	2005-09-06 19:58:03.000000000 +0900
@@ -57,7 +57,9 @@
 {
 	unsigned int year, month, day, hour, minute, second;
 	unsigned int century;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	CMOS_WRITE(RTC_READ, RTC_CONTROL);
 	second = BCD2BIN(CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
 	minute = BCD2BIN(CMOS_READ(RTC_MINUTES));
@@ -67,6 +69,7 @@
 	year = BCD2BIN(CMOS_READ(RTC_YEAR));
 	century = BCD2BIN(CMOS_READ(RTC_CENTURY) & RTC_CENTURY_MASK);
 	CMOS_WRITE(0, RTC_CONTROL);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	year += century * 100;
 
@@ -81,7 +84,9 @@
 	u8 year, month, day, hour, minute, second;
 	u8 cmos_year, cmos_month, cmos_day, cmos_hour, cmos_minute, cmos_second;
 	int cmos_century;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	CMOS_WRITE(RTC_READ, RTC_CONTROL);
 	cmos_second = (u8)(CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
 	cmos_minute = (u8)CMOS_READ(RTC_MINUTES);
@@ -139,6 +144,7 @@
 
 	/* RTC_CENTURY and RTC_CONTROL share same address... */
 	CMOS_WRITE(cmos_century, RTC_CONTROL);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/lasat/ds1603.c linux/arch/mips/lasat/ds1603.c
--- linux-mips/arch/mips/lasat/ds1603.c	2005-08-30 11:02:01.000000000 +0900
+++ linux/arch/mips/lasat/ds1603.c	2005-09-06 19:58:25.000000000 +0900
@@ -8,6 +8,7 @@
 #include <asm/lasat/lasat.h>
 #include <linux/delay.h>
 #include <asm/lasat/ds1603.h>
+#include <asm/time.h>
 
 #include "ds1603.h"
 
@@ -138,19 +139,27 @@
 unsigned long ds1603_read(void)
 {
 	unsigned long word;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
 	rtc_init_op();
 	rtc_write_byte(READ_TIME_CMD);
 	word = rtc_read_word();
 	rtc_end_op();
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	return word;
 }
 
 int ds1603_set(unsigned long time)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
 	rtc_init_op();
 	rtc_write_byte(SET_TIME_CMD);
 	rtc_write_word(time);
 	rtc_end_op();
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/momentum/jaguar_atx/setup.c linux/arch/mips/momentum/jaguar_atx/setup.c
--- linux-mips/arch/mips/momentum/jaguar_atx/setup.c	2005-08-30 11:02:03.000000000 +0900
+++ linux/arch/mips/momentum/jaguar_atx/setup.c	2005-09-06 19:58:40.000000000 +0900
@@ -149,7 +149,9 @@
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
@@ -166,6 +168,7 @@
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -173,11 +176,13 @@
 int m48t37y_set_time(unsigned long sec)
 {
 	struct rtc_time tm;
+	unsigned long flags;
 
 	/* convert to a more useful format -- note months count from 0 */
 	to_tm(sec, &tm);
 	tm.tm_mon += 1;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* enable writing */
 	rtc_base[0x7ff8] = 0x80;
 
@@ -201,6 +206,7 @@
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/momentum/ocelot_3/setup.c linux/arch/mips/momentum/ocelot_3/setup.c
--- linux-mips/arch/mips/momentum/ocelot_3/setup.c	2005-08-30 11:02:03.000000000 +0900
+++ linux/arch/mips/momentum/ocelot_3/setup.c	2005-09-06 19:58:52.000000000 +0900
@@ -135,7 +135,9 @@
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
@@ -152,6 +154,7 @@
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -159,11 +162,13 @@
 int m48t37y_set_time(unsigned long sec)
 {
 	struct rtc_time tm;
+	unsigned long flags;
 
 	/* convert to a more useful format -- note months count from 0 */
 	to_tm(sec, &tm);
 	tm.tm_mon += 1;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* enable writing */
 	rtc_base[0x7ff8] = 0x80;
 
@@ -187,6 +192,7 @@
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/momentum/ocelot_c/setup.c linux/arch/mips/momentum/ocelot_c/setup.c
--- linux-mips/arch/mips/momentum/ocelot_c/setup.c	2005-08-30 11:02:03.000000000 +0900
+++ linux/arch/mips/momentum/ocelot_c/setup.c	2005-09-06 19:58:59.000000000 +0900
@@ -140,7 +140,9 @@
 	unsigned char* rtc_base = (unsigned char*)0xfc800000;
 #endif
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
@@ -157,6 +159,7 @@
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -169,11 +172,13 @@
 	unsigned char* rtc_base = (unsigned char*)0xfc800000;
 #endif
 	struct rtc_time tm;
+	unsigned long flags;
 
 	/* convert to a more useful format -- note months count from 0 */
 	to_tm(sec, &tm);
 	tm.tm_mon += 1;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* enable writing */
 	rtc_base[0x7ff8] = 0x80;
 
@@ -197,6 +202,7 @@
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/pmc-sierra/yosemite/setup.c linux/arch/mips/pmc-sierra/yosemite/setup.c
--- linux-mips/arch/mips/pmc-sierra/yosemite/setup.c	2005-06-24 10:01:20.000000000 +0900
+++ linux/arch/mips/pmc-sierra/yosemite/setup.c	2005-09-06 19:59:19.000000000 +0900
@@ -73,7 +73,9 @@
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* Stop the update to the time */
 	m48t37_base->control = 0x40;
 
@@ -88,6 +90,7 @@
 
 	/* Start the update to the time again */
 	m48t37_base->control = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -95,11 +98,13 @@
 int m48t37y_set_time(unsigned long sec)
 {
 	struct rtc_time tm;
+	unsigned long flags;
 
 	/* convert to a more useful format -- note months count from 0 */
 	to_tm(sec, &tm);
 	tm.tm_mon += 1;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* enable writing */
 	m48t37_base->control = 0x80;
 
@@ -123,6 +128,7 @@
 
 	/* disable writing */
 	m48t37_base->control = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/sgi-ip22/ip22-time.c linux/arch/mips/sgi-ip22/ip22-time.c
--- linux-mips/arch/mips/sgi-ip22/ip22-time.c	2005-08-30 11:02:04.000000000 +0900
+++ linux/arch/mips/sgi-ip22/ip22-time.c	2005-09-06 19:59:43.000000000 +0900
@@ -35,7 +35,9 @@
 {
 	unsigned int yrs, mon, day, hrs, min, sec;
 	unsigned int save_control;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
 	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
 
@@ -47,6 +49,7 @@
 	yrs = BCD2BIN(hpc3c0->rtcregs[RTC_YEAR] & 0xff);
 
 	hpc3c0->rtcregs[RTC_CMD] = save_control;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	if (yrs < 45)
 		yrs += 30;
@@ -60,6 +63,7 @@
 {
 	struct rtc_time tm;
 	unsigned int save_control;
+	unsigned long flags;
 
 	to_tm(tim, &tm);
 
@@ -68,6 +72,7 @@
 	if (tm.tm_year >= 100)
 		tm.tm_year -= 100;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
 	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
 
@@ -80,6 +85,7 @@
 	hpc3c0->rtcregs[RTC_HUNDREDTH_SECOND] = 0;
 
 	hpc3c0->rtcregs[RTC_CMD] = save_control;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff -ur linux-mips/arch/mips/sibyte/swarm/rtc_m41t81.c linux/arch/mips/sibyte/swarm/rtc_m41t81.c
--- linux-mips/arch/mips/sibyte/swarm/rtc_m41t81.c	2005-08-30 11:02:04.000000000 +0900
+++ linux/arch/mips/sibyte/swarm/rtc_m41t81.c	2005-09-06 20:00:03.000000000 +0900
@@ -144,6 +144,7 @@
 int m41t81_set_time(unsigned long t)
 {
 	struct rtc_time tm;
+	unsigned long flags;
 
 	to_tm(t, &tm);
 
@@ -153,6 +154,7 @@
 	 * believe we should finish writing min within a second.
 	 */
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	tm.tm_sec = BIN2BCD(tm.tm_sec);
 	m41t81_write(M41T81REG_SC, tm.tm_sec);
 
@@ -180,6 +182,7 @@
 	tm.tm_year %= 100;
 	tm.tm_year = BIN2BCD(tm.tm_year);
 	m41t81_write(M41T81REG_YR, tm.tm_year);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
@@ -187,14 +190,17 @@
 unsigned long m41t81_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
+	unsigned long flags;
 
 	/*
 	 * min is valid if two reads of sec are the same.
 	 */
 	for (;;) {
+		spin_lock_irqsave(&rtc_lock, flags);
 		sec = m41t81_read(M41T81REG_SC);
 		min = m41t81_read(M41T81REG_MN);
 		if (sec == m41t81_read(M41T81REG_SC)) break;
+		spin_unlock_irqrestore(&rtc_lock, flags);
 	}
 	hour = m41t81_read(M41T81REG_HR) & 0x3f;
 	day = m41t81_read(M41T81REG_DT);
@@ -207,6 +213,7 @@
 	day = BCD2BIN(day);
 	mon = BCD2BIN(mon);
 	year = BCD2BIN(year);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	year += 2000;
 
diff -ur linux-mips/arch/mips/sibyte/swarm/rtc_xicor1241.c linux/arch/mips/sibyte/swarm/rtc_xicor1241.c
--- linux-mips/arch/mips/sibyte/swarm/rtc_xicor1241.c	2005-03-04 10:19:33.000000000 +0900
+++ linux/arch/mips/sibyte/swarm/rtc_xicor1241.c	2005-09-06 20:00:28.000000000 +0900
@@ -113,9 +113,11 @@
 {
 	struct rtc_time tm;
 	int tmp;
+	unsigned long flags;
 
 	to_tm(t, &tm);
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* unlock writes to the CCR */
 	xicor_write(X1241REG_SR, X1241REG_SR_WEL);
 	xicor_write(X1241REG_SR, X1241REG_SR_WEL | X1241REG_SR_RWEL);
@@ -160,6 +162,7 @@
 	xicor_write(X1241REG_HR, tmp);
 
 	xicor_write(X1241REG_SR, 0);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
@@ -167,7 +170,9 @@
 unsigned long xicor_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec, y2k;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	sec = xicor_read(X1241REG_SC);
 	min = xicor_read(X1241REG_MN);
 	hour = xicor_read(X1241REG_HR);
@@ -183,6 +188,7 @@
 	mon = xicor_read(X1241REG_MO);
 	year = xicor_read(X1241REG_YR);
 	y2k = xicor_read(X1241REG_Y2K);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	sec = BCD2BIN(sec);
 	min = BCD2BIN(min);
diff -ur linux-mips/arch/mips/tx4938/common/rtc_rx5c348.c linux/arch/mips/tx4938/common/rtc_rx5c348.c
--- linux-mips/arch/mips/tx4938/common/rtc_rx5c348.c	2005-08-30 11:02:04.000000000 +0900
+++ linux/arch/mips/tx4938/common/rtc_rx5c348.c	2005-09-06 19:56:27.000000000 +0900
@@ -67,14 +67,20 @@
 {
 	unsigned char *inbufs[1], *outbufs[1];
 	unsigned int incounts[2], outcounts[2];
+	int ret;
+	unsigned long flags;
+
 	inbufs[0] = inbuf;
 	incounts[0] = count;
 	incounts[1] = 0;
 	outbufs[0] = outbuf;
 	outcounts[0] = count;
 	outcounts[1] = 0;
-	return txx9_spi_io(srtc_chipid, &srtc_dev_desc,
-			   inbufs, incounts, outbufs, outcounts, 0);
+	spin_lock_irqsave(&rtc_lock, flags);
+	ret = txx9_spi_io(srtc_chipid, &srtc_dev_desc,
+			  inbufs, incounts, outbufs, outcounts, 0);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return ret;
 }
 
 /*
diff -ur linux-mips/include/asm-mips/mc146818-time.h linux/include/asm-mips/mc146818-time.h
--- linux-mips/include/asm-mips/mc146818-time.h	2004-08-14 19:55:59.000000000 +0900
+++ linux/include/asm-mips/mc146818-time.h	2005-09-06 18:38:47.000000000 +0900
@@ -33,7 +33,9 @@
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char save_control, save_freq_select;
 	int retval = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
 	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
 
@@ -79,14 +81,30 @@
 	 */
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return retval;
 }
 
+/*
+ * Returns true if a clock update is in progress
+ */
+static inline unsigned char rtc_is_updating(void)
+{
+	unsigned char uip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return uip;
+}
+
 static inline unsigned long mc146818_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	int i;
+	unsigned long flags;
 
 	/*
 	 * The Linux interpretation of the CMOS clock register contents:
@@ -97,12 +115,13 @@
 
 	/* read RTC exactly on falling edge of update flag */
 	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+		if (rtc_is_updating())
 			break;
 	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+		if (!rtc_is_updating())
 			break;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	do { /* Isn't this overkill ? UIP above should guarantee consistency */
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
@@ -121,6 +140,7 @@
 		BCD_TO_BIN(year);
 	}
 	year = mc146818_decode_year(year);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, mon, day, hour, min, sec);
 }
diff -ur linux-mips/include/asm-mips/rtc.h linux/include/asm-mips/rtc.h
--- linux-mips/include/asm-mips/rtc.h	2005-09-05 10:17:18.000000000 +0900
+++ linux/include/asm-mips/rtc.h	2005-09-06 16:17:02.000000000 +0900
@@ -14,7 +14,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/spinlock.h>
 #include <linux/rtc.h>
 #include <asm/time.h>
 
@@ -29,23 +28,13 @@
 #define RTC_24H 0x02            /* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01         /* auto switch DST - works f. USA only */
 
-unsigned int get_rtc_time(struct rtc_time *time);
-int set_rtc_time(struct rtc_time *time);
-unsigned int get_rtc_ss(void);
-int get_rtc_pll(struct rtc_pll_info *pll);
-int set_rtc_pll(struct rtc_pll_info *pll);
-
-static DEFINE_SPINLOCK(mips_rtc_lock);
-
 static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	unsigned long nowtime;
 
-	spin_lock(&mips_rtc_lock);
 	nowtime = rtc_get_time();
 	to_tm(nowtime, time);
 	time->tm_year -= 1900;
-	spin_unlock(&mips_rtc_lock);
 
 	return RTC_24H;
 }
@@ -55,12 +44,10 @@
 	unsigned long nowtime;
 	int ret;
 
-	spin_lock(&mips_rtc_lock);
 	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
 			time->tm_mday, time->tm_hour, time->tm_min,
 			time->tm_sec);
 	ret = rtc_set_time(nowtime);
-	spin_unlock(&mips_rtc_lock);
 
 	return ret;
 }
diff -ur linux-mips/include/asm-mips/time.h linux/include/asm-mips/time.h
--- linux-mips/include/asm-mips/time.h	2004-08-14 19:54:51.000000000 +0900
+++ linux/include/asm-mips/time.h	2005-09-06 19:38:52.000000000 +0900
@@ -20,6 +20,9 @@
 #include <linux/linkage.h>
 #include <linux/ptrace.h>
 #include <linux/rtc.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t rtc_lock;
 
 /*
  * RTC ops.  By default, they point to no-RTC functions.
