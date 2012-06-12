Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:25:15 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54586 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab2FLIYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:36 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so5334449bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hLfvLg5B53OwPVburhNT1DE3M90UvLx1tvb8f4AaZ9w=;
        b=vEeCP7h2MH/WhTBwqx2Huyr+2kwwyg3YF0Bi2OBRYu0VP3ehwJ0yJmXvgTnvLSlHQX
         Jdh/rhO/6LVUPczQ6kvw5gbOc1SHwt1+eHQurgOr3qEGph+eOvXjQ5x5oCcPhkjCVEUV
         5+QFfxULKrHTbGMtZYN99RHeLmZMgrhw0fKn4jK5urC4bAPJJCHmC0nYdt0QIAInrzQ4
         dZ10LoR8KpRHoeD7Ij6r4mTRyVuvVGg899Xk6K+XKgJd86yOrefE92Exjc4JhnH2bNIx
         IIpvyhASSCMbbPa4JsU58bsO+CF+YoNNTyqr/x+n4rkVSlXfaBtn6nRJ1WpH3bGZuOsf
         J+4Q==
Received: by 10.204.157.23 with SMTP id z23mr11608341bkw.71.1339489476096;
        Tue, 12 Jun 2012 01:24:36 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.34
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:35 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 4/8] MIPS: BCM63XX: add basic BCM6328 CPU support
Date:   Tue, 12 Jun 2012 10:23:41 +0200
Message-Id: <1339489425-19037-5-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

Add basic BCM6328 support. This includes CPU speed, memory size
detection and working uart, but no support for attached flashes,
lacking the appropriate drivers.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/Kconfig                         |    3 +
 arch/mips/bcm63xx/boards/board_bcm963xx.c         |   12 ++-
 arch/mips/bcm63xx/cpu.c                           |   43 ++++++++
 arch/mips/bcm63xx/dev-flash.c                     |    6 +
 arch/mips/bcm63xx/dev-spi.c                       |    2 +-
 arch/mips/bcm63xx/irq.c                           |   21 ++++
 arch/mips/bcm63xx/prom.c                          |    4 +-
 arch/mips/bcm63xx/setup.c                         |   13 ++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  111 ++++++++++++++++++++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h   |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   54 ++++++++++
 arch/mips/include/asm/mach-bcm63xx/ioremap.h      |    1 +
 13 files changed, 265 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 6b1b9ad..09e93ca 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -1,6 +1,9 @@
 menu "CPU support"
 	depends on BCM63XX
 
+config BCM63XX_CPU_6328
+	bool "support 6328 CPU"
+
 config BCM63XX_CPU_6338
 	bool "support 6338 CPU"
 	select HW_HAS_PCI
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index bdfbdf9..be7498a 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -708,9 +708,15 @@ void __init board_prom_init(void)
 	char cfe_version[32];
 	u32 val;
 
-	/* read base address of boot chip select (0) */
-	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-	val &= MPI_CSBASE_BASE_MASK;
+	/* read base address of boot chip select (0)
+	 * 6328 does not have MPI but boots from a fixed address
+	 */
+	if (BCMCPU_IS_6328())
+		val = 0x18000000;
+	else {
+		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+		val &= MPI_CSBASE_BASE_MASK;
+	}
 	boot_addr = (u8 *)KSEG1ADDR(val);
 
 	/* dump cfe version */
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index e3c1da5..a7afb28 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -29,6 +29,14 @@ static u16 bcm63xx_cpu_rev;
 static unsigned int bcm63xx_cpu_freq;
 static unsigned int bcm63xx_memory_size;
 
+static const unsigned long bcm6328_regs_base[] = {
+	__GEN_CPU_REGS_TABLE(6328)
+};
+
+static const int bcm6328_irqs[] = {
+	__GEN_CPU_IRQ_TABLE(6328)
+};
+
 static const unsigned long bcm6338_regs_base[] = {
 	__GEN_CPU_REGS_TABLE(6338)
 };
@@ -99,6 +107,33 @@ unsigned int bcm63xx_get_memory_size(void)
 static unsigned int detect_cpu_clock(void)
 {
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+	{
+		unsigned int tmp, mips_pll_fcvo;
+
+		tmp = bcm_misc_readl(MISC_STRAPBUS_6328_REG);
+		mips_pll_fcvo = (tmp & STRAPBUS_6328_FCVO_MASK)
+				>> STRAPBUS_6328_FCVO_SHIFT;
+
+		switch (mips_pll_fcvo) {
+		case 0x12:
+		case 0x14:
+		case 0x19:
+			return 160000000;
+		case 0x1c:
+			return 192000000;
+		case 0x13:
+		case 0x15:
+			return 200000000;
+		case 0x1a:
+			return 384000000;
+		case 0x16:
+			return 400000000;
+		default:
+			return 320000000;
+		}
+
+	}
 	case BCM6338_CPU_ID:
 		/* BCM6338 has a fixed 240 Mhz frequency */
 		return 240000000;
@@ -170,6 +205,9 @@ static unsigned int detect_memory_size(void)
 	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
 	u32 val;
 
+	if (BCMCPU_IS_6328())
+		return bcm_ddr_readl(DDR_CSEND_REG) << 24;
+
 	if (BCMCPU_IS_6345()) {
 		val = bcm_sdram_readl(SDRAM_MBASE_REG);
 		return (val * 8 * 1024 * 1024);
@@ -237,6 +275,11 @@ void __init bcm63xx_cpu_init(void)
 			u16 chip_id = bcm_readw(BCM_6368_PERF_BASE);
 
 			switch (chip_id) {
+			case BCM6328_CPU_ID:
+				expected_cpu_id = BCM6328_CPU_ID;
+				bcm63xx_regs_base = bcm6328_regs_base;
+				bcm63xx_irqs = bcm6328_irqs;
+				break;
 			case BCM6368_CPU_ID:
 				expected_cpu_id = BCM6368_CPU_ID;
 				bcm63xx_regs_base = bcm6368_regs_base;
diff --git a/arch/mips/bcm63xx/dev-flash.c b/arch/mips/bcm63xx/dev-flash.c
index 1051fae..58371c7 100644
--- a/arch/mips/bcm63xx/dev-flash.c
+++ b/arch/mips/bcm63xx/dev-flash.c
@@ -60,6 +60,12 @@ static int __init bcm63xx_detect_flash_type(void)
 	u32 val;
 
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		val = bcm_misc_readl(MISC_STRAPBUS_6328_REG);
+		if (val & STRAPBUS_6328_BOOT_SEL_SERIAL)
+			return BCM63XX_FLASH_TYPE_SERIAL;
+		else
+			return BCM63XX_FLASH_TYPE_NAND;
 	case BCM6338_CPU_ID:
 	case BCM6345_CPU_ID:
 	case BCM6348_CPU_ID:
diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index 67fa45b..e39f730 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -87,7 +87,7 @@ int __init bcm63xx_spi_register(void)
 {
 	struct clk *periph_clk;
 
-	if (BCMCPU_IS_6345())
+	if (BCMCPU_IS_6328() || BCMCPU_IS_6345())
 		return -ENODEV;
 
 	periph_clk = clk_get(NULL, "periph");
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 9a216a4..18e051a 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -27,6 +27,17 @@ static void __internal_irq_unmask_32(unsigned int irq) __maybe_unused;
 static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 
 #ifndef BCMCPU_RUNTIME_DETECT
+#ifdef CONFIG_BCM63XX_CPU_6328
+#define irq_stat_reg		PERF_IRQSTAT_6328_REG
+#define irq_mask_reg		PERF_IRQMASK_6328_REG
+#define irq_bits		64
+#define is_ext_irq_cascaded	1
+#define ext_irq_start		(BCM_6328_EXT_IRQ0 - IRQ_INTERNAL_BASE)
+#define ext_irq_end		(BCM_6328_EXT_IRQ3 - IRQ_INTERNAL_BASE)
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6328
+#define ext_irq_cfg_reg2	0
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6338
 #define irq_stat_reg		PERF_IRQSTAT_6338_REG
 #define irq_mask_reg		PERF_IRQMASK_6338_REG
@@ -118,6 +129,16 @@ static void bcm63xx_init_irq(void)
 	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
 
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6328_REG;
+		irq_mask_addr += PERF_IRQMASK_6328_REG;
+		irq_bits = 64;
+		ext_irq_count = 4;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6328_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6328_EXT_IRQ3 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6328;
+		break;
 	case BCM6338_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6338_REG;
 		irq_mask_addr += PERF_IRQMASK_6338_REG;
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 99d7f40..10eaff4 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -26,7 +26,9 @@ void __init prom_init(void)
 	bcm_wdt_writel(WDT_STOP_2, WDT_CTL_REG);
 
 	/* disable all hardware blocks clock for now */
-	if (BCMCPU_IS_6338())
+	if (BCMCPU_IS_6328())
+		mask = CKCTL_6328_ALL_SAFE_EN;
+	else if (BCMCPU_IS_6338())
 		mask = CKCTL_6338_ALL_SAFE_EN;
 	else if (BCMCPU_IS_6345())
 		mask = CKCTL_6345_ALL_SAFE_EN;
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 356b055..0e74a13 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -68,6 +68,9 @@ void bcm63xx_machine_reboot(void)
 
 	/* mask and clear all external irq */
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6328;
+		break;
 	case BCM6338_CPU_ID:
 		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6338;
 		break;
@@ -95,9 +98,13 @@ void bcm63xx_machine_reboot(void)
 		bcm6348_a1_reboot();
 
 	printk(KERN_INFO "triggering watchdog soft-reset...\n");
-	reg = bcm_perf_readl(PERF_SYS_PLL_CTL_REG);
-	reg |= SYS_PLL_SOFT_RESET;
-	bcm_perf_writel(reg, PERF_SYS_PLL_CTL_REG);
+	if (BCMCPU_IS_6328()) {
+		bcm_wdt_writel(1, WDT_SOFTRESET_REG);
+	} else {
+		reg = bcm_perf_readl(PERF_SYS_PLL_CTL_REG);
+		reg |= SYS_PLL_SOFT_RESET;
+		bcm_perf_writel(reg, PERF_SYS_PLL_CTL_REG);
+	}
 	while (1)
 		;
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 0c981aa..b842b6d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -9,6 +9,7 @@
  * compile time if only one CPU support is enabled (idea stolen from
  * arm mach-types)
  */
+#define BCM6328_CPU_ID		0x6328
 #define BCM6338_CPU_ID		0x6338
 #define BCM6345_CPU_ID		0x6345
 #define BCM6348_CPU_ID		0x6348
@@ -20,6 +21,19 @@ u16 __bcm63xx_get_cpu_id(void);
 u16 bcm63xx_get_cpu_rev(void);
 unsigned int bcm63xx_get_cpu_freq(void);
 
+#ifdef CONFIG_BCM63XX_CPU_6328
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6328_CPU_ID
+# endif
+# define BCMCPU_IS_6328()	(bcm63xx_get_cpu_id() == BCM6328_CPU_ID)
+#else
+# define BCMCPU_IS_6328()	(0)
+#endif
+
 #ifdef CONFIG_BCM63XX_CPU_6338
 # ifdef bcm63xx_get_cpu_id
 #  undef bcm63xx_get_cpu_id
@@ -129,7 +143,8 @@ enum bcm63xx_regs_set {
 	RSET_PCMDMA,
 	RSET_PCMDMAC,
 	RSET_PCMDMAS,
-	RSET_RNG
+	RSET_RNG,
+	RSET_MISC
 };
 
 #define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
@@ -156,6 +171,49 @@ enum bcm63xx_regs_set {
 #define RSET_RNG_SIZE			20
 
 /*
+ * 6328 register sets base address
+ */
+#define BCM_6328_DSL_LMEM_BASE		(0xdeadbeef)
+#define BCM_6328_PERF_BASE		(0xb0000000)
+#define BCM_6328_TIMER_BASE		(0xb0000040)
+#define BCM_6328_WDT_BASE		(0xb000005c)
+#define BCM_6328_UART0_BASE             (0xb0000100)
+#define BCM_6328_UART1_BASE		(0xb0000120)
+#define BCM_6328_GPIO_BASE		(0xb0000080)
+#define BCM_6328_SPI_BASE		(0xdeadbeef)
+#define BCM_6328_UDC0_BASE		(0xdeadbeef)
+#define BCM_6328_USBDMA_BASE		(0xdeadbeef)
+#define BCM_6328_OHCI0_BASE		(0xdeadbeef)
+#define BCM_6328_OHCI_PRIV_BASE		(0xdeadbeef)
+#define BCM_6328_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6328_MPI_BASE		(0xdeadbeef)
+#define BCM_6328_PCMCIA_BASE		(0xdeadbeef)
+#define BCM_6328_SDRAM_REGS_BASE	(0xdeadbeef)
+#define BCM_6328_DSL_BASE		(0xb0001900)
+#define BCM_6328_UBUS_BASE		(0xdeadbeef)
+#define BCM_6328_ENET0_BASE		(0xdeadbeef)
+#define BCM_6328_ENET1_BASE		(0xdeadbeef)
+#define BCM_6328_ENETDMA_BASE		(0xb000d800)
+#define BCM_6328_ENETDMAC_BASE		(0xb000da00)
+#define BCM_6328_ENETDMAS_BASE		(0xb000dc00)
+#define BCM_6328_ENETSW_BASE		(0xb0e00000)
+#define BCM_6328_EHCI0_BASE		(0x10002500)
+#define BCM_6328_SDRAM_BASE		(0xdeadbeef)
+#define BCM_6328_MEMC_BASE		(0xdeadbeef)
+#define BCM_6328_DDR_BASE		(0xb0003000)
+#define BCM_6328_M2M_BASE		(0xdeadbeef)
+#define BCM_6328_ATM_BASE		(0xdeadbeef)
+#define BCM_6328_XTM_BASE		(0xdeadbeef)
+#define BCM_6328_XTMDMA_BASE		(0xb000b800)
+#define BCM_6328_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_6328_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_6328_PCM_BASE		(0xb000a800)
+#define BCM_6328_PCMDMA_BASE		(0xdeadbeef)
+#define BCM_6328_PCMDMAC_BASE		(0xdeadbeef)
+#define BCM_6328_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6328_RNG_BASE		(0xdeadbeef)
+#define BCM_6328_MISC_BASE		(0xb0001800)
+/*
  * 6338 register sets base address
  */
 #define BCM_6338_DSL_LMEM_BASE		(0xfff00000)
@@ -198,6 +256,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6338_PCMDMAS_BASE		(0xdeadbeef)
 #define BCM_6338_RNG_BASE		(0xdeadbeef)
+#define BCM_6338_MISC_BASE		(0xdeadbeef)
 
 /*
  * 6345 register sets base address
@@ -242,6 +301,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6345_PCMDMAS_BASE		(0xdeadbeef)
 #define BCM_6345_RNG_BASE		(0xdeadbeef)
+#define BCM_6345_MISC_BASE		(0xdeadbeef)
 
 /*
  * 6348 register sets base address
@@ -283,6 +343,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6348_PCMDMAS_BASE		(0xdeadbeef)
 #define BCM_6348_RNG_BASE		(0xdeadbeef)
+#define BCM_6348_MISC_BASE		(0xdeadbeef)
 
 /*
  * 6358 register sets base address
@@ -324,6 +385,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_PCMDMAC_BASE		(0xfffe1900)
 #define BCM_6358_PCMDMAS_BASE		(0xfffe1a00)
 #define BCM_6358_RNG_BASE		(0xdeadbeef)
+#define BCM_6358_MISC_BASE		(0xdeadbeef)
 
 
 /*
@@ -366,6 +428,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_PCMDMAC_BASE		(0xb0005a00)
 #define BCM_6368_PCMDMAS_BASE		(0xb0005c00)
 #define BCM_6368_RNG_BASE		(0xb0004180)
+#define BCM_6368_MISC_BASE		(0xdeadbeef)
 
 
 extern const unsigned long *bcm63xx_regs_base;
@@ -412,6 +475,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, PCMDMAC)					\
 	__GEN_RSET_BASE(__cpu, PCMDMAS)					\
 	__GEN_RSET_BASE(__cpu, RNG)					\
+	__GEN_RSET_BASE(__cpu, MISC)					\
 	}
 
 #define __GEN_CPU_REGS_TABLE(__cpu)					\
@@ -451,6 +515,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_PCMDMAC]		= BCM_## __cpu ##_PCMDMAC_BASE,		\
 	[RSET_PCMDMAS]		= BCM_## __cpu ##_PCMDMAS_BASE,		\
 	[RSET_RNG]		= BCM_## __cpu ##_RNG_BASE,		\
+	[RSET_MISC]		= BCM_## __cpu ##_MISC_BASE,		\
 
 
 static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
@@ -458,6 +523,9 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 #ifdef BCMCPU_RUNTIME_DETECT
 	return bcm63xx_regs_base[set];
 #else
+#ifdef CONFIG_BCM63XX_CPU_6328
+	__GEN_RSET(6328)
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6338
 	__GEN_RSET(6338)
 #endif
@@ -512,6 +580,47 @@ enum bcm63xx_irq {
 };
 
 /*
+ * 6328 irqs
+ */
+#define BCM_6328_HIGH_IRQ_BASE		(IRQ_INTERNAL_BASE + 32)
+
+#define BCM_6328_TIMER_IRQ		(IRQ_INTERNAL_BASE + 31)
+#define BCM_6328_SPI_IRQ		0
+#define BCM_6328_UART0_IRQ		(IRQ_INTERNAL_BASE + 28)
+#define BCM_6328_UART1_IRQ		(BCM_6328_HIGH_IRQ_BASE + 7)
+#define BCM_6328_DSL_IRQ		(IRQ_INTERNAL_BASE + 4)
+#define BCM_6328_UDC0_IRQ		0
+#define BCM_6328_ENET0_IRQ		0
+#define BCM_6328_ENET1_IRQ		0
+#define BCM_6328_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6328_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6328_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
+#define BCM_6328_PCMCIA_IRQ		0
+#define BCM_6328_ENET0_RXDMA_IRQ	0
+#define BCM_6328_ENET0_TXDMA_IRQ	0
+#define BCM_6328_ENET1_RXDMA_IRQ	0
+#define BCM_6328_ENET1_TXDMA_IRQ	0
+#define BCM_6328_PCI_IRQ		(IRQ_INTERNAL_BASE + 23)
+#define BCM_6328_ATM_IRQ		0
+#define BCM_6328_ENETSW_RXDMA0_IRQ	(BCM_6328_HIGH_IRQ_BASE + 0)
+#define BCM_6328_ENETSW_RXDMA1_IRQ	(BCM_6328_HIGH_IRQ_BASE + 1)
+#define BCM_6328_ENETSW_RXDMA2_IRQ	(BCM_6328_HIGH_IRQ_BASE + 2)
+#define BCM_6328_ENETSW_RXDMA3_IRQ	(BCM_6328_HIGH_IRQ_BASE + 3)
+#define BCM_6328_ENETSW_TXDMA0_IRQ	(BCM_6328_HIGH_IRQ_BASE + 4)
+#define BCM_6328_ENETSW_TXDMA1_IRQ	(BCM_6328_HIGH_IRQ_BASE + 5)
+#define BCM_6328_ENETSW_TXDMA2_IRQ	(BCM_6328_HIGH_IRQ_BASE + 6)
+#define BCM_6328_ENETSW_TXDMA3_IRQ	(BCM_6328_HIGH_IRQ_BASE + 7)
+#define BCM_6328_XTM_IRQ		(BCM_6328_HIGH_IRQ_BASE + 31)
+#define BCM_6328_XTM_DMA0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 11)
+
+#define BCM_6328_PCM_DMA0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6328_PCM_DMA1_IRQ		(IRQ_INTERNAL_BASE + 3)
+#define BCM_6328_EXT_IRQ0		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6328_EXT_IRQ1		(IRQ_INTERNAL_BASE + 25)
+#define BCM_6328_EXT_IRQ2		(IRQ_INTERNAL_BASE + 26)
+#define BCM_6328_EXT_IRQ3		(IRQ_INTERNAL_BASE + 27)
+
+/*
  * 6338 irqs
  */
 #define BCM_6338_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 1d7dd96..0a9891f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -9,6 +9,8 @@ int __init bcm63xx_gpio_init(void);
 static inline unsigned long bcm63xx_gpio_count(void)
 {
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		return 32;
 	case BCM6358_CPU_ID:
 		return 40;
 	case BCM6338_CPU_ID:
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
index 72477a6..6dcd8b2 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
@@ -91,5 +91,7 @@
 #define bcm_memc_writel(v, o)	bcm_rset_writel(RSET_MEMC, (v), (o))
 #define bcm_ddr_readl(o)	bcm_rset_readl(RSET_DDR, (o))
 #define bcm_ddr_writel(v, o)	bcm_rset_writel(RSET_DDR, (v), (o))
+#define bcm_misc_readl(o)	bcm_rset_readl(RSET_MISC, (o))
+#define bcm_misc_writel(v, o)	bcm_rset_writel(RSET_MISC, (v), (o))
 
 #endif /* ! BCM63XX_IO_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 849fd97..4fc2ab2 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -15,6 +15,30 @@
 /* Clock Control register */
 #define PERF_CKCTL_REG			0x4
 
+#define CKCTL_6328_PHYMIPS_EN		(1 << 0)
+#define CKCTL_6328_ADSL_QPROC_EN	(1 << 1)
+#define CKCTL_6328_ADSL_AFE_EN		(1 << 2)
+#define CKCTL_6328_ADSL_EN		(1 << 3)
+#define CKCTL_6328_MIPS_EN		(1 << 4)
+#define CKCTL_6328_SAR_EN		(1 << 5)
+#define CKCTL_6328_PCM_EN		(1 << 6)
+#define CKCTL_6328_USBD_EN		(1 << 7)
+#define CKCTL_6328_USBH_EN		(1 << 8)
+#define CKCTL_6328_HSSPI_EN		(1 << 9)
+#define CKCTL_6328_PCIE_EN		(1 << 10)
+#define CKCTL_6328_ROBOSW_EN		(1 << 11)
+
+#define CKCTL_6328_ALL_SAFE_EN		(CKCTL_6328_PHYMIPS_EN |	\
+					CKCTL_6328_ADSL_QPROC_EN |	\
+					CKCTL_6328_ADSL_AFE_EN |	\
+					CKCTL_6328_ADSL_EN |		\
+					CKCTL_6328_SAR_EN  |		\
+					CKCTL_6328_PCM_EN  |		\
+					CKCTL_6328_USBD_EN |		\
+					CKCTL_6328_USBH_EN |		\
+					CKCTL_6328_ROBOSW_EN |		\
+					CKCTL_6328_PCIE_EN)
+
 #define CKCTL_6338_ADSLPHY_EN		(1 << 0)
 #define CKCTL_6338_MPI_EN		(1 << 1)
 #define CKCTL_6338_DRAM_EN		(1 << 2)
@@ -119,6 +143,7 @@
 #define SYS_PLL_SOFT_RESET		0x1
 
 /* Interrupt Mask register */
+#define PERF_IRQMASK_6328_REG		0x20
 #define PERF_IRQMASK_6338_REG		0xc
 #define PERF_IRQMASK_6345_REG		0xc
 #define PERF_IRQMASK_6348_REG		0xc
@@ -126,6 +151,7 @@
 #define PERF_IRQMASK_6368_REG		0x20
 
 /* Interrupt Status register */
+#define PERF_IRQSTAT_6328_REG		0x28
 #define PERF_IRQSTAT_6338_REG		0x10
 #define PERF_IRQSTAT_6345_REG		0x10
 #define PERF_IRQSTAT_6348_REG		0x10
@@ -133,6 +159,7 @@
 #define PERF_IRQSTAT_6368_REG		0x28
 
 /* External Interrupt Configuration register */
+#define PERF_EXTIRQ_CFG_REG_6328	0x18
 #define PERF_EXTIRQ_CFG_REG_6338	0x14
 #define PERF_EXTIRQ_CFG_REG_6348	0x14
 #define PERF_EXTIRQ_CFG_REG_6358	0x14
@@ -162,8 +189,21 @@
 
 /* Soft Reset register */
 #define PERF_SOFTRESET_REG		0x28
+#define PERF_SOFTRESET_6328_REG		0x10
 #define PERF_SOFTRESET_6368_REG		0x10
 
+#define SOFTRESET_6328_SPI_MASK		(1 << 0)
+#define SOFTRESET_6328_EPHY_MASK	(1 << 1)
+#define SOFTRESET_6328_SAR_MASK		(1 << 2)
+#define SOFTRESET_6328_ENETSW_MASK	(1 << 3)
+#define SOFTRESET_6328_USBS_MASK	(1 << 4)
+#define SOFTRESET_6328_USBH_MASK	(1 << 5)
+#define SOFTRESET_6328_PCM_MASK		(1 << 6)
+#define SOFTRESET_6328_PCIE_CORE_MASK	(1 << 7)
+#define SOFTRESET_6328_PCIE_MASK	(1 << 8)
+#define SOFTRESET_6328_PCIE_EXT_MASK	(1 << 9)
+#define SOFTRESET_6328_PCIE_HARD_MASK	(1 << 10)
+
 #define SOFTRESET_6338_SPI_MASK		(1 << 0)
 #define SOFTRESET_6338_ENET_MASK	(1 << 2)
 #define SOFTRESET_6338_USBH_MASK	(1 << 3)
@@ -307,6 +347,8 @@
 /* Watchdog reset length register */
 #define WDT_RSTLEN_REG			0x8
 
+/* Watchdog soft reset register (BCM6328 only) */
+#define WDT_SOFTRESET_REG		0xc
 
 /*************************************************************************
  * _REG relative to RSET_UARTx
@@ -933,6 +975,8 @@
  * _REG relative to RSET_DDR
  *************************************************************************/
 
+#define DDR_CSEND_REG			0x8
+
 #define DDR_DMIPSPLLCFG_REG		0x18
 #define DMIPSPLLCFG_M1_SHIFT		0
 #define DMIPSPLLCFG_M1_MASK		(0xff << DMIPSPLLCFG_M1_SHIFT)
@@ -1115,4 +1159,14 @@
 #define SPI_SSOFFTIME_SHIFT		3
 #define SPI_BYTE_SWAP			0x80
 
+/*************************************************************************
+ * _REG relative to RSET_MISC
+ *************************************************************************/
+
+#define MISC_STRAPBUS_6328_REG		0x240
+#define STRAPBUS_6328_FCVO_SHIFT	7
+#define STRAPBUS_6328_FCVO_MASK		(0x1f << STRAPBUS_6328_FCVO_SHIFT)
+#define STRAPBUS_6328_BOOT_SEL_SERIAL	(1 << 28)
+#define STRAPBUS_6328_BOOT_SEL_NAND	(0 << 28)
+
 #endif /* BCM63XX_REGS_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/ioremap.h b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
index ef94ba7..30931c4 100644
--- a/arch/mips/include/asm/mach-bcm63xx/ioremap.h
+++ b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
@@ -18,6 +18,7 @@ static inline int is_bcm63xx_internal_registers(phys_t offset)
 		if (offset >= 0xfff00000)
 			return 1;
 		break;
+	case BCM6328_CPU_ID:
 	case BCM6368_CPU_ID:
 		if (offset >= 0xb0000000 && offset < 0xb1000000)
 			return 1;
-- 
1.7.2.5
