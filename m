Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:04:57 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37256 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825897Ab3CUPDxf5S1v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:53 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8nq487FpWE1O; Thu, 21 Mar 2013 16:03:21 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 926712815AD;
        Thu, 21 Mar 2013 16:03:20 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 4/7] MIPS: BCM63XX: add basic BCM6362 support
Date:   Thu, 21 Mar 2013 16:03:17 +0100
Message-Id: <1363878200-4523-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
 <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Add basic support for detecting and booting the BCM6362.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/Kconfig                         |    4 +
 arch/mips/bcm63xx/boards/board_bcm963xx.c         |    6 +-
 arch/mips/bcm63xx/cpu.c                           |   51 +++++++-
 arch/mips/bcm63xx/irq.c                           |   22 ++++
 arch/mips/bcm63xx/prom.c                          |    2 +
 arch/mips/bcm63xx/reset.c                         |   28 +++++
 arch/mips/bcm63xx/setup.c                         |    3 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  139 +++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   61 ++++++++-
 arch/mips/include/asm/mach-bcm63xx/ioremap.h      |    1 +
 11 files changed, 314 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index d03e879..5639662 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -25,6 +25,10 @@ config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
 	select HW_HAS_PCI
 
+config BCM63XX_CPU_6362
+	bool "support 6362 CPU"
+	select HW_HAS_PCI
+
 config BCM63XX_CPU_6368
 	bool "support 6368 CPU"
 	select HW_HAS_PCI
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 9aa7d44..a9505c4 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -726,11 +726,11 @@ void __init board_prom_init(void)
 	u32 val;
 
 	/* read base address of boot chip select (0)
-	 * 6328 does not have MPI but boots from a fixed address
+	 * 6328/6362 do not have MPI but boot from a fixed address
 	 */
-	if (BCMCPU_IS_6328())
+	if (BCMCPU_IS_6328() || BCMCPU_IS_6362()) {
 		val = 0x18000000;
-	else {
+	} else {
 		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
 		val &= MPI_CSBASE_BASE_MASK;
 	}
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index fef168d..79fe32d 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -71,6 +71,15 @@ static const int bcm6358_irqs[] = {
 
 };
 
+static const unsigned long bcm6362_regs_base[] = {
+	__GEN_CPU_REGS_TABLE(6362)
+};
+
+static const int bcm6362_irqs[] = {
+	__GEN_CPU_IRQ_TABLE(6362)
+
+};
+
 static const unsigned long bcm6368_regs_base[] = {
 	__GEN_CPU_REGS_TABLE(6368)
 };
@@ -169,6 +178,42 @@ static unsigned int detect_cpu_clock(void)
 		return (16 * 1000000 * n1 * n2) / m1;
 	}
 
+	case BCM6362_CPU_ID:
+	{
+		unsigned int tmp, mips_pll_fcvo;
+
+		tmp = bcm_misc_readl(MISC_STRAPBUS_6362_REG);
+		mips_pll_fcvo = (tmp & STRAPBUS_6362_FCVO_MASK)
+				>> STRAPBUS_6362_FCVO_SHIFT;
+		switch (mips_pll_fcvo) {
+		case 0x03:
+		case 0x0b:
+		case 0x13:
+		case 0x1b:
+			return 240000000;
+		case 0x04:
+		case 0x0c:
+		case 0x14:
+		case 0x1c:
+			return 160000000;
+		case 0x05:
+		case 0x0e:
+		case 0x16:
+		case 0x1e:
+		case 0x1f:
+			return 400000000;
+		case 0x06:
+			return 440000000;
+		case 0x07:
+		case 0x17:
+			return 384000000;
+		case 0x15:
+		case 0x1d:
+			return 200000000;
+		default:
+			return 320000000;
+		}
+	}
 	case BCM6368_CPU_ID:
 	{
 		unsigned int tmp, p1, p2, ndiv, m1;
@@ -205,7 +250,7 @@ static unsigned int detect_memory_size(void)
 	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
 	u32 val;
 
-	if (BCMCPU_IS_6328())
+	if (BCMCPU_IS_6328() || BCMCPU_IS_6362())
 		return bcm_ddr_readl(DDR_CSEND_REG) << 24;
 
 	if (BCMCPU_IS_6345()) {
@@ -297,6 +342,10 @@ void __init bcm63xx_cpu_init(void)
 		bcm63xx_regs_base = bcm6358_regs_base;
 		bcm63xx_irqs = bcm6358_irqs;
 		break;
+	case BCM6362_CPU_ID:
+		bcm63xx_regs_base = bcm6362_regs_base;
+		bcm63xx_irqs = bcm6362_irqs;
+		break;
 	case BCM6368_CPU_ID:
 		bcm63xx_regs_base = bcm6368_regs_base;
 		bcm63xx_irqs = bcm6368_irqs;
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index da24c2b..c0ab388 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -82,6 +82,17 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6358
 #define ext_irq_cfg_reg2	0
 #endif
+#ifdef CONFIG_BCM63XX_CPU_6362
+#define irq_stat_reg		PERF_IRQSTAT_6362_REG
+#define irq_mask_reg		PERF_IRQMASK_6362_REG
+#define irq_bits		64
+#define is_ext_irq_cascaded	1
+#define ext_irq_start		(BCM_6362_EXT_IRQ0 - IRQ_INTERNAL_BASE)
+#define ext_irq_end		(BCM_6362_EXT_IRQ3 - IRQ_INTERNAL_BASE)
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6362
+#define ext_irq_cfg_reg2	0
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6368
 #define irq_stat_reg		PERF_IRQSTAT_6368_REG
 #define irq_mask_reg		PERF_IRQMASK_6368_REG
@@ -170,6 +181,16 @@ static void bcm63xx_init_irq(void)
 		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6358;
 		break;
+	case BCM6362_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6362_REG;
+		irq_mask_addr += PERF_IRQMASK_6362_REG;
+		irq_bits = 64;
+		ext_irq_count = 4;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6362_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6362_EXT_IRQ3 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6362;
+		break;
 	case BCM6368_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6368_REG;
 		irq_mask_addr += PERF_IRQMASK_6368_REG;
@@ -458,6 +479,7 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 	case BCM6338_CPU_ID:
 	case BCM6345_CPU_ID:
 	case BCM6358_CPU_ID:
+	case BCM6362_CPU_ID:
 	case BCM6368_CPU_ID:
 		if (levelsense)
 			reg |= EXTIRQ_CFG_LEVELSENSE(irq);
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 10eaff4..fd69808 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -36,6 +36,8 @@ void __init prom_init(void)
 		mask = CKCTL_6348_ALL_SAFE_EN;
 	else if (BCMCPU_IS_6358())
 		mask = CKCTL_6358_ALL_SAFE_EN;
+	else if (BCMCPU_IS_6362())
+		mask = CKCTL_6362_ALL_SAFE_EN;
 	else if (BCMCPU_IS_6368())
 		mask = CKCTL_6368_ALL_SAFE_EN;
 	else
diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index 68a31bb..317931c 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -85,6 +85,20 @@
 #define BCM6358_RESET_PCIE	0
 #define BCM6358_RESET_PCIE_EXT	0
 
+#define BCM6362_RESET_SPI	SOFTRESET_6362_SPI_MASK
+#define BCM6362_RESET_ENET	0
+#define BCM6362_RESET_USBH	SOFTRESET_6362_USBH_MASK
+#define BCM6362_RESET_USBD	SOFTRESET_6362_USBS_MASK
+#define BCM6362_RESET_DSL	0
+#define BCM6362_RESET_SAR	SOFTRESET_6362_SAR_MASK
+#define BCM6362_RESET_EPHY	SOFTRESET_6362_EPHY_MASK
+#define BCM6362_RESET_ENETSW	SOFTRESET_6362_ENETSW_MASK
+#define BCM6362_RESET_PCM	SOFTRESET_6362_PCM_MASK
+#define BCM6362_RESET_MPI	0
+#define BCM6362_RESET_PCIE      (SOFTRESET_6362_PCIE_MASK | \
+				 SOFTRESET_6362_PCIE_CORE_MASK)
+#define BCM6362_RESET_PCIE_EXT	SOFTRESET_6362_PCIE_EXT_MASK
+
 #define BCM6368_RESET_SPI	SOFTRESET_6368_SPI_MASK
 #define BCM6368_RESET_ENET	0
 #define BCM6368_RESET_USBH	SOFTRESET_6368_USBH_MASK
@@ -119,6 +133,10 @@ static const u32 bcm6358_reset_bits[] = {
 	__GEN_RESET_BITS_TABLE(6358)
 };
 
+static const u32 bcm6362_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6362)
+};
+
 static const u32 bcm6368_reset_bits[] = {
 	__GEN_RESET_BITS_TABLE(6368)
 };
@@ -140,6 +158,9 @@ static int __init bcm63xx_reset_bits_init(void)
 	} else if (BCMCPU_IS_6358()) {
 		reset_reg = PERF_SOFTRESET_6358_REG;
 		bcm63xx_reset_bits = bcm6358_reset_bits;
+	} else if (BCMCPU_IS_6362()) {
+		reset_reg = PERF_SOFTRESET_6362_REG;
+		bcm63xx_reset_bits = bcm6362_reset_bits;
 	} else if (BCMCPU_IS_6368()) {
 		reset_reg = PERF_SOFTRESET_6368_REG;
 		bcm63xx_reset_bits = bcm6368_reset_bits;
@@ -182,6 +203,13 @@ static const u32 bcm63xx_reset_bits[] = {
 #define reset_reg PERF_SOFTRESET_6358_REG
 #endif
 
+#ifdef CONFIG_BCM63XX_CPU_6362
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6362)
+};
+#define reset_reg PERF_SOFTRESET_6362_REG
+#endif
+
 #ifdef CONFIG_BCM63XX_CPU_6368
 static const u32 bcm63xx_reset_bits[] = {
 	__GEN_RESET_BITS_TABLE(6368)
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 911fd7d..24a2444 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -83,6 +83,9 @@ void bcm63xx_machine_reboot(void)
 	case BCM6358_CPU_ID:
 		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6358;
 		break;
+	case BCM6362_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6362;
+		break;
 	}
 
 	for (i = 0; i < 2; i++) {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 19a80ea..3362289 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -14,6 +14,7 @@
 #define BCM6345_CPU_ID		0x6345
 #define BCM6348_CPU_ID		0x6348
 #define BCM6358_CPU_ID		0x6358
+#define BCM6362_CPU_ID		0x6362
 #define BCM6368_CPU_ID		0x6368
 
 void __init bcm63xx_cpu_init(void);
@@ -86,6 +87,20 @@ unsigned int bcm63xx_get_cpu_freq(void);
 # define BCMCPU_IS_6358()	(0)
 #endif
 
+#ifdef CONFIG_BCM63XX_CPU_6362
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6362_CPU_ID
+# endif
+# define BCMCPU_IS_6362()	(bcm63xx_get_cpu_id() == BCM6362_CPU_ID)
+#else
+# define BCMCPU_IS_6362()	(0)
+#endif
+
+
 #ifdef CONFIG_BCM63XX_CPU_6368
 # ifdef bcm63xx_get_cpu_id
 #  undef bcm63xx_get_cpu_id
@@ -406,6 +421,62 @@ enum bcm63xx_regs_set {
 
 
 /*
+ * 6362 register sets base address
+ */
+#define BCM_6362_DSL_LMEM_BASE		(0xdeadbeef)
+#define BCM_6362_PERF_BASE		(0xb0000000)
+#define BCM_6362_TIMER_BASE		(0xb0000040)
+#define BCM_6362_WDT_BASE		(0xb000005c)
+#define BCM_6362_UART0_BASE             (0xb0000100)
+#define BCM_6362_UART1_BASE		(0xb0000120)
+#define BCM_6362_GPIO_BASE		(0xb0000080)
+#define BCM_6362_SPI_BASE		(0xb0000800)
+#define BCM_6362_HSSPI_BASE		(0xb0001000)
+#define BCM_6362_UDC0_BASE		(0xdeadbeef)
+#define BCM_6362_USBDMA_BASE		(0xb000c000)
+#define BCM_6362_OHCI0_BASE		(0xb0002600)
+#define BCM_6362_OHCI_PRIV_BASE		(0xdeadbeef)
+#define BCM_6362_USBH_PRIV_BASE		(0xb0002700)
+#define BCM_6362_USBD_BASE		(0xb0002400)
+#define BCM_6362_MPI_BASE		(0xdeadbeef)
+#define BCM_6362_PCMCIA_BASE		(0xdeadbeef)
+#define BCM_6362_PCIE_BASE		(0xb0e40000)
+#define BCM_6362_SDRAM_REGS_BASE	(0xdeadbeef)
+#define BCM_6362_DSL_BASE		(0xdeadbeef)
+#define BCM_6362_UBUS_BASE		(0xdeadbeef)
+#define BCM_6362_ENET0_BASE		(0xdeadbeef)
+#define BCM_6362_ENET1_BASE		(0xdeadbeef)
+#define BCM_6362_ENETDMA_BASE		(0xb000d800)
+#define BCM_6362_ENETDMAC_BASE		(0xb000da00)
+#define BCM_6362_ENETDMAS_BASE		(0xb000dc00)
+#define BCM_6362_ENETSW_BASE		(0xb0e00000)
+#define BCM_6362_EHCI0_BASE		(0xb0002500)
+#define BCM_6362_SDRAM_BASE		(0xdeadbeef)
+#define BCM_6362_MEMC_BASE		(0xdeadbeef)
+#define BCM_6362_DDR_BASE		(0xb0003000)
+#define BCM_6362_M2M_BASE		(0xdeadbeef)
+#define BCM_6362_ATM_BASE		(0xdeadbeef)
+#define BCM_6362_XTM_BASE		(0xb0007800)
+#define BCM_6362_XTMDMA_BASE		(0xb000b800)
+#define BCM_6362_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_6362_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_6362_PCM_BASE		(0xb000a800)
+#define BCM_6362_PCMDMA_BASE		(0xdeadbeef)
+#define BCM_6362_PCMDMAC_BASE		(0xdeadbeef)
+#define BCM_6362_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6362_RNG_BASE		(0xdeadbeef)
+#define BCM_6362_MISC_BASE		(0xb0001800)
+
+#define BCM_6362_NAND_REG_BASE		(0xb0000200)
+#define BCM_6362_NAND_CACHE_BASE	(0xb0000600)
+#define BCM_6362_LED_BASE		(0xb0001900)
+#define BCM_6362_IPSEC_BASE		(0xb0002800)
+#define BCM_6362_IPSEC_DMA_BASE		(0xb000d000)
+#define BCM_6362_WLAN_CHIPCOMMON_BASE	(0xb0004000)
+#define BCM_6362_WLAN_D11_BASE		(0xb0005000)
+#define BCM_6362_WLAN_SHIM_BASE		(0xb0007000)
+
+/*
  * 6368 register sets base address
  */
 #define BCM_6368_DSL_LMEM_BASE		(0xdeadbeef)
@@ -564,6 +635,9 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 #ifdef CONFIG_BCM63XX_CPU_6358
 	__GEN_RSET(6358)
 #endif
+#ifdef CONFIG_BCM63XX_CPU_6362
+	__GEN_RSET(6362)
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6368
 	__GEN_RSET(6368)
 #endif
@@ -820,6 +894,71 @@ enum bcm63xx_irq {
 #define BCM_6358_EXT_IRQ3		(IRQ_INTERNAL_BASE + 28)
 
 /*
+ * 6362 irqs
+ */
+#define BCM_6362_HIGH_IRQ_BASE		(IRQ_INTERNAL_BASE + 32)
+
+#define BCM_6362_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6362_SPI_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6362_UART0_IRQ		(IRQ_INTERNAL_BASE + 3)
+#define BCM_6362_UART1_IRQ		(IRQ_INTERNAL_BASE + 4)
+#define BCM_6362_DSL_IRQ		(IRQ_INTERNAL_BASE + 28)
+#define BCM_6362_UDC0_IRQ		0
+#define BCM_6362_ENET0_IRQ		0
+#define BCM_6362_ENET1_IRQ		0
+#define BCM_6362_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 14)
+#define BCM_6362_HSSPI_IRQ		(IRQ_INTERNAL_BASE + 5)
+#define BCM_6362_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6362_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
+#define BCM_6362_USBD_IRQ		(IRQ_INTERNAL_BASE + 11)
+#define BCM_6362_USBD_RXDMA0_IRQ	(IRQ_INTERNAL_BASE + 20)
+#define BCM_6362_USBD_TXDMA0_IRQ	(IRQ_INTERNAL_BASE + 21)
+#define BCM_6362_USBD_RXDMA1_IRQ	(IRQ_INTERNAL_BASE + 22)
+#define BCM_6362_USBD_TXDMA1_IRQ	(IRQ_INTERNAL_BASE + 23)
+#define BCM_6362_USBD_RXDMA2_IRQ	(IRQ_INTERNAL_BASE + 24)
+#define BCM_6362_USBD_TXDMA2_IRQ	(IRQ_INTERNAL_BASE + 25)
+#define BCM_6362_PCMCIA_IRQ		0
+#define BCM_6362_ENET0_RXDMA_IRQ	0
+#define BCM_6362_ENET0_TXDMA_IRQ	0
+#define BCM_6362_ENET1_RXDMA_IRQ	0
+#define BCM_6362_ENET1_TXDMA_IRQ	0
+#define BCM_6362_PCI_IRQ		(IRQ_INTERNAL_BASE + 30)
+#define BCM_6362_ATM_IRQ		0
+#define BCM_6362_ENETSW_RXDMA0_IRQ	(BCM_6362_HIGH_IRQ_BASE + 0)
+#define BCM_6362_ENETSW_RXDMA1_IRQ	(BCM_6362_HIGH_IRQ_BASE + 1)
+#define BCM_6362_ENETSW_RXDMA2_IRQ	(BCM_6362_HIGH_IRQ_BASE + 2)
+#define BCM_6362_ENETSW_RXDMA3_IRQ	(BCM_6362_HIGH_IRQ_BASE + 3)
+#define BCM_6362_ENETSW_TXDMA0_IRQ	0
+#define BCM_6362_ENETSW_TXDMA1_IRQ	0
+#define BCM_6362_ENETSW_TXDMA2_IRQ	0
+#define BCM_6362_ENETSW_TXDMA3_IRQ	0
+#define BCM_6362_XTM_IRQ		0
+#define BCM_6362_XTM_DMA0_IRQ		(BCM_6362_HIGH_IRQ_BASE + 12)
+
+#define BCM_6362_RING_OSC_IRQ		(IRQ_INTERNAL_BASE + 1)
+#define BCM_6362_WLAN_GPIO_IRQ		(IRQ_INTERNAL_BASE + 6)
+#define BCM_6362_WLAN_IRQ		(IRQ_INTERNAL_BASE + 7)
+#define BCM_6362_IPSEC_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6362_NAND_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6362_PCM_IRQ		(IRQ_INTERNAL_BASE + 13)
+#define BCM_6362_DG_IRQ			(IRQ_INTERNAL_BASE + 15)
+#define BCM_6362_EPHY_ENERGY0_IRQ	(IRQ_INTERNAL_BASE + 16)
+#define BCM_6362_EPHY_ENERGY1_IRQ	(IRQ_INTERNAL_BASE + 17)
+#define BCM_6362_EPHY_ENERGY2_IRQ	(IRQ_INTERNAL_BASE + 18)
+#define BCM_6362_EPHY_ENERGY3_IRQ	(IRQ_INTERNAL_BASE + 19)
+#define BCM_6362_IPSEC_DMA0_IRQ		(IRQ_INTERNAL_BASE + 26)
+#define BCM_6362_IPSEC_DMA1_IRQ		(IRQ_INTERNAL_BASE + 27)
+#define BCM_6362_FAP0_IRQ		(IRQ_INTERNAL_BASE + 29)
+#define BCM_6362_PCM_DMA0_IRQ		(BCM_6362_HIGH_IRQ_BASE + 4)
+#define BCM_6362_PCM_DMA1_IRQ		(BCM_6362_HIGH_IRQ_BASE + 5)
+#define BCM_6362_DECT0_IRQ		(BCM_6362_HIGH_IRQ_BASE + 6)
+#define BCM_6362_DECT1_IRQ		(BCM_6362_HIGH_IRQ_BASE + 7)
+#define BCM_6362_EXT_IRQ0		(BCM_6362_HIGH_IRQ_BASE + 8)
+#define BCM_6362_EXT_IRQ1		(BCM_6362_HIGH_IRQ_BASE + 9)
+#define BCM_6362_EXT_IRQ2		(BCM_6362_HIGH_IRQ_BASE + 10)
+#define BCM_6362_EXT_IRQ3		(BCM_6362_HIGH_IRQ_BASE + 11)
+
+/*
  * 6368 irqs
  */
 #define BCM_6368_HIGH_IRQ_BASE		(IRQ_INTERNAL_BASE + 32)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 0a9891f..35baa1a 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -17,6 +17,8 @@ static inline unsigned long bcm63xx_gpio_count(void)
 		return 8;
 	case BCM6345_CPU_ID:
 		return 16;
+	case BCM6362_CPU_ID:
+		return 48;
 	case BCM6368_CPU_ID:
 		return 38;
 	case BCM6348_CPU_ID:
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index fe3601a..129b8a6 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -112,6 +112,39 @@
 					CKCTL_6358_USBSU_EN |		\
 					CKCTL_6358_EPHY_EN)
 
+#define CKCTL_6362_ADSL_QPROC_EN	(1 << 1)
+#define CKCTL_6362_ADSL_AFE_EN		(1 << 2)
+#define CKCTL_6362_ADSL_EN		(1 << 3)
+#define CKCTL_6362_MIPS_EN		(1 << 4)
+#define CKCTL_6362_WLAN_OCP_EN		(1 << 5)
+#define CKCTL_6362_SWPKT_USB_EN		(1 << 7)
+#define CKCTL_6362_SWPKT_SAR_EN		(1 << 8)
+#define CKCTL_6362_SAR_EN		(1 << 9)
+#define CKCTL_6362_ROBOSW_EN		(1 << 10)
+#define CKCTL_6362_PCM_EN		(1 << 11)
+#define CKCTL_6362_USBD_EN		(1 << 12)
+#define CKCTL_6362_USBH_EN		(1 << 13)
+#define CKCTL_6362_IPSEC_EN		(1 << 14)
+#define CKCTL_6362_SPI_EN		(1 << 15)
+#define CKCTL_6362_HSSPI_EN		(1 << 16)
+#define CKCTL_6362_PCIE_EN		(1 << 17)
+#define CKCTL_6362_FAP_EN		(1 << 18)
+#define CKCTL_6362_PHYMIPS_EN		(1 << 19)
+#define CKCTL_6362_NAND_EN		(1 << 20)
+
+#define CKCTL_6362_ALL_SAFE_EN		(CKCTL_6362_PHYMIPS_EN |	\
+					CKCTL_6362_ADSL_QPROC_EN |	\
+					CKCTL_6362_ADSL_AFE_EN |	\
+					CKCTL_6362_ADSL_EN |		\
+					CKCTL_6362_SAR_EN  |		\
+					CKCTL_6362_PCM_EN  |		\
+					CKCTL_6362_IPSEC_EN |		\
+					CKCTL_6362_USBD_EN |		\
+					CKCTL_6362_USBH_EN |		\
+					CKCTL_6362_ROBOSW_EN |		\
+					CKCTL_6362_PCIE_EN)
+
+
 #define CKCTL_6368_VDSL_QPROC_EN	(1 << 2)
 #define CKCTL_6368_VDSL_AFE_EN		(1 << 3)
 #define CKCTL_6368_VDSL_BONDING_EN	(1 << 4)
@@ -153,6 +186,7 @@
 #define PERF_IRQMASK_6345_REG		0xc
 #define PERF_IRQMASK_6348_REG		0xc
 #define PERF_IRQMASK_6358_REG		0xc
+#define PERF_IRQMASK_6362_REG		0x20
 #define PERF_IRQMASK_6368_REG		0x20
 
 /* Interrupt Status register */
@@ -161,6 +195,7 @@
 #define PERF_IRQSTAT_6345_REG		0x10
 #define PERF_IRQSTAT_6348_REG		0x10
 #define PERF_IRQSTAT_6358_REG		0x10
+#define PERF_IRQSTAT_6362_REG		0x28
 #define PERF_IRQSTAT_6368_REG		0x28
 
 /* External Interrupt Configuration register */
@@ -169,6 +204,7 @@
 #define PERF_EXTIRQ_CFG_REG_6345	0x14
 #define PERF_EXTIRQ_CFG_REG_6348	0x14
 #define PERF_EXTIRQ_CFG_REG_6358	0x14
+#define PERF_EXTIRQ_CFG_REG_6362	0x18
 #define PERF_EXTIRQ_CFG_REG_6368	0x18
 
 #define PERF_EXTIRQ_CFG_REG2_6368	0x1c
@@ -197,6 +233,7 @@
 #define PERF_SOFTRESET_REG		0x28
 #define PERF_SOFTRESET_6328_REG		0x10
 #define PERF_SOFTRESET_6358_REG		0x34
+#define PERF_SOFTRESET_6362_REG		0x10
 #define PERF_SOFTRESET_6368_REG		0x10
 
 #define SOFTRESET_6328_SPI_MASK		(1 << 0)
@@ -259,6 +296,22 @@
 #define SOFTRESET_6358_PCM_MASK		(1 << 13)
 #define SOFTRESET_6358_ADSL_MASK	(1 << 14)
 
+#define SOFTRESET_6362_SPI_MASK		(1 << 0)
+#define SOFTRESET_6362_IPSEC_MASK	(1 << 1)
+#define SOFTRESET_6362_EPHY_MASK	(1 << 2)
+#define SOFTRESET_6362_SAR_MASK		(1 << 3)
+#define SOFTRESET_6362_ENETSW_MASK	(1 << 4)
+#define SOFTRESET_6362_USBS_MASK	(1 << 5)
+#define SOFTRESET_6362_USBH_MASK	(1 << 6)
+#define SOFTRESET_6362_PCM_MASK		(1 << 7)
+#define SOFTRESET_6362_PCIE_CORE_MASK	(1 << 8)
+#define SOFTRESET_6362_PCIE_MASK	(1 << 9)
+#define SOFTRESET_6362_PCIE_EXT_MASK	(1 << 10)
+#define SOFTRESET_6362_WLAN_SHIM_MASK	(1 << 11)
+#define SOFTRESET_6362_DDR_PHY_MASK	(1 << 12)
+#define SOFTRESET_6362_FAP_MASK		(1 << 13)
+#define SOFTRESET_6362_WLAN_UBUS_MASK	(1 << 14)
+
 #define SOFTRESET_6368_SPI_MASK		(1 << 0)
 #define SOFTRESET_6368_MPI_MASK		(1 << 3)
 #define SOFTRESET_6368_EPHY_MASK	(1 << 6)
@@ -1240,7 +1293,7 @@
 #define SPI_6348_RX_DATA		0x80
 #define SPI_6348_RX_DATA_SIZE		0x3f
 
-/* BCM 6358/6368 SPI core */
+/* BCM 6358/6262/6368 SPI core */
 #define SPI_6358_MSG_CTL		0x00	/* 16-bits register */
 #define SPI_6358_MSG_CTL_WIDTH		16
 #define SPI_6358_MSG_DATA		0x02
@@ -1316,6 +1369,12 @@
 #define SERDES_PCIE_EN			(1 << 0)
 #define SERDES_PCIE_EXD_EN		(1 << 15)
 
+#define MISC_STRAPBUS_6362_REG		0x14
+#define STRAPBUS_6362_FCVO_SHIFT	1
+#define STRAPBUS_6362_FCVO_MASK		(0x1f << STRAPBUS_6362_FCVO_SHIFT)
+#define STRAPBUS_6362_BOOT_SEL_SERIAL	(1 << 15)
+#define STRAPBUS_6362_BOOT_SEL_NAND	(0 << 15)
+
 #define MISC_STRAPBUS_6328_REG		0x240
 #define STRAPBUS_6328_FCVO_SHIFT	7
 #define STRAPBUS_6328_FCVO_MASK		(0x1f << STRAPBUS_6328_FCVO_SHIFT)
diff --git a/arch/mips/include/asm/mach-bcm63xx/ioremap.h b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
index 30931c4..94e3011 100644
--- a/arch/mips/include/asm/mach-bcm63xx/ioremap.h
+++ b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
@@ -19,6 +19,7 @@ static inline int is_bcm63xx_internal_registers(phys_t offset)
 			return 1;
 		break;
 	case BCM6328_CPU_ID:
+	case BCM6362_CPU_ID:
 	case BCM6368_CPU_ID:
 		if (offset >= 0xb0000000 && offset < 0xb1000000)
 			return 1;
-- 
1.7.10.4
