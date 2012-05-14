Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:51:23 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:36738 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903713Ab2ENRul (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:50:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [RESEND PATCH V2 15/17] MIPS: lantiq: implement support for FALCON soc
Date:   Mon, 14 May 2012 19:42:41 +0200
Message-Id: <1337017363-14424-15-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Adds support for the FALCON SoC. This SoC is from the FTTH/GPON SoC family.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../include/asm/mach-lantiq/falcon/falcon_irq.h    |   23 ++
 arch/mips/include/asm/mach-lantiq/falcon/irq.h     |   18 ++
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |   67 +++++
 arch/mips/lantiq/Kconfig                           |    4 +
 arch/mips/lantiq/Makefile                          |    1 +
 arch/mips/lantiq/Platform                          |    1 +
 arch/mips/lantiq/falcon/Makefile                   |    1 +
 arch/mips/lantiq/falcon/prom.c                     |   87 +++++++
 arch/mips/lantiq/falcon/reset.c                    |   90 +++++++
 arch/mips/lantiq/falcon/sysctrl.c                  |  260 ++++++++++++++++++++
 10 files changed, 552 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
 create mode 100644 arch/mips/lantiq/falcon/Makefile
 create mode 100644 arch/mips/lantiq/falcon/prom.c
 create mode 100644 arch/mips/lantiq/falcon/reset.c
 create mode 100644 arch/mips/lantiq/falcon/sysctrl.c

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
new file mode 100644
index 0000000..318f982
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
@@ -0,0 +1,23 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
+ */
+
+#ifndef _FALCON_IRQ__
+#define _FALCON_IRQ__
+
+#define INT_NUM_IRQ0			8
+#define INT_NUM_IM0_IRL0		(INT_NUM_IRQ0 + 0)
+#define INT_NUM_IM1_IRL0		(INT_NUM_IM0_IRL0 + 32)
+#define INT_NUM_IM2_IRL0		(INT_NUM_IM1_IRL0 + 32)
+#define INT_NUM_IM3_IRL0		(INT_NUM_IM2_IRL0 + 32)
+#define INT_NUM_IM4_IRL0		(INT_NUM_IM3_IRL0 + 32)
+#define INT_NUM_EXTRA_START		(INT_NUM_IM4_IRL0 + 32)
+#define INT_NUM_IM_OFFSET		(INT_NUM_IM1_IRL0 - INT_NUM_IM0_IRL0)
+
+#define MIPS_CPU_TIMER_IRQ			7
+
+#endif /* _FALCON_IRQ__ */
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/irq.h b/arch/mips/include/asm/mach-lantiq/falcon/irq.h
new file mode 100644
index 0000000..2caccd9
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/irq.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ */
+
+#ifndef __FALCON_IRQ_H
+#define __FALCON_IRQ_H
+
+#include <falcon_irq.h>
+
+#define NR_IRQS 328
+
+#include_next <irq.h>
+
+#endif
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
new file mode 100644
index 0000000..b385252
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -0,0 +1,67 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_FALCON_H__
+#define _LTQ_FALCON_H__
+
+#ifdef CONFIG_SOC_FALCON
+
+#include <linux/pinctrl/pinctrl.h>
+#include <lantiq.h>
+
+/* Chip IDs */
+#define SOC_ID_FALCON		0x01B8
+
+/* SoC Types */
+#define SOC_TYPE_FALCON		0x01
+
+/*
+ * during early_printk no ioremap possible at this early stage
+ * lets use KSEG1 instead
+ */
+#define LTQ_ASC0_BASE_ADDR	0x1E100C00
+#define LTQ_EARLY_ASC		KSEG1ADDR(LTQ_ASC0_BASE_ADDR)
+
+/* WDT */
+#define LTQ_RST_CAUSE_WDTRST	0x0002
+
+/* CHIP ID */
+#define LTQ_STATUS_BASE_ADDR	0x1E802000
+
+#define FALCON_CHIPID		((u32 *)(KSEG1 + LTQ_STATUS_BASE_ADDR + 0x0c))
+#define FALCON_CHIPTYPE		((u32 *)(KSEG1 + LTQ_STATUS_BASE_ADDR + 0x38))
+#define FALCON_CHIPCONF		((u32 *)(KSEG1 + LTQ_STATUS_BASE_ADDR + 0x40))
+
+/* SYSCTL - start/stop/restart/configure/... different parts of the Soc */
+#define SYSCTL_SYS1		0
+#define SYSCTL_SYSETH		1
+#define SYSCTL_SYSGPE		2
+
+/* BOOT_SEL - find what boot media we have */
+#define BS_FLASH		0x1
+#define BS_SPI                  0x4
+
+/* global register ranges */
+extern __iomem void *ltq_ebu_membase;
+extern __iomem void *ltq_sys1_membase;
+#define ltq_ebu_w32(x, y)	ltq_w32((x), ltq_ebu_membase + (y))
+#define ltq_ebu_r32(x)		ltq_r32(ltq_ebu_membase + (x))
+
+#define ltq_sys1_w32(x, y)	ltq_w32((x), ltq_sys1_membase + (y))
+#define ltq_sys1_r32(x)		ltq_r32(ltq_sys1_membase + (x))
+#define ltq_sys1_w32_mask(clear, set, reg)   \
+	ltq_sys1_w32((ltq_sys1_r32(reg) & ~(clear)) | (set), reg)
+
+/*
+ * to keep the irq code generic we need to define this to 0 as falcon
+ * has no EIU/EBU
+ */
+#define LTQ_EBU_PCC_ISTAT	0
+
+#endif /* CONFIG_SOC_FALCON */
+#endif /* _LTQ_XWAY_H__ */
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 7389098..20bdf40 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -16,6 +16,10 @@ config SOC_XWAY
 	bool "XWAY"
 	select SOC_TYPE_XWAY
 	select HW_HAS_PCI
+
+config SOC_FALCON
+	bool "FALCON"
+
 endchoice
 
 choice
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index 16f1c75..d6bdc57 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -11,3 +11,4 @@ obj-y += dts/
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 obj-$(CONFIG_SOC_TYPE_XWAY) += xway/
+obj-$(CONFIG_SOC_FALCON) += falcon/
diff --git a/arch/mips/lantiq/Platform b/arch/mips/lantiq/Platform
index f3dff05..b3ec498 100644
--- a/arch/mips/lantiq/Platform
+++ b/arch/mips/lantiq/Platform
@@ -6,3 +6,4 @@ platform-$(CONFIG_LANTIQ)	+= lantiq/
 cflags-$(CONFIG_LANTIQ)		+= -I$(srctree)/arch/mips/include/asm/mach-lantiq
 load-$(CONFIG_LANTIQ)		= 0xffffffff80002000
 cflags-$(CONFIG_SOC_TYPE_XWAY)	+= -I$(srctree)/arch/mips/include/asm/mach-lantiq/xway
+cflags-$(CONFIG_SOC_FALCON)	+= -I$(srctree)/arch/mips/include/asm/mach-lantiq/falcon
diff --git a/arch/mips/lantiq/falcon/Makefile b/arch/mips/lantiq/falcon/Makefile
new file mode 100644
index 0000000..ff220f9
--- /dev/null
+++ b/arch/mips/lantiq/falcon/Makefile
@@ -0,0 +1 @@
+obj-y := prom.o reset.o sysctrl.o
diff --git a/arch/mips/lantiq/falcon/prom.c b/arch/mips/lantiq/falcon/prom.c
new file mode 100644
index 0000000..c1d278f
--- /dev/null
+++ b/arch/mips/lantiq/falcon/prom.c
@@ -0,0 +1,87 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2012 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <asm/io.h>
+
+#include <lantiq_soc.h>
+
+#include "../prom.h"
+
+#define SOC_FALCON	"Falcon"
+#define SOC_FALCON_D	"Falcon-D"
+#define SOC_FALCON_V	"Falcon-V"
+#define SOC_FALCON_M	"Falcon-M"
+
+#define COMP_FALCON	"lantiq,falcon"
+
+#define PART_SHIFT	12
+#define PART_MASK	0x0FFFF000
+#define REV_SHIFT	28
+#define REV_MASK	0xF0000000
+#define SREV_SHIFT	22
+#define SREV_MASK	0x03C00000
+#define TYPE_SHIFT	26
+#define TYPE_MASK	0x3C000000
+
+/* reset, nmi and ejtag exception vectors */
+#define BOOT_REG_BASE	(KSEG1 | 0x1F200000)
+#define BOOT_RVEC	(BOOT_REG_BASE | 0x00)
+#define BOOT_NVEC	(BOOT_REG_BASE | 0x04)
+#define BOOT_EVEC	(BOOT_REG_BASE | 0x08)
+
+void __init ltq_soc_nmi_setup(void)
+{
+	extern void (*nmi_handler)(void);
+
+	ltq_w32((unsigned long)&nmi_handler, (void *)BOOT_NVEC);
+}
+
+void __init ltq_soc_ejtag_setup(void)
+{
+	extern void (*ejtag_debug_handler)(void);
+
+	ltq_w32((unsigned long)&ejtag_debug_handler, (void *)BOOT_EVEC);
+}
+
+void __init ltq_soc_detect(struct ltq_soc_info *i)
+{
+	u32 type;
+	i->partnum = (ltq_r32(FALCON_CHIPID) & PART_MASK) >> PART_SHIFT;
+	i->rev = (ltq_r32(FALCON_CHIPID) & REV_MASK) >> REV_SHIFT;
+	i->srev = ((ltq_r32(FALCON_CHIPCONF) & SREV_MASK) >> SREV_SHIFT);
+	i->compatible = COMP_FALCON;
+	i->type = SOC_TYPE_FALCON;
+	sprintf(i->rev_type, "%c%d%d", (i->srev & 0x4) ? ('B') : ('A'),
+		i->rev & 0x7, (i->srev & 0x3) + 1);
+
+	switch (i->partnum) {
+	case SOC_ID_FALCON:
+		type = (ltq_r32(FALCON_CHIPTYPE) & TYPE_MASK) >> TYPE_SHIFT;
+		switch (type) {
+		case 0:
+			i->name = SOC_FALCON_D;
+			break;
+		case 1:
+			i->name = SOC_FALCON_V;
+			break;
+		case 2:
+			i->name = SOC_FALCON_M;
+			break;
+		default:
+			i->name = SOC_FALCON;
+			break;
+		}
+		break;
+
+	default:
+		unreachable();
+		break;
+	}
+}
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
new file mode 100644
index 0000000..5682482
--- /dev/null
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -0,0 +1,90 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2012 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <asm/reboot.h>
+#include <linux/export.h>
+
+#include <lantiq_soc.h>
+
+/* CPU0 Reset Source Register */
+#define SYS1_CPU0RS		0x0040
+/* reset cause mask */
+#define CPU0RS_MASK		0x0003
+/* CPU0 Boot Mode Register */
+#define SYS1_BM			0x00a0
+/* boot mode mask */
+#define BM_MASK			0x0005
+
+/* allow platform code to find out what surce we booted from */
+unsigned char ltq_boot_select(void)
+{
+	return ltq_sys1_r32(SYS1_BM) & BM_MASK;
+}
+
+/* allow the watchdog driver to find out what the boot reason was */
+int ltq_reset_cause(void)
+{
+	return ltq_sys1_r32(SYS1_CPU0RS) & CPU0RS_MASK;
+}
+EXPORT_SYMBOL_GPL(ltq_reset_cause);
+
+#define BOOT_REG_BASE	(KSEG1 | 0x1F200000)
+#define BOOT_PW1_REG	(BOOT_REG_BASE | 0x20)
+#define BOOT_PW2_REG	(BOOT_REG_BASE | 0x24)
+#define BOOT_PW1	0x4C545100
+#define BOOT_PW2	0x0051544C
+
+#define WDT_REG_BASE	(KSEG1 | 0x1F8803F0)
+#define WDT_PW1		0x00BE0000
+#define WDT_PW2		0x00DC0000
+
+static void machine_restart(char *command)
+{
+	local_irq_disable();
+
+	/* reboot magic */
+	ltq_w32(BOOT_PW1, (void *)BOOT_PW1_REG); /* 'LTQ\0' */
+	ltq_w32(BOOT_PW2, (void *)BOOT_PW2_REG); /* '\0QTL' */
+	ltq_w32(0, (void *)BOOT_REG_BASE); /* reset Bootreg RVEC */
+
+	/* watchdog magic */
+	ltq_w32(WDT_PW1, (void *)WDT_REG_BASE);
+	ltq_w32(WDT_PW2 |
+		(0x3 << 26) | /* PWL */
+		(0x2 << 24) | /* CLKDIV */
+		(0x1 << 31) | /* enable */
+		(1), /* reload */
+		(void *)WDT_REG_BASE);
+	unreachable();
+}
+
+static void machine_halt(void)
+{
+	local_irq_disable();
+	unreachable();
+}
+
+static void machine_power_off(void)
+{
+	local_irq_disable();
+	unreachable();
+}
+
+static int __init mips_reboot_setup(void)
+{
+	_machine_restart = machine_restart;
+	_machine_halt = machine_halt;
+	pm_power_off = machine_power_off;
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
new file mode 100644
index 0000000..ba0123d
--- /dev/null
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -0,0 +1,260 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/ioport.h>
+#include <linux/export.h>
+#include <linux/clkdev.h>
+#include <linux/of_address.h>
+#include <asm/delay.h>
+
+#include <lantiq_soc.h>
+
+#include "../clk.h"
+
+/* infrastructure control register */
+#define SYS1_INFRAC		0x00bc
+/* Configuration fuses for drivers and pll */
+#define STATUS_CONFIG		0x0040
+
+/* GPE frequency selection */
+#define GPPC_OFFSET		24
+#define GPEFREQ_MASK		0x00000C0
+#define GPEFREQ_OFFSET		10
+/* Clock status register */
+#define SYSCTL_CLKS		0x0000
+/* Clock enable register */
+#define SYSCTL_CLKEN		0x0004
+/* Clock clear register */
+#define SYSCTL_CLKCLR		0x0008
+/* Activation Status Register */
+#define SYSCTL_ACTS		0x0020
+/* Activation Register */
+#define SYSCTL_ACT		0x0024
+/* Deactivation Register */
+#define SYSCTL_DEACT		0x0028
+/* reboot Register */
+#define SYSCTL_RBT		0x002c
+/* CPU0 Clock Control Register */
+#define SYS1_CPU0CC		0x0040
+/* HRST_OUT_N Control Register */
+#define SYS1_HRSTOUTC		0x00c0
+/* clock divider bit */
+#define CPU0CC_CPUDIV		0x0001
+
+/* Activation Status Register */
+#define ACTS_ASC1_ACT	0x00000800
+#define ACTS_I2C_ACT	0x00004000
+#define ACTS_P0		0x00010000
+#define ACTS_P1		0x00010000
+#define ACTS_P2		0x00020000
+#define ACTS_P3		0x00020000
+#define ACTS_P4		0x00040000
+#define ACTS_PADCTRL0	0x00100000
+#define ACTS_PADCTRL1	0x00100000
+#define ACTS_PADCTRL2	0x00200000
+#define ACTS_PADCTRL3	0x00200000
+#define ACTS_PADCTRL4	0x00400000
+
+#define sysctl_w32(m, x, y)	ltq_w32((x), sysctl_membase[m] + (y))
+#define sysctl_r32(m, x)	ltq_r32(sysctl_membase[m] + (x))
+#define sysctl_w32_mask(m, clear, set, reg)	\
+		sysctl_w32(m, (sysctl_r32(m, reg) & ~(clear)) | (set), reg)
+
+#define status_w32(x, y)	ltq_w32((x), status_membase + (y))
+#define status_r32(x)		ltq_r32(status_membase + (x))
+
+static void __iomem *sysctl_membase[3], *status_membase;
+void __iomem *ltq_sys1_membase, *ltq_ebu_membase;
+
+void falcon_trigger_hrst(int level)
+{
+	sysctl_w32(SYSCTL_SYS1, level & 1, SYS1_HRSTOUTC);
+}
+
+static inline void sysctl_wait(struct clk *clk,
+		unsigned int test, unsigned int reg)
+{
+	int err = 1000000;
+
+	do {} while (--err && ((sysctl_r32(clk->module, reg)
+					& clk->bits) != test));
+	if (!err)
+		pr_err("module de/activation failed %d %08X %08X %08X\n",
+			clk->module, clk->bits, test,
+			sysctl_r32(clk->module, reg) & clk->bits);
+}
+
+static int sysctl_activate(struct clk *clk)
+{
+	sysctl_w32(clk->module, clk->bits, SYSCTL_CLKEN);
+	sysctl_w32(clk->module, clk->bits, SYSCTL_ACT);
+	sysctl_wait(clk, clk->bits, SYSCTL_ACTS);
+	return 0;
+}
+
+static void sysctl_deactivate(struct clk *clk)
+{
+	sysctl_w32(clk->module, clk->bits, SYSCTL_CLKCLR);
+	sysctl_w32(clk->module, clk->bits, SYSCTL_DEACT);
+	sysctl_wait(clk, 0, SYSCTL_ACTS);
+}
+
+static int sysctl_clken(struct clk *clk)
+{
+	sysctl_w32(clk->module, clk->bits, SYSCTL_CLKEN);
+	sysctl_wait(clk, clk->bits, SYSCTL_CLKS);
+	return 0;
+}
+
+static void sysctl_clkdis(struct clk *clk)
+{
+	sysctl_w32(clk->module, clk->bits, SYSCTL_CLKCLR);
+	sysctl_wait(clk, 0, SYSCTL_CLKS);
+}
+
+static void sysctl_reboot(struct clk *clk)
+{
+	unsigned int act;
+	unsigned int bits;
+
+	act = sysctl_r32(clk->module, SYSCTL_ACT);
+	bits = ~act & clk->bits;
+	if (bits != 0) {
+		sysctl_w32(clk->module, bits, SYSCTL_CLKEN);
+		sysctl_w32(clk->module, bits, SYSCTL_ACT);
+		sysctl_wait(clk, bits, SYSCTL_ACTS);
+	}
+	sysctl_w32(clk->module, act & clk->bits, SYSCTL_RBT);
+	sysctl_wait(clk, clk->bits, SYSCTL_ACTS);
+}
+
+/* enable the ONU core */
+static void falcon_gpe_enable(void)
+{
+	unsigned int freq;
+	unsigned int status;
+
+	/* if if the clock is already enabled */
+	status = sysctl_r32(SYSCTL_SYS1, SYS1_INFRAC);
+	if (status & (1 << (GPPC_OFFSET + 1)))
+		return;
+
+	if (status_r32(STATUS_CONFIG) == 0)
+		freq = 1; /* use 625MHz on unfused chip */
+	else
+		freq = (status_r32(STATUS_CONFIG) &
+			GPEFREQ_MASK) >>
+			GPEFREQ_OFFSET;
+
+	/* apply new frequency */
+	sysctl_w32_mask(SYSCTL_SYS1, 7 << (GPPC_OFFSET + 1),
+		freq << (GPPC_OFFSET + 2) , SYS1_INFRAC);
+	udelay(1);
+
+	/* enable new frequency */
+	sysctl_w32_mask(SYSCTL_SYS1, 0, 1 << (GPPC_OFFSET + 1), SYS1_INFRAC);
+	udelay(1);
+}
+
+static inline void clkdev_add_sys(const char *dev, unsigned int module,
+					unsigned int bits)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = dev;
+	clk->cl.con_id = NULL;
+	clk->cl.clk = clk;
+	clk->module = module;
+	clk->activate = sysctl_activate;
+	clk->deactivate = sysctl_deactivate;
+	clk->enable = sysctl_clken;
+	clk->disable = sysctl_clkdis;
+	clk->reboot = sysctl_reboot;
+	clkdev_add(&clk->cl);
+}
+
+void __init ltq_soc_init(void)
+{
+	struct device_node *np_status =
+		of_find_compatible_node(NULL, NULL, "lantiq,status-falcon");
+	struct device_node *np_ebu =
+		of_find_compatible_node(NULL, NULL, "lantiq,ebu-falcon");
+	struct device_node *np_sys1 =
+		of_find_compatible_node(NULL, NULL, "lantiq,sys1-falcon");
+	struct device_node *np_syseth =
+		of_find_compatible_node(NULL, NULL, "lantiq,syseth-falcon");
+	struct device_node *np_sysgpe =
+		of_find_compatible_node(NULL, NULL, "lantiq,sysgpe-falcon");
+	struct resource res_status, res_ebu, res_sys[3];
+	int i;
+
+	/* check if all the core register ranges are available */
+	if (!np_status || !np_ebu || !np_sys1 || !np_syseth || !np_sysgpe)
+		panic("Failed to load core nodes from devicetree");
+
+	if (of_address_to_resource(np_status, 0, &res_status) ||
+			of_address_to_resource(np_ebu, 0, &res_ebu) ||
+			of_address_to_resource(np_sys1, 0, &res_sys[0]) ||
+			of_address_to_resource(np_syseth, 0, &res_sys[1]) ||
+			of_address_to_resource(np_sysgpe, 0, &res_sys[2]))
+		panic("Failed to get core resources");
+
+	if ((request_mem_region(res_status.start, resource_size(&res_status),
+				res_status.name) < 0) ||
+		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
+				res_ebu.name) < 0) ||
+		(request_mem_region(res_sys[0].start,
+				resource_size(&res_sys[0]),
+				res_sys[0].name) < 0) ||
+		(request_mem_region(res_sys[1].start,
+				resource_size(&res_sys[1]),
+				res_sys[1].name) < 0) ||
+		(request_mem_region(res_sys[2].start,
+				resource_size(&res_sys[2]),
+				res_sys[2].name) < 0))
+		pr_err("Failed to request core reources");
+
+	status_membase = ioremap_nocache(res_status.start,
+					resource_size(&res_status));
+	ltq_ebu_membase = ioremap_nocache(res_ebu.start,
+					resource_size(&res_ebu));
+
+	if (!status_membase || !ltq_ebu_membase)
+		panic("Failed to remap core resources");
+
+	for (i = 0; i < 3; i++) {
+		sysctl_membase[i] = ioremap_nocache(res_sys[i].start,
+						resource_size(&res_sys[i]));
+		if (!sysctl_membase[i])
+			panic("Failed to remap sysctrl resources");
+	}
+	ltq_sys1_membase = sysctl_membase[0];
+
+	falcon_gpe_enable();
+
+	/* get our 3 static rates for cpu, fpi and io clocks */
+	if (ltq_sys1_r32(SYS1_CPU0CC) & CPU0CC_CPUDIV)
+		clkdev_add_static(CLOCK_200M, CLOCK_100M, CLOCK_200M);
+	else
+		clkdev_add_static(CLOCK_400M, CLOCK_100M, CLOCK_200M);
+
+	/* add our clock domains */
+	clkdev_add_sys("1d810000.gpio", SYSCTL_SYSETH, ACTS_P0);
+	clkdev_add_sys("1d810100.gpio", SYSCTL_SYSETH, ACTS_P2);
+	clkdev_add_sys("1e800100.gpio", SYSCTL_SYS1, ACTS_P1);
+	clkdev_add_sys("1e800200.gpio", SYSCTL_SYS1, ACTS_P3);
+	clkdev_add_sys("1e800300.gpio", SYSCTL_SYS1, ACTS_P4);
+	clkdev_add_sys("1db01000.pad", SYSCTL_SYSETH, ACTS_PADCTRL0);
+	clkdev_add_sys("1db02000.pad", SYSCTL_SYSETH, ACTS_PADCTRL2);
+	clkdev_add_sys("1e800400.pad", SYSCTL_SYS1, ACTS_PADCTRL1);
+	clkdev_add_sys("1e800500.pad", SYSCTL_SYS1, ACTS_PADCTRL3);
+	clkdev_add_sys("1e800600.pad", SYSCTL_SYS1, ACTS_PADCTRL4);
+	clkdev_add_sys("1e100C00.serial", SYSCTL_SYS1, ACTS_ASC1_ACT);
+	clkdev_add_sys("1e200000.i2c", SYSCTL_SYS1, ACTS_I2C_ACT);
+}
-- 
1.7.9.1
