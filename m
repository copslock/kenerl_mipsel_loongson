Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:07:38 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491865AbZGARHK
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 19:07:10 +0200
Message-Id: <20090701120939.442145090@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 02/12] MIPS: BCM63XX: Add support for the Broadcom BCM63xx family of SOCs.
References: <20090701112926.825088732@linux-mips.org>
Content-Disposition: inline; filename=0002.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From:	Maxime Bizon <mbizon@freebox.fr>

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/Kconfig                                          |   18 
 arch/mips/Makefile                                         |    7 
 arch/mips/bcm63xx/Kconfig                                  |    9 
 arch/mips/bcm63xx/Makefile                                 |    4 
 arch/mips/bcm63xx/clk.c                                    |  220 +++
 arch/mips/bcm63xx/cpu.c                                    |  245 ++++
 arch/mips/bcm63xx/cs.c                                     |  144 ++
 arch/mips/bcm63xx/early_printk.c                           |   30 
 arch/mips/bcm63xx/gpio.c                                   |  128 ++
 arch/mips/bcm63xx/irq.c                                    |  253 ++++
 arch/mips/bcm63xx/prom.c                                   |   43 
 arch/mips/bcm63xx/setup.c                                  |  111 +
 arch/mips/bcm63xx/timer.c                                  |  205 +++
 arch/mips/include/asm/fixmap.h                             |    4 
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h           |   11 
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h           |  314 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cs.h            |   10 
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h          |   10 
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h            |   93 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h           |   15 
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h          |  728 +++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h         |   11 
 arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h |   51 
 arch/mips/include/asm/mach-bcm63xx/gpio.h                  |   17 
 arch/mips/include/asm/mach-bcm63xx/war.h                   |   25 
 25 files changed, 2705 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm63xx/Kconfig
 create mode 100644 arch/mips/bcm63xx/Makefile
 create mode 100644 arch/mips/bcm63xx/clk.c
 create mode 100644 arch/mips/bcm63xx/cpu.c
 create mode 100644 arch/mips/bcm63xx/cs.c
 create mode 100644 arch/mips/bcm63xx/early_printk.c
 create mode 100644 arch/mips/bcm63xx/gpio.c
 create mode 100644 arch/mips/bcm63xx/irq.c
 create mode 100644 arch/mips/bcm63xx/prom.c
 create mode 100644 arch/mips/bcm63xx/setup.c
 create mode 100644 arch/mips/bcm63xx/timer.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cs.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/gpio.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -60,7 +60,7 @@ config BASLER_EXCITE
 	  Basler Vision Technologies AG.
 
 config BCM47XX
-	bool "BCM47XX based boards"
+	bool "Broadcom BCM47XX based boards"
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
@@ -80,6 +80,21 @@ config BCM47XX
 	help
 	 Support for BCM47XX based boards
 
+config BCM63XX
+	bool "Broadcom BCM63XX based boards"
+	select CEVT_R4K
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
+	select SWAP_IO_SPACE
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	 Support for BCM63XX based boards
+
 config MIPS_COBALT
 	bool "Cobalt Server"
 	select CEVT_R4K
@@ -659,6 +674,7 @@ endchoice
 
 source "arch/mips/alchemy/Kconfig"
 source "arch/mips/basler/excite/Kconfig"
+source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -560,6 +560,13 @@ cflags-$(CONFIG_BCM47XX)	+= -I$(srctree)
 load-$(CONFIG_BCM47XX)		:= 0xffffffff80001000
 
 #
+# Broadcom BCM63XX boards
+#
+core-$(CONFIG_BCM63XX)		+= arch/mips/bcm63xx/
+cflags-$(CONFIG_BCM63XX)	+= -I$(srctree)/arch/mips/include/asm/mach-bcm63xx/
+load-$(CONFIG_BCM63XX)		:= 0xffffffff80010000
+
+#
 # SNI RM
 #
 core-$(CONFIG_SNI_RM)		+= arch/mips/sni/
--- /dev/null
+++ b/arch/mips/bcm63xx/Kconfig
@@ -0,0 +1,9 @@
+menu "CPU support"
+	depends on BCM63XX
+
+config BCM63XX_CPU_6348
+	bool "support 6348 CPU"
+
+config BCM63XX_CPU_6358
+	bool "support 6358 CPU"
+endmenu
--- /dev/null
+++ b/arch/mips/bcm63xx/Makefile
@@ -0,0 +1,4 @@
+obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o
+obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+
+EXTRA_CFLAGS += -Werror
--- /dev/null
+++ b/arch/mips/bcm63xx/clk.c
@@ -0,0 +1,220 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_clk.h>
+
+DEFINE_MUTEX(clocks_mutex);
+
+
+static void clk_enable_unlocked(struct clk *clk)
+{
+	if (clk->set && (clk->usage++) == 0)
+		clk->set(clk, 1);
+}
+
+static void clk_disable_unlocked(struct clk *clk)
+{
+	if (clk->set && (--clk->usage) == 0)
+		clk->set(clk, 0);
+}
+
+static void bcm_hwclock_set(u32 mask, int enable)
+{
+	u32 reg;
+
+	reg = bcm_perf_readl(PERF_CKCTL_REG);
+	if (enable)
+		reg |= mask;
+	else
+		reg &= ~mask;
+	bcm_perf_writel(reg, PERF_CKCTL_REG);
+}
+
+/*
+ * Ethernet MAC "misc" clock: dma clocks and main clock on 6348
+ */
+static void enet_misc_set(struct clk *clk, int enable)
+{
+	u32 mask;
+
+	if (BCMCPU_IS_6348())
+		mask = CKCTL_6348_ENET_EN;
+	else
+		/* BCMCPU_IS_6358 */
+		mask = CKCTL_6358_EMUSB_EN;
+	bcm_hwclock_set(mask, enable);
+}
+
+static struct clk clk_enet_misc = {
+	.set	= enet_misc_set,
+};
+
+/*
+ * Ethernet MAC clocks: only revelant on 6358, silently enable misc
+ * clocks
+ */
+static void enetx_set(struct clk *clk, int enable)
+{
+	if (enable)
+		clk_enable_unlocked(&clk_enet_misc);
+	else
+		clk_disable_unlocked(&clk_enet_misc);
+
+	if (BCMCPU_IS_6358()) {
+		u32 mask;
+
+		if (clk->id == 0)
+			mask = CKCTL_6358_ENET0_EN;
+		else
+			mask = CKCTL_6358_ENET1_EN;
+		bcm_hwclock_set(mask, enable);
+	}
+}
+
+static struct clk clk_enet0 = {
+	.id	= 0,
+	.set	= enetx_set,
+};
+
+static struct clk clk_enet1 = {
+	.id	= 1,
+	.set	= enetx_set,
+};
+
+/*
+ * Ethernet PHY clock
+ */
+static void ephy_set(struct clk *clk, int enable)
+{
+	if (!BCMCPU_IS_6358())
+		return;
+	bcm_hwclock_set(CKCTL_6358_EPHY_EN, enable);
+}
+
+
+static struct clk clk_ephy = {
+	.set	= ephy_set,
+};
+
+/*
+ * PCM clock
+ */
+static void pcm_set(struct clk *clk, int enable)
+{
+	if (!BCMCPU_IS_6358())
+		return;
+	bcm_hwclock_set(CKCTL_6358_PCM_EN, enable);
+}
+
+static struct clk clk_pcm = {
+	.set	= pcm_set,
+};
+
+/*
+ * USB host clock
+ */
+static void usbh_set(struct clk *clk, int enable)
+{
+	if (!BCMCPU_IS_6348())
+		return;
+	bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
+}
+
+static struct clk clk_usbh = {
+	.set	= usbh_set,
+};
+
+/*
+ * SPI clock
+ */
+static void spi_set(struct clk *clk, int enable)
+{
+	u32 mask;
+
+	if (BCMCPU_IS_6348())
+		mask = CKCTL_6348_SPI_EN;
+	else
+		/* BCMCPU_IS_6358 */
+		mask = CKCTL_6358_SPI_EN;
+	bcm_hwclock_set(mask, enable);
+}
+
+static struct clk clk_spi = {
+	.set	= spi_set,
+};
+
+/*
+ * Internal peripheral clock
+ */
+static struct clk clk_periph = {
+	.rate	= (50 * 1000 * 1000),
+};
+
+
+/*
+ * Linux clock API implementation
+ */
+int clk_enable(struct clk *clk)
+{
+	mutex_lock(&clocks_mutex);
+	clk_enable_unlocked(clk);
+	mutex_unlock(&clocks_mutex);
+	return 0;
+}
+
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	mutex_lock(&clocks_mutex);
+	clk_disable_unlocked(clk);
+	mutex_unlock(&clocks_mutex);
+}
+
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+EXPORT_SYMBOL(clk_get_rate);
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "enet0"))
+		return &clk_enet0;
+	if (!strcmp(id, "enet1"))
+		return &clk_enet1;
+	if (!strcmp(id, "ephy"))
+		return &clk_ephy;
+	if (!strcmp(id, "usbh"))
+		return &clk_usbh;
+	if (!strcmp(id, "spi"))
+		return &clk_spi;
+	if (!strcmp(id, "periph"))
+		return &clk_periph;
+	if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
+		return &clk_pcm;
+	return ERR_PTR(-ENOENT);
+}
+
+EXPORT_SYMBOL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+}
+
+EXPORT_SYMBOL(clk_put);
--- /dev/null
+++ b/arch/mips/bcm63xx/cpu.c
@@ -0,0 +1,245 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_irq.h>
+
+const unsigned long *bcm63xx_regs_base;
+EXPORT_SYMBOL(bcm63xx_regs_base);
+
+const int *bcm63xx_irqs;
+EXPORT_SYMBOL(bcm63xx_irqs);
+
+static u16 bcm63xx_cpu_id;
+static u16 bcm63xx_cpu_rev;
+static unsigned int bcm63xx_cpu_freq;
+static unsigned int bcm63xx_memory_size;
+
+/*
+ * 6348 register sets and irqs
+ */
+static const unsigned long bcm96348_regs_base[] = {
+	[RSET_DSL_LMEM]		= BCM_6348_DSL_LMEM_BASE,
+	[RSET_PERF]		= BCM_6348_PERF_BASE,
+	[RSET_TIMER]		= BCM_6348_TIMER_BASE,
+	[RSET_WDT]		= BCM_6348_WDT_BASE,
+	[RSET_UART0]		= BCM_6348_UART0_BASE,
+	[RSET_GPIO]		= BCM_6348_GPIO_BASE,
+	[RSET_SPI]		= BCM_6348_SPI_BASE,
+	[RSET_OHCI0]		= BCM_6348_OHCI0_BASE,
+	[RSET_OHCI_PRIV]	= BCM_6348_OHCI_PRIV_BASE,
+	[RSET_USBH_PRIV]	= BCM_6348_USBH_PRIV_BASE,
+	[RSET_MPI]		= BCM_6348_MPI_BASE,
+	[RSET_PCMCIA]		= BCM_6348_PCMCIA_BASE,
+	[RSET_SDRAM]		= BCM_6348_SDRAM_BASE,
+	[RSET_DSL]		= BCM_6348_DSL_BASE,
+	[RSET_ENET0]		= BCM_6348_ENET0_BASE,
+	[RSET_ENET1]		= BCM_6348_ENET1_BASE,
+	[RSET_ENETDMA]		= BCM_6348_ENETDMA_BASE,
+	[RSET_MEMC]		= BCM_6348_MEMC_BASE,
+	[RSET_DDR]		= BCM_6348_DDR_BASE,
+};
+
+static const int bcm96348_irqs[] = {
+	[IRQ_TIMER]		= BCM_6348_TIMER_IRQ,
+	[IRQ_UART0]		= BCM_6348_UART0_IRQ,
+	[IRQ_DSL]		= BCM_6348_DSL_IRQ,
+	[IRQ_ENET0]		= BCM_6348_ENET0_IRQ,
+	[IRQ_ENET1]		= BCM_6348_ENET1_IRQ,
+	[IRQ_ENET_PHY]		= BCM_6348_ENET_PHY_IRQ,
+	[IRQ_OHCI0]		= BCM_6348_OHCI0_IRQ,
+	[IRQ_PCMCIA]		= BCM_6348_PCMCIA_IRQ,
+	[IRQ_ENET0_RXDMA]	= BCM_6348_ENET0_RXDMA_IRQ,
+	[IRQ_ENET0_TXDMA]	= BCM_6348_ENET0_TXDMA_IRQ,
+	[IRQ_ENET1_RXDMA]	= BCM_6348_ENET1_RXDMA_IRQ,
+	[IRQ_ENET1_TXDMA]	= BCM_6348_ENET1_TXDMA_IRQ,
+	[IRQ_PCI]		= BCM_6348_PCI_IRQ,
+};
+
+/*
+ * 6358 register sets and irqs
+ */
+static const unsigned long bcm96358_regs_base[] = {
+	[RSET_DSL_LMEM]		= BCM_6358_DSL_LMEM_BASE,
+	[RSET_PERF]		= BCM_6358_PERF_BASE,
+	[RSET_TIMER]		= BCM_6358_TIMER_BASE,
+	[RSET_WDT]		= BCM_6358_WDT_BASE,
+	[RSET_UART0]		= BCM_6358_UART0_BASE,
+	[RSET_GPIO]		= BCM_6358_GPIO_BASE,
+	[RSET_SPI]		= BCM_6358_SPI_BASE,
+	[RSET_OHCI0]		= BCM_6358_OHCI0_BASE,
+	[RSET_EHCI0]		= BCM_6358_EHCI0_BASE,
+	[RSET_OHCI_PRIV]	= BCM_6358_OHCI_PRIV_BASE,
+	[RSET_USBH_PRIV]	= BCM_6358_USBH_PRIV_BASE,
+	[RSET_MPI]		= BCM_6358_MPI_BASE,
+	[RSET_PCMCIA]		= BCM_6358_PCMCIA_BASE,
+	[RSET_SDRAM]		= BCM_6358_SDRAM_BASE,
+	[RSET_DSL]		= BCM_6358_DSL_BASE,
+	[RSET_ENET0]		= BCM_6358_ENET0_BASE,
+	[RSET_ENET1]		= BCM_6358_ENET1_BASE,
+	[RSET_ENETDMA]		= BCM_6358_ENETDMA_BASE,
+	[RSET_MEMC]		= BCM_6358_MEMC_BASE,
+	[RSET_DDR]		= BCM_6358_DDR_BASE,
+};
+
+static const int bcm96358_irqs[] = {
+	[IRQ_TIMER]		= BCM_6358_TIMER_IRQ,
+	[IRQ_UART0]		= BCM_6358_UART0_IRQ,
+	[IRQ_DSL]		= BCM_6358_DSL_IRQ,
+	[IRQ_ENET0]		= BCM_6358_ENET0_IRQ,
+	[IRQ_ENET1]		= BCM_6358_ENET1_IRQ,
+	[IRQ_ENET_PHY]		= BCM_6358_ENET_PHY_IRQ,
+	[IRQ_OHCI0]		= BCM_6358_OHCI0_IRQ,
+	[IRQ_EHCI0]		= BCM_6358_EHCI0_IRQ,
+	[IRQ_PCMCIA]		= BCM_6358_PCMCIA_IRQ,
+	[IRQ_ENET0_RXDMA]	= BCM_6358_ENET0_RXDMA_IRQ,
+	[IRQ_ENET0_TXDMA]	= BCM_6358_ENET0_TXDMA_IRQ,
+	[IRQ_ENET1_RXDMA]	= BCM_6358_ENET1_RXDMA_IRQ,
+	[IRQ_ENET1_TXDMA]	= BCM_6358_ENET1_TXDMA_IRQ,
+	[IRQ_PCI]		= BCM_6358_PCI_IRQ,
+};
+
+u16 __bcm63xx_get_cpu_id(void)
+{
+	return bcm63xx_cpu_id;
+}
+
+EXPORT_SYMBOL(__bcm63xx_get_cpu_id);
+
+u16 bcm63xx_get_cpu_rev(void)
+{
+	return bcm63xx_cpu_rev;
+}
+
+EXPORT_SYMBOL(bcm63xx_get_cpu_rev);
+
+unsigned int bcm63xx_get_cpu_freq(void)
+{
+	return bcm63xx_cpu_freq;
+}
+
+unsigned int bcm63xx_get_memory_size(void)
+{
+	return bcm63xx_memory_size;
+}
+
+static unsigned int detect_cpu_clock(void)
+{
+	unsigned int tmp, n1 = 0, n2 = 0, m1 = 0;
+
+	/*
+	 * frequency depends on PLL configuration:
+	 */
+	if (BCMCPU_IS_6348()) {
+		/* 16MHz * (N1 + 1) * (N2 + 2) / (M1_CPU + 1) */
+		tmp = bcm_perf_readl(PERF_MIPSPLLCTL_REG);
+		n1 = (tmp & MIPSPLLCTL_N1_MASK) >> MIPSPLLCTL_N1_SHIFT;
+		n2 = (tmp & MIPSPLLCTL_N2_MASK) >> MIPSPLLCTL_N2_SHIFT;
+		m1 = (tmp & MIPSPLLCTL_M1CPU_MASK) >> MIPSPLLCTL_M1CPU_SHIFT;
+		n1 += 1;
+		n2 += 2;
+		m1 += 1;
+	}
+
+	if (BCMCPU_IS_6358()) {
+		/* 16MHz * N1 * N2 / M1_CPU */
+		tmp = bcm_ddr_readl(DDR_DMIPSPLLCFG_REG);
+		n1 = (tmp & DMIPSPLLCFG_N1_MASK) >> DMIPSPLLCFG_N1_SHIFT;
+		n2 = (tmp & DMIPSPLLCFG_N2_MASK) >> DMIPSPLLCFG_N2_SHIFT;
+		m1 = (tmp & DMIPSPLLCFG_M1_MASK) >> DMIPSPLLCFG_M1_SHIFT;
+	}
+
+	return (16 * 1000000 * n1 * n2) / m1;
+}
+
+/*
+ * attempt to detect the amount of memory installed
+ */
+static unsigned int detect_memory_size(void)
+{
+	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
+	u32 val;
+
+	if (BCMCPU_IS_6348()) {
+		val = bcm_sdram_readl(SDRAM_CFG_REG);
+		rows = (val & SDRAM_CFG_ROW_MASK) >> SDRAM_CFG_ROW_SHIFT;
+		cols = (val & SDRAM_CFG_COL_MASK) >> SDRAM_CFG_COL_SHIFT;
+		is_32bits = (val & SDRAM_CFG_32B_MASK) ? 1 : 0;
+		banks = (val & SDRAM_CFG_BANK_MASK) ? 2 : 1;
+	}
+
+	if (BCMCPU_IS_6358()) {
+		val = bcm_memc_readl(MEMC_CFG_REG);
+		rows = (val & MEMC_CFG_ROW_MASK) >> MEMC_CFG_ROW_SHIFT;
+		cols = (val & MEMC_CFG_COL_MASK) >> MEMC_CFG_COL_SHIFT;
+		is_32bits = (val & MEMC_CFG_32B_MASK) ? 0 : 1;
+		banks = 2;
+	}
+
+	/* 0 => 11 address bits ... 2 => 13 address bits */
+	rows += 11;
+
+	/* 0 => 8 address bits ... 2 => 10 address bits */
+	cols += 8;
+
+	return 1 << (cols + rows + (is_32bits + 1) + banks);
+}
+
+void __init bcm63xx_cpu_init(void)
+{
+	unsigned int tmp, expected_cpu_id;
+	struct cpuinfo_mips *c = &current_cpu_data;
+
+	/* soc registers location depends on cpu type */
+	expected_cpu_id = 0;
+
+	switch (c->cputype) {
+	case CPU_BCM6348:
+		expected_cpu_id = BCM6348_CPU_ID;
+		bcm63xx_regs_base = bcm96348_regs_base;
+		bcm63xx_irqs = bcm96348_irqs;
+		break;
+	case CPU_BCM6358:
+		expected_cpu_id = BCM6358_CPU_ID;
+		bcm63xx_regs_base = bcm96358_regs_base;
+		bcm63xx_irqs = bcm96358_irqs;
+		break;
+	}
+
+	/* really early to panic, but delaying panic would not help
+	 * since we will never get any working console */
+	if (!expected_cpu_id)
+		panic("unsupported Broadcom CPU");
+
+	/*
+	 * bcm63xx_regs_base is set, we can access soc registers
+	 */
+
+	/* double check CPU type */
+	tmp = bcm_perf_readl(PERF_REV_REG);
+	bcm63xx_cpu_id = (tmp & REV_CHIPID_MASK) >> REV_CHIPID_SHIFT;
+	bcm63xx_cpu_rev = (tmp & REV_REVID_MASK) >> REV_REVID_SHIFT;
+
+	if (bcm63xx_cpu_id != expected_cpu_id)
+		panic("bcm63xx CPU id mismatch");
+
+	bcm63xx_cpu_freq = detect_cpu_clock();
+	bcm63xx_memory_size = detect_memory_size();
+
+	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
+	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
+	printk(KERN_INFO "CPU frequency is %u MHz\n",
+	       bcm63xx_cpu_freq / 1000000);
+	printk(KERN_INFO "%uMB of RAM installed\n",
+	       bcm63xx_memory_size >> 20);
+}
--- /dev/null
+++ b/arch/mips/bcm63xx/cs.c
@@ -0,0 +1,144 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/log2.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_cs.h>
+
+static DEFINE_SPINLOCK(bcm63xx_cs_lock);
+
+/*
+ * check if given chip select exists
+ */
+static int is_valid_cs(unsigned int cs)
+{
+	if (cs > 6)
+		return 0;
+	return 1;
+}
+
+/*
+ * Configure chipselect base address and size (bytes).
+ * Size must be a power of two between 8k and 256M.
+ */
+int bcm63xx_set_cs_base(unsigned int cs, u32 base, unsigned int size)
+{
+	unsigned long flags;
+	u32 val;
+
+	if (!is_valid_cs(cs))
+		return -EINVAL;
+
+	/* sanity check on size */
+	if (size != roundup_pow_of_two(size))
+		return -EINVAL;
+
+	if (size < 8 * 1024 || size > 256 * 1024 * 1024)
+		return -EINVAL;
+
+	val = (base & MPI_CSBASE_BASE_MASK);
+	/* 8k => 0 - 256M => 15 */
+	val |= (ilog2(size) - ilog2(8 * 1024)) << MPI_CSBASE_SIZE_SHIFT;
+
+	spin_lock_irqsave(&bcm63xx_cs_lock, flags);
+	bcm_mpi_writel(val, MPI_CSBASE_REG(cs));
+	spin_unlock_irqrestore(&bcm63xx_cs_lock, flags);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_set_cs_base);
+
+/*
+ * configure chipselect timing (ns)
+ */
+int bcm63xx_set_cs_timing(unsigned int cs, unsigned int wait,
+			   unsigned int setup, unsigned int hold)
+{
+	unsigned long flags;
+	u32 val;
+
+	if (!is_valid_cs(cs))
+		return -EINVAL;
+
+	spin_lock_irqsave(&bcm63xx_cs_lock, flags);
+	val = bcm_mpi_readl(MPI_CSCTL_REG(cs));
+	val &= ~(MPI_CSCTL_WAIT_MASK);
+	val &= ~(MPI_CSCTL_SETUP_MASK);
+	val &= ~(MPI_CSCTL_HOLD_MASK);
+	val |= wait << MPI_CSCTL_WAIT_SHIFT;
+	val |= setup << MPI_CSCTL_SETUP_SHIFT;
+	val |= hold << MPI_CSCTL_HOLD_SHIFT;
+	bcm_mpi_writel(val, MPI_CSCTL_REG(cs));
+	spin_unlock_irqrestore(&bcm63xx_cs_lock, flags);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_set_cs_timing);
+
+/*
+ * configure other chipselect parameter (data bus size, ...)
+ */
+int bcm63xx_set_cs_param(unsigned int cs, u32 params)
+{
+	unsigned long flags;
+	u32 val;
+
+	if (!is_valid_cs(cs))
+		return -EINVAL;
+
+	/* none of this fields apply to pcmcia */
+	if (cs == MPI_CS_PCMCIA_COMMON ||
+	    cs == MPI_CS_PCMCIA_ATTR ||
+	    cs == MPI_CS_PCMCIA_IO)
+		return -EINVAL;
+
+	spin_lock_irqsave(&bcm63xx_cs_lock, flags);
+	val = bcm_mpi_readl(MPI_CSCTL_REG(cs));
+	val &= ~(MPI_CSCTL_DATA16_MASK);
+	val &= ~(MPI_CSCTL_SYNCMODE_MASK);
+	val &= ~(MPI_CSCTL_TSIZE_MASK);
+	val &= ~(MPI_CSCTL_ENDIANSWAP_MASK);
+	val |= params;
+	bcm_mpi_writel(val, MPI_CSCTL_REG(cs));
+	spin_unlock_irqrestore(&bcm63xx_cs_lock, flags);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_set_cs_param);
+
+/*
+ * set cs status (enable/disable)
+ */
+int bcm63xx_set_cs_status(unsigned int cs, int enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	if (!is_valid_cs(cs))
+		return -EINVAL;
+
+	spin_lock_irqsave(&bcm63xx_cs_lock, flags);
+	val = bcm_mpi_readl(MPI_CSCTL_REG(cs));
+	if (enable)
+		val |= MPI_CSCTL_ENABLE_MASK;
+	else
+		val &= ~MPI_CSCTL_ENABLE_MASK;
+	bcm_mpi_writel(val, MPI_CSCTL_REG(cs));
+	spin_unlock_irqrestore(&bcm63xx_cs_lock, flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_set_cs_status);
--- /dev/null
+++ b/arch/mips/bcm63xx/early_printk.c
@@ -0,0 +1,30 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+static void __init wait_xfered(void)
+{
+	unsigned int val;
+
+	/* wait for any previous char to be transmitted */
+	do {
+		val = bcm_uart0_readl(UART_IR_REG);
+		if (val & UART_IR_STAT(UART_IR_TXEMPTY))
+			break;
+	} while (1);
+}
+
+void __init prom_putchar(char c)
+{
+	wait_xfered();
+	bcm_uart0_writel(c, UART_FIFO_REG);
+	wait_xfered();
+}
--- /dev/null
+++ b/arch/mips/bcm63xx/gpio.c
@@ -0,0 +1,128 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_gpio.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+static void bcm63xx_gpio_set(struct gpio_chip *chip,
+				unsigned gpio, int val)
+{
+	u32 reg;
+	u32 mask;
+	u32 tmp;
+	unsigned long flags;
+
+	if (gpio >= chip->ngpio)
+		BUG();
+
+	if (gpio < 32) {
+		reg = GPIO_DATA_LO_REG;
+		mask = 1 << gpio;
+	} else {
+		reg = GPIO_DATA_HI_REG;
+		mask = 1 << (gpio - 32);
+	}
+
+	local_irq_save(flags);
+	tmp = bcm_gpio_readl(reg);
+	if (val)
+		tmp |= mask;
+	else
+		tmp &= ~mask;
+	bcm_gpio_writel(tmp, reg);
+	local_irq_restore(flags);
+}
+
+static int bcm63xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
+{
+	u32 reg;
+	u32 mask;
+
+	if (gpio >= chip->ngpio)
+		BUG();
+
+	if (gpio < 32) {
+		reg = GPIO_DATA_LO_REG;
+		mask = 1 << gpio;
+	} else {
+		reg = GPIO_DATA_HI_REG;
+		mask = 1 << (gpio - 32);
+	}
+
+	return !!(bcm_gpio_readl(reg) & mask);
+}
+
+static int bcm63xx_gpio_set_direction(struct gpio_chip *chip,
+					unsigned gpio, int dir)
+{
+	u32 reg;
+	u32 mask;
+	u32 tmp;
+	unsigned long flags;
+
+	if (gpio >= chip->ngpio)
+		BUG();
+
+	if (gpio < 32) {
+		reg = GPIO_CTL_LO_REG;
+		mask = 1 << gpio;
+	} else {
+		reg = GPIO_CTL_HI_REG;
+		mask = 1 << (gpio - 32);
+	}
+
+	local_irq_save(flags);
+	tmp = bcm_gpio_readl(reg);
+	if (dir == GPIO_DIR_IN)
+		tmp &= ~mask;
+	else
+		tmp |= mask;
+	bcm_gpio_writel(tmp, reg);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int bcm63xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_IN);
+}
+
+static int bcm63xx_gpio_direction_output(struct gpio_chip *chip,
+					unsigned gpio, int value)
+{
+	bcm63xx_gpio_set(chip, gpio, value);
+	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_OUT);
+}
+
+
+static struct gpio_chip bcm63xx_gpio_chip = {
+	.label			= "bcm63xx-gpio",
+	.direction_input	= bcm63xx_gpio_direction_input,
+	.direction_output	= bcm63xx_gpio_direction_output,
+	.get			= bcm63xx_gpio_get,
+	.set			= bcm63xx_gpio_set,
+	.base			= 0,
+	.ngpio			= BCM63XX_GPIO_COUNT,
+};
+
+static int __init bcm63xx_gpio_init(void)
+{
+	printk(KERN_INFO "registering %d GPIOs\n", BCM63XX_GPIO_COUNT);
+	return gpiochip_add(&bcm63xx_gpio_chip);
+}
+arch_initcall(bcm63xx_gpio_init);
--- /dev/null
+++ b/arch/mips/bcm63xx/irq.c
@@ -0,0 +1,253 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Nicolas Schichan <nschichan@freebox.fr>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_irq.h>
+
+/*
+ * dispatch internal devices IRQ (uart, enet, watchdog, ...). do not
+ * prioritize any interrupt relatively to another. the static counter
+ * will resume the loop where it ended the last time we left this
+ * function.
+ */
+static void bcm63xx_irq_dispatch_internal(void)
+{
+	u32 pending;
+	static int i;
+
+	pending = bcm_perf_readl(PERF_IRQMASK_REG) &
+		bcm_perf_readl(PERF_IRQSTAT_REG);
+
+	if (!pending)
+		return ;
+
+	while (1) {
+		int to_call = i;
+
+		i = (i + 1) & 0x1f;
+		if (pending & (1 << to_call)) {
+			do_IRQ(to_call + IRQ_INTERNAL_BASE);
+			break;
+		}
+	}
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	u32 cause;
+
+	do {
+		cause = read_c0_cause() & read_c0_status() & ST0_IM;
+
+		if (!cause)
+			break;
+
+		if (cause & CAUSEF_IP7)
+			do_IRQ(7);
+		if (cause & CAUSEF_IP2)
+			bcm63xx_irq_dispatch_internal();
+		if (cause & CAUSEF_IP3)
+			do_IRQ(IRQ_EXT_0);
+		if (cause & CAUSEF_IP4)
+			do_IRQ(IRQ_EXT_1);
+		if (cause & CAUSEF_IP5)
+			do_IRQ(IRQ_EXT_2);
+		if (cause & CAUSEF_IP6)
+			do_IRQ(IRQ_EXT_3);
+	} while (1);
+}
+
+/*
+ * internal IRQs operations: only mask/unmask on PERF irq mask
+ * register.
+ */
+static inline void bcm63xx_internal_irq_mask(unsigned int irq)
+{
+	u32 mask;
+
+	irq -= IRQ_INTERNAL_BASE;
+	mask = bcm_perf_readl(PERF_IRQMASK_REG);
+	mask &= ~(1 << irq);
+	bcm_perf_writel(mask, PERF_IRQMASK_REG);
+}
+
+static void bcm63xx_internal_irq_unmask(unsigned int irq)
+{
+	u32 mask;
+
+	irq -= IRQ_INTERNAL_BASE;
+	mask = bcm_perf_readl(PERF_IRQMASK_REG);
+	mask |= (1 << irq);
+	bcm_perf_writel(mask, PERF_IRQMASK_REG);
+}
+
+static unsigned int bcm63xx_internal_irq_startup(unsigned int irq)
+{
+	bcm63xx_internal_irq_unmask(irq);
+	return 0;
+}
+
+/*
+ * external IRQs operations: mask/unmask and clear on PERF external
+ * irq control register.
+ */
+static void bcm63xx_external_irq_mask(unsigned int irq)
+{
+	u32 reg;
+
+	irq -= IRQ_EXT_BASE;
+	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+	reg &= ~EXTIRQ_CFG_MASK(irq);
+	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+}
+
+static void bcm63xx_external_irq_unmask(unsigned int irq)
+{
+	u32 reg;
+
+	irq -= IRQ_EXT_BASE;
+	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+	reg |= EXTIRQ_CFG_MASK(irq);
+	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+}
+
+static void bcm63xx_external_irq_clear(unsigned int irq)
+{
+	u32 reg;
+
+	irq -= IRQ_EXT_BASE;
+	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+	reg |= EXTIRQ_CFG_CLEAR(irq);
+	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+}
+
+static unsigned int bcm63xx_external_irq_startup(unsigned int irq)
+{
+	set_c0_status(0x100 << (irq - IRQ_MIPS_BASE));
+	irq_enable_hazard();
+	bcm63xx_external_irq_unmask(irq);
+	return 0;
+}
+
+static void bcm63xx_external_irq_shutdown(unsigned int irq)
+{
+	bcm63xx_external_irq_mask(irq);
+	clear_c0_status(0x100 << (irq - IRQ_MIPS_BASE));
+	irq_disable_hazard();
+}
+
+static int bcm63xx_external_irq_set_type(unsigned int irq,
+					 unsigned int flow_type)
+{
+	u32 reg;
+	struct irq_desc *desc = irq_desc + irq;
+
+	irq -= IRQ_EXT_BASE;
+
+	flow_type &= IRQ_TYPE_SENSE_MASK;
+
+	if (flow_type == IRQ_TYPE_NONE)
+		flow_type = IRQ_TYPE_LEVEL_LOW;
+
+	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_BOTH:
+		reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
+		reg |= EXTIRQ_CFG_BOTHEDGE(irq);
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
+		reg |= EXTIRQ_CFG_SENSE(irq);
+		reg &= ~EXTIRQ_CFG_BOTHEDGE(irq);
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
+		reg &= ~EXTIRQ_CFG_SENSE(irq);
+		reg &= ~EXTIRQ_CFG_BOTHEDGE(irq);
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		reg |= EXTIRQ_CFG_LEVELSENSE(irq);
+		reg |= EXTIRQ_CFG_SENSE(irq);
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		reg |= EXTIRQ_CFG_LEVELSENSE(irq);
+		reg &= ~EXTIRQ_CFG_SENSE(irq);
+		break;
+
+	default:
+		printk(KERN_ERR "bogus flow type combination given !\n");
+		return -EINVAL;
+	}
+	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+
+	if (flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))  {
+		desc->status |= IRQ_LEVEL;
+		desc->handle_irq = handle_level_irq;
+	} else {
+		desc->handle_irq = handle_edge_irq;
+	}
+
+	return 0;
+}
+
+static struct irq_chip bcm63xx_internal_irq_chip = {
+	.name		= "bcm63xx_ipic",
+	.startup	= bcm63xx_internal_irq_startup,
+	.shutdown	= bcm63xx_internal_irq_mask,
+
+	.mask		= bcm63xx_internal_irq_mask,
+	.mask_ack	= bcm63xx_internal_irq_mask,
+	.unmask		= bcm63xx_internal_irq_unmask,
+};
+
+static struct irq_chip bcm63xx_external_irq_chip = {
+	.name		= "bcm63xx_epic",
+	.startup	= bcm63xx_external_irq_startup,
+	.shutdown	= bcm63xx_external_irq_shutdown,
+
+	.ack		= bcm63xx_external_irq_clear,
+
+	.mask		= bcm63xx_external_irq_mask,
+	.unmask		= bcm63xx_external_irq_unmask,
+
+	.set_type	= bcm63xx_external_irq_set_type,
+};
+
+static struct irqaction cpu_ip2_cascade_action = {
+	.handler	= no_action,
+	.name		= "cascade_ip2",
+};
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	mips_cpu_irq_init();
+	for (i = IRQ_INTERNAL_BASE; i < NR_IRQS; ++i)
+		set_irq_chip_and_handler(i, &bcm63xx_internal_irq_chip,
+					 handle_level_irq);
+
+	for (i = IRQ_EXT_BASE; i < IRQ_EXT_BASE + 4; ++i)
+		set_irq_chip_and_handler(i, &bcm63xx_external_irq_chip,
+					 handle_edge_irq);
+
+	setup_irq(IRQ_MIPS_BASE + 2, &cpu_ip2_cascade_action);
+}
--- /dev/null
+++ b/arch/mips/bcm63xx/prom.c
@@ -0,0 +1,43 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <asm/bootinfo.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+void __init prom_init(void)
+{
+	u32 reg, mask;
+
+	bcm63xx_cpu_init();
+
+	/* stop any running watchdog */
+	bcm_wdt_writel(WDT_STOP_1, WDT_CTL_REG);
+	bcm_wdt_writel(WDT_STOP_2, WDT_CTL_REG);
+
+	/* disable all hardware blocks clock for now */
+	if (BCMCPU_IS_6348())
+		mask = CKCTL_6348_ALL_SAFE_EN;
+	else
+		/* BCMCPU_IS_6358() */
+		mask = CKCTL_6358_ALL_SAFE_EN;
+
+	reg = bcm_perf_readl(PERF_CKCTL_REG);
+	reg &= ~mask;
+	bcm_perf_writel(reg, PERF_CKCTL_REG);
+
+	/* assign command line from kernel config */
+	strcpy(arcs_cmdline, CONFIG_CMDLINE);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
--- /dev/null
+++ b/arch/mips/bcm63xx/setup.c
@@ -0,0 +1,111 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/bootmem.h>
+#include <linux/ioport.h>
+#include <linux/pm.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+#include <asm/reboot.h>
+#include <asm/cacheflush.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+
+void bcm63xx_machine_halt(void)
+{
+	printk(KERN_INFO "System halted\n");
+	while (1)
+		;
+}
+
+static void bcm6348_a1_reboot(void)
+{
+	u32 reg;
+
+	/* soft reset all blocks */
+	printk(KERN_INFO "soft-reseting all blocks ...\n");
+	reg = bcm_perf_readl(PERF_SOFTRESET_REG);
+	reg &= ~SOFTRESET_6348_ALL;
+	bcm_perf_writel(reg, PERF_SOFTRESET_REG);
+	mdelay(10);
+
+	reg = bcm_perf_readl(PERF_SOFTRESET_REG);
+	reg |= SOFTRESET_6348_ALL;
+	bcm_perf_writel(reg, PERF_SOFTRESET_REG);
+	mdelay(10);
+
+	/* Jump to the power on address. */
+	printk(KERN_INFO "jumping to reset vector.\n");
+	/* set high vectors (base at 0xbfc00000 */
+	set_c0_status(ST0_BEV | ST0_ERL);
+	/* run uncached in kseg0 */
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	__flush_cache_all();
+	/* remove all wired TLB entries */
+	write_c0_wired(0);
+	__asm__ __volatile__(
+		"jr\t%0"
+		:
+		: "r" (0xbfc00000));
+	while (1)
+		;
+}
+
+void bcm63xx_machine_reboot(void)
+{
+	u32 reg;
+
+	/* mask and clear all external irq */
+	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+	reg &= ~EXTIRQ_CFG_MASK_ALL;
+	reg |= EXTIRQ_CFG_CLEAR_ALL;
+	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+
+	if (BCMCPU_IS_6348() && (bcm63xx_get_cpu_rev() == 0xa1))
+		bcm6348_a1_reboot();
+
+	printk(KERN_INFO "triggering watchdog soft-reset...\n");
+	bcm_perf_writel(SYS_PLL_SOFT_RESET, PERF_SYS_PLL_CTL_REG);
+	while (1)
+		;
+}
+
+static void __bcm63xx_machine_reboot(char *p)
+{
+	bcm63xx_machine_reboot();
+}
+
+/*
+ * return system type in /proc/cpuinfo
+ */
+const char *get_system_type(void)
+{
+	static char buf[128];
+	sprintf(buf, "bcm963xx (0x%04x/0x%04X)",
+		bcm63xx_get_cpu_id(), bcm63xx_get_cpu_rev());
+	return buf;
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = bcm63xx_get_cpu_freq() / 2;
+}
+void __init plat_mem_setup(void)
+{
+	add_memory_region(0, bcm63xx_get_memory_size(), BOOT_MEM_RAM);
+
+	_machine_halt = bcm63xx_machine_halt;
+	_machine_restart = __bcm63xx_machine_reboot;
+	pm_power_off = bcm63xx_machine_halt;
+
+	set_io_port_base(0);
+}
--- /dev/null
+++ b/arch/mips/bcm63xx/timer.c
@@ -0,0 +1,205 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_timer.h>
+#include <bcm63xx_regs.h>
+
+static DEFINE_SPINLOCK(timer_reg_lock);
+static DEFINE_SPINLOCK(timer_data_lock);
+static struct clk *periph_clk;
+
+static struct timer_data {
+	void	(*cb)(void *);
+	void	*data;
+} timer_data[BCM63XX_TIMER_COUNT];
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id)
+{
+	u32 stat;
+	int i;
+
+	spin_lock(&timer_reg_lock);
+	stat = bcm_timer_readl(TIMER_IRQSTAT_REG);
+	bcm_timer_writel(stat, TIMER_IRQSTAT_REG);
+	spin_unlock(&timer_reg_lock);
+
+	for (i = 0; i < BCM63XX_TIMER_COUNT; i++) {
+		if (!(stat & TIMER_IRQSTAT_TIMER_CAUSE(i)))
+			continue;
+
+		spin_lock(&timer_data_lock);
+		if (!timer_data[i].cb) {
+			spin_unlock(&timer_data_lock);
+			continue;
+		}
+
+		timer_data[i].cb(timer_data[i].data);
+		spin_unlock(&timer_data_lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int bcm63xx_timer_enable(int id)
+{
+	u32 reg;
+	unsigned long flags;
+
+	if (id >= BCM63XX_TIMER_COUNT)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer_reg_lock, flags);
+
+	reg = bcm_timer_readl(TIMER_CTLx_REG(id));
+	reg |= TIMER_CTL_ENABLE_MASK;
+	bcm_timer_writel(reg, TIMER_CTLx_REG(id));
+
+	reg = bcm_timer_readl(TIMER_IRQSTAT_REG);
+	reg |= TIMER_IRQSTAT_TIMER_IR_EN(id);
+	bcm_timer_writel(reg, TIMER_IRQSTAT_REG);
+
+	spin_unlock_irqrestore(&timer_reg_lock, flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_timer_enable);
+
+int bcm63xx_timer_disable(int id)
+{
+	u32 reg;
+	unsigned long flags;
+
+	if (id >= BCM63XX_TIMER_COUNT)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer_reg_lock, flags);
+
+	reg = bcm_timer_readl(TIMER_CTLx_REG(id));
+	reg &= ~TIMER_CTL_ENABLE_MASK;
+	bcm_timer_writel(reg, TIMER_CTLx_REG(id));
+
+	reg = bcm_timer_readl(TIMER_IRQSTAT_REG);
+	reg &= ~TIMER_IRQSTAT_TIMER_IR_EN(id);
+	bcm_timer_writel(reg, TIMER_IRQSTAT_REG);
+
+	spin_unlock_irqrestore(&timer_reg_lock, flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_timer_disable);
+
+int bcm63xx_timer_register(int id, void (*callback)(void *data), void *data)
+{
+	unsigned long flags;
+	int ret;
+
+	if (id >= BCM63XX_TIMER_COUNT || !callback)
+		return -EINVAL;
+
+	ret = 0;
+	spin_lock_irqsave(&timer_data_lock, flags);
+	if (timer_data[id].cb) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	timer_data[id].cb = callback;
+	timer_data[id].data = data;
+
+out:
+	spin_unlock_irqrestore(&timer_data_lock, flags);
+	return ret;
+}
+
+EXPORT_SYMBOL(bcm63xx_timer_register);
+
+void bcm63xx_timer_unregister(int id)
+{
+	unsigned long flags;
+
+	if (id >= BCM63XX_TIMER_COUNT)
+		return;
+
+	spin_lock_irqsave(&timer_data_lock, flags);
+	timer_data[id].cb = NULL;
+	spin_unlock_irqrestore(&timer_data_lock, flags);
+}
+
+EXPORT_SYMBOL(bcm63xx_timer_unregister);
+
+unsigned int bcm63xx_timer_countdown(unsigned int countdown_us)
+{
+	return (clk_get_rate(periph_clk) / (1000 * 1000)) * countdown_us;
+}
+
+EXPORT_SYMBOL(bcm63xx_timer_countdown);
+
+int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us)
+{
+	u32 reg, countdown;
+	unsigned long flags;
+
+	if (id >= BCM63XX_TIMER_COUNT)
+		return -EINVAL;
+
+	countdown = bcm63xx_timer_countdown(countdown_us);
+	if (countdown & ~TIMER_CTL_COUNTDOWN_MASK)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer_reg_lock, flags);
+	reg = bcm_timer_readl(TIMER_CTLx_REG(id));
+
+	if (monotonic)
+		reg &= ~TIMER_CTL_MONOTONIC_MASK;
+	else
+		reg |= TIMER_CTL_MONOTONIC_MASK;
+
+	reg &= ~TIMER_CTL_COUNTDOWN_MASK;
+	reg |= countdown;
+	bcm_timer_writel(reg, TIMER_CTLx_REG(id));
+
+	spin_unlock_irqrestore(&timer_reg_lock, flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(bcm63xx_timer_set);
+
+int bcm63xx_timer_init(void)
+{
+	int ret, irq;
+	u32 reg;
+
+	reg = bcm_timer_readl(TIMER_IRQSTAT_REG);
+	reg &= ~TIMER_IRQSTAT_TIMER0_IR_EN;
+	reg &= ~TIMER_IRQSTAT_TIMER1_IR_EN;
+	reg &= ~TIMER_IRQSTAT_TIMER2_IR_EN;
+	bcm_timer_writel(reg, TIMER_IRQSTAT_REG);
+
+	periph_clk = clk_get(NULL, "periph");
+	if (IS_ERR(periph_clk))
+		return -ENODEV;
+
+	irq = bcm63xx_get_irq_number(IRQ_TIMER);
+	ret = request_irq(irq, timer_interrupt, 0, "bcm63xx_timer", NULL);
+	if (ret) {
+		printk(KERN_ERR "bcm63xx_timer: failed to register irq\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+arch_initcall(bcm63xx_timer_init);
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -67,11 +67,15 @@ enum fixed_addresses {
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
+#ifdef CONFIG_BCM63XX
+#define FIXADDR_TOP     ((unsigned long)(long)(int)0xff000000)
+#else
 #if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
 #define FIXADDR_TOP	((unsigned long)(long)(int)(0xff000000 - 0x20000))
 #else
 #define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
 #endif
+#endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h
@@ -0,0 +1,11 @@
+#ifndef BCM63XX_CLK_H_
+#define BCM63XX_CLK_H_
+
+struct clk {
+	void		(*set)(struct clk *, int);
+	unsigned int	rate;
+	unsigned int	usage;
+	int		id;
+};
+
+#endif /* ! BCM63XX_CLK_H_ */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -0,0 +1,314 @@
+#ifndef BCM63XX_CPU_H_
+#define BCM63XX_CPU_H_
+
+#include <linux/types.h>
+#include <linux/init.h>
+
+/*
+ * Macro to fetch bcm63xx cpu id and revision, should be optimized at
+ * compile time if only one CPU support is enabled (idea stolen from
+ * arm mach-types)
+ */
+#define BCM6348_CPU_ID		0x6348
+#define BCM6358_CPU_ID		0x6358
+
+void __init bcm63xx_cpu_init(void);
+u16 __bcm63xx_get_cpu_id(void);
+u16 bcm63xx_get_cpu_rev(void);
+unsigned int bcm63xx_get_cpu_freq(void);
+
+#ifdef CONFIG_BCM63XX_CPU_6348
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6348_CPU_ID
+# endif
+# define BCMCPU_IS_6348()	(bcm63xx_get_cpu_id() == BCM6348_CPU_ID)
+#else
+# define BCMCPU_IS_6348()	(0)
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6358
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6358_CPU_ID
+# endif
+# define BCMCPU_IS_6358()	(bcm63xx_get_cpu_id() == BCM6358_CPU_ID)
+#else
+# define BCMCPU_IS_6358()	(0)
+#endif
+
+#ifndef bcm63xx_get_cpu_id
+#error "No CPU support configured"
+#endif
+
+/*
+ * While registers sets are (mostly) the same across 63xx CPU, base
+ * address of these sets do change.
+ */
+enum bcm63xx_regs_set {
+	RSET_DSL_LMEM = 0,
+	RSET_PERF,
+	RSET_TIMER,
+	RSET_WDT,
+	RSET_UART0,
+	RSET_GPIO,
+	RSET_SPI,
+	RSET_UDC0,
+	RSET_OHCI0,
+	RSET_OHCI_PRIV,
+	RSET_USBH_PRIV,
+	RSET_MPI,
+	RSET_PCMCIA,
+	RSET_DSL,
+	RSET_ENET0,
+	RSET_ENET1,
+	RSET_ENETDMA,
+	RSET_EHCI0,
+	RSET_SDRAM,
+	RSET_MEMC,
+	RSET_DDR,
+};
+
+#define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
+#define RSET_DSL_SIZE			4096
+#define RSET_WDT_SIZE			12
+#define RSET_ENET_SIZE			2048
+#define RSET_ENETDMA_SIZE		2048
+#define RSET_UART_SIZE			24
+#define RSET_UDC_SIZE			256
+#define RSET_OHCI_SIZE			256
+#define RSET_EHCI_SIZE			256
+#define RSET_PCMCIA_SIZE		12
+
+/*
+ * 6348 register sets base address
+ */
+#define BCM_6348_DSL_LMEM_BASE		(0xfff00000)
+#define BCM_6348_PERF_BASE		(0xfffe0000)
+#define BCM_6348_TIMER_BASE		(0xfffe0200)
+#define BCM_6348_WDT_BASE		(0xfffe021c)
+#define BCM_6348_UART0_BASE		(0xfffe0300)
+#define BCM_6348_GPIO_BASE		(0xfffe0400)
+#define BCM_6348_SPI_BASE		(0xfffe0c00)
+#define BCM_6348_UDC0_BASE		(0xfffe1000)
+#define BCM_6348_OHCI0_BASE		(0xfffe1b00)
+#define BCM_6348_OHCI_PRIV_BASE		(0xfffe1c00)
+#define BCM_6348_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6348_MPI_BASE		(0xfffe2000)
+#define BCM_6348_PCMCIA_BASE		(0xfffe2054)
+#define BCM_6348_SDRAM_REGS_BASE	(0xfffe2300)
+#define BCM_6348_DSL_BASE		(0xfffe3000)
+#define BCM_6348_ENET0_BASE		(0xfffe6000)
+#define BCM_6348_ENET1_BASE		(0xfffe6800)
+#define BCM_6348_ENETDMA_BASE		(0xfffe7000)
+#define BCM_6348_EHCI0_BASE		(0xdeadbeef)
+#define BCM_6348_SDRAM_BASE		(0xfffe2300)
+#define BCM_6348_MEMC_BASE		(0xdeadbeef)
+#define BCM_6348_DDR_BASE		(0xdeadbeef)
+
+/*
+ * 6358 register sets base address
+ */
+#define BCM_6358_DSL_LMEM_BASE		(0xfff00000)
+#define BCM_6358_PERF_BASE		(0xfffe0000)
+#define BCM_6358_TIMER_BASE		(0xfffe0040)
+#define BCM_6358_WDT_BASE		(0xfffe005c)
+#define BCM_6358_UART0_BASE		(0xfffe0100)
+#define BCM_6358_GPIO_BASE		(0xfffe0080)
+#define BCM_6358_SPI_BASE		(0xdeadbeef)
+#define BCM_6358_UDC0_BASE		(0xfffe0800)
+#define BCM_6358_OHCI0_BASE		(0xfffe1400)
+#define BCM_6358_OHCI_PRIV_BASE		(0xdeadbeef)
+#define BCM_6358_USBH_PRIV_BASE		(0xfffe1500)
+#define BCM_6358_MPI_BASE		(0xfffe1000)
+#define BCM_6358_PCMCIA_BASE		(0xfffe1054)
+#define BCM_6358_SDRAM_REGS_BASE	(0xfffe2300)
+#define BCM_6358_DSL_BASE		(0xfffe3000)
+#define BCM_6358_ENET0_BASE		(0xfffe4000)
+#define BCM_6358_ENET1_BASE		(0xfffe4800)
+#define BCM_6358_ENETDMA_BASE		(0xfffe5000)
+#define BCM_6358_EHCI0_BASE		(0xfffe1300)
+#define BCM_6358_SDRAM_BASE		(0xdeadbeef)
+#define BCM_6358_MEMC_BASE		(0xfffe1200)
+#define BCM_6358_DDR_BASE		(0xfffe12a0)
+
+
+extern const unsigned long *bcm63xx_regs_base;
+
+static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
+{
+#ifdef BCMCPU_RUNTIME_DETECT
+	return bcm63xx_regs_base[set];
+#else
+#ifdef CONFIG_BCM63XX_CPU_6348
+	switch (set) {
+	case RSET_DSL_LMEM:
+		return BCM_6348_DSL_LMEM_BASE;
+	case RSET_PERF:
+		return BCM_6348_PERF_BASE;
+	case RSET_TIMER:
+		return BCM_6348_TIMER_BASE;
+	case RSET_WDT:
+		return BCM_6348_WDT_BASE;
+	case RSET_UART0:
+		return BCM_6348_UART0_BASE;
+	case RSET_GPIO:
+		return BCM_6348_GPIO_BASE;
+	case RSET_SPI:
+		return BCM_6348_SPI_BASE;
+	case RSET_UDC0:
+		return BCM_6348_UDC0_BASE;
+	case RSET_OHCI0:
+		return BCM_6348_OHCI0_BASE;
+	case RSET_OHCI_PRIV:
+		return BCM_6348_OHCI_PRIV_BASE;
+	case RSET_USBH_PRIV:
+		return BCM_6348_USBH_PRIV_BASE;
+	case RSET_MPI:
+		return BCM_6348_MPI_BASE;
+	case RSET_PCMCIA:
+		return BCM_6348_PCMCIA_BASE;
+	case RSET_DSL:
+		return BCM_6348_DSL_BASE;
+	case RSET_ENET0:
+		return BCM_6348_ENET0_BASE;
+	case RSET_ENET1:
+		return BCM_6348_ENET1_BASE;
+	case RSET_ENETDMA:
+		return BCM_6348_ENETDMA_BASE;
+	case RSET_EHCI0:
+		return BCM_6348_EHCI0_BASE;
+	case RSET_SDRAM:
+		return BCM_6348_SDRAM_BASE;
+	case RSET_MEMC:
+		return BCM_6348_MEMC_BASE;
+	case RSET_DDR:
+		return BCM_6348_DDR_BASE;
+	}
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6358
+	switch (set) {
+	case RSET_DSL_LMEM:
+		return BCM_6358_DSL_LMEM_BASE;
+	case RSET_PERF:
+		return BCM_6358_PERF_BASE;
+	case RSET_TIMER:
+		return BCM_6358_TIMER_BASE;
+	case RSET_WDT:
+		return BCM_6358_WDT_BASE;
+	case RSET_UART0:
+		return BCM_6358_UART0_BASE;
+	case RSET_GPIO:
+		return BCM_6358_GPIO_BASE;
+	case RSET_SPI:
+		return BCM_6358_SPI_BASE;
+	case RSET_UDC0:
+		return BCM_6358_UDC0_BASE;
+	case RSET_OHCI0:
+		return BCM_6358_OHCI0_BASE;
+	case RSET_OHCI_PRIV:
+		return BCM_6358_OHCI_PRIV_BASE;
+	case RSET_USBH_PRIV:
+		return BCM_6358_USBH_PRIV_BASE;
+	case RSET_MPI:
+		return BCM_6358_MPI_BASE;
+	case RSET_PCMCIA:
+		return BCM_6358_PCMCIA_BASE;
+	case RSET_ENET0:
+		return BCM_6358_ENET0_BASE;
+	case RSET_ENET1:
+		return BCM_6358_ENET1_BASE;
+	case RSET_ENETDMA:
+		return BCM_6358_ENETDMA_BASE;
+	case RSET_DSL:
+		return BCM_6358_DSL_BASE;
+	case RSET_EHCI0:
+		return BCM_6358_EHCI0_BASE;
+	case RSET_SDRAM:
+		return BCM_6358_SDRAM_BASE;
+	case RSET_MEMC:
+		return BCM_6358_MEMC_BASE;
+	case RSET_DDR:
+		return BCM_6358_DDR_BASE;
+	}
+#endif
+#endif
+	/* unreached */
+	return 0;
+}
+
+/*
+ * IRQ number changes across CPU too
+ */
+enum bcm63xx_irq {
+	IRQ_TIMER = 0,
+	IRQ_UART0,
+	IRQ_DSL,
+	IRQ_ENET0,
+	IRQ_ENET1,
+	IRQ_ENET_PHY,
+	IRQ_OHCI0,
+	IRQ_EHCI0,
+	IRQ_PCMCIA0,
+	IRQ_ENET0_RXDMA,
+	IRQ_ENET0_TXDMA,
+	IRQ_ENET1_RXDMA,
+	IRQ_ENET1_TXDMA,
+	IRQ_PCI,
+	IRQ_PCMCIA,
+};
+
+/*
+ * 6348 irqs
+ */
+#define BCM_6348_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6348_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6348_DSL_IRQ		(IRQ_INTERNAL_BASE + 4)
+#define BCM_6348_ENET1_IRQ		(IRQ_INTERNAL_BASE + 7)
+#define BCM_6348_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6348_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6348_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6348_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 20)
+#define BCM_6348_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 21)
+#define BCM_6348_ENET1_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 22)
+#define BCM_6348_ENET1_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 23)
+#define BCM_6348_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6348_PCI_IRQ		(IRQ_INTERNAL_BASE + 24)
+
+/*
+ * 6358 irqs
+ */
+#define BCM_6358_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6358_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6358_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
+#define BCM_6358_ENET1_IRQ		(IRQ_INTERNAL_BASE + 6)
+#define BCM_6358_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6358_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6358_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
+#define BCM_6358_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
+#define BCM_6358_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
+#define BCM_6358_ENET1_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 17)
+#define BCM_6358_ENET1_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 18)
+#define BCM_6358_DSL_IRQ		(IRQ_INTERNAL_BASE + 29)
+#define BCM_6358_PCI_IRQ		(IRQ_INTERNAL_BASE + 31)
+#define BCM_6358_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
+
+extern const int *bcm63xx_irqs;
+
+static inline int bcm63xx_get_irq_number(enum bcm63xx_irq irq)
+{
+	return bcm63xx_irqs[irq];
+}
+
+/*
+ * return installed memory size
+ */
+unsigned int bcm63xx_get_memory_size(void);
+
+#endif /* !BCM63XX_CPU_H_ */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cs.h
@@ -0,0 +1,10 @@
+#ifndef BCM63XX_CS_H
+#define BCM63XX_CS_H
+
+int bcm63xx_set_cs_base(unsigned int cs, u32 base, unsigned int size);
+int bcm63xx_set_cs_timing(unsigned int cs, unsigned int wait,
+			   unsigned int setup, unsigned int hold);
+int bcm63xx_set_cs_param(unsigned int cs, u32 flags);
+int bcm63xx_set_cs_status(unsigned int cs, int enable);
+
+#endif /* !BCM63XX_CS_H */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -0,0 +1,10 @@
+#ifndef BCM63XX_GPIO_H
+#define BCM63XX_GPIO_H
+
+/* all helpers will BUG() if gpio count is >= 37. */
+#define BCM63XX_GPIO_COUNT	37
+
+#define GPIO_DIR_OUT	0x0
+#define GPIO_DIR_IN	0x1
+
+#endif /* !BCM63XX_GPIO_H */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
@@ -0,0 +1,93 @@
+#ifndef BCM63XX_IO_H_
+#define BCM63XX_IO_H_
+
+#include "bcm63xx_cpu.h"
+
+/*
+ * Physical memory map, RAM is mapped at 0x0.
+ *
+ * Note that size MUST be a power of two.
+ */
+#define BCM_PCMCIA_COMMON_BASE_PA	(0x20000000)
+#define BCM_PCMCIA_COMMON_SIZE		(16 * 1024 * 1024)
+#define BCM_PCMCIA_COMMON_END_PA	(BCM_PCMCIA_COMMON_BASE_PA +	\
+					 BCM_PCMCIA_COMMON_SIZE - 1)
+
+#define BCM_PCMCIA_ATTR_BASE_PA		(0x21000000)
+#define BCM_PCMCIA_ATTR_SIZE		(16 * 1024 * 1024)
+#define BCM_PCMCIA_ATTR_END_PA		(BCM_PCMCIA_ATTR_BASE_PA +	\
+					 BCM_PCMCIA_ATTR_SIZE - 1)
+
+#define BCM_PCMCIA_IO_BASE_PA		(0x22000000)
+#define BCM_PCMCIA_IO_SIZE		(64 * 1024)
+#define BCM_PCMCIA_IO_END_PA		(BCM_PCMCIA_IO_BASE_PA +	\
+					BCM_PCMCIA_IO_SIZE - 1)
+
+#define BCM_PCI_MEM_BASE_PA		(0x30000000)
+#define BCM_PCI_MEM_SIZE		(128 * 1024 * 1024)
+#define BCM_PCI_MEM_END_PA		(BCM_PCI_MEM_BASE_PA +		\
+					BCM_PCI_MEM_SIZE - 1)
+
+#define BCM_PCI_IO_BASE_PA		(0x08000000)
+#define BCM_PCI_IO_SIZE			(64 * 1024)
+#define BCM_PCI_IO_END_PA		(BCM_PCI_IO_BASE_PA +		\
+					BCM_PCI_IO_SIZE - 1)
+#define BCM_PCI_IO_HALF_PA		(BCM_PCI_IO_BASE_PA +		\
+					(BCM_PCI_IO_SIZE / 2) - 1)
+
+#define BCM_CB_MEM_BASE_PA		(0x38000000)
+#define BCM_CB_MEM_SIZE			(128 * 1024 * 1024)
+#define BCM_CB_MEM_END_PA		(BCM_CB_MEM_BASE_PA +		\
+					BCM_CB_MEM_SIZE - 1)
+
+
+/*
+ * Internal registers are accessed through KSEG3
+ */
+#define BCM_REGS_VA(x)	((void __iomem *)(x))
+
+#define bcm_readb(a)	(*(volatile unsigned char *)	BCM_REGS_VA(a))
+#define bcm_readw(a)	(*(volatile unsigned short *)	BCM_REGS_VA(a))
+#define bcm_readl(a)	(*(volatile unsigned int *)	BCM_REGS_VA(a))
+#define bcm_writeb(v, a) (*(volatile unsigned char *) BCM_REGS_VA((a)) = (v))
+#define bcm_writew(v, a) (*(volatile unsigned short *) BCM_REGS_VA((a)) = (v))
+#define bcm_writel(v, a) (*(volatile unsigned int *) BCM_REGS_VA((a)) = (v))
+
+/*
+ * IO helpers to access register set for current CPU
+ */
+#define bcm_rset_readb(s, o)	bcm_readb(bcm63xx_regset_address(s) + (o))
+#define bcm_rset_readw(s, o)	bcm_readw(bcm63xx_regset_address(s) + (o))
+#define bcm_rset_readl(s, o)	bcm_readl(bcm63xx_regset_address(s) + (o))
+#define bcm_rset_writeb(s, v, o)	bcm_writeb((v), \
+					bcm63xx_regset_address(s) + (o))
+#define bcm_rset_writew(s, v, o)	bcm_writew((v), \
+					bcm63xx_regset_address(s) + (o))
+#define bcm_rset_writel(s, v, o)	bcm_writel((v), \
+					bcm63xx_regset_address(s) + (o))
+
+/*
+ * helpers for frequently used register sets
+ */
+#define bcm_perf_readl(o)	bcm_rset_readl(RSET_PERF, (o))
+#define bcm_perf_writel(v, o)	bcm_rset_writel(RSET_PERF, (v), (o))
+#define bcm_timer_readl(o)	bcm_rset_readl(RSET_TIMER, (o))
+#define bcm_timer_writel(v, o)	bcm_rset_writel(RSET_TIMER, (v), (o))
+#define bcm_wdt_readl(o)	bcm_rset_readl(RSET_WDT, (o))
+#define bcm_wdt_writel(v, o)	bcm_rset_writel(RSET_WDT, (v), (o))
+#define bcm_gpio_readl(o)	bcm_rset_readl(RSET_GPIO, (o))
+#define bcm_gpio_writel(v, o)	bcm_rset_writel(RSET_GPIO, (v), (o))
+#define bcm_uart0_readl(o)	bcm_rset_readl(RSET_UART0, (o))
+#define bcm_uart0_writel(v, o)	bcm_rset_writel(RSET_UART0, (v), (o))
+#define bcm_mpi_readl(o)	bcm_rset_readl(RSET_MPI, (o))
+#define bcm_mpi_writel(v, o)	bcm_rset_writel(RSET_MPI, (v), (o))
+#define bcm_pcmcia_readl(o)	bcm_rset_readl(RSET_PCMCIA, (o))
+#define bcm_pcmcia_writel(v, o)	bcm_rset_writel(RSET_PCMCIA, (v), (o))
+#define bcm_sdram_readl(o)	bcm_rset_readl(RSET_SDRAM, (o))
+#define bcm_sdram_writel(v, o)	bcm_rset_writel(RSET_SDRAM, (v), (o))
+#define bcm_memc_readl(o)	bcm_rset_readl(RSET_MEMC, (o))
+#define bcm_memc_writel(v, o)	bcm_rset_writel(RSET_MEMC, (v), (o))
+#define bcm_ddr_readl(o)	bcm_rset_readl(RSET_DDR, (o))
+#define bcm_ddr_writel(v, o)	bcm_rset_writel(RSET_DDR, (v), (o))
+
+#endif /* ! BCM63XX_IO_H_ */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h
@@ -0,0 +1,15 @@
+#ifndef BCM63XX_IRQ_H_
+#define BCM63XX_IRQ_H_
+
+#include <bcm63xx_cpu.h>
+
+#define IRQ_MIPS_BASE			0
+#define IRQ_INTERNAL_BASE		8
+
+#define IRQ_EXT_BASE			(IRQ_MIPS_BASE + 3)
+#define IRQ_EXT_0			(IRQ_EXT_BASE + 0)
+#define IRQ_EXT_1			(IRQ_EXT_BASE + 1)
+#define IRQ_EXT_2			(IRQ_EXT_BASE + 2)
+#define IRQ_EXT_3			(IRQ_EXT_BASE + 3)
+
+#endif /* ! BCM63XX_IRQ_H_ */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -0,0 +1,728 @@
+#ifndef BCM63XX_REGS_H_
+#define BCM63XX_REGS_H_
+
+/*************************************************************************
+ * _REG relative to RSET_PERF
+ *************************************************************************/
+
+/* Chip Identifier / Revision register */
+#define PERF_REV_REG			0x0
+#define REV_CHIPID_SHIFT		16
+#define REV_CHIPID_MASK			(0xffff << REV_CHIPID_SHIFT)
+#define REV_REVID_SHIFT			0
+#define REV_REVID_MASK			(0xffff << REV_REVID_SHIFT)
+
+/* Clock Control register */
+#define PERF_CKCTL_REG			0x4
+
+#define CKCTL_6348_ADSLPHY_EN		(1 << 0)
+#define CKCTL_6348_MPI_EN		(1 << 1)
+#define CKCTL_6348_SDRAM_EN		(1 << 2)
+#define CKCTL_6348_M2M_EN		(1 << 3)
+#define CKCTL_6348_ENET_EN		(1 << 4)
+#define CKCTL_6348_SAR_EN		(1 << 5)
+#define CKCTL_6348_USBS_EN		(1 << 6)
+#define CKCTL_6348_USBH_EN		(1 << 8)
+#define CKCTL_6348_SPI_EN		(1 << 9)
+
+#define CKCTL_6348_ALL_SAFE_EN		(CKCTL_6348_ADSLPHY_EN |	\
+					CKCTL_6348_M2M_EN |		\
+					CKCTL_6348_ENET_EN |		\
+					CKCTL_6348_SAR_EN |		\
+					CKCTL_6348_USBS_EN |		\
+					CKCTL_6348_USBH_EN |		\
+					CKCTL_6348_SPI_EN)
+
+#define CKCTL_6358_ENET_EN		(1 << 4)
+#define CKCTL_6358_ADSLPHY_EN		(1 << 5)
+#define CKCTL_6358_PCM_EN		(1 << 8)
+#define CKCTL_6358_SPI_EN		(1 << 9)
+#define CKCTL_6358_USBS_EN		(1 << 10)
+#define CKCTL_6358_SAR_EN		(1 << 11)
+#define CKCTL_6358_EMUSB_EN		(1 << 17)
+#define CKCTL_6358_ENET0_EN		(1 << 18)
+#define CKCTL_6358_ENET1_EN		(1 << 19)
+#define CKCTL_6358_USBSU_EN		(1 << 20)
+#define CKCTL_6358_EPHY_EN		(1 << 21)
+
+#define CKCTL_6358_ALL_SAFE_EN		(CKCTL_6358_ENET_EN |		\
+					CKCTL_6358_ADSLPHY_EN |		\
+					CKCTL_6358_PCM_EN |		\
+					CKCTL_6358_SPI_EN |		\
+					CKCTL_6358_USBS_EN |		\
+					CKCTL_6358_SAR_EN |		\
+					CKCTL_6358_EMUSB_EN |		\
+					CKCTL_6358_ENET0_EN |		\
+					CKCTL_6358_ENET1_EN |		\
+					CKCTL_6358_USBSU_EN |		\
+					CKCTL_6358_EPHY_EN)
+
+/* System PLL Control register  */
+#define PERF_SYS_PLL_CTL_REG		0x8
+#define SYS_PLL_SOFT_RESET		0x1
+
+/* Interrupt Mask register */
+#define PERF_IRQMASK_REG		0xc
+#define PERF_IRQSTAT_REG		0x10
+
+/* Interrupt Status register */
+#define PERF_IRQSTAT_REG		0x10
+
+/* External Interrupt Configuration register */
+#define PERF_EXTIRQ_CFG_REG		0x14
+#define EXTIRQ_CFG_SENSE(x)		(1 << (x))
+#define EXTIRQ_CFG_STAT(x)		(1 << (x + 5))
+#define EXTIRQ_CFG_CLEAR(x)		(1 << (x + 10))
+#define EXTIRQ_CFG_MASK(x)		(1 << (x + 15))
+#define EXTIRQ_CFG_BOTHEDGE(x)		(1 << (x + 20))
+#define EXTIRQ_CFG_LEVELSENSE(x)	(1 << (x + 25))
+
+#define EXTIRQ_CFG_CLEAR_ALL		(0xf << 10)
+#define EXTIRQ_CFG_MASK_ALL		(0xf << 15)
+
+/* Soft Reset register */
+#define PERF_SOFTRESET_REG		0x28
+
+#define SOFTRESET_6348_SPI_MASK		(1 << 0)
+#define SOFTRESET_6348_ENET_MASK	(1 << 2)
+#define SOFTRESET_6348_USBH_MASK	(1 << 3)
+#define SOFTRESET_6348_USBS_MASK	(1 << 4)
+#define SOFTRESET_6348_ADSL_MASK	(1 << 5)
+#define SOFTRESET_6348_DMAMEM_MASK	(1 << 6)
+#define SOFTRESET_6348_SAR_MASK		(1 << 7)
+#define SOFTRESET_6348_ACLC_MASK	(1 << 8)
+#define SOFTRESET_6348_ADSLMIPSPLL_MASK	(1 << 10)
+
+#define SOFTRESET_6348_ALL	 (SOFTRESET_6348_SPI_MASK |		\
+				  SOFTRESET_6348_ENET_MASK |		\
+				  SOFTRESET_6348_USBH_MASK |		\
+				  SOFTRESET_6348_USBS_MASK |		\
+				  SOFTRESET_6348_ADSL_MASK |		\
+				  SOFTRESET_6348_DMAMEM_MASK |		\
+				  SOFTRESET_6348_SAR_MASK |		\
+				  SOFTRESET_6348_ACLC_MASK |		\
+				  SOFTRESET_6348_ADSLMIPSPLL_MASK)
+
+/* MIPS PLL control register */
+#define PERF_MIPSPLLCTL_REG		0x34
+#define MIPSPLLCTL_N1_SHIFT		20
+#define MIPSPLLCTL_N1_MASK		(0x7 << MIPSPLLCTL_N1_SHIFT)
+#define MIPSPLLCTL_N2_SHIFT		15
+#define MIPSPLLCTL_N2_MASK		(0x1f << MIPSPLLCTL_N2_SHIFT)
+#define MIPSPLLCTL_M1REF_SHIFT		12
+#define MIPSPLLCTL_M1REF_MASK		(0x7 << MIPSPLLCTL_M1REF_SHIFT)
+#define MIPSPLLCTL_M2REF_SHIFT		9
+#define MIPSPLLCTL_M2REF_MASK		(0x7 << MIPSPLLCTL_M2REF_SHIFT)
+#define MIPSPLLCTL_M1CPU_SHIFT		6
+#define MIPSPLLCTL_M1CPU_MASK		(0x7 << MIPSPLLCTL_M1CPU_SHIFT)
+#define MIPSPLLCTL_M1BUS_SHIFT		3
+#define MIPSPLLCTL_M1BUS_MASK		(0x7 << MIPSPLLCTL_M1BUS_SHIFT)
+#define MIPSPLLCTL_M2BUS_SHIFT		0
+#define MIPSPLLCTL_M2BUS_MASK		(0x7 << MIPSPLLCTL_M2BUS_SHIFT)
+
+/* ADSL PHY PLL Control register */
+#define PERF_ADSLPLLCTL_REG		0x38
+#define ADSLPLLCTL_N1_SHIFT		20
+#define ADSLPLLCTL_N1_MASK		(0x7 << ADSLPLLCTL_N1_SHIFT)
+#define ADSLPLLCTL_N2_SHIFT		15
+#define ADSLPLLCTL_N2_MASK		(0x1f << ADSLPLLCTL_N2_SHIFT)
+#define ADSLPLLCTL_M1REF_SHIFT		12
+#define ADSLPLLCTL_M1REF_MASK		(0x7 << ADSLPLLCTL_M1REF_SHIFT)
+#define ADSLPLLCTL_M2REF_SHIFT		9
+#define ADSLPLLCTL_M2REF_MASK		(0x7 << ADSLPLLCTL_M2REF_SHIFT)
+#define ADSLPLLCTL_M1CPU_SHIFT		6
+#define ADSLPLLCTL_M1CPU_MASK		(0x7 << ADSLPLLCTL_M1CPU_SHIFT)
+#define ADSLPLLCTL_M1BUS_SHIFT		3
+#define ADSLPLLCTL_M1BUS_MASK		(0x7 << ADSLPLLCTL_M1BUS_SHIFT)
+#define ADSLPLLCTL_M2BUS_SHIFT		0
+#define ADSLPLLCTL_M2BUS_MASK		(0x7 << ADSLPLLCTL_M2BUS_SHIFT)
+
+#define ADSLPLLCTL_VAL(n1, n2, m1ref, m2ref, m1cpu, m1bus, m2bus)	\
+				(((n1) << ADSLPLLCTL_N1_SHIFT) |	\
+				((n2) << ADSLPLLCTL_N2_SHIFT) |		\
+				((m1ref) << ADSLPLLCTL_M1REF_SHIFT) |	\
+				((m2ref) << ADSLPLLCTL_M2REF_SHIFT) |	\
+				((m1cpu) << ADSLPLLCTL_M1CPU_SHIFT) |	\
+				((m1bus) << ADSLPLLCTL_M1BUS_SHIFT) |	\
+				((m2bus) << ADSLPLLCTL_M2BUS_SHIFT))
+
+
+/*************************************************************************
+ * _REG relative to RSET_TIMER
+ *************************************************************************/
+
+#define BCM63XX_TIMER_COUNT		4
+#define TIMER_T0_ID			0
+#define TIMER_T1_ID			1
+#define TIMER_T2_ID			2
+#define TIMER_WDT_ID			3
+
+/* Timer irqstat register */
+#define TIMER_IRQSTAT_REG		0
+#define TIMER_IRQSTAT_TIMER_CAUSE(x)	(1 << (x))
+#define TIMER_IRQSTAT_TIMER0_CAUSE	(1 << 0)
+#define TIMER_IRQSTAT_TIMER1_CAUSE	(1 << 1)
+#define TIMER_IRQSTAT_TIMER2_CAUSE	(1 << 2)
+#define TIMER_IRQSTAT_WDT_CAUSE		(1 << 3)
+#define TIMER_IRQSTAT_TIMER_IR_EN(x)	(1 << ((x) + 8))
+#define TIMER_IRQSTAT_TIMER0_IR_EN	(1 << 8)
+#define TIMER_IRQSTAT_TIMER1_IR_EN	(1 << 9)
+#define TIMER_IRQSTAT_TIMER2_IR_EN	(1 << 10)
+
+/* Timer control register */
+#define TIMER_CTLx_REG(x)		(0x4 + (x * 4))
+#define TIMER_CTL0_REG			0x4
+#define TIMER_CTL1_REG			0x8
+#define TIMER_CTL2_REG			0xC
+#define TIMER_CTL_COUNTDOWN_MASK	(0x3fffffff)
+#define TIMER_CTL_MONOTONIC_MASK	(1 << 30)
+#define TIMER_CTL_ENABLE_MASK		(1 << 31)
+
+
+/*************************************************************************
+ * _REG relative to RSET_WDT
+ *************************************************************************/
+
+/* Watchdog default count register */
+#define WDT_DEFVAL_REG			0x0
+
+/* Watchdog control register */
+#define WDT_CTL_REG			0x4
+
+/* Watchdog control register constants */
+#define WDT_START_1			(0xff00)
+#define WDT_START_2			(0x00ff)
+#define WDT_STOP_1			(0xee00)
+#define WDT_STOP_2			(0x00ee)
+
+/* Watchdog reset length register */
+#define WDT_RSTLEN_REG			0x8
+
+
+/*************************************************************************
+ * _REG relative to RSET_UARTx
+ *************************************************************************/
+
+/* UART Control Register */
+#define UART_CTL_REG			0x0
+#define UART_CTL_RXTMOUTCNT_SHIFT	0
+#define UART_CTL_RXTMOUTCNT_MASK	(0x1f << UART_CTL_RXTMOUTCNT_SHIFT)
+#define UART_CTL_RSTTXDN_SHIFT		5
+#define UART_CTL_RSTTXDN_MASK		(1 << UART_CTL_RSTTXDN_SHIFT)
+#define UART_CTL_RSTRXFIFO_SHIFT		6
+#define UART_CTL_RSTRXFIFO_MASK		(1 << UART_CTL_RSTRXFIFO_SHIFT)
+#define UART_CTL_RSTTXFIFO_SHIFT		7
+#define UART_CTL_RSTTXFIFO_MASK		(1 << UART_CTL_RSTTXFIFO_SHIFT)
+#define UART_CTL_STOPBITS_SHIFT		8
+#define UART_CTL_STOPBITS_MASK		(0xf << UART_CTL_STOPBITS_SHIFT)
+#define UART_CTL_STOPBITS_1		(0x7 << UART_CTL_STOPBITS_SHIFT)
+#define UART_CTL_STOPBITS_2		(0xf << UART_CTL_STOPBITS_SHIFT)
+#define UART_CTL_BITSPERSYM_SHIFT	12
+#define UART_CTL_BITSPERSYM_MASK	(0x3 << UART_CTL_BITSPERSYM_SHIFT)
+#define UART_CTL_XMITBRK_SHIFT		14
+#define UART_CTL_XMITBRK_MASK		(1 << UART_CTL_XMITBRK_SHIFT)
+#define UART_CTL_RSVD_SHIFT		15
+#define UART_CTL_RSVD_MASK		(1 << UART_CTL_RSVD_SHIFT)
+#define UART_CTL_RXPAREVEN_SHIFT		16
+#define UART_CTL_RXPAREVEN_MASK		(1 << UART_CTL_RXPAREVEN_SHIFT)
+#define UART_CTL_RXPAREN_SHIFT		17
+#define UART_CTL_RXPAREN_MASK		(1 << UART_CTL_RXPAREN_SHIFT)
+#define UART_CTL_TXPAREVEN_SHIFT		18
+#define UART_CTL_TXPAREVEN_MASK		(1 << UART_CTL_TXPAREVEN_SHIFT)
+#define UART_CTL_TXPAREN_SHIFT		18
+#define UART_CTL_TXPAREN_MASK		(1 << UART_CTL_TXPAREN_SHIFT)
+#define UART_CTL_LOOPBACK_SHIFT		20
+#define UART_CTL_LOOPBACK_MASK		(1 << UART_CTL_LOOPBACK_SHIFT)
+#define UART_CTL_RXEN_SHIFT		21
+#define UART_CTL_RXEN_MASK		(1 << UART_CTL_RXEN_SHIFT)
+#define UART_CTL_TXEN_SHIFT		22
+#define UART_CTL_TXEN_MASK		(1 << UART_CTL_TXEN_SHIFT)
+#define UART_CTL_BRGEN_SHIFT		23
+#define UART_CTL_BRGEN_MASK		(1 << UART_CTL_BRGEN_SHIFT)
+
+/* UART Baudword register */
+#define UART_BAUD_REG			0x4
+
+/* UART Misc Control register */
+#define UART_MCTL_REG			0x8
+#define UART_MCTL_DTR_SHIFT		0
+#define UART_MCTL_DTR_MASK		(1 << UART_MCTL_DTR_SHIFT)
+#define UART_MCTL_RTS_SHIFT		1
+#define UART_MCTL_RTS_MASK		(1 << UART_MCTL_RTS_SHIFT)
+#define UART_MCTL_RXFIFOTHRESH_SHIFT	8
+#define UART_MCTL_RXFIFOTHRESH_MASK	(0xf << UART_MCTL_RXFIFOTHRESH_SHIFT)
+#define UART_MCTL_TXFIFOTHRESH_SHIFT	12
+#define UART_MCTL_TXFIFOTHRESH_MASK	(0xf << UART_MCTL_TXFIFOTHRESH_SHIFT)
+#define UART_MCTL_RXFIFOFILL_SHIFT	16
+#define UART_MCTL_RXFIFOFILL_MASK	(0x1f << UART_MCTL_RXFIFOFILL_SHIFT)
+#define UART_MCTL_TXFIFOFILL_SHIFT	24
+#define UART_MCTL_TXFIFOFILL_MASK	(0x1f << UART_MCTL_TXFIFOFILL_SHIFT)
+
+/* UART External Input Configuration register */
+#define UART_EXTINP_REG			0xc
+#define UART_EXTINP_RI_SHIFT		0
+#define UART_EXTINP_RI_MASK		(1 << UART_EXTINP_RI_SHIFT)
+#define UART_EXTINP_CTS_SHIFT		1
+#define UART_EXTINP_CTS_MASK		(1 << UART_EXTINP_CTS_SHIFT)
+#define UART_EXTINP_DCD_SHIFT		2
+#define UART_EXTINP_DCD_MASK		(1 << UART_EXTINP_DCD_SHIFT)
+#define UART_EXTINP_DSR_SHIFT		3
+#define UART_EXTINP_DSR_MASK		(1 << UART_EXTINP_DSR_SHIFT)
+#define UART_EXTINP_IRSTAT(x)		(1 << (x + 4))
+#define UART_EXTINP_IRMASK(x)		(1 << (x + 8))
+#define UART_EXTINP_IR_RI		0
+#define UART_EXTINP_IR_CTS		1
+#define UART_EXTINP_IR_DCD		2
+#define UART_EXTINP_IR_DSR		3
+#define UART_EXTINP_RI_NOSENSE_SHIFT	16
+#define UART_EXTINP_RI_NOSENSE_MASK	(1 << UART_EXTINP_RI_NOSENSE_SHIFT)
+#define UART_EXTINP_CTS_NOSENSE_SHIFT	17
+#define UART_EXTINP_CTS_NOSENSE_MASK	(1 << UART_EXTINP_CTS_NOSENSE_SHIFT)
+#define UART_EXTINP_DCD_NOSENSE_SHIFT	18
+#define UART_EXTINP_DCD_NOSENSE_MASK	(1 << UART_EXTINP_DCD_NOSENSE_SHIFT)
+#define UART_EXTINP_DSR_NOSENSE_SHIFT	19
+#define UART_EXTINP_DSR_NOSENSE_MASK	(1 << UART_EXTINP_DSR_NOSENSE_SHIFT)
+
+/* UART Interrupt register */
+#define UART_IR_REG			0x10
+#define UART_IR_MASK(x)			(1 << (x + 16))
+#define UART_IR_STAT(x)			(1 << (x))
+#define UART_IR_EXTIP			0
+#define UART_IR_TXUNDER			1
+#define UART_IR_TXOVER			2
+#define UART_IR_TXTRESH			3
+#define UART_IR_TXRDLATCH		4
+#define UART_IR_TXEMPTY			5
+#define UART_IR_RXUNDER			6
+#define UART_IR_RXOVER			7
+#define UART_IR_RXTIMEOUT		8
+#define UART_IR_RXFULL			9
+#define UART_IR_RXTHRESH		10
+#define UART_IR_RXNOTEMPTY		11
+#define UART_IR_RXFRAMEERR		12
+#define UART_IR_RXPARERR		13
+#define UART_IR_RXBRK			14
+#define UART_IR_TXDONE			15
+
+/* UART Fifo register */
+#define UART_FIFO_REG			0x14
+#define UART_FIFO_VALID_SHIFT		0
+#define UART_FIFO_VALID_MASK		0xff
+#define UART_FIFO_FRAMEERR_SHIFT	8
+#define UART_FIFO_FRAMEERR_MASK		(1 << UART_FIFO_FRAMEERR_SHIFT)
+#define UART_FIFO_PARERR_SHIFT		9
+#define UART_FIFO_PARERR_MASK		(1 << UART_FIFO_PARERR_SHIFT)
+#define UART_FIFO_BRKDET_SHIFT		10
+#define UART_FIFO_BRKDET_MASK		(1 << UART_FIFO_BRKDET_SHIFT)
+#define UART_FIFO_ANYERR_MASK		(UART_FIFO_FRAMEERR_MASK |	\
+					UART_FIFO_PARERR_MASK |		\
+					UART_FIFO_BRKDET_MASK)
+
+
+/*************************************************************************
+ * _REG relative to RSET_GPIO
+ *************************************************************************/
+
+/* GPIO registers */
+#define GPIO_CTL_HI_REG			0x0
+#define GPIO_CTL_LO_REG			0x4
+#define GPIO_DATA_HI_REG		0x8
+#define GPIO_DATA_LO_REG		0xC
+
+/* GPIO mux registers and constants */
+#define GPIO_MODE_REG			0x18
+
+#define GPIO_MODE_6348_G4_DIAG		0x00090000
+#define GPIO_MODE_6348_G4_UTOPIA	0x00080000
+#define GPIO_MODE_6348_G4_LEGACY_LED	0x00030000
+#define GPIO_MODE_6348_G4_MII_SNOOP	0x00020000
+#define GPIO_MODE_6348_G4_EXT_EPHY	0x00010000
+#define GPIO_MODE_6348_G3_DIAG		0x00009000
+#define GPIO_MODE_6348_G3_UTOPIA	0x00008000
+#define GPIO_MODE_6348_G3_EXT_MII	0x00007000
+#define GPIO_MODE_6348_G2_DIAG		0x00000900
+#define GPIO_MODE_6348_G2_PCI		0x00000500
+#define GPIO_MODE_6348_G1_DIAG		0x00000090
+#define GPIO_MODE_6348_G1_UTOPIA	0x00000080
+#define GPIO_MODE_6348_G1_SPI_UART	0x00000060
+#define GPIO_MODE_6348_G1_SPI_MASTER	0x00000060
+#define GPIO_MODE_6348_G1_MII_PCCARD	0x00000040
+#define GPIO_MODE_6348_G1_MII_SNOOP	0x00000020
+#define GPIO_MODE_6348_G1_EXT_EPHY	0x00000010
+#define GPIO_MODE_6348_G0_DIAG		0x00000009
+#define GPIO_MODE_6348_G0_EXT_MII	0x00000007
+
+#define GPIO_MODE_6358_EXTRACS		(1 << 5)
+#define GPIO_MODE_6358_UART1		(1 << 6)
+#define GPIO_MODE_6358_EXTRA_SPI_SS	(1 << 7)
+#define GPIO_MODE_6358_SERIAL_LED	(1 << 10)
+#define GPIO_MODE_6358_UTOPIA		(1 << 12)
+
+
+/*************************************************************************
+ * _REG relative to RSET_ENET
+ *************************************************************************/
+
+/* Receiver Configuration register */
+#define ENET_RXCFG_REG			0x0
+#define ENET_RXCFG_ALLMCAST_SHIFT	1
+#define ENET_RXCFG_ALLMCAST_MASK	(1 << ENET_RXCFG_ALLMCAST_SHIFT)
+#define ENET_RXCFG_PROMISC_SHIFT	3
+#define ENET_RXCFG_PROMISC_MASK		(1 << ENET_RXCFG_PROMISC_SHIFT)
+#define ENET_RXCFG_LOOPBACK_SHIFT	4
+#define ENET_RXCFG_LOOPBACK_MASK	(1 << ENET_RXCFG_LOOPBACK_SHIFT)
+#define ENET_RXCFG_ENFLOW_SHIFT		5
+#define ENET_RXCFG_ENFLOW_MASK		(1 << ENET_RXCFG_ENFLOW_SHIFT)
+
+/* Receive Maximum Length register */
+#define ENET_RXMAXLEN_REG		0x4
+#define ENET_RXMAXLEN_SHIFT		0
+#define ENET_RXMAXLEN_MASK		(0x7ff << ENET_RXMAXLEN_SHIFT)
+
+/* Transmit Maximum Length register */
+#define ENET_TXMAXLEN_REG		0x8
+#define ENET_TXMAXLEN_SHIFT		0
+#define ENET_TXMAXLEN_MASK		(0x7ff << ENET_TXMAXLEN_SHIFT)
+
+/* MII Status/Control register */
+#define ENET_MIISC_REG			0x10
+#define ENET_MIISC_MDCFREQDIV_SHIFT	0
+#define ENET_MIISC_MDCFREQDIV_MASK	(0x7f << ENET_MIISC_MDCFREQDIV_SHIFT)
+#define ENET_MIISC_PREAMBLEEN_SHIFT	7
+#define ENET_MIISC_PREAMBLEEN_MASK	(1 << ENET_MIISC_PREAMBLEEN_SHIFT)
+
+/* MII Data register */
+#define ENET_MIIDATA_REG		0x14
+#define ENET_MIIDATA_DATA_SHIFT		0
+#define ENET_MIIDATA_DATA_MASK		(0xffff << ENET_MIIDATA_DATA_SHIFT)
+#define ENET_MIIDATA_TA_SHIFT		16
+#define ENET_MIIDATA_TA_MASK		(0x3 << ENET_MIIDATA_TA_SHIFT)
+#define ENET_MIIDATA_REG_SHIFT		18
+#define ENET_MIIDATA_REG_MASK		(0x1f << ENET_MIIDATA_REG_SHIFT)
+#define ENET_MIIDATA_PHYID_SHIFT	23
+#define ENET_MIIDATA_PHYID_MASK		(0x1f << ENET_MIIDATA_PHYID_SHIFT)
+#define ENET_MIIDATA_OP_READ_MASK	(0x6 << 28)
+#define ENET_MIIDATA_OP_WRITE_MASK	(0x5 << 28)
+
+/* Ethernet Interrupt Mask register */
+#define ENET_IRMASK_REG			0x18
+
+/* Ethernet Interrupt register */
+#define ENET_IR_REG			0x1c
+#define ENET_IR_MII			(1 << 0)
+#define ENET_IR_MIB			(1 << 1)
+#define ENET_IR_FLOWC			(1 << 2)
+
+/* Ethernet Control register */
+#define ENET_CTL_REG			0x2c
+#define ENET_CTL_ENABLE_SHIFT		0
+#define ENET_CTL_ENABLE_MASK		(1 << ENET_CTL_ENABLE_SHIFT)
+#define ENET_CTL_DISABLE_SHIFT		1
+#define ENET_CTL_DISABLE_MASK		(1 << ENET_CTL_DISABLE_SHIFT)
+#define ENET_CTL_SRESET_SHIFT		2
+#define ENET_CTL_SRESET_MASK		(1 << ENET_CTL_SRESET_SHIFT)
+#define ENET_CTL_EPHYSEL_SHIFT		3
+#define ENET_CTL_EPHYSEL_MASK		(1 << ENET_CTL_EPHYSEL_SHIFT)
+
+/* Transmit Control register */
+#define ENET_TXCTL_REG			0x30
+#define ENET_TXCTL_FD_SHIFT		0
+#define ENET_TXCTL_FD_MASK		(1 << ENET_TXCTL_FD_SHIFT)
+
+/* Transmit Watermask register */
+#define ENET_TXWMARK_REG		0x34
+#define ENET_TXWMARK_WM_SHIFT		0
+#define ENET_TXWMARK_WM_MASK		(0x3f << ENET_TXWMARK_WM_SHIFT)
+
+/* MIB Control register */
+#define ENET_MIBCTL_REG			0x38
+#define ENET_MIBCTL_RDCLEAR_SHIFT	0
+#define ENET_MIBCTL_RDCLEAR_MASK	(1 << ENET_MIBCTL_RDCLEAR_SHIFT)
+
+/* Perfect Match Data Low register */
+#define ENET_PML_REG(x)			(0x58 + (x) * 8)
+#define ENET_PMH_REG(x)			(0x5c + (x) * 8)
+#define ENET_PMH_DATAVALID_SHIFT	16
+#define ENET_PMH_DATAVALID_MASK		(1 << ENET_PMH_DATAVALID_SHIFT)
+
+/* MIB register */
+#define ENET_MIB_REG(x)			(0x200 + (x) * 4)
+#define ENET_MIB_REG_COUNT		55
+
+
+/*************************************************************************
+ * _REG relative to RSET_ENETDMA
+ *************************************************************************/
+
+/* Controller Configuration Register */
+#define ENETDMA_CFG_REG			(0x0)
+#define ENETDMA_CFG_EN_SHIFT		0
+#define ENETDMA_CFG_EN_MASK		(1 << ENETDMA_CFG_EN_SHIFT)
+#define ENETDMA_CFG_FLOWCH_MASK(x)	(1 << ((x >> 1) + 1))
+
+/* Flow Control Descriptor Low Threshold register */
+#define ENETDMA_FLOWCL_REG(x)		(0x4 + (x) * 6)
+
+/* Flow Control Descriptor High Threshold register */
+#define ENETDMA_FLOWCH_REG(x)		(0x8 + (x) * 6)
+
+/* Flow Control Descriptor Buffer Alloca Threshold register */
+#define ENETDMA_BUFALLOC_REG(x)		(0xc + (x) * 6)
+#define ENETDMA_BUFALLOC_FORCE_SHIFT	31
+#define ENETDMA_BUFALLOC_FORCE_MASK	(1 << ENETDMA_BUFALLOC_FORCE_SHIFT)
+
+/* Channel Configuration register */
+#define ENETDMA_CHANCFG_REG(x)		(0x100 + (x) * 0x10)
+#define ENETDMA_CHANCFG_EN_SHIFT	0
+#define ENETDMA_CHANCFG_EN_MASK		(1 << ENETDMA_CHANCFG_EN_SHIFT)
+#define ENETDMA_CHANCFG_PKTHALT_SHIFT	1
+#define ENETDMA_CHANCFG_PKTHALT_MASK	(1 << ENETDMA_CHANCFG_PKTHALT_SHIFT)
+
+/* Interrupt Control/Status register */
+#define ENETDMA_IR_REG(x)		(0x104 + (x) * 0x10)
+#define ENETDMA_IR_BUFDONE_MASK		(1 << 0)
+#define ENETDMA_IR_PKTDONE_MASK		(1 << 1)
+#define ENETDMA_IR_NOTOWNER_MASK	(1 << 2)
+
+/* Interrupt Mask register */
+#define ENETDMA_IRMASK_REG(x)		(0x108 + (x) * 0x10)
+
+/* Maximum Burst Length */
+#define ENETDMA_MAXBURST_REG(x)		(0x10C + (x) * 0x10)
+
+/* Ring Start Address register */
+#define ENETDMA_RSTART_REG(x)		(0x200 + (x) * 0x10)
+
+/* State Ram Word 2 */
+#define ENETDMA_SRAM2_REG(x)		(0x204 + (x) * 0x10)
+
+/* State Ram Word 3 */
+#define ENETDMA_SRAM3_REG(x)		(0x208 + (x) * 0x10)
+
+/* State Ram Word 4 */
+#define ENETDMA_SRAM4_REG(x)		(0x20c + (x) * 0x10)
+
+
+/*************************************************************************
+ * _REG relative to RSET_OHCI_PRIV
+ *************************************************************************/
+
+#define OHCI_PRIV_REG			0x0
+#define OHCI_PRIV_PORT1_HOST_SHIFT	0
+#define OHCI_PRIV_PORT1_HOST_MASK	(1 << OHCI_PRIV_PORT1_HOST_SHIFT)
+#define OHCI_PRIV_REG_SWAP_SHIFT	3
+#define OHCI_PRIV_REG_SWAP_MASK		(1 << OHCI_PRIV_REG_SWAP_SHIFT)
+
+
+/*************************************************************************
+ * _REG relative to RSET_USBH_PRIV
+ *************************************************************************/
+
+#define USBH_PRIV_SWAP_REG		0x0
+#define USBH_PRIV_SWAP_EHCI_ENDN_SHIFT	4
+#define USBH_PRIV_SWAP_EHCI_ENDN_MASK	(1 << USBH_PRIV_SWAP_EHCI_ENDN_SHIFT)
+#define USBH_PRIV_SWAP_EHCI_DATA_SHIFT	3
+#define USBH_PRIV_SWAP_EHCI_DATA_MASK	(1 << USBH_PRIV_SWAP_EHCI_DATA_SHIFT)
+#define USBH_PRIV_SWAP_OHCI_ENDN_SHIFT	1
+#define USBH_PRIV_SWAP_OHCI_ENDN_MASK	(1 << USBH_PRIV_SWAP_OHCI_ENDN_SHIFT)
+#define USBH_PRIV_SWAP_OHCI_DATA_SHIFT	0
+#define USBH_PRIV_SWAP_OHCI_DATA_MASK	(1 << USBH_PRIV_SWAP_OHCI_DATA_SHIFT)
+
+#define USBH_PRIV_TEST_REG		0x24
+
+
+/*************************************************************************
+ * _REG relative to RSET_MPI
+ *************************************************************************/
+
+/* well known (hard wired) chip select */
+#define MPI_CS_PCMCIA_COMMON		4
+#define MPI_CS_PCMCIA_ATTR		5
+#define MPI_CS_PCMCIA_IO		6
+
+/* Chip select base register */
+#define MPI_CSBASE_REG(x)		(0x0 + (x) * 8)
+#define MPI_CSBASE_BASE_SHIFT		13
+#define MPI_CSBASE_BASE_MASK		(0x1ffff << MPI_CSBASE_BASE_SHIFT)
+#define MPI_CSBASE_SIZE_SHIFT		0
+#define MPI_CSBASE_SIZE_MASK		(0xf << MPI_CSBASE_SIZE_SHIFT)
+
+#define MPI_CSBASE_SIZE_8K		0
+#define MPI_CSBASE_SIZE_16K		1
+#define MPI_CSBASE_SIZE_32K		2
+#define MPI_CSBASE_SIZE_64K		3
+#define MPI_CSBASE_SIZE_128K		4
+#define MPI_CSBASE_SIZE_256K		5
+#define MPI_CSBASE_SIZE_512K		6
+#define MPI_CSBASE_SIZE_1M		7
+#define MPI_CSBASE_SIZE_2M		8
+#define MPI_CSBASE_SIZE_4M		9
+#define MPI_CSBASE_SIZE_8M		10
+#define MPI_CSBASE_SIZE_16M		11
+#define MPI_CSBASE_SIZE_32M		12
+#define MPI_CSBASE_SIZE_64M		13
+#define MPI_CSBASE_SIZE_128M		14
+#define MPI_CSBASE_SIZE_256M		15
+
+/* Chip select control register */
+#define MPI_CSCTL_REG(x)		(0x4 + (x) * 8)
+#define MPI_CSCTL_ENABLE_MASK		(1 << 0)
+#define MPI_CSCTL_WAIT_SHIFT		1
+#define MPI_CSCTL_WAIT_MASK		(0x7 << MPI_CSCTL_WAIT_SHIFT)
+#define MPI_CSCTL_DATA16_MASK		(1 << 4)
+#define MPI_CSCTL_SYNCMODE_MASK		(1 << 7)
+#define MPI_CSCTL_TSIZE_MASK		(1 << 8)
+#define MPI_CSCTL_ENDIANSWAP_MASK	(1 << 10)
+#define MPI_CSCTL_SETUP_SHIFT		16
+#define MPI_CSCTL_SETUP_MASK		(0xf << MPI_CSCTL_SETUP_SHIFT)
+#define MPI_CSCTL_HOLD_SHIFT		20
+#define MPI_CSCTL_HOLD_MASK		(0xf << MPI_CSCTL_HOLD_SHIFT)
+
+/* PCI registers */
+#define MPI_SP0_RANGE_REG		0x100
+#define MPI_SP0_REMAP_REG		0x104
+#define MPI_SP0_REMAP_ENABLE_MASK	(1 << 0)
+#define MPI_SP1_RANGE_REG		0x10C
+#define MPI_SP1_REMAP_REG		0x110
+#define MPI_SP1_REMAP_ENABLE_MASK	(1 << 0)
+
+#define MPI_L2PCFG_REG			0x11C
+#define MPI_L2PCFG_CFG_TYPE_SHIFT	0
+#define MPI_L2PCFG_CFG_TYPE_MASK	(0x3 << MPI_L2PCFG_CFG_TYPE_SHIFT)
+#define MPI_L2PCFG_REG_SHIFT		2
+#define MPI_L2PCFG_REG_MASK		(0x3f << MPI_L2PCFG_REG_SHIFT)
+#define MPI_L2PCFG_FUNC_SHIFT		8
+#define MPI_L2PCFG_FUNC_MASK		(0x7 << MPI_L2PCFG_FUNC_SHIFT)
+#define MPI_L2PCFG_DEVNUM_SHIFT		11
+#define MPI_L2PCFG_DEVNUM_MASK		(0x1f << MPI_L2PCFG_DEVNUM_SHIFT)
+#define MPI_L2PCFG_CFG_USEREG_MASK	(1 << 30)
+#define MPI_L2PCFG_CFG_SEL_MASK		(1 << 31)
+
+#define MPI_L2PMEMRANGE1_REG		0x120
+#define MPI_L2PMEMBASE1_REG		0x124
+#define MPI_L2PMEMREMAP1_REG		0x128
+#define MPI_L2PMEMRANGE2_REG		0x12C
+#define MPI_L2PMEMBASE2_REG		0x130
+#define MPI_L2PMEMREMAP2_REG		0x134
+#define MPI_L2PIORANGE_REG		0x138
+#define MPI_L2PIOBASE_REG		0x13C
+#define MPI_L2PIOREMAP_REG		0x140
+#define MPI_L2P_BASE_MASK		(0xffff8000)
+#define MPI_L2PREMAP_ENABLED_MASK	(1 << 0)
+#define MPI_L2PREMAP_IS_CARDBUS_MASK	(1 << 2)
+
+#define MPI_PCIMODESEL_REG		0x144
+#define MPI_PCIMODESEL_BAR1_NOSWAP_MASK	(1 << 0)
+#define MPI_PCIMODESEL_BAR2_NOSWAP_MASK	(1 << 1)
+#define MPI_PCIMODESEL_EXT_ARB_MASK	(1 << 2)
+#define MPI_PCIMODESEL_PREFETCH_SHIFT	4
+#define MPI_PCIMODESEL_PREFETCH_MASK	(0xf << MPI_PCIMODESEL_PREFETCH_SHIFT)
+
+#define MPI_LOCBUSCTL_REG		0x14C
+#define MPI_LOCBUSCTL_EN_PCI_GPIO_MASK	(1 << 0)
+#define MPI_LOCBUSCTL_U2P_NOSWAP_MASK	(1 << 1)
+
+#define MPI_LOCINT_REG			0x150
+#define MPI_LOCINT_MASK(x)		(1 << (x + 16))
+#define MPI_LOCINT_STAT(x)		(1 << (x))
+#define MPI_LOCINT_DIR_FAILED		6
+#define MPI_LOCINT_EXT_PCI_INT		7
+#define MPI_LOCINT_SERR			8
+#define MPI_LOCINT_CSERR		9
+
+#define MPI_PCICFGCTL_REG		0x178
+#define MPI_PCICFGCTL_CFGADDR_SHIFT	2
+#define MPI_PCICFGCTL_CFGADDR_MASK	(0x1f << MPI_PCICFGCTL_CFGADDR_SHIFT)
+#define MPI_PCICFGCTL_WRITEEN_MASK	(1 << 7)
+
+#define MPI_PCICFGDATA_REG		0x17C
+
+/* PCI host bridge custom register */
+#define BCMPCI_REG_TIMERS		0x40
+#define REG_TIMER_TRDY_SHIFT		0
+#define REG_TIMER_TRDY_MASK		(0xff << REG_TIMER_TRDY_SHIFT)
+#define REG_TIMER_RETRY_SHIFT		8
+#define REG_TIMER_RETRY_MASK		(0xff << REG_TIMER_RETRY_SHIFT)
+
+
+/*************************************************************************
+ * _REG relative to RSET_PCMCIA
+ *************************************************************************/
+
+#define PCMCIA_C1_REG			0x0
+#define PCMCIA_C1_CD1_MASK		(1 << 0)
+#define PCMCIA_C1_CD2_MASK		(1 << 1)
+#define PCMCIA_C1_VS1_MASK		(1 << 2)
+#define PCMCIA_C1_VS2_MASK		(1 << 3)
+#define PCMCIA_C1_VS1OE_MASK		(1 << 6)
+#define PCMCIA_C1_VS2OE_MASK		(1 << 7)
+#define PCMCIA_C1_CBIDSEL_SHIFT		(8)
+#define PCMCIA_C1_CBIDSEL_MASK		(0x1f << PCMCIA_C1_CBIDSEL_SHIFT)
+#define PCMCIA_C1_EN_PCMCIA_GPIO_MASK	(1 << 13)
+#define PCMCIA_C1_EN_PCMCIA_MASK	(1 << 14)
+#define PCMCIA_C1_EN_CARDBUS_MASK	(1 << 15)
+#define PCMCIA_C1_RESET_MASK		(1 << 18)
+
+#define PCMCIA_C2_REG			0x8
+#define PCMCIA_C2_DATA16_MASK		(1 << 0)
+#define PCMCIA_C2_BYTESWAP_MASK		(1 << 1)
+#define PCMCIA_C2_RWCOUNT_SHIFT		2
+#define PCMCIA_C2_RWCOUNT_MASK		(0x3f << PCMCIA_C2_RWCOUNT_SHIFT)
+#define PCMCIA_C2_INACTIVE_SHIFT	8
+#define PCMCIA_C2_INACTIVE_MASK		(0x3f << PCMCIA_C2_INACTIVE_SHIFT)
+#define PCMCIA_C2_SETUP_SHIFT		16
+#define PCMCIA_C2_SETUP_MASK		(0x3f << PCMCIA_C2_SETUP_SHIFT)
+#define PCMCIA_C2_HOLD_SHIFT		24
+#define PCMCIA_C2_HOLD_MASK		(0x3f << PCMCIA_C2_HOLD_SHIFT)
+
+
+/*************************************************************************
+ * _REG relative to RSET_SDRAM
+ *************************************************************************/
+
+#define SDRAM_CFG_REG			0x0
+#define SDRAM_CFG_ROW_SHIFT		4
+#define SDRAM_CFG_ROW_MASK		(0x3 << SDRAM_CFG_ROW_SHIFT)
+#define SDRAM_CFG_COL_SHIFT		6
+#define SDRAM_CFG_COL_MASK		(0x3 << SDRAM_CFG_COL_SHIFT)
+#define SDRAM_CFG_32B_SHIFT		10
+#define SDRAM_CFG_32B_MASK		(1 << SDRAM_CFG_32B_SHIFT)
+#define SDRAM_CFG_BANK_SHIFT		13
+#define SDRAM_CFG_BANK_MASK		(1 << SDRAM_CFG_BANK_SHIFT)
+
+#define SDRAM_PRIO_REG			0x2C
+#define SDRAM_PRIO_MIPS_SHIFT		29
+#define SDRAM_PRIO_MIPS_MASK		(1 << SDRAM_PRIO_MIPS_SHIFT)
+#define SDRAM_PRIO_ADSL_SHIFT		30
+#define SDRAM_PRIO_ADSL_MASK		(1 << SDRAM_PRIO_ADSL_SHIFT)
+#define SDRAM_PRIO_EN_SHIFT		31
+#define SDRAM_PRIO_EN_MASK		(1 << SDRAM_PRIO_EN_SHIFT)
+
+
+/*************************************************************************
+ * _REG relative to RSET_MEMC
+ *************************************************************************/
+
+#define MEMC_CFG_REG			0x4
+#define MEMC_CFG_32B_SHIFT		1
+#define MEMC_CFG_32B_MASK		(1 << MEMC_CFG_32B_SHIFT)
+#define MEMC_CFG_COL_SHIFT		3
+#define MEMC_CFG_COL_MASK		(0x3 << MEMC_CFG_COL_SHIFT)
+#define MEMC_CFG_ROW_SHIFT		6
+#define MEMC_CFG_ROW_MASK		(0x3 << MEMC_CFG_ROW_SHIFT)
+
+
+/*************************************************************************
+ * _REG relative to RSET_DDR
+ *************************************************************************/
+
+#define DDR_DMIPSPLLCFG_REG		0x18
+#define DMIPSPLLCFG_M1_SHIFT		0
+#define DMIPSPLLCFG_M1_MASK		(0xff << DMIPSPLLCFG_M1_SHIFT)
+#define DMIPSPLLCFG_N1_SHIFT		23
+#define DMIPSPLLCFG_N1_MASK		(0x3f << DMIPSPLLCFG_N1_SHIFT)
+#define DMIPSPLLCFG_N2_SHIFT		29
+#define DMIPSPLLCFG_N2_MASK		(0x7 << DMIPSPLLCFG_N2_SHIFT)
+
+#endif /* BCM63XX_REGS_H_ */
+
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
@@ -0,0 +1,11 @@
+#ifndef BCM63XX_TIMER_H_
+#define BCM63XX_TIMER_H_
+
+int bcm63xx_timer_register(int id, void (*callback)(void *data), void *data);
+void bcm63xx_timer_unregister(int id);
+int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us);
+int bcm63xx_timer_enable(int id);
+int bcm63xx_timer_disable(int id);
+unsigned int bcm63xx_timer_countdown(unsigned int countdown_us);
+
+#endif /* !BCM63XX_TIMER_H_ */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
@@ -0,0 +1,51 @@
+#ifndef __ASM_MACH_BCM963XX_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_BCM963XX_CPU_FEATURE_OVERRIDES_H
+
+#include <bcm63xx_cpu.h>
+
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_4k_cache		1
+#define cpu_has_fpu			0
+#define cpu_has_32fpr			0
+#define cpu_has_counter			1
+#define cpu_has_watch			0
+#define cpu_has_divec			1
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_prefetch		1
+#define cpu_has_mcheck			1
+#define cpu_has_ejtag			1
+#define cpu_has_llsc			1
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_vtag_icache		0
+
+#if !defined(BCMCPU_RUNTIME_DETECT) && defined(CONFIG_BCMCPU_IS_6348)
+#define cpu_has_dc_aliases		0
+#endif
+
+#define cpu_has_ic_fills_f_dc		0
+#define cpu_has_pindexed_dcache		0
+
+#define cpu_has_mips32r1		1
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
+
+#define cpu_has_nofpuex			0
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+
+#define cpu_dcache_line_size()		16
+#define cpu_icache_line_size()		16
+#define cpu_scache_line_size()		0
+
+#endif /* __ASM_MACH_BCM963XX_CPU_FEATURE_OVERRIDES_H */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/gpio.h
@@ -0,0 +1,17 @@
+#ifndef __ASM_MIPS_MACH_BCM63XX_GPIO_H
+#define __ASM_MIPS_MACH_BCM63XX_GPIO_H
+
+#include <bcm63xx_gpio.h>
+
+#define NR_BUILTIN_GPIO		BCM63XX_GPIO_COUNT
+
+#define gpio_to_irq(gpio)	NULL
+
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
+
+#define gpio_cansleep __gpio_cansleep
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_MIPS_MACH_BCM63XX_GPIO_H */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_BCM63XX_WAR_H
+#define __ASM_MIPS_MACH_BCM63XX_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_BCM63XX_WAR_H */
