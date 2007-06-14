Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 11:21:23 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:22849 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022748AbXFNKUo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 11:20:44 +0100
Received: by ug-out-1314.google.com with SMTP id m3so647578ugc
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=b5EQy33pf1kRYPW/INFpW16NGMIIsLuJHobK8SI1+uWXcefpngre5B8ZhDbjuVTobswP2JhVaeDPk0fRooV/2j0uCh1jaFe8eSKLNqNjEDVqOtucAaPeA+AQdxFh+4YGo9sG2I2TF65WPf0/hX2SmUKFqWxb+6XxT7j3VCnCsGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Gp8js3bpRahmkFaj+6Yj7IIK+ah1EnTUaf06Q7QgI9AG4iATui3HlX/JLY7+XJLx/cbEUGwNiNaF8CJ2aXptRRq8zDXp5pM6wyc1gCjG/FWP7KOmmcAluQpNzZB3/5sqiTvk820BfheZSmQUrkz+w10o/vZdDC/F7NYQTIsqfso=
Received: by 10.67.25.9 with SMTP id c9mr1986214ugj.1181816382875;
        Thu, 14 Jun 2007 03:19:42 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z33sm3874836ikz.2007.06.14.03.19.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2007 03:19:40 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A6EB323F76F; Thu, 14 Jun 2007 12:20:02 +0200 (CEST)
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Date:	Thu, 14 Jun 2007 12:19:59 +0200
Message-Id: <11818164023940-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818164011355-git-send-email-fbuihuu@gmail.com>
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>

Hard to follow who is pointing what to where and why so it's simply getting
in the way of the time code renovation.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/au1000/common/setup.c           |    2 -
 arch/mips/au1000/common/time.c            |    4 --
 arch/mips/basler/excite/excite_setup.c    |    5 +--
 arch/mips/ddb5xxx/common/rtc_ds1386.c     |   10 +----
 arch/mips/ddb5xxx/ddb5477/setup.c         |    4 +-
 arch/mips/dec/setup.c                     |    4 --
 arch/mips/dec/time.c                      |   12 ++----
 arch/mips/emma2rh/markeins/setup.c        |    4 +-
 arch/mips/gt64120/wrppmc/setup.c          |    4 --
 arch/mips/gt64120/wrppmc/time.c           |    2 +-
 arch/mips/jmr3927/rbhma3100/setup.c       |    4 +-
 arch/mips/kernel/time.c                   |   41 ++++++--------------
 arch/mips/lasat/ds1603.c                  |    6 +-
 arch/mips/lasat/ds1603.h                  |    2 -
 arch/mips/lasat/setup.c                   |    6 +--
 arch/mips/lasat/sysctl.c                  |   59 -----------------------------
 arch/mips/mips-boards/atlas/atlas_setup.c |    5 --
 arch/mips/mips-boards/generic/time.c      |    4 +-
 arch/mips/mips-boards/malta/malta_setup.c |    4 --
 arch/mips/mips-boards/sead/sead_setup.c   |    3 -
 arch/mips/mips-boards/sim/sim_setup.c     |    3 -
 arch/mips/mips-boards/sim/sim_time.c      |    2 +-
 arch/mips/momentum/ocelot_3/setup.c       |   12 +----
 arch/mips/momentum/ocelot_c/setup.c       |   15 ++-----
 arch/mips/philips/pnx8550/common/setup.c  |    3 -
 arch/mips/philips/pnx8550/common/time.c   |    7 ++-
 arch/mips/pmc-sierra/yosemite/setup.c     |   18 +-------
 arch/mips/sgi-ip22/ip22-setup.c           |    2 -
 arch/mips/sgi-ip22/ip22-time.c            |   15 +------
 arch/mips/sgi-ip27/ip27-init.c            |    3 -
 arch/mips/sgi-ip27/ip27-timer.c           |    6 +--
 arch/mips/sgi-ip32/ip32-setup.c           |   12 +++---
 arch/mips/sibyte/swarm/setup.c            |   48 +++++++++++++++++------
 arch/mips/sni/a20r.c                      |    1 -
 arch/mips/sni/ds1216.c                    |    4 +-
 arch/mips/sni/pcimt.c                     |    3 -
 arch/mips/sni/pcit.c                      |    3 -
 arch/mips/sni/rm200.c                     |    2 -
 arch/mips/sni/time.c                      |    2 +-
 arch/mips/tx4927/common/tx4927_setup.c    |    9 +----
 arch/mips/tx4938/common/rtc_rx5c348.c     |   10 +----
 arch/mips/tx4938/common/setup.c           |    9 ----
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |    4 +-
 arch/mips/vr41xx/common/init.c            |    8 +---
 include/asm-mips/rtc.h                    |    6 +-
 include/asm-mips/time.h                   |   12 ++----
 46 files changed, 106 insertions(+), 298 deletions(-)

diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 13fe187..646d7aa 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -50,7 +50,6 @@ extern void au1000_halt(void);
 extern void au1000_power_off(void);
 extern void au1x_time_init(void);
 extern void au1x_timer_setup(struct irqaction *irq);
-extern void au1xxx_time_init(void);
 extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
@@ -121,7 +120,6 @@ void __init plat_mem_setup(void)
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	pm_power_off = au1000_power_off;
-	board_time_init = au1xxx_time_init;
 
 	/* IO/MEM resources. */
 	set_io_port_base(0);
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index fa1c62f..b32bf46 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -358,7 +358,3 @@ void __init plat_timer_setup(struct irqaction *irq)
 
 #endif
 }
-
-void __init au1xxx_time_init(void)
-{
-}
diff --git a/arch/mips/basler/excite/excite_setup.c b/arch/mips/basler/excite/excite_setup.c
index 2f0e4c0..bf7e543 100644
--- a/arch/mips/basler/excite/excite_setup.c
+++ b/arch/mips/basler/excite/excite_setup.c
@@ -67,7 +67,7 @@ DEFINE_SPINLOCK(titan_lock);
 int titan_irqflags;
 
 
-static void excite_timer_init(void)
+void __init plat_time_init(void)
 {
 	const u32 modebit5 = ocd_readl(0x00e4);
 	unsigned int
@@ -260,9 +260,6 @@ void __init plat_mem_setup(void)
 	/* Announce RAM to system */
 	add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
 
-	/* Set up timer initialization hooks */
-	board_time_init = excite_timer_init;
-
 	/* Set up the peripheral address map */
 	*(boot_ocd_base + (LKB9 / sizeof (u32))) = 0;
 	*(boot_ocd_base + (LKB10 / sizeof (u32))) = 0;
diff --git a/arch/mips/ddb5xxx/common/rtc_ds1386.c b/arch/mips/ddb5xxx/common/rtc_ds1386.c
index 5dc34da..80f8e74 100644
--- a/arch/mips/ddb5xxx/common/rtc_ds1386.c
+++ b/arch/mips/ddb5xxx/common/rtc_ds1386.c
@@ -35,8 +35,7 @@
 
 static unsigned long rtc_base;
 
-static unsigned long
-rtc_ds1386_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	u8 byte;
 	u8 temp;
@@ -77,8 +76,7 @@ rtc_ds1386_get_time(void)
 	return mktime(year, month, day, hour, minute, second);
 }
 
-static int
-rtc_ds1386_set_time(unsigned long t)
+static int rtc_mips_set_time(unsigned long t)
 {
 	struct rtc_time tm;
 	u8 byte;
@@ -163,8 +161,4 @@ rtc_ds1386_init(unsigned long base)
 	byte = READ_RTC(0xB);
 	byte |= 0x80;
 	WRITE_RTC(0xB, byte);
-
-	/* set the function pointers */
-	rtc_mips_get_time = rtc_ds1386_get_time;
-	rtc_mips_set_time = rtc_ds1386_set_time;
 }
diff --git a/arch/mips/ddb5xxx/ddb5477/setup.c b/arch/mips/ddb5xxx/ddb5477/setup.c
index f0cc0e8..c276e94 100644
--- a/arch/mips/ddb5xxx/ddb5477/setup.c
+++ b/arch/mips/ddb5xxx/ddb5477/setup.c
@@ -121,7 +121,7 @@ static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
 	return freq;
 }
 
-static void __init ddb_time_init(void)
+void __init plat_time_init(void)
 {
 	unsigned long rtc_base;
 	unsigned int i;
@@ -176,8 +176,6 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(KSEG1ADDR(DDB_PCI_IO_BASE));
 
-	board_time_init = ddb_time_init;
-
 	_machine_restart = ddb_machine_restart;
 	_machine_halt = ddb_machine_halt;
 	pm_power_off = ddb_machine_power_off;
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index b8a5e75..4ed83b4 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -145,13 +145,9 @@ static void __init dec_be_init(void)
 	}
 }
 
-
-extern void dec_time_init(void);
-
 void __init plat_mem_setup(void)
 {
 	board_be_init = dec_be_init;
-	board_time_init = dec_time_init;
 
 	wbflush_setup();
 
diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 8b7e0c1..2c6dc89 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -36,7 +36,7 @@
 #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/machtype.h>
 
-static unsigned long dec_rtc_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned int year, mon, day, hour, min, sec, real_year;
 	unsigned long flags;
@@ -75,13 +75,13 @@ static unsigned long dec_rtc_get_time(void)
 }
 
 /*
- * In order to set the CMOS clock precisely, dec_rtc_set_mmss has to
+ * In order to set the CMOS clock precisely, rtc_mips_set_mmss has to
  * be called 500 ms after the second nowtime has started, because when
  * nowtime is written into the registers of the CMOS clock, it will
  * jump to the next second precisely 500 ms later.  Check the Dallas
  * DS1287 data sheet for details.
  */
-static int dec_rtc_set_mmss(unsigned long nowtime)
+int rtc_mips_set_mmss(unsigned long nowtime)
 {
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
@@ -140,7 +140,6 @@ static int dec_rtc_set_mmss(unsigned long nowtime)
 	return retval;
 }
 
-
 static int dec_timer_state(void)
 {
 	return (CMOS_READ(RTC_REG_C) & RTC_PF) != 0;
@@ -161,11 +160,8 @@ static cycle_t dec_ioasic_hpt_read(void)
 }
 
 
-void __init dec_time_init(void)
+void __init plat_time_init(void)
 {
-	rtc_mips_get_time = dec_rtc_get_time;
-	rtc_mips_set_mmss = dec_rtc_set_mmss;
-
 	mips_timer_state = dec_timer_state;
 	mips_timer_ack = dec_timer_ack;
 
diff --git a/arch/mips/emma2rh/markeins/setup.c b/arch/mips/emma2rh/markeins/setup.c
index 2f060e1..5e1da53 100644
--- a/arch/mips/emma2rh/markeins/setup.c
+++ b/arch/mips/emma2rh/markeins/setup.c
@@ -88,7 +88,7 @@ static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
 	return clock[reg];
 }
 
-static void __init emma2rh_time_init(void)
+void __init plat_time_init(void)
 {
 	u32 reg;
 	if (bus_frequency == 0)
@@ -124,8 +124,6 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(KSEG1ADDR(EMMA2RH_PCI_IO_BASE));
 
-	board_time_init = emma2rh_time_init;
-
 	_machine_restart = markeins_machine_restart;
 	_machine_halt = markeins_machine_halt;
 	pm_power_off = markeins_machine_power_off;
diff --git a/arch/mips/gt64120/wrppmc/setup.c b/arch/mips/gt64120/wrppmc/setup.c
index 121188d..46abb59 100644
--- a/arch/mips/gt64120/wrppmc/setup.c
+++ b/arch/mips/gt64120/wrppmc/setup.c
@@ -125,7 +125,6 @@ static void wrppmc_setup_serial(void)
 
 void __init plat_mem_setup(void)
 {
-	extern void wrppmc_time_init(void);
 	extern void wrppmc_machine_restart(char *command);
 	extern void wrppmc_machine_halt(void);
 	extern void wrppmc_machine_power_off(void);
@@ -134,9 +133,6 @@ void __init plat_mem_setup(void)
 	_machine_halt	 = wrppmc_machine_halt;
 	pm_power_off	 = wrppmc_machine_power_off;
 
-	/* Use MIPS Count/Compare Timer */
-	board_time_init   = wrppmc_time_init;
-
 	/* This makes the operations of 'in/out[bwl]' to the
 	 * physical address ( < KSEG0) can work via KSEG1
 	 */
diff --git a/arch/mips/gt64120/wrppmc/time.c b/arch/mips/gt64120/wrppmc/time.c
index 5b44085..faf164e 100644
--- a/arch/mips/gt64120/wrppmc/time.c
+++ b/arch/mips/gt64120/wrppmc/time.c
@@ -38,7 +38,7 @@ void __init plat_timer_setup(struct irqaction *irq)
  * NOTE: We disable all GT64120 timers, and use MIPS processor internal
  * timer as the source of kernel clock tick.
  */
-void __init wrppmc_time_init(void)
+void __init plat_time_init(void)
 {
 	/* Disable GT64120 timers */
 	GT_WRITE(GT_TC_CONTROL_OFS, 0x00);
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 8303001..285adf6 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -109,7 +109,7 @@ static void jmr3927_timer_ack(void)
 	jmr3927_tmrptr->tisr = 0;       /* ack interrupt */
 }
 
-static void __init jmr3927_time_init(void)
+void __init plat_time_init(void)
 {
 	clocksource_mips.read = jmr3927_hpt_read;
 	mips_timer_ack = jmr3927_timer_ack;
@@ -141,8 +141,6 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(JMR3927_PORT_BASE + JMR3927_PCIIO);
 
-	board_time_init = jmr3927_time_init;
-
 	_machine_restart = jmr3927_machine_restart;
 	_machine_halt = jmr3927_machine_halt;
 	pm_power_off = jmr3927_machine_power_off;
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 376e127..d176e91 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -49,23 +49,16 @@
  */
 DEFINE_SPINLOCK(rtc_lock);
 
-/*
- * By default we provide the null RTC ops
- */
-static unsigned long null_rtc_get_time(void)
+int __attribute__((weak)) rtc_mips_set_time(unsigned long sec)
 {
-	return mktime(2000, 1, 1, 0, 0, 0);
+	return 0;
 }
 
-static int null_rtc_set_time(unsigned long sec)
+int __attribute__((weak)) rtc_mips_set_mmss(unsigned long nowtime)
 {
-	return 0;
+	return rtc_mips_set_time(nowtime);
 }
 
-unsigned long (*rtc_mips_get_time)(void) = null_rtc_get_time;
-int (*rtc_mips_set_time)(unsigned long) = null_rtc_set_time;
-int (*rtc_mips_set_mmss)(unsigned long);
-
 int update_persistent_clock(struct timespec now)
 {
 	return rtc_mips_set_mmss(now.tv_sec);
@@ -241,21 +234,18 @@ asmlinkage void ll_local_timer_interrupt(int irq)
 /*
  * time_init() - it does the following things.
  *
- * 1) board_time_init() -
+ * 1) plat_time_init() -
  * 	a) (optional) set up RTC routines,
  *      b) (optional) calibrate and set the mips_hpt_frequency
  *	    (only needed if you intended to use cpu counter as timer interrupt
  *	     source)
- * 2) setup xtime based on rtc_mips_get_time().
- * 3) calculate a couple of cached variables for later usage
- * 4) plat_timer_setup() -
+ * 2) calculate a couple of cached variables for later usage
+ * 3) plat_timer_setup() -
  *	a) (optional) over-write any choices made above by time_init().
  *	b) machine specific code should setup the timer irqaction.
  *	c) enable the timer interrupt
  */
 
-void (*board_time_init)(void);
-
 unsigned int mips_hpt_frequency;
 
 static struct irqaction timer_irqaction = {
@@ -335,19 +325,13 @@ static void __init init_mips_clocksource(void)
 	clocksource_register(&clocksource_mips);
 }
 
-void __init time_init(void)
+void __init __weak plat_time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
-
-	if (!rtc_mips_set_mmss)
-		rtc_mips_set_mmss = rtc_mips_set_time;
-
-	xtime.tv_sec = rtc_mips_get_time();
-	xtime.tv_nsec = 0;
+}
 
-	set_normalized_timespec(&wall_to_monotonic,
-	                        -xtime.tv_sec, -xtime.tv_nsec);
+void __init time_init(void)
+{
+	plat_time_init();
 
 	/* Choose appropriate high precision timer routines.  */
 	if (!cpu_has_counter && !clocksource_mips.read)
@@ -456,4 +440,3 @@ void to_tm(unsigned long tim, struct rtc_time *tm)
 EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL(to_tm);
 EXPORT_SYMBOL(rtc_mips_set_time);
-EXPORT_SYMBOL(rtc_mips_get_time);
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
index 7dced67..53207de 100644
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -135,8 +135,7 @@ static void rtc_end_op(void)
 	lasat_ndelay(1000);
 }
 
-/* interface */
-unsigned long ds1603_read(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned long word;
 	unsigned long flags;
@@ -147,10 +146,11 @@ unsigned long ds1603_read(void)
 	word = rtc_read_word();
 	rtc_end_op();
 	spin_unlock_irqrestore(&rtc_lock, flags);
+
 	return word;
 }
 
-int ds1603_set(unsigned long time)
+int rtc_mips_set_time(unsigned long time)
 {
 	unsigned long flags;
 
diff --git a/arch/mips/lasat/ds1603.h b/arch/mips/lasat/ds1603.h
index c2e5c76..2da3704 100644
--- a/arch/mips/lasat/ds1603.h
+++ b/arch/mips/lasat/ds1603.h
@@ -20,8 +20,6 @@ struct ds_defs {
 
 extern struct ds_defs *ds1603;
 
-unsigned long ds1603_read(void);
-int ds1603_set(unsigned long);
 void ds1603_set_trimmer(unsigned int);
 void ds1603_enable(void);
 void ds1603_disable(void);
diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
index 488007f..ef630e7 100644
--- a/arch/mips/lasat/setup.c
+++ b/arch/mips/lasat/setup.c
@@ -109,7 +109,7 @@ static struct notifier_block lasat_panic_block[] =
 	{ lasat_panic_prom_monitor, NULL, INT_MIN }
 };
 
-static void lasat_time_init(void)
+void __init plat_time_init(void)
 {
 	mips_hpt_frequency = lasat_board_info.li_cpu_hz / 2;
 }
@@ -164,12 +164,8 @@ void __init plat_mem_setup(void)
 
 	lasat_reboot_setup();
 
-	board_time_init = lasat_time_init;
-
 #ifdef CONFIG_DS1603
 	ds1603 = &ds_defs[mips_machtype];
-	rtc_mips_get_time = ds1603_read;
-	rtc_mips_set_time = ds1603_set;
 #endif
 
 #ifdef DYNAMIC_SERIAL_INIT
diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 699ab18..58e2fec 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -92,30 +92,6 @@ int proc_dolasatint(ctl_table *table, int write, struct file *filp,
 
 static int rtctmp;
 
-#ifdef CONFIG_DS1603
-/* proc function to read/write RealTime Clock */
-int proc_dolasatrtc(ctl_table *table, int write, struct file *filp,
-		       void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int r;
-	mutex_lock(&lasat_info_mutex);
-	if (!write) {
-		rtctmp = ds1603_read();
-		/* check for time < 0 and set to 0 */
-		if (rtctmp < 0)
-			rtctmp = 0;
-	}
-	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
-	if ( (!write) || r) {
-		mutex_unlock(&lasat_info_mutex);
-		return r;
-	}
-	ds1603_set(rtctmp);
-	mutex_unlock(&lasat_info_mutex);
-	return 0;
-}
-#endif
-
 /* Sysctl for setting the IP addresses */
 int sysctl_lasat_intvec(ctl_table *table, int *name, int nlen,
 		    void *oldval, size_t *oldlenp,
@@ -135,30 +111,6 @@ int sysctl_lasat_intvec(ctl_table *table, int *name, int nlen,
 	return 1;
 }
 
-#ifdef CONFIG_DS1603
-/* Same for RTC */
-int sysctl_lasat_rtc(ctl_table *table, int *name, int nlen,
-		    void *oldval, size_t *oldlenp,
-		    void *newval, size_t newlen)
-{
-	int r;
-	mutex_lock(&lasat_info_mutex);
-	rtctmp = ds1603_read();
-	if (rtctmp < 0)
-		rtctmp = 0;
-	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
-	if (r < 0) {
-		mutex_unlock(&lasat_info_mutex);
-		return r;
-	}
-	if (newval && newlen) {
-		ds1603_set(rtctmp);
-	}
-	mutex_unlock(&lasat_info_mutex);
-	return 1;
-}
-#endif
-
 #ifdef CONFIG_INET
 static char lasat_bcastaddr[16];
 
@@ -385,17 +337,6 @@ static ctl_table lasat_table[] = {
 		.proc_handler	= &proc_dointvec,
 		.strategy	= &sysctl_intvec
 	},
-#ifdef CONFIG_DS1603
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "rtc",
-		.data		= &rtctmp,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dolasatrtc,
-		.strategy	= &sysctl_lasat_rtc
-	},
-#endif
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "namestr",
diff --git a/arch/mips/mips-boards/atlas/atlas_setup.c b/arch/mips/mips-boards/atlas/atlas_setup.c
index 1cc6ebb..d96b426 100644
--- a/arch/mips/mips-boards/atlas/atlas_setup.c
+++ b/arch/mips/mips-boards/atlas/atlas_setup.c
@@ -34,8 +34,6 @@
 #include <asm/traps.h>
 
 extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
-extern unsigned long mips_rtc_get_time(void);
 
 #ifdef CONFIG_KGDB
 extern void kgdb_config(void);
@@ -62,9 +60,6 @@ void __init plat_mem_setup(void)
 	kgdb_config();
 #endif
 	mips_reboot_setup();
-
-	board_time_init = mips_time_init;
-	rtc_mips_get_time = mips_rtc_get_time;
 }
 
 static void __init serial_init(void)
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index 8f1000f..67a0718 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -224,12 +224,12 @@ static unsigned int __init estimate_cpu_frequency(void)
 	return count;
 }
 
-unsigned long __init mips_rtc_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	return mc146818_get_cmos_time();
 }
 
-void __init mips_time_init(void)
+void __init plat_time_init(void)
 {
 	unsigned int est_freq;
 
diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 8f1b78d..a5a5a43 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -36,7 +36,6 @@
 #endif
 
 extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
 extern unsigned long mips_rtc_get_time(void);
 
 #ifdef CONFIG_KGDB
@@ -185,7 +184,4 @@ void __init plat_mem_setup(void)
 #endif
 #endif
 	mips_reboot_setup();
-
-	board_time_init = mips_time_init;
-	rtc_mips_get_time = mips_rtc_get_time;
 }
diff --git a/arch/mips/mips-boards/sead/sead_setup.c b/arch/mips/mips-boards/sead/sead_setup.c
index 811aba1..bc05054 100644
--- a/arch/mips/mips-boards/sead/sead_setup.c
+++ b/arch/mips/mips-boards/sead/sead_setup.c
@@ -34,7 +34,6 @@
 #include <asm/time.h>
 
 extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
 
 static void __init serial_init(void);
 
@@ -51,8 +50,6 @@ void __init plat_mem_setup(void)
 
 	serial_init ();
 
-	board_time_init = mips_time_init;
-
 	mips_reboot_setup();
 }
 
diff --git a/arch/mips/mips-boards/sim/sim_setup.c b/arch/mips/mips-boards/sim/sim_setup.c
index b705f09..e05c1c2 100644
--- a/arch/mips/mips-boards/sim/sim_setup.c
+++ b/arch/mips/mips-boards/sim/sim_setup.c
@@ -35,8 +35,6 @@
 #include <asm/mips-boards/sim.h>
 #include <asm/mips-boards/simint.h>
 
-
-extern void sim_time_init(void);
 static void __init serial_init(void);
 unsigned int _isbonito = 0;
 
@@ -54,7 +52,6 @@ void __init plat_mem_setup(void)
 
 	serial_init();
 
-	board_time_init = sim_time_init;
 	pr_info("Linux started...\n");
 
 #ifdef CONFIG_MIPS_MT_SMP
diff --git a/arch/mips/mips-boards/sim/sim_time.c b/arch/mips/mips-boards/sim/sim_time.c
index d3a21c7..f8b8dff 100644
--- a/arch/mips/mips-boards/sim/sim_time.c
+++ b/arch/mips/mips-boards/sim/sim_time.c
@@ -146,7 +146,7 @@ static unsigned int __init estimate_cpu_frequency(void)
 	return count;
 }
 
-void __init sim_time_init(void)
+void __init plat_time_init(void)
 {
 	unsigned int est_freq, flags;
 
diff --git a/arch/mips/momentum/ocelot_3/setup.c b/arch/mips/momentum/ocelot_3/setup.c
index ff0829f..fd3372d 100644
--- a/arch/mips/momentum/ocelot_3/setup.c
+++ b/arch/mips/momentum/ocelot_3/setup.c
@@ -98,7 +98,6 @@ extern void momenco_ocelot_restart(char *command);
 extern void momenco_ocelot_halt(void);
 extern void momenco_ocelot_power_off(void);
 
-void momenco_time_init(void);
 static char reset_reason;
 
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
@@ -131,7 +130,7 @@ void setup_wired_tlb_entries(void)
 	add_wired_entry(ENTRYLO(0xfc000000), ENTRYLO(0xfd000000), (signed)0xfc000000, PM_16M);
 }
 
-unsigned long m48t37y_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned int year, month, day, hour, min, sec;
 	unsigned long flags;
@@ -158,7 +157,7 @@ unsigned long m48t37y_get_time(void)
 	return mktime(year, month, day, hour, min, sec);
 }
 
-int m48t37y_set_time(unsigned long sec)
+int rtc_mips_set_time(unsigned long sec)
 {
 	struct rtc_time tm;
 	unsigned long flags;
@@ -201,7 +200,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(7, irq);	/* Timer interrupt, unmask status IM7 */
 }
 
-void momenco_time_init(void)
+void __init plat_time_init(void)
 {
 	setup_wired_tlb_entries();
 
@@ -210,9 +209,6 @@ void momenco_time_init(void)
 	 * the Rm7900 and the Rm7065C
 	 */
 	mips_hpt_frequency = cpu_clock / 2;
-
-	rtc_mips_get_time = m48t37y_get_time;
-	rtc_mips_set_time = m48t37y_set_time;
 }
 
 /*
@@ -315,8 +311,6 @@ void __init plat_mem_setup(void)
 {
 	unsigned int tmpword;
 
-	board_time_init = momenco_time_init;
-
 	_machine_restart = momenco_ocelot_restart;
 	_machine_halt = momenco_ocelot_halt;
 	pm_power_off = momenco_ocelot_power_off;
diff --git a/arch/mips/momentum/ocelot_c/setup.c b/arch/mips/momentum/ocelot_c/setup.c
index 0b6b233..68b8236 100644
--- a/arch/mips/momentum/ocelot_c/setup.c
+++ b/arch/mips/momentum/ocelot_c/setup.c
@@ -76,8 +76,6 @@ extern void momenco_ocelot_restart(char *command);
 extern void momenco_ocelot_halt(void);
 extern void momenco_ocelot_power_off(void);
 
-void momenco_time_init(void);
-
 static char reset_reason;
 
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1, unsigned long entryhi, unsigned long pagemask);
@@ -130,7 +128,7 @@ void PMON_v2_setup(void)
 #endif
 }
 
-unsigned long m48t37y_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 #ifdef CONFIG_64BIT
 	unsigned char *rtc_base = (unsigned char*)0xfffffffffc800000;
@@ -162,7 +160,7 @@ unsigned long m48t37y_get_time(void)
 	return mktime(year, month, day, hour, min, sec);
 }
 
-int m48t37y_set_time(unsigned long sec)
+int rtc_mips_set_time(unsigned long sec)
 {
 #ifdef CONFIG_64BIT
 	unsigned char* rtc_base = (unsigned char*)0xfffffffffc800000;
@@ -210,7 +208,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(7, irq);
 }
 
-void momenco_time_init(void)
+void __init plat_time_init(void)
 {
 #ifdef CONFIG_CPU_SR71000
 	mips_hpt_frequency = cpu_clock;
@@ -219,18 +217,13 @@ void momenco_time_init(void)
 #else
 #error Unknown CPU for this board
 #endif
-	printk("momenco_time_init cpu_clock=%d\n", cpu_clock);
-
-	rtc_mips_get_time = m48t37y_get_time;
-	rtc_mips_set_time = m48t37y_set_time;
+	printk("plat_time_init cpu_clock=%d\n", cpu_clock);
 }
 
 void __init plat_mem_setup(void)
 {
 	unsigned int tmpword;
 
-	board_time_init = momenco_time_init;
-
 	_machine_restart = momenco_ocelot_restart;
 	_machine_halt = momenco_ocelot_halt;
 	pm_power_off = momenco_ocelot_power_off;
diff --git a/arch/mips/philips/pnx8550/common/setup.c b/arch/mips/philips/pnx8550/common/setup.c
index 5bd7374..2ce298f 100644
--- a/arch/mips/philips/pnx8550/common/setup.c
+++ b/arch/mips/philips/pnx8550/common/setup.c
@@ -47,7 +47,6 @@ extern void pnx8550_machine_halt(void);
 extern void pnx8550_machine_power_off(void);
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
-extern void pnx8550_time_init(void);
 extern void rs_kgdb_hook(int tty_no);
 extern char *prom_getcmdline(void);
 
@@ -104,8 +103,6 @@ void __init plat_mem_setup(void)
         _machine_halt = pnx8550_machine_halt;
         pm_power_off = pnx8550_machine_power_off;
 
-	board_time_init = pnx8550_time_init;
-
 	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
 	   Bit 1:Enable DAC Powerdown
 	  -> 0:DACs are enabled and are working normally
diff --git a/arch/mips/philips/pnx8550/common/time.c b/arch/mips/philips/pnx8550/common/time.c
index 68def38..e818fd0 100644
--- a/arch/mips/philips/pnx8550/common/time.c
+++ b/arch/mips/philips/pnx8550/common/time.c
@@ -1,6 +1,7 @@
 /*
  * Copyright 2001, 2002, 2003 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
  *
  * Common time service routines for MIPS machines. See
  * Documents/MIPS/README.txt.
@@ -46,16 +47,16 @@ static void timer_ack(void)
 }
 
 /*
- * pnx8550_time_init() - it does the following things:
+ * plat_time_init() - it does the following things:
  *
- * 1) board_time_init() -
+ * 1) plat_time_init() -
  * 	a) (optional) set up RTC routines,
  *      b) (optional) calibrate and set the mips_hpt_frequency
  *	    (only needed if you intended to use cpu counter as timer interrupt
  *	     source)
  */
 
-void pnx8550_time_init(void)
+__init void plat_time_init(void)
 {
 	unsigned int             n;
 	unsigned int             m;
diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
index 6a6e15e..902ace8 100644
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -69,7 +69,7 @@ void __init bus_error_init(void)
 }
 
 
-unsigned long m48t37y_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned int year, month, day, hour, min, sec;
 	unsigned long flags;
@@ -94,7 +94,7 @@ unsigned long m48t37y_get_time(void)
 	return mktime(year, month, day, hour, min, sec);
 }
 
-int m48t37y_set_time(unsigned long sec)
+int rtc_mips_set_time(unsigned long sec)
 {
 	struct rtc_time tm;
 	unsigned long flags;
@@ -137,7 +137,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(7, irq);
 }
 
-void yosemite_time_init(void)
+void __init plat_time_init(void)
 {
 	mips_hpt_frequency = cpu_clock / 2;
 mips_hpt_frequency = 33000000 * 3 * 5;
@@ -197,17 +197,6 @@ static void __init py_rtc_setup(void)
 	m48t37_base = ioremap(YOSEMITE_RTC_BASE, YOSEMITE_RTC_SIZE);
 	if (!m48t37_base)
 		printk(KERN_ERR "Mapping the RTC failed\n");
-
-	rtc_mips_get_time = m48t37y_get_time;
-	rtc_mips_set_time = m48t37y_set_time;
-
-	write_seqlock(&xtime_lock);
-	xtime.tv_sec = m48t37y_get_time();
-	xtime.tv_nsec = 0;
-
-	set_normalized_timespec(&wall_to_monotonic,
-	                        -xtime.tv_sec, -xtime.tv_nsec);
-	write_sequnlock(&xtime_lock);
 }
 
 /* Not only time init but that's what the hook it's called through is named */
@@ -220,7 +209,6 @@ static void __init py_late_time_init(void)
 
 void __init plat_mem_setup(void)
 {
-	board_time_init = yosemite_time_init;
 	late_time_init = py_late_time_init;
 
 	/* Add memory regions */
diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index 25097ec..35bdf83 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -50,7 +50,6 @@ void ip22_do_break(void)
 EXPORT_SYMBOL(ip22_do_break);
 
 extern void ip22_be_init(void) __init;
-extern void ip22_time_init(void) __init;
 
 void __init plat_mem_setup(void)
 {
@@ -58,7 +57,6 @@ void __init plat_mem_setup(void)
 	char *cserial;
 
 	board_be_init = ip22_be_init;
-	ip22_time_init();
 
 	/* Init the INDY HPC I/O controller.  Need to call this before
 	 * fucking with the memory controller because it needs to know the
diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 8e88a44..77f0c30 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -32,7 +32,7 @@
  * note that mktime uses month from 1 to 12 while to_tm
  * uses 0 to 11.
  */
-static unsigned long indy_rtc_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned int yrs, mon, day, hrs, min, sec;
 	unsigned int save_control;
@@ -60,7 +60,7 @@ static unsigned long indy_rtc_get_time(void)
 	return mktime(yrs + 1900, mon, day, hrs, min, sec);
 }
 
-static int indy_rtc_set_time(unsigned long tim)
+int rtc_mips_set_time(unsigned long tim)
 {
 	struct rtc_time tm;
 	unsigned int save_control;
@@ -128,7 +128,7 @@ static unsigned long dosample(void)
 /*
  * Here we need to calibrate the cycle counter to at least be close.
  */
-static __init void indy_time_init(void)
+__init void plat_time_init(void)
 {
 	unsigned long r4k_ticks[3];
 	unsigned long r4k_tick;
@@ -207,12 +207,3 @@ void __init plat_timer_setup(struct irqaction *irq)
 	/* setup irqaction */
 	setup_irq(SGI_TIMER_IRQ, irq);
 }
-
-void __init ip22_time_init(void)
-{
-	/* setup hookup functions */
-	rtc_mips_get_time = indy_rtc_get_time;
-	rtc_mips_set_time = indy_rtc_set_time;
-
-	board_time_init = indy_time_init;
-}
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 74158d3..8427231 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -191,7 +191,6 @@ static inline void ioc3_eth_init(void)
 	ioc3->eier = 0;
 }
 
-extern void ip27_time_init(void);
 extern void ip27_reboot_setup(void);
 
 void __init plat_mem_setup(void)
@@ -238,6 +237,4 @@ void __init plat_mem_setup(void)
 	per_cpu_init();
 
 	set_io_port_base(IO_BASE);
-
-	board_time_init = ip27_time_init;
 }
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 3134616..9c1700e 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -123,7 +123,7 @@ again:
 #include <asm/sn/sn0/hubio.h>
 #include <asm/pci/bridge.h>
 
-static __init unsigned long get_m48t35_time(void)
+unsigned long read_persistent_clock(void)
 {
         unsigned int year, month, date, hour, min, sec;
 	struct m48t35_rtc *rtc;
@@ -205,12 +205,10 @@ static cycle_t ip27_hpt_read(void)
 	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
 }
 
-void __init ip27_time_init(void)
+void __init plat_time_init(void)
 {
 	clocksource_mips.read = ip27_hpt_read;
 	mips_hpt_frequency = CYCLES_PER_SEC;
-	xtime.tv_sec = get_m48t35_time();
-	xtime.tv_nsec = 0;
 }
 
 void __init cpu_time_init(void)
diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
index 57708fe..f3aa4cf 100644
--- a/arch/mips/sgi-ip32/ip32-setup.c
+++ b/arch/mips/sgi-ip32/ip32-setup.c
@@ -68,10 +68,15 @@ static inline void str2eaddr(unsigned char *ea, unsigned char *str)
 #include <linux/serial_core.h>
 #endif /* CONFIG_SERIAL_8250 */
 
+unsigned long read_persistent_clock(void)
+{
+	return mc146818_get_cmos_time();
+}
+
 /* An arbitrary time; this can be decreased if reliability looks good */
 #define WAIT_MS 10
 
-void __init ip32_time_init(void)
+void __init plat_time_init(void)
 {
 	printk(KERN_INFO "Calibrating system timer... ");
 	write_c0_count(0);
@@ -91,11 +96,6 @@ void __init plat_mem_setup(void)
 {
 	board_be_init = ip32_be_init;
 
-	rtc_mips_get_time = mc146818_get_cmos_time;
-	rtc_mips_set_mmss = mc146818_set_rtc_mmss;
-
-	board_time_init = ip32_time_init;
-
 #ifdef CONFIG_SERIAL_8250
 	{
 		static struct uart_port o2_serial[2];
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 83572d8..9988cea 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -69,7 +69,7 @@ const char *get_system_type(void)
 	return "SiByte " SIBYTE_BOARD_NAME;
 }
 
-void __init swarm_time_init(void)
+void __init plat_time_init(void)
 {
 #if defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	/* Setup HPT */
@@ -104,6 +104,36 @@ int swarm_be_handler(struct pt_regs *regs, int is_fixup)
 	return (is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL);
 }
 
+enum swarm_rtc_type {
+	RTC_NONE,
+	RTC_XICOR,
+	RTC_M4LT81
+};
+
+enum swarm_rtc_type swarm_rtc_type;
+
+unsigned long read_persistent_clock(void)
+{
+	switch (swarm_rtc_type) {
+	case RTC_XICOR:
+		return xicor_get_time(void);
+
+	case RTC_M4LT81:
+		return m41t81_get_time(void);
+	}
+}
+
+static int rtc_mips_set_time(unsigned long sec)
+{
+	switch (swarm_rtc_type) {
+	case RTC_XICOR:
+		return xicor_set_time(sec);
+
+	case RTC_M4LT81:
+		return m41t81_set_time(sec);
+	}
+}
+
 void __init plat_mem_setup(void)
 {
 #if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
@@ -116,20 +146,12 @@ void __init plat_mem_setup(void)
 
 	panic_timeout = 5;  /* For debug.  */
 
-	board_time_init = swarm_time_init;
 	board_be_handler = swarm_be_handler;
 
-	if (xicor_probe()) {
-		printk("swarm setup: Xicor 1241 RTC detected.\n");
-		rtc_mips_get_time = xicor_get_time;
-		rtc_mips_set_time = xicor_set_time;
-	}
-
-	if (m41t81_probe()) {
-		printk("swarm setup: M41T81 RTC detected.\n");
-		rtc_mips_get_time = m41t81_get_time;
-		rtc_mips_set_time = m41t81_set_time;
-	}
+	if (xicor_probe())
+		swarm_rtc_type = RTC_XICOR;
+	if (m41t81_probe())
+		swarm_rtc_type = RTC_M4LT81;
 
 	printk("This kernel optimized for "
 #ifdef CONFIG_SIMULATION
diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index 31ab80f..b311ccd 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -206,7 +206,6 @@ void __init sni_a20r_irq_init(void)
 void sni_a20r_init(void)
 {
 	ds1216_base = (volatile unsigned char *) SNI_DS1216_A20R_BASE;
-	rtc_mips_get_time = ds1216_get_cmos_time;
 }
 
 static int __init snirm_a20r_setup_devinit(void)
diff --git a/arch/mips/sni/ds1216.c b/arch/mips/sni/ds1216.c
index 1d92732..440d26f 100644
--- a/arch/mips/sni/ds1216.c
+++ b/arch/mips/sni/ds1216.c
@@ -48,7 +48,7 @@ static void ds1216_switch_ds_to_clock(void)
 	}
 }
 
-unsigned long ds1216_get_cmos_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned char	*rdbuf;
 	unsigned int	year, month, date, hour, min, sec;
@@ -74,7 +74,7 @@ unsigned long ds1216_get_cmos_time(void)
 	return mktime(year, month, date, hour, min, sec);
 }
 
-int ds1216_set_rtc_mmss(unsigned long nowtime)
+int rtc_mips_set_mmss(unsigned long nowtime)
 {
 	printk("ds1216_set_rtc_mmss called but not implemented\n");
 	return -1;
diff --git a/arch/mips/sni/pcimt.c b/arch/mips/sni/pcimt.c
index 97b2343..a709e79 100644
--- a/arch/mips/sni/pcimt.c
+++ b/arch/mips/sni/pcimt.c
@@ -294,9 +294,6 @@ void sni_pcimt_init(void)
 {
 	sni_pcimt_detect();
 	sni_pcimt_sc_init();
-	rtc_mips_get_time = mc146818_get_cmos_time;
-	rtc_mips_set_time = mc146818_set_rtc_mmss;
-	board_time_init = sni_cpu_time_init;
 	ioport_resource.end = sni_io_resource.end;
 #ifdef CONFIG_PCI
 	PCIBIOS_MIN_IO = 0x9000;
diff --git a/arch/mips/sni/pcit.c b/arch/mips/sni/pcit.c
index 00d151f..8d992c5 100644
--- a/arch/mips/sni/pcit.c
+++ b/arch/mips/sni/pcit.c
@@ -245,9 +245,6 @@ void __init sni_pcit_cplus_irq_init(void)
 
 void sni_pcit_init(void)
 {
-	rtc_mips_get_time = mc146818_get_cmos_time;
-	rtc_mips_set_time = mc146818_set_rtc_mmss;
-	board_time_init = sni_cpu_time_init;
 	ioport_resource.end = sni_io_resource.end;
 #ifdef CONFIG_PCI
 	PCIBIOS_MIN_IO = 0x9000;
diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
index b82ff12..5ff6b35 100644
--- a/arch/mips/sni/rm200.c
+++ b/arch/mips/sni/rm200.c
@@ -181,6 +181,4 @@ void sni_rm200_init(void)
 	set_io_port_base(SNI_PORT_BASE + 0x02000000);
 	ioport_resource.end += 0x02000000;
 	ds1216_base = (volatile unsigned char *) SNI_DS1216_RM200_BASE;
-	rtc_mips_get_time = ds1216_get_cmos_time;
-	board_time_init = sni_cpu_time_init;
 }
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 20028fc..3d5bfa0 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -71,7 +71,7 @@ static __init unsigned long dosample(void)
 /*
  * Here we need to calibrate the cycle counter to at least be close.
  */
-__init void sni_cpu_time_init(void)
+void __init plat_time_init(void)
 {
 	unsigned long r4k_ticks[3];
 	unsigned long r4k_tick;
diff --git a/arch/mips/tx4927/common/tx4927_setup.c b/arch/mips/tx4927/common/tx4927_setup.c
index c8e49fe..a141f44 100644
--- a/arch/mips/tx4927/common/tx4927_setup.c
+++ b/arch/mips/tx4927/common/tx4927_setup.c
@@ -49,14 +49,11 @@
 
 #undef DEBUG
 
-void __init tx4927_time_init(void);
 void dump_cp0(char *key);
 
 
 void __init plat_mem_setup(void)
 {
-	board_time_init = tx4927_time_init;
-
 #ifdef CONFIG_TOSHIBA_RBTX4927
 	{
 		extern void toshiba_rbtx4927_setup(void);
@@ -65,20 +62,16 @@ void __init plat_mem_setup(void)
 #endif
 }
 
-void __init tx4927_time_init(void)
+void __init plat_time_init(void)
 {
-
 #ifdef CONFIG_TOSHIBA_RBTX4927
 	{
 		extern void toshiba_rbtx4927_time_init(void);
 		toshiba_rbtx4927_time_init();
 	}
 #endif
-
-	return;
 }
 
-
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	setup_irq(TX4927_IRQ_CPU_TIMER, irq);
diff --git a/arch/mips/tx4938/common/rtc_rx5c348.c b/arch/mips/tx4938/common/rtc_rx5c348.c
index 07f782f..ad83308 100644
--- a/arch/mips/tx4938/common/rtc_rx5c348.c
+++ b/arch/mips/tx4938/common/rtc_rx5c348.c
@@ -80,8 +80,7 @@ spi_rtc_io(unsigned char *inbuf, unsigned char *outbuf, unsigned int count)
 
 /* RTC-dependent code for time.c */
 
-static int
-rtc_rx5c348_set_time(unsigned long t)
+int rtc_mips_set_time(unsigned long t)
 {
 	unsigned char inbuf[8];
 	struct rtc_time tm;
@@ -129,8 +128,7 @@ rtc_rx5c348_set_time(unsigned long t)
 	return spi_rtc_io(inbuf, NULL, 8);
 }
 
-static unsigned long
-rtc_rx5c348_get_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned char inbuf[8], outbuf[8];
 	unsigned int year, month, day, hour, minute, second;
@@ -185,8 +183,4 @@ rtc_rx5c348_init(int chipid)
 	spi_rtc_io(inbuf, outbuf, 2);
 	if (outbuf[1] & Rx5C348_BIT_24H)
 		srtc_24h = 1;
-
-	/* set the function pointers */
-	rtc_mips_get_time = rtc_rx5c348_get_time;
-	rtc_mips_set_time = rtc_rx5c348_set_time;
 }
diff --git a/arch/mips/tx4938/common/setup.c b/arch/mips/tx4938/common/setup.c
index 142abf4..ab40822 100644
--- a/arch/mips/tx4938/common/setup.c
+++ b/arch/mips/tx4938/common/setup.c
@@ -34,25 +34,16 @@
 #include <asm/tx4938/rbtx4938.h>
 
 extern void toshiba_rbtx4938_setup(void);
-extern void rbtx4938_time_init(void);
 
 void __init tx4938_setup(void);
-void __init tx4938_time_init(void);
 void dump_cp0(char *key);
 
 void __init
 plat_mem_setup(void)
 {
-	board_time_init = tx4938_time_init;
 	toshiba_rbtx4938_setup();
 }
 
-void __init
-tx4938_time_init(void)
-{
-	rbtx4938_time_init();
-}
-
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	setup_irq(TX4938_IRQ_CPU_TIMER, irq);
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index f5d1ce7..f55117d 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -36,7 +36,6 @@
 #include <linux/serial_core.h>
 #endif
 
-extern void rbtx4938_time_init(void) __init;
 extern char * __init prom_getcmdline(void);
 static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
 
@@ -897,7 +896,8 @@ void tx4938_report_pcic_status(void)
  * interrupt running at 100HZ. */
 
 extern void __init rtc_rx5c348_init(int chipid);
-void __init rbtx4938_time_init(void)
+
+void __init plat_time_init(void)
 {
 	rtc_rx5c348_init(RBTX4938_SRTC_CHIPID);
 	mips_hpt_frequency = txx9_cpu_clock / 2;
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 4f97e0b..407cec2 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -36,7 +36,7 @@ static void __init iomem_resource_init(void)
 	iomem_resource.end = IO_MEM_RESOURCE_END;
 }
 
-static void __init setup_timer_frequency(void)
+void __init plat_time_init(void)
 {
 	unsigned long tclock;
 
@@ -53,16 +53,10 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(TIMER_IRQ, irq);
 }
 
-static void __init timer_init(void)
-{
-	board_time_init = setup_timer_frequency;
-}
-
 void __init plat_mem_setup(void)
 {
 	vr41xx_calculate_clock_frequency();
 
-	timer_init();
 	iomem_resource_init();
 }
 
diff --git a/include/asm-mips/rtc.h b/include/asm-mips/rtc.h
index 82ad401..9da3821 100644
--- a/include/asm-mips/rtc.h
+++ b/include/asm-mips/rtc.h
@@ -1,10 +1,9 @@
 /*
- * include/asm-mips/rtc.h
- *
  * (Really an interface for drivers/char/genrtc.c)
  *
  * Copyright (C) 2004 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
  *
  * Please read the COPYING file for all license details.
  */
@@ -32,7 +31,7 @@ static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	unsigned long nowtime;
 
-	nowtime = rtc_mips_get_time();
+	nowtime = read_persistent_clock();
 	to_tm(nowtime, time);
 	time->tm_year -= 1900;
 
@@ -57,6 +56,7 @@ static inline unsigned int get_rtc_ss(void)
 	struct rtc_time h;
 
 	get_rtc_time(&h);
+
 	return h.tm_sec;
 }
 
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index a632cef..74ab331 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -26,15 +26,13 @@
 extern spinlock_t rtc_lock;
 
 /*
- * RTC ops.  By default, they point to no-RTC functions.
- *	rtc_mips_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
+ * RTC ops.  By default, they point to weak no-op RTC functions.
  *	rtc_mips_set_time - reverse the above translation and set time to RTC.
  *	rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
  *			to be set.  Used by RTC sync-up.
  */
-extern unsigned long (*rtc_mips_get_time)(void);
-extern int (*rtc_mips_set_time)(unsigned long);
-extern int (*rtc_mips_set_mmss)(unsigned long);
+extern int rtc_mips_set_time(unsigned long);
+extern int rtc_mips_set_mmss(unsigned long);
 
 /*
  * Timer interrupt functions.
@@ -75,11 +73,9 @@ extern asmlinkage void ll_local_timer_interrupt(int irq);
 
 /*
  * board specific routines required by time_init().
- * board_time_init is defaulted to NULL and can remain so.
- * plat_timer_setup must be setup properly in machine setup routine.
  */
 struct irqaction;
-extern void (*board_time_init)(void);
+extern void plat_time_init(void);
 extern void plat_timer_setup(struct irqaction *irq);
 
 /*
-- 
1.5.2.1
