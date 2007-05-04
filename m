Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2007 16:35:41 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:54169 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022136AbXEDPfV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 May 2007 16:35:21 +0100
Received: by ug-out-1314.google.com with SMTP id 40so585624uga
        for <linux-mips@linux-mips.org>; Fri, 04 May 2007 08:35:20 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=jXct1Nt4dPMyxV1iLyLJPHOVHuJRVbbmWyJtABDBFTVbmUydY8rt0gV0w5szQjnvna0notS8zUlKpXL6gkAFli+V/GJd2Ezsdp9tZM5gFLrmJgn9HbO9ew/WdMAMLrUU9BBPczzYvtePqnpxpBGj4MM3fnerzbp2Sfbt5nmil1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=X6TWkN7JGwMIE1PtVgfxP1agZeRSOVuEe7OntGhm4RSoWhE6EdckLra/BSv0HyAOYLw95qKtpZQ3aIbTcaA3Ukyf5ZCaQVa+tmOxtY2jtqnkbwLQhJF0SO3CbyF8NWNWfmxyoIttehbxWgqYJDN0Q433WRHSBIfNb5Z/2GPPaRw=
Received: by 10.82.185.12 with SMTP id i12mr6712598buf.1178292920039;
        Fri, 04 May 2007 08:35:20 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z34sm102534ikz.2007.05.04.08.35.16;
        Fri, 04 May 2007 08:35:18 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 99BD323F772; Fri,  4 May 2007 17:36:46 +0200 (CEST)
To:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Date:	Fri,  4 May 2007 17:36:45 +0200
Message-Id: <11782930063123-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <1178293006633-git-send-email-fbuihuu@gmail.com>
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch introduces plat_clk_setup() which is a hook that platforms
can implement to setup clock and mips_hpt_frequency.

This was done by board_time_init function pointer previously.

There are 3 reasons why we should prefer plat_clk_setup() over
board_time_init:

    1/ There's no need for platforms to initialize a function
    pointer anymore.

    2/ board_time_init was previously initialized in plat_mem_setup()
    which is normally used to setup platform's *memories*.

    3/ plat_clk_setup() is called earlier in boot process. Therefore
    others subsystems can get the time during their initialisation,
    timekeeping subsystem is an example.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/au1000/common/setup.c           |    2 --
 arch/mips/au1000/common/time.c            |    4 ----
 arch/mips/basler/excite/excite_setup.c    |    5 +----
 arch/mips/ddb5xxx/ddb5477/setup.c         |    4 +---
 arch/mips/dec/setup.c                     |    3 ---
 arch/mips/dec/time.c                      |    2 +-
 arch/mips/emma2rh/markeins/setup.c        |    4 +---
 arch/mips/gt64120/wrppmc/setup.c          |    4 ----
 arch/mips/gt64120/wrppmc/time.c           |    2 +-
 arch/mips/jmr3927/rbhma3100/setup.c       |    4 +---
 arch/mips/kernel/setup.c                  |   13 +++++++++++++
 arch/mips/kernel/time.c                   |   16 +++-------------
 arch/mips/lasat/setup.c                   |    4 +---
 arch/mips/mips-boards/atlas/atlas_setup.c |    2 --
 arch/mips/mips-boards/generic/time.c      |    2 +-
 arch/mips/mips-boards/malta/malta_setup.c |    2 --
 arch/mips/mips-boards/sead/sead_setup.c   |    4 ----
 arch/mips/mips-boards/sim/sim_setup.c     |    2 --
 arch/mips/mips-boards/sim/sim_time.c      |    2 +-
 arch/mips/momentum/jaguar_atx/setup.c     |    6 +-----
 arch/mips/momentum/ocelot_3/setup.c       |    5 +----
 arch/mips/momentum/ocelot_c/setup.c       |    8 ++------
 arch/mips/momentum/ocelot_g/gt-irq.c      |    2 +-
 arch/mips/momentum/ocelot_g/setup.c       |    3 ---
 arch/mips/philips/pnx8550/common/setup.c  |    3 ---
 arch/mips/philips/pnx8550/common/time.c   |    5 ++---
 arch/mips/pmc-sierra/yosemite/setup.c     |    4 ++--
 arch/mips/sgi-ip22/ip22-time.c            |    4 +---
 arch/mips/sgi-ip27/ip27-init.c            |    3 ---
 arch/mips/sgi-ip27/ip27-timer.c           |    2 +-
 arch/mips/sgi-ip32/ip32-setup.c           |    4 +---
 arch/mips/sibyte/swarm/setup.c            |    3 +--
 arch/mips/sni/pcimt.c                     |    1 -
 arch/mips/sni/pcit.c                      |    1 -
 arch/mips/sni/rm200.c                     |    1 -
 arch/mips/sni/time.c                      |    2 +-
 arch/mips/tx4927/common/tx4927_setup.c    |    5 +----
 arch/mips/tx4938/common/setup.c           |    4 +---
 arch/mips/vr41xx/common/init.c            |    8 +-------
 include/asm-mips/sni.h                    |    3 ---
 40 files changed, 42 insertions(+), 116 deletions(-)

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
index 2f0e4c0..a337e0d 100644
--- a/arch/mips/basler/excite/excite_setup.c
+++ b/arch/mips/basler/excite/excite_setup.c
@@ -67,7 +67,7 @@ DEFINE_SPINLOCK(titan_lock);
 int titan_irqflags;
 
 
-static void excite_timer_init(void)
+void __init plat_clk_setup(void)
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
diff --git a/arch/mips/ddb5xxx/ddb5477/setup.c b/arch/mips/ddb5xxx/ddb5477/setup.c
index f0cc0e8..94aebbb 100644
--- a/arch/mips/ddb5xxx/ddb5477/setup.c
+++ b/arch/mips/ddb5xxx/ddb5477/setup.c
@@ -121,7 +121,7 @@ static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
 	return freq;
 }
 
-static void __init ddb_time_init(void)
+void __init plat_clk_setup(void)
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
index b8a5e75..25b879b 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -146,12 +146,9 @@ static void __init dec_be_init(void)
 }
 
 
-extern void dec_time_init(void);
-
 void __init plat_mem_setup(void)
 {
 	board_be_init = dec_be_init;
-	board_time_init = dec_time_init;
 
 	wbflush_setup();
 
diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 8b7e0c1..47d11a2 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -161,7 +161,7 @@ static cycle_t dec_ioasic_hpt_read(void)
 }
 
 
-void __init dec_time_init(void)
+void __init plat_clk_setup(void)
 {
 	rtc_mips_get_time = dec_rtc_get_time;
 	rtc_mips_set_mmss = dec_rtc_set_mmss;
diff --git a/arch/mips/emma2rh/markeins/setup.c b/arch/mips/emma2rh/markeins/setup.c
index b29a447..2cd8c28 100644
--- a/arch/mips/emma2rh/markeins/setup.c
+++ b/arch/mips/emma2rh/markeins/setup.c
@@ -88,7 +88,7 @@ static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
 	return clock[reg];
 }
 
-static void __init emma2rh_time_init(void)
+void __init plat_clk_setup(void)
 {
 	u32 reg;
 	if (bus_frequency == 0)
@@ -148,8 +148,6 @@ void __init plat_mem_setup(void)
 
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
index 5b44085..dbb8fae 100644
--- a/arch/mips/gt64120/wrppmc/time.c
+++ b/arch/mips/gt64120/wrppmc/time.c
@@ -38,7 +38,7 @@ void __init plat_timer_setup(struct irqaction *irq)
  * NOTE: We disable all GT64120 timers, and use MIPS processor internal
  * timer as the source of kernel clock tick.
  */
-void __init wrppmc_time_init(void)
+void __init plat_clk_setup(void)
 {
 	/* Disable GT64120 timers */
 	GT_WRITE(GT_TC_CONTROL_OFS, 0x00);
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 8303001..8c4a988 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -109,7 +109,7 @@ static void jmr3927_timer_ack(void)
 	jmr3927_tmrptr->tisr = 0;       /* ack interrupt */
 }
 
-static void __init jmr3927_time_init(void)
+void __init plat_clk_setup(void)
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
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4975da0..6cdd596 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -521,6 +521,18 @@ static void __init resource_init(void)
 	}
 }
 
+/*
+ * plat_clk_setup() -- optional
+ *
+ *      a) set up RTC routines,
+ *      b) calibrate and set the mips_hpt_frequency (only needed if
+ *         you intended to use cpu counter as timer interrupt source)
+ */
+void __init __weak plat_clk_setup(void)
+{
+	return;
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -549,6 +561,7 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_SMP
 	plat_smp_setup();
 #endif
+	plat_clk_setup();
 }
 
 static int __init fpu_disable(char *s)
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 751b4a1..5a4fd06 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -239,21 +239,14 @@ asmlinkage void ll_local_timer_interrupt(int irq)
 /*
  * time_init() - it does the following things.
  *
- * 1) board_time_init() -
- * 	a) (optional) set up RTC routines,
- *      b) (optional) calibrate and set the mips_hpt_frequency
- *	    (only needed if you intended to use cpu counter as timer interrupt
- *	     source)
- * 2) setup xtime based on rtc_mips_get_time().
- * 3) calculate a couple of cached variables for later usage
- * 4) plat_timer_setup() -
+ * 1) setup xtime based on rtc_mips_get_time().
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
@@ -335,9 +328,6 @@ static void __init init_mips_clocksource(void)
 
 void __init time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
-
 	if (!rtc_mips_set_mmss)
 		rtc_mips_set_mmss = rtc_mips_set_time;
 
diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
index 488007f..1b3221c 100644
--- a/arch/mips/lasat/setup.c
+++ b/arch/mips/lasat/setup.c
@@ -109,7 +109,7 @@ static struct notifier_block lasat_panic_block[] =
 	{ lasat_panic_prom_monitor, NULL, INT_MIN }
 };
 
-static void lasat_time_init(void)
+void __init plat_clk_setup(void)
 {
 	mips_hpt_frequency = lasat_board_info.li_cpu_hz / 2;
 }
@@ -164,8 +164,6 @@ void __init plat_mem_setup(void)
 
 	lasat_reboot_setup();
 
-	board_time_init = lasat_time_init;
-
 #ifdef CONFIG_DS1603
 	ds1603 = &ds_defs[mips_machtype];
 	rtc_mips_get_time = ds1603_read;
diff --git a/arch/mips/mips-boards/atlas/atlas_setup.c b/arch/mips/mips-boards/atlas/atlas_setup.c
index 0c6b0ce..cc4057e 100644
--- a/arch/mips/mips-boards/atlas/atlas_setup.c
+++ b/arch/mips/mips-boards/atlas/atlas_setup.c
@@ -34,7 +34,6 @@
 #include <asm/traps.h>
 
 extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
 extern unsigned long mips_rtc_get_time(void);
 
 #ifdef CONFIG_KGDB
@@ -61,7 +60,6 @@ void __init plat_mem_setup(void)
 #endif
 	mips_reboot_setup();
 
-	board_time_init = mips_time_init;
 	rtc_mips_get_time = mips_rtc_get_time;
 }
 
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index df2a2bd..d24ffe9 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -249,7 +249,7 @@ unsigned long __init mips_rtc_get_time(void)
 	return mc146818_get_cmos_time();
 }
 
-void __init mips_time_init(void)
+void __init plat_clk_setup(void)
 {
 	unsigned int est_freq;
 
diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 7873932..2602131 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -36,7 +36,6 @@
 #endif
 
 extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
 extern unsigned long mips_rtc_get_time(void);
 
 #ifdef CONFIG_KGDB
@@ -182,6 +181,5 @@ void __init plat_mem_setup(void)
 #endif
 	mips_reboot_setup();
 
-	board_time_init = mips_time_init;
 	rtc_mips_get_time = mips_rtc_get_time;
 }
diff --git a/arch/mips/mips-boards/sead/sead_setup.c b/arch/mips/mips-boards/sead/sead_setup.c
index a189dec..ad52e14 100644
--- a/arch/mips/mips-boards/sead/sead_setup.c
+++ b/arch/mips/mips-boards/sead/sead_setup.c
@@ -34,8 +34,6 @@
 #include <asm/time.h>
 
 extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
-
 static void __init serial_init(void);
 
 const char *get_system_type(void)
@@ -49,8 +47,6 @@ void __init plat_mem_setup(void)
 
 	serial_init ();
 
-	board_time_init = mips_time_init;
-
 	mips_reboot_setup();
 }
 
diff --git a/arch/mips/mips-boards/sim/sim_setup.c b/arch/mips/mips-boards/sim/sim_setup.c
index b705f09..58c427a 100644
--- a/arch/mips/mips-boards/sim/sim_setup.c
+++ b/arch/mips/mips-boards/sim/sim_setup.c
@@ -36,7 +36,6 @@
 #include <asm/mips-boards/simint.h>
 
 
-extern void sim_time_init(void);
 static void __init serial_init(void);
 unsigned int _isbonito = 0;
 
@@ -54,7 +53,6 @@ void __init plat_mem_setup(void)
 
 	serial_init();
 
-	board_time_init = sim_time_init;
 	pr_info("Linux started...\n");
 
 #ifdef CONFIG_MIPS_MT_SMP
diff --git a/arch/mips/mips-boards/sim/sim_time.c b/arch/mips/mips-boards/sim/sim_time.c
index d3a21c7..2dcda66 100644
--- a/arch/mips/mips-boards/sim/sim_time.c
+++ b/arch/mips/mips-boards/sim/sim_time.c
@@ -146,7 +146,7 @@ static unsigned int __init estimate_cpu_frequency(void)
 	return count;
 }
 
-void __init sim_time_init(void)
+void __init plat_clk_setup(void)
 {
 	unsigned int est_freq, flags;
 
diff --git a/arch/mips/momentum/jaguar_atx/setup.c b/arch/mips/momentum/jaguar_atx/setup.c
index 5a51014..14ed3f5 100644
--- a/arch/mips/momentum/jaguar_atx/setup.c
+++ b/arch/mips/momentum/jaguar_atx/setup.c
@@ -75,8 +75,6 @@ extern void momenco_jaguar_restart(char *command);
 extern void momenco_jaguar_halt(void);
 extern void momenco_jaguar_power_off(void);
 
-void momenco_time_init(void);
-
 static char reset_reason;
 
 static inline unsigned long ENTRYLO(unsigned long paddr)
@@ -220,7 +218,7 @@ void __init plat_timer_setup(struct irqaction *irq)
  * Ugly but the least of all evils.  TLB initialization did flush the TLB so
  * We need to setup mappings again before we can touch the RTC.
  */
-void momenco_time_init(void)
+void __init plat_clk_setup(void)
 {
 	wire_stupidity_into_tlb();
 
@@ -360,8 +358,6 @@ void __init plat_mem_setup(void)
 {
 	unsigned int tmpword;
 
-	board_time_init = momenco_time_init;
-
 	_machine_restart = momenco_jaguar_restart;
 	_machine_halt = momenco_jaguar_halt;
 	pm_power_off = momenco_jaguar_power_off;
diff --git a/arch/mips/momentum/ocelot_3/setup.c b/arch/mips/momentum/ocelot_3/setup.c
index ff0829f..7191dc4 100644
--- a/arch/mips/momentum/ocelot_3/setup.c
+++ b/arch/mips/momentum/ocelot_3/setup.c
@@ -98,7 +98,6 @@ extern void momenco_ocelot_restart(char *command);
 extern void momenco_ocelot_halt(void);
 extern void momenco_ocelot_power_off(void);
 
-void momenco_time_init(void);
 static char reset_reason;
 
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
@@ -201,7 +200,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(7, irq);	/* Timer interrupt, unmask status IM7 */
 }
 
-void momenco_time_init(void)
+void __init plat_clk_setup(void)
 {
 	setup_wired_tlb_entries();
 
@@ -315,8 +314,6 @@ void __init plat_mem_setup(void)
 {
 	unsigned int tmpword;
 
-	board_time_init = momenco_time_init;
-
 	_machine_restart = momenco_ocelot_restart;
 	_machine_halt = momenco_ocelot_halt;
 	pm_power_off = momenco_ocelot_power_off;
diff --git a/arch/mips/momentum/ocelot_c/setup.c b/arch/mips/momentum/ocelot_c/setup.c
index 0b6b233..8e083c8 100644
--- a/arch/mips/momentum/ocelot_c/setup.c
+++ b/arch/mips/momentum/ocelot_c/setup.c
@@ -76,8 +76,6 @@ extern void momenco_ocelot_restart(char *command);
 extern void momenco_ocelot_halt(void);
 extern void momenco_ocelot_power_off(void);
 
-void momenco_time_init(void);
-
 static char reset_reason;
 
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1, unsigned long entryhi, unsigned long pagemask);
@@ -210,7 +208,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(7, irq);
 }
 
-void momenco_time_init(void)
+void __init plat_clk_setup(void)
 {
 #ifdef CONFIG_CPU_SR71000
 	mips_hpt_frequency = cpu_clock;
@@ -219,7 +217,7 @@ void momenco_time_init(void)
 #else
 #error Unknown CPU for this board
 #endif
-	printk("momenco_time_init cpu_clock=%d\n", cpu_clock);
+	printk("%s cpu_clock=%d\n", __FUNCTION__, cpu_clock);
 
 	rtc_mips_get_time = m48t37y_get_time;
 	rtc_mips_set_time = m48t37y_set_time;
@@ -229,8 +227,6 @@ void __init plat_mem_setup(void)
 {
 	unsigned int tmpword;
 
-	board_time_init = momenco_time_init;
-
 	_machine_restart = momenco_ocelot_restart;
 	_machine_halt = momenco_ocelot_halt;
 	pm_power_off = momenco_ocelot_power_off;
diff --git a/arch/mips/momentum/ocelot_g/gt-irq.c b/arch/mips/momentum/ocelot_g/gt-irq.c
index e5576bd..8b06f4f 100644
--- a/arch/mips/momentum/ocelot_g/gt-irq.c
+++ b/arch/mips/momentum/ocelot_g/gt-irq.c
@@ -156,7 +156,7 @@ static irqreturn_t gt64240_p0int_irq(int irq, void *dev)
  * that is passed in as *irq (=irq0 in ../kernel/time.c).
  * We will do our own timer interrupt handling.
  */
-void gt64240_time_init(void)
+void plat_clk_setup(void)
 {
 	static struct irqaction timer;
 
diff --git a/arch/mips/momentum/ocelot_g/setup.c b/arch/mips/momentum/ocelot_g/setup.c
index 9db638a..b0513cc 100644
--- a/arch/mips/momentum/ocelot_g/setup.c
+++ b/arch/mips/momentum/ocelot_g/setup.c
@@ -75,7 +75,6 @@ extern void momenco_ocelot_restart(char *command);
 extern void momenco_ocelot_halt(void);
 extern void momenco_ocelot_power_off(void);
 
-extern void gt64240_time_init(void);
 extern void momenco_ocelot_irq_setup(void);
 
 static char reset_reason;
@@ -170,8 +169,6 @@ void __init plat_mem_setup(void)
 	void (*l3func)(unsigned long) = (void *) KSEG1ADDR(setup_l3cache);
 	unsigned int tmpword;
 
-	board_time_init = gt64240_time_init;
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
index 68def38..0e1ae35 100644
--- a/arch/mips/philips/pnx8550/common/time.c
+++ b/arch/mips/philips/pnx8550/common/time.c
@@ -46,16 +46,15 @@ static void timer_ack(void)
 }
 
 /*
- * pnx8550_time_init() - it does the following things:
+ * plat_clk_setup() - it does the following things:
  *
- * 1) board_time_init() -
  * 	a) (optional) set up RTC routines,
  *      b) (optional) calibrate and set the mips_hpt_frequency
  *	    (only needed if you intended to use cpu counter as timer interrupt
  *	     source)
  */
 
-void pnx8550_time_init(void)
+void __init plat_clk_setup(void)
 {
 	unsigned int             n;
 	unsigned int             m;
diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
index 6a6e15e..ceae27c 100644
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -137,8 +137,9 @@ void __init plat_timer_setup(struct irqaction *irq)
 	setup_irq(7, irq);
 }
 
-void yosemite_time_init(void)
+void __init plat_clk_setup(void)
 {
+	/* FIXME: what's this code is doing ? */
 	mips_hpt_frequency = cpu_clock / 2;
 mips_hpt_frequency = 33000000 * 3 * 5;
 }
@@ -220,7 +221,6 @@ static void __init py_late_time_init(void)
 
 void __init plat_mem_setup(void)
 {
-	board_time_init = yosemite_time_init;
 	late_time_init = py_late_time_init;
 
 	/* Add memory regions */
diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 8e88a44..202fe80 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -128,7 +128,7 @@ static unsigned long dosample(void)
 /*
  * Here we need to calibrate the cycle counter to at least be close.
  */
-static __init void indy_time_init(void)
+void __init plat_clk_setup(void)
 {
 	unsigned long r4k_ticks[3];
 	unsigned long r4k_tick;
@@ -213,6 +213,4 @@ void __init ip22_time_init(void)
 	/* setup hookup functions */
 	rtc_mips_get_time = indy_rtc_get_time;
 	rtc_mips_set_time = indy_rtc_set_time;
-
-	board_time_init = indy_time_init;
 }
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
index 8c3c78c..d7740c4 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -223,7 +223,7 @@ static cycle_t ip27_hpt_read(void)
 	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
 }
 
-void __init ip27_time_init(void)
+void __init plat_clk_setup(void)
 {
 	clocksource_mips.read = ip27_hpt_read;
 	mips_hpt_frequency = CYCLES_PER_SEC;
diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
index 57708fe..0910b84 100644
--- a/arch/mips/sgi-ip32/ip32-setup.c
+++ b/arch/mips/sgi-ip32/ip32-setup.c
@@ -71,7 +71,7 @@ static inline void str2eaddr(unsigned char *ea, unsigned char *str)
 /* An arbitrary time; this can be decreased if reliability looks good */
 #define WAIT_MS 10
 
-void __init ip32_time_init(void)
+void __init plat_clk_setup(void)
 {
 	printk(KERN_INFO "Calibrating system timer... ");
 	write_c0_count(0);
@@ -94,8 +94,6 @@ void __init plat_mem_setup(void)
 	rtc_mips_get_time = mc146818_get_cmos_time;
 	rtc_mips_set_mmss = mc146818_set_rtc_mmss;
 
-	board_time_init = ip32_time_init;
-
 #ifdef CONFIG_SERIAL_8250
 	{
 		static struct uart_port o2_serial[2];
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 83572d8..93f8d14 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -69,7 +69,7 @@ const char *get_system_type(void)
 	return "SiByte " SIBYTE_BOARD_NAME;
 }
 
-void __init swarm_time_init(void)
+void __init plat_clk_setup(void)
 {
 #if defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	/* Setup HPT */
@@ -116,7 +116,6 @@ void __init plat_mem_setup(void)
 
 	panic_timeout = 5;  /* For debug.  */
 
-	board_time_init = swarm_time_init;
 	board_be_handler = swarm_be_handler;
 
 	if (xicor_probe()) {
diff --git a/arch/mips/sni/pcimt.c b/arch/mips/sni/pcimt.c
index 9ee208d..ba04719 100644
--- a/arch/mips/sni/pcimt.c
+++ b/arch/mips/sni/pcimt.c
@@ -280,7 +280,6 @@ void sni_pcimt_init(void)
 	sni_pcimt_sc_init();
 	rtc_mips_get_time = mc146818_get_cmos_time;
 	rtc_mips_set_time = mc146818_set_rtc_mmss;
-	board_time_init = sni_cpu_time_init;
 	ioport_resource.end = sni_io_resource.end;
 #ifdef CONFIG_PCI
 	PCIBIOS_MIN_IO = 0x9000;
diff --git a/arch/mips/sni/pcit.c b/arch/mips/sni/pcit.c
index 00d151f..4d722ae 100644
--- a/arch/mips/sni/pcit.c
+++ b/arch/mips/sni/pcit.c
@@ -247,7 +247,6 @@ void sni_pcit_init(void)
 {
 	rtc_mips_get_time = mc146818_get_cmos_time;
 	rtc_mips_set_time = mc146818_set_rtc_mmss;
-	board_time_init = sni_cpu_time_init;
 	ioport_resource.end = sni_io_resource.end;
 #ifdef CONFIG_PCI
 	PCIBIOS_MIN_IO = 0x9000;
diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
index b82ff12..2421441 100644
--- a/arch/mips/sni/rm200.c
+++ b/arch/mips/sni/rm200.c
@@ -182,5 +182,4 @@ void sni_rm200_init(void)
 	ioport_resource.end += 0x02000000;
 	ds1216_base = (volatile unsigned char *) SNI_DS1216_RM200_BASE;
 	rtc_mips_get_time = ds1216_get_cmos_time;
-	board_time_init = sni_cpu_time_init;
 }
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 20028fc..85b4986 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -71,7 +71,7 @@ static __init unsigned long dosample(void)
 /*
  * Here we need to calibrate the cycle counter to at least be close.
  */
-__init void sni_cpu_time_init(void)
+void __init plat_clk_setup(void)
 {
 	unsigned long r4k_ticks[3];
 	unsigned long r4k_tick;
diff --git a/arch/mips/tx4927/common/tx4927_setup.c b/arch/mips/tx4927/common/tx4927_setup.c
index c8e49fe..60f594c 100644
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
@@ -65,7 +62,7 @@ void __init plat_mem_setup(void)
 #endif
 }
 
-void __init tx4927_time_init(void)
+void __init plat_clk_setup(void)
 {
 
 #ifdef CONFIG_TOSHIBA_RBTX4927
diff --git a/arch/mips/tx4938/common/setup.c b/arch/mips/tx4938/common/setup.c
index 142abf4..e7f2dfc 100644
--- a/arch/mips/tx4938/common/setup.c
+++ b/arch/mips/tx4938/common/setup.c
@@ -37,18 +37,16 @@ extern void toshiba_rbtx4938_setup(void);
 extern void rbtx4938_time_init(void);
 
 void __init tx4938_setup(void);
-void __init tx4938_time_init(void);
 void dump_cp0(char *key);
 
 void __init
 plat_mem_setup(void)
 {
-	board_time_init = tx4938_time_init;
 	toshiba_rbtx4938_setup();
 }
 
 void __init
-tx4938_time_init(void)
+plat_clk_setup(void)
 {
 	rbtx4938_time_init();
 }
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 4f97e0b..14ac696 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -36,7 +36,7 @@ static void __init iomem_resource_init(void)
 	iomem_resource.end = IO_MEM_RESOURCE_END;
 }
 
-static void __init setup_timer_frequency(void)
+void __init plat_clk_setup(void)
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
 
diff --git a/include/asm-mips/sni.h b/include/asm-mips/sni.h
index f257509..5667797 100644
--- a/include/asm-mips/sni.h
+++ b/include/asm-mips/sni.h
@@ -209,9 +209,6 @@ extern void sni_pcit_cplus_irq_init (void);
 extern void sni_rm200_irq_init (void);
 extern void sni_pcimt_irq_init (void);
 
-/* timer inits */
-extern void sni_cpu_time_init(void);
-
 /* common irq stuff */
 extern void (*sni_hwint)(void);
 extern struct irqaction sni_isa_irq;
-- 
1.5.1.3
