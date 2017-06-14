Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 14:42:15 +0200 (CEST)
Received: from mail-wr0-x22d.google.com ([IPv6:2a00:1450:400c:c0c::22d]:32897
        "EHLO mail-wr0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994627AbdFNMmDDDWnN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 14:42:03 +0200
Received: by mail-wr0-x22d.google.com with SMTP id v104so175910896wrb.0
        for <linux-mips@linux-mips.org>; Wed, 14 Jun 2017 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aivh4/t9307J15fNmuFPQz0QtwAD1cuDfkuXFUlHMsg=;
        b=FvwNkpcYL3dvVetif45MzVYrnbGko6vNyXiQSoQUAXczQKaZMFNasjQ+ow6mVEXFVt
         eJa1jGYgn2swMt8+u6cUxa0eNLj64J0ji8H/x7MyCw1V4shrJxcW1i/yVNlSSnewDy8k
         JpY0mFKdigHT3IBZic+Di3hKLJWlogIq+ru44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aivh4/t9307J15fNmuFPQz0QtwAD1cuDfkuXFUlHMsg=;
        b=QxCJJi2fDcrFDxNOgecR65PILJtFmu9nmGzXQg42wMChf2460RWXQ96F1+2PVsHXz1
         5wPpseP0HV2jUnMjrQd+7q4Jyq793CHggBOdMfVLjshJ8FPksBTaFADvRjqXfp1aiTz3
         0NQ2j9nzgd1LxFMBp5E7mXQN073tmmUUZfVVfPhno3qaZH5CgbQZ+m3gcTUI0X0yr4c8
         9grAtzus35EBgeoj1MpN9BjT0xsQO5p3jfltlgRZsH2C1/mMmYmv43EzyZJjRURSzkAs
         IhhJMB3dzme8FXA+6zf7TnuUaf1PB4SGamnh5Byvdmy8vRGPTIdDvuzqQUs2SH7MUcdV
         NkHg==
X-Gm-Message-State: AKS2vOz3y8o4WT7jXTFBkHA3PszDbWz7ocoatf40Sww91kOdpG9Sqfpa
        BuBMa3Cuxw8I+sAR
X-Received: by 10.223.129.183 with SMTP id 52mr358084wra.71.1497444115993;
        Wed, 14 Jun 2017 05:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:19a:b336:54d7:46e9])
        by smtp.gmail.com with ESMTPSA id 80sm1457015wmg.17.2017.06.14.05.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 05:41:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        John Crispin <john@phrozen.org>,
        Ley Foon Tan <lftan@altera.com>,
        Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vlad Zakharov <Vladislav.Zakharov@synopsys.com>,
        Rob Herring <robh@kernel.org>, Noam Camus <noamc@ezchip.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCH...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC...),
        linux-omap@vger.kernel.org (open list:OMAP2+ SUPPORT),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC...),
        linux-renesas-soc@vger.kernel.org (open list:ARM/SHMOBILE ARM...),
        uclinux-h8-devel@lists.sourceforge.jp (moderated list:H8/300
        ARCHITECTURE), linux-mips@linux-mips.org (open list:MIPS),
        nios2-dev@lists.rocketboards.org (moderated list:NIOS2 ARCHITECTURE),
        linux-sh@vger.kernel.org (open list:SUPERH),
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA...)
Subject: [PATCH 13/23] clocksource/drivers: Rename clocksource_probe to timer_probe
Date:   Wed, 14 Jun 2017 14:39:34 +0200
Message-Id: <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170614123800.GH2261@mai>
 <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

The function name is now renamed to 'timer_probe' for consistency with
the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/kernel/setup.c                  |  2 +-
 arch/arm/kernel/time.c                   |  2 +-
 arch/arm/mach-mediatek/mediatek.c        |  2 +-
 arch/arm/mach-omap2/timer.c              | 10 +++++-----
 arch/arm/mach-rockchip/rockchip.c        |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 +-
 arch/arm/mach-spear/spear13xx.c          |  2 +-
 arch/arm/mach-sunxi/sunxi.c              |  2 +-
 arch/arm/mach-u300/core.c                |  2 +-
 arch/arm/mach-zynq/common.c              |  2 +-
 arch/arm64/kernel/time.c                 |  2 +-
 arch/h8300/kernel/setup.c                |  2 +-
 arch/microblaze/kernel/setup.c           |  2 +-
 arch/mips/generic/init.c                 |  2 +-
 arch/mips/mti-malta/malta-time.c         |  2 +-
 arch/mips/pic32/pic32mzda/time.c         |  2 +-
 arch/mips/pistachio/time.c               |  2 +-
 arch/mips/ralink/clk.c                   |  2 +-
 arch/mips/ralink/timer-gic.c             |  2 +-
 arch/mips/xilfpga/time.c                 |  2 +-
 arch/nios2/kernel/time.c                 |  2 +-
 arch/sh/boards/of-generic.c              |  2 +-
 arch/xtensa/kernel/time.c                |  2 +-
 drivers/clocksource/clksrc-probe.c       |  2 +-
 include/linux/clocksource.h              |  4 ++--
 25 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index fc8211f..666613f 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -470,7 +470,7 @@ void __init setup_arch(char **cmdline_p)
 void __init time_init(void)
 {
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 static int __init customize_machine(void)
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 97b22fa..629f8e9 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -120,6 +120,6 @@ void __init time_init(void)
 #ifdef CONFIG_COMMON_CLK
 		of_clk_init(NULL);
 #endif
-		clocksource_probe();
+		timer_probe();
 	}
 }
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index a6e3c98..c3cf215 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -41,7 +41,7 @@ static void __init mediatek_timer_init(void)
 	}
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 };
 
 static const char * const mediatek_board_dt_compat[] = {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 07dd692..ae4bb9f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -497,7 +497,7 @@ void __init omap_init_time(void)
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
 
-	clocksource_probe();
+	timer_probe();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
@@ -506,7 +506,7 @@ void __init omap3_secure_sync32k_timer_init(void)
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
 			2, "timer_sys_ck", NULL, false);
 
-	clocksource_probe();
+	timer_probe();
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
@@ -517,7 +517,7 @@ void __init omap3_gptimer_timer_init(void)
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
 			1, "timer_sys_ck", "ti,timer-alwon", true);
 	if (of_have_populated_dt())
-		clocksource_probe();
+		timer_probe();
 }
 #endif
 
@@ -532,7 +532,7 @@ static void __init omap4_sync32k_timer_init(void)
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	clocksource_probe();
+	timer_probe();
 }
 #endif
 
@@ -656,7 +656,7 @@ void __init omap5_realtime_timer_init(void)
 	omap4_sync32k_timer_init();
 	realtime_counter_init();
 
-	clocksource_probe();
+	timer_probe();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index ef0500a..5ab834e 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -55,7 +55,7 @@ static void __init rockchip_timer_init(void)
 	}
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 static void __init rockchip_dt_init(void)
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 52d466b..a6e74f4 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -113,7 +113,7 @@ void __init rcar_gen2_timer_init(void)
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 struct memory_reserve_config {
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index ca2f6a8..31c43ca 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -124,5 +124,5 @@ void __init spear13xx_timer_init(void)
 	clk_put(pclk);
 
 	spear_setup_of_timer();
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index f44e3ac..7ab353f 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -42,7 +42,7 @@ static void __init sun6i_timer_init(void)
 	of_clk_init(NULL);
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		sun6i_reset_init();
-	clocksource_probe();
+	timer_probe();
 }
 
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index a4910ea..048f15e 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -407,7 +407,7 @@ static const char * u300_board_compat[] = {
 DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
 	.map_io		= u300_map_io,
 	.init_irq	= u300_init_irq_dt,
-	.init_time	= clocksource_probe,
+	.init_time	= timer_probe,
 	.init_machine	= u300_init_machine_dt,
 	.restart	= u300_restart,
 	.dt_compat      = u300_board_compat,
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index ed11864..6aba9eb 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -150,7 +150,7 @@ static void __init zynq_timer_init(void)
 {
 	zynq_clock_init();
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 static struct map_desc zynq_cortex_a9_scu_map __initdata = {
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 5977969..da33c90 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -70,7 +70,7 @@ void __init time_init(void)
 	u32 arch_timer_rate;
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 
 	tick_setup_hrtimer_broadcast();
 
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index c8c25a4..6be15d6 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -246,5 +246,5 @@ void __init calibrate_delay(void)
 void __init time_init(void)
 {
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index f31ebb5..be98ffe 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -192,7 +192,7 @@ void __init time_init(void)
 {
 	of_clk_init(NULL);
 	setup_cpuinfo_clk();
-	clocksource_probe();
+	timer_probe();
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 4af6192..1231b5a 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -161,7 +161,7 @@ void __init plat_time_init(void)
 		}
 	}
 
-	clocksource_probe();
+	timer_probe();
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 289edcf..cea4ec9 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -265,7 +265,7 @@ void __init plat_time_init(void)
 		       (freq%1000000)*100/1000000);
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 		update_gic_frequency_dt();
-		clocksource_probe();
+		timer_probe();
 #endif
 	}
 #endif
diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index 62a0a78..1894e50 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -64,5 +64,5 @@ void __init plat_time_init(void)
 	pr_info("CPU Clock: %ldMHz\n", rate / 1000000);
 	mips_hpt_frequency = rate / 2;
 
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
index 1022201..17a0f1d 100644
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -39,7 +39,7 @@ void __init plat_time_init(void)
 	struct clk *clk;
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 
 	np = of_get_cpu_node(0, NULL);
 	if (!np) {
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index df79588..eb1c619 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -82,5 +82,5 @@ void __init plat_time_init(void)
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 	clk_put(clk);
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/mips/ralink/timer-gic.c b/arch/mips/ralink/timer-gic.c
index 069771d..b5f07d2 100644
--- a/arch/mips/ralink/timer-gic.c
+++ b/arch/mips/ralink/timer-gic.c
@@ -20,5 +20,5 @@ void __init plat_time_init(void)
 	ralink_of_remap();
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/mips/xilfpga/time.c b/arch/mips/xilfpga/time.c
index cbb3fca..36f3f18 100644
--- a/arch/mips/xilfpga/time.c
+++ b/arch/mips/xilfpga/time.c
@@ -22,7 +22,7 @@ void __init plat_time_init(void)
 	struct clk *clk;
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 
 	np = of_get_cpu_node(0, NULL);
 	if (!np) {
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index 2954b66..645129a 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -350,7 +350,7 @@ void __init time_init(void)
 	if (count < 2)
 		panic("%d timer is found, it needs 2 timers in system\n", count);
 
-	clocksource_probe();
+	timer_probe();
 }
 
 TIMER_OF_DECLARE(nios2_timer, ALTR_TIMER_COMPATIBLE, nios2_time_init);
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 1fb6d57..4feb7c8 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -119,7 +119,7 @@ static void __init sh_of_mem_reserve(void)
 static void __init sh_of_time_init(void)
 {
 	pr_info("SH generic board support: scanning for clocksource devices\n");
-	clocksource_probe();
+	timer_probe();
 }
 
 static void __init sh_of_setup(char **cmdline_p)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 668c105..fd524a5 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -187,7 +187,7 @@ void __init time_init(void)
 	local_timer_setup(0);
 	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
-	clocksource_probe();
+	timer_probe();
 }
 
 /*
diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index ac701ff..5d549c2 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -24,7 +24,7 @@ extern struct of_device_id __clksrc_of_table[];
 static const struct of_device_id __clksrc_of_table_sentinel
 	__used __section(__clksrc_of_table_end);
 
-void __init clocksource_probe(void)
+void __init timer_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index a86b65f..010bb9f 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -253,9 +253,9 @@ extern int clocksource_i8253_init(void);
 	OF_DECLARE_1_RET(clksrc, name, compat, fn)
 
 #ifdef CONFIG_CLKSRC_PROBE
-extern void clocksource_probe(void);
+extern void timer_probe(void);
 #else
-static inline void clocksource_probe(void) {}
+static inline void timer_probe(void) {}
 #endif
 
 #define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.7.4
