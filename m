Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 20:56:29 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:35665 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490979Ab1AETzd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jan 2011 20:55:33 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 02/10] MIPS: lantiq: add SoC specific code for XWAY family
Date:   Wed,  5 Jan 2011 20:56:11 +0100
Message-Id: <1294257379-417-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1294257379-417-1-git-send-email-blogic@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Add support for the Lantiq XWAY family of Mips24KEc SoCs.

* Danube (PSB50702)
* Twinpass (PSB4000)
* AR9 (PSB50802)
* Amazon SE (PSB5061)

The Amazon SE is a lightweight SoC and has no PCI as well as a different
clock. We split the code out into seperate files to handle this.

The GPIO pins on the SoCs are multi function and there are several bits
we can use to configure the pins. To be as compatible as possible to
GPIOLIB we add a function

int lq_gpio_request(unsigned int pin, unsigned int alt0,
	unsigned int alt1, unsigned int dir, const char *name);

which lets you configure the 2 "alternate function" bits. This way drivers like
PCI can make use of GPIOLIB without a cubersome wrapper.

The pll code inside arch/mips/lantiq/xway/clk-xway.c is voodoo to me. It was
taken from a 2.4.20 source tree and was never really changed by me since then.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig                                  |    1 +
 arch/mips/include/asm/mach-lantiq/xway/irq.h       |   18 ++
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |   62 ++++++
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  119 +++++++++++
 arch/mips/lantiq/Kconfig                           |   21 ++
 arch/mips/lantiq/Makefile                          |    2 +
 arch/mips/lantiq/Platform                          |    1 +
 arch/mips/lantiq/xway/Makefile                     |    4 +
 arch/mips/lantiq/xway/clk-ase.c                    |   53 +++++
 arch/mips/lantiq/xway/clk-xway.c                   |  221 ++++++++++++++++++++
 arch/mips/lantiq/xway/gpio.c                       |  205 ++++++++++++++++++
 arch/mips/lantiq/xway/pmu.c                        |   36 ++++
 arch/mips/lantiq/xway/prom-ase.c                   |   41 ++++
 arch/mips/lantiq/xway/prom-xway.c                  |   56 +++++
 arch/mips/lantiq/xway/reset.c                      |   53 +++++
 15 files changed, 893 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
 create mode 100644 arch/mips/lantiq/Kconfig
 create mode 100644 arch/mips/lantiq/xway/Makefile
 create mode 100644 arch/mips/lantiq/xway/clk-ase.c
 create mode 100644 arch/mips/lantiq/xway/clk-xway.c
 create mode 100644 arch/mips/lantiq/xway/gpio.c
 create mode 100644 arch/mips/lantiq/xway/pmu.c
 create mode 100644 arch/mips/lantiq/xway/prom-ase.c
 create mode 100644 arch/mips/lantiq/xway/prom-xway.c
 create mode 100644 arch/mips/lantiq/xway/reset.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a2396f1..9d3fd89 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -736,6 +736,7 @@ source "arch/mips/alchemy/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
+source "arch/mips/lantiq/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
 source "arch/mips/powertv/Kconfig"
diff --git a/arch/mips/include/asm/mach-lantiq/xway/irq.h b/arch/mips/include/asm/mach-lantiq/xway/irq.h
new file mode 100644
index 0000000..a1471d2
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/xway/irq.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef __LANTIQ_IRQ_H
+#define __LANTIQ_IRQ_H
+
+#include <lantiq_irq.h>
+
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
new file mode 100644
index 0000000..2d29e77
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -0,0 +1,62 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LANTIQ_XWAY_IRQ_H__
+#define _LANTIQ_XWAY_IRQ_H__
+
+#define INT_NUM_IRQ0			8
+#define INT_NUM_IM0_IRL0		(INT_NUM_IRQ0 + 0)
+#define INT_NUM_IM1_IRL0		(INT_NUM_IRQ0 + 32)
+#define INT_NUM_IM2_IRL0		(INT_NUM_IRQ0 + 64)
+#define INT_NUM_IM3_IRL0		(INT_NUM_IRQ0 + 96)
+#define INT_NUM_IM4_IRL0		(INT_NUM_IRQ0 + 128)
+#define INT_NUM_IM_OFFSET		(INT_NUM_IM1_IRL0 - INT_NUM_IM0_IRL0)
+
+#define LTQ_ASC_TIR(x)			(INT_NUM_IM3_IRL0 + (x * 8))
+#define LTQ_ASC_RIR(x)			(INT_NUM_IM3_IRL0 + (x * 8) + 1)
+#define LTQ_ASC_EIR(x)			(INT_NUM_IM3_IRL0 + (x * 8) + 2)
+
+#define LTQ_SSC_TIR				(INT_NUM_IM0_IRL0 + 15)
+#define LTQ_SSC_RIR				(INT_NUM_IM0_IRL0 + 14)
+#define LTQ_SSC_EIR				(INT_NUM_IM0_IRL0 + 16)
+
+#define LTQ_MEI_DYING_GASP_INT	(INT_NUM_IM1_IRL0 + 21)
+#define LTQ_MEI_INT				(INT_NUM_IM1_IRL0 + 23)
+
+#define LTQ_TIMER6_INT			(INT_NUM_IM1_IRL0 + 23)
+#define LTQ_USB_INT				(INT_NUM_IM1_IRL0 + 22)
+#define LTQ_USB_OC_INT			(INT_NUM_IM4_IRL0 + 23)
+
+#define MIPS_CPU_TIMER_IRQ		7
+
+#define LTQ_DMA_CH0_INT			(INT_NUM_IM2_IRL0)
+#define LTQ_DMA_CH1_INT			(INT_NUM_IM2_IRL0 + 1)
+#define LTQ_DMA_CH2_INT			(INT_NUM_IM2_IRL0 + 2)
+#define LTQ_DMA_CH3_INT			(INT_NUM_IM2_IRL0 + 3)
+#define LTQ_DMA_CH4_INT			(INT_NUM_IM2_IRL0 + 4)
+#define LTQ_DMA_CH5_INT			(INT_NUM_IM2_IRL0 + 5)
+#define LTQ_DMA_CH6_INT			(INT_NUM_IM2_IRL0 + 6)
+#define LTQ_DMA_CH7_INT			(INT_NUM_IM2_IRL0 + 7)
+#define LTQ_DMA_CH8_INT			(INT_NUM_IM2_IRL0 + 8)
+#define LTQ_DMA_CH9_INT			(INT_NUM_IM2_IRL0 + 9)
+#define LTQ_DMA_CH10_INT			(INT_NUM_IM2_IRL0 + 10)
+#define LTQ_DMA_CH11_INT			(INT_NUM_IM2_IRL0 + 11)
+#define LTQ_DMA_CH12_INT			(INT_NUM_IM2_IRL0 + 25)
+#define LTQ_DMA_CH13_INT			(INT_NUM_IM2_IRL0 + 26)
+#define LTQ_DMA_CH14_INT			(INT_NUM_IM2_IRL0 + 27)
+#define LTQ_DMA_CH15_INT			(INT_NUM_IM2_IRL0 + 28)
+#define LTQ_DMA_CH16_INT			(INT_NUM_IM2_IRL0 + 29)
+#define LTQ_DMA_CH17_INT			(INT_NUM_IM2_IRL0 + 30)
+#define LTQ_DMA_CH18_INT			(INT_NUM_IM2_IRL0 + 16)
+#define LTQ_DMA_CH19_INT			(INT_NUM_IM2_IRL0 + 21)
+
+#define LTQ_PPE_MBOX_INT			(INT_NUM_IM2_IRL0 + 24)
+
+#define INT_NUM_IM4_IRL14		(INT_NUM_IM4_IRL0 + 14)
+
+#endif
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
new file mode 100644
index 0000000..74beeb7
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -0,0 +1,119 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifdef CONFIG_SOC_TYPE_XWAY
+
+#ifndef _LTQ_XWAY_H__
+#define _LTQ_XWAY_H__
+
+#include <lantiq.h>
+
+/* request a non-gpio and set the PIO config */
+extern int  ltq_gpio_request(unsigned int pin, unsigned int alt0,
+	unsigned int alt1, unsigned int dir, const char *name);
+extern int ltq_gpio_setconfig(unsigned int pin,
+	unsigned int reg, unsigned int val);
+
+extern void ltq_pmu_enable(unsigned int module);
+extern void ltq_pmu_disable(unsigned int module);
+
+/*------------ Chip IDs */
+#define SOC_ID_DANUBE1		0x129
+#define SOC_ID_DANUBE2		0x12B
+#define SOC_ID_TWINPASS		0x12D
+#define SOC_ID_AMAZON_SE	0x152
+#define SOC_ID_ARX188		0x16C
+#define SOC_ID_ARX168		0x16D
+#define SOC_ID_ARX182		0x16F
+
+/*------------ SoC Types */
+#define SOC_TYPE_DANUBE		0x01
+#define SOC_TYPE_TWINPASS	0x02
+#define SOC_TYPE_AR9		0x03
+#define SOC_TYPE_AMAZON_SE	0x04
+
+/*------------ ASC0/1 */
+#define LTQ_ASC0_BASE		0x1E100400
+#define LTQ_ASC1_BASE		0x1E100C00
+#define LTQ_ASC_SIZE			0x400
+
+/*------------ RCU */
+#define LTQ_RCU_BASE_ADDR	0xBF203000
+
+/*------------ GPTU */
+#define LTQ_GPTU_BASE_ADDR	0xB8000300
+
+/*------------ EBU */
+#define LTQ_EBU_GPIO_START	0x14000000
+#define LTQ_EBU_GPIO_SIZE	0x1000
+
+#define LTQ_EBU_BASE_ADDR	0xBE105300
+
+#define LTQ_EBU_BUSCON0		((u32 *)(LTQ_EBU_BASE_ADDR + 0x0060))
+#define LTQ_EBU_PCC_CON		((u32 *)(LTQ_EBU_BASE_ADDR + 0x0090))
+#define LTQ_EBU_PCC_IEN		((u32 *)(LTQ_EBU_BASE_ADDR + 0x00A4))
+#define LTQ_EBU_PCC_ISTAT	((u32 *)(LTQ_EBU_BASE_ADDR + 0x00A0))
+#define LTQ_EBU_BUSCON1		((u32 *)(LTQ_EBU_BASE_ADDR + 0x0064))
+#define LTQ_EBU_ADDRSEL1		((u32 *)(LTQ_EBU_BASE_ADDR + 0x0024))
+
+#define EBU_WRDIS			0x80000000
+
+/*------------ CGU */
+#define LTQ_CGU_BASE_ADDR	(KSEG1 + 0x1F103000)
+
+/*------------ PMU */
+#define LTQ_PMU_BASE_ADDR	(KSEG1 + 0x1F102000)
+
+#define PMU_DMA				0x0020
+#define PMU_USB				0x8041
+#define PMU_LED				0x0800
+#define PMU_GPT				0x1000
+#define PMU_PPE				0x2000
+#define PMU_FPI				0x4000
+#define PMU_SWITCH			0x10000000
+
+/*------------ ETOP */
+#define LTQ_PPE32_BASE_ADDR	0xBE180000
+#define LTQ_PPE32_SIZE		0x40000
+
+/*------------ DMA */
+#define LTQ_DMA_BASE_ADDR	0xBE104100
+
+/*------------ PCI */
+#define PCI_CR_BASE_ADDR	(KSEG1 + 0x1E105400)
+#define PCI_CS_BASE_ADDR	(KSEG1 + 0x17000000)
+
+/*------------ WDT */
+#define LTQ_WDT_BASE			0x1F880000
+#define LTQ_WDT_SIZE			0x400
+
+/*------------ Serial To Parallel conversion  */
+#define LTQ_STP_BASE			0x1E100BB0
+#define LTQ_STP_SIZE			0x40
+
+/*------------ GPIO */
+#define LTQ_GPIO0_BASE_ADDR	0x1E100B10
+#define LTQ_GPIO1_BASE_ADDR	0x1E100B40
+#define LTQ_GPIO_SIZE		0x30
+
+/*------------ SSC */
+#define LTQ_SSC_BASE_ADDR	(KSEG1 + 0x1e100800)
+
+/*------------ MEI */
+#define LTQ_MEI_BASE_ADDR	(KSEG1 + 0x1E116000)
+
+/*------------ DEU */
+#define LTQ_DEU_BASE			(KSEG1 + 0x1E103100)
+
+/*------------ MPS */
+#define LTQ_MPS_BASE_ADDR	(KSEG1 + 0x1F107000)
+#define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
+
+#endif
+
+#endif
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
new file mode 100644
index 0000000..2780461
--- /dev/null
+++ b/arch/mips/lantiq/Kconfig
@@ -0,0 +1,21 @@
+if LANTIQ
+
+config SOC_TYPE_XWAY
+	bool
+	default n
+
+choice
+	prompt "SoC Type"
+	default SOC_XWAY
+
+config SOC_AMAZON_SE
+	bool "Amazon SE"
+	select SOC_TYPE_XWAY
+
+config SOC_XWAY
+	bool "XWAY"
+	select SOC_TYPE_XWAY
+	select HW_HAS_PCI
+endchoice
+
+endif
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index 6a30de6..a268391 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -7,3 +7,5 @@
 obj-y := irq.o setup.o clk.o prom.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+
+obj-$(CONFIG_SOC_TYPE_XWAY) += xway/
diff --git a/arch/mips/lantiq/Platform b/arch/mips/lantiq/Platform
index eef587f..f3dff05 100644
--- a/arch/mips/lantiq/Platform
+++ b/arch/mips/lantiq/Platform
@@ -5,3 +5,4 @@
 platform-$(CONFIG_LANTIQ)	+= lantiq/
 cflags-$(CONFIG_LANTIQ)		+= -I$(srctree)/arch/mips/include/asm/mach-lantiq
 load-$(CONFIG_LANTIQ)		= 0xffffffff80002000
+cflags-$(CONFIG_SOC_TYPE_XWAY)	+= -I$(srctree)/arch/mips/include/asm/mach-lantiq/xway
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
new file mode 100644
index 0000000..64730d5
--- /dev/null
+++ b/arch/mips/lantiq/xway/Makefile
@@ -0,0 +1,4 @@
+obj-y := pmu.o reset.o gpio.o
+
+obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
+obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
diff --git a/arch/mips/lantiq/xway/clk-ase.c b/arch/mips/lantiq/xway/clk-ase.c
new file mode 100644
index 0000000..ecc3b7c
--- /dev/null
+++ b/arch/mips/lantiq/xway/clk-ase.c
@@ -0,0 +1,53 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+
+#include <asm/time.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+
+#include <lantiq_soc.h>
+
+#define LTQ_CGU_SYS			((u32 *)(LTQ_CGU_BASE_ADDR + 0x0010))
+
+unsigned int
+ltq_get_io_region_clock(void)
+{
+	return CLOCK_133M;
+}
+EXPORT_SYMBOL(ltq_get_io_region_clock);
+
+unsigned int
+ltq_get_fpi_bus_clock(int fpi)
+{
+	return CLOCK_133M;
+}
+EXPORT_SYMBOL(ltq_get_fpi_bus_clock);
+
+unsigned int
+ltq_get_cpu_hz(void)
+{
+	if (ltq_r32(LTQ_CGU_SYS) & (1 << 5))
+		return CLOCK_266M;
+	else
+		return CLOCK_133M;
+}
+EXPORT_SYMBOL(ltq_get_cpu_hz);
+
+unsigned int
+ltq_get_fpi_hz(void)
+{
+	return CLOCK_133M;
+}
+EXPORT_SYMBOL(ltq_get_fpi_hz);
+
+
diff --git a/arch/mips/lantiq/xway/clk-xway.c b/arch/mips/lantiq/xway/clk-xway.c
new file mode 100644
index 0000000..8e7e3d6
--- /dev/null
+++ b/arch/mips/lantiq/xway/clk-xway.c
@@ -0,0 +1,221 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+
+#include <asm/time.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+
+#include <lantiq_soc.h>
+
+static unsigned int ltq_ram_clocks[] = {
+	CLOCK_167M, CLOCK_133M, CLOCK_111M, CLOCK_83M };
+#define DDR_HZ ltq_ram_clocks[ltq_r32(LTQ_CGU_SYS) & 0x3]
+
+#define BASIC_FREQUENCY_1	35328000
+#define BASIC_FREQUENCY_2	36000000
+#define BASIS_REQUENCY_USB	12000000
+
+#define GET_BITS(x, msb, lsb)           \
+			(((x) & ((1 << ((msb) + 1)) - 1)) >> (lsb))
+
+#define CGU_PLL0_PHASE_DIVIDER_ENABLE   (ltq_r32(LTQ_CGU_PLL0_CFG) & (1 << 31))
+#define CGU_PLL0_BYPASS                 (ltq_r32(LTQ_CGU_PLL0_CFG) & (1 << 30))
+#define CGU_PLL0_CFG_DSMSEL             (ltq_r32(LTQ_CGU_PLL0_CFG) & (1 << 28))
+#define CGU_PLL0_CFG_FRAC_EN            (ltq_r32(LTQ_CGU_PLL0_CFG) & (1 << 27))
+#define CGU_PLL1_SRC                    (ltq_r32(LTQ_CGU_PLL1_CFG) & (1 << 31))
+#define CGU_PLL2_PHASE_DIVIDER_ENABLE   (ltq_r32(LTQ_CGU_PLL2_CFG) & (1 << 20))
+#define CGU_SYS_FPI_SEL                 (1 << 6)
+#define CGU_SYS_DDR_SEL                 0x3
+#define CGU_PLL0_SRC                    (1 << 29)
+
+#define CGU_PLL0_CFG_PLLK               GET_BITS(*LTQ_CGU_PLL0_CFG, 26, 17)
+#define CGU_PLL0_CFG_PLLN               GET_BITS(*LTQ_CGU_PLL0_CFG, 12, 6)
+#define CGU_PLL0_CFG_PLLM               GET_BITS(*LTQ_CGU_PLL0_CFG, 5, 2)
+#define CGU_PLL2_SRC                    GET_BITS(*LTQ_CGU_PLL2_CFG, 18, 17)
+#define CGU_PLL2_CFG_INPUT_DIV          GET_BITS(*LTQ_CGU_PLL2_CFG, 16, 13)
+
+#define LTQ_GPTU_GPT_CLC		((u32 *)(LTQ_GPTU_BASE_ADDR + 0x0000))
+#define LTQ_CGU_PLL0_CFG		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0004))
+#define LTQ_CGU_PLL1_CFG		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0008))
+#define LTQ_CGU_PLL2_CFG		((u32 *)(LTQ_CGU_BASE_ADDR + 0x000C))
+#define LTQ_CGU_SYS			((u32 *)(LTQ_CGU_BASE_ADDR + 0x0010))
+#define LTQ_CGU_UPDATE		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0014))
+#define LTQ_CGU_IF_CLK		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0018))
+#define LTQ_CGU_OSC_CON		((u32 *)(LTQ_CGU_BASE_ADDR + 0x001C))
+#define LTQ_CGU_SMD			((u32 *)(LTQ_CGU_BASE_ADDR + 0x0020))
+#define LTQ_CGU_CT1SR		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0028))
+#define LTQ_CGU_CT2SR		((u32 *)(LTQ_CGU_BASE_ADDR + 0x002C))
+#define LTQ_CGU_PCMCR		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0030))
+#define LTQ_CGU_PCI_CR		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0034))
+#define LTQ_CGU_PD_PC		((u32 *)(LTQ_CGU_BASE_ADDR + 0x0038))
+#define LTQ_CGU_FMR			((u32 *)(LTQ_CGU_BASE_ADDR + 0x003C))
+
+static unsigned int ltq_get_pll0_fdiv(void);
+
+static inline unsigned int
+get_input_clock(int pll)
+{
+	switch (pll) {
+	case 0:
+		if (ltq_r32(LTQ_CGU_PLL0_CFG) & CGU_PLL0_SRC)
+			return BASIS_REQUENCY_USB;
+		else if (CGU_PLL0_PHASE_DIVIDER_ENABLE)
+			return BASIC_FREQUENCY_1;
+		else
+			return BASIC_FREQUENCY_2;
+	case 1:
+		if (CGU_PLL1_SRC)
+			return BASIS_REQUENCY_USB;
+		else if (CGU_PLL0_PHASE_DIVIDER_ENABLE)
+			return BASIC_FREQUENCY_1;
+		else
+			return BASIC_FREQUENCY_2;
+	case 2:
+		switch (CGU_PLL2_SRC) {
+		case 0:
+			return ltq_get_pll0_fdiv();
+		case 1:
+			return CGU_PLL2_PHASE_DIVIDER_ENABLE ?
+				BASIC_FREQUENCY_1 :
+				BASIC_FREQUENCY_2;
+		case 2:
+			return BASIS_REQUENCY_USB;
+		}
+	default:
+		return 0;
+	}
+}
+
+static inline unsigned int
+cal_dsm(int pll, unsigned int num, unsigned int den)
+{
+	u64 res, clock = get_input_clock(pll);
+	res = num * clock;
+	do_div(res, den);
+	return res;
+}
+
+static inline unsigned int
+mash_dsm(int pll, unsigned int M, unsigned int N, unsigned int K)
+{
+	unsigned int num = ((N + 1) << 10) + K;
+	unsigned int den = (M + 1) << 10;
+	return cal_dsm(pll, num, den);
+}
+
+static inline unsigned int
+ssff_dsm_1(int pll, unsigned int M, unsigned int N,	unsigned int K)
+{
+	unsigned int num = ((N + 1) << 11) + K + 512;
+	unsigned int den = (M + 1) << 11;
+	return cal_dsm(pll, num, den);
+}
+
+static inline unsigned int
+ssff_dsm_2(int pll, unsigned int M, unsigned int N, unsigned int K)
+{
+	unsigned int num = K >= 512 ?
+		((N + 1) << 12) + K - 512 : ((N + 1) << 12) + K + 3584;
+	unsigned int den = (M + 1) << 12;
+	return cal_dsm(pll, num, den);
+}
+
+static inline unsigned int
+dsm(int pll, unsigned int M, unsigned int N, unsigned int K,
+	unsigned int dsmsel, unsigned int phase_div_en)
+{
+	if (!dsmsel)
+		return mash_dsm(pll, M, N, K);
+	else if (!phase_div_en)
+		return mash_dsm(pll, M, N, K);
+	else
+		return ssff_dsm_2(pll, M, N, K);
+}
+
+static inline unsigned int
+ltq_get_pll0_fosc(void)
+{
+	if (CGU_PLL0_BYPASS)
+		return get_input_clock(0);
+	else
+		return !CGU_PLL0_CFG_FRAC_EN
+			? dsm(0, CGU_PLL0_CFG_PLLM, CGU_PLL0_CFG_PLLN, 0,
+				CGU_PLL0_CFG_DSMSEL,
+				CGU_PLL0_PHASE_DIVIDER_ENABLE)
+			: dsm(0, CGU_PLL0_CFG_PLLM, CGU_PLL0_CFG_PLLN,
+				CGU_PLL0_CFG_PLLK, CGU_PLL0_CFG_DSMSEL,
+				CGU_PLL0_PHASE_DIVIDER_ENABLE);
+}
+
+static unsigned int
+ltq_get_pll0_fdiv(void)
+{
+	unsigned int div = CGU_PLL2_CFG_INPUT_DIV + 1;
+	return (ltq_get_pll0_fosc() + (div >> 1)) / div;
+}
+
+unsigned int
+ltq_get_io_region_clock(void)
+{
+	unsigned int ret = ltq_get_pll0_fosc();
+	switch (ltq_r32(LTQ_CGU_PLL2_CFG) & CGU_SYS_DDR_SEL) {
+	default:
+	case 0:
+		return (ret + 1) / 2;
+	case 1:
+		return (ret * 2 + 2) / 5;
+	case 2:
+		return (ret + 1) / 3;
+	case 3:
+		return (ret + 2) / 4;
+	}
+}
+EXPORT_SYMBOL(ltq_get_io_region_clock);
+
+unsigned int
+ltq_get_fpi_bus_clock(int fpi)
+{
+	unsigned int ret = ltq_get_io_region_clock();
+	if ((fpi == 2) && (ltq_r32(LTQ_CGU_SYS) & CGU_SYS_FPI_SEL))
+		ret >>= 1;
+	return ret;
+}
+EXPORT_SYMBOL(ltq_get_fpi_bus_clock);
+
+unsigned int
+ltq_get_cpu_hz(void)
+{
+	switch (ltq_r32(LTQ_CGU_SYS) & 0xc) {
+	case 0:
+		return CLOCK_333M;
+	case 4:
+		return DDR_HZ;
+	case 8:
+		return DDR_HZ << 1;
+	default:
+		return DDR_HZ >> 1;
+	}
+}
+EXPORT_SYMBOL(ltq_get_cpu_hz);
+
+unsigned int
+ltq_get_fpi_hz(void)
+{
+	unsigned int ddr_clock = DDR_HZ;
+	if (ltq_r32(LTQ_CGU_SYS) & 0x40)
+		return ddr_clock >> 1;
+	return ddr_clock;
+}
+EXPORT_SYMBOL(ltq_get_fpi_hz);
+
+
diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
new file mode 100644
index 0000000..2faa23a
--- /dev/null
+++ b/arch/mips/lantiq/xway/gpio.c
@@ -0,0 +1,205 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <lantiq.h>
+
+#define LQ_GPIO0_BASE_ADDR	0x1E100B10
+#define LQ_GPIO1_BASE_ADDR	0x1E100B40
+#define LQ_GPIO_SIZE		0x30
+
+#define LQ_GPIO_OUT			0x00
+#define LQ_GPIO_IN			0x04
+#define LQ_GPIO_DIR			0x08
+#define LQ_GPIO_ALTSEL0		0x0C
+#define LQ_GPIO_ALTSEL1		0x10
+#define LQ_GPIO_OD			0x14
+
+#define PINS_PER_PORT		16
+
+#define ltq_gpio_getbit(m, r, p)		(!!(ltq_r32(m + r) & (1 << p)))
+#define ltq_gpio_setbit(m, r, p)		ltq_w32_mask(0, (1 << p), m + r)
+#define ltq_gpio_clearbit(m, r, p)	ltq_w32_mask((1 << p), 0, m + r)
+
+struct ltq_gpio {
+	void __iomem *membase;
+	struct gpio_chip chip;
+};
+
+int
+gpio_to_irq(unsigned int gpio)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(gpio_to_irq);
+
+int
+irq_to_gpio(unsigned int gpio)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(irq_to_gpio);
+
+int
+ltq_gpio_setconfig(unsigned int pin, unsigned int reg, unsigned int val)
+{
+	void __iomem *membase = (void *)KSEG1ADDR(LQ_GPIO0_BASE_ADDR);
+	if (pin >= (2 * PINS_PER_PORT))
+		return -EINVAL;
+	if (pin >= PINS_PER_PORT) {
+		pin -= PINS_PER_PORT;
+		membase += LQ_GPIO_SIZE;
+	}
+	if (val)
+		ltq_w32_mask(0, (1 << pin), membase + reg);
+	else
+		ltq_w32_mask((1 << pin), 0, membase + reg);
+	return 0;
+}
+EXPORT_SYMBOL(ltq_gpio_setconfig);
+
+int
+ltq_gpio_request(unsigned int pin, unsigned int alt0,
+	unsigned int alt1, unsigned int dir, const char *name)
+{
+	void __iomem *membase = (void *)KSEG1ADDR(LQ_GPIO0_BASE_ADDR);
+	if (pin >= (2 * PINS_PER_PORT))
+		return -EINVAL;
+	if (gpio_request(pin, name)) {
+		printk(KERN_ERR "failed to register %s gpio\n", name);
+		return -EBUSY;
+	}
+	gpio_direction_output(pin, dir);
+	if (pin >= PINS_PER_PORT) {
+		pin -= PINS_PER_PORT;
+		membase += LQ_GPIO_SIZE;
+	}
+	if (alt0)
+		ltq_gpio_setbit(membase, LQ_GPIO_ALTSEL0, pin);
+	else
+		ltq_gpio_clearbit(membase, LQ_GPIO_ALTSEL0, pin);
+	if (alt1)
+		ltq_gpio_setbit(membase, LQ_GPIO_ALTSEL1, pin);
+	else
+		ltq_gpio_clearbit(membase, LQ_GPIO_ALTSEL1, pin);
+	return 0;
+}
+EXPORT_SYMBOL(ltq_gpio_request);
+
+static void
+ltq_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
+	if (value)
+		ltq_gpio_setbit(ltq_gpio->membase, LQ_GPIO_OUT, offset);
+	else
+		ltq_gpio_clearbit(ltq_gpio->membase, LQ_GPIO_OUT, offset);
+}
+
+static int
+ltq_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
+	return ltq_gpio_getbit(ltq_gpio->membase, LQ_GPIO_IN, offset);
+}
+
+static int
+ltq_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
+	ltq_gpio_clearbit(ltq_gpio->membase, LQ_GPIO_OD, offset);
+	ltq_gpio_clearbit(ltq_gpio->membase, LQ_GPIO_DIR, offset);
+	return 0;
+}
+
+static int
+ltq_gpio_direction_output(struct gpio_chip *chip,
+	unsigned int offset, int value)
+{
+	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
+	ltq_gpio_setbit(ltq_gpio->membase, LQ_GPIO_OD, offset);
+	ltq_gpio_setbit(ltq_gpio->membase, LQ_GPIO_DIR, offset);
+	ltq_gpio_set(chip, offset, value);
+	return 0;
+}
+
+static int
+ltq_gpio_req(struct gpio_chip *chip, unsigned offset)
+{
+	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
+	ltq_gpio_clearbit(ltq_gpio->membase, LQ_GPIO_ALTSEL0, offset);
+	ltq_gpio_clearbit(ltq_gpio->membase, LQ_GPIO_ALTSEL1, offset);
+	return 0;
+}
+
+static int
+ltq_gpio_probe(struct platform_device *pdev)
+{
+	struct ltq_gpio *ltq_gpio =
+		kzalloc(sizeof(struct ltq_gpio), GFP_KERNEL);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret = 0;
+	if (!res) {
+		ret = -ENOENT;
+		goto err_free;
+	}
+	res = request_mem_region(res->start, resource_size(res),
+		dev_name(&pdev->dev));
+	if (!res) {
+		ret = -EBUSY;
+		goto err_free;
+	}
+	ltq_gpio->membase = ioremap_nocache(res->start, resource_size(res));
+	if (!ltq_gpio->membase) {
+		ret = -ENOMEM;
+		goto err_release_mem_region;
+	}
+	ltq_gpio->chip.label = "ltq_gpio";
+	ltq_gpio->chip.direction_input = ltq_gpio_direction_input;
+	ltq_gpio->chip.direction_output = ltq_gpio_direction_output;
+	ltq_gpio->chip.get = ltq_gpio_get;
+	ltq_gpio->chip.set = ltq_gpio_set;
+	ltq_gpio->chip.request = ltq_gpio_req;
+	ltq_gpio->chip.base = PINS_PER_PORT * pdev->id;
+	ltq_gpio->chip.ngpio = PINS_PER_PORT;
+	platform_set_drvdata(pdev, ltq_gpio);
+	ret = gpiochip_add(&ltq_gpio->chip);
+	if (!ret)
+		return 0;
+
+	iounmap(ltq_gpio->membase);
+err_release_mem_region:
+	release_mem_region(res->start, resource_size(res));
+err_free:
+	kfree(ltq_gpio);
+	return ret;
+}
+
+static struct platform_driver
+ltq_gpio_driver = {
+	.probe = ltq_gpio_probe,
+	.driver = {
+		.name = "ltq_gpio",
+		.owner = THIS_MODULE,
+	},
+};
+
+int __init
+ltq_gpio_init(void)
+{
+	int ret = platform_driver_register(&ltq_gpio_driver);
+	if (ret)
+		printk(KERN_INFO "ltq_gpio : Error registering platfom driver!");
+	return ret;
+}
+
+arch_initcall(ltq_gpio_init);
diff --git a/arch/mips/lantiq/xway/pmu.c b/arch/mips/lantiq/xway/pmu.c
new file mode 100644
index 0000000..78f4a4c
--- /dev/null
+++ b/arch/mips/lantiq/xway/pmu.c
@@ -0,0 +1,36 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/version.h>
+
+#include <lantiq_soc.h>
+
+#define LTQ_PMU_PWDCR        ((u32 *)(LTQ_PMU_BASE_ADDR + 0x001C))
+#define LTQ_PMU_PWDSR        ((u32 *)(LTQ_PMU_BASE_ADDR + 0x0020))
+
+void
+ltq_pmu_enable(unsigned int module)
+{
+	int err = 1000000;
+
+	ltq_w32(ltq_r32(LTQ_PMU_PWDCR) & ~module, LTQ_PMU_PWDCR);
+	do {} while (--err && (ltq_r32(LTQ_PMU_PWDSR) & module));
+
+	if (!err)
+		panic("activating PMU module failed!");
+}
+EXPORT_SYMBOL(ltq_pmu_enable);
+
+void
+ltq_pmu_disable(unsigned int module)
+{
+	ltq_w32(ltq_r32(LTQ_PMU_PWDCR) | module, LTQ_PMU_PWDCR);
+}
+EXPORT_SYMBOL(ltq_pmu_disable);
diff --git a/arch/mips/lantiq/xway/prom-ase.c b/arch/mips/lantiq/xway/prom-ase.c
new file mode 100644
index 0000000..55f5041
--- /dev/null
+++ b/arch/mips/lantiq/xway/prom-ase.c
@@ -0,0 +1,41 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+
+#include <lantiq_soc.h>
+
+#include "../prom.h"
+
+#define SOC_AMAZON_SE	"Amazon_SE"
+
+#define PART_SHIFT		12
+#define PART_MASK		0x0FFFFFFF
+#define REV_SHIFT		28
+#define REV_MASK		0xF0000000
+
+void __init
+ltq_soc_detect(struct ltq_soc_info *i)
+{
+	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
+	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
+	switch (i->partnum) {
+	case SOC_ID_AMAZON_SE:
+		i->name = SOC_AMAZON_SE;
+		i->type = SOC_TYPE_AMAZON_SE;
+		break;
+
+	default:
+		early_printf(KERN_ERR "unknown chiprev : 0x%08X\n", i->partnum);
+		unreachable();
+		break;
+	}
+}
diff --git a/arch/mips/lantiq/xway/prom-xway.c b/arch/mips/lantiq/xway/prom-xway.c
new file mode 100644
index 0000000..5c4e1a7
--- /dev/null
+++ b/arch/mips/lantiq/xway/prom-xway.c
@@ -0,0 +1,56 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+
+#include <lantiq_soc.h>
+
+#include "../prom.h"
+
+#define SOC_DANUBE		"Danube"
+#define SOC_TWINPASS	"Twinpass"
+#define SOC_AR9			"AR9"
+
+#define PART_SHIFT		12
+#define PART_MASK		0x0FFFFFFF
+#define REV_SHIFT		28
+#define REV_MASK		0xF0000000
+
+void __init
+ltq_soc_detect(struct ltq_soc_info *i)
+{
+	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
+	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
+	switch (i->partnum) {
+	case SOC_ID_DANUBE1:
+	case SOC_ID_DANUBE2:
+		i->name = SOC_DANUBE;
+		i->type = SOC_TYPE_DANUBE;
+		break;
+
+	case SOC_ID_TWINPASS:
+		i->name = SOC_TWINPASS;
+		i->type = SOC_TYPE_DANUBE;
+		break;
+
+	case SOC_ID_ARX188:
+	case SOC_ID_ARX168:
+	case SOC_ID_ARX182:
+		i->name = SOC_AR9;
+		i->type = SOC_TYPE_AR9;
+		break;
+
+	default:
+		early_printf("unknown chiprev : 0x%08X\n", i->partnum);
+		unreachable();
+		break;
+	}
+}
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
new file mode 100644
index 0000000..64ecd77
--- /dev/null
+++ b/arch/mips/lantiq/xway/reset.c
@@ -0,0 +1,53 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <asm/reboot.h>
+
+#include <lantiq_soc.h>
+
+#define LTQ_RCU_RST			((u32 *)(LTQ_RCU_BASE_ADDR + 0x0010))
+#define LTQ_RCU_RST_ALL		0x40000000
+
+static void
+ltq_machine_restart(char *command)
+{
+	printk(KERN_NOTICE "System restart\n");
+	local_irq_disable();
+	ltq_w32(ltq_r32(LTQ_RCU_RST) | LTQ_RCU_RST_ALL,	LTQ_RCU_RST);
+	unreachable();
+}
+
+static void
+ltq_machine_halt(void)
+{
+	printk(KERN_NOTICE "System halted.\n");
+	local_irq_disable();
+	unreachable();
+}
+
+static void
+ltq_machine_power_off(void)
+{
+	printk(KERN_NOTICE "Please turn off the power now.\n");
+	local_irq_disable();
+	unreachable();
+}
+
+static int __init
+mips_reboot_setup(void)
+{
+	_machine_restart = ltq_machine_restart;
+	_machine_halt = ltq_machine_halt;
+	pm_power_off = ltq_machine_power_off;
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
-- 
1.7.2.3
