Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Nov 2006 15:08:03 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:47063 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038846AbWKKPH6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Nov 2006 15:07:58 +0000
Received: from localhost (p7022-ipad11funabasi.chiba.ocn.ne.jp [219.162.42.22])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9F3DFB80A; Sun, 12 Nov 2006 00:07:52 +0900 (JST)
Date:	Sun, 12 Nov 2006 00:10:28 +0900 (JST)
Message-Id: <20061112.001028.41198601.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] mips hpt cleanup: make clocksource_mips public
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
X-archive-position: 13176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Note: This patch can be applied after the patch titled:
"[PATCH] mips hpt cleanup: get rid of mips_hpt_init"
in lmo linux-queue tree (or 2.6.19-rc5-mm1).


Make clocksource_mips public and get rid of mips_hpt_read,
mips_hpt_mask.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/dec/time.c                |    4 +--
 arch/mips/jmr3927/rbhma3100/setup.c |    4 +--
 arch/mips/kernel/time.c             |   42 +++++++++++++-----------------------
 arch/mips/sgi-ip27/ip27-timer.c     |    4 +--
 arch/mips/sibyte/bcm1480/time.c     |    4 +--
 arch/mips/sibyte/sb1250/time.c      |    8 +++---
 include/asm-mips/time.h             |    8 +++---
 7 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 69e424e..8b7e0c1 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -151,7 +151,7 @@ static void dec_timer_ack(void)
 	CMOS_READ(RTC_REG_C);			/* Ack the RTC interrupt.  */
 }
 
-static unsigned int dec_ioasic_hpt_read(void)
+static cycle_t dec_ioasic_hpt_read(void)
 {
 	/*
 	 * The free-running counter is 32-bit which is good for about
@@ -171,7 +171,7 @@ void __init dec_time_init(void)
 
 	if (!cpu_has_counter && IOASIC)
 		/* For pre-R4k systems we use the I/O ASIC's counter.  */
-		mips_hpt_read = dec_ioasic_hpt_read;
+		clocksource_mips.read = dec_ioasic_hpt_read;
 
 	/* Set up the rate of periodic DS1287 interrupts.  */
 	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - __ffs(HZ)), RTC_REG_A);
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 16e5dfe..138f25e 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -170,7 +170,7 @@ static void jmr3927_machine_power_off(vo
 	while (1);
 }
 
-static unsigned int jmr3927_hpt_read(void)
+static cycle_t jmr3927_hpt_read(void)
 {
 	/* We assume this function is called xtime_lock held. */
 	return jiffies * (JMR3927_TIMER_CLK / HZ) + jmr3927_tmrptr->trr;
@@ -182,7 +182,7 @@ extern void rtc_ds1742_init(unsigned lon
 #endif
 static void __init jmr3927_time_init(void)
 {
-	mips_hpt_read = jmr3927_hpt_read;
+	clocksource_mips.read = jmr3927_hpt_read;
 	mips_hpt_frequency = JMR3927_TIMER_CLK;
 #ifdef USE_RTC_DS1742
 	if (jmr3927_have_nvram()) {
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 111d1ba..11aab6d 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -11,7 +11,6 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/clocksource.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -83,7 +82,7 @@ static void null_timer_ack(void) { /* no
 /*
  * Null high precision timer functions for systems lacking one.
  */
-static unsigned int null_hpt_read(void)
+static cycle_t null_hpt_read(void)
 {
 	return 0;
 }
@@ -112,7 +111,7 @@ #endif
 /*
  * High precision timer functions for a R4k-compatible timer.
  */
-static unsigned int c0_hpt_read(void)
+static cycle_t c0_hpt_read(void)
 {
 	return read_c0_count();
 }
@@ -126,8 +125,6 @@ static void __init c0_hpt_timer_init(voi
 
 int (*mips_timer_state)(void);
 void (*mips_timer_ack)(void);
-unsigned int (*mips_hpt_read)(void);
-unsigned int mips_hpt_mask = 0xffffffff;
 
 /* last time when xtime and rtc are sync'ed up */
 static long last_rtc_update;
@@ -269,8 +266,7 @@ static struct irqaction timer_irqaction 
 
 static unsigned int __init calibrate_hpt(void)
 {
-	u64 frequency;
-	u32 hpt_start, hpt_end, hpt_count, hz;
+	cycle_t frequency, hpt_start, hpt_end, hpt_count, hz;
 
 	const int loops = HZ / 10;
 	int log_2_loops = 0;
@@ -296,28 +292,23 @@ static unsigned int __init calibrate_hpt
 	 * during the calculated number of periods between timer
 	 * interrupts.
 	 */
-	hpt_start = mips_hpt_read();
+	hpt_start = clocksource_mips.read();
 	do {
 		while (mips_timer_state());
 		while (!mips_timer_state());
 	} while (--i);
-	hpt_end = mips_hpt_read();
+	hpt_end = clocksource_mips.read();
 
-	hpt_count = (hpt_end - hpt_start) & mips_hpt_mask;
+	hpt_count = (hpt_end - hpt_start) & clocksource_mips.mask;
 	hz = HZ;
-	frequency = (u64)hpt_count * (u64)hz;
+	frequency = hpt_count * hz;
 
 	return frequency >> log_2_loops;
 }
 
-static cycle_t read_mips_hpt(void)
-{
-	return (cycle_t)mips_hpt_read();
-}
-
-static struct clocksource clocksource_mips = {
+struct clocksource clocksource_mips = {
 	.name		= "MIPS",
-	.read		= read_mips_hpt,
+	.mask		= 0xffffffff,
 	.is_continuous	= 1,
 };
 
@@ -326,7 +317,7 @@ static void __init init_mips_clocksource
 	u64 temp;
 	u32 shift;
 
-	if (!mips_hpt_frequency || mips_hpt_read == null_hpt_read)
+	if (!mips_hpt_frequency || clocksource_mips.read == null_hpt_read)
 		return;
 
 	/* Calclate a somewhat reasonable rating value */
@@ -340,7 +331,6 @@ static void __init init_mips_clocksource
 	}
 	clocksource_mips.shift = shift;
 	clocksource_mips.mult = (u32)temp;
-	clocksource_mips.mask = mips_hpt_mask;
 
 	clocksource_register(&clocksource_mips);
 }
@@ -360,19 +350,19 @@ void __init time_init(void)
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
 	/* Choose appropriate high precision timer routines.  */
-	if (!cpu_has_counter && !mips_hpt_read)
+	if (!cpu_has_counter && !clocksource_mips.read)
 		/* No high precision timer -- sorry.  */
-		mips_hpt_read = null_hpt_read;
+		clocksource_mips.read = null_hpt_read;
 	else if (!mips_hpt_frequency && !mips_timer_state) {
 		/* A high precision timer of unknown frequency.  */
-		if (!mips_hpt_read)
+		if (!clocksource_mips.read)
 			/* No external high precision timer -- use R4k.  */
-			mips_hpt_read = c0_hpt_read;
+			clocksource_mips.read = c0_hpt_read;
 	} else {
 		/* We know counter frequency.  Or we can get it.  */
-		if (!mips_hpt_read) {
+		if (!clocksource_mips.read) {
 			/* No external high precision timer -- use R4k.  */
-			mips_hpt_read = c0_hpt_read;
+			clocksource_mips.read = c0_hpt_read;
 
 			if (!mips_timer_state) {
 				/* No external timer interrupt -- use R4k.  */
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 5e82a26..7106d54 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -239,14 +239,14 @@ void __init plat_timer_setup(struct irqa
 	setup_irq(irqno, &rt_irqaction);
 }
 
-static unsigned int ip27_hpt_read(void)
+static cycle_t ip27_hpt_read(void)
 {
 	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
 }
 
 void __init ip27_time_init(void)
 {
-	mips_hpt_read = ip27_hpt_read;
+	clocksource_mips.read = ip27_hpt_read;
 	mips_hpt_frequency = CYCLES_PER_SEC;
 	xtime.tv_sec = get_m48t35_time();
 	xtime.tv_nsec = 0;
diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
index e136bde..26b5c29 100644
--- a/arch/mips/sibyte/bcm1480/time.c
+++ b/arch/mips/sibyte/bcm1480/time.c
@@ -119,7 +119,7 @@ void bcm1480_timer_interrupt(void)
 	}
 }
 
-static unsigned int bcm1480_hpt_read(void)
+static cycle_t bcm1480_hpt_read(void)
 {
 	/* We assume this function is called xtime_lock held. */
 	unsigned long count =
@@ -129,6 +129,6 @@ static unsigned int bcm1480_hpt_read(voi
 
 void __init bcm1480_hpt_setup(void)
 {
-	mips_hpt_read = bcm1480_hpt_read;
+	clocksource_mips.read = bcm1480_hpt_read;
 	mips_hpt_frequency = BCM1480_HPT_VALUE;
 }
diff --git a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
index bcb74f2..2efffe1 100644
--- a/arch/mips/sibyte/sb1250/time.c
+++ b/arch/mips/sibyte/sb1250/time.c
@@ -51,7 +51,7 @@ #define SB1250_HPT_VALUE	M_SCD_TIMER_CNT
 
 extern int sb1250_steal_irq(int irq);
 
-static unsigned int sb1250_hpt_read(void);
+static cycle_t sb1250_hpt_read(void);
 
 void __init sb1250_hpt_setup(void)
 {
@@ -66,8 +66,8 @@ void __init sb1250_hpt_setup(void)
 			     IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CFG)));
 
 		mips_hpt_frequency = V_SCD_TIMER_FREQ;
-		mips_hpt_read = sb1250_hpt_read;
-		mips_hpt_mask = M_SCD_TIMER_INIT;
+		clocksource_mips.read = sb1250_hpt_read;
+		clocksource_mips.mask = M_SCD_TIMER_INIT;
 	}
 }
 
@@ -143,7 +143,7 @@ void sb1250_timer_interrupt(void)
  * The HPT is free running from SB1250_HPT_VALUE down to 0 then starts over
  * again.
  */
-static unsigned int sb1250_hpt_read(void)
+static cycle_t sb1250_hpt_read(void)
 {
 	unsigned int count;
 
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index b58665e..a632cef 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -21,6 +21,7 @@ #include <linux/linkage.h>
 #include <linux/ptrace.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
+#include <linux/clocksource.h>
 
 extern spinlock_t rtc_lock;
 
@@ -44,11 +45,10 @@ extern int (*mips_timer_state)(void);
 extern void (*mips_timer_ack)(void);
 
 /*
- * High precision timer functions.
- * If mips_hpt_read is NULL, an R4k-compatible timer setup is attempted.
+ * High precision timer clocksource.
+ * If .read is NULL, an R4k-compatible timer setup is attempted.
  */
-extern unsigned int (*mips_hpt_read)(void);
-extern unsigned int mips_hpt_mask;
+extern struct clocksource clocksource_mips;
 
 /*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
