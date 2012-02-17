Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:37:52 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36942 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903698Ab2BQKdi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:38 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/9] MIPS: lantiq: convert falcon to clkdev api
Date:   Fri, 17 Feb 2012 11:33:15 +0100
Message-Id: <1329474800-20979-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Unify prom/clock code and add clkdev hooks to sysctrl.c

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |    8 +-
 arch/mips/lantiq/falcon/Makefile                   |    2 +-
 arch/mips/lantiq/falcon/clk.c                      |   44 -------
 arch/mips/lantiq/falcon/sysctrl.c                  |  131 ++++++++++++--------
 4 files changed, 82 insertions(+), 103 deletions(-)
 delete mode 100644 arch/mips/lantiq/falcon/clk.c

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
index 1a4b836..59c4f56 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -95,6 +95,7 @@
 
 /* Activation Status Register */
 #define ACTS_ASC1_ACT	0x00000800
+#define ACTS_I2C_ACT	0x00004000
 #define ACTS_P0		0x00010000
 #define ACTS_P1		0x00010000
 #define ACTS_P2		0x00020000
@@ -106,13 +107,6 @@
 #define ACTS_PADCTRL3	0x00200000
 #define ACTS_PADCTRL4	0x00400000
 
-extern void ltq_sysctl_activate(int module, unsigned int mask);
-extern void ltq_sysctl_deactivate(int module, unsigned int mask);
-extern void ltq_sysctl_clken(int module, unsigned int mask);
-extern void ltq_sysctl_clkdis(int module, unsigned int mask);
-extern void ltq_sysctl_reboot(int module, unsigned int mask);
-extern int ltq_gpe_is_activated(unsigned int mask);
-
 /* global register ranges */
 extern void __iomem *ltq_ebu_membase;
 extern void __iomem *ltq_sys1_membase;
diff --git a/arch/mips/lantiq/falcon/Makefile b/arch/mips/lantiq/falcon/Makefile
index 56b22eb..3634154 100644
--- a/arch/mips/lantiq/falcon/Makefile
+++ b/arch/mips/lantiq/falcon/Makefile
@@ -1,2 +1,2 @@
-obj-y := clk.o prom.o reset.o sysctrl.o devices.o gpio.o
+obj-y := prom.o reset.o sysctrl.o devices.o gpio.o
 obj-$(CONFIG_LANTIQ_MACH_EASY98000) += mach-easy98000.o
diff --git a/arch/mips/lantiq/falcon/clk.c b/arch/mips/lantiq/falcon/clk.c
deleted file mode 100644
index afe1b52..0000000
--- a/arch/mips/lantiq/falcon/clk.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- *
- * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
- * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/ioport.h>
-#include <linux/export.h>
-
-#include <lantiq_soc.h>
-
-#include "devices.h"
-
-/* CPU0 Clock Control Register */
-#define LTQ_SYS1_CPU0CC		0x0040
-/* clock divider bit */
-#define LTQ_CPU0CC_CPUDIV	0x0001
-
-unsigned int
-ltq_get_io_region_clock(void)
-{
-	return CLOCK_200M;
-}
-EXPORT_SYMBOL(ltq_get_io_region_clock);
-
-unsigned int
-ltq_get_cpu_hz(void)
-{
-	if (ltq_sys1_r32(LTQ_SYS1_CPU0CC) & LTQ_CPU0CC_CPUDIV)
-		return CLOCK_200M;
-	else
-		return CLOCK_400M;
-}
-EXPORT_SYMBOL(ltq_get_cpu_hz);
-
-unsigned int
-ltq_get_fpi_hz(void)
-{
-	return CLOCK_100M;
-}
-EXPORT_SYMBOL(ltq_get_fpi_hz);
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 905a142..08eca20 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -9,11 +9,13 @@
 
 #include <linux/ioport.h>
 #include <linux/export.h>
+#include <linux/clkdev.h>
 #include <asm/delay.h>
 
 #include <lantiq_soc.h>
 
 #include "devices.h"
+#include "../clk.h"
 
 /* infrastructure control register */
 #define SYS1_INFRAC		0x00bc
@@ -38,6 +40,10 @@
 #define LTQ_SYSCTL_DEACT	0x0028
 /* reboot Register */
 #define LTQ_SYSCTL_RBT		0x002c
+/* CPU0 Clock Control Register */
+#define LTQ_SYS1_CPU0CC         0x0040
+/* clock divider bit */
+#define LTQ_CPU0CC_CPUDIV       0x0001
 
 static struct resource ltq_sysctl_res[] = {
 	MEM_RES("sys1", LTQ_SYS1_BASE_ADDR, LTQ_SYS1_SIZE),
@@ -64,79 +70,67 @@ void __iomem *ltq_ebu_membase;
 #define ltq_status_r32(x)	ltq_r32(ltq_status_membase + (x))
 
 static inline void
-ltq_sysctl_wait(int module, unsigned int mask,
+ltq_sysctl_wait(struct clk *clk,
 		unsigned int test, unsigned int reg)
 {
 	int err = 1000000;
 
-	do {} while (--err && ((ltq_reg_r32(module, reg)
-					& mask) != test));
+	do {} while (--err && ((ltq_reg_r32(clk->module, reg)
+					& clk->bits) != test));
 	if (!err)
-		pr_err("module de/activation failed %d %08X %08X\n",
-							module, mask, test);
+		pr_err("module de/activation failed %d %08X %08X %08X\n",
+				clk->module, clk->bits, test,
+				ltq_reg_r32(clk->module, reg) & clk->bits);
 }
 
-void
-ltq_sysctl_activate(int module, unsigned int mask)
+static int
+ltq_sysctl_activate(struct clk *clk)
 {
-	if (module > SYSCTL_SYSGPE)
-		return;
-
-	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKEN);
-	ltq_reg_w32(module, mask, LTQ_SYSCTL_ACT);
-	ltq_sysctl_wait(module, mask, mask, LTQ_SYSCTL_ACTS);
+	ltq_reg_w32(clk->module, clk->bits, LTQ_SYSCTL_CLKEN);
+	ltq_reg_w32(clk->module, clk->bits, LTQ_SYSCTL_ACT);
+	ltq_sysctl_wait(clk, clk->bits, LTQ_SYSCTL_ACTS);
+	return 0;
 }
-EXPORT_SYMBOL(ltq_sysctl_activate);
 
-void
-ltq_sysctl_deactivate(int module, unsigned int mask)
+static void
+ltq_sysctl_deactivate(struct clk *clk)
 {
-	if (module > SYSCTL_SYSGPE)
-		return;
-
-	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKCLR);
-	ltq_reg_w32(module, mask, LTQ_SYSCTL_DEACT);
-	ltq_sysctl_wait(module, mask, 0, LTQ_SYSCTL_ACTS);
+	ltq_reg_w32(clk->module, clk->bits, LTQ_SYSCTL_CLKCLR);
+	ltq_reg_w32(clk->module, clk->bits, LTQ_SYSCTL_DEACT);
+	ltq_sysctl_wait(clk, 0, LTQ_SYSCTL_ACTS);
 }
-EXPORT_SYMBOL(ltq_sysctl_deactivate);
 
-void
-ltq_sysctl_clken(int module, unsigned int mask)
+static int
+ltq_sysctl_clken(struct clk *clk)
 {
-	if (module > SYSCTL_SYSGPE)
-		return;
-
-	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKEN);
-	ltq_sysctl_wait(module, mask, mask, LTQ_SYSCTL_CLKS);
+	ltq_reg_w32(clk->module, clk->bits, LTQ_SYSCTL_CLKEN);
+	ltq_sysctl_wait(clk, clk->bits, LTQ_SYSCTL_CLKS);
+	return 0;
 }
-EXPORT_SYMBOL(ltq_sysctl_clken);
 
-void
-ltq_sysctl_clkdis(int module, unsigned int mask)
+static void
+ltq_sysctl_clkdis(struct clk *clk)
 {
-	if (module > SYSCTL_SYSGPE)
-		return;
-
-	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKCLR);
-	ltq_sysctl_wait(module, mask, 0, LTQ_SYSCTL_CLKS);
+	ltq_reg_w32(clk->module, clk->bits, LTQ_SYSCTL_CLKCLR);
+	ltq_sysctl_wait(clk, 0, LTQ_SYSCTL_CLKS);
 }
-EXPORT_SYMBOL(ltq_sysctl_clkdis);
 
-void
-ltq_sysctl_reboot(int module, unsigned int mask)
+static void
+ltq_sysctl_reboot(struct clk *clk)
 {
 	unsigned int act;
-
-	if (module > SYSCTL_SYSGPE)
-		return;
-
-	act = ltq_reg_r32(module, LTQ_SYSCTL_ACT);
-	if ((~act & mask) != 0)
-		ltq_sysctl_activate(module, ~act & mask);
-	ltq_reg_w32(module, act & mask, LTQ_SYSCTL_RBT);
-	ltq_sysctl_wait(module, mask, mask, LTQ_SYSCTL_ACTS);
+	unsigned int bits;
+
+	act = ltq_reg_r32(clk->module, LTQ_SYSCTL_ACT);
+	bits = ~act & clk->bits;
+	if (bits != 0) {
+		ltq_reg_w32(clk->module, bits, LTQ_SYSCTL_CLKEN);
+		ltq_reg_w32(clk->module, bits, LTQ_SYSCTL_ACT);
+		ltq_sysctl_wait(clk, bits, LTQ_SYSCTL_ACTS);
+	}
+	ltq_reg_w32(clk->module, act & clk->bits, LTQ_SYSCTL_RBT);
+	ltq_sysctl_wait(clk, clk->bits, LTQ_SYSCTL_ACTS);
 }
-EXPORT_SYMBOL(ltq_sysctl_reboot);
 
 /* enable the ONU core */
 static void
@@ -167,6 +161,24 @@ ltq_gpe_enable(void)
 	udelay(1);
 }
 
+static inline void
+clkdev_add_sys(const char *dev, unsigned int module,
+				unsigned int bits)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = dev;
+	clk->cl.con_id = NULL;
+	clk->cl.clk = clk;
+	clk->module = module;
+	clk->activate = ltq_sysctl_activate;
+	clk->deactivate = ltq_sysctl_deactivate;
+	clk->enable = ltq_sysctl_clken;
+	clk->disable = ltq_sysctl_clkdis;
+	clk->reboot = ltq_sysctl_reboot;
+	clkdev_add(&clk->cl);
+}
+
 void __init
 ltq_soc_init(void)
 {
@@ -180,4 +192,21 @@ ltq_soc_init(void)
 	ltq_ebu_membase = ltq_remap_resource(&ltq_ebu_res);
 
 	ltq_gpe_enable();
+
+	/* get our 3 static rates for cpu, fpi and io clocks */
+	if (ltq_sys1_r32(LTQ_SYS1_CPU0CC) & LTQ_CPU0CC_CPUDIV)
+		clkdev_add_static("cpu", CLOCK_200M);
+	else
+		clkdev_add_static("cpu", CLOCK_400M);
+	clkdev_add_static("fpi", CLOCK_100M);
+	clkdev_add_static("io", CLOCK_200M);
+
+	/* add our clock domains */
+	clkdev_add_sys("gpio0", SYSCTL_SYSETH, ACTS_PADCTRL0 | ACTS_P0);
+	clkdev_add_sys("gpio1", SYSCTL_SYS1, ACTS_PADCTRL1 | ACTS_P1);
+	clkdev_add_sys("gpio2", SYSCTL_SYSETH, ACTS_PADCTRL2 | ACTS_P2);
+	clkdev_add_sys("gpio3", SYSCTL_SYS1, ACTS_PADCTRL3 | ACTS_P3);
+	clkdev_add_sys("gpio4", SYSCTL_SYS1, ACTS_PADCTRL4 | ACTS_P4);
+	clkdev_add_sys("i2c", SYSCTL_SYS1, ACTS_I2C_ACT);
+	clkdev_add_sys("asc-debug", SYSCTL_SYS1, ACTS_ASC1_ACT);
 }
-- 
1.7.7.1
