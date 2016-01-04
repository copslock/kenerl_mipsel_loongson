Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:24:32 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57780 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009726AbcADTYOJEsDd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:14 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 45252280660;
        Mon,  4 Jan 2016 20:23:41 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:41 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/8] MIPS: ralink: add MT7621 support
Date:   Mon,  4 Jan 2016 20:23:55 +0100
Message-Id: <1451935441-40803-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
References: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

MT7621 is based on a 1004k core. This patch adds support for the SoC. The
timer and IRQ is just boiler plate as GIC has recently been moved to
generic places in the kernel and just works.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/irq.h            |    9 +
 arch/mips/include/asm/mach-ralink/mt7621.h         |   38 ++++
 .../asm/mach-ralink/mt7621/cpu-feature-overrides.h |   65 ++++++
 arch/mips/ralink/Kconfig                           |   11 +
 arch/mips/ralink/Makefile                          |    8 +-
 arch/mips/ralink/Platform                          |    5 +
 arch/mips/ralink/irq-gic.c                         |   26 +++
 arch/mips/ralink/mt7621.c                          |  226 ++++++++++++++++++++
 arch/mips/ralink/timer-gic.c                       |   24 +++
 9 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-ralink/irq.h
 create mode 100644 arch/mips/include/asm/mach-ralink/mt7621.h
 create mode 100644 arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
 create mode 100644 arch/mips/ralink/irq-gic.c
 create mode 100644 arch/mips/ralink/mt7621.c
 create mode 100644 arch/mips/ralink/timer-gic.c

diff --git a/arch/mips/include/asm/mach-ralink/irq.h b/arch/mips/include/asm/mach-ralink/irq.h
new file mode 100644
index 0000000..4321865
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/irq.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_RALINK_IRQ_H
+#define __ASM_MACH_RALINK_IRQ_H
+
+#define GIC_NUM_INTRS	64
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif
diff --git a/arch/mips/include/asm/mach-ralink/mt7621.h b/arch/mips/include/asm/mach-ralink/mt7621.h
new file mode 100644
index 0000000..610b61e
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/mt7621.h
@@ -0,0 +1,38 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _MT7621_REGS_H_
+#define _MT7621_REGS_H_
+
+#define MT7621_PALMBUS_BASE		0x1C000000
+#define MT7621_PALMBUS_SIZE		0x03FFFFFF
+
+#define MT7621_SYSC_BASE		0x1E000000
+
+#define SYSC_REG_CHIP_NAME0		0x00
+#define SYSC_REG_CHIP_NAME1		0x04
+#define SYSC_REG_CHIP_REV		0x0c
+#define SYSC_REG_SYSTEM_CONFIG0		0x10
+#define SYSC_REG_SYSTEM_CONFIG1		0x14
+
+#define CHIP_REV_PKG_MASK		0x1
+#define CHIP_REV_PKG_SHIFT		16
+#define CHIP_REV_VER_MASK		0xf
+#define CHIP_REV_VER_SHIFT		8
+#define CHIP_REV_ECO_MASK		0xf
+
+#define MT7621_DRAM_BASE                0x0
+#define MT7621_DDR2_SIZE_MIN		32
+#define MT7621_DDR2_SIZE_MAX		256
+
+#define MT7621_CHIP_NAME0		0x3637544D
+#define MT7621_CHIP_NAME1		0x20203132
+
+#define MIPS_GIC_IRQ_BASE           (MIPS_CPU_IRQ_BASE + 8)
+
+#endif
diff --git a/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
new file mode 100644
index 0000000..15db1b3
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
@@ -0,0 +1,65 @@
+/*
+ * Ralink MT7621 specific CPU feature overrides
+ *
+ * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2015 Felix Fietkau <nbd@openwrt.org>
+ *
+ * This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ */
+#ifndef _MT7621_CPU_FEATURE_OVERRIDES_H
+#define _MT7621_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_sb1_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+
+#define cpu_has_prefetch	1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+
+#define cpu_has_mips16		1
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#define cpu_has_dsp		1
+#define cpu_has_dsp2		0
+#define cpu_has_mipsmt		1
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+
+#define cpu_has_dc_aliases	0
+#define cpu_has_vtag_icache	0
+
+#define cpu_has_rixi		0
+#define cpu_has_tlbinv		0
+#define cpu_has_userlocal	1
+
+#endif /* _MT7621_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index c578c5d9d..016d26e 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -15,6 +15,7 @@ config RALINK_ILL_ACC
 config IRQ_INTC
 	bool
 	default y
+	depends on !SOC_MT7621
 
 choice
 	prompt "Ralink SoC selection"
@@ -38,6 +39,16 @@ choice
 	config SOC_MT7620
 		bool "MT7620/8"
 
+	config SOC_MT7621
+		bool "MT7621"
+		select MIPS_CPU_SCACHE
+		select SYS_SUPPORTS_MULTITHREADING
+		select SYS_SUPPORTS_SMP
+		select SYS_SUPPORTS_MIPS_CPS
+		select MIPS_GIC
+		select COMMON_CLK
+		select CLKSRC_MIPS_GIC
+		select HW_HAS_PCI
 endchoice
 
 choice
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 06c315f..0d1795a 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -6,18 +6,24 @@
 # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
 # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
 
-obj-y := prom.o of.o reset.o clk.o irq.o timer.o
+obj-y := prom.o of.o reset.o
+
+ifndef CONFIG_MIPS_GIC
+	obj-y += clk.o timer.o
+endif
 
 obj-$(CONFIG_CLKEVT_RT3352) += cevt-rt3352.o
 
 obj-$(CONFIG_RALINK_ILL_ACC) += ill_acc.o
 
 obj-$(CONFIG_IRQ_INTC) += irq.o
+obj-$(CONFIG_MIPS_GIC) += irq-gic.o timer-gic.o
 
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
 obj-$(CONFIG_SOC_MT7620) += mt7620.o
+obj-$(CONFIG_SOC_MT7621) += mt7621.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index 6d9c8c4..6095fcc 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -27,3 +27,8 @@ cflags-$(CONFIG_SOC_RT3883)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/rt
 #
 load-$(CONFIG_SOC_MT7620)	+= 0xffffffff80000000
 cflags-$(CONFIG_SOC_MT7620)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/mt7620
+
+# Ralink MT7621
+#
+load-$(CONFIG_SOC_MT7621)	+= 0xffffffff80001000
+cflags-$(CONFIG_SOC_MT7621)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/mt7621
diff --git a/arch/mips/ralink/irq-gic.c b/arch/mips/ralink/irq-gic.c
new file mode 100644
index 0000000..3eda25a
--- /dev/null
+++ b/arch/mips/ralink/irq-gic.c
@@ -0,0 +1,26 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Nikolay Martynov <mar.kolya@gmail.com>
+ * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+
+#include <linux/of.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/mips-gic.h>
+
+int get_c0_perfcount_int(void)
+{
+	return gic_get_c0_perfcount_int();
+}
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
+
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
new file mode 100644
index 0000000..e9b9fa3
--- /dev/null
+++ b/arch/mips/ralink/mt7621.c
@@ -0,0 +1,226 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Nikolay Martynov <mar.kolya@gmail.com>
+ * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/mipsregs.h>
+#include <asm/smp-ops.h>
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+#include <asm/mach-ralink/ralink_regs.h>
+#include <asm/mach-ralink/mt7621.h>
+
+#include <pinmux.h>
+
+#include "common.h"
+
+#define SYSC_REG_SYSCFG		0x10
+#define SYSC_REG_CPLL_CLKCFG0	0x2c
+#define SYSC_REG_CUR_CLK_STS	0x44
+#define CPU_CLK_SEL		(BIT(30) | BIT(31))
+
+#define MT7621_GPIO_MODE_UART1		1
+#define MT7621_GPIO_MODE_I2C		2
+#define MT7621_GPIO_MODE_UART3_MASK	0x3
+#define MT7621_GPIO_MODE_UART3_SHIFT	3
+#define MT7621_GPIO_MODE_UART3_GPIO	1
+#define MT7621_GPIO_MODE_UART2_MASK	0x3
+#define MT7621_GPIO_MODE_UART2_SHIFT	5
+#define MT7621_GPIO_MODE_UART2_GPIO	1
+#define MT7621_GPIO_MODE_JTAG		7
+#define MT7621_GPIO_MODE_WDT_MASK	0x3
+#define MT7621_GPIO_MODE_WDT_SHIFT	8
+#define MT7621_GPIO_MODE_WDT_GPIO	1
+#define MT7621_GPIO_MODE_PCIE_RST	0
+#define MT7621_GPIO_MODE_PCIE_REF	2
+#define MT7621_GPIO_MODE_PCIE_MASK	0x3
+#define MT7621_GPIO_MODE_PCIE_SHIFT	10
+#define MT7621_GPIO_MODE_PCIE_GPIO	1
+#define MT7621_GPIO_MODE_MDIO_MASK	0x3
+#define MT7621_GPIO_MODE_MDIO_SHIFT	12
+#define MT7621_GPIO_MODE_MDIO_GPIO	1
+#define MT7621_GPIO_MODE_RGMII1		14
+#define MT7621_GPIO_MODE_RGMII2		15
+#define MT7621_GPIO_MODE_SPI_MASK	0x3
+#define MT7621_GPIO_MODE_SPI_SHIFT	16
+#define MT7621_GPIO_MODE_SPI_GPIO	1
+#define MT7621_GPIO_MODE_SDHCI_MASK	0x3
+#define MT7621_GPIO_MODE_SDHCI_SHIFT	18
+#define MT7621_GPIO_MODE_SDHCI_GPIO	1
+
+static struct rt2880_pmx_func uart1_grp[] =  { FUNC("uart1", 0, 1, 2) };
+static struct rt2880_pmx_func i2c_grp[] =  { FUNC("i2c", 0, 3, 2) };
+static struct rt2880_pmx_func uart3_grp[] = {
+	FUNC("uart3", 0, 5, 4),
+	FUNC("i2s", 2, 5, 4),
+	FUNC("spdif3", 3, 5, 4),
+};
+static struct rt2880_pmx_func uart2_grp[] = {
+	FUNC("uart2", 0, 9, 4),
+	FUNC("pcm", 2, 9, 4),
+	FUNC("spdif2", 3, 9, 4),
+};
+static struct rt2880_pmx_func jtag_grp[] = { FUNC("jtag", 0, 13, 5) };
+static struct rt2880_pmx_func wdt_grp[] = {
+	FUNC("wdt rst", 0, 18, 1),
+	FUNC("wdt refclk", 2, 18, 1),
+};
+static struct rt2880_pmx_func pcie_rst_grp[] = {
+	FUNC("pcie rst", MT7621_GPIO_MODE_PCIE_RST, 19, 1),
+	FUNC("pcie refclk", MT7621_GPIO_MODE_PCIE_REF, 19, 1)
+};
+static struct rt2880_pmx_func mdio_grp[] = { FUNC("mdio", 0, 20, 2) };
+static struct rt2880_pmx_func rgmii2_grp[] = { FUNC("rgmii2", 0, 22, 12) };
+static struct rt2880_pmx_func spi_grp[] = {
+	FUNC("spi", 0, 34, 7),
+	FUNC("nand1", 2, 34, 7),
+};
+static struct rt2880_pmx_func sdhci_grp[] = {
+	FUNC("sdhci", 0, 41, 8),
+	FUNC("nand2", 2, 41, 8),
+};
+static struct rt2880_pmx_func rgmii1_grp[] = { FUNC("rgmii1", 0, 49, 12) };
+
+static struct rt2880_pmx_group mt7621_pinmux_data[] = {
+	GRP("uart1", uart1_grp, 1, MT7621_GPIO_MODE_UART1),
+	GRP("i2c", i2c_grp, 1, MT7621_GPIO_MODE_I2C),
+	GRP_G("uart3", uart3_grp, MT7621_GPIO_MODE_UART3_MASK,
+		MT7621_GPIO_MODE_UART3_GPIO, MT7621_GPIO_MODE_UART3_SHIFT),
+	GRP_G("uart2", uart2_grp, MT7621_GPIO_MODE_UART2_MASK,
+		MT7621_GPIO_MODE_UART2_GPIO, MT7621_GPIO_MODE_UART2_SHIFT),
+	GRP("jtag", jtag_grp, 1, MT7621_GPIO_MODE_JTAG),
+	GRP_G("wdt", wdt_grp, MT7621_GPIO_MODE_WDT_MASK,
+		MT7621_GPIO_MODE_WDT_GPIO, MT7621_GPIO_MODE_WDT_SHIFT),
+	GRP_G("pcie", pcie_rst_grp, MT7621_GPIO_MODE_PCIE_MASK,
+		MT7621_GPIO_MODE_PCIE_GPIO, MT7621_GPIO_MODE_PCIE_SHIFT),
+	GRP_G("mdio", mdio_grp, MT7621_GPIO_MODE_MDIO_MASK,
+		MT7621_GPIO_MODE_MDIO_GPIO, MT7621_GPIO_MODE_MDIO_SHIFT),
+	GRP("rgmii2", rgmii2_grp, 1, MT7621_GPIO_MODE_RGMII2),
+	GRP_G("spi", spi_grp, MT7621_GPIO_MODE_SPI_MASK,
+		MT7621_GPIO_MODE_SPI_GPIO, MT7621_GPIO_MODE_SPI_SHIFT),
+	GRP_G("sdhci", sdhci_grp, MT7621_GPIO_MODE_SDHCI_MASK,
+		MT7621_GPIO_MODE_SDHCI_GPIO, MT7621_GPIO_MODE_SDHCI_SHIFT),
+	GRP("rgmii1", rgmii1_grp, 1, MT7621_GPIO_MODE_RGMII1),
+	{ 0 }
+};
+
+phys_addr_t mips_cpc_default_phys_base(void)
+{
+	panic("Cannot detect cpc address");
+}
+
+void __init ralink_clk_init(void)
+{
+	int cpu_fdiv = 0;
+	int cpu_ffrac = 0;
+	int fbdiv = 0;
+	u32 clk_sts, syscfg;
+	u8 clk_sel = 0, xtal_mode;
+	u32 cpu_clk;
+
+	if ((rt_sysc_r32(SYSC_REG_CPLL_CLKCFG0) & CPU_CLK_SEL) != 0)
+		clk_sel = 1;
+
+	switch (clk_sel) {
+	case 0:
+		clk_sts = rt_sysc_r32(SYSC_REG_CUR_CLK_STS);
+		cpu_fdiv = ((clk_sts >> 8) & 0x1F);
+		cpu_ffrac = (clk_sts & 0x1F);
+		cpu_clk = (500 * cpu_ffrac / cpu_fdiv) * 1000 * 1000;
+		break;
+
+	case 1:
+		fbdiv = ((rt_sysc_r32(0x648) >> 4) & 0x7F) + 1;
+		syscfg = rt_sysc_r32(SYSC_REG_SYSCFG);
+		xtal_mode = (syscfg >> 6) & 0x7;
+		if (xtal_mode >= 6) {
+			/* 25Mhz Xtal */
+			cpu_clk = 25 * fbdiv * 1000 * 1000;
+		} else if (xtal_mode >= 3) {
+			/* 40Mhz Xtal */
+			cpu_clk = 40 * fbdiv * 1000 * 1000;
+		} else {
+			/* 20Mhz Xtal */
+			cpu_clk = 20 * fbdiv * 1000 * 1000;
+		}
+		break;
+	}
+}
+
+void __init ralink_of_remap(void)
+{
+	rt_sysc_membase = plat_of_remap_node("mtk,mt7621-sysc");
+	rt_memc_membase = plat_of_remap_node("mtk,mt7621-memc");
+
+	if (!rt_sysc_membase || !rt_memc_membase)
+		panic("Failed to remap core resources");
+}
+
+void prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	void __iomem *sysc = (void __iomem *) KSEG1ADDR(MT7621_SYSC_BASE);
+	unsigned char *name = NULL;
+	u32 n0;
+	u32 n1;
+	u32 rev;
+
+	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
+
+	if (n0 == MT7621_CHIP_NAME0 && n1 == MT7621_CHIP_NAME1) {
+		name = "MT7621";
+		soc_info->compatible = "mtk,mt7621-soc";
+	} else {
+		panic("mt7621: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
+	}
+
+	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
+
+	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
+		"MediaTek %s ver:%u eco:%u",
+		name,
+		(rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK,
+		(rev & CHIP_REV_ECO_MASK));
+
+	soc_info->mem_size_min = MT7621_DDR2_SIZE_MIN;
+	soc_info->mem_size_max = MT7621_DDR2_SIZE_MAX;
+	soc_info->mem_base = MT7621_DRAM_BASE;
+
+	rt2880_pinmux_data = mt7621_pinmux_data;
+
+	/* Early detection of CMP support */
+	mips_cm_probe();
+	mips_cpc_probe();
+
+	if (mips_cm_numiocu()) {
+		/*
+		 * mips_cm_probe() wipes out bootloader
+		 * config for CM regions and we have to configure them
+		 * again. This SoC cannot talk to pamlbus devices
+		 * witout proper iocu region set up.
+		 *
+		 * FIXME: it would be better to do this with values
+		 * from DT, but we need this very early because
+		 * without this we cannot talk to pretty much anything
+		 * including serial.
+		 */
+		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
+		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
+				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+	}
+
+	if (!register_cps_smp_ops())
+		return;
+	if (!register_cmp_smp_ops())
+		return;
+	if (!register_vsmp_smp_ops())
+		return;
+}
diff --git a/arch/mips/ralink/timer-gic.c b/arch/mips/ralink/timer-gic.c
new file mode 100644
index 0000000..5b4f186
--- /dev/null
+++ b/arch/mips/ralink/timer-gic.c
@@ -0,0 +1,24 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Nikolay Martynov <mar.kolya@gmail.com>
+ * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
+#include "common.h"
+
+void __init plat_time_init(void)
+{
+	ralink_of_remap();
+
+	of_clk_init(NULL);
+	clocksource_probe();
+}
-- 
1.7.10.4
