Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:51:59 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52715 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491151Ab1FJVrp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:45 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id C0FE54C8089;
        Fri, 10 Jun 2011 23:47:39 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id 0B34618066F;
        Fri, 10 Jun 2011 23:47:31 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 006F855AEB4; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 11/11] MIPS: BCM63XX: add support for bcm6368 CPU.
Date:   Fri, 10 Jun 2011 23:47:21 +0200
Message-Id: <1307742441-28284-12-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9583

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/Kconfig                         |    4 +
 arch/mips/bcm63xx/clk.c                           |   70 +++++++++++++-
 arch/mips/bcm63xx/cpu.c                           |   76 ++++++++++++---
 arch/mips/bcm63xx/dev-uart.c                      |    2 +-
 arch/mips/bcm63xx/irq.c                           |   16 +++
 arch/mips/bcm63xx/prom.c                          |    7 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |   99 +++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  106 ++++++++++++++++++++-
 arch/mips/include/asm/mach-bcm63xx/ioremap.h      |    4 +
 arch/mips/pci/pci-bcm63xx.c                       |    4 +-
 11 files changed, 364 insertions(+), 26 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index fb177d6..6b1b9ad 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -20,6 +20,10 @@ config BCM63XX_CPU_6348
 config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
 	select HW_HAS_PCI
+
+config BCM63XX_CPU_6368
+	bool "support 6368 CPU"
+	select HW_HAS_PCI
 endmenu
 
 source "arch/mips/bcm63xx/boards/Kconfig"
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 2c68ee9..9d57c71 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
@@ -113,6 +114,34 @@ static struct clk clk_ephy = {
 };
 
 /*
+ * Ethernet switch clock
+ */
+static void enetsw_set(struct clk *clk, int enable)
+{
+	if (!BCMCPU_IS_6368())
+		return;
+	bcm_hwclock_set(CKCTL_6368_ROBOSW_CLK_EN |
+			CKCTL_6368_SWPKT_USB_EN |
+			CKCTL_6368_SWPKT_SAR_EN, enable);
+	if (enable) {
+		u32 val;
+
+		/* reset switch core afer clock change */
+		val = bcm_perf_readl(PERF_SOFTRESET_6368_REG);
+		val &= ~SOFTRESET_6368_ENETSW_MASK;
+		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		msleep(10);
+		val |= SOFTRESET_6368_ENETSW_MASK;
+		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		msleep(10);
+	}
+}
+
+static struct clk clk_enetsw = {
+	.set	= enetsw_set,
+};
+
+/*
  * PCM clock
  */
 static void pcm_set(struct clk *clk, int enable)
@@ -131,9 +160,10 @@ static struct clk clk_pcm = {
  */
 static void usbh_set(struct clk *clk, int enable)
 {
-	if (!BCMCPU_IS_6348())
-		return;
-	bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
+	if (BCMCPU_IS_6348())
+		bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
+	else if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_USBH_CLK_EN, enable);
 }
 
 static struct clk clk_usbh = {
@@ -162,6 +192,36 @@ static struct clk clk_spi = {
 };
 
 /*
+ * XTM clock
+ */
+static void xtm_set(struct clk *clk, int enable)
+{
+	if (!BCMCPU_IS_6368())
+		return;
+
+	bcm_hwclock_set(CKCTL_6368_SAR_CLK_EN |
+			CKCTL_6368_SWPKT_SAR_EN, enable);
+
+	if (enable) {
+		u32 val;
+
+		/* reset sar core afer clock change */
+		val = bcm_perf_readl(PERF_SOFTRESET_6368_REG);
+		val &= ~SOFTRESET_6368_SAR_MASK;
+		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		mdelay(1);
+		val |= SOFTRESET_6368_SAR_MASK;
+		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		mdelay(1);
+	}
+}
+
+
+static struct clk clk_xtm = {
+	.set	= xtm_set,
+};
+
+/*
  * Internal peripheral clock
  */
 static struct clk clk_periph = {
@@ -204,12 +264,16 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_enet0;
 	if (!strcmp(id, "enet1"))
 		return &clk_enet1;
+	if (!strcmp(id, "enetsw"))
+		return &clk_enetsw;
 	if (!strcmp(id, "ephy"))
 		return &clk_ephy;
 	if (!strcmp(id, "usbh"))
 		return &clk_usbh;
 	if (!strcmp(id, "spi"))
 		return &clk_spi;
+	if (!strcmp(id, "xtm"))
+		return &clk_xtm;
 	if (!strcmp(id, "periph"))
 		return &clk_periph;
 	if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 027ac30..3ea2533 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -66,6 +66,15 @@ static const int bcm96358_irqs[] = {
 
 };
 
+static const unsigned long bcm96368_regs_base[] = {
+	__GEN_CPU_REGS_TABLE(6368)
+};
+
+static const int bcm96368_irqs[] = {
+	__GEN_CPU_IRQ_TABLE(6368)
+
+};
+
 u16 __bcm63xx_get_cpu_id(void)
 {
 	return bcm63xx_cpu_id;
@@ -92,20 +101,19 @@ unsigned int bcm63xx_get_memory_size(void)
 
 static unsigned int detect_cpu_clock(void)
 {
-	unsigned int tmp, n1 = 0, n2 = 0, m1 = 0;
-
-	/* BCM6338 has a fixed 240 Mhz frequency */
-	if (BCMCPU_IS_6338())
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6338_CPU_ID:
+		/* BCM6338 has a fixed 240 Mhz frequency */
 		return 240000000;
 
-	/* BCM6345 has a fixed 140Mhz frequency */
-	if (BCMCPU_IS_6345())
+	case BCM6345_CPU_ID:
+		/* BCM6345 has a fixed 140Mhz frequency */
 		return 140000000;
 
-	/*
-	 * frequency depends on PLL configuration:
-	 */
-	if (BCMCPU_IS_6348()) {
+	case BCM6348_CPU_ID:
+	{
+		unsigned int tmp, n1, n2, m1;
+
 		/* 16MHz * (N1 + 1) * (N2 + 2) / (M1_CPU + 1) */
 		tmp = bcm_perf_readl(PERF_MIPSPLLCTL_REG);
 		n1 = (tmp & MIPSPLLCTL_N1_MASK) >> MIPSPLLCTL_N1_SHIFT;
@@ -114,17 +122,47 @@ static unsigned int detect_cpu_clock(void)
 		n1 += 1;
 		n2 += 2;
 		m1 += 1;
+		return (16 * 1000000 * n1 * n2) / m1;
 	}
 
-	if (BCMCPU_IS_6358()) {
+	case BCM6358_CPU_ID:
+	{
+		unsigned int tmp, n1, n2, m1;
+
 		/* 16MHz * N1 * N2 / M1_CPU */
 		tmp = bcm_ddr_readl(DDR_DMIPSPLLCFG_REG);
 		n1 = (tmp & DMIPSPLLCFG_N1_MASK) >> DMIPSPLLCFG_N1_SHIFT;
 		n2 = (tmp & DMIPSPLLCFG_N2_MASK) >> DMIPSPLLCFG_N2_SHIFT;
 		m1 = (tmp & DMIPSPLLCFG_M1_MASK) >> DMIPSPLLCFG_M1_SHIFT;
+		return (16 * 1000000 * n1 * n2) / m1;
 	}
 
-	return (16 * 1000000 * n1 * n2) / m1;
+	case BCM6368_CPU_ID:
+	{
+		unsigned int tmp, p1, p2, ndiv, m1;
+
+		/* (64MHz / P1) * P2 * NDIV / M1_CPU */
+		tmp = bcm_ddr_readl(DDR_DMIPSPLLCFG_6368_REG);
+
+		p1 = (tmp & DMIPSPLLCFG_6368_P1_MASK) >>
+			DMIPSPLLCFG_6368_P1_SHIFT;
+
+		p2 = (tmp & DMIPSPLLCFG_6368_P2_MASK) >>
+			DMIPSPLLCFG_6368_P2_SHIFT;
+
+		ndiv = (tmp & DMIPSPLLCFG_6368_NDIV_MASK) >>
+			DMIPSPLLCFG_6368_NDIV_SHIFT;
+
+		tmp = bcm_ddr_readl(DDR_DMIPSPLLDIV_6368_REG);
+		m1 = (tmp & DMIPSPLLDIV_6368_MDIV_MASK) >>
+			DMIPSPLLDIV_6368_MDIV_SHIFT;
+
+		return (((64 * 1000000) / p1) * p2 * ndiv) / m1;
+	}
+
+	default:
+		BUG();
+	}
 }
 
 /*
@@ -146,7 +184,7 @@ static unsigned int detect_memory_size(void)
 		banks = (val & SDRAM_CFG_BANK_MASK) ? 2 : 1;
 	}
 
-	if (BCMCPU_IS_6358()) {
+	if (BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
 		val = bcm_memc_readl(MEMC_CFG_REG);
 		rows = (val & MEMC_CFG_ROW_MASK) >> MEMC_CFG_ROW_SHIFT;
 		cols = (val & MEMC_CFG_COL_MASK) >> MEMC_CFG_COL_SHIFT;
@@ -191,9 +229,15 @@ void __init bcm63xx_cpu_init(void)
 		bcm63xx_irqs = bcm96345_irqs;
 		break;
 	case CPU_BMIPS4350:
-		expected_cpu_id = BCM6358_CPU_ID;
-		bcm63xx_regs_base = bcm96358_regs_base;
-		bcm63xx_irqs = bcm96358_irqs;
+		if ((read_c0_prid() & 0xf0) == 0x0030) {
+			expected_cpu_id = BCM6368_CPU_ID;
+			bcm63xx_regs_base = bcm96368_regs_base;
+			bcm63xx_irqs = bcm96368_irqs;
+		} else {
+			expected_cpu_id = BCM6358_CPU_ID;
+			bcm63xx_regs_base = bcm96358_regs_base;
+			bcm63xx_irqs = bcm96358_irqs;
+		}
 		break;
 	}
 
diff --git a/arch/mips/bcm63xx/dev-uart.c b/arch/mips/bcm63xx/dev-uart.c
index c2963da..d6e42c6 100644
--- a/arch/mips/bcm63xx/dev-uart.c
+++ b/arch/mips/bcm63xx/dev-uart.c
@@ -54,7 +54,7 @@ int __init bcm63xx_uart_register(unsigned int id)
 	if (id >= ARRAY_SIZE(bcm63xx_uart_devices))
 		return -ENODEV;
 
-	if (id == 1 && !BCMCPU_IS_6358())
+	if (id == 1 && (!BCMCPU_IS_6358() && !BCMCPU_IS_6368()))
 		return -ENODEV;
 
 	if (id == 0) {
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index f2d5e30..f111ccd 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -59,6 +59,14 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define ext_irq_start		(BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE)
 #define ext_irq_end		(BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE)
 #endif
+#ifdef CONFIG_BCM63XX_CPU_6368
+#define irq_stat_reg		PERF_IRQSTAT_6368_REG
+#define irq_mask_reg		PERF_IRQMASK_6368_REG
+#define irq_bits		64
+#define is_ext_irq_cascaded	1
+#define ext_irq_start		(BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE)
+#define ext_irq_end		(BCM_6368_EXT_IRQ3 - IRQ_INTERNAL_BASE)
+#endif
 
 #if irq_bits == 32
 #define dispatch_internal			__dispatch_internal
@@ -116,6 +124,14 @@ static void bcm63xx_init_irq(void)
 		ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
 		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
 		break;
+	case BCM6368_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6368_REG;
+		irq_mask_addr += PERF_IRQMASK_6368_REG;
+		irq_bits = 64;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6368_EXT_IRQ5 - IRQ_INTERNAL_BASE;
+		break;
 	default:
 		BUG();
 	}
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index be252ef..99d7f40 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -32,9 +32,12 @@ void __init prom_init(void)
 		mask = CKCTL_6345_ALL_SAFE_EN;
 	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_ALL_SAFE_EN;
-	else
-		/* BCMCPU_IS_6358() */
+	else if (BCMCPU_IS_6358())
 		mask = CKCTL_6358_ALL_SAFE_EN;
+	else if (BCMCPU_IS_6368())
+		mask = CKCTL_6368_ALL_SAFE_EN;
+	else
+		mask = 0;
 
 	reg = bcm_perf_readl(PERF_CKCTL_REG);
 	reg &= ~mask;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index ce6b3ca..cf145ea 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -13,6 +13,7 @@
 #define BCM6345_CPU_ID		0x6345
 #define BCM6348_CPU_ID		0x6348
 #define BCM6358_CPU_ID		0x6358
+#define BCM6368_CPU_ID		0x6368
 
 void __init bcm63xx_cpu_init(void);
 u16 __bcm63xx_get_cpu_id(void);
@@ -71,6 +72,19 @@ unsigned int bcm63xx_get_cpu_freq(void);
 # define BCMCPU_IS_6358()	(0)
 #endif
 
+#ifdef CONFIG_BCM63XX_CPU_6368
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6368_CPU_ID
+# endif
+# define BCMCPU_IS_6368()	(bcm63xx_get_cpu_id() == BCM6368_CPU_ID)
+#else
+# define BCMCPU_IS_6368()	(0)
+#endif
+
 #ifndef bcm63xx_get_cpu_id
 #error "No CPU support configured"
 #endif
@@ -309,6 +323,47 @@ enum bcm63xx_regs_set {
 #define BCM_6358_PCMDMAS_BASE		(0xfffe1a00)
 
 
+/*
+ * 6368 register sets base address
+ */
+#define BCM_6368_DSL_LMEM_BASE		(0xdeadbeef)
+#define BCM_6368_PERF_BASE		(0xb0000000)
+#define BCM_6368_TIMER_BASE		(0xb0000040)
+#define BCM_6368_WDT_BASE		(0xb000005c)
+#define BCM_6368_UART0_BASE		(0xb0000100)
+#define BCM_6368_UART1_BASE		(0xb0000120)
+#define BCM_6368_GPIO_BASE		(0xb0000080)
+#define BCM_6368_SPI_BASE		(0xdeadbeef)
+#define BCM_6368_SPI2_BASE		(0xb0000800)
+#define BCM_6368_UDC0_BASE		(0xdeadbeef)
+#define BCM_6368_OHCI0_BASE		(0xb0001600)
+#define BCM_6368_OHCI_PRIV_BASE		(0xdeadbeef)
+#define BCM_6368_USBH_PRIV_BASE		(0xb0001700)
+#define BCM_6368_MPI_BASE		(0xb0001000)
+#define BCM_6368_PCMCIA_BASE		(0xb0001054)
+#define BCM_6368_SDRAM_REGS_BASE	(0xdeadbeef)
+#define BCM_6368_M2M_BASE		(0xdeadbeef)
+#define BCM_6368_DSL_BASE		(0xdeadbeef)
+#define BCM_6368_ENET0_BASE		(0xdeadbeef)
+#define BCM_6368_ENET1_BASE		(0xdeadbeef)
+#define BCM_6368_ENETDMA_BASE		(0xb0006800)
+#define BCM_6368_ENETDMAC_BASE		(0xb0006a00)
+#define BCM_6368_ENETDMAS_BASE		(0xb0006c00)
+#define BCM_6368_ENETSW_BASE		(0xb0f00000)
+#define BCM_6368_EHCI0_BASE		(0xb0001500)
+#define BCM_6368_SDRAM_BASE		(0xdeadbeef)
+#define BCM_6368_MEMC_BASE		(0xb0001200)
+#define BCM_6368_DDR_BASE		(0xb0001280)
+#define BCM_6368_ATM_BASE		(0xdeadbeef)
+#define BCM_6368_XTM_BASE		(0xb0001800)
+#define BCM_6368_XTMDMA_BASE		(0xb0005000)
+#define BCM_6368_XTMDMAC_BASE		(0xb0005200)
+#define BCM_6368_XTMDMAS_BASE		(0xb0005400)
+#define BCM_6368_PCM_BASE		(0xb0004000)
+#define BCM_6368_PCMDMA_BASE		(0xb0005800)
+#define BCM_6368_PCMDMAC_BASE		(0xb0005a00)
+#define BCM_6368_PCMDMAS_BASE		(0xb0005c00)
+
 
 extern const unsigned long *bcm63xx_regs_base;
 
@@ -412,6 +467,9 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 #ifdef CONFIG_BCM63XX_CPU_6358
 	__GEN_RSET(6358)
 #endif
+#ifdef CONFIG_BCM63XX_CPU_6368
+	__GEN_RSET(6368)
+#endif
 #endif
 	/* unreached */
 	return 0;
@@ -576,6 +634,47 @@ enum bcm63xx_irq {
 #define BCM_6358_EXT_IRQ2		(IRQ_INTERNAL_BASE + 27)
 #define BCM_6358_EXT_IRQ3		(IRQ_INTERNAL_BASE + 28)
 
+/*
+ * 6368 irqs
+ */
+#define BCM_6368_HIGH_IRQ_BASE		(IRQ_INTERNAL_BASE + 32)
+
+#define BCM_6368_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6368_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6368_UART1_IRQ		(IRQ_INTERNAL_BASE + 3)
+#define BCM_6368_DSL_IRQ		(IRQ_INTERNAL_BASE + 4)
+#define BCM_6368_ENET0_IRQ		0
+#define BCM_6368_ENET1_IRQ		0
+#define BCM_6368_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 15)
+#define BCM_6368_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
+#define BCM_6368_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 7)
+#define BCM_6368_PCMCIA_IRQ		0
+#define BCM_6368_ENET0_RXDMA_IRQ	0
+#define BCM_6368_ENET0_TXDMA_IRQ	0
+#define BCM_6368_ENET1_RXDMA_IRQ	0
+#define BCM_6368_ENET1_TXDMA_IRQ	0
+#define BCM_6368_PCI_IRQ		(IRQ_INTERNAL_BASE + 13)
+#define BCM_6368_ATM_IRQ		0
+#define BCM_6368_ENETSW_RXDMA0_IRQ	(BCM_6368_HIGH_IRQ_BASE + 0)
+#define BCM_6368_ENETSW_RXDMA1_IRQ	(BCM_6368_HIGH_IRQ_BASE + 1)
+#define BCM_6368_ENETSW_RXDMA2_IRQ	(BCM_6368_HIGH_IRQ_BASE + 2)
+#define BCM_6368_ENETSW_RXDMA3_IRQ	(BCM_6368_HIGH_IRQ_BASE + 3)
+#define BCM_6368_ENETSW_TXDMA0_IRQ	(BCM_6368_HIGH_IRQ_BASE + 4)
+#define BCM_6368_ENETSW_TXDMA1_IRQ	(BCM_6368_HIGH_IRQ_BASE + 5)
+#define BCM_6368_ENETSW_TXDMA2_IRQ	(BCM_6368_HIGH_IRQ_BASE + 6)
+#define BCM_6368_ENETSW_TXDMA3_IRQ	(BCM_6368_HIGH_IRQ_BASE + 7)
+#define BCM_6368_XTM_IRQ		(IRQ_INTERNAL_BASE + 11)
+#define BCM_6368_XTM_DMA0_IRQ		(BCM_6368_HIGH_IRQ_BASE + 8)
+
+#define BCM_6368_PCM_DMA0_IRQ		(BCM_6368_HIGH_IRQ_BASE + 30)
+#define BCM_6368_PCM_DMA1_IRQ		(BCM_6368_HIGH_IRQ_BASE + 31)
+#define BCM_6368_EXT_IRQ0		(IRQ_INTERNAL_BASE + 20)
+#define BCM_6368_EXT_IRQ1		(IRQ_INTERNAL_BASE + 21)
+#define BCM_6368_EXT_IRQ2		(IRQ_INTERNAL_BASE + 22)
+#define BCM_6368_EXT_IRQ3		(IRQ_INTERNAL_BASE + 23)
+#define BCM_6368_EXT_IRQ4		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6368_EXT_IRQ5		(IRQ_INTERNAL_BASE + 25)
+
 extern const int *bcm63xx_irqs;
 
 #define __GEN_CPU_IRQ_TABLE(__cpu)					\
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 3999ec0..3d5de96 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -14,6 +14,8 @@ static inline unsigned long bcm63xx_gpio_count(void)
 		return 8;
 	case BCM6345_CPU_ID:
 		return 16;
+	case BCM6368_CPU_ID:
+		return 38;
 	case BCM6348_CPU_ID:
 	default:
 		return 37;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 0fa613c..f237b41 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -83,6 +83,37 @@
 					CKCTL_6358_USBSU_EN |		\
 					CKCTL_6358_EPHY_EN)
 
+#define CKCTL_6368_VDSL_QPROC_EN	(1 << 2)
+#define CKCTL_6368_VDSL_AFE_EN		(1 << 3)
+#define CKCTL_6368_VDSL_BONDING_EN	(1 << 4)
+#define CKCTL_6368_VDSL_EN		(1 << 5)
+#define CKCTL_6368_PHYMIPS_EN		(1 << 6)
+#define CKCTL_6368_SWPKT_USB_EN		(1 << 7)
+#define CKCTL_6368_SWPKT_SAR_EN		(1 << 8)
+#define CKCTL_6368_SPI_CLK_EN		(1 << 9)
+#define CKCTL_6368_USBD_CLK_EN		(1 << 10)
+#define CKCTL_6368_SAR_CLK_EN		(1 << 11)
+#define CKCTL_6368_ROBOSW_CLK_EN	(1 << 12)
+#define CKCTL_6368_UTOPIA_CLK_EN	(1 << 13)
+#define CKCTL_6368_PCM_CLK_EN		(1 << 14)
+#define CKCTL_6368_USBH_CLK_EN		(1 << 15)
+#define CKCTL_6368_DISABLE_GLESS_EN	(1 << 16)
+#define CKCTL_6368_NAND_CLK_EN		(1 << 17)
+#define CKCTL_6368_IPSEC_CLK_EN		(1 << 17)
+
+#define CKCTL_6368_ALL_SAFE_EN		(CKCTL_6368_SWPKT_USB_EN |	\
+					CKCTL_6368_SWPKT_SAR_EN |	\
+					CKCTL_6368_SPI_CLK_EN |		\
+					CKCTL_6368_USBD_CLK_EN |	\
+					CKCTL_6368_SAR_CLK_EN |		\
+					CKCTL_6368_ROBOSW_CLK_EN |	\
+					CKCTL_6368_UTOPIA_CLK_EN |	\
+					CKCTL_6368_PCM_CLK_EN |		\
+					CKCTL_6368_USBH_CLK_EN |	\
+					CKCTL_6368_DISABLE_GLESS_EN |	\
+					CKCTL_6368_NAND_CLK_EN |	\
+					CKCTL_6368_IPSEC_CLK_EN)
+
 /* System PLL Control register  */
 #define PERF_SYS_PLL_CTL_REG		0x8
 #define SYS_PLL_SOFT_RESET		0x1
@@ -94,6 +125,7 @@
 #define PERF_IRQMASK_6345_REG		0xc
 #define PERF_IRQMASK_6348_REG		0xc
 #define PERF_IRQMASK_6358_REG		0xc
+#define PERF_IRQMASK_6368_REG		0x20
 
 /* Interrupt Status register */
 #define PERF_IRQSTAT_REG		0x10
@@ -101,6 +133,7 @@
 #define PERF_IRQSTAT_6345_REG		0x10
 #define PERF_IRQSTAT_6348_REG		0x10
 #define PERF_IRQSTAT_6358_REG		0x10
+#define PERF_IRQSTAT_6368_REG		0x28
 
 /* External Interrupt Configuration register */
 #define PERF_EXTIRQ_CFG_REG		0x14
@@ -126,6 +159,7 @@
 
 /* Soft Reset register */
 #define PERF_SOFTRESET_REG		0x28
+#define PERF_SOFTRESET_6368_REG		0x10
 
 #define SOFTRESET_6338_SPI_MASK		(1 << 0)
 #define SOFTRESET_6338_ENET_MASK	(1 << 2)
@@ -166,6 +200,15 @@
 				  SOFTRESET_6348_ACLC_MASK |		\
 				  SOFTRESET_6348_ADSLMIPSPLL_MASK)
 
+#define SOFTRESET_6368_SPI_MASK		(1 << 0)
+#define SOFTRESET_6368_MPI_MASK		(1 << 3)
+#define SOFTRESET_6368_EPHY_MASK	(1 << 6)
+#define SOFTRESET_6368_SAR_MASK		(1 << 7)
+#define SOFTRESET_6368_ENETSW_MASK	(1 << 10)
+#define SOFTRESET_6368_USBS_MASK	(1 << 11)
+#define SOFTRESET_6368_USBH_MASK	(1 << 12)
+#define SOFTRESET_6368_PCM_MASK		(1 << 13)
+
 /* MIPS PLL control register */
 #define PERF_MIPSPLLCTL_REG		0x34
 #define MIPSPLLCTL_N1_SHIFT		20
@@ -421,6 +464,44 @@
 #define GPIO_MODE_6358_SERIAL_LED	(1 << 10)
 #define GPIO_MODE_6358_UTOPIA		(1 << 12)
 
+#define GPIO_MODE_6368_ANALOG_AFE_0	(1 << 0)
+#define GPIO_MODE_6368_ANALOG_AFE_1	(1 << 1)
+#define GPIO_MODE_6368_SYS_IRQ		(1 << 2)
+#define GPIO_MODE_6368_SERIAL_LED_DATA	(1 << 3)
+#define GPIO_MODE_6368_SERIAL_LED_CLK	(1 << 4)
+#define GPIO_MODE_6368_INET_LED		(1 << 5)
+#define GPIO_MODE_6368_EPHY0_LED	(1 << 6)
+#define GPIO_MODE_6368_EPHY1_LED	(1 << 7)
+#define GPIO_MODE_6368_EPHY2_LED	(1 << 8)
+#define GPIO_MODE_6368_EPHY3_LED	(1 << 9)
+#define GPIO_MODE_6368_ROBOSW_LED_DAT	(1 << 10)
+#define GPIO_MODE_6368_ROBOSW_LED_CLK	(1 << 11)
+#define GPIO_MODE_6368_ROBOSW_LED0	(1 << 12)
+#define GPIO_MODE_6368_ROBOSW_LED1	(1 << 13)
+#define GPIO_MODE_6368_USBD_LED		(1 << 14)
+#define GPIO_MODE_6368_NTR_PULSE	(1 << 15)
+#define GPIO_MODE_6368_PCI_REQ1		(1 << 16)
+#define GPIO_MODE_6368_PCI_GNT1		(1 << 17)
+#define GPIO_MODE_6368_PCI_INTB		(1 << 18)
+#define GPIO_MODE_6368_PCI_REQ0		(1 << 19)
+#define GPIO_MODE_6368_PCI_GNT0		(1 << 20)
+#define GPIO_MODE_6368_PCMCIA_CD1	(1 << 22)
+#define GPIO_MODE_6368_PCMCIA_CD2	(1 << 23)
+#define GPIO_MODE_6368_PCMCIA_VS1	(1 << 24)
+#define GPIO_MODE_6368_PCMCIA_VS2	(1 << 25)
+#define GPIO_MODE_6368_EBI_CS2		(1 << 26)
+#define GPIO_MODE_6368_EBI_CS3		(1 << 27)
+#define GPIO_MODE_6368_SPI_SSN2		(1 << 28)
+#define GPIO_MODE_6368_SPI_SSN3		(1 << 29)
+#define GPIO_MODE_6368_SPI_SSN4		(1 << 30)
+#define GPIO_MODE_6368_SPI_SSN5		(1 << 31)
+
+
+#define GPIO_BASEMODE_6368_REG		0x38
+#define GPIO_BASEMODE_6368_UART2	0x1
+#define GPIO_BASEMODE_6368_GPIO		0x0
+#define GPIO_BASEMODE_6368_MASK		0x7
+/* those bits must be kept as read in gpio basemode register*/
 
 /*************************************************************************
  * _REG relative to RSET_ENET
@@ -631,7 +712,9 @@
  * _REG relative to RSET_USBH_PRIV
  *************************************************************************/
 
-#define USBH_PRIV_SWAP_REG		0x0
+#define USBH_PRIV_SWAP_6358_REG		0x0
+#define USBH_PRIV_SWAP_6368_REG		0x1c
+
 #define USBH_PRIV_SWAP_EHCI_ENDN_SHIFT	4
 #define USBH_PRIV_SWAP_EHCI_ENDN_MASK	(1 << USBH_PRIV_SWAP_EHCI_ENDN_SHIFT)
 #define USBH_PRIV_SWAP_EHCI_DATA_SHIFT	3
@@ -641,7 +724,13 @@
 #define USBH_PRIV_SWAP_OHCI_DATA_SHIFT	0
 #define USBH_PRIV_SWAP_OHCI_DATA_MASK	(1 << USBH_PRIV_SWAP_OHCI_DATA_SHIFT)
 
-#define USBH_PRIV_TEST_REG		0x24
+#define USBH_PRIV_TEST_6358_REG		0x24
+#define USBH_PRIV_TEST_6368_REG		0x14
+
+#define USBH_PRIV_SETUP_6368_REG	0x28
+#define USBH_PRIV_SETUP_IOC_SHIFT	4
+#define USBH_PRIV_SETUP_IOC_MASK	(1 << USBH_PRIV_SETUP_IOC_SHIFT)
+
 
 
 /*************************************************************************
@@ -837,6 +926,19 @@
 #define DMIPSPLLCFG_N2_SHIFT		29
 #define DMIPSPLLCFG_N2_MASK		(0x7 << DMIPSPLLCFG_N2_SHIFT)
 
+#define DDR_DMIPSPLLCFG_6368_REG	0x20
+#define DMIPSPLLCFG_6368_P1_SHIFT	0
+#define DMIPSPLLCFG_6368_P1_MASK	(0xf << DMIPSPLLCFG_6368_P1_SHIFT)
+#define DMIPSPLLCFG_6368_P2_SHIFT	4
+#define DMIPSPLLCFG_6368_P2_MASK	(0xf << DMIPSPLLCFG_6368_P2_SHIFT)
+#define DMIPSPLLCFG_6368_NDIV_SHIFT	16
+#define DMIPSPLLCFG_6368_NDIV_MASK	(0x1ff << DMIPSPLLCFG_6368_NDIV_SHIFT)
+
+#define DDR_DMIPSPLLDIV_6368_REG	0x24
+#define DMIPSPLLDIV_6368_MDIV_SHIFT	0
+#define DMIPSPLLDIV_6368_MDIV_MASK	(0xff << DMIPSPLLDIV_6368_MDIV_SHIFT)
+
+
 /*************************************************************************
  * _REG relative to RSET_M2M
  *************************************************************************/
diff --git a/arch/mips/include/asm/mach-bcm63xx/ioremap.h b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
index e3fe04d..ef94ba7 100644
--- a/arch/mips/include/asm/mach-bcm63xx/ioremap.h
+++ b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
@@ -18,6 +18,10 @@ static inline int is_bcm63xx_internal_registers(phys_t offset)
 		if (offset >= 0xfff00000)
 			return 1;
 		break;
+	case BCM6368_CPU_ID:
+		if (offset >= 0xb0000000 && offset < 0xb1000000)
+			return 1;
+		break;
 	}
 	return 0;
 }
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index c7fc92f..24e7bcf 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -99,7 +99,7 @@ static int __init bcm63xx_pci_init(void)
 	unsigned int mem_size;
 	u32 val;
 
-	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358())
+	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358() && !BCMCPU_IS_6368())
 		return -ENODEV;
 
 	if (!bcm63xx_pci_enabled)
@@ -159,7 +159,7 @@ static int __init bcm63xx_pci_init(void)
 	/* setup PCI to local bus access, used by PCI device to target
 	 * local RAM while bus mastering */
 	bcm63xx_int_cfg_writel(0, PCI_BASE_ADDRESS_3);
-	if (BCMCPU_IS_6358())
+	if (BCMCPU_IS_6358() || BCMCPU_IS_6368())
 		val = MPI_SP0_REMAP_ENABLE_MASK;
 	else
 		val = 0;
-- 
1.7.1.1
