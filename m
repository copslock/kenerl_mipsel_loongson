Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2005 16:02:03 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23267 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133805AbVKBQBi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Nov 2005 16:01:38 +0000
Received: from localhost (p4242-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4076FAAA6; Thu,  3 Nov 2005 01:02:16 +0900 (JST)
Date:	Thu, 03 Nov 2005 01:01:15 +0900 (JST)
Message-Id: <20051103.010115.07642880.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use rtc_lock to protect RTC operations
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 9403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Many RTC routines are not protected each other.  There are potential
race, for example, ntp-update and /dev/rtc.  This patch fixes them
using rtc_lock.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/ddb5xxx/common/rtc_ds1386.c b/arch/mips/ddb5xxx/common/rtc_ds1386.c
--- a/arch/mips/ddb5xxx/common/rtc_ds1386.c
+++ b/arch/mips/ddb5xxx/common/rtc_ds1386.c
@@ -41,7 +41,9 @@ rtc_ds1386_get_time(void)
 	u8 byte;
 	u8 temp;
 	unsigned int year, month, day, hour, minute, second;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* let us freeze external registers */
 	byte = READ_RTC(0xB);
 	byte &= 0x3f;
@@ -60,6 +62,7 @@ rtc_ds1386_get_time(void)
 	/* enable time transfer */
 	byte |= 0x80;
 	WRITE_RTC(0xB, byte);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	/* calc hour */
 	if (temp & 0x40) {
@@ -81,7 +84,9 @@ rtc_ds1386_set_time(unsigned long t)
 	u8 byte;
 	u8 temp;
 	u8 year, month, day, hour, minute, second;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* let us freeze external registers */
 	byte = READ_RTC(0xB);
 	byte &= 0x3f;
@@ -133,6 +138,7 @@ rtc_ds1386_set_time(unsigned long t)
 	if (second != READ_RTC(0x1)) {
 		WRITE_RTC(0x1, second);
 	}
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
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
@@ -49,11 +64,12 @@ static unsigned long dec_rtc_get_time(vo
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
@@ -77,6 +93,7 @@ static unsigned long dec_rtc_get_time(vo
 	 * of unused BBU RAM locations.
 	 */
 	real_year = CMOS_READ(RTC_DEC_YEAR);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	year += real_year - 72 + 2000;
 
 	return mktime(year, mon, day, hour, min, sec);
@@ -95,6 +112,8 @@ static int dec_rtc_set_mmss(unsigned lon
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char save_control, save_freq_select;
 
+	/* irq are locally disabled here */
+	spin_lock(&rtc_lock);
 	/* tell the clock it's being set */
 	save_control = CMOS_READ(RTC_CONTROL);
 	CMOS_WRITE((save_control | RTC_SET), RTC_CONTROL);
@@ -141,6 +160,7 @@ static int dec_rtc_set_mmss(unsigned lon
 	 */
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+	spin_unlock(&rtc_lock);
 
 	return retval;
 }
diff --git a/arch/mips/jmr3927/common/rtc_ds1742.c b/arch/mips/jmr3927/common/rtc_ds1742.c
--- a/arch/mips/jmr3927/common/rtc_ds1742.c
+++ b/arch/mips/jmr3927/common/rtc_ds1742.c
@@ -57,7 +57,9 @@ rtc_ds1742_get_time(void)
 {
 	unsigned int year, month, day, hour, minute, second;
 	unsigned int century;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	CMOS_WRITE(RTC_READ, RTC_CONTROL);
 	second = BCD2BIN(CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
 	minute = BCD2BIN(CMOS_READ(RTC_MINUTES));
@@ -67,6 +69,7 @@ rtc_ds1742_get_time(void)
 	year = BCD2BIN(CMOS_READ(RTC_YEAR));
 	century = BCD2BIN(CMOS_READ(RTC_CENTURY) & RTC_CENTURY_MASK);
 	CMOS_WRITE(0, RTC_CONTROL);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	year += century * 100;
 
@@ -81,7 +84,9 @@ rtc_ds1742_set_time(unsigned long t)
 	u8 year, month, day, hour, minute, second;
 	u8 cmos_year, cmos_month, cmos_day, cmos_hour, cmos_minute, cmos_second;
 	int cmos_century;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	CMOS_WRITE(RTC_READ, RTC_CONTROL);
 	cmos_second = (u8)(CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
 	cmos_minute = (u8)CMOS_READ(RTC_MINUTES);
@@ -139,6 +144,7 @@ rtc_ds1742_set_time(unsigned long t)
 
 	/* RTC_CENTURY and RTC_CONTROL share same address... */
 	CMOS_WRITE(cmos_century, RTC_CONTROL);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -8,6 +8,7 @@
 #include <asm/lasat/lasat.h>
 #include <linux/delay.h>
 #include <asm/lasat/ds1603.h>
+#include <asm/time.h>
 
 #include "ds1603.h"
 
@@ -138,19 +139,27 @@ static void rtc_end_op(void)
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
diff --git a/arch/mips/momentum/jaguar_atx/setup.c b/arch/mips/momentum/jaguar_atx/setup.c
--- a/arch/mips/momentum/jaguar_atx/setup.c
+++ b/arch/mips/momentum/jaguar_atx/setup.c
@@ -149,7 +149,9 @@ arch_initcall(per_cpu_mappings);
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
@@ -166,6 +168,7 @@ unsigned long m48t37y_get_time(void)
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -173,11 +176,13 @@ unsigned long m48t37y_get_time(void)
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
 
@@ -201,6 +206,7 @@ int m48t37y_set_time(unsigned long sec)
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/momentum/ocelot_3/setup.c b/arch/mips/momentum/ocelot_3/setup.c
--- a/arch/mips/momentum/ocelot_3/setup.c
+++ b/arch/mips/momentum/ocelot_3/setup.c
@@ -135,7 +135,9 @@ void setup_wired_tlb_entries(void)
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
@@ -152,6 +154,7 @@ unsigned long m48t37y_get_time(void)
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -159,11 +162,13 @@ unsigned long m48t37y_get_time(void)
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
 
@@ -187,6 +192,7 @@ int m48t37y_set_time(unsigned long sec)
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/momentum/ocelot_c/setup.c b/arch/mips/momentum/ocelot_c/setup.c
--- a/arch/mips/momentum/ocelot_c/setup.c
+++ b/arch/mips/momentum/ocelot_c/setup.c
@@ -140,7 +140,9 @@ unsigned long m48t37y_get_time(void)
 	unsigned char* rtc_base = (unsigned char*)0xfc800000;
 #endif
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* stop the update */
 	rtc_base[0x7ff8] = 0x40;
 
@@ -157,6 +159,7 @@ unsigned long m48t37y_get_time(void)
 
 	/* start the update */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -169,11 +172,13 @@ int m48t37y_set_time(unsigned long sec)
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
 
@@ -197,6 +202,7 @@ int m48t37y_set_time(unsigned long sec)
 
 	/* disable writing */
 	rtc_base[0x7ff8] = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -73,7 +73,9 @@ void __init bus_error_init(void)
 unsigned long m48t37y_get_time(void)
 {
 	unsigned int year, month, day, hour, min, sec;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* Stop the update to the time */
 	m48t37_base->control = 0x40;
 
@@ -88,6 +90,7 @@ unsigned long m48t37y_get_time(void)
 
 	/* Start the update to the time again */
 	m48t37_base->control = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return mktime(year, month, day, hour, min, sec);
 }
@@ -95,11 +98,13 @@ unsigned long m48t37y_get_time(void)
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
 
@@ -123,6 +128,7 @@ int m48t37y_set_time(unsigned long sec)
 
 	/* disable writing */
 	m48t37_base->control = 0x00;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -35,7 +35,9 @@ static unsigned long indy_rtc_get_time(v
 {
 	unsigned int yrs, mon, day, hrs, min, sec;
 	unsigned int save_control;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
 	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
 
@@ -47,6 +49,7 @@ static unsigned long indy_rtc_get_time(v
 	yrs = BCD2BIN(hpc3c0->rtcregs[RTC_YEAR] & 0xff);
 
 	hpc3c0->rtcregs[RTC_CMD] = save_control;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	if (yrs < 45)
 		yrs += 30;
@@ -60,6 +63,7 @@ static int indy_rtc_set_time(unsigned lo
 {
 	struct rtc_time tm;
 	unsigned int save_control;
+	unsigned long flags;
 
 	to_tm(tim, &tm);
 
@@ -68,6 +72,7 @@ static int indy_rtc_set_time(unsigned lo
 	if (tm.tm_year >= 100)
 		tm.tm_year -= 100;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
 	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
 
@@ -80,6 +85,7 @@ static int indy_rtc_set_time(unsigned lo
 	hpc3c0->rtcregs[RTC_HUNDREDTH_SECOND] = 0;
 
 	hpc3c0->rtcregs[RTC_CMD] = save_control;
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
diff --git a/arch/mips/sibyte/swarm/rtc_m41t81.c b/arch/mips/sibyte/swarm/rtc_m41t81.c
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ b/arch/mips/sibyte/swarm/rtc_m41t81.c
@@ -144,6 +144,7 @@ static int m41t81_write(uint8_t addr, in
 int m41t81_set_time(unsigned long t)
 {
 	struct rtc_time tm;
+	unsigned long flags;
 
 	to_tm(t, &tm);
 
@@ -153,6 +154,7 @@ int m41t81_set_time(unsigned long t)
 	 * believe we should finish writing min within a second.
 	 */
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	tm.tm_sec = BIN2BCD(tm.tm_sec);
 	m41t81_write(M41T81REG_SC, tm.tm_sec);
 
@@ -180,6 +182,7 @@ int m41t81_set_time(unsigned long t)
 	tm.tm_year %= 100;
 	tm.tm_year = BIN2BCD(tm.tm_year);
 	m41t81_write(M41T81REG_YR, tm.tm_year);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
@@ -187,19 +190,23 @@ int m41t81_set_time(unsigned long t)
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
 	mon = m41t81_read(M41T81REG_MO);
 	year = m41t81_read(M41T81REG_YR);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	sec = BCD2BIN(sec);
 	min = BCD2BIN(min);
diff --git a/arch/mips/sibyte/swarm/rtc_xicor1241.c b/arch/mips/sibyte/swarm/rtc_xicor1241.c
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ b/arch/mips/sibyte/swarm/rtc_xicor1241.c
@@ -113,9 +113,11 @@ int xicor_set_time(unsigned long t)
 {
 	struct rtc_time tm;
 	int tmp;
+	unsigned long flags;
 
 	to_tm(t, &tm);
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	/* unlock writes to the CCR */
 	xicor_write(X1241REG_SR, X1241REG_SR_WEL);
 	xicor_write(X1241REG_SR, X1241REG_SR_WEL | X1241REG_SR_RWEL);
@@ -160,6 +162,7 @@ int xicor_set_time(unsigned long t)
 	xicor_write(X1241REG_HR, tmp);
 
 	xicor_write(X1241REG_SR, 0);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return 0;
 }
@@ -167,7 +170,9 @@ int xicor_set_time(unsigned long t)
 unsigned long xicor_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec, y2k;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	sec = xicor_read(X1241REG_SC);
 	min = xicor_read(X1241REG_MN);
 	hour = xicor_read(X1241REG_HR);
@@ -183,6 +188,7 @@ unsigned long xicor_get_time(void)
 	mon = xicor_read(X1241REG_MO);
 	year = xicor_read(X1241REG_YR);
 	y2k = xicor_read(X1241REG_Y2K);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	sec = BCD2BIN(sec);
 	min = BCD2BIN(min);
diff --git a/include/asm-mips/mc146818-time.h b/include/asm-mips/mc146818-time.h
--- a/include/asm-mips/mc146818-time.h
+++ b/include/asm-mips/mc146818-time.h
@@ -33,7 +33,9 @@ static inline int mc146818_set_rtc_mmss(
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char save_control, save_freq_select;
 	int retval = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
 	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
 
@@ -79,14 +81,30 @@ static inline int mc146818_set_rtc_mmss(
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
@@ -97,12 +115,13 @@ static inline unsigned long mc146818_get
 
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
@@ -120,6 +139,7 @@ static inline unsigned long mc146818_get
 		BCD_TO_BIN(mon);
 		BCD_TO_BIN(year);
 	}
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	year = mc146818_decode_year(year);
 
 	return mktime(year, mon, day, hour, min, sec);
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -20,6 +20,9 @@
 #include <linux/linkage.h>
 #include <linux/ptrace.h>
 #include <linux/rtc.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t rtc_lock;
 
 /*
  * RTC ops.  By default, they point to no-RTC functions.
