Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:19:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55618 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823690Ab3DMJT6IsRMN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:19:58 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 11/14] MIPS: ralink: adds support for RT2880 SoC family
Date:   Sat, 13 Apr 2013 10:48:22 +0200
Message-Id: <1365842905-10906-11-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
References: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36138
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

Add support code for rt2880 SOC.

The code detects the SoC and registers the clk / pinmux settings.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig                          |    2 +-
 arch/mips/include/asm/mach-ralink/rt288x.h |   49 ++++++++++
 arch/mips/ralink/Kconfig                   |    3 +
 arch/mips/ralink/Makefile                  |    1 +
 arch/mips/ralink/Platform                  |    5 +
 arch/mips/ralink/rt288x.c                  |  139 ++++++++++++++++++++++++++++
 6 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-ralink/rt288x.h
 create mode 100644 arch/mips/ralink/rt288x.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 27a4bfa..c1997db 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1144,7 +1144,7 @@ config BOOT_ELF32
 
 config MIPS_L1_CACHE_SHIFT
 	int
-	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL
+	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || SOC_RT288X
 	default "6" if MIPS_CPU_SCACHE
 	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
 	default "5"
diff --git a/arch/mips/include/asm/mach-ralink/rt288x.h b/arch/mips/include/asm/mach-ralink/rt288x.h
new file mode 100644
index 0000000..ad8b42d
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/rt288x.h
@@ -0,0 +1,49 @@
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
+#ifndef _RT288X_REGS_H_
+#define _RT288X_REGS_H_
+
+#define RT2880_SYSC_BASE		0x00300000
+
+#define SYSC_REG_CHIP_NAME0		0x00
+#define SYSC_REG_CHIP_NAME1		0x04
+#define SYSC_REG_CHIP_ID		0x0c
+#define SYSC_REG_SYSTEM_CONFIG		0x10
+#define SYSC_REG_CLKCFG			0x30
+
+#define RT2880_CHIP_NAME0		0x38325452
+#define RT2880_CHIP_NAME1		0x20203038
+
+#define CHIP_ID_ID_MASK			0xff
+#define CHIP_ID_ID_SHIFT		8
+#define CHIP_ID_REV_MASK		0xff
+
+#define SYSTEM_CONFIG_CPUCLK_SHIFT	20
+#define SYSTEM_CONFIG_CPUCLK_MASK	0x3
+#define SYSTEM_CONFIG_CPUCLK_250	0x0
+#define SYSTEM_CONFIG_CPUCLK_266	0x1
+#define SYSTEM_CONFIG_CPUCLK_280	0x2
+#define SYSTEM_CONFIG_CPUCLK_300	0x3
+
+#define RT2880_GPIO_MODE_I2C		BIT(0)
+#define RT2880_GPIO_MODE_UART0		BIT(1)
+#define RT2880_GPIO_MODE_SPI		BIT(2)
+#define RT2880_GPIO_MODE_UART1		BIT(3)
+#define RT2880_GPIO_MODE_JTAG		BIT(4)
+#define RT2880_GPIO_MODE_MDIO		BIT(5)
+#define RT2880_GPIO_MODE_SDRAM		BIT(6)
+#define RT2880_GPIO_MODE_PCI		BIT(7)
+
+#define CLKCFG_SRAM_CS_N_WDT		BIT(9)
+
+#endif
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index a0b0197..6723b94 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -6,6 +6,9 @@ choice
 	help
 	  Select Ralink MIPS SoC type.
 
+	config SOC_RT288X
+		bool "RT288x"
+
 	config SOC_RT305X
 		bool "RT305x"
 		select USB_ARCH_HAS_HCD
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 939757f..6d826f2 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -8,6 +8,7 @@
 
 obj-y := prom.o of.o reset.o clk.o irq.o
 
+obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index 6babd65..3f49e51 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -5,6 +5,11 @@ core-$(CONFIG_RALINK)		+= arch/mips/ralink/
 cflags-$(CONFIG_RALINK)		+= -I$(srctree)/arch/mips/include/asm/mach-ralink
 
 #
+# Ralink RT288x
+#
+load-$(CONFIG_SOC_RT288X)	+= 0xffffffff88000000
+
+#
 # Ralink RT305x
 #
 load-$(CONFIG_SOC_RT305X)	+= 0xffffffff80000000
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
new file mode 100644
index 0000000..1e0788e
--- /dev/null
+++ b/arch/mips/ralink/rt288x.c
@@ -0,0 +1,139 @@
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
+
+#include <asm/mipsregs.h>
+#include <asm/mach-ralink/ralink_regs.h>
+#include <asm/mach-ralink/rt288x.h>
+
+#include "common.h"
+
+static struct ralink_pinmux_grp mode_mux[] = {
+	{
+		.name = "i2c",
+		.mask = RT2880_GPIO_MODE_I2C,
+		.gpio_first = 1,
+		.gpio_last = 2,
+	}, {
+		.name = "spi",
+		.mask = RT2880_GPIO_MODE_SPI,
+		.gpio_first = 3,
+		.gpio_last = 6,
+	}, {
+		.name = "uartlite",
+		.mask = RT2880_GPIO_MODE_UART0,
+		.gpio_first = 7,
+		.gpio_last = 14,
+	}, {
+		.name = "jtag",
+		.mask = RT2880_GPIO_MODE_JTAG,
+		.gpio_first = 17,
+		.gpio_last = 21,
+	}, {
+		.name = "mdio",
+		.mask = RT2880_GPIO_MODE_MDIO,
+		.gpio_first = 22,
+		.gpio_last = 23,
+	}, {
+		.name = "sdram",
+		.mask = RT2880_GPIO_MODE_SDRAM,
+		.gpio_first = 24,
+		.gpio_last = 39,
+	}, {
+		.name = "pci",
+		.mask = RT2880_GPIO_MODE_PCI,
+		.gpio_first = 40,
+		.gpio_last = 71,
+	}, {0}
+};
+
+static void rt288x_wdt_reset(void)
+{
+	u32 t;
+
+	/* enable WDT reset output on pin SRAM_CS_N */
+	t = rt_sysc_r32(SYSC_REG_CLKCFG);
+	t |= CLKCFG_SRAM_CS_N_WDT;
+	rt_sysc_w32(t, SYSC_REG_CLKCFG);
+}
+
+struct ralink_pinmux rt_gpio_pinmux = {
+	.mode = mode_mux,
+	.wdt_reset = rt288x_wdt_reset,
+};
+
+void __init ralink_clk_init(void)
+{
+	unsigned long cpu_rate;
+	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
+	t = ((t >> SYSTEM_CONFIG_CPUCLK_SHIFT) & SYSTEM_CONFIG_CPUCLK_MASK);
+
+	switch (t) {
+	case SYSTEM_CONFIG_CPUCLK_250:
+		cpu_rate = 250000000;
+		break;
+	case SYSTEM_CONFIG_CPUCLK_266:
+		cpu_rate = 266666667;
+		break;
+	case SYSTEM_CONFIG_CPUCLK_280:
+		cpu_rate = 280000000;
+		break;
+	case SYSTEM_CONFIG_CPUCLK_300:
+		cpu_rate = 300000000;
+		break;
+	}
+
+	ralink_clk_add("cpu", cpu_rate);
+	ralink_clk_add("300100.timer", cpu_rate / 2);
+	ralink_clk_add("300120.watchdog", cpu_rate / 2);
+	ralink_clk_add("300500.uart", cpu_rate / 2);
+	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
+	ralink_clk_add("400000.ethernet", cpu_rate / 2);
+}
+
+void __init ralink_of_remap(void)
+{
+	rt_sysc_membase = plat_of_remap_node("ralink,rt2880-sysc");
+	rt_memc_membase = plat_of_remap_node("ralink,rt2880-memc");
+
+	if (!rt_sysc_membase || !rt_memc_membase)
+		panic("Failed to remap core resources");
+}
+
+void prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT2880_SYSC_BASE);
+	const char *name;
+	u32 n0;
+	u32 n1;
+	u32 id;
+
+	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
+	id = __raw_readl(sysc + SYSC_REG_CHIP_ID);
+
+	if (n0 == RT2880_CHIP_NAME0 && n1 == RT2880_CHIP_NAME1) {
+		soc_info->compatible = "ralink,r2880-soc";
+		name = "RT2880";
+	} else {
+		panic("rt288x: unknown SoC, n0:%08x n1:%08x", n0, n1);
+	}
+
+	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
+		"Ralink %s id:%u rev:%u",
+		name,
+		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
+		(id & CHIP_ID_REV_MASK));
+}
-- 
1.7.10.4
