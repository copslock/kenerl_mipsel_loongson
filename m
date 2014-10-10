Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 11:34:29 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:48907
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011065AbaJJJeMDMxuq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 11:34:12 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: ralink: add MT7621 support
Date:   Fri, 10 Oct 2014 11:34:05 +0200
Message-Id: <1412933645-55061-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412933645-55061-1-git-send-email-blogic@openwrt.org>
References: <1412933645-55061-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43197
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

This is the big APSoC made by mediatek. It is based on 1004k and has 2 cores
running at 800mhz. Each core has 2 VPEs. Unlike all the other SoCs from this
family, MT7621 has no wireless mac. It relies on pcie cards being present for
wifi.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7621.h |   39 ++++++
 arch/mips/ralink/Kconfig                   |   13 ++
 arch/mips/ralink/Makefile                  |    3 +
 arch/mips/ralink/Platform                  |    5 +
 arch/mips/ralink/malta-amon.c              |   72 +++++++++++
 arch/mips/ralink/mt7621.c                  |  186 ++++++++++++++++++++++++++++
 6 files changed, 318 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/mt7621.h
 create mode 100644 arch/mips/ralink/malta-amon.c
 create mode 100644 arch/mips/ralink/mt7621.c

diff --git a/arch/mips/include/asm/mach-ralink/mt7621.h b/arch/mips/include/asm/mach-ralink/mt7621.h
new file mode 100644
index 0000000..21c8dc2
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/mt7621.h
@@ -0,0 +1,39 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Parts of this file are based on Ralink's 2.6.21 BSP
+ *
+ * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _MT7621_REGS_H_
+#define _MT7621_REGS_H_
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
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index ca31156..4705678 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -34,6 +34,15 @@ choice
 	config SOC_MT7620
 		bool "MT7620/8"
 
+	config SOC_MT7621
+		bool "MT7621"
+		select MIPS_CPU_SCACHE
+		select SYS_SUPPORTS_MULTITHREADING
+		select SYS_SUPPORTS_SMP
+		select SYS_SUPPORTS_MIPS_CMP
+		select IRQ_GIC
+		select HW_HAS_PCI
+
 endchoice
 
 choice
@@ -65,6 +74,10 @@ choice
 		bool "MT7620A eval kit"
 		depends on SOC_MT7620
 
+	config DTB_MT7621_EVAL
+		bool "MT7621 eval kit"
+		depends on SOC_MT7621
+
 endchoice
 
 endif
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 7bf1b96..e4baf8e 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -19,6 +19,9 @@ obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
 obj-$(CONFIG_SOC_MT7620) += mt7620.o
+obj-$(CONFIG_SOC_MT7621) += mt7621.o
+
+obj-$(CONFIG_MIPS_MT_SMP) += malta-amon.o
 
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
diff --git a/arch/mips/ralink/malta-amon.c b/arch/mips/ralink/malta-amon.c
new file mode 100644
index 0000000..f5af18b
--- /dev/null
+++ b/arch/mips/ralink/malta-amon.c
@@ -0,0 +1,72 @@
+/*
+ *  Copyright (C) 2007  MIPS Technologies, Inc.
+ *	All rights reserved.
+
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  Arbitrary Monitor interface
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/addrspace.h>
+#include <asm/mips-boards/launch.h>
+#include <asm/mipsmtregs.h>
+
+int amon_cpu_avail(int cpu)
+{
+	struct cpulaunch *launch = (struct cpulaunch *)CKSEG0ADDR(CPULAUNCH);
+
+	if (cpu < 0 || cpu >= NCPULAUNCH) {
+		pr_debug("avail: cpu%d is out of range\n", cpu);
+		return 0;
+	}
+
+	launch += cpu;
+	if (!(launch->flags & LAUNCH_FREADY)) {
+		pr_debug("avail: cpu%d is not ready\n", cpu);
+		return 0;
+	}
+	if (launch->flags & (LAUNCH_FGO|LAUNCH_FGONE)) {
+		pr_debug("avail: too late.. cpu%d is already gone\n", cpu);
+		return 0;
+	}
+
+	return 1;
+}
+
+void amon_cpu_start(int cpu,
+		    unsigned long pc, unsigned long sp,
+		    unsigned long gp, unsigned long a0)
+{
+	volatile struct cpulaunch *launch =
+		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
+
+	if (!amon_cpu_avail(cpu))
+		return;
+	if (cpu == smp_processor_id()) {
+		pr_debug("launch: I am cpu%d!\n", cpu);
+		return;
+	}
+	launch += cpu;
+
+	pr_debug("launch: starting cpu%d\n", cpu);
+
+	launch->pc = pc;
+	launch->gp = gp;
+	launch->sp = sp;
+	launch->a0 = a0;
+
+	smp_wmb();		/* Target must see parameters before go */
+	launch->flags |= LAUNCH_FGO;
+	smp_wmb();		/* Target must see go before we poll  */
+
+	while ((launch->flags & LAUNCH_FGONE) == 0)
+		;
+	smp_rmb();	/* Target will be updating flags soon */
+	pr_debug("launch: cpu%d gone!\n", cpu);
+}
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
new file mode 100644
index 0000000..73cfda7
--- /dev/null
+++ b/arch/mips/ralink/mt7621.c
@@ -0,0 +1,186 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Parts of this file are based on Ralink's 2.6.21 BSP
+ *
+ * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/gcmpregs.h>
+
+#include <asm/mipsregs.h>
+#include <asm/smp-ops.h>
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
+#define MT7621_GPIO_MODE_UART2		3
+#define MT7621_GPIO_MODE_UART3		5
+#define MT7621_GPIO_MODE_JTAG		7
+#define MT7621_GPIO_MODE_WDT_MASK	0x3
+#define MT7621_GPIO_MODE_WDT_SHIFT	8
+#define MT7621_GPIO_MODE_WDT_GPIO	1
+#define MT7621_GPIO_MODE_PCIE_RST	0
+#define MT7621_GPIO_MODE_PCIE_REF	2
+#define MT7621_GPIO_MODE_PCIE_MASK	0x3
+#define MT7621_GPIO_MODE_PCIE_SHIFT	10
+#define MT7621_GPIO_MODE_PCIE_GPIO	1
+#define MT7621_GPIO_MODE_MDIO		12
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
+static struct rt2880_pmx_func uart3_grp[] = { FUNC("uart3", 0, 5, 4) };
+static struct rt2880_pmx_func uart2_grp[] = { FUNC("uart2", 0, 9, 4) };
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
+	FUNC("nand", 2, 34, 8),
+};
+static struct rt2880_pmx_func sdhci_grp[] = {
+	FUNC("sdhci", 0, 41, 8),
+	FUNC("nand", 2, 41, 8),
+};
+static struct rt2880_pmx_func rgmii1_grp[] = { FUNC("rgmii1", 0, 49, 12) };
+
+static struct rt2880_pmx_group mt7621_pinmux_data[] = {
+	GRP("uart1", uart1_grp, 1, MT7621_GPIO_MODE_UART1),
+	GRP("i2c", i2c_grp, 1, MT7621_GPIO_MODE_I2C),
+	GRP("uart3", uart2_grp, 1, MT7621_GPIO_MODE_UART2),
+	GRP("uart2", uart3_grp, 1, MT7621_GPIO_MODE_UART3),
+	GRP("jtag", jtag_grp, 1, MT7621_GPIO_MODE_JTAG),
+	GRP_G("wdt", wdt_grp, MT7621_GPIO_MODE_WDT_MASK,
+		MT7621_GPIO_MODE_WDT_GPIO, MT7621_GPIO_MODE_WDT_SHIFT),
+	GRP_G("pcie", pcie_rst_grp, MT7621_GPIO_MODE_PCIE_MASK,
+		MT7621_GPIO_MODE_PCIE_GPIO, MT7621_GPIO_MODE_PCIE_SHIFT),
+	GRP("mdio", mdio_grp, 1, MT7621_GPIO_MODE_MDIO),
+	GRP("rgmii2", rgmii2_grp, 1, MT7621_GPIO_MODE_RGMII2),
+	GRP_G("spi", spi_grp, MT7621_GPIO_MODE_SPI_MASK,
+		MT7621_GPIO_MODE_SPI_GPIO, MT7621_GPIO_MODE_SPI_SHIFT),
+	GRP_G("sdhci", sdhci_grp, MT7621_GPIO_MODE_SDHCI_MASK,
+		MT7621_GPIO_MODE_SDHCI_GPIO, MT7621_GPIO_MODE_SDHCI_SHIFT),
+	GRP("rgmii1", rgmii1_grp, 1, MT7621_GPIO_MODE_RGMII1),
+	{ 0 }
+};
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
+	cpu_clk = 880000000;
+	ralink_clk_add("cpu", cpu_clk);
+	ralink_clk_add("1e000b00.spi", 50000000);
+	ralink_clk_add("1e000c00.uartlite", 50000000);
+	ralink_clk_add("1e000d00.uart", 50000000);
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
+		"Mediatek %s ver:%u eco:%u",
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
+	if (register_cmp_smp_ops())
+		panic("failed to register_vsmp_smp_ops()");
+}
-- 
1.7.10.4
