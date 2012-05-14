Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:45:28 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38233 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903701Ab2ENRnc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:43:32 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RESEND PATCH V2 05/17] MIPS: lantiq: implement support for clkdev api
Date:   Mon, 14 May 2012 19:42:31 +0200
Message-Id: <1337017363-14424-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch unifies all clock generation and gating code into one file.
All drivers will now be able to request their clocks via their device.
This patch also adds support for the clockout feature, which allows
clock generation on external pins.

Support for COMMON_CLK will be provided in the next series.

Signed-off-by: John Crispin <blogic@openwrt.org>

Changes in V2
* add io clk to accomodate falcon soc
---
 arch/mips/Kconfig                                  |    3 +-
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   27 +-
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    5 +
 arch/mips/lantiq/clk.c                             |  146 +++++----
 arch/mips/lantiq/clk.h                             |   68 ++++-
 arch/mips/lantiq/xway/Makefile                     |    5 +-
 arch/mips/lantiq/xway/clk-ase.c                    |   48 ---
 arch/mips/lantiq/xway/clk-xway.c                   |  223 ------------
 arch/mips/lantiq/xway/clk.c                        |  151 ++++++++
 arch/mips/lantiq/xway/ebu.c                        |   48 ---
 arch/mips/lantiq/xway/pmu.c                        |   69 ----
 arch/mips/lantiq/xway/sysctrl.c                    |  367 ++++++++++++++++++++
 12 files changed, 681 insertions(+), 479 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/clk-ase.c
 delete mode 100644 arch/mips/lantiq/xway/clk-xway.c
 create mode 100644 arch/mips/lantiq/xway/clk.c
 delete mode 100644 arch/mips/lantiq/xway/ebu.c
 delete mode 100644 arch/mips/lantiq/xway/pmu.c
 create mode 100644 arch/mips/lantiq/xway/sysctrl.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08b0312..54be81c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -228,7 +228,8 @@ config LANTIQ
 	select ARCH_REQUIRE_GPIOLIB
 	select SWAP_IO_SPACE
 	select BOOT_RAW
-	select HAVE_CLK
+	select HAVE_MACH_CLKDEV
+	select CLKDEV_LOOKUP
 	select USE_OF
 
 config LASAT
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 7a90190..6775d24 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -9,6 +9,8 @@
 #define _LANTIQ_H__
 
 #include <linux/irq.h>
+#include <linux/device.h>
+#include <linux/clk.h>
 
 /* generic reg access functions */
 #define ltq_r32(reg)		__raw_readl(reg)
@@ -21,26 +23,13 @@
 /* register access macros for EBU and CGU */
 #define ltq_ebu_w32(x, y)	ltq_w32((x), ltq_ebu_membase + (y))
 #define ltq_ebu_r32(x)		ltq_r32(ltq_ebu_membase + (x))
-#define ltq_cgu_w32(x, y)	ltq_w32((x), ltq_cgu_membase + (y))
-#define ltq_cgu_r32(x)		ltq_r32(ltq_cgu_membase + (x))
-
+#define ltq_ebu_w32_mask(x, y, z) \
+	ltq_w32_mask(x, y, ltq_ebu_membase + (z))
 extern __iomem void *ltq_ebu_membase;
-extern __iomem void *ltq_cgu_membase;
 
 extern unsigned int ltq_get_cpu_ver(void);
 extern unsigned int ltq_get_soc_type(void);
 
-/* clock speeds */
-#define CLOCK_60M	60000000
-#define CLOCK_83M	83333333
-#define CLOCK_111M	111111111
-#define CLOCK_133M	133333333
-#define CLOCK_167M	166666667
-#define CLOCK_200M	200000000
-#define CLOCK_266M	266666666
-#define CLOCK_333M	333333333
-#define CLOCK_400M	400000000
-
 /* spinlock all ebu i/o */
 extern spinlock_t ebu_lock;
 
@@ -48,6 +37,14 @@ extern spinlock_t ebu_lock;
 extern void ltq_disable_irq(struct irq_data *data);
 extern void ltq_mask_and_ack_irq(struct irq_data *data);
 extern void ltq_enable_irq(struct irq_data *data);
+
+/* clock handling */
+extern int clk_activate(struct clk *clk);
+extern void clk_deactivate(struct clk *clk);
+extern struct clk *clk_get_cpu(void);
+extern struct clk *clk_get_fpi(void);
+extern struct clk *clk_get_io(void);
+
 /* find out what bootsource we have */
 extern unsigned char ltq_boot_select(void);
 /* find out what caused the last cpu reset */
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 150c7be..b5a2acf 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -59,6 +59,11 @@
 #define BS_NAND			0x6
 #define BS_RMII0		0x7
 
+/* helpers used to access the cgu */
+#define ltq_cgu_w32(x, y)	ltq_w32((x), ltq_cgu_membase + (y))
+#define ltq_cgu_r32(x)		ltq_r32(ltq_cgu_membase + (x))
+extern __iomem void *ltq_cgu_membase;
+
 /*
  * during early_printk no ioremap is possible
  * lets use KSEG1 instead
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 412814f..d3bcc33 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/list.h>
 
@@ -22,44 +23,32 @@
 #include <lantiq_soc.h>
 
 #include "clk.h"
+#include "prom.h"
 
-struct clk {
-	const char *name;
-	unsigned long rate;
-	unsigned long (*get_rate) (void);
-};
+/* lantiq socs have 3 static clocks */
+static struct clk cpu_clk_generic[3];
 
-static struct clk *cpu_clk;
-static int cpu_clk_cnt;
+void clkdev_add_static(unsigned long cpu, unsigned long fpi, unsigned long io)
+{
+	cpu_clk_generic[0].rate = cpu;
+	cpu_clk_generic[1].rate = fpi;
+	cpu_clk_generic[2].rate = io;
+}
 
-/* lantiq socs have 3 static clocks */
-static struct clk cpu_clk_generic[] = {
-	{
-		.name = "cpu",
-		.get_rate = ltq_get_cpu_hz,
-	}, {
-		.name = "fpi",
-		.get_rate = ltq_get_fpi_hz,
-	}, {
-		.name = "io",
-		.get_rate = ltq_get_io_region_clock,
-	},
-};
-
-static struct resource ltq_cgu_resource = {
-	.name	= "cgu",
-	.start	= LTQ_CGU_BASE_ADDR,
-	.end	= LTQ_CGU_BASE_ADDR + LTQ_CGU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-/* remapped clock register range */
-void __iomem *ltq_cgu_membase;
-
-void clk_init(void)
+struct clk *clk_get_cpu(void)
+{
+	return &cpu_clk_generic[0];
+}
+
+struct clk *clk_get_fpi(void)
+{
+	return &cpu_clk_generic[1];
+}
+EXPORT_SYMBOL_GPL(clk_get_fpi);
+
+struct clk *clk_get_io(void)
 {
-	cpu_clk = cpu_clk_generic;
-	cpu_clk_cnt = ARRAY_SIZE(cpu_clk_generic);
+	return &cpu_clk_generic[2];
 }
 
 static inline int clk_good(struct clk *clk)
@@ -82,38 +71,71 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
-struct clk *clk_get(struct device *dev, const char *id)
+int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	int i;
-
-	for (i = 0; i < cpu_clk_cnt; i++)
-		if (!strcmp(id, cpu_clk[i].name))
-			return &cpu_clk[i];
-	BUG();
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-	/* not used */
+	if (unlikely(!clk_good(clk)))
+		return 0;
+	if (clk->rates && *clk->rates) {
+		unsigned long *r = clk->rates;
+
+		while (*r && (*r != rate))
+			r++;
+		if (!*r) {
+			pr_err("clk %s.%s: trying to set invalid rate %ld\n",
+				clk->cl.dev_id, clk->cl.con_id, rate);
+			return -1;
+		}
+	}
+	clk->rate = rate;
+	return 0;
 }
-EXPORT_SYMBOL(clk_put);
+EXPORT_SYMBOL(clk_set_rate);
 
 int clk_enable(struct clk *clk)
 {
-	/* not used */
-	return 0;
+	if (unlikely(!clk_good(clk)))
+		return -1;
+
+	if (clk->enable)
+		return clk->enable(clk);
+
+	return -1;
 }
 EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
-	/* not used */
+	if (unlikely(!clk_good(clk)))
+		return;
+
+	if (clk->disable)
+		clk->disable(clk);
 }
 EXPORT_SYMBOL(clk_disable);
 
-static inline u32 ltq_get_counter_resolution(void)
+int clk_activate(struct clk *clk)
+{
+	if (unlikely(!clk_good(clk)))
+		return -1;
+
+	if (clk->activate)
+		return clk->activate(clk);
+
+	return -1;
+}
+EXPORT_SYMBOL(clk_activate);
+
+void clk_deactivate(struct clk *clk)
+{
+	if (unlikely(!clk_good(clk)))
+		return;
+
+	if (clk->deactivate)
+		clk->deactivate(clk);
+}
+EXPORT_SYMBOL(clk_deactivate);
+
+static inline u32 get_counter_resolution(void)
 {
 	u32 res;
 
@@ -133,21 +155,11 @@ void __init plat_time_init(void)
 {
 	struct clk *clk;
 
-	if (insert_resource(&iomem_resource, &ltq_cgu_resource) < 0)
-		panic("Failed to insert cgu memory");
+	ltq_soc_init();
 
-	if (request_mem_region(ltq_cgu_resource.start,
-			resource_size(&ltq_cgu_resource), "cgu") < 0)
-		panic("Failed to request cgu memory");
-
-	ltq_cgu_membase = ioremap_nocache(ltq_cgu_resource.start,
-				resource_size(&ltq_cgu_resource));
-	if (!ltq_cgu_membase) {
-		pr_err("Failed to remap cgu memory\n");
-		unreachable();
-	}
-	clk = clk_get(0, "cpu");
-	mips_hpt_frequency = clk_get_rate(clk) / ltq_get_counter_resolution();
+	clk = clk_get_cpu();
+	mips_hpt_frequency = clk_get_rate(clk) / get_counter_resolution();
 	write_c0_compare(read_c0_count());
+	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
 	clk_put(clk);
 }
diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
index 3328925..fa67060 100644
--- a/arch/mips/lantiq/clk.h
+++ b/arch/mips/lantiq/clk.h
@@ -9,10 +9,70 @@
 #ifndef _LTQ_CLK_H__
 #define _LTQ_CLK_H__
 
-extern void clk_init(void);
+#include <linux/clkdev.h>
 
-extern unsigned long ltq_get_cpu_hz(void);
-extern unsigned long ltq_get_fpi_hz(void);
-extern unsigned long ltq_get_io_region_clock(void);
+/* clock speeds */
+#define CLOCK_33M	33333333
+#define CLOCK_60M	60000000
+#define CLOCK_62_5M	62500000
+#define CLOCK_83M	83333333
+#define CLOCK_83_5M	83500000
+#define CLOCK_98_304M	98304000
+#define CLOCK_100M	100000000
+#define CLOCK_111M	111111111
+#define CLOCK_125M	125000000
+#define CLOCK_133M	133333333
+#define CLOCK_150M	150000000
+#define CLOCK_166M	166666666
+#define CLOCK_167M	166666667
+#define CLOCK_196_608M	196608000
+#define CLOCK_200M	200000000
+#define CLOCK_250M	250000000
+#define CLOCK_266M	266666666
+#define CLOCK_300M	300000000
+#define CLOCK_333M	333333333
+#define CLOCK_393M	393215332
+#define CLOCK_400M	400000000
+#define CLOCK_500M	500000000
+#define CLOCK_600M	600000000
+
+/* clock out speeds */
+#define CLOCK_32_768K	32768
+#define CLOCK_1_536M	1536000
+#define CLOCK_2_5M	2500000
+#define CLOCK_12M	12000000
+#define CLOCK_24M	24000000
+#define CLOCK_25M	25000000
+#define CLOCK_30M	30000000
+#define CLOCK_40M	40000000
+#define CLOCK_48M	48000000
+#define CLOCK_50M	50000000
+#define CLOCK_60M	60000000
+
+struct clk {
+	struct clk_lookup cl;
+	unsigned long rate;
+	unsigned long *rates;
+	unsigned int module;
+	unsigned int bits;
+	unsigned long (*get_rate) (void);
+	int (*enable) (struct clk *clk);
+	void (*disable) (struct clk *clk);
+	int (*activate) (struct clk *clk);
+	void (*deactivate) (struct clk *clk);
+	void (*reboot) (struct clk *clk);
+};
+
+extern void clkdev_add_static(unsigned long cpu, unsigned long fpi,
+				unsigned long io);
+
+extern unsigned long ltq_danube_cpu_hz(void);
+extern unsigned long ltq_danube_fpi_hz(void);
+
+extern unsigned long ltq_ar9_cpu_hz(void);
+extern unsigned long ltq_ar9_fpi_hz(void);
+
+extern unsigned long ltq_vr9_cpu_hz(void);
+extern unsigned long ltq_vr9_fpi_hz(void);
 
 #endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 7a6c30f..edef6c5 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,4 +1 @@
-obj-y := prom.o pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o dma.o
-
-obj-$(CONFIG_SOC_XWAY) += clk-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o
+obj-y := prom.o sysctrl.o clk.o reset.o gpio.o gpio_stp.o gpio_ebu.o dma.o
diff --git a/arch/mips/lantiq/xway/clk-ase.c b/arch/mips/lantiq/xway/clk-ase.c
deleted file mode 100644
index 6522583..0000000
--- a/arch/mips/lantiq/xway/clk-ase.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-
-#include <asm/time.h>
-#include <asm/irq.h>
-#include <asm/div64.h>
-
-#include <lantiq_soc.h>
-
-/* cgu registers */
-#define LTQ_CGU_SYS	0x0010
-
-unsigned int ltq_get_io_region_clock(void)
-{
-	return CLOCK_133M;
-}
-EXPORT_SYMBOL(ltq_get_io_region_clock);
-
-unsigned int ltq_get_fpi_bus_clock(int fpi)
-{
-	return CLOCK_133M;
-}
-EXPORT_SYMBOL(ltq_get_fpi_bus_clock);
-
-unsigned int ltq_get_cpu_hz(void)
-{
-	if (ltq_cgu_r32(LTQ_CGU_SYS) & (1 << 5))
-		return CLOCK_266M;
-	else
-		return CLOCK_133M;
-}
-EXPORT_SYMBOL(ltq_get_cpu_hz);
-
-unsigned int ltq_get_fpi_hz(void)
-{
-	return CLOCK_133M;
-}
-EXPORT_SYMBOL(ltq_get_fpi_hz);
diff --git a/arch/mips/lantiq/xway/clk-xway.c b/arch/mips/lantiq/xway/clk-xway.c
deleted file mode 100644
index 696b1a3..0000000
--- a/arch/mips/lantiq/xway/clk-xway.c
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-
-#include <asm/time.h>
-#include <asm/irq.h>
-#include <asm/div64.h>
-
-#include <lantiq_soc.h>
-
-static unsigned int ltq_ram_clocks[] = {
-	CLOCK_167M, CLOCK_133M, CLOCK_111M, CLOCK_83M };
-#define DDR_HZ ltq_ram_clocks[ltq_cgu_r32(LTQ_CGU_SYS) & 0x3]
-
-#define BASIC_FREQUENCY_1	35328000
-#define BASIC_FREQUENCY_2	36000000
-#define BASIS_REQUENCY_USB	12000000
-
-#define GET_BITS(x, msb, lsb) \
-	(((x) & ((1 << ((msb) + 1)) - 1)) >> (lsb))
-
-#define LTQ_CGU_PLL0_CFG	0x0004
-#define LTQ_CGU_PLL1_CFG	0x0008
-#define LTQ_CGU_PLL2_CFG	0x000C
-#define LTQ_CGU_SYS		0x0010
-#define LTQ_CGU_UPDATE		0x0014
-#define LTQ_CGU_IF_CLK		0x0018
-#define LTQ_CGU_OSC_CON		0x001C
-#define LTQ_CGU_SMD		0x0020
-#define LTQ_CGU_CT1SR		0x0028
-#define LTQ_CGU_CT2SR		0x002C
-#define LTQ_CGU_PCMCR		0x0030
-#define LTQ_CGU_PCI_CR		0x0034
-#define LTQ_CGU_PD_PC		0x0038
-#define LTQ_CGU_FMR		0x003C
-
-#define CGU_PLL0_PHASE_DIVIDER_ENABLE	\
-	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 31))
-#define CGU_PLL0_BYPASS			\
-	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 30))
-#define CGU_PLL0_CFG_DSMSEL		\
-	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 28))
-#define CGU_PLL0_CFG_FRAC_EN		\
-	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 27))
-#define CGU_PLL1_SRC			\
-	(ltq_cgu_r32(LTQ_CGU_PLL1_CFG) & (1 << 31))
-#define CGU_PLL2_PHASE_DIVIDER_ENABLE	\
-	(ltq_cgu_r32(LTQ_CGU_PLL2_CFG) & (1 << 20))
-#define CGU_SYS_FPI_SEL			(1 << 6)
-#define CGU_SYS_DDR_SEL			0x3
-#define CGU_PLL0_SRC			(1 << 29)
-
-#define CGU_PLL0_CFG_PLLK	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL0_CFG), 26, 17)
-#define CGU_PLL0_CFG_PLLN	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL0_CFG), 12, 6)
-#define CGU_PLL0_CFG_PLLM	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL0_CFG), 5, 2)
-#define CGU_PLL2_SRC		GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL2_CFG), 18, 17)
-#define CGU_PLL2_CFG_INPUT_DIV	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL2_CFG), 16, 13)
-
-static unsigned int ltq_get_pll0_fdiv(void);
-
-static inline unsigned int get_input_clock(int pll)
-{
-	switch (pll) {
-	case 0:
-		if (ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & CGU_PLL0_SRC)
-			return BASIS_REQUENCY_USB;
-		else if (CGU_PLL0_PHASE_DIVIDER_ENABLE)
-			return BASIC_FREQUENCY_1;
-		else
-			return BASIC_FREQUENCY_2;
-	case 1:
-		if (CGU_PLL1_SRC)
-			return BASIS_REQUENCY_USB;
-		else if (CGU_PLL0_PHASE_DIVIDER_ENABLE)
-			return BASIC_FREQUENCY_1;
-		else
-			return BASIC_FREQUENCY_2;
-	case 2:
-		switch (CGU_PLL2_SRC) {
-		case 0:
-			return ltq_get_pll0_fdiv();
-		case 1:
-			return CGU_PLL2_PHASE_DIVIDER_ENABLE ?
-				BASIC_FREQUENCY_1 :
-				BASIC_FREQUENCY_2;
-		case 2:
-			return BASIS_REQUENCY_USB;
-		}
-	default:
-		return 0;
-	}
-}
-
-static inline unsigned int cal_dsm(int pll, unsigned int num, unsigned int den)
-{
-	u64 res, clock = get_input_clock(pll);
-
-	res = num * clock;
-	do_div(res, den);
-	return res;
-}
-
-static inline unsigned int mash_dsm(int pll, unsigned int M, unsigned int N,
-	unsigned int K)
-{
-	unsigned int num = ((N + 1) << 10) + K;
-	unsigned int den = (M + 1) << 10;
-
-	return cal_dsm(pll, num, den);
-}
-
-static inline unsigned int ssff_dsm_1(int pll, unsigned int M, unsigned int N,
-	unsigned int K)
-{
-	unsigned int num = ((N + 1) << 11) + K + 512;
-	unsigned int den = (M + 1) << 11;
-
-	return cal_dsm(pll, num, den);
-}
-
-static inline unsigned int ssff_dsm_2(int pll, unsigned int M, unsigned int N,
-	unsigned int K)
-{
-	unsigned int num = K >= 512 ?
-		((N + 1) << 12) + K - 512 : ((N + 1) << 12) + K + 3584;
-	unsigned int den = (M + 1) << 12;
-
-	return cal_dsm(pll, num, den);
-}
-
-static inline unsigned int dsm(int pll, unsigned int M, unsigned int N,
-	unsigned int K, unsigned int dsmsel, unsigned int phase_div_en)
-{
-	if (!dsmsel)
-		return mash_dsm(pll, M, N, K);
-	else if (!phase_div_en)
-		return mash_dsm(pll, M, N, K);
-	else
-		return ssff_dsm_2(pll, M, N, K);
-}
-
-static inline unsigned int ltq_get_pll0_fosc(void)
-{
-	if (CGU_PLL0_BYPASS)
-		return get_input_clock(0);
-	else
-		return !CGU_PLL0_CFG_FRAC_EN
-			? dsm(0, CGU_PLL0_CFG_PLLM, CGU_PLL0_CFG_PLLN, 0,
-				CGU_PLL0_CFG_DSMSEL,
-				CGU_PLL0_PHASE_DIVIDER_ENABLE)
-			: dsm(0, CGU_PLL0_CFG_PLLM, CGU_PLL0_CFG_PLLN,
-				CGU_PLL0_CFG_PLLK, CGU_PLL0_CFG_DSMSEL,
-				CGU_PLL0_PHASE_DIVIDER_ENABLE);
-}
-
-static unsigned int ltq_get_pll0_fdiv(void)
-{
-	unsigned int div = CGU_PLL2_CFG_INPUT_DIV + 1;
-
-	return (ltq_get_pll0_fosc() + (div >> 1)) / div;
-}
-
-unsigned int ltq_get_io_region_clock(void)
-{
-	unsigned int ret = ltq_get_pll0_fosc();
-
-	switch (ltq_cgu_r32(LTQ_CGU_PLL2_CFG) & CGU_SYS_DDR_SEL) {
-	default:
-	case 0:
-		return (ret + 1) / 2;
-	case 1:
-		return (ret * 2 + 2) / 5;
-	case 2:
-		return (ret + 1) / 3;
-	case 3:
-		return (ret + 2) / 4;
-	}
-}
-EXPORT_SYMBOL(ltq_get_io_region_clock);
-
-unsigned int ltq_get_fpi_bus_clock(int fpi)
-{
-	unsigned int ret = ltq_get_io_region_clock();
-
-	if ((fpi == 2) && (ltq_cgu_r32(LTQ_CGU_SYS) & CGU_SYS_FPI_SEL))
-		ret >>= 1;
-	return ret;
-}
-EXPORT_SYMBOL(ltq_get_fpi_bus_clock);
-
-unsigned int ltq_get_cpu_hz(void)
-{
-	switch (ltq_cgu_r32(LTQ_CGU_SYS) & 0xc) {
-	case 0:
-		return CLOCK_333M;
-	case 4:
-		return DDR_HZ;
-	case 8:
-		return DDR_HZ << 1;
-	default:
-		return DDR_HZ >> 1;
-	}
-}
-EXPORT_SYMBOL(ltq_get_cpu_hz);
-
-unsigned int ltq_get_fpi_hz(void)
-{
-	unsigned int ddr_clock = DDR_HZ;
-
-	if (ltq_cgu_r32(LTQ_CGU_SYS) & 0x40)
-		return ddr_clock >> 1;
-	return ddr_clock;
-}
-EXPORT_SYMBOL(ltq_get_fpi_hz);
diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
new file mode 100644
index 0000000..9aa17f7
--- /dev/null
+++ b/arch/mips/lantiq/xway/clk.c
@@ -0,0 +1,151 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+
+#include <asm/time.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+
+#include <lantiq_soc.h>
+
+#include "../clk.h"
+
+static unsigned int ram_clocks[] = {
+	CLOCK_167M, CLOCK_133M, CLOCK_111M, CLOCK_83M };
+#define DDR_HZ ram_clocks[ltq_cgu_r32(CGU_SYS) & 0x3]
+
+/* legacy xway clock */
+#define CGU_SYS			0x10
+
+/* vr9 clock */
+#define CGU_SYS_VR9		0x0c
+#define CGU_IF_CLK_VR9		0x24
+
+unsigned long ltq_danube_fpi_hz(void)
+{
+	unsigned long ddr_clock = DDR_HZ;
+
+	if (ltq_cgu_r32(CGU_SYS) & 0x40)
+		return ddr_clock >> 1;
+	return ddr_clock;
+}
+
+unsigned long ltq_danube_cpu_hz(void)
+{
+	switch (ltq_cgu_r32(CGU_SYS) & 0xc) {
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
+
+unsigned long ltq_ar9_sys_hz(void)
+{
+	if (((ltq_cgu_r32(CGU_SYS) >> 3) & 0x3) == 0x2)
+		return CLOCK_393M;
+	return CLOCK_333M;
+}
+
+unsigned long ltq_ar9_fpi_hz(void)
+{
+	unsigned long sys = ltq_ar9_sys_hz();
+
+	if (ltq_cgu_r32(CGU_SYS) & BIT(0))
+		return sys;
+	return sys >> 1;
+}
+
+unsigned long ltq_ar9_cpu_hz(void)
+{
+	if (ltq_cgu_r32(CGU_SYS) & BIT(2))
+		return ltq_ar9_fpi_hz();
+	else
+		return ltq_ar9_sys_hz();
+}
+
+unsigned long ltq_vr9_cpu_hz(void)
+{
+	unsigned int cpu_sel;
+	unsigned long clk;
+
+	cpu_sel = (ltq_cgu_r32(CGU_SYS_VR9) >> 4) & 0xf;
+
+	switch (cpu_sel) {
+	case 0:
+		clk = CLOCK_600M;
+		break;
+	case 1:
+		clk = CLOCK_500M;
+		break;
+	case 2:
+		clk = CLOCK_393M;
+		break;
+	case 3:
+		clk = CLOCK_333M;
+		break;
+	case 5:
+	case 6:
+		clk = CLOCK_196_608M;
+		break;
+	case 7:
+		clk = CLOCK_167M;
+		break;
+	case 4:
+	case 8:
+	case 9:
+		clk = CLOCK_125M;
+		break;
+	default:
+		clk = 0;
+		break;
+	}
+
+	return clk;
+}
+
+unsigned long ltq_vr9_fpi_hz(void)
+{
+	unsigned int ocp_sel, cpu_clk;
+	unsigned long clk;
+
+	cpu_clk = ltq_vr9_cpu_hz();
+	ocp_sel = ltq_cgu_r32(CGU_SYS_VR9) & 0x3;
+
+	switch (ocp_sel) {
+	case 0:
+		/* OCP ratio 1 */
+		clk = cpu_clk;
+		break;
+	case 2:
+		/* OCP ratio 2 */
+		clk = cpu_clk / 2;
+		break;
+	case 3:
+		/* OCP ratio 2.5 */
+		clk = (cpu_clk * 2) / 5;
+		break;
+	case 4:
+		/* OCP ratio 3 */
+		clk = cpu_clk / 3;
+		break;
+	default:
+		clk = 0;
+		break;
+	}
+
+	return clk;
+}
diff --git a/arch/mips/lantiq/xway/ebu.c b/arch/mips/lantiq/xway/ebu.c
deleted file mode 100644
index 419b47b..0000000
--- a/arch/mips/lantiq/xway/ebu.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  EBU - the external bus unit attaches PCI, NOR and NAND
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/ioport.h>
-
-#include <lantiq_soc.h>
-
-static struct resource ltq_ebu_resource = {
-	.name	= "ebu",
-	.start	= LTQ_EBU_BASE_ADDR,
-	.end	= LTQ_EBU_BASE_ADDR + LTQ_EBU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-/* remapped base addr of the clock unit and external bus unit */
-void __iomem *ltq_ebu_membase;
-
-static int __init lantiq_ebu_init(void)
-{
-	/* insert and request the memory region */
-	if (insert_resource(&iomem_resource, &ltq_ebu_resource) < 0)
-		panic("Failed to insert ebu memory");
-
-	if (request_mem_region(ltq_ebu_resource.start,
-			resource_size(&ltq_ebu_resource), "ebu") < 0)
-		panic("Failed to request ebu memory");
-
-	/* remap ebu register range */
-	ltq_ebu_membase = ioremap_nocache(ltq_ebu_resource.start,
-				resource_size(&ltq_ebu_resource));
-	if (!ltq_ebu_membase)
-		panic("Failed to remap ebu memory");
-
-	/* make sure to unprotect the memory region where flash is located */
-	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
-	return 0;
-}
-
-postcore_initcall(lantiq_ebu_init);
diff --git a/arch/mips/lantiq/xway/pmu.c b/arch/mips/lantiq/xway/pmu.c
deleted file mode 100644
index fe85361..0000000
--- a/arch/mips/lantiq/xway/pmu.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/ioport.h>
-
-#include <lantiq_soc.h>
-
-/* PMU - the power management unit allows us to turn part of the core
- * on and off
- */
-
-/* the enable / disable registers */
-#define LTQ_PMU_PWDCR	0x1C
-#define LTQ_PMU_PWDSR	0x20
-
-#define ltq_pmu_w32(x, y)	ltq_w32((x), ltq_pmu_membase + (y))
-#define ltq_pmu_r32(x)		ltq_r32(ltq_pmu_membase + (x))
-
-static struct resource ltq_pmu_resource = {
-	.name	= "pmu",
-	.start	= LTQ_PMU_BASE_ADDR,
-	.end	= LTQ_PMU_BASE_ADDR + LTQ_PMU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static void __iomem *ltq_pmu_membase;
-
-void ltq_pmu_enable(unsigned int module)
-{
-	int err = 1000000;
-
-	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) & ~module, LTQ_PMU_PWDCR);
-	do {} while (--err && (ltq_pmu_r32(LTQ_PMU_PWDSR) & module));
-
-	if (!err)
-		panic("activating PMU module failed!");
-}
-EXPORT_SYMBOL(ltq_pmu_enable);
-
-void ltq_pmu_disable(unsigned int module)
-{
-	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) | module, LTQ_PMU_PWDCR);
-}
-EXPORT_SYMBOL(ltq_pmu_disable);
-
-int __init ltq_pmu_init(void)
-{
-	if (insert_resource(&iomem_resource, &ltq_pmu_resource) < 0)
-		panic("Failed to insert pmu memory");
-
-	if (request_mem_region(ltq_pmu_resource.start,
-			resource_size(&ltq_pmu_resource), "pmu") < 0)
-		panic("Failed to request pmu memory");
-
-	ltq_pmu_membase = ioremap_nocache(ltq_pmu_resource.start,
-				resource_size(&ltq_pmu_resource));
-	if (!ltq_pmu_membase)
-		panic("Failed to remap pmu memory");
-	return 0;
-}
-
-core_initcall(ltq_pmu_init);
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
new file mode 100644
index 0000000..4d6aac6
--- /dev/null
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -0,0 +1,367 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011-2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/ioport.h>
+#include <linux/export.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+#include <lantiq_soc.h>
+
+#include "../clk.h"
+#include "../prom.h"
+
+/* clock control register */
+#define CGU_IFCCR	0x0018
+/* system clock register */
+#define CGU_SYS		0x0010
+/* pci control register */
+#define CGU_PCICR	0x0034
+/* ephy configuration register */
+#define CGU_EPHY	0x10
+/* power control register */
+#define PMU_PWDCR	0x1C
+/* power status register */
+#define PMU_PWDSR	0x20
+/* power control register */
+#define PMU_PWDCR1	0x24
+/* power status register */
+#define PMU_PWDSR1	0x28
+/* power control register */
+#define PWDCR(x) ((x) ? (PMU_PWDCR1) : (PMU_PWDCR))
+/* power status register */
+#define PWDSR(x) ((x) ? (PMU_PWDSR1) : (PMU_PWDSR))
+
+/* clock gates that we can en/disable */
+#define PMU_USB0_P	BIT(0)
+#define PMU_PCI		BIT(4)
+#define PMU_USB0	BIT(6)
+#define PMU_ASC0	BIT(7)
+#define PMU_EPHY	BIT(7)	/* ase */
+#define PMU_SPI		BIT(8)
+#define PMU_DFE		BIT(9)
+#define PMU_EBU		BIT(10)
+#define PMU_STP		BIT(11)
+#define PMU_AHBS	BIT(13) /* vr9 */
+#define PMU_AHBM	BIT(15)
+#define PMU_ASC1	BIT(17)
+#define PMU_PPE_QSB	BIT(18)
+#define PMU_PPE_SLL01	BIT(19)
+#define PMU_PPE_TC	BIT(21)
+#define PMU_PPE_EMA	BIT(22)
+#define PMU_PPE_DPLUM	BIT(23)
+#define PMU_PPE_DPLUS	BIT(24)
+#define PMU_USB1_P	BIT(26)
+#define PMU_USB1	BIT(27)
+#define PMU_PPE_TOP	BIT(29)
+#define PMU_GPHY	BIT(30)
+#define PMU_PCIE_CLK	BIT(31)
+
+#define PMU1_PCIE_PHY	BIT(0)
+#define PMU1_PCIE_CTL	BIT(1)
+#define PMU1_PCIE_PDI	BIT(4)
+#define PMU1_PCIE_MSI	BIT(5)
+
+#define pmu_w32(x, y)	ltq_w32((x), pmu_membase + (y))
+#define pmu_r32(x)	ltq_r32(pmu_membase + (x))
+
+static void __iomem *pmu_membase;
+void __iomem *ltq_cgu_membase;
+void __iomem *ltq_ebu_membase;
+
+/* legacy function kept alive to ease clkdev transition */
+void ltq_pmu_enable(unsigned int module)
+{
+	int err = 1000000;
+
+	pmu_w32(pmu_r32(PMU_PWDCR) & ~module, PMU_PWDCR);
+	do {} while (--err && (pmu_r32(PMU_PWDSR) & module));
+
+	if (!err)
+		panic("activating PMU module failed!");
+}
+EXPORT_SYMBOL(ltq_pmu_enable);
+
+/* legacy function kept alive to ease clkdev transition */
+void ltq_pmu_disable(unsigned int module)
+{
+	pmu_w32(pmu_r32(PMU_PWDCR) | module, PMU_PWDCR);
+}
+EXPORT_SYMBOL(ltq_pmu_disable);
+
+/* enable a hw clock */
+static int cgu_enable(struct clk *clk)
+{
+	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) | clk->bits, CGU_IFCCR);
+	return 0;
+}
+
+/* disable a hw clock */
+static void cgu_disable(struct clk *clk)
+{
+	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) & ~clk->bits, CGU_IFCCR);
+}
+
+/* enable a clock gate */
+static int pmu_enable(struct clk *clk)
+{
+	int retry = 1000000;
+
+	pmu_w32(pmu_r32(PWDCR(clk->module)) & ~clk->bits,
+		PWDCR(clk->module));
+	do {} while (--retry && (pmu_r32(PWDSR(clk->module)) & clk->bits));
+
+	if (!retry)
+		panic("activating PMU module failed!\n");
+
+	return 0;
+}
+
+/* disable a clock gate */
+static void pmu_disable(struct clk *clk)
+{
+	pmu_w32(pmu_r32(PWDCR(clk->module)) | clk->bits,
+		PWDCR(clk->module));
+}
+
+/* the pci enable helper */
+static int pci_enable(struct clk *clk)
+{
+	unsigned int ifccr = ltq_cgu_r32(CGU_IFCCR);
+	/* set bus clock speed */
+	if (of_machine_is_compatible("lantiq,ar9")) {
+		ifccr &= ~0x1f00000;
+		if (clk->rate == CLOCK_33M)
+			ifccr |= 0xe00000;
+		else
+			ifccr |= 0x700000; /* 62.5M */
+	} else {
+		ifccr &= ~0xf00000;
+		if (clk->rate == CLOCK_33M)
+			ifccr |= 0x800000;
+		else
+			ifccr |= 0x400000; /* 62.5M */
+	}
+	ltq_cgu_w32(ifccr, CGU_IFCCR);
+	pmu_enable(clk);
+	return 0;
+}
+
+/* enable the external clock as a source */
+static int pci_ext_enable(struct clk *clk)
+{
+	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) & ~(1 << 16),
+		CGU_IFCCR);
+	ltq_cgu_w32((1 << 30), CGU_PCICR);
+	return 0;
+}
+
+/* disable the external clock as a source */
+static void pci_ext_disable(struct clk *clk)
+{
+	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) | (1 << 16),
+		CGU_IFCCR);
+	ltq_cgu_w32((1 << 31) | (1 << 30), CGU_PCICR);
+}
+
+/* enable a clockout source */
+static int clkout_enable(struct clk *clk)
+{
+	int i;
+
+	/* get the correct rate */
+	for (i = 0; i < 4; i++) {
+		if (clk->rates[i] == clk->rate) {
+			int shift = 14 - (2 * clk->module);
+			unsigned int ifccr = ltq_cgu_r32(CGU_IFCCR);
+
+			ifccr &= ~(3 << shift);
+			ifccr |= i << shift;
+			ltq_cgu_w32(ifccr, CGU_IFCCR);
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/* manage the clock gates via PMU */
+static void clkdev_add_pmu(const char *dev, const char *con,
+					unsigned int module, unsigned int bits)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = dev;
+	clk->cl.con_id = con;
+	clk->cl.clk = clk;
+	clk->enable = pmu_enable;
+	clk->disable = pmu_disable;
+	clk->module = module;
+	clk->bits = bits;
+	clkdev_add(&clk->cl);
+}
+
+/* manage the clock generator */
+static void clkdev_add_cgu(const char *dev, const char *con,
+					unsigned int bits)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = dev;
+	clk->cl.con_id = con;
+	clk->cl.clk = clk;
+	clk->enable = cgu_enable;
+	clk->disable = cgu_disable;
+	clk->bits = bits;
+	clkdev_add(&clk->cl);
+}
+
+/* pci needs its own enable function as the setup is a bit more complex */
+static unsigned long valid_pci_rates[] = {CLOCK_33M, CLOCK_62_5M, 0};
+
+static void clkdev_add_pci(void)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+	struct clk *clk_ext = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	/* main pci clock */
+	clk->cl.dev_id = "17000000.pci";
+	clk->cl.con_id = NULL;
+	clk->cl.clk = clk;
+	clk->rate = CLOCK_33M;
+	clk->rates = valid_pci_rates;
+	clk->enable = pci_enable;
+	clk->disable = pmu_disable;
+	clk->module = 0;
+	clk->bits = PMU_PCI;
+	clkdev_add(&clk->cl);
+
+	/* use internal/external bus clock */
+	clk_ext->cl.dev_id = "17000000.pci";
+	clk_ext->cl.con_id = "external";
+	clk_ext->cl.clk = clk_ext;
+	clk_ext->enable = pci_ext_enable;
+	clk_ext->disable = pci_ext_disable;
+	clkdev_add(&clk_ext->cl);
+}
+
+/* xway socs can generate clocks on gpio pins */
+static unsigned long valid_clkout_rates[4][5] = {
+	{CLOCK_32_768K, CLOCK_1_536M, CLOCK_2_5M, CLOCK_12M, 0},
+	{CLOCK_40M, CLOCK_12M, CLOCK_24M, CLOCK_48M, 0},
+	{CLOCK_25M, CLOCK_40M, CLOCK_30M, CLOCK_60M, 0},
+	{CLOCK_12M, CLOCK_50M, CLOCK_32_768K, CLOCK_25M, 0},
+};
+
+static void clkdev_add_clkout(void)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		struct clk *clk;
+		char *name;
+
+		name = kzalloc(sizeof("clkout0"), GFP_KERNEL);
+		sprintf(name, "clkout%d", i);
+
+		clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+		clk->cl.dev_id = "1f103000.cgu";
+		clk->cl.con_id = name;
+		clk->cl.clk = clk;
+		clk->rate = 0;
+		clk->rates = valid_clkout_rates[i];
+		clk->enable = clkout_enable;
+		clk->module = i;
+		clkdev_add(&clk->cl);
+	}
+}
+
+/* bring up all register ranges that we need for basic system control */
+void __init ltq_soc_init(void)
+{
+	struct resource res_pmu, res_cgu, res_ebu;
+	struct device_node *np_pmu =
+			of_find_compatible_node(NULL, NULL, "lantiq,pmu-xway");
+	struct device_node *np_cgu =
+			of_find_compatible_node(NULL, NULL, "lantiq,cgu-xway");
+	struct device_node *np_ebu =
+			of_find_compatible_node(NULL, NULL, "lantiq,ebu-xway");
+
+	/* check if all the core register ranges are available */
+	if (!np_pmu || !np_cgu || !np_ebu)
+		panic("Failed to load core nodess from devicetree");
+
+	if (of_address_to_resource(np_pmu, 0, &res_pmu) ||
+			of_address_to_resource(np_cgu, 0, &res_cgu) ||
+			of_address_to_resource(np_ebu, 0, &res_ebu))
+		panic("Failed to get core resources");
+
+	if ((request_mem_region(res_pmu.start, resource_size(&res_pmu),
+				res_pmu.name) < 0) ||
+		(request_mem_region(res_cgu.start, resource_size(&res_cgu),
+				res_cgu.name) < 0) ||
+		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
+				res_ebu.name) < 0))
+		pr_err("Failed to request core reources");
+
+	pmu_membase = ioremap_nocache(res_pmu.start, resource_size(&res_pmu));
+	ltq_cgu_membase = ioremap_nocache(res_cgu.start,
+						resource_size(&res_cgu));
+	ltq_ebu_membase = ioremap_nocache(res_ebu.start,
+						resource_size(&res_ebu));
+	if (!pmu_membase || !ltq_cgu_membase || !ltq_ebu_membase)
+		panic("Failed to remap core resources");
+
+	/* make sure to unprotect the memory region where flash is located */
+	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
+
+	/* add our generic xway clocks */
+	clkdev_add_pmu("10000000.fpi", NULL, 0, PMU_FPI);
+	clkdev_add_pmu("1e100400.serial", NULL, 0, PMU_ASC0);
+	clkdev_add_pmu("1e100a00.gptu", NULL, 0, PMU_GPT);
+	clkdev_add_pmu("1e100bb0.stp", NULL, 0, PMU_STP);
+	clkdev_add_pmu("1e104100.dma", NULL, 0, PMU_DMA);
+	clkdev_add_pmu("1e100800.spi", NULL, 0, PMU_SPI);
+	clkdev_add_pmu("1e105300.ebu", NULL, 0, PMU_EBU);
+	clkdev_add_clkout();
+
+	/* add the soc dependent clocks */
+	if (!of_machine_is_compatible("lantiq,vr9"))
+		clkdev_add_pmu("1e180000.etop", NULL, 0, PMU_PPE);
+
+	if (!of_machine_is_compatible("lantiq,ase")) {
+		clkdev_add_pmu("1e100c00.serial", NULL, 0, PMU_ASC1);
+		clkdev_add_pci();
+	}
+
+	if (of_machine_is_compatible("lantiq,ase")) {
+		if (ltq_cgu_r32(CGU_SYS) & (1 << 5))
+			clkdev_add_static(CLOCK_266M, CLOCK_133M, CLOCK_133M);
+		else
+			clkdev_add_static(CLOCK_133M, CLOCK_133M, CLOCK_133M);
+		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY),
+		clkdev_add_pmu("1e180000.etop", "ephy", 0, PMU_EPHY);
+	} else if (of_machine_is_compatible("lantiq,vr9")) {
+		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
+				ltq_vr9_fpi_hz());
+		clkdev_add_pmu("1d900000.pcie", "phy", 1, PMU1_PCIE_PHY);
+		clkdev_add_pmu("1d900000.pcie", "bus", 0, PMU_PCIE_CLK);
+		clkdev_add_pmu("1d900000.pcie", "msi", 1, PMU1_PCIE_MSI);
+		clkdev_add_pmu("1d900000.pcie", "pdi", 1, PMU1_PCIE_PDI);
+		clkdev_add_pmu("1d900000.pcie", "ctl", 1, PMU1_PCIE_CTL);
+		clkdev_add_pmu("1d900000.pcie", "ahb", 0, PMU_AHBM | PMU_AHBS);
+	} else if (of_machine_is_compatible("lantiq,ar9")) {
+		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
+				ltq_ar9_fpi_hz());
+		clkdev_add_pmu("1e180000.etop", "switch", 0, PMU_SWITCH);
+	} else {
+		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
+				ltq_danube_fpi_hz());
+	}
+}
-- 
1.7.9.1
