Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:37:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36938 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903697Ab2BQKdi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:38 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/9] MIPS: lantiq: convert xway to clkdev api
Date:   Fri, 17 Feb 2012 11:33:14 +0100
Message-Id: <1329474800-20979-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Unify xway/ase clock code and add clkdev hooks to sysctrl.c

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   13 -
 arch/mips/lantiq/xway/Makefile                     |    6 +-
 arch/mips/lantiq/xway/clk-ase.c                    |   48 ----
 arch/mips/lantiq/xway/clk-xway.c                   |  223 ----------------
 arch/mips/lantiq/xway/clk.c                        |  266 ++++++++++++++++++++
 arch/mips/lantiq/xway/sysctrl.c                    |  106 +++++++-
 6 files changed, 366 insertions(+), 296 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/clk-ase.c
 delete mode 100644 arch/mips/lantiq/xway/clk-xway.c
 create mode 100644 arch/mips/lantiq/xway/clk.c

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 4213926..6dfb65e 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -81,15 +81,6 @@
 #define LTQ_PMU_BASE_ADDR	0x1F102000
 #define LTQ_PMU_SIZE		0x1000
 
-#define PMU_DMA			0x0020
-#define PMU_EPHY		0x0080
-#define PMU_USB			0x8041
-#define PMU_LED			0x0800
-#define PMU_GPT			0x1000
-#define PMU_PPE			0x2000
-#define PMU_FPI			0x4000
-#define PMU_SWITCH		0x10000000
-
 /* ETOP - ethernet */
 #define LTQ_ETOP_BASE_ADDR	0x1E180000
 #define LTQ_ETOP_SIZE		0x40000
@@ -167,10 +158,6 @@ static inline void ltq_cgu_w32_mask(u32 c, u32 s, u32 r)
 	ltq_cgu_w32((ltq_cgu_r32(r) & ~(c)) | (s), r);
 }
 
-extern void ltq_pmu_enable(unsigned int module);
-extern void ltq_pmu_disable(unsigned int module);
-extern void ltq_cgu_enable(unsigned int clk);
-
 static inline int ltq_is_ase(void)
 {
 	return (ltq_get_soc_type() == SOC_TYPE_AMAZON_SE);
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 6678402..4dcb96f 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,7 +1,7 @@
-obj-y := sysctrl.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
+obj-y := sysctrl.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o clk.o
 
-obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
+obj-$(CONFIG_SOC_XWAY) += prom-xway.o
+obj-$(CONFIG_SOC_AMAZON_SE) += prom-ase.o
 
 obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
 obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
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
index 0000000..88a1017
--- /dev/null
+++ b/arch/mips/lantiq/xway/clk.c
@@ -0,0 +1,266 @@
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
+static unsigned int ltq_ram_clocks[] = {
+	CLOCK_167M, CLOCK_133M, CLOCK_111M, CLOCK_83M };
+#define DDR_HZ ltq_ram_clocks[ltq_cgu_r32(LTQ_CGU_SYS) & 0x3]
+
+#define BASIC_FREQUENCY_1	35328000
+#define BASIC_FREQUENCY_2	36000000
+#define BASIS_REQUENCY_USB	12000000
+
+#define GET_BITS(x, msb, lsb) \
+	(((x) & ((1 << ((msb) + 1)) - 1)) >> (lsb))
+
+/* legacy xway clock */
+#define LTQ_CGU_PLL0_CFG	0x0004
+#define LTQ_CGU_PLL1_CFG	0x0008
+#define LTQ_CGU_PLL2_CFG	0x000C
+#define LTQ_CGU_SYS		0x0010
+#define LTQ_CGU_UPDATE		0x0014
+#define LTQ_CGU_IF_CLK		0x0018
+#define LTQ_CGU_OSC_CON		0x001C
+#define LTQ_CGU_SMD		0x0020
+#define LTQ_CGU_CT1SR		0x0028
+#define LTQ_CGU_CT2SR		0x002C
+#define LTQ_CGU_PCMCR		0x0030
+#define LTQ_CGU_PCI_CR		0x0034
+#define LTQ_CGU_PD_PC		0x0038
+#define LTQ_CGU_FMR		0x003C
+
+#define CGU_PLL0_PHASE_DIVIDER_ENABLE	\
+	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 31))
+#define CGU_PLL0_BYPASS			\
+	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 30))
+#define CGU_PLL0_CFG_DSMSEL		\
+	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 28))
+#define CGU_PLL0_CFG_FRAC_EN		\
+	(ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & (1 << 27))
+#define CGU_PLL1_SRC			\
+	(ltq_cgu_r32(LTQ_CGU_PLL1_CFG) & (1 << 31))
+#define CGU_PLL2_PHASE_DIVIDER_ENABLE	\
+	(ltq_cgu_r32(LTQ_CGU_PLL2_CFG) & (1 << 20))
+#define CGU_SYS_FPI_SEL			(1 << 6)
+#define CGU_SYS_DDR_SEL			0x3
+#define CGU_PLL0_SRC			(1 << 29)
+
+#define CGU_PLL0_CFG_PLLK	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL0_CFG), 26, 17)
+#define CGU_PLL0_CFG_PLLN	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL0_CFG), 12, 6)
+#define CGU_PLL0_CFG_PLLM	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL0_CFG), 5, 2)
+#define CGU_PLL2_SRC		GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL2_CFG), 18, 17)
+#define CGU_PLL2_CFG_INPUT_DIV	GET_BITS(ltq_cgu_r32(LTQ_CGU_PLL2_CFG), 16, 13)
+
+/* vr9 clock */
+#define LTQ_CGU_SYS_VR9	0x0c
+#define LTQ_CGU_IF_CLK_VR9	0x24
+
+
+static unsigned int ltq_get_pll0_fdiv(void);
+
+static inline unsigned int get_input_clock(int pll)
+{
+	switch (pll) {
+	case 0:
+		if (ltq_cgu_r32(LTQ_CGU_PLL0_CFG) & CGU_PLL0_SRC)
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
+static inline unsigned int cal_dsm(int pll, unsigned int num, unsigned int den)
+{
+	u64 res, clock = get_input_clock(pll);
+
+	res = num * clock;
+	do_div(res, den);
+	return res;
+}
+
+static inline unsigned int mash_dsm(int pll, unsigned int M, unsigned int N,
+	unsigned int K)
+{
+	unsigned int num = ((N + 1) << 10) + K;
+	unsigned int den = (M + 1) << 10;
+
+	return cal_dsm(pll, num, den);
+}
+
+static inline unsigned int ssff_dsm_1(int pll, unsigned int M, unsigned int N,
+	unsigned int K)
+{
+	unsigned int num = ((N + 1) << 11) + K + 512;
+	unsigned int den = (M + 1) << 11;
+
+	return cal_dsm(pll, num, den);
+}
+
+static inline unsigned int ssff_dsm_2(int pll, unsigned int M, unsigned int N,
+	unsigned int K)
+{
+	unsigned int num = K >= 512 ?
+		((N + 1) << 12) + K - 512 : ((N + 1) << 12) + K + 3584;
+	unsigned int den = (M + 1) << 12;
+
+	return cal_dsm(pll, num, den);
+}
+
+static inline unsigned int dsm(int pll, unsigned int M, unsigned int N,
+	unsigned int K, unsigned int dsmsel, unsigned int phase_div_en)
+{
+	if (!dsmsel)
+		return mash_dsm(pll, M, N, K);
+	else if (!phase_div_en)
+		return mash_dsm(pll, M, N, K);
+	else
+		return ssff_dsm_2(pll, M, N, K);
+}
+
+static inline unsigned int ltq_get_pll0_fosc(void)
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
+static unsigned int ltq_get_pll0_fdiv(void)
+{
+	unsigned int div = CGU_PLL2_CFG_INPUT_DIV + 1;
+
+	return (ltq_get_pll0_fosc() + (div >> 1)) / div;
+}
+
+unsigned long ltq_danube_io_region_clock(void)
+{
+	unsigned int ret = ltq_get_pll0_fosc();
+
+	switch (ltq_cgu_r32(LTQ_CGU_PLL2_CFG) & CGU_SYS_DDR_SEL) {
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
+
+unsigned long ltq_danube_fpi_bus_clock(int fpi)
+{
+	unsigned long ret = ltq_danube_io_region_clock();
+
+	if ((fpi == 2) && (ltq_cgu_r32(LTQ_CGU_SYS) & CGU_SYS_FPI_SEL))
+		ret >>= 1;
+	return ret;
+}
+
+unsigned long ltq_danube_cpu_hz(void)
+{
+	switch (ltq_cgu_r32(LTQ_CGU_SYS) & 0xc) {
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
+unsigned long ltq_danube_fpi_hz(void)
+{
+	unsigned long ddr_clock = DDR_HZ;
+
+	if (ltq_cgu_r32(LTQ_CGU_SYS) & 0x40)
+		return ddr_clock >> 1;
+	return ddr_clock;
+}
+
+unsigned long ltq_vr9_cpu_hz(void)
+{
+	long clks[] = {
+		CLOCK_600M, CLOCK_500M,	CLOCK_393M, CLOCK_333M,
+		CLOCK_125M, CLOCK_125M, CLOCK_196_608M, CLOCK_166M,
+		CLOCK_125M, CLOCK_125M };
+	int val = (ltq_cgu_r32(LTQ_CGU_SYS_VR9) >> 4) & 0xf;
+
+	if (val > 9)
+		panic("bad cpu speed");
+	if (val == 2)
+		panic("missing workaround");
+	return clks[val];
+}
+
+unsigned long ltq_vr9_fpi_hz(void)
+{
+	long clks[] = {
+		CLOCK_62_5M, CLOCK_62_5M, CLOCK_83_5M, CLOCK_125M,
+		CLOCK_125M, CLOCK_125M, CLOCK_167M, CLOCK_200M,
+		CLOCK_250M, CLOCK_300M, CLOCK_62_5M, CLOCK_98_304M,
+		CLOCK_150M, CLOCK_196_608M };
+	int val = ((ltq_cgu_r32(LTQ_CGU_IF_CLK_VR9) >> 25) & 0xf);
+
+	if (val > 13)
+		panic("bad fpi speed");
+	return clks[val];
+}
+
+unsigned long ltq_vr9_io_region_clock(void)
+{
+	return ltq_vr9_fpi_hz() / 2;
+}
+
+unsigned long ltq_vr9_fpi_bus_clock(int fpi)
+{
+	return ltq_vr9_fpi_hz();
+}
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 38c122f..879c89a 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -8,17 +8,48 @@
 
 #include <linux/ioport.h>
 #include <linux/export.h>
+#include <linux/clkdev.h>
 
 #include <lantiq_soc.h>
 
+#include "../clk.h"
 #include "../devices.h"
 
 /* clock control register */
 #define LTQ_CGU_IFCCR	0x0018
+/* system clock register */
+#define LTQ_CGU_SYS     0x0010
 
 /* the enable / disable registers */
 #define LTQ_PMU_PWDCR	0x1C
 #define LTQ_PMU_PWDSR	0x20
+#define LTQ_PMU_PWDCR1	0x24
+#define LTQ_PMU_PWDSR1	0x28
+
+#define PWDCR(x) ((x) ? (LTQ_PMU_PWDCR1) : (LTQ_PMU_PWDCR))
+#define PWDSR(x) ((x) ? (LTQ_PMU_PWDSR1) : (LTQ_PMU_PWDSR))
+
+/* CGU - clock generation unit */
+#define CGU_EPHY		0x10
+
+/* PMU - power management unit */
+#define PMU_DMA			0x0020
+#define PMU_SPI			0x0100
+#define PMU_EPHY		0x0080
+#define PMU_USB			0x8041
+#define PMU_STP			0x0800
+#define PMU_GPT			0x1000
+#define PMU_PPE			0x2000
+#define PMU_FPI			0x4000
+#define PMU_SWITCH		0x10000000
+#define PMU_AHBS		0x2000
+#define PMU_AHBM		0x8000
+#define PMU_PCIE_CLK            0x80000000
+
+#define PMU1_PCIE_PHY		0x0001
+#define PMU1_PCIE_CTL		0x0002
+#define PMU1_PCIE_MSI		0x0020
+#define PMU1_PCIE_PDI		0x0010
 
 #define ltq_pmu_w32(x, y)	ltq_w32((x), ltq_pmu_membase + (y))
 #define ltq_pmu_r32(x)		ltq_r32(ltq_pmu_membase + (x))
@@ -36,28 +67,63 @@ void __iomem *ltq_cgu_membase;
 void __iomem *ltq_ebu_membase;
 static void __iomem *ltq_pmu_membase;
 
-void ltq_cgu_enable(unsigned int clk)
+static int ltq_cgu_enable(struct clk *clk)
 {
-	ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | clk, LTQ_CGU_IFCCR);
+	ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | clk->bits, LTQ_CGU_IFCCR);
+	return 0;
 }
 
-void ltq_pmu_enable(unsigned int module)
+static void ltq_cgu_disable(struct clk *clk)
+{
+	ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~clk->bits, LTQ_CGU_IFCCR);
+}
+
+static int ltq_pmu_enable(struct clk *clk)
 {
 	int err = 1000000;
 
-	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) & ~module, LTQ_PMU_PWDCR);
-	do {} while (--err && (ltq_pmu_r32(LTQ_PMU_PWDSR) & module));
+	ltq_pmu_w32(ltq_pmu_r32(PWDCR(clk->module)) & ~clk->bits,
+		PWDCR(clk->module));
+	do {} while (--err && (ltq_pmu_r32(PWDSR(clk->module)) & clk->bits));
 
 	if (!err)
 		panic("activating PMU module failed!");
+
+	return 0;
 }
-EXPORT_SYMBOL(ltq_pmu_enable);
 
-void ltq_pmu_disable(unsigned int module)
+static void ltq_pmu_disable(struct clk *clk)
 {
-	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) | module, LTQ_PMU_PWDCR);
+	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) | clk->bits, LTQ_PMU_PWDCR);
+}
+
+static inline void clkdev_add_pmu(const char *dev, const char *con,
+	unsigned int module, unsigned int bits)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = dev;
+	clk->cl.con_id = con;
+	clk->cl.clk = clk;
+	clk->enable = ltq_pmu_enable;
+	clk->disable = ltq_pmu_disable;
+	clk->module = module;
+	clk->bits = bits;
+	clkdev_add(&clk->cl);
+}
+
+static inline void clkdev_add_cgu(const char *con, unsigned int bits)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = "fpi";
+	clk->cl.con_id = con;
+	clk->cl.clk = clk;
+	clk->enable = ltq_cgu_enable;
+	clk->disable = ltq_cgu_disable;
+	clk->bits = bits;
+	clkdev_add(&clk->cl);
 }
-EXPORT_SYMBOL(ltq_pmu_disable);
 
 void __init ltq_soc_init(void)
 {
@@ -75,4 +141,26 @@ void __init ltq_soc_init(void)
 
 	/* make sure to unprotect the memory region where flash is located */
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
+
+	/* add our clocks */
+	if (ltq_is_ase()) {
+		if (ltq_cgu_r32(LTQ_CGU_SYS) & (1 << 5))
+			clkdev_add_static("cpu", CLOCK_266M);
+		else
+			clkdev_add_static("cpu", CLOCK_133M);
+		clkdev_add_static("fpi", CLOCK_133M);
+		clkdev_add_static("io", CLOCK_133M);
+		clkdev_add_cgu("ephycgu", CGU_EPHY),
+		clkdev_add_pmu("fpi", "ephy", 0, PMU_EPHY);
+	} else {
+		clkdev_add_static("cpu", ltq_danube_cpu_hz());
+		clkdev_add_static("fpi", ltq_danube_fpi_hz());
+		clkdev_add_static("io", ltq_danube_io_region_clock());
+		if (ltq_is_ar9())
+			clkdev_add_pmu("fpi", "switch", 0, PMU_SWITCH);
+	}
+	clkdev_add_pmu("fpi", "dma", 0, PMU_DMA);
+	clkdev_add_pmu("fpi", "stp", 0, PMU_STP);
+	clkdev_add_pmu("fpi", "spi", 0, PMU_SPI);
+	clkdev_add_pmu("fpi", "ppe", 0, PMU_PPE);
 }
-- 
1.7.7.1
