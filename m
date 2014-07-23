Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:40:09 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64270 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842523AbaGWOg6DE8fu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:36:58 +0200
Received: by mail-wi0-f179.google.com with SMTP id f8so2367128wiw.6
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tossjytRZ/ROmyYxICgozETNRhkYGOvcmG6Y/X6DpWg=;
        b=jxKBX/dryPXsGYdMeKoAyH8FvDm32NQ/Y8kV7fOUNP6/RdW0p24ud3/uU8ySaSYIBs
         lQZnYK7LXdhFBs2R1x3aISdpx0j9IfaiuUFBJWGJspl/BCdymTyuRhpFJR5aGbi8wxza
         iun3FXMg6Fp4/HrIB0FyV6GnoF3I9xnFPseLB5G2+4wUnwDsaF3+FRYMy0wAERkSj5GT
         bmGExioycIxnULQ9NdP8SDbBi3YaPfo3yemIDhiduuwi8xkL+ZUxxALLkK+/iAO1UE6X
         hfNkgN1Q7lqg2GfvCygQIdJmH+NcbYvzKiVDLqxWkzJsej4yOq639o03hfghGr9EUpXu
         J5Bw==
X-Received: by 10.194.121.6 with SMTP id lg6mr2531745wjb.116.1406126209036;
        Wed, 23 Jul 2014 07:36:49 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id h3sm6717751wjz.48.2014.07.23.07.36.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:36:48 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 4/6] MIPS: Alchemy: introduce helpers to access SYS register block.
Date:   Wed, 23 Jul 2014 16:36:24 +0200
Message-Id: <1406126186-471228-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

This patch changes all absolute SYS_XY registers to offsets from the
SYS block base, prefixes them with AU1000 to avoid silent failures due
to changed addresses, and introduces helper functions to read/write
them.

No functional changes, comparing assembly of a few select functions shows
no differences.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/board-mtx1.c                  |  4 +-
 arch/mips/alchemy/board-xxs1500.c               |  4 +-
 arch/mips/alchemy/common/clocks.c               |  6 +-
 arch/mips/alchemy/common/irq.c                  |  5 +-
 arch/mips/alchemy/common/platform.c             |  2 +-
 arch/mips/alchemy/common/power.c                | 26 ++++-----
 arch/mips/alchemy/common/time.c                 | 23 ++++----
 arch/mips/alchemy/devboards/db1000.c            |  5 +-
 arch/mips/alchemy/devboards/db1200.c            | 19 +++----
 arch/mips/alchemy/devboards/db1550.c            | 10 ++--
 arch/mips/alchemy/devboards/pm.c                | 39 +++++--------
 arch/mips/include/asm/mach-au1x00/au1000.h      | 75 ++++++++++++++++---------
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h | 56 +++++++++---------
 drivers/mmc/host/au1xmmc.c                      |  2 +-
 drivers/rtc/rtc-au1xxx.c                        | 18 +++---
 drivers/video/fbdev/au1100fb.c                  | 11 ++--
 drivers/video/fbdev/au1200fb.c                  |  6 +-
 17 files changed, 152 insertions(+), 159 deletions(-)

diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 25a59a2..1e3b102 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -85,10 +85,10 @@ void __init board_setup(void)
 #endif /* IS_ENABLED(CONFIG_USB_OHCI_HCD) */
 
 	/* Initialize sys_pinfunc */
-	au_writel(SYS_PF_NI2, SYS_PINFUNC);
+	alchemy_wrsys(SYS_PF_NI2, AU1000_SYS_PINFUNC);
 
 	/* Initialize GPIO */
-	au_writel(~0, KSEG1ADDR(AU1000_SYS_PHYS_ADDR) + SYS_TRIOUTCLR);
+	alchemy_wrsys(~0, AU1000_SYS_TRIOUTCLR);
 	alchemy_gpio_direction_output(0, 0);	/* Disable M66EN (PCI 66MHz) */
 	alchemy_gpio_direction_output(3, 1);	/* Disable PCI CLKRUN# */
 	alchemy_gpio_direction_output(1, 1);	/* Enable EXT_IO3 */
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index 3fb814b..0fc53e0 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -87,9 +87,9 @@ void __init board_setup(void)
 	alchemy_gpio2_enable();
 
 	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
-	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
+	pin_func  = alchemy_rdsys(AU1000_SYS_PINFUNC) & ~SYS_PF_UR3;
 	pin_func |= SYS_PF_UR3;
-	au_writel(pin_func, SYS_PINFUNC);
+	alchemy_wrsys(pin_func, AU1000_SYS_PINFUNC);
 
 	/* Enable UART */
 	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
diff --git a/arch/mips/alchemy/common/clocks.c b/arch/mips/alchemy/common/clocks.c
index f38298a..0e41416 100644
--- a/arch/mips/alchemy/common/clocks.c
+++ b/arch/mips/alchemy/common/clocks.c
@@ -91,13 +91,13 @@ unsigned long au1xxx_calc_clock(void)
 	if (au1xxx_cpu_has_pll_wo())
 		cpu_speed = 396000000;
 	else
-		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
+		cpu_speed = (alchemy_rdsys(AU1000_SYS_CPUPLL) & 0x3f) * AU1000_SRC_CLK;
 
 	/* On Alchemy CPU:counter ratio is 1:1 */
 	mips_hpt_frequency = cpu_speed;
 	/* Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16) */
-	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)
-							  & 0x03) + 2) * 16));
+	set_au1x00_uart_baud_base(cpu_speed / (2 *
+		((alchemy_rdsys(AU1000_SYS_POWERCTRL) & 0x03) + 2) * 16));
 
 	set_au1x00_speed(cpu_speed);
 
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 63a7181..6cb60ab 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -389,13 +389,12 @@ static int au1x_ic1_setwake(struct irq_data *d, unsigned int on)
 		return -EINVAL;
 
 	local_irq_save(flags);
-	wakemsk = __raw_readl((void __iomem *)SYS_WAKEMSK);
+	wakemsk = alchemy_rdsys(AU1000_SYS_WAKEMSK);
 	if (on)
 		wakemsk |= 1 << bit;
 	else
 		wakemsk &= ~(1 << bit);
-	__raw_writel(wakemsk, (void __iomem *)SYS_WAKEMSK);
-	wmb();
+	alchemy_wrsys(wakemsk, AU1000_SYS_WAKEMSK);
 	local_irq_restore(flags);
 
 	return 0;
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 9837a13..fb89d21 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -420,7 +420,7 @@ static void __init alchemy_setup_macs(int ctype)
 		memcpy(au1xxx_eth1_platform_data.mac, ethaddr, 6);
 
 	/* Register second MAC if enabled in pinfunc */
-	if (!(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2)) {
+	if (!(alchemy_rdsys(AU1000_SYS_PINFUNC) & SYS_PF_NI2)) {
 		ret = platform_device_register(&au1xxx_eth1_device);
 		if (ret)
 			printk(KERN_INFO "Alchemy: failed to register MAC1\n");
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index bdb28dee..2d3831b 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -54,14 +54,14 @@ static unsigned int sleep_static_memctlr[4][3];
 static void save_core_regs(void)
 {
 	/* Clocks and PLLs. */
-	sleep_sys_clocks[0] = au_readl(SYS_FREQCTRL0);
-	sleep_sys_clocks[1] = au_readl(SYS_FREQCTRL1);
-	sleep_sys_clocks[2] = au_readl(SYS_CLKSRC);
-	sleep_sys_clocks[3] = au_readl(SYS_CPUPLL);
-	sleep_sys_clocks[4] = au_readl(SYS_AUXPLL);
+	sleep_sys_clocks[0] = alchemy_rdsys(AU1000_SYS_FREQCTRL0);
+	sleep_sys_clocks[1] = alchemy_rdsys(AU1000_SYS_FREQCTRL1);
+	sleep_sys_clocks[2] = alchemy_rdsys(AU1000_SYS_CLKSRC);
+	sleep_sys_clocks[3] = alchemy_rdsys(AU1000_SYS_CPUPLL);
+	sleep_sys_clocks[4] = alchemy_rdsys(AU1000_SYS_AUXPLL);
 
 	/* pin mux config */
-	sleep_sys_pinfunc = au_readl(SYS_PINFUNC);
+	sleep_sys_pinfunc = alchemy_rdsys(AU1000_SYS_PINFUNC);
 
 	/* Save the static memory controller configuration. */
 	sleep_static_memctlr[0][0] = au_readl(MEM_STCFG0);
@@ -85,16 +85,14 @@ static void restore_core_regs(void)
 	 * one of those Au1000 with a write-only PLL, where we dont
 	 * have a valid value)
 	 */
-	au_writel(sleep_sys_clocks[0], SYS_FREQCTRL0);
-	au_writel(sleep_sys_clocks[1], SYS_FREQCTRL1);
-	au_writel(sleep_sys_clocks[2], SYS_CLKSRC);
-	au_writel(sleep_sys_clocks[4], SYS_AUXPLL);
+	alchemy_wrsys(sleep_sys_clocks[0], AU1000_SYS_FREQCTRL0);
+	alchemy_wrsys(sleep_sys_clocks[1], AU1000_SYS_FREQCTRL1);
+	alchemy_wrsys(sleep_sys_clocks[2], AU1000_SYS_CLKSRC);
+	alchemy_wrsys(sleep_sys_clocks[4], AU1000_SYS_AUXPLL);
 	if (!au1xxx_cpu_has_pll_wo())
-		au_writel(sleep_sys_clocks[3], SYS_CPUPLL);
-	au_sync();
+		alchemy_wrsys(sleep_sys_clocks[3], AU1000_SYS_CPUPLL);
 
-	au_writel(sleep_sys_pinfunc, SYS_PINFUNC);
-	au_sync();
+	alchemy_wrsys(sleep_sys_pinfunc, AU1000_SYS_PINFUNC);
 
 	/* Restore the static memory controller configuration. */
 	au_writel(sleep_static_memctlr[0][0], MEM_STCFG0);
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 93fa586..50e17e1 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -46,7 +46,7 @@
 
 static cycle_t au1x_counter1_read(struct clocksource *cs)
 {
-	return au_readl(SYS_RTCREAD);
+	return alchemy_rdsys(AU1000_SYS_RTCREAD);
 }
 
 static struct clocksource au1x_counter1_clocksource = {
@@ -60,12 +60,11 @@ static struct clocksource au1x_counter1_clocksource = {
 static int au1x_rtcmatch2_set_next_event(unsigned long delta,
 					 struct clock_event_device *cd)
 {
-	delta += au_readl(SYS_RTCREAD);
+	delta += alchemy_rdsys(AU1000_SYS_RTCREAD);
 	/* wait for register access */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M21)
+	while (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_M21)
 		;
-	au_writel(delta, SYS_RTCMATCH2);
-	au_sync();
+	alchemy_wrsys(delta, AU1000_SYS_RTCMATCH2);
 
 	return 0;
 }
@@ -112,31 +111,29 @@ static int __init alchemy_time_init(unsigned int m2int)
 	 * (the 32S bit seems to be stuck set to 1 once a single clock-
 	 * edge is detected, hence the timeouts).
 	 */
-	if (CNTR_OK != (au_readl(SYS_COUNTER_CNTRL) & CNTR_OK))
+	if (CNTR_OK != (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & CNTR_OK))
 		goto cntr_err;
 
 	/*
 	 * setup counter 1 (RTC) to tick at full speed
 	 */
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S) && --t)
+	while ((alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_T1S) && --t)
 		asm volatile ("nop");
 	if (!t)
 		goto cntr_err;
 
-	au_writel(0, SYS_RTCTRIM);	/* 32.768 kHz */
-	au_sync();
+	alchemy_wrsys(0, AU1000_SYS_RTCTRIM);	/* 32.768 kHz */
 
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && --t)
+	while ((alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_C1S) && --t)
 		asm volatile ("nop");
 	if (!t)
 		goto cntr_err;
-	au_writel(0, SYS_RTCWRITE);
-	au_sync();
+	alchemy_wrsys(0, AU1000_SYS_RTCWRITE);
 
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && --t)
+	while ((alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_C1S) && --t)
 		asm volatile ("nop");
 	if (!t)
 		goto cntr_err;
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 92dd929..8201f00 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -518,10 +518,9 @@ int __init db1000_dev_setup(void)
 		gpio_direction_input(20);	/* sd1 cd# */
 
 		/* spi_gpio on SSI0 pins */
-		pfc = __raw_readl((void __iomem *)SYS_PINFUNC);
+		pfc = alchemy_rdsys(AU1000_SYS_PINFUNC);
 		pfc |= (1 << 0);	/* SSI0 pins as GPIOs */
-		__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
-		wmb();
+		alchemy_wrsys(pfc, AU1000_SYS_PINFUNC);
 
 		spi_register_board_info(db1100_spi_info,
 					ARRAY_SIZE(db1100_spi_info));
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 9e46667..408c36f 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -150,12 +150,11 @@ int __init db1200_board_setup(void)
 		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
 
 	/* SMBus/SPI on PSC0, Audio on PSC1 */
-	pfc = __raw_readl((void __iomem *)SYS_PINFUNC);
+	pfc = alchemy_rdsys(AU1000_SYS_PINFUNC);
 	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
 	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
 	pfc |= SYS_PINFUNC_P1C; /* SPI is configured later */
-	__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
-	wmb();
+	alchemy_wrsys(pfc, AU1000_SYS_PINFUNC);
 
 	/* Clock configurations: PSC0: ~50MHz via Clkgen0, derived from
 	 * CPU clock; all other clock generators off/unused.
@@ -166,16 +165,13 @@ int __init db1200_board_setup(void)
 	div = ((div >> 1) - 1) & 0xff;
 
 	freq0 = div << SYS_FC_FRDIV0_BIT;
-	__raw_writel(freq0, (void __iomem *)SYS_FREQCTRL0);
-	wmb();
+	alchemy_wrsys(freq0, AU1000_SYS_FREQCTRL0);
 	freq0 |= SYS_FC_FE0;	/* enable F0 */
-	__raw_writel(freq0, (void __iomem *)SYS_FREQCTRL0);
-	wmb();
+	alchemy_wrsys(freq0, AU1000_SYS_FREQCTRL0);
 
 	/* psc0_intclk comes 1:1 from F0 */
 	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
-	__raw_writel(clksrc, (void __iomem *)SYS_CLKSRC);
-	wmb();
+	alchemy_wrsys(clksrc, AU1000_SYS_CLKSRC);
 
 	return 0;
 }
@@ -886,7 +882,7 @@ int __init db1200_dev_setup(void)
 	 * As a result, in SPI mode, OTG simply won't work (PSC0 uses
 	 * it as an input pin which is pulled high on the boards).
 	 */
-	pfc = __raw_readl((void __iomem *)SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
+	pfc = alchemy_rdsys(AU1000_SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
 
 	/* switch off OTG VBUS supply */
 	gpio_request(215, "otg-vbus");
@@ -912,8 +908,7 @@ int __init db1200_dev_setup(void)
 		printk(KERN_INFO " S6.8 ON : PSC0 mode SPI\n");
 		printk(KERN_INFO "   OTG port VBUS supply disabled\n");
 	}
-	__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
-	wmb();
+	alchemy_wrsys(pfc, AU1000_SYS_PINFUNC);
 
 	/* Audio: DIP7 selects I2S(0)/AC97(1), but need I2C for I2S!
 	 * so: DIP7=1 || DIP8=0 => AC97, DIP7=0 && DIP8=1 => I2S
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index bbd8d98..392fb89 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -31,16 +31,16 @@
 static void __init db1550_hw_setup(void)
 {
 	void __iomem *base;
+	unsigned long v;
 
 	/* complete SPI setup: link psc0_intclk to a 48MHz source,
 	 * and assign GPIO16 to PSC0_SYNC1 (SPI cs# line) as well as PSC1_SYNC
 	 * for AC97 on PB1550.
 	 */
-	base = (void __iomem *)SYS_CLKSRC;
-	__raw_writel(__raw_readl(base) | 0x000001e0, base);
-	base = (void __iomem *)SYS_PINFUNC;
-	__raw_writel(__raw_readl(base) | 1 | SYS_PF_PSC1_S1, base);
-	wmb();
+	v = alchemy_rdsys(AU1000_SYS_CLKSRC);
+	alchemy_wrsys(v | 0x000001e0, AU1000_SYS_CLKSRC);
+	v = alchemy_rdsys(AU1000_SYS_PINFUNC);
+	alchemy_wrsys(v | 1 | SYS_PF_PSC1_S1, AU1000_SYS_PINFUNC);
 
 	/* reset the AC97 codec now, the reset time in the psc-ac97 driver
 	 * is apparently too short although it's ridiculous as it is.
diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
index 61e90fe..bfeb8f3 100644
--- a/arch/mips/alchemy/devboards/pm.c
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -45,23 +45,20 @@ static int db1x_pm_enter(suspend_state_t state)
 	alchemy_gpio1_input_enable();
 
 	/* clear and setup wake cause and source */
-	au_writel(0, SYS_WAKEMSK);
-	au_sync();
-	au_writel(0, SYS_WAKESRC);
-	au_sync();
+	alchemy_wrsys(0, AU1000_SYS_WAKEMSK);
+	alchemy_wrsys(0, AU1000_SYS_WAKESRC);
 
-	au_writel(db1x_pm_wakemsk, SYS_WAKEMSK);
-	au_sync();
+	alchemy_wrsys(db1x_pm_wakemsk, AU1000_SYS_WAKEMSK);
 
 	/* setup 1Hz-timer-based wakeup: wait for reg access */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+	while (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_M20)
 		asm volatile ("nop");
 
-	au_writel(au_readl(SYS_TOYREAD) + db1x_pm_sleep_secs, SYS_TOYMATCH2);
-	au_sync();
+	alchemy_wrsys(alchemy_rdsys(AU1000_SYS_TOYREAD) + db1x_pm_sleep_secs,
+		      AU1000_SYS_TOYMATCH2);
 
 	/* wait for value to really hit the register */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+	while (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_M20)
 		asm volatile ("nop");
 
 	/* ...and now the sandman can come! */
@@ -102,12 +99,10 @@ static void db1x_pm_end(void)
 	/* read and store wakeup source, the clear the register. To
 	 * be able to clear it, WAKEMSK must be cleared first.
 	 */
-	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
-
-	au_writel(0, SYS_WAKEMSK);
-	au_writel(0, SYS_WAKESRC);
-	au_sync();
+	db1x_pm_last_wakesrc = alchemy_rdsys(AU1000_SYS_WAKESRC);
 
+	alchemy_wrsys(0, AU1000_SYS_WAKEMSK);
+	alchemy_wrsys(0, AU1000_SYS_WAKESRC);
 }
 
 static const struct platform_suspend_ops db1x_pm_ops = {
@@ -242,17 +237,13 @@ static int __init pm_init(void)
 	 * for confirmation since there's plenty of time from here to
 	 * the next suspend cycle.
 	 */
-	if (au_readl(SYS_TOYTRIM) != 32767) {
-		au_writel(32767, SYS_TOYTRIM);
-		au_sync();
-	}
+	if (alchemy_rdsys(AU1000_SYS_TOYTRIM) != 32767)
+		alchemy_wrsys(32767, AU1000_SYS_TOYTRIM);
 
-	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
+	db1x_pm_last_wakesrc = alchemy_rdsys(AU1000_SYS_WAKESRC);
 
-	au_writel(0, SYS_WAKESRC);
-	au_sync();
-	au_writel(0, SYS_WAKEMSK);
-	au_sync();
+	alchemy_wrsys(0, AU1000_SYS_WAKESRC);
+	alchemy_wrsys(0, AU1000_SYS_WAKEMSK);
 
 	suspend_set_ops(&db1x_pm_ops);
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 16cd012..c8cfca9 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -335,8 +335,7 @@
 
 
 /* Programmable Counters 0 and 1 */
-#define SYS_BASE		0xB1900000
-#define SYS_COUNTER_CNTRL	(SYS_BASE + 0x14)
+#define AU1000_SYS_CNTRCTRL	0x14
 #  define SYS_CNTRL_E1S		(1 << 23)
 #  define SYS_CNTRL_T1S		(1 << 20)
 #  define SYS_CNTRL_M21		(1 << 19)
@@ -358,24 +357,24 @@
 #  define SYS_CNTRL_C0S		(1 << 0)
 
 /* Programmable Counter 0 Registers */
-#define SYS_TOYTRIM		(SYS_BASE + 0)
-#define SYS_TOYWRITE		(SYS_BASE + 4)
-#define SYS_TOYMATCH0		(SYS_BASE + 8)
-#define SYS_TOYMATCH1		(SYS_BASE + 0xC)
-#define SYS_TOYMATCH2		(SYS_BASE + 0x10)
-#define SYS_TOYREAD		(SYS_BASE + 0x40)
+#define AU1000_SYS_TOYTRIM	0x00
+#define AU1000_SYS_TOYWRITE	0x04
+#define AU1000_SYS_TOYMATCH0	0x08
+#define AU1000_SYS_TOYMATCH1	0x0c
+#define AU1000_SYS_TOYMATCH2	0x10
+#define AU1000_SYS_TOYREAD	0x40
 
 /* Programmable Counter 1 Registers */
-#define SYS_RTCTRIM		(SYS_BASE + 0x44)
-#define SYS_RTCWRITE		(SYS_BASE + 0x48)
-#define SYS_RTCMATCH0		(SYS_BASE + 0x4C)
-#define SYS_RTCMATCH1		(SYS_BASE + 0x50)
-#define SYS_RTCMATCH2		(SYS_BASE + 0x54)
-#define SYS_RTCREAD		(SYS_BASE + 0x58)
+#define AU1000_SYS_RTCTRIM	0x44
+#define AU1000_SYS_RTCWRITE	0x48
+#define AU1000_SYS_RTCMATCH0	0x4c
+#define AU1000_SYS_RTCMATCH1	0x50
+#define AU1000_SYS_RTCMATCH2	0x54
+#define AU1000_SYS_RTCREAD	0x58
 
 
 /* GPIO */
-#define SYS_PINFUNC		0xB190002C
+#define AU1000_SYS_PINFUNC	0x2C
 #  define SYS_PF_USB		(1 << 15)	/* 2nd USB device/host */
 #  define SYS_PF_U3		(1 << 14)	/* GPIO23/U3TXD */
 #  define SYS_PF_U2		(1 << 13)	/* GPIO22/U2TXD */
@@ -445,21 +444,21 @@
 #define SYS_PINFUNC_S1B		(1 << 2)
 
 /* Power Management */
-#define SYS_SCRATCH0		0xB1900018
-#define SYS_SCRATCH1		0xB190001C
-#define SYS_WAKEMSK		0xB1900034
-#define SYS_ENDIAN		0xB1900038
-#define SYS_POWERCTRL		0xB190003C
-#define SYS_WAKESRC		0xB190005C
-#define SYS_SLPPWR		0xB1900078
-#define SYS_SLEEP		0xB190007C
+#define AU1000_SYS_SCRATCH0	0x18
+#define AU1000_SYS_SCRATCH1	0x1c
+#define AU1000_SYS_WAKEMSK	0x34
+#define AU1000_SYS_ENDIAN	0x38
+#define AU1000_SYS_POWERCTRL	0x3c
+#define AU1000_SYS_WAKESRC	0x5c
+#define AU1000_SYS_SLPPWR	0x78
+#define AU1000_SYS_SLEEP	0x7c
 
 #define SYS_WAKEMSK_D2		(1 << 9)
 #define SYS_WAKEMSK_M2		(1 << 8)
 #define SYS_WAKEMSK_GPIO(x)	(1 << (x))
 
 /* Clock Controller */
-#define SYS_FREQCTRL0		0xB1900020
+#define AU1000_SYS_FREQCTRL0	0x20
 #  define SYS_FC_FRDIV2_BIT	22
 #  define SYS_FC_FRDIV2_MASK	(0xff << SYS_FC_FRDIV2_BIT)
 #  define SYS_FC_FE2		(1 << 21)
@@ -472,7 +471,7 @@
 #  define SYS_FC_FRDIV0_MASK	(0xff << SYS_FC_FRDIV0_BIT)
 #  define SYS_FC_FE0		(1 << 1)
 #  define SYS_FC_FS0		(1 << 0)
-#define SYS_FREQCTRL1		0xB1900024
+#define AU1000_SYS_FREQCTRL1	0x24
 #  define SYS_FC_FRDIV5_BIT	22
 #  define SYS_FC_FRDIV5_MASK	(0xff << SYS_FC_FRDIV5_BIT)
 #  define SYS_FC_FE5		(1 << 21)
@@ -485,7 +484,7 @@
 #  define SYS_FC_FRDIV3_MASK	(0xff << SYS_FC_FRDIV3_BIT)
 #  define SYS_FC_FE3		(1 << 1)
 #  define SYS_FC_FS3		(1 << 0)
-#define SYS_CLKSRC		0xB1900028
+#define AU1000_SYS_CLKSRC	0x28
 #  define SYS_CS_ME1_BIT	27
 #  define SYS_CS_ME1_MASK	(0x7 << SYS_CS_ME1_BIT)
 #  define SYS_CS_DE1		(1 << 26)
@@ -525,8 +524,12 @@
 #  define SYS_CS_MUX_FQ3	0x5
 #  define SYS_CS_MUX_FQ4	0x6
 #  define SYS_CS_MUX_FQ5	0x7
-#define SYS_CPUPLL		0xB1900060
-#define SYS_AUXPLL		0xB1900064
+
+#define AU1000_SYS_CPUPLL	0x60
+#define AU1000_SYS_AUXPLL	0x64
+
+
+/**********************************************************************/
 
 
 /* The PCI chip selects are outside the 32bit space, and since we can't
@@ -694,6 +697,22 @@ static inline u32 au_readl(unsigned long reg)
 	return *(volatile u32 *)reg;
 }
 
+/* helpers to access the SYS_* registers */
+static inline unsigned long alchemy_rdsys(int regofs)
+{
+	void __iomem *b = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
+
+	return __raw_readl(b + regofs);
+}
+
+static inline void alchemy_wrsys(unsigned long v, int regofs)
+{
+	void __iomem *b = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
+
+	__raw_writel(v, b + regofs);
+	wmb(); /* drain writebuffer */
+}
+
 /* Early Au1000 have a write-only SYS_CPUPLL register. */
 static inline int au1xxx_cpu_has_pll_wo(void)
 {
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 796afd0..9785e4e 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -25,20 +25,20 @@
 #define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
 
 /* GPIO1 registers within SYS_ area */
-#define SYS_TRIOUTRD		0x100
-#define SYS_TRIOUTCLR		0x100
-#define SYS_OUTPUTRD		0x108
-#define SYS_OUTPUTSET		0x108
-#define SYS_OUTPUTCLR		0x10C
-#define SYS_PINSTATERD		0x110
-#define SYS_PININPUTEN		0x110
+#define AU1000_SYS_TRIOUTRD	0x100
+#define AU1000_SYS_TRIOUTCLR	0x100
+#define AU1000_SYS_OUTPUTRD	0x108
+#define AU1000_SYS_OUTPUTSET	0x108
+#define AU1000_SYS_OUTPUTCLR	0x10C
+#define AU1000_SYS_PINSTATERD	0x110
+#define AU1000_SYS_PININPUTEN	0x110
 
 /* register offsets within GPIO2 block */
-#define GPIO2_DIR		0x00
-#define GPIO2_OUTPUT		0x08
-#define GPIO2_PINSTATE		0x0C
-#define GPIO2_INTENABLE		0x10
-#define GPIO2_ENABLE		0x14
+#define AU1000_GPIO2_DIR	0x00
+#define AU1000_GPIO2_OUTPUT	0x08
+#define AU1000_GPIO2_PINSTATE	0x0C
+#define AU1000_GPIO2_INTENABLE	0x10
+#define AU1000_GPIO2_ENABLE	0x14
 
 struct gpio;
 
@@ -217,26 +217,21 @@ static inline int au1200_irq_to_gpio(int irq)
  */
 static inline void alchemy_gpio1_set_value(int gpio, int v)
 {
-	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
-	unsigned long r = v ? SYS_OUTPUTSET : SYS_OUTPUTCLR;
-	__raw_writel(mask, base + r);
-	wmb();
+	unsigned long r = v ? AU1000_SYS_OUTPUTSET : AU1000_SYS_OUTPUTCLR;
+	alchemy_wrsys(mask, r);
 }
 
 static inline int alchemy_gpio1_get_value(int gpio)
 {
-	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
-	return __raw_readl(base + SYS_PINSTATERD) & mask;
+	return alchemy_rdsys(AU1000_SYS_PINSTATERD) & mask;
 }
 
 static inline int alchemy_gpio1_direction_input(int gpio)
 {
-	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
-	__raw_writel(mask, base + SYS_TRIOUTCLR);
-	wmb();
+	alchemy_wrsys(mask, AU1000_SYS_TRIOUTCLR);
 	return 0;
 }
 
@@ -279,13 +274,13 @@ static inline void __alchemy_gpio2_mod_dir(int gpio, int to_out)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
-	unsigned long d = __raw_readl(base + GPIO2_DIR);
+	unsigned long d = __raw_readl(base + AU1000_GPIO2_DIR);
 
 	if (to_out)
 		d |= mask;
 	else
 		d &= ~mask;
-	__raw_writel(d, base + GPIO2_DIR);
+	__raw_writel(d, base + AU1000_GPIO2_DIR);
 	wmb();
 }
 
@@ -294,14 +289,15 @@ static inline void alchemy_gpio2_set_value(int gpio, int v)
 	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
 	unsigned long mask;
 	mask = ((v) ? 0x00010001 : 0x00010000) << (gpio - ALCHEMY_GPIO2_BASE);
-	__raw_writel(mask, base + GPIO2_OUTPUT);
+	__raw_writel(mask, base + AU1000_GPIO2_OUTPUT);
 	wmb();
 }
 
 static inline int alchemy_gpio2_get_value(int gpio)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
-	return __raw_readl(base + GPIO2_PINSTATE) & (1 << (gpio - ALCHEMY_GPIO2_BASE));
+	return __raw_readl(base + AU1000_GPIO2_PINSTATE) &
+				(1 << (gpio - ALCHEMY_GPIO2_BASE));
 }
 
 static inline int alchemy_gpio2_direction_input(int gpio)
@@ -352,12 +348,12 @@ static inline int alchemy_gpio2_to_irq(int gpio)
 static inline void __alchemy_gpio2_mod_int(int gpio2, int en)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
-	unsigned long r = __raw_readl(base + GPIO2_INTENABLE);
+	unsigned long r = __raw_readl(base + AU1000_GPIO2_INTENABLE);
 	if (en)
 		r |= 1 << gpio2;
 	else
 		r &= ~(1 << gpio2);
-	__raw_writel(r, base + GPIO2_INTENABLE);
+	__raw_writel(r, base + AU1000_GPIO2_INTENABLE);
 	wmb();
 }
 
@@ -434,9 +430,9 @@ static inline void alchemy_gpio2_disable_int(int gpio2)
 static inline void alchemy_gpio2_enable(void)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
-	__raw_writel(3, base + GPIO2_ENABLE);	/* reset, clock enabled */
+	__raw_writel(3, base + AU1000_GPIO2_ENABLE);	/* reset, clock enabled */
 	wmb();
-	__raw_writel(1, base + GPIO2_ENABLE);	/* clock enabled */
+	__raw_writel(1, base + AU1000_GPIO2_ENABLE);	/* clock enabled */
 	wmb();
 }
 
@@ -448,7 +444,7 @@ static inline void alchemy_gpio2_enable(void)
 static inline void alchemy_gpio2_disable(void)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
-	__raw_writel(2, base + GPIO2_ENABLE);	/* reset, clock disabled */
+	__raw_writel(2, base + AU1000_GPIO2_ENABLE);	/* reset, clock disabled */
 	wmb();
 }
 
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index f5443a6..0ea43c0 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -602,7 +602,7 @@ static void au1xmmc_set_clock(struct au1xmmc_host *host, int rate)
 	/* From databook:
 	 * divisor = ((((cpuclock / sbus_divisor) / 2) / mmcclock) / 2) - 1
 	 */
-	pbus /= ((au_readl(SYS_POWERCTRL) & 0x3) + 2);
+	pbus /= ((alchemy_rdsys(AU1000_SYS_POWERCTRL) & 0x3) + 2);
 	pbus /= 2;
 	divisor = ((pbus / rate) / 2) - 1;
 
diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index ed526a1..fd25e23 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -32,7 +32,7 @@ static int au1xtoy_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long t;
 
-	t = au_readl(SYS_TOYREAD);
+	t = alchemy_rdsys(AU1000_SYS_TOYREAD);
 
 	rtc_time_to_tm(t, tm);
 
@@ -45,13 +45,12 @@ static int au1xtoy_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_tm_to_time(tm, &t);
 
-	au_writel(t, SYS_TOYWRITE);
-	au_sync();
+	alchemy_wrsys(t, AU1000_SYS_TOYWRITE);
 
 	/* wait for the pending register write to succeed.  This can
 	 * take up to 6 seconds...
 	 */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+	while (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_C0S)
 		msleep(1);
 
 	return 0;
@@ -68,7 +67,7 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 	unsigned long t;
 	int ret;
 
-	t = au_readl(SYS_COUNTER_CNTRL);
+	t = alchemy_rdsys(AU1000_SYS_CNTRCTRL);
 	if (!(t & CNTR_OK)) {
 		dev_err(&pdev->dev, "counters not working; aborting.\n");
 		ret = -ENODEV;
@@ -78,10 +77,10 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 	ret = -ETIMEDOUT;
 
 	/* set counter0 tickrate to 1Hz if necessary */
-	if (au_readl(SYS_TOYTRIM) != 32767) {
+	if (alchemy_rdsys(AU1000_SYS_TOYTRIM) != 32767) {
 		/* wait until hardware gives access to TRIM register */
 		t = 0x00100000;
-		while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S) && --t)
+		while ((alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_T0S) && --t)
 			msleep(1);
 
 		if (!t) {
@@ -93,12 +92,11 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 		}
 
 		/* set 1Hz TOY tick rate */
-		au_writel(32767, SYS_TOYTRIM);
-		au_sync();
+		alchemy_wrsys(32767, AU1000_SYS_TOYTRIM);
 	}
 
 	/* wait until the hardware allows writes to the counter reg */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+	while (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_C0S)
 		msleep(1);
 
 	rtcdev = devm_rtc_device_register(&pdev->dev, "rtc-au1xxx",
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 372d4ae..c0832ea 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -507,8 +507,9 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* Setup LCD clock to AUX (48 MHz) */
-	sys_clksrc = au_readl(SYS_CLKSRC) & ~(SYS_CS_ML_MASK | SYS_CS_DL | SYS_CS_CL);
-	au_writel((sys_clksrc | (1 << SYS_CS_ML_BIT)), SYS_CLKSRC);
+	sys_clksrc = alchemy_rdsys(AU1000_SYS_CLKSRC);
+	sys_clksrc &= ~(SYS_CS_ML_MASK | SYS_CS_DL | SYS_CS_CL);
+	alchemy_wrsys((sys_clksrc | (1 << SYS_CS_ML_BIT)), AU1000_SYS_CLKSRC);
 
 	/* load the panel info into the var struct */
 	au1100fb_var.bits_per_pixel = fbdev->panel->bpp;
@@ -591,13 +592,13 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 		return 0;
 
 	/* Save the clock source state */
-	sys_clksrc = au_readl(SYS_CLKSRC);
+	sys_clksrc = alchemy_rdsys(AU1000_SYS_CLKSRC);
 
 	/* Blank the LCD */
 	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
 
 	/* Stop LCD clocking */
-	au_writel(sys_clksrc & ~SYS_CS_ML_MASK, SYS_CLKSRC);
+	alchemy_wrsys(sys_clksrc & ~SYS_CS_ML_MASK, AU1000_SYS_CLKSRC);
 
 	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
 
@@ -614,7 +615,7 @@ int au1100fb_drv_resume(struct platform_device *dev)
 	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
 
 	/* Restart LCD clocking */
-	au_writel(sys_clksrc, SYS_CLKSRC);
+	alchemy_wrsys(sys_clksrc, AU1000_SYS_CLKSRC);
 
 	/* Unblank the LCD */
 	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 4cfba78..2d77334 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -830,10 +830,10 @@ static void au1200_setpanel(struct panel_settings *newpanel,
 	if (!(panel->mode_clkcontrol & LCD_CLKCONTROL_EXT))
 	{
 		uint32 sys_clksrc;
-		au_writel(panel->mode_auxpll, SYS_AUXPLL);
-		sys_clksrc = au_readl(SYS_CLKSRC) & ~0x0000001f;
+		alchemy_wrsys(panel->mode_auxpll, AU1000_SYS_AUXPLL);
+		sys_clksrc = alchemy_rdsys(AU1000_SYS_CLKSRC) & ~0x0000001f;
 		sys_clksrc |= panel->mode_toyclksrc;
-		au_writel(sys_clksrc, SYS_CLKSRC);
+		alchemy_wrsys(sys_clksrc, AU1000_SYS_CLKSRC);
 	}
 
 	/*
-- 
2.0.1
