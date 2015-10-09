Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2015 23:58:10 +0200 (CEST)
Received: from unicorn.mansr.com ([81.2.72.234]:50500 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010418AbbJIV6Hxse1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Oct 2015 23:58:07 +0200
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 41AA21538A; Fri,  9 Oct 2015 22:57:59 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Russell King <linux@arm.linux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Carlo Caione <carlo@caione.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Barry Song <baohua@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] sched_clock: add data pointer argument to read callback
Date:   Fri,  9 Oct 2015 22:57:35 +0100
Message-Id: <1444427858-576-1-git-send-email-mans@mansr.com>
X-Mailer: git-send-email 2.5.3
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This passes a data pointer specified in the sched_clock_register()
call to the read callback allowing simpler implementations thereof.

In this patch, existing uses of this interface are simply updated
with a null pointer.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-davinci/time.c              |  4 ++--
 arch/arm/mach-ep93xx/timer-ep93xx.c       |  4 ++--
 arch/arm/mach-footbridge/dc21285-timer.c  |  4 ++--
 arch/arm/mach-gemini/time.c               |  4 ++--
 arch/arm/mach-integrator/integrator_cp.c  |  4 ++--
 arch/arm/mach-ixp4xx/common.c             |  5 +++--
 arch/arm/mach-mmp/time.c                  |  4 ++--
 arch/arm/mach-omap1/time.c                |  4 ++--
 arch/arm/mach-omap2/timer.c               |  4 ++--
 arch/arm/plat-iop/time.c                  |  4 ++--
 arch/arm/plat-omap/counter_32k.c          |  4 ++--
 arch/arm/plat-orion/time.c                |  4 ++--
 arch/arm/plat-versatile/sched-clock.c     |  4 ++--
 arch/cris/arch-v32/kernel/time.c          |  4 ++--
 arch/microblaze/kernel/timer.c            |  4 ++--
 arch/mips/jz4740/time.c                   |  4 ++--
 arch/mips/kernel/cevt-txx9.c              |  4 ++--
 arch/mips/kernel/csrc-bcm1480.c           |  4 ++--
 arch/mips/kernel/csrc-ioasic.c            |  4 ++--
 arch/mips/kernel/csrc-r4k.c               |  5 +++--
 arch/mips/kernel/csrc-sb1250.c            |  5 +++--
 arch/mips/sgi-ip27/ip27-timer.c           |  4 ++--
 arch/xtensa/kernel/time.c                 |  4 ++--
 drivers/clocksource/arm_arch_timer.c      |  8 +++++++-
 drivers/clocksource/arm_global_timer.c    |  4 ++--
 drivers/clocksource/bcm2835_timer.c       |  4 ++--
 drivers/clocksource/cadence_ttc_timer.c   |  4 ++--
 drivers/clocksource/clksrc-dbx500-prcmu.c |  4 ++--
 drivers/clocksource/clksrc_st_lpc.c       |  4 ++--
 drivers/clocksource/clps711x-timer.c      |  4 ++--
 drivers/clocksource/dw_apb_timer_of.c     |  4 ++--
 drivers/clocksource/exynos_mct.c          |  4 ++--
 drivers/clocksource/fsl_ftm_timer.c       |  5 +++--
 drivers/clocksource/meson6_timer.c        |  4 ++--
 drivers/clocksource/mxs_timer.c           |  4 ++--
 drivers/clocksource/nomadik-mtu.c         |  4 ++--
 drivers/clocksource/pxa_timer.c           |  4 ++--
 drivers/clocksource/qcom-timer.c          |  4 ++--
 drivers/clocksource/samsung_pwm_timer.c   |  4 ++--
 drivers/clocksource/sun4i_timer.c         |  4 ++--
 drivers/clocksource/tegra20_timer.c       |  4 ++--
 drivers/clocksource/time-armada-370-xp.c  |  5 +++--
 drivers/clocksource/time-lpc32xx.c        |  4 ++--
 drivers/clocksource/time-orion.c          |  5 +++--
 drivers/clocksource/time-pistachio.c      |  4 ++--
 drivers/clocksource/timer-digicolor.c     |  4 ++--
 drivers/clocksource/timer-imx-gpt.c       |  4 ++--
 drivers/clocksource/timer-integrator-ap.c |  4 ++--
 drivers/clocksource/timer-prima2.c        |  5 +++--
 drivers/clocksource/timer-sp804.c         |  4 ++--
 drivers/clocksource/timer-u300.c          |  4 ++--
 drivers/clocksource/versatile.c           |  4 ++--
 drivers/clocksource/vf_pit_timer.c        |  4 ++--
 include/linux/sched_clock.h               |  4 ++--
 kernel/time/sched_clock.c                 | 32 +++++++++++++++++++------------
 55 files changed, 140 insertions(+), 119 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 6c18445..ccc29e97 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -285,7 +285,7 @@ static struct clocksource clocksource_davinci = {
 /*
  * Overwrite weak default sched_clock with something more precise
  */
-static u64 notrace davinci_read_sched_clock(void)
+static u64 notrace davinci_read_sched_clock(void *data)
 {
 	return timer32_read(&timers[TID_CLOCKSOURCE]);
 }
@@ -397,7 +397,7 @@ void __init davinci_timer_init(void)
 		       clocksource_davinci.name);
 
 	sched_clock_register(davinci_read_sched_clock, 32,
-			  davinci_clock_tick_rate);
+			  davinci_clock_tick_rate, NULL);
 
 	/* setup clockevent */
 	clockevent_davinci.name = id_to_name[timers[TID_CLOCKEVENT].id];
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index e5f7911..bf3f285 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -50,7 +50,7 @@
 #define EP93XX_TIMER123_RATE		508469
 #define EP93XX_TIMER4_RATE		983040
 
-static u64 notrace ep93xx_read_sched_clock(void)
+static u64 notrace ep93xx_read_sched_clock(void *data)
 {
 	u64 ret;
 
@@ -132,7 +132,7 @@ void __init ep93xx_timer_init(void)
 			      EP93XX_TIMER4_RATE, 200, 40,
 			      ep93xx_clocksource_read);
 	sched_clock_register(ep93xx_read_sched_clock, 40,
-			     EP93XX_TIMER4_RATE);
+			     EP93XX_TIMER4_RATE, NULL);
 
 	/* Set up clockevent on timer 3 */
 	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 810edc7..ebc9468 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -123,7 +123,7 @@ void __init footbridge_timer_init(void)
 	clockevents_config_and_register(ce, rate, 0x4, 0xffffff);
 }
 
-static u64 notrace footbridge_read_sched_clock(void)
+static u64 notrace footbridge_read_sched_clock(void *data)
 {
 	return ~*CSR_TIMER3_VALUE;
 }
@@ -136,5 +136,5 @@ void __init footbridge_sched_clock(void)
 	*CSR_TIMER3_CLR = 0;
 	*CSR_TIMER3_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_DIV16;
 
-	sched_clock_register(footbridge_read_sched_clock, 24, rate);
+	sched_clock_register(footbridge_read_sched_clock, 24, rate, NULL);
 }
diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index f5f18df..19d5b12 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -63,7 +63,7 @@
 
 static unsigned int tick_rate;
 
-static u64 notrace gemini_read_sched_clock(void)
+static u64 notrace gemini_read_sched_clock(void *data)
 {
 	return readl(TIMER_COUNT(TIMER3_BASE));
 }
@@ -222,7 +222,7 @@ void __init gemini_timer_init(void)
 	clocksource_mmio_init(TIMER_COUNT(TIMER3_BASE),
 			      "gemini_clocksource", tick_rate,
 			      300, 32, clocksource_mmio_readl_up);
-	sched_clock_register(gemini_read_sched_clock, 32, tick_rate);
+	sched_clock_register(gemini_read_sched_clock, 32, tick_rate, NULL);
 
 	/*
 	 * Setup clockevent timer (interrupt-driven.)
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index b5fb71a..2e1e856 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -223,14 +223,14 @@ static struct clcd_board clcd_data = {
 
 #define REFCOUNTER (__io_address(INTEGRATOR_HDR_BASE) + 0x28)
 
-static u64 notrace intcp_read_sched_clock(void)
+static u64 notrace intcp_read_sched_clock(void *data)
 {
 	return readl(REFCOUNTER);
 }
 
 static void __init intcp_init_early(void)
 {
-	sched_clock_register(intcp_read_sched_clock, 32, 24000000);
+	sched_clock_register(intcp_read_sched_clock, 32, 24000000, NULL);
 }
 
 static void __init intcp_init_irq_of(void)
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 1cb6f2f..16809a3 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -484,7 +484,7 @@ void __init ixp4xx_sys_init(void)
 /*
  * sched_clock()
  */
-static u64 notrace ixp4xx_read_sched_clock(void)
+static u64 notrace ixp4xx_read_sched_clock(void *data)
 {
 	return *IXP4XX_OSTS;
 }
@@ -502,7 +502,8 @@ unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	sched_clock_register(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
+	sched_clock_register(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq,
+			NULL);
 
 	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 			ixp4xx_clocksource_read);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index dbc697b..20cd15f 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -67,7 +67,7 @@ static inline uint32_t timer_read(void)
 	return __raw_readl(mmp_timer_base + TMR_CVWR(1));
 }
 
-static u64 notrace mmp_read_sched_clock(void)
+static u64 notrace mmp_read_sched_clock(void *data)
 {
 	return timer_read();
 }
@@ -194,7 +194,7 @@ void __init timer_init(int irq)
 {
 	timer_config();
 
-	sched_clock_register(mmp_read_sched_clock, 32, MMP_CLOCK_FREQ);
+	sched_clock_register(mmp_read_sched_clock, 32, MMP_CLOCK_FREQ, NULL);
 
 	ckevt.cpumask = cpumask_of(0);
 
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 524977a..32e4f1e 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -178,7 +178,7 @@ static __init void omap_init_mpu_timer(unsigned long rate)
  * ---------------------------------------------------------------------------
  */
 
-static u64 notrace omap_mpu_read_sched_clock(void)
+static u64 notrace omap_mpu_read_sched_clock(void *data)
 {
 	return ~omap_mpu_timer_read(1);
 }
@@ -190,7 +190,7 @@ static void __init omap_init_clocksource(unsigned long rate)
 			"%s: can't register clocksource!\n";
 
 	omap_mpu_timer_start(1, ~0, 1);
-	sched_clock_register(omap_mpu_read_sched_clock, 32, rate);
+	sched_clock_register(omap_mpu_read_sched_clock, 32, rate, NULL);
 
 	if (clocksource_mmio_init(&timer->read_tim, "mpu_timer2", rate,
 			300, 32, clocksource_mmio_readl_down))
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a556551..af52e10 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -374,7 +374,7 @@ static struct clocksource clocksource_gpt = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace dmtimer_read_sched_clock(void)
+static u64 notrace dmtimer_read_sched_clock(void *data)
 {
 	if (clksrc.reserved)
 		return __omap_dm_timer_read_counter(&clksrc,
@@ -466,7 +466,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	__omap_dm_timer_load_start(&clksrc,
 				   OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0,
 				   OMAP_TIMER_NONPOSTED);
-	sched_clock_register(dmtimer_read_sched_clock, 32, clksrc.rate);
+	sched_clock_register(dmtimer_read_sched_clock, 32, clksrc.rate, NULL);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 101e8f2..e5818f5 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -54,7 +54,7 @@ static struct clocksource iop_clocksource = {
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-static u64 notrace iop_read_sched_clock(void)
+static u64 notrace iop_read_sched_clock(void *data)
 {
 	return 0xffffffffu - read_tcr1();
 }
@@ -158,7 +158,7 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
 
-	sched_clock_register(iop_read_sched_clock, 32, tick_rate);
+	sched_clock_register(iop_read_sched_clock, 32, tick_rate, NULL);
 
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	iop_tick_rate = tick_rate;
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2438b96..480fb00 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -38,7 +38,7 @@
  */
 static void __iomem *sync32k_cnt_reg;
 
-static u64 notrace omap_32k_read_sched_clock(void)
+static u64 notrace omap_32k_read_sched_clock(void *data)
 {
 	return sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
 }
@@ -109,7 +109,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 		return ret;
 	}
 
-	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	sched_clock_register(omap_32k_read_sched_clock, 32, 32768, NULL);
 	register_persistent_clock(NULL, omap_read_persistent_clock64);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 8085a8a..bbb5bf0 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -61,7 +61,7 @@ static u32 ticks_per_jiffy;
  * at least 7.5ns (133MHz TCLK).
  */
 
-static u64 notrace orion_read_sched_clock(void)
+static u64 notrace orion_read_sched_clock(void *data)
 {
 	return ~readl(timer_base + TIMER0_VAL_OFF);
 }
@@ -205,7 +205,7 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
-	sched_clock_register(orion_read_sched_clock, 32, tclk);
+	sched_clock_register(orion_read_sched_clock, 32, tclk, NULL);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index c966ae9..e71f787 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -26,7 +26,7 @@
 
 static void __iomem *ctr;
 
-static u64 notrace versatile_read_sched_clock(void)
+static u64 notrace versatile_read_sched_clock(void *data)
 {
 	if (ctr)
 		return readl(ctr);
@@ -37,5 +37,5 @@ static u64 notrace versatile_read_sched_clock(void)
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long rate)
 {
 	ctr = reg;
-	sched_clock_register(versatile_read_sched_clock, 32, rate);
+	sched_clock_register(versatile_read_sched_clock, 32, rate, NULL);
 }
diff --git a/arch/cris/arch-v32/kernel/time.c b/arch/cris/arch-v32/kernel/time.c
index d2a8440..efd4e38 100644
--- a/arch/cris/arch-v32/kernel/time.c
+++ b/arch/cris/arch-v32/kernel/time.c
@@ -245,7 +245,7 @@ static struct irqaction irq_timer = {
 	.dev_id = &crisv32_clockevent,
 };
 
-static u64 notrace crisv32_timer_sched_clock(void)
+static u64 notrace crisv32_timer_sched_clock(void *data)
 {
 	return REG_RD(timer, timer_base, r_time);
 }
@@ -284,7 +284,7 @@ void __init time_init(void)
 	crisv32_timer_init();
 
 	sched_clock_register(crisv32_timer_sched_clock, 32,
-			     CRISV32_TIMER_FREQ);
+			     CRISV32_TIMER_FREQ, NULL);
 
 	clocksource_mmio_init(timer_base + REG_RD_ADDR_timer_r_time,
 			      "crisv32-timer", CRISV32_TIMER_FREQ,
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index 67e2ef4..d408c83c 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -183,7 +183,7 @@ static __init void xilinx_clockevent_init(void)
 	clockevents_register_device(&clockevent_xilinx_timer);
 }
 
-static u64 xilinx_clock_read(void)
+static u64 xilinx_clock_read(void *data)
 {
 	return read_fn(timer_baseaddr + TCR1);
 }
@@ -304,7 +304,7 @@ static void __init xilinx_timer_init(struct device_node *timer)
 	xilinx_clocksource_init();
 	xilinx_clockevent_init();
 
-	sched_clock_register(xilinx_clock_read, 32, timer_clock_freq);
+	sched_clock_register(xilinx_clock_read, 32, timer_clock_freq, NULL);
 }
 
 CLOCKSOURCE_OF_DECLARE(xilinx_timer, "xlnx,xps-timer-1.00.a",
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 1f7ca2c..ada4d47 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -47,7 +47,7 @@ static struct clocksource jz4740_clocksource = {
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace jz4740_read_sched_clock(void)
+static u64 notrace jz4740_read_sched_clock(void *data)
 {
 	return jz4740_timer_get_count(TIMER_CLOCKSOURCE);
 }
@@ -155,7 +155,7 @@ void __init plat_time_init(void)
 	if (ret)
 		printk(KERN_ERR "Failed to register clocksource: %d\n", ret);
 
-	sched_clock_register(jz4740_read_sched_clock, 16, clk_rate);
+	sched_clock_register(jz4740_read_sched_clock, 16, clk_rate, NULL);
 
 	setup_irq(jz4740_clockevent.irq, &timer_irqaction);
 
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 537eefd..b319711 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -47,7 +47,7 @@ static struct txx9_clocksource txx9_clocksource = {
 	},
 };
 
-static u64 notrace txx9_read_sched_clock(void)
+static u64 notrace txx9_read_sched_clock(void *data)
 {
 	return __raw_readl(&txx9_clocksource.tmrptr->trr);
 }
@@ -69,7 +69,7 @@ void __init txx9_clocksource_init(unsigned long baseaddr,
 	txx9_clocksource.tmrptr = tmrptr;
 
 	sched_clock_register(txx9_read_sched_clock, TXX9_CLOCKSOURCE_BITS,
-			     TIMER_CLK(imbusclk));
+			     TIMER_CLK(imbusclk), NULL);
 }
 
 struct txx9_clock_event_device {
diff --git a/arch/mips/kernel/csrc-bcm1480.c b/arch/mips/kernel/csrc-bcm1480.c
index 7f65b53..bdbd4ee 100644
--- a/arch/mips/kernel/csrc-bcm1480.c
+++ b/arch/mips/kernel/csrc-bcm1480.c
@@ -38,7 +38,7 @@ struct clocksource bcm1480_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace sb1480_read_sched_clock(void)
+static u64 notrace sb1480_read_sched_clock(void *data)
 {
 	return __raw_readq(IOADDR(A_SCD_ZBBUS_CYCLE_COUNT));
 }
@@ -53,5 +53,5 @@ void __init sb1480_clocksource_init(void)
 	zbbus = ((plldiv >> 1) * 50000000) + ((plldiv & 1) * 25000000);
 	clocksource_register_hz(cs, zbbus);
 
-	sched_clock_register(sb1480_read_sched_clock, 64, zbbus);
+	sched_clock_register(sb1480_read_sched_clock, 64, zbbus, NULL);
 }
diff --git a/arch/mips/kernel/csrc-ioasic.c b/arch/mips/kernel/csrc-ioasic.c
index 722f558..ab7585b 100644
--- a/arch/mips/kernel/csrc-ioasic.c
+++ b/arch/mips/kernel/csrc-ioasic.c
@@ -34,7 +34,7 @@ static struct clocksource clocksource_dec = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace dec_ioasic_read_sched_clock(void)
+static u64 notrace dec_ioasic_read_sched_clock(void *data)
 {
 	return ioasic_read(IO_REG_FCTR);
 }
@@ -68,7 +68,7 @@ int __init dec_ioasic_clocksource_init(void)
 	clocksource_dec.rating = 200 + freq / 10000000;
 	clocksource_register_hz(&clocksource_dec, freq);
 
-	sched_clock_register(dec_ioasic_read_sched_clock, 32, freq);
+	sched_clock_register(dec_ioasic_read_sched_clock, 32, freq, NULL);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e5ed7ad..0269927 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -23,7 +23,7 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace r4k_read_sched_clock(void)
+static u64 notrace r4k_read_sched_clock(void *data)
 {
 	return read_c0_count();
 }
@@ -38,7 +38,8 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
-	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
+	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency,
+			     NULL);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/csrc-sb1250.c b/arch/mips/kernel/csrc-sb1250.c
index d915652..e1b0018 100644
--- a/arch/mips/kernel/csrc-sb1250.c
+++ b/arch/mips/kernel/csrc-sb1250.c
@@ -54,7 +54,7 @@ struct clocksource bcm1250_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace sb1250_read_sched_clock(void)
+static u64 notrace sb1250_read_sched_clock(void *data)
 {
 	return sb1250_hpt_get_cycles();
 }
@@ -76,5 +76,6 @@ void __init sb1250_clocksource_init(void)
 
 	clocksource_register_hz(cs, V_SCD_TIMER_FREQ);
 
-	sched_clock_register(sb1250_read_sched_clock, 23, V_SCD_TIMER_FREQ);
+	sched_clock_register(sb1250_read_sched_clock, 23, V_SCD_TIMER_FREQ,
+			     NULL);
 }
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 42d6cb9..7e30956 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -153,7 +153,7 @@ struct clocksource hub_rt_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace hub_rt_read_sched_clock(void)
+static u64 notrace hub_rt_read_sched_clock(void *data)
 {
 	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
 }
@@ -164,7 +164,7 @@ static void __init hub_rt_clocksource_init(void)
 
 	clocksource_register_hz(cs, CYCLES_PER_SEC);
 
-	sched_clock_register(hub_rt_read_sched_clock, 52, CYCLES_PER_SEC);
+	sched_clock_register(hub_rt_read_sched_clock, 52, CYCLES_PER_SEC, NULL);
 }
 
 void __init plat_time_init(void)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index b97767d..7b896b6 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -37,7 +37,7 @@ static cycle_t ccount_read(struct clocksource *cs)
 	return (cycle_t)get_ccount();
 }
 
-static u64 notrace ccount_sched_clock_read(void)
+static u64 notrace ccount_sched_clock_read(void *data)
 {
 	return get_ccount();
 }
@@ -147,7 +147,7 @@ void __init time_init(void)
 	clocksource_register_hz(&ccount_clocksource, ccount_freq);
 	local_timer_setup(0);
 	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
-	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
+	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq, NULL);
 	clocksource_of_init();
 }
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d6e3e49..3737be5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -434,6 +434,11 @@ static cycle_t arch_counter_read_cc(const struct cyclecounter *cc)
 	return arch_timer_read_counter();
 }
 
+static u64 notrace arch_counter_sched_read(void *data)
+{
+	return arch_timer_read_counter();
+}
+
 static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
 	.rating	= 400,
@@ -482,7 +487,8 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&timecounter, &cyclecounter, start_count);
 
 	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_counter_sched_read, 56, arch_timer_rate,
+			     NULL);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 29ea50a..b86a755 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -199,7 +199,7 @@ static struct clocksource gt_clocksource = {
 };
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-static u64 notrace gt_sched_clock_read(void)
+static u64 notrace gt_sched_clock_read(void *data)
 {
 	return gt_counter_read();
 }
@@ -214,7 +214,7 @@ static void __init gt_clocksource_init(void)
 	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
+	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate, NULL);
 #endif
 	clocksource_register_hz(&gt_clocksource, gt_clk_rate);
 }
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 6f28229..927a250 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -49,7 +49,7 @@ struct bcm2835_timer {
 
 static void __iomem *system_clock __read_mostly;
 
-static u64 notrace bcm2835_sched_read(void)
+static u64 notrace bcm2835_sched_read(void *data)
 {
 	return readl_relaxed(system_clock);
 }
@@ -95,7 +95,7 @@ static void __init bcm2835_timer_init(struct device_node *node)
 		panic("Can't read clock-frequency");
 
 	system_clock = base + REG_COUNTER_LO;
-	sched_clock_register(bcm2835_sched_read, 32, freq);
+	sched_clock_register(bcm2835_sched_read, 32, freq, NULL);
 
 	clocksource_mmio_init(base + REG_COUNTER_LO, node->name,
 		freq, 300, 32, clocksource_mmio_readl_up);
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 9be6018..c0450f5 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -166,7 +166,7 @@ static cycle_t __ttc_clocksource_read(struct clocksource *cs)
 				TTC_COUNT_VAL_OFFSET);
 }
 
-static u64 notrace ttc_sched_clock_read(void)
+static u64 notrace ttc_sched_clock_read(void *data)
 {
 	return readl_relaxed(ttc_sched_clock_val_reg);
 }
@@ -375,7 +375,7 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 
 	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
 	sched_clock_register(ttc_sched_clock_read, timer_width,
-			     ttccs->ttc.freq / PRESCALE);
+			     ttccs->ttc.freq / PRESCALE, NULL);
 }
 
 static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index b375106..25c8b51 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -53,7 +53,7 @@ static struct clocksource clocksource_dbx500_prcmu = {
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 
-static u64 notrace dbx500_prcmu_sched_clock_read(void)
+static u64 notrace dbx500_prcmu_sched_clock_read(void *data)
 {
 	if (unlikely(!clksrc_dbx500_timer_base))
 		return 0;
@@ -81,7 +81,7 @@ void __init clksrc_dbx500_prcmu_init(void __iomem *base)
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
 	}
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	sched_clock_register(dbx500_prcmu_sched_clock_read, 32, RATE_32K);
+	sched_clock_register(dbx500_prcmu_sched_clock_read, 32, RATE_32K, NULL);
 #endif
 	clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 65ec467..fbcb023 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -39,7 +39,7 @@ static void __init st_clksrc_reset(void)
 	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
 }
 
-static u64 notrace st_clksrc_sched_clock_read(void)
+static u64 notrace st_clksrc_sched_clock_read(void *data)
 {
 	return (u64)readl_relaxed(ddata.base + LPC_LPT_LSB_OFF);
 }
@@ -53,7 +53,7 @@ static int __init st_clksrc_init(void)
 
 	rate = clk_get_rate(ddata.clk);
 
-	sched_clock_register(st_clksrc_sched_clock_read, 32, rate);
+	sched_clock_register(st_clksrc_sched_clock_read, 32, rate, NULL);
 
 	ret = clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
 				    "clksrc-st-lpc", rate, 300, 32,
diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index cdd86e3..a112713 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -26,7 +26,7 @@ enum {
 
 static void __iomem *tcd;
 
-static u64 notrace clps711x_sched_clock_read(void)
+static u64 notrace clps711x_sched_clock_read(void *data)
 {
 	return ~readw(tcd);
 }
@@ -47,7 +47,7 @@ static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 	clocksource_mmio_init(tcd, "clps711x-clocksource", rate, 300, 16,
 			      clocksource_mmio_readw_down);
 
-	sched_clock_register(clps711x_sched_clock_read, 16, rate);
+	sched_clock_register(clps711x_sched_clock_read, 16, rate, NULL);
 
 	return 0;
 }
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index a19a3f6..f971245 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -106,7 +106,7 @@ static void __init add_clocksource(struct device_node *source_timer)
 	sched_rate = rate;
 }
 
-static u64 notrace read_sched_clock(void)
+static u64 notrace read_sched_clock(void *data)
 {
 	return ~readl_relaxed(sched_io_base);
 }
@@ -127,7 +127,7 @@ static void __init init_sched_clock(void)
 		of_node_put(sched_timer);
 	}
 
-	sched_clock_register(read_sched_clock, 32, sched_rate);
+	sched_clock_register(read_sched_clock, 32, sched_rate, NULL);
 }
 
 static int num_called;
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 029f96a..516d505 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -218,7 +218,7 @@ static struct clocksource mct_frc = {
 	.resume		= exynos4_frc_resume,
 };
 
-static u64 notrace exynos4_read_sched_clock(void)
+static u64 notrace exynos4_read_sched_clock(void *data)
 {
 	return exynos4_read_count_32();
 }
@@ -243,7 +243,7 @@ static void __init exynos4_clocksource_init(void)
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
 
-	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
+	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate, NULL);
 }
 
 static void exynos4_mct_comp0_stop(void)
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
index ef43469..a395e9b 100644
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -118,7 +118,7 @@ static inline void ftm_reset_counter(void __iomem *base)
 	ftm_writel(0x00, base + FTM_CNT);
 }
 
-static u64 ftm_read_sched_clock(void)
+static u64 ftm_read_sched_clock(void *data)
 {
 	return ftm_readl(priv->clksrc_base + FTM_CNT);
 }
@@ -234,7 +234,8 @@ static int __init ftm_clocksource_init(unsigned long freq)
 
 	ftm_reset_counter(priv->clksrc_base);
 
-	sched_clock_register(ftm_read_sched_clock, 16, freq / (1 << priv->ps));
+	sched_clock_register(ftm_read_sched_clock, 16, freq / (1 << priv->ps),
+			     NULL);
 	err = clocksource_mmio_init(priv->clksrc_base + FTM_CNT, "fsl-ftm",
 				    freq / (1 << priv->ps), 300, 16,
 				    clocksource_mmio_readl_up);
diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 1fa22c4..cd6a543 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -38,7 +38,7 @@
 
 static void __iomem *timer_base;
 
-static u64 notrace meson6_timer_sched_read(void)
+static u64 notrace meson6_timer_sched_read(void *data)
 {
 	return (u64)readl(timer_base + TIMER_ISA_VAL(CSD_ID));
 }
@@ -145,7 +145,7 @@ static void __init meson6_timer_init(struct device_node *node)
 	val |= TIMER_CSD_UNIT_1US << TIMER_INPUT_BIT(CSD_ID);
 	writel(val, timer_base + TIMER_ISA_MUX);
 
-	sched_clock_register(meson6_timer_sched_read, 32, USEC_PER_SEC);
+	sched_clock_register(meson6_timer_sched_read, 32, USEC_PER_SEC, NULL);
 	clocksource_mmio_init(timer_base + TIMER_ISA_VAL(CSD_ID), node->name,
 			      1000 * 1000, 300, 32, clocksource_mmio_readl_up);
 
diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index f5ce296..84d8e3d 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -206,7 +206,7 @@ static struct clocksource clocksource_mxs = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace mxs_read_sched_clock_v2(void)
+static u64 notrace mxs_read_sched_clock_v2(void *data)
 {
 	return ~readl_relaxed(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1));
 }
@@ -220,7 +220,7 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 	else {
 		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1),
 			"mxs_timer", c, 200, 32, clocksource_mmio_readl_down);
-		sched_clock_register(mxs_read_sched_clock_v2, 32, c);
+		sched_clock_register(mxs_read_sched_clock_v2, 32, c, NULL);
 	}
 
 	return 0;
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index bc8dd44..e30faf7 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -75,7 +75,7 @@ static struct delay_timer mtu_delay_timer;
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
  */
-static u64 notrace nomadik_read_sched_clock(void)
+static u64 notrace nomadik_read_sched_clock(void *data)
 {
 	if (unlikely(!mtu_base))
 		return 0;
@@ -232,7 +232,7 @@ static void __init nmdk_timer_init(void __iomem *base, int irq,
 		       "mtu_0");
 
 #ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
-	sched_clock_register(nomadik_read_sched_clock, 32, rate);
+	sched_clock_register(nomadik_read_sched_clock, 32, rate, NULL);
 #endif
 
 	/* Timer 1 is used for events, register irq and clockevents */
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 45b6a49..a9395fd 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -54,7 +54,7 @@
 
 static void __iomem *timer_base;
 
-static u64 notrace pxa_read_sched_clock(void)
+static u64 notrace pxa_read_sched_clock(void *data)
 {
 	return timer_readl(OSCR);
 }
@@ -155,7 +155,7 @@ static void __init pxa_timer_common_init(int irq, unsigned long clock_tick_rate)
 	timer_writel(0, OIER);
 	timer_writel(OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3, OSSR);
 
-	sched_clock_register(pxa_read_sched_clock, 32, clock_tick_rate);
+	sched_clock_register(pxa_read_sched_clock, 32, clock_tick_rate, NULL);
 
 	ckevt_pxa_osmr0.cpumask = cpumask_of(0);
 
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
index f8e09f9..2f99c80 100644
--- a/drivers/clocksource/qcom-timer.c
+++ b/drivers/clocksource/qcom-timer.c
@@ -164,7 +164,7 @@ static struct notifier_block msm_timer_cpu_nb = {
 	.notifier_call = msm_timer_cpu_notify,
 };
 
-static u64 notrace msm_sched_clock_read(void)
+static u64 notrace msm_sched_clock_read(void *data)
 {
 	return msm_clocksource.read(&msm_clocksource);
 }
@@ -215,7 +215,7 @@ err:
 	res = clocksource_register_hz(cs, dgt_hz);
 	if (res)
 		pr_err("clocksource_register failed\n");
-	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz);
+	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz, NULL);
 	msm_delay_timer.freq = dgt_hz;
 	register_current_timer_delay(&msm_delay_timer);
 }
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index bc90e13..e4b7578 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -328,7 +328,7 @@ static struct clocksource samsung_clocksource = {
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by U300 implementation.)
  */
-static u64 notrace samsung_read_sched_clock(void)
+static u64 notrace samsung_read_sched_clock(void *data)
 {
 	return samsung_clocksource_read(NULL);
 }
@@ -355,7 +355,7 @@ static void __init samsung_clocksource_init(void)
 		pwm.source_reg = pwm.base + pwm.source_id * 0x0c + 0x14;
 
 	sched_clock_register(samsung_read_sched_clock,
-						pwm.variant.bits, clock_rate);
+					pwm.variant.bits, clock_rate, NULL);
 
 	samsung_clocksource.mask = CLOCKSOURCE_MASK(pwm.variant.bits);
 	ret = clocksource_register_hz(&samsung_clocksource, clock_rate);
diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6f3719d..0407429 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -141,7 +141,7 @@ static struct irqaction sun4i_timer_irq = {
 	.dev_id = &sun4i_clockevent,
 };
 
-static u64 notrace sun4i_timer_sched_read(void)
+static u64 notrace sun4i_timer_sched_read(void *data)
 {
 	return ~readl(timer_base + TIMER_CNTVAL_REG(1));
 }
@@ -180,7 +180,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
 	    of_machine_is_compatible("allwinner,sun5i-a10s"))
-		sched_clock_register(sun4i_timer_sched_read, 32, rate);
+		sched_clock_register(sun4i_timer_sched_read, 32, rate, NULL);
 
 	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
 			      rate, 350, 32, clocksource_mmio_readl_down);
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 6ebda11..c7c149a 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -104,7 +104,7 @@ static struct clock_event_device tegra_clockevent = {
 	.tick_resume		= tegra_timer_shutdown,
 };
 
-static u64 notrace tegra_read_sched_clock(void)
+static u64 notrace tegra_read_sched_clock(void *data)
 {
 	return timer_readl(TIMERUS_CNTR_1US);
 }
@@ -208,7 +208,7 @@ static void __init tegra20_init_timer(struct device_node *np)
 		WARN(1, "Unknown clock rate");
 	}
 
-	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
+	sched_clock_register(tegra_read_sched_clock, 32, 1000000, NULL);
 
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 2162796..a13b73b 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -92,7 +92,7 @@ static void local_timer_ctrl_clrset(u32 clr, u32 set)
 		local_base + TIMER_CTRL_OFF);
 }
 
-static u64 notrace armada_370_xp_read_sched_clock(void)
+static u64 notrace armada_370_xp_read_sched_clock(void *data)
 {
 	return ~readl(timer_base + TIMER0_VAL_OFF);
 }
@@ -290,7 +290,8 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
-	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
+	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk,
+			     NULL);
 
 	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
 			      "armada_370_xp_clocksource",
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index a1c06a2..045735d 100644
--- a/drivers/clocksource/time-lpc32xx.c
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -48,7 +48,7 @@ struct lpc32xx_clock_event_ddata {
 /* Needed for the sched clock */
 static void __iomem *clocksource_timer_counter;
 
-static u64 notrace lpc32xx_read_sched_clock(void)
+static u64 notrace lpc32xx_read_sched_clock(void *data)
 {
 	return readl(clocksource_timer_counter);
 }
@@ -162,7 +162,7 @@ static int __init lpc32xx_clocksource_init(struct device_node *np)
 	}
 
 	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
-	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
+	sched_clock_register(lpc32xx_read_sched_clock, 32, rate, NULL);
 
 	return 0;
 
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index 0ece742..84faf88 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -39,7 +39,7 @@ static void __iomem *timer_base;
 /*
  * Free-running clocksource handling.
  */
-static u64 notrace orion_read_sched_clock(void)
+static u64 notrace orion_read_sched_clock(void *data)
 {
 	return ~readl(timer_base + TIMER0_VAL);
 }
@@ -133,7 +133,8 @@ static void __init orion_timer_init(struct device_node *np)
 	clocksource_mmio_init(timer_base + TIMER0_VAL, "orion_clocksource",
 			      clk_get_rate(clk), 300, 32,
 			      clocksource_mmio_readl_down);
-	sched_clock_register(orion_read_sched_clock, 32, clk_get_rate(clk));
+	sched_clock_register(orion_read_sched_clock, 32, clk_get_rate(clk),
+			     NULL);
 
 	/* setup timer1 as clockevent timer */
 	if (setup_irq(irq, &orion_clkevt_irq))
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index 18d4266..92897d8 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -86,7 +86,7 @@ static cycle_t pistachio_clocksource_read_cycles(struct clocksource *cs)
 	return ~(cycle_t)counter;
 }
 
-static u64 notrace pistachio_read_sched_clock(void)
+static u64 notrace pistachio_read_sched_clock(void *data)
 {
 	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);
 }
@@ -210,7 +210,7 @@ static void __init pistachio_clksrc_of_init(struct device_node *node)
 	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
 
 	raw_spin_lock_init(&pcs_gpt.lock);
-	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	sched_clock_register(pistachio_read_sched_clock, 32, rate, NULL);
 	clocksource_register_hz(&pcs_gpt.cs, rate);
 }
 CLOCKSOURCE_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index e73947f0f..66635fc 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -143,7 +143,7 @@ static irqreturn_t digicolor_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static u64 digicolor_timer_sched_read(void)
+static u64 digicolor_timer_sched_read(void *data)
 {
 	return ~readl(dc_timer_dev.base + COUNT(TIMER_B));
 }
@@ -183,7 +183,7 @@ static void __init digicolor_timer_init(struct device_node *node)
 	writel(UINT_MAX, dc_timer_dev.base + COUNT(TIMER_B));
 	writeb(CONTROL_ENABLE, dc_timer_dev.base + CONTROL(TIMER_B));
 
-	sched_clock_register(digicolor_timer_sched_read, 32, rate);
+	sched_clock_register(digicolor_timer_sched_read, 32, rate, NULL);
 	clocksource_mmio_init(dc_timer_dev.base + COUNT(TIMER_B), node->name,
 			      rate, 340, 32, clocksource_mmio_readl_down);
 
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 839aba9..5e387db 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -152,7 +152,7 @@ static void imx31_gpt_irq_acknowledge(struct imx_timer *imxtm)
 
 static void __iomem *sched_clock_reg;
 
-static u64 notrace mxc_read_sched_clock(void)
+static u64 notrace mxc_read_sched_clock(void *data)
 {
 	return sched_clock_reg ? readl_relaxed(sched_clock_reg) : 0;
 }
@@ -175,7 +175,7 @@ static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 
 	sched_clock_reg = reg;
 
-	sched_clock_register(mxc_read_sched_clock, 32, c);
+	sched_clock_register(mxc_read_sched_clock, 32, c, NULL);
 	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
 			clocksource_mmio_readl_up);
 }
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 3f59ac2..f69f5bd 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -31,7 +31,7 @@
 
 static void __iomem * sched_clk_base;
 
-static u64 notrace integrator_read_sched_clock(void)
+static u64 notrace integrator_read_sched_clock(void *data)
 {
 	return -readl(sched_clk_base + TIMER_VALUE);
 }
@@ -54,7 +54,7 @@ static void integrator_clocksource_init(unsigned long inrate,
 			rate, 200, 16, clocksource_mmio_readl_down);
 
 	sched_clk_base = base;
-	sched_clock_register(integrator_read_sched_clock, 16, rate);
+	sched_clock_register(integrator_read_sched_clock, 16, rate, NULL);
 }
 
 static unsigned long timer_reload;
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 78de982..4f3043d 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -176,7 +176,7 @@ static struct irqaction sirfsoc_timer_irq = {
 };
 
 /* Overwrite weak default sched_clock with more precise one */
-static u64 notrace sirfsoc_read_sched_clock(void)
+static u64 notrace sirfsoc_read_sched_clock(void *data)
 {
 	return sirfsoc_timer_read(NULL);
 }
@@ -219,7 +219,8 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource,
 				       PRIMA2_CLOCK_FREQ));
 
-	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
+	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ,
+			     NULL);
 
 	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
 
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5f45b9a..a7f4f2b 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -67,7 +67,7 @@ static long __init sp804_get_clock_rate(struct clk *clk)
 
 static void __iomem *sched_clock_base;
 
-static u64 notrace sp804_read(void)
+static u64 notrace sp804_read(void *data)
 {
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
@@ -110,7 +110,7 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 
 	if (use_sched_clock) {
 		sched_clock_base = base;
-		sched_clock_register(sp804_read, 32, rate);
+		sched_clock_register(sp804_read, 32, rate, NULL);
 	}
 }
 
diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index 1744b24..d653efe 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -344,7 +344,7 @@ static struct irqaction u300_timer_irq = {
  * stamp. (Inspired by OMAP implementation.)
  */
 
-static u64 notrace u300_read_sched_clock(void)
+static u64 notrace u300_read_sched_clock(void *data)
 {
 	return readl(u300_timer_base + U300_TIMER_APP_GPT2CC);
 }
@@ -384,7 +384,7 @@ static void __init u300_timer_init_of(struct device_node *np)
 
 	u300_clockevent_data.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
 
-	sched_clock_register(u300_read_sched_clock, 32, rate);
+	sched_clock_register(u300_read_sched_clock, 32, rate, NULL);
 
 	u300_delay_timer.read_current_timer = &u300_read_current_timer;
 	u300_delay_timer.freq = rate;
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/versatile.c
index 0a26d3d..fe319c0 100644
--- a/drivers/clocksource/versatile.c
+++ b/drivers/clocksource/versatile.c
@@ -20,7 +20,7 @@
 
 static void __iomem *versatile_sys_24mhz;
 
-static u64 notrace versatile_sys_24mhz_read(void)
+static u64 notrace versatile_sys_24mhz_read(void *data)
 {
 	return readl(versatile_sys_24mhz);
 }
@@ -34,7 +34,7 @@ static void __init versatile_sched_clock_init(struct device_node *node)
 
 	versatile_sys_24mhz = base + SYS_24MHZ;
 
-	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
+	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000, NULL);
 }
 CLOCKSOURCE_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
 		       versatile_sched_clock_init);
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index f07ba99..3cb1c54 100644
--- a/drivers/clocksource/vf_pit_timer.c
+++ b/drivers/clocksource/vf_pit_timer.c
@@ -52,7 +52,7 @@ static inline void pit_irq_acknowledge(void)
 	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 }
 
-static u64 pit_read_sched_clock(void)
+static u64 pit_read_sched_clock(void *data)
 {
 	return ~__raw_readl(clksrc_base + PITCVAL);
 }
@@ -64,7 +64,7 @@ static int __init pit_clocksource_init(unsigned long rate)
 	__raw_writel(~0UL, clksrc_base + PITLDVAL);
 	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
 
-	sched_clock_register(pit_read_sched_clock, 32, rate);
+	sched_clock_register(pit_read_sched_clock, 32, rate, NULL);
 	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
 			300, 32, clocksource_mmio_readl_down);
 }
diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index efa931c..881358e 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -14,7 +14,7 @@ extern void sched_clock_postinit(void);
 static inline void sched_clock_postinit(void) { }
 #endif
 
-extern void sched_clock_register(u64 (*read)(void), int bits,
-				 unsigned long rate);
+extern void sched_clock_register(u64 (*read)(void *), int bits,
+				 unsigned long rate, void *data);
 
 #endif
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index a26036d..ccb2af9 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -27,6 +27,7 @@
  * @sched_clock_mask:   Bitmask for two's complement subtraction of non 64bit
  *			clocks.
  * @read_sched_clock:	Current clock source (or dummy source when suspended).
+ * @sched_clock_data:	Pointer passed to read_sched_clock()
  * @mult:		Multipler for scaled math conversion.
  * @shift:		Shift value for scaled math conversion.
  *
@@ -39,7 +40,8 @@ struct clock_read_data {
 	u64 epoch_ns;
 	u64 epoch_cyc;
 	u64 sched_clock_mask;
-	u64 (*read_sched_clock)(void);
+	u64 (*read_sched_clock)(void *);
+	void *sched_clock_data;
 	u32 mult;
 	u32 shift;
 };
@@ -54,6 +56,7 @@ struct clock_read_data {
  * @wrap_kt:		Duration for which clock can run before wrapping.
  * @rate:		Tick rate of the registered clock.
  * @actual_read_sched_clock: Registered hardware level clock read function.
+ * @sched_clock_data:	Pointer passed to actual_read_sched_clock()
  *
  * The ordering of this structure has been chosen to optimize cache
  * performance. In particular 'seq' and 'read_data[0]' (combined) should fit
@@ -65,7 +68,8 @@ struct clock_data {
 	ktime_t			wrap_kt;
 	unsigned long		rate;
 
-	u64 (*actual_read_sched_clock)(void);
+	u64 (*actual_read_sched_clock)(void *data);
+	void *sched_clock_data;
 };
 
 static struct hrtimer sched_clock_timer;
@@ -73,7 +77,7 @@ static int irqtime = -1;
 
 core_param(irqtime, irqtime, int, 0400);
 
-static u64 notrace jiffy_sched_clock_read(void)
+static u64 notrace jiffy_sched_clock_read(void *data)
 {
 	/*
 	 * We don't need to use get_jiffies_64 on 32-bit arches here
@@ -103,8 +107,8 @@ unsigned long long notrace sched_clock(void)
 		seq = raw_read_seqcount(&cd.seq);
 		rd = cd.read_data + (seq & 1);
 
-		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
-		      rd->sched_clock_mask;
+		cyc = (rd->read_sched_clock(rd->sched_clock_data) -
+		       rd->epoch_cyc) & rd->sched_clock_mask;
 		res = rd->epoch_ns + cyc_to_ns(cyc, rd->mult, rd->shift);
 	} while (read_seqcount_retry(&cd.seq, seq));
 
@@ -147,7 +151,7 @@ static void update_sched_clock(void)
 
 	rd = cd.read_data[0];
 
-	cyc = cd.actual_read_sched_clock();
+	cyc = cd.actual_read_sched_clock(cd.sched_clock_data);
 	ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) & rd.sched_clock_mask, rd.mult, rd.shift);
 
 	rd.epoch_ns = ns;
@@ -165,7 +169,8 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 }
 
 void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+sched_clock_register(u64 (*read)(void *), int bits, unsigned long rate,
+		     void *data)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -191,12 +196,14 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	rd = cd.read_data[0];
 
 	/* Update epoch for new counter and update 'epoch_ns' from old counter*/
-	new_epoch = read();
-	cyc = cd.actual_read_sched_clock();
+	new_epoch = read(data);
+	cyc = cd.actual_read_sched_clock(cd.sched_clock_data);
 	ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) & rd.sched_clock_mask, rd.mult, rd.shift);
 	cd.actual_read_sched_clock = read;
+	cd.sched_clock_data = data;
 
 	rd.read_sched_clock	= read;
+	rd.sched_clock_data	= data;
 	rd.sched_clock_mask	= new_mask;
 	rd.mult			= new_mult;
 	rd.shift		= new_shift;
@@ -238,7 +245,8 @@ void __init sched_clock_postinit(void)
 	 * make it the final one one.
 	 */
 	if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
-		sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
+		sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ,
+				     NULL);
 
 	update_sched_clock();
 
@@ -262,7 +270,7 @@ void __init sched_clock_postinit(void)
  * at the end of the critical section to be sure we observe the
  * correct copy of 'epoch_cyc'.
  */
-static u64 notrace suspended_sched_clock_read(void)
+static u64 notrace suspended_sched_clock_read(void *data)
 {
 	unsigned long seq = raw_read_seqcount(&cd.seq);
 
@@ -284,7 +292,7 @@ static void sched_clock_resume(void)
 {
 	struct clock_read_data *rd = &cd.read_data[0];
 
-	rd->epoch_cyc = cd.actual_read_sched_clock();
+	rd->epoch_cyc = cd.actual_read_sched_clock(cd.sched_clock_data);
 	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
 	rd->read_sched_clock = cd.actual_read_sched_clock;
 }
-- 
2.5.3
