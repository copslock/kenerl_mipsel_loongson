Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 14:19:19 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43119 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823068Ab3DJMTFX7WgO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 14:19:05 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 14/18] MIPS: ralink: adds support for MT7620 SoC family
Date:   Wed, 10 Apr 2013 13:47:23 +0200
Message-Id: <1365594447-13068-15-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36049
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

Add support code for mt7620 SOC.

The code detects the SoC and registers the clk / pinmux settings.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |   66 +++++++++
 arch/mips/ralink/Kconfig                   |    3 +
 arch/mips/ralink/Makefile                  |    1 +
 arch/mips/ralink/Platform                  |    5 +
 arch/mips/ralink/mt7620.c                  |  209 ++++++++++++++++++++++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/mt7620.h
 create mode 100644 arch/mips/ralink/mt7620.c

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
new file mode 100644
index 0000000..3d51235
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -0,0 +1,66 @@
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
+#ifndef _MT7620_REGS_H_
+#define _MT7620_REGS_H_
+
+#define MT7620_SYSC_BASE		0x10000000
+
+#define SYSC_REG_CHIP_NAME0		0x00
+#define SYSC_REG_CHIP_NAME1		0x04
+#define SYSC_REG_CHIP_REV		0x0c
+#define SYSC_REG_SYSTEM_CONFIG0		0x10
+#define SYSC_REG_SYSTEM_CONFIG1		0x14
+#define SYSC_REG_CPLL_CONFIG0		0x54
+#define SYSC_REG_CPLL_CONFIG1		0x58
+
+#define MT7620N_CHIP_NAME0		0x33365452
+#define MT7620N_CHIP_NAME1		0x20203235
+
+#define MT7620A_CHIP_NAME0		0x3637544d
+#define MT7620A_CHIP_NAME1		0x20203032
+
+#define CHIP_REV_PKG_MASK		0x1
+#define CHIP_REV_PKG_SHIFT		16
+#define CHIP_REV_VER_MASK		0xf
+#define CHIP_REV_VER_SHIFT		8
+#define CHIP_REV_ECO_MASK		0xf
+
+#define MT7620_CPLL_SW_CONFIG_SHIFT	31
+#define MT7620_CPLL_SW_CONFIG_MASK	0x1
+#define MT7620_CPLL_CPU_CLK_SHIFT	24
+#define MT7620_CPLL_CPU_CLK_MASK	0x1
+
+#define MT7620_GPIO_MODE_I2C		BIT(0)
+#define MT7620_GPIO_MODE_UART0_SHIFT	2
+#define MT7620_GPIO_MODE_UART0_MASK	0x7
+#define MT7620_GPIO_MODE_UART0(x)	((x) << MT7620_GPIO_MODE_UART0_SHIFT)
+#define MT7620_GPIO_MODE_UARTF		0x0
+#define MT7620_GPIO_MODE_PCM_UARTF	0x1
+#define MT7620_GPIO_MODE_PCM_I2S	0x2
+#define MT7620_GPIO_MODE_I2S_UARTF	0x3
+#define MT7620_GPIO_MODE_PCM_GPIO	0x4
+#define MT7620_GPIO_MODE_GPIO_UARTF	0x5
+#define MT7620_GPIO_MODE_GPIO_I2S	0x6
+#define MT7620_GPIO_MODE_GPIO		0x7
+#define MT7620_GPIO_MODE_UART1		BIT(5)
+#define MT7620_GPIO_MODE_MDIO		BIT(8)
+#define MT7620_GPIO_MODE_RGMII1		BIT(9)
+#define MT7620_GPIO_MODE_RGMII2		BIT(10)
+#define MT7620_GPIO_MODE_SPI		BIT(11)
+#define MT7620_GPIO_MODE_SPI_REF_CLK	BIT(12)
+#define MT7620_GPIO_MODE_WLED		BIT(13)
+#define MT7620_GPIO_MODE_JTAG		BIT(15)
+#define MT7620_GPIO_MODE_EPHY		BIT(15)
+#define MT7620_GPIO_MODE_WDT		BIT(22)
+
+#endif
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 2ef69ee..493411f 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -20,6 +20,9 @@ choice
 		select USB_ARCH_HAS_OHCI
 		select USB_ARCH_HAS_EHCI
 
+	config SOC_MT7620
+		bool "MT7620"
+
 endchoice
 
 choice
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 87f6ca9..341b4de 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -11,6 +11,7 @@ obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
+obj-$(CONFIG_SOC_MT7620) += mt7620.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index f67c08d..b2cbf16 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -18,3 +18,8 @@ load-$(CONFIG_SOC_RT305X)	+= 0xffffffff80000000
 # Ralink RT3883
 #
 load-$(CONFIG_SOC_RT3883)	+= 0xffffffff80000000
+
+#
+# Ralink MT7620
+#
+load-$(CONFIG_SOC_MT7620)	+= 0xffffffff80000000
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
new file mode 100644
index 0000000..e7a0e60
--- /dev/null
+++ b/arch/mips/ralink/mt7620.c
@@ -0,0 +1,209 @@
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
+#include <asm/mach-ralink/mt7620.h>
+
+#include "common.h"
+
+
+struct ralink_pinmux_grp mode_mux[] = {
+	{
+		.name = "i2c",
+		.mask = MT7620_GPIO_MODE_I2C,
+		.gpio_first = 1,
+		.gpio_last = 2,
+	}, {
+		.name = "spi",
+		.mask = MT7620_GPIO_MODE_SPI,
+		.gpio_first = 3,
+		.gpio_last = 6,
+	}, {
+		.name = "uartlite",
+		.mask = MT7620_GPIO_MODE_UART1,
+		.gpio_first = 15,
+		.gpio_last = 16,
+	}, {
+		.name = "wdt",
+		.mask = MT7620_GPIO_MODE_WDT,
+		.gpio_first = 17,
+		.gpio_last = 17,
+	}, {
+		.name = "mdio",
+		.mask = MT7620_GPIO_MODE_MDIO,
+		.gpio_first = 22,
+		.gpio_last = 23,
+	}, {
+		.name = "rgmii1",
+		.mask = MT7620_GPIO_MODE_RGMII1,
+		.gpio_first = 24,
+		.gpio_last = 35,
+	}, {
+		.name = "spi refclk",
+		.mask = MT7620_GPIO_MODE_SPI_REF_CLK,
+		.gpio_first = 37,
+		.gpio_last = 39,
+	}, {
+		.name = "jtag",
+		.mask = MT7620_GPIO_MODE_JTAG,
+		.gpio_first = 40,
+		.gpio_last = 44,
+	}, {
+		/* shared lines with jtag */
+		.name = "ephy",
+		.mask = MT7620_GPIO_MODE_EPHY,
+		.gpio_first = 40,
+		.gpio_last = 44,
+	}, {
+		.name = "nand",
+		.mask = MT7620_GPIO_MODE_JTAG,
+		.gpio_first = 45,
+		.gpio_last = 59,
+	}, {
+		.name = "rgmii2",
+		.mask = MT7620_GPIO_MODE_RGMII2,
+		.gpio_first = 60,
+		.gpio_last = 71,
+	}, {
+		.name = "wled",
+		.mask = MT7620_GPIO_MODE_WLED,
+		.gpio_first = 72,
+		.gpio_last = 72,
+	}, {0}
+};
+
+
+struct ralink_pinmux_grp uart_mux[] = {
+	{
+		.name = "uartf",
+		.mask = MT7620_GPIO_MODE_UARTF,
+		.gpio_first = 7,
+		.gpio_last = 14,
+	}, {
+		.name = "pcm uartf",
+		.mask = MT7620_GPIO_MODE_PCM_UARTF,
+		.gpio_first = 7,
+		.gpio_last = 14,
+	}, {
+		.name = "pcm i2s",
+		.mask = MT7620_GPIO_MODE_PCM_I2S,
+		.gpio_first = 7,
+		.gpio_last = 14,
+	}, {
+		.name = "i2s uartf",
+		.mask = MT7620_GPIO_MODE_I2S_UARTF,
+		.gpio_first = 7,
+		.gpio_last = 14,
+	}, {
+		.name = "pcm gpio",
+		.mask = MT7620_GPIO_MODE_PCM_GPIO,
+		.gpio_first = 11,
+		.gpio_last = 14,
+	}, {
+		.name = "gpio uartf",
+		.mask = MT7620_GPIO_MODE_GPIO_UARTF,
+		.gpio_first = 7,
+		.gpio_last = 10,
+	}, {
+		.name = "gpio i2s",
+		.mask = MT7620_GPIO_MODE_GPIO_I2S,
+		.gpio_first = 7,
+		.gpio_last = 10,
+	}, {
+		.name = "gpio",
+		.mask = MT7620_GPIO_MODE_GPIO,
+	}, {0}
+};
+
+void mt7620_wdt_reset(void)
+{
+}
+
+struct ralink_pinmux rt_pinmux = {
+	.mode = mode_mux,
+	.uart = uart_mux,
+	.uart_shift = MT7620_GPIO_MODE_UART0_SHIFT,
+	.wdt_reset = mt7620_wdt_reset,
+};
+
+void __init ralink_clk_init(void)
+{
+	unsigned long cpu_rate, sys_rate;
+	u32 c0 = rt_sysc_r32(SYSC_REG_CPLL_CONFIG0);
+	u32 c1 = rt_sysc_r32(SYSC_REG_CPLL_CONFIG1);
+
+	c0 = (c0 >> MT7620_CPLL_SW_CONFIG_SHIFT) &
+		MT7620_CPLL_SW_CONFIG_MASK;
+	c1 = (c1 >> MT7620_CPLL_CPU_CLK_SHIFT) &
+	     MT7620_CPLL_CPU_CLK_MASK;
+	if (c1 == 0x01) {
+		cpu_rate = 480000000;
+	} else {
+		if (c1 == 0x0) {
+			cpu_rate = 600000000;
+		} else {
+			/* TODO calculate custom clock from pll settings */
+			BUG();
+		}
+	}
+	/* FIXME  SDR - 4, DDR - 3 */
+	sys_rate = cpu_rate / 4;
+
+	ralink_clk_add("cpu", cpu_rate);
+	ralink_clk_add("10000100.timer", 40000000);
+	ralink_clk_add("10000500.uart", 40000000);
+	ralink_clk_add("10000c00.uartlite", 40000000);
+}
+
+void __init ralink_of_remap(void)
+{
+	rt_sysc_membase = plat_of_remap_node("ralink,mt7620-sysc");
+	rt_memc_membase = plat_of_remap_node("ralink,mt7620-memc");
+
+	if (!rt_sysc_membase || !rt_memc_membase)
+		panic("Failed to remap core resources");
+}
+
+void prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	void __iomem *sysc = (void __iomem *) KSEG1ADDR(MT7620_SYSC_BASE);
+	unsigned char *name = NULL;
+	u32 n0;
+	u32 n1;
+	u32 rev;
+
+	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
+
+	if (n0 == MT7620N_CHIP_NAME0 && n1 == MT7620N_CHIP_NAME1) {
+		name = "MT7620N";
+		soc_info->compatible = "ralink,mt7620n-soc";
+	} else if (n0 == MT7620A_CHIP_NAME0 && n1 == MT7620A_CHIP_NAME1) {
+		name = "MT7620A";
+		soc_info->compatible = "ralink,mt7620a-soc";
+	} else {
+		panic("mt7620: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
+	}
+
+	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
+
+	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
+		"Ralink %s ver:%u eco:%u",
+		name,
+		(rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK,
+		(rev & CHIP_REV_ECO_MASK));
+}
-- 
1.7.10.4
