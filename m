Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 22:54:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60443 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994854AbdHWUyUFuLTs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 22:54:20 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 65C27DAC48524;
        Wed, 23 Aug 2017 21:54:08 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 21:54:12
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] MIPS: Remove custom implementations CPU hang implementations
Date:   Wed, 23 Aug 2017 13:53:17 -0700
Message-ID: <20170823205317.4828-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170823205317.4828-1-paul.burton@imgtec.com>
References: <20170823205317.4828-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Many platforms implement variations upon the same theme of hanging the
CPU using an infinite loop in their _machine_halt, _machine_restart or
pm_power_off callbacks. Our generic machine_halt(), machine_restart() &
machine_power_off() functions will do this for us if the platform
doesn't specify the appropriate callback or the callback function
returns, so there's no need for each platform to implement the same
thing.

This patch removes many platforms implementations of this functionality,
leaving it to the generic code to handle.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/alchemy/board-gpr.c          |  8 --------
 arch/mips/alchemy/board-mtx1.c         | 11 -----------
 arch/mips/alchemy/board-xxs1500.c      | 11 -----------
 arch/mips/alchemy/devboards/platform.c |  2 --
 arch/mips/ar7/setup.c                  |  8 --------
 arch/mips/ath25/board.c                |  9 ---------
 arch/mips/ath79/setup.c                |  9 ---------
 arch/mips/bcm47xx/setup.c              |  4 ----
 arch/mips/bcm63xx/setup.c              |  9 ---------
 arch/mips/cobalt/reset.c               |  4 ----
 arch/mips/emma/markeins/setup.c        |  2 --
 arch/mips/jz4740/reset.c               | 13 -------------
 arch/mips/lantiq/falcon/reset.c        | 14 --------------
 arch/mips/lantiq/xway/reset.c          | 14 --------------
 arch/mips/lasat/reset.c                |  1 -
 arch/mips/loongson32/common/reset.c    | 17 -----------------
 arch/mips/loongson64/common/reset.c    | 18 ------------------
 arch/mips/netlogic/xlp/setup.c         |  2 --
 arch/mips/netlogic/xlr/setup.c         |  2 --
 arch/mips/pic32/common/reset.c         | 22 ----------------------
 arch/mips/pmcs-msp71xx/msp_setup.c     | 18 ------------------
 arch/mips/pnx833x/common/reset.c       | 12 ------------
 arch/mips/pnx833x/common/setup.c       |  4 ----
 arch/mips/ralink/reset.c               |  7 -------
 arch/mips/rb532/setup.c                |  8 --------
 arch/mips/sgi-ip22/ip22-reset.c        |  1 -
 arch/mips/txx9/generic/setup.c         | 24 ------------------------
 arch/mips/vr41xx/common/pmu.c          |  1 -
 28 files changed, 255 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 6fb6b3faa158..218d1255a4cb 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -80,18 +80,10 @@ static void gpr_reset(char *c)
 		cpu_wait();
 }
 
-static void gpr_power_off(void)
-{
-	while (1)
-		cpu_wait();
-}
-
 void __init board_setup(void)
 {
 	printk(KERN_INFO "Trapeze ITS GPR board\n");
 
-	pm_power_off = gpr_power_off;
-	_machine_halt = gpr_power_off;
 	_machine_restart = gpr_reset;
 
 	/* Enable UART1/3 */
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 85bb75669b0d..24880e117bfa 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -69,15 +69,6 @@ static void mtx1_reset(char *c)
 	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
 }
 
-static void mtx1_power_off(void)
-{
-	while (1)
-		asm volatile (
-		"	.set	mips32					\n"
-		"	wait						\n"
-		"	.set	mips0					\n");
-}
-
 void __init board_setup(void)
 {
 #if IS_ENABLED(CONFIG_USB_OHCI_HCD)
@@ -99,8 +90,6 @@ void __init board_setup(void)
 	alchemy_gpio_direction_output(211, 1);	/* green on */
 	alchemy_gpio_direction_output(212, 0);	/* red off */
 
-	pm_power_off = mtx1_power_off;
-	_machine_halt = mtx1_power_off;
 	_machine_restart = mtx1_reset;
 
 	printk(KERN_INFO "4G Systems MTX-1 Board\n");
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index 0fc53e08a894..40dd0a9b55be 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -66,21 +66,10 @@ static void xxs1500_reset(char *c)
 	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
 }
 
-static void xxs1500_power_off(void)
-{
-	while (1)
-		asm volatile (
-		"	.set	mips32					\n"
-		"	wait						\n"
-		"	.set	mips0					\n");
-}
-
 void __init board_setup(void)
 {
 	u32 pin_func;
 
-	pm_power_off = xxs1500_power_off;
-	_machine_halt = xxs1500_power_off;
 	_machine_restart = xxs1500_reset;
 
 	alchemy_gpio1_input_enable();
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index be139a0198b0..fd9831f663f3 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -54,8 +54,6 @@ static void db1x_power_off(void)
 {
 	bcsr_write(BCSR_RESETS, 0);
 	bcsr_write(BCSR_SYSTEM, BCSR_SYSTEM_PWROFF | BCSR_SYSTEM_RESET);
-	while (1)		/* sit and spin */
-		cpu_wait();
 }
 
 static void db1x_reset(char *c)
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 7bb9a670bb73..8d5eb1b9150e 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -31,19 +31,12 @@ static void ar7_machine_restart(char *command)
 	writel(1, softres_reg);
 }
 
-static void ar7_machine_halt(void)
-{
-	while (1)
-		;
-}
-
 static void ar7_machine_power_off(void)
 {
 	u32 *power_reg = (u32 *)ioremap(AR7_REGS_POWER, 1);
 	u32 power_state = readl(power_reg) | (3 << 30);
 
 	writel(power_state, power_reg);
-	ar7_machine_halt();
 }
 
 const char *get_system_type(void)
@@ -89,7 +82,6 @@ void __init plat_mem_setup(void)
 	unsigned long io_base;
 
 	_machine_restart = ar7_machine_restart;
-	_machine_halt = ar7_machine_halt;
 	pm_power_off = ar7_machine_power_off;
 
 	io_base = (unsigned long)ioremap(AR7_REGS_BASE, 0x10000);
diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 9ab48ff80c1c..3629b652285c 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -183,17 +183,8 @@ int __init ath25_find_config(phys_addr_t base, unsigned long size)
 	return -ENODEV;
 }
 
-static void ath25_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 void __init plat_mem_setup(void)
 {
-	_machine_halt = ath25_halt;
-	pm_power_off = ath25_halt;
-
 	if (is_ar5312())
 		ar5312_plat_mem_setup();
 	else
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index f206dafbb0a3..ce28428cf256 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -46,12 +46,6 @@ static void ath79_restart(char *command)
 			cpu_wait();
 }
 
-static void ath79_halt(void)
-{
-	while (1)
-		cpu_wait();
-}
-
 static void __init ath79_detect_sys_type(void)
 {
 	char *chip = "????";
@@ -219,9 +213,6 @@ void __init plat_mem_setup(void)
 		/* OF machines should use the reset driver */
 		_machine_restart = ath79_restart;
 	}
-
-	_machine_halt = ath79_halt;
-	pm_power_off = ath79_halt;
 }
 
 static void __init ath79_of_plat_time_init(void)
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 6054d49e608e..f7ab6b4085ad 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -77,8 +77,6 @@ static void bcm47xx_machine_restart(char *command)
 		break;
 #endif
 	}
-	while (1)
-		cpu_relax();
 }
 
 static void bcm47xx_machine_halt(void)
@@ -97,8 +95,6 @@ static void bcm47xx_machine_halt(void)
 		break;
 #endif
 	}
-	while (1)
-		cpu_relax();
 }
 
 #ifdef CONFIG_BCM47XX_SSB
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 2be9caaa2085..43a9617a19af 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -22,13 +22,6 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_gpio.h>
 
-void bcm63xx_machine_halt(void)
-{
-	pr_info("System halted\n");
-	while (1)
-		;
-}
-
 static void bcm6348_a1_reboot(void)
 {
 	u32 reg;
@@ -148,9 +141,7 @@ void __init plat_mem_setup(void)
 {
 	add_memory_region(0, bcm63xx_get_memory_size(), BOOT_MEM_RAM);
 
-	_machine_halt = bcm63xx_machine_halt;
 	_machine_restart = __bcm63xx_machine_reboot;
-	pm_power_off = bcm63xx_machine_halt;
 
 	set_io_port_base(0);
 	ioport_resource.start = 0;
diff --git a/arch/mips/cobalt/reset.c b/arch/mips/cobalt/reset.c
index 4eedd481dd00..727f139ed460 100644
--- a/arch/mips/cobalt/reset.c
+++ b/arch/mips/cobalt/reset.c
@@ -37,10 +37,6 @@ void cobalt_machine_halt(void)
 	led_trigger_event(power_off_led_trigger, LED_FULL);
 
 	local_irq_disable();
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
 }
 
 void cobalt_machine_restart(char *command)
diff --git a/arch/mips/emma/markeins/setup.c b/arch/mips/emma/markeins/setup.c
index 44ff64a80255..1d0bd438e463 100644
--- a/arch/mips/emma/markeins/setup.c
+++ b/arch/mips/emma/markeins/setup.c
@@ -47,13 +47,11 @@ static void markeins_machine_halt(void)
 {
 	printk("EMMA2RH Mark-eins halted.\n");
 	markeins_led("halted.");
-	while (1) ;
 }
 
 static void markeins_machine_power_off(void)
 {
 	markeins_led("poweroff.");
-	while (1) ;
 }
 
 static unsigned long __initdata emma2rh_clock[4] = {
diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 67780c4b6573..e1a78e45c875 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -25,17 +25,6 @@
 #include "reset.h"
 #include "clock.h"
 
-static void jz4740_halt(void)
-{
-	while (1) {
-		__asm__(".set push;\n"
-			".set mips3;\n"
-			"wait;\n"
-			".set pop;\n"
-		);
-	}
-}
-
 #define JZ_REG_WDT_DATA 0x00
 #define JZ_REG_WDT_COUNTER_ENABLE 0x04
 #define JZ_REG_WDT_COUNTER 0x08
@@ -54,11 +43,9 @@ static void jz4740_restart(char *command)
 	writew(BIT(2), wdt_base + JZ_REG_WDT_CTRL);
 
 	writeb(1, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-	jz4740_halt();
 }
 
 void jz4740_reset_init(void)
 {
 	_machine_restart = jz4740_restart;
-	_machine_halt = jz4740_halt;
 }
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
index 7a535d72f541..024d10f353c6 100644
--- a/arch/mips/lantiq/falcon/reset.c
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -67,23 +67,9 @@ static void machine_restart(char *command)
 	unreachable();
 }
 
-static void machine_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
-static void machine_power_off(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = machine_restart;
-	_machine_halt = machine_halt;
-	pm_power_off = machine_power_off;
 	return 0;
 }
 
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 83fd65d76e81..40f64c828647 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -295,18 +295,6 @@ static void ltq_machine_restart(char *command)
 	unreachable();
 }
 
-static void ltq_machine_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
-static void ltq_machine_power_off(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static void ltq_usb_init(void)
 {
 	/* Power for USB cores 1 & 2 */
@@ -378,8 +366,6 @@ static int __init mips_reboot_setup(void)
 			    RCU_AHB_ENDIAN);
 
 	_machine_restart = ltq_machine_restart;
-	_machine_halt = ltq_machine_halt;
-	pm_power_off = ltq_machine_power_off;
 
 	return 0;
 }
diff --git a/arch/mips/lasat/reset.c b/arch/mips/lasat/reset.c
index e21f0b9a586e..d4a5d5b787a9 100644
--- a/arch/mips/lasat/reset.c
+++ b/arch/mips/lasat/reset.c
@@ -49,7 +49,6 @@ static void lasat_machine_halt(void)
 	local_irq_disable();
 
 	prom_monitor();
-	for (;;) ;
 }
 
 void lasat_reboot_setup(void)
diff --git a/arch/mips/loongson32/common/reset.c b/arch/mips/loongson32/common/reset.c
index 8a1d9cc5a134..e7c107fb0c1e 100644
--- a/arch/mips/loongson32/common/reset.c
+++ b/arch/mips/loongson32/common/reset.c
@@ -17,26 +17,11 @@
 
 static void __iomem *wdt_reg_base;
 
-static void ls1x_halt(void)
-{
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
-}
-
 static void ls1x_restart(char *command)
 {
 	__raw_writel(0x1, wdt_reg_base + WDT_EN);
 	__raw_writel(0x1, wdt_reg_base + WDT_TIMER);
 	__raw_writel(0x1, wdt_reg_base + WDT_SET);
-
-	ls1x_halt();
-}
-
-static void ls1x_power_off(void)
-{
-	ls1x_halt();
 }
 
 static int __init ls1x_reboot_setup(void)
@@ -46,8 +31,6 @@ static int __init ls1x_reboot_setup(void)
 		panic("Failed to remap watchdog registers");
 
 	_machine_restart = ls1x_restart;
-	_machine_halt = ls1x_halt;
-	pm_power_off = ls1x_power_off;
 
 	return 0;
 }
diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/common/reset.c
index a60715e11306..ec290392c175 100644
--- a/arch/mips/loongson64/common/reset.c
+++ b/arch/mips/loongson64/common/reset.c
@@ -48,10 +48,6 @@ static void loongson_restart(char *command)
 	void (*fw_restart)(void) = (void *)loongson_sysconf.restart_addr;
 
 	fw_restart();
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
 #endif
 }
 
@@ -64,26 +60,12 @@ static void loongson_poweroff(void)
 	void (*fw_poweroff)(void) = (void *)loongson_sysconf.poweroff_addr;
 
 	fw_poweroff();
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
 #endif
 }
 
-static void loongson_halt(void)
-{
-	pr_notice("\n\n** You can safely turn off the power now **\n\n");
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = loongson_restart;
-	_machine_halt = loongson_halt;
 	pm_power_off = loongson_poweroff;
 
 	return 0;
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index f743fd9da323..c5fde7546ba5 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -60,8 +60,6 @@ static void nlm_linux_exit(void)
 		nlm_write_sys_reg(sysbase, SYS_9XX_CHIP_RESET, 1);
 	else
 		nlm_write_sys_reg(sysbase, SYS_CHIP_RESET, 1);
-	for ( ; ; )
-		cpu_wait();
 }
 
 static void nlm_fixup_mem(void)
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 72ceddc9a03f..45c6a13d8ffd 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -67,8 +67,6 @@ static void nlm_linux_exit(void)
 	gpiobase = nlm_mmio_base(NETLOGIC_IO_GPIO_OFFSET);
 	/* trigger a chip reset by writing 1 to GPIO_SWRESET_REG */
 	nlm_write_reg(gpiobase, GPIO_SWRESET_REG, 1);
-	for ( ; ; )
-		cpu_wait();
 }
 
 void __init plat_mem_setup(void)
diff --git a/arch/mips/pic32/common/reset.c b/arch/mips/pic32/common/reset.c
index 83345757be5f..2afd9dd0e0e2 100644
--- a/arch/mips/pic32/common/reset.c
+++ b/arch/mips/pic32/common/reset.c
@@ -18,17 +18,6 @@
 
 #define PIC32_RSWRST		0x10
 
-static void pic32_halt(void)
-{
-	while (1) {
-		__asm__(".set push;\n"
-			".set arch=r4000;\n"
-			"wait;\n"
-			".set pop;\n"
-		);
-	}
-}
-
 static void pic32_machine_restart(char *command)
 {
 	void __iomem *reg =
@@ -39,22 +28,11 @@ static void pic32_machine_restart(char *command)
 	/* magic write/read */
 	__raw_writel(1, reg);
 	(void)__raw_readl(reg);
-
-	pic32_halt();
-}
-
-static void pic32_machine_halt(void)
-{
-	local_irq_disable();
-
-	pic32_halt();
 }
 
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = pic32_machine_restart;
-	_machine_halt = pic32_machine_halt;
-	pm_power_off = pic32_machine_halt;
 
 	return 0;
 }
diff --git a/arch/mips/pmcs-msp71xx/msp_setup.c b/arch/mips/pmcs-msp71xx/msp_setup.c
index a63b73610fd4..45d6d59b896e 100644
--- a/arch/mips/pmcs-msp71xx/msp_setup.c
+++ b/arch/mips/pmcs-msp71xx/msp_setup.c
@@ -125,27 +125,9 @@ void msp_restart(char *command)
 #endif
 }
 
-void msp_halt(void)
-{
-	printk(KERN_WARNING "\n** You can safely turn off the power\n");
-	while (1)
-		/* If possible call official function to get CPU WARs */
-		if (cpu_wait)
-			(*cpu_wait)();
-		else
-			__asm__(".set\tmips3\n\t" "wait\n\t" ".set\tmips0");
-}
-
-void msp_power_off(void)
-{
-	msp_halt();
-}
-
 void __init plat_mem_setup(void)
 {
 	_machine_restart = msp_restart;
-	_machine_halt = msp_halt;
-	pm_power_off = msp_power_off;
 }
 
 void __init prom_init(void)
diff --git a/arch/mips/pnx833x/common/reset.c b/arch/mips/pnx833x/common/reset.c
index 5cc9a9b3601c..e0f38c23d2b1 100644
--- a/arch/mips/pnx833x/common/reset.c
+++ b/arch/mips/pnx833x/common/reset.c
@@ -30,15 +30,3 @@ void pnx833x_machine_restart(char *command)
 	PNX833X_RESET_CONTROL_2 = 0;
 	PNX833X_RESET_CONTROL = 0;
 }
-
-void pnx833x_machine_halt(void)
-{
-	while (1)
-		__asm__ __volatile__ ("wait");
-
-}
-
-void pnx833x_machine_power_off(void)
-{
-	pnx833x_machine_halt();
-}
diff --git a/arch/mips/pnx833x/common/setup.c b/arch/mips/pnx833x/common/setup.c
index 8a7443b2535e..72e310286029 100644
--- a/arch/mips/pnx833x/common/setup.c
+++ b/arch/mips/pnx833x/common/setup.c
@@ -33,8 +33,6 @@
 
 extern void pnx833x_board_setup(void);
 extern void pnx833x_machine_restart(char *);
-extern void pnx833x_machine_halt(void);
-extern void pnx833x_machine_power_off(void);
 
 int __init plat_mem_setup(void)
 {
@@ -47,8 +45,6 @@ int __init plat_mem_setup(void)
 	pnx833x_board_setup();
 
 	_machine_restart = pnx833x_machine_restart;
-	_machine_halt = pnx833x_machine_halt;
-	pm_power_off = pnx833x_machine_power_off;
 
 	/* IO/MEM resources. */
 	set_io_port_base(KSEG1);
diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 64543d66e76b..e9531fea23a2 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -96,16 +96,9 @@ static void ralink_restart(char *command)
 	unreachable();
 }
 
-static void ralink_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
-	_machine_halt = ralink_halt;
 
 	return 0;
 }
diff --git a/arch/mips/rb532/setup.c b/arch/mips/rb532/setup.c
index d0c64e71d532..7d4e1643343d 100644
--- a/arch/mips/rb532/setup.c
+++ b/arch/mips/rb532/setup.c
@@ -32,19 +32,11 @@ static void rb_machine_restart(char *command)
 	((void (*)(void)) KSEG1ADDR(0x1FC00000u))();
 }
 
-static void rb_machine_halt(void)
-{
-	for (;;)
-		continue;
-}
-
 void __init plat_mem_setup(void)
 {
 	u32 val;
 
 	_machine_restart = rb_machine_restart;
-	_machine_halt = rb_machine_halt;
-	pm_power_off = rb_machine_halt;
 
 	set_io_port_base(KSEG1);
 
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 03a39ac5ead9..ce1f435f31de 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -71,7 +71,6 @@ static void __noreturn sgi_machine_restart(char *command)
 	if (machine_state & MACHINE_SHUTTING_DOWN)
 		sgi_machine_power_off();
 	sgimc->cpuctrl0 |= SGIMC_CCTRL0_SYSINIT;
-	while (1);
 }
 
 static void __noreturn sgi_machine_halt(void)
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 1791a44ee570..c58ab1bdd3e5 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -370,25 +370,6 @@ const char *__init prom_getenv(const char *name)
 	return NULL;
 }
 
-static void __noreturn txx9_machine_halt(void)
-{
-	local_irq_disable();
-	clear_c0_status(ST0_IM);
-	while (1) {
-		if (cpu_wait) {
-			(*cpu_wait)();
-			if (cpu_has_counter) {
-				/*
-				 * Clear counter interrupt while it
-				 * breaks WAIT instruction even if
-				 * masked.
-				 */
-				write_c0_compare(0);
-			}
-		}
-	}
-}
-
 /* Watchdog support */
 void __init txx9_wdt_init(unsigned long base)
 {
@@ -503,11 +484,6 @@ void __init plat_mem_setup(void)
 	iomem_resource.start = 0;
 	iomem_resource.end = ~0UL;	/* no limit */
 
-	/* fallback restart/halt routines */
-	_machine_restart = (void (*)(char *))txx9_machine_halt;
-	_machine_halt = txx9_machine_halt;
-	pm_power_off = txx9_machine_halt;
-
 #ifdef CONFIG_PCI
 	pcibios_plat_setup = txx9_pcibios_setup;
 #endif
diff --git a/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
index 39a0db3e2b34..65157b686b5c 100644
--- a/arch/mips/vr41xx/common/pmu.c
+++ b/arch/mips/vr41xx/common/pmu.c
@@ -84,7 +84,6 @@ static void vr41xx_restart(char *command)
 {
 	local_irq_disable();
 	software_reset();
-	while (1) ;
 }
 
 static void vr41xx_halt(void)
-- 
2.14.1
