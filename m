Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 09:28:37 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45646 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491076Ab1C3H0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 09:26:52 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V5 01/10] MIPS: lantiq: add initial support for Lantiq SoCs
Date:   Wed, 30 Mar 2011 09:27:47 +0200
Message-Id: <1301470076-17279-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Add initial support for Mips based SoCs made by Lantiq. This series will add
support for the XWAY family.

The series allows booting a minimal system using a initramfs or NOR. Missing
drivers and support for Amazon and GPON family will be provided in a later
series.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org

---

Changes in V2
* handle external interrup sources
* properly set io_base
* handle CMDLINE properly
* remove custom early_printf

Changes in V3
* whitespace
* change __iomem void to void __iomem
* multiline comments
* use pr_* macros instead of printk

Changes in V4
* properly insert and request all memory regions
* whitespace fixes in irq.c

Changes in V5
* implement new irq scheme

 arch/mips/Kbuild.platforms                 |    1 +
 arch/mips/Kconfig                          |   17 ++
 arch/mips/include/asm/mach-lantiq/lantiq.h |   60 +++++
 arch/mips/include/asm/mach-lantiq/war.h    |   24 ++
 arch/mips/lantiq/Makefile                  |    9 +
 arch/mips/lantiq/Platform                  |    7 +
 arch/mips/lantiq/clk.c                     |  150 ++++++++++++
 arch/mips/lantiq/clk.h                     |   18 ++
 arch/mips/lantiq/early_printk.c            |   34 +++
 arch/mips/lantiq/irq.c                     |  338 ++++++++++++++++++++++++++++
 arch/mips/lantiq/prom.c                    |   77 +++++++
 arch/mips/lantiq/prom.h                    |   24 ++
 arch/mips/lantiq/setup.c                   |   47 ++++
 13 files changed, 806 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/war.h
 create mode 100644 arch/mips/lantiq/Makefile
 create mode 100644 arch/mips/lantiq/Platform
 create mode 100644 arch/mips/lantiq/clk.c
 create mode 100644 arch/mips/lantiq/clk.h
 create mode 100644 arch/mips/lantiq/early_printk.c
 create mode 100644 arch/mips/lantiq/irq.c
 create mode 100644 arch/mips/lantiq/prom.c
 create mode 100644 arch/mips/lantiq/prom.h
 create mode 100644 arch/mips/lantiq/setup.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 7ff9b54..aef6c91 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -11,6 +11,7 @@ platforms += dec
 platforms += emma
 platforms += jazz
 platforms += jz4740
+platforms += lantiq
 platforms += lasat
 platforms += loongson
 platforms += mipssim
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 83aa5fb..095900c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -212,6 +212,23 @@ config MACH_JZ4740
 	select HAVE_PWM
 	select HAVE_CLK
 
+config LANTIQ
+	bool "Lantiq based platforms"
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_HAS_EARLY_PRINTK
+	select ARCH_REQUIRE_GPIOLIB
+	select SWAP_IO_SPACE
+	select BOOT_RAW
+	select HAVE_CLK
+
 config LASAT
 	bool "LASAT Networks platforms"
 	select CEVT_R4K
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
new file mode 100644
index 0000000..3d101fa
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -0,0 +1,60 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LANTIQ_H__
+#define _LANTIQ_H__
+
+#include <linux/irq.h>
+
+/* generic reg access functions */
+#define ltq_r32(reg)		__raw_readl(reg)
+#define ltq_w32(val, reg)	__raw_writel(val, reg)
+#define ltq_w32_mask(clear, set, reg)	\
+	ltq_w32((ltq_r32(reg) & ~(clear)) | (set), reg)
+#define ltq_r8(reg)		__raw_readb(reg)
+#define ltq_w8(val, reg)	__raw_writeb(val, reg)
+
+/* register access macros for EBU and CGU */
+#define ltq_ebu_w32(x, y)	ltq_w32((x), ltq_ebu_membase + (y))
+#define ltq_ebu_r32(x)		ltq_r32(ltq_ebu_membase + (x))
+#define ltq_cgu_w32(x, y)	ltq_w32((x), ltq_cgu_membase + (y))
+#define ltq_cgu_r32(x)		ltq_r32(ltq_cgu_membase + (x))
+
+extern __iomem void *ltq_ebu_membase;
+extern __iomem void *ltq_cgu_membase;
+
+extern unsigned int ltq_get_cpu_ver(void);
+extern unsigned int ltq_get_soc_type(void);
+
+/* clock speeds */
+#define CLOCK_60M	60000000
+#define CLOCK_83M	83333333
+#define CLOCK_111M	111111111
+#define CLOCK_133M	133333333
+#define CLOCK_167M	166666667
+#define CLOCK_200M	200000000
+#define CLOCK_266M	266666666
+#define CLOCK_333M	333333333
+#define CLOCK_400M	400000000
+
+/* spinlock all ebu i/o */
+extern spinlock_t ebu_lock;
+
+/* some irq helpers */
+extern void ltq_disable_irq(struct irq_data *data);
+extern void ltq_mask_and_ack_irq(struct irq_data *data);
+extern void ltq_enable_irq(struct irq_data *data);
+
+#define IOPORT_RESOURCE_START	0x10000000
+#define IOPORT_RESOURCE_END	0xffffffff
+#define IOMEM_RESOURCE_START	0x10000000
+#define IOMEM_RESOURCE_END	0xffffffff
+#define LTQ_FLASH_START		0x10000000
+#define LTQ_FLASH_MAX		0x04000000
+
+#endif
diff --git a/arch/mips/include/asm/mach-lantiq/war.h b/arch/mips/include/asm/mach-lantiq/war.h
new file mode 100644
index 0000000..01b08ef
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/war.h
@@ -0,0 +1,24 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#ifndef __ASM_MIPS_MACH_LANTIQ_WAR_H
+#define __ASM_MIPS_MACH_LANTIQ_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR     0
+#define R4600_V1_HIT_CACHEOP_WAR        0
+#define R4600_V2_HIT_CACHEOP_WAR        0
+#define R5432_CP0_INTERRUPT_WAR         0
+#define BCM1250_M3_WAR                  0
+#define SIBYTE_1956_WAR                 0
+#define MIPS4K_ICACHE_REFILL_WAR        0
+#define MIPS_CACHE_SYNC_WAR             0
+#define TX49XX_ICACHE_INDEX_INV_WAR     0
+#define RM9000_CDEX_SMP_WAR             0
+#define ICACHE_REFILLS_WORKAROUND_WAR   0
+#define R10000_LLSC_WAR                 0
+#define MIPS34K_MISSED_ITLB_WAR         0
+
+#endif
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
new file mode 100644
index 0000000..6a30de6
--- /dev/null
+++ b/arch/mips/lantiq/Makefile
@@ -0,0 +1,9 @@
+# Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License version 2 as published
+# by the Free Software Foundation.
+
+obj-y := irq.o setup.o clk.o prom.o
+
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
diff --git a/arch/mips/lantiq/Platform b/arch/mips/lantiq/Platform
new file mode 100644
index 0000000..eef587f
--- /dev/null
+++ b/arch/mips/lantiq/Platform
@@ -0,0 +1,7 @@
+#
+# Lantiq
+#
+
+platform-$(CONFIG_LANTIQ)	+= lantiq/
+cflags-$(CONFIG_LANTIQ)		+= -I$(srctree)/arch/mips/include/asm/mach-lantiq
+load-$(CONFIG_LANTIQ)		= 0xffffffff80002000
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
new file mode 100644
index 0000000..e5fd24f
--- /dev/null
+++ b/arch/mips/lantiq/clk.c
@@ -0,0 +1,150 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/list.h>
+
+#include <asm/time.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+
+#include <lantiq_soc.h>
+
+#include "clk.h"
+
+struct clk {
+	const char *name;
+	unsigned long rate;
+	unsigned long (*get_rate) (void);
+};
+
+static struct clk *cpu_clk;
+static int cpu_clk_cnt;
+
+/* lantiq socs have 3 static clocks */
+static struct clk cpu_clk_generic[] = {
+	{
+		.name = "cpu",
+		.get_rate = ltq_get_cpu_hz,
+	}, {
+		.name = "fpi",
+		.get_rate = ltq_get_fpi_hz,
+	}, {
+		.name = "io",
+		.get_rate = ltq_get_io_region_clock,
+	},
+};
+
+static struct resource ltq_cgu_resource = {
+	.name	= "cgu",
+	.start	= LTQ_CGU_BASE_ADDR,
+	.end	= LTQ_CGU_BASE_ADDR + LTQ_CGU_SIZE - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+/* remapped clock register range */
+void __iomem *ltq_cgu_membase;
+
+void
+clk_init(void)
+{
+	cpu_clk = cpu_clk_generic;
+	cpu_clk_cnt = ARRAY_SIZE(cpu_clk_generic);
+}
+
+static inline int
+clk_good(struct clk *clk)
+{
+	return clk && !IS_ERR(clk);
+}
+
+unsigned long
+clk_get_rate(struct clk *clk)
+{
+	if (unlikely(!clk_good(clk)))
+		return 0;
+
+	if (clk->rate != 0)
+		return clk->rate;
+
+	if (clk->get_rate != NULL)
+		return clk->get_rate();
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+struct clk*
+clk_get(struct device *dev, const char *id)
+{
+	int i;
+
+	for (i = 0; i < cpu_clk_cnt; i++)
+		if (!strcmp(id, cpu_clk[i].name))
+			return &cpu_clk[i];
+	BUG();
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+void
+clk_put(struct clk *clk)
+{
+	/* not used */
+}
+EXPORT_SYMBOL(clk_put);
+
+static inline u32
+ltq_get_counter_resolution(void)
+{
+	u32 res;
+
+	__asm__ __volatile__(
+		".set   push\n"
+		".set   mips32r2\n"
+		".set   noreorder\n"
+		"rdhwr  %0, $3\n"
+		"ehb\n"
+		".set pop\n"
+		: "=&r" (res)
+		: /* no input */
+		: "memory");
+	instruction_hazard();
+	return res;
+}
+
+void __init
+plat_time_init(void)
+{
+	struct clk *clk;
+
+	if (insert_resource(&iomem_resource, &ltq_cgu_resource) < 0)
+		panic("Failed to insert cgu memory\n");
+
+	if (request_mem_region(ltq_cgu_resource.start,
+			resource_size(&ltq_cgu_resource), "cgu") < 0)
+		panic("Failed to request cgu memory\n");
+
+	ltq_cgu_membase = ioremap_nocache(ltq_cgu_resource.start,
+				resource_size(&ltq_cgu_resource));
+	if (!ltq_cgu_membase) {
+		pr_err("Failed to remap cgu memory\n");
+		unreachable();
+	}
+	clk = clk_get(0, "cpu");
+	mips_hpt_frequency = clk_get_rate(clk) / ltq_get_counter_resolution();
+	write_c0_compare(read_c0_count());
+	clk_put(clk);
+}
diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
new file mode 100644
index 0000000..3328925
--- /dev/null
+++ b/arch/mips/lantiq/clk.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_CLK_H__
+#define _LTQ_CLK_H__
+
+extern void clk_init(void);
+
+extern unsigned long ltq_get_cpu_hz(void);
+extern unsigned long ltq_get_fpi_hz(void);
+extern unsigned long ltq_get_io_region_clock(void);
+
+#endif
diff --git a/arch/mips/lantiq/early_printk.c b/arch/mips/lantiq/early_printk.c
new file mode 100644
index 0000000..ebccf60
--- /dev/null
+++ b/arch/mips/lantiq/early_printk.c
@@ -0,0 +1,34 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/cpu.h>
+
+#include <lantiq.h>
+#include <lantiq_soc.h>
+
+/* no ioremap possible at this early stage, lets use KSEG1 instead  */
+#define LTQ_ASC_BASE	KSEG1ADDR(LTQ_ASC1_BASE_ADDR)
+#define ASC_BUF		1024
+#define LTQ_ASC_FSTAT	((u32 *)(LTQ_ASC_BASE + 0x0048))
+#define LTQ_ASC_TBUF	((u32 *)(LTQ_ASC_BASE + 0x0020))
+#define TXMASK		0x3F00
+#define TXOFFSET	8
+
+void
+prom_putchar(char c)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	do { } while ((ltq_r32(LTQ_ASC_FSTAT) & TXMASK) >> TXOFFSET);
+	if (c == '\n')
+		ltq_w32('\r', LTQ_ASC_TBUF);
+	ltq_w32(c, LTQ_ASC_TBUF);
+	local_irq_restore(flags);
+}
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
new file mode 100644
index 0000000..4c80644
--- /dev/null
+++ b/arch/mips/lantiq/irq.c
@@ -0,0 +1,338 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+
+#include <asm/bootinfo.h>
+#include <asm/irq_cpu.h>
+
+#include <lantiq_soc.h>
+#include <irq.h>
+
+/* register definitions */
+#define LTQ_ICU_IM0_ISR		0x0000
+#define LTQ_ICU_IM0_IER		0x0008
+#define LTQ_ICU_IM0_IOSR	0x0010
+#define LTQ_ICU_IM0_IRSR	0x0018
+#define LTQ_ICU_IM0_IMR		0x0020
+#define LTQ_ICU_IM1_ISR		0x0028
+#define LTQ_ICU_OFFSET		(LTQ_ICU_IM1_ISR - LTQ_ICU_IM0_ISR)
+
+#define LTQ_EIU_EXIN_C		0x0000
+#define LTQ_EIU_EXIN_INIC	0x0004
+#define LTQ_EIU_EXIN_INEN	0x000C
+
+/* irq numbers used by the external interrupt unit (EIU) */
+#define LTQ_EIU_IR0		(INT_NUM_IM4_IRL0 + 30)
+#define LTQ_EIU_IR1		(INT_NUM_IM3_IRL0 + 31)
+#define LTQ_EIU_IR2		(INT_NUM_IM1_IRL0 + 26)
+#define LTQ_EIU_IR3		INT_NUM_IM1_IRL0
+#define LTQ_EIU_IR4		(INT_NUM_IM1_IRL0 + 1)
+#define LTQ_EIU_IR5		(INT_NUM_IM1_IRL0 + 2)
+#define LTQ_EIU_IR6		(INT_NUM_IM2_IRL0 + 30)
+
+#define MAX_EIU			6
+
+/* irqs generated by device attached to the EBU need to be acked in
+ * a special manner
+ */
+#define LTQ_ICU_EBU_IRQ		22
+
+#define ltq_icu_w32(x, y)	ltq_w32((x), ltq_icu_membase + (y))
+#define ltq_icu_r32(x)		ltq_r32(ltq_icu_membase + (x))
+
+#define ltq_eiu_w32(x, y)	ltq_w32((x), ltq_eiu_membase + (y))
+#define ltq_eiu_r32(x)		ltq_r32(ltq_eiu_membase + (x))
+
+static unsigned short ltq_eiu_irq[MAX_EIU] = {
+	LTQ_EIU_IR0,
+	LTQ_EIU_IR1,
+	LTQ_EIU_IR2,
+	LTQ_EIU_IR3,
+	LTQ_EIU_IR4,
+	LTQ_EIU_IR5,
+};
+
+static struct resource ltq_icu_resource = {
+	.name	= "icu",
+	.start	= LTQ_ICU_BASE_ADDR,
+	.end	= LTQ_ICU_BASE_ADDR + LTQ_ICU_SIZE - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct resource ltq_eiu_resource = {
+	.name	= "eiu",
+	.start	= LTQ_EIU_BASE_ADDR,
+	.end	= LTQ_EIU_BASE_ADDR + LTQ_ICU_SIZE - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static void __iomem *ltq_icu_membase;
+static void __iomem *ltq_eiu_membase;
+
+void
+ltq_disable_irq(struct irq_data *d)
+{
+	u32 ier = LTQ_ICU_IM0_IER;
+	int irq_nr = d->irq - INT_NUM_IRQ0;
+
+	ier += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
+	irq_nr %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(ltq_icu_r32(ier) & ~(1 << irq_nr), ier);
+}
+
+void
+ltq_mask_and_ack_irq(struct irq_data *d)
+{
+	u32 ier = LTQ_ICU_IM0_IER;
+	u32 isr = LTQ_ICU_IM0_ISR;
+	int irq_nr = d->irq - INT_NUM_IRQ0;
+
+	ier += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
+	isr += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
+	irq_nr %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(ltq_icu_r32(ier) & ~(1 << irq_nr), ier);
+	ltq_icu_w32((1 << irq_nr), isr);
+}
+
+static void
+ltq_ack_irq(struct irq_data *d)
+{
+	u32 isr = LTQ_ICU_IM0_ISR;
+	int irq_nr = d->irq - INT_NUM_IRQ0;
+
+	isr += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
+	irq_nr %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32((1 << irq_nr), isr);
+}
+
+void
+ltq_enable_irq(struct irq_data *d)
+{
+	u32 ier = LTQ_ICU_IM0_IER;
+	int irq_nr = d->irq - INT_NUM_IRQ0;
+
+	ier += LTQ_ICU_OFFSET  * (irq_nr / INT_NUM_IM_OFFSET);
+	irq_nr %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(ltq_icu_r32(ier) | (1 << irq_nr), ier);
+}
+
+static unsigned int
+ltq_startup_eiu_irq(struct irq_data *d)
+{
+	int i;
+	int irq_nr = d->irq - INT_NUM_IRQ0;
+
+	ltq_enable_irq(d);
+	for (i = 0; i < MAX_EIU; i++) {
+		if (irq_nr == ltq_eiu_irq[i]) {
+			/* low level - we should really handle set_type */
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
+				(0x6 << (i * 4)), LTQ_EIU_EXIN_C);
+			/* clear all pending */
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INIC) & ~(1 << i),
+				LTQ_EIU_EXIN_INIC);
+			/* enable */
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) | (1 << i),
+				LTQ_EIU_EXIN_INEN);
+			break;
+		}
+	}
+	return 0;
+}
+
+static void
+ltq_shutdown_eiu_irq(struct irq_data *d)
+{
+	int i;
+	int irq_nr = d->irq - INT_NUM_IRQ0;
+
+	ltq_disable_irq(d);
+	for (i = 0; i < MAX_EIU; i++) {
+		if (irq_nr == ltq_eiu_irq[i]) {
+			/* disable */
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~(1 << i),
+				LTQ_EIU_EXIN_INEN);
+			break;
+		}
+	}
+}
+
+static struct irq_chip
+ltq_irq_type = {
+	"icu",
+	.irq_enable = ltq_enable_irq,
+	.irq_disable = ltq_disable_irq,
+	.irq_unmask = ltq_enable_irq,
+	.irq_ack = ltq_ack_irq,
+	.irq_mask = ltq_disable_irq,
+	.irq_mask_ack = ltq_mask_and_ack_irq,
+};
+
+static struct irq_chip
+ltq_eiu_type = {
+	"eiu",
+	.irq_startup = ltq_startup_eiu_irq,
+	.irq_shutdown = ltq_shutdown_eiu_irq,
+	.irq_enable = ltq_enable_irq,
+	.irq_disable = ltq_disable_irq,
+	.irq_unmask = ltq_enable_irq,
+	.irq_ack = ltq_ack_irq,
+	.irq_mask = ltq_disable_irq,
+	.irq_mask_ack = ltq_mask_and_ack_irq,
+};
+
+static void
+ltq_hw_irqdispatch(int module)
+{
+	u32 irq;
+
+	irq = ltq_icu_r32(LTQ_ICU_IM0_IOSR + (module * LTQ_ICU_OFFSET));
+	if (irq == 0)
+		return;
+
+	/* silicon bug causes only the msb set to 1 to be valid. all
+	 * other bits might be bogus
+	 */
+	irq = __fls(irq);
+	do_IRQ((int)irq + INT_NUM_IM0_IRL0 + (INT_NUM_IM_OFFSET * module));
+
+	/* if this is a EBU irq, we need to ack it or get a deadlock */
+	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0))
+		ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_ISTAT) | 0x10,
+			LTQ_EBU_PCC_ISTAT);
+}
+
+#define DEFINE_HWx_IRQDISPATCH(x) \
+static void ltq_hw ## x ## _irqdispatch(void)\
+{\
+	ltq_hw_irqdispatch(x); \
+}
+DEFINE_HWx_IRQDISPATCH(0)
+DEFINE_HWx_IRQDISPATCH(1)
+DEFINE_HWx_IRQDISPATCH(2)
+DEFINE_HWx_IRQDISPATCH(3)
+DEFINE_HWx_IRQDISPATCH(4)
+
+static void ltq_hw5_irqdispatch(void)
+{
+	do_IRQ(MIPS_CPU_TIMER_IRQ);
+}
+
+asmlinkage void
+plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+	unsigned int i;
+
+	if (pending & CAUSEF_IP7) {
+		do_IRQ(MIPS_CPU_TIMER_IRQ);
+		goto out;
+	} else {
+		for (i = 0; i < 5; i++) {
+			if (pending & (CAUSEF_IP2 << i)) {
+				ltq_hw_irqdispatch(i);
+				goto out;
+			}
+		}
+	}
+	pr_alert("Spurious IRQ: CAUSE=0x%08x\n", read_c0_status());
+
+out:
+	return;
+}
+
+static struct irqaction
+cascade = {
+	.handler = no_action,
+	.flags = IRQF_DISABLED,
+	.name = "cascade",
+};
+
+void __init
+arch_init_irq(void)
+{
+	int i;
+
+	if (insert_resource(&iomem_resource, &ltq_icu_resource) < 0)
+		panic("Failed to insert icu memory\n");
+
+	if (request_mem_region(ltq_icu_resource.start,
+			resource_size(&ltq_icu_resource), "icu") < 0)
+		panic("Failed to request icu memory\n");
+
+	ltq_icu_membase = ioremap_nocache(ltq_icu_resource.start,
+				resource_size(&ltq_icu_resource));
+	if (!ltq_icu_membase)
+		panic("Failed to remap icu memory\n");
+
+	if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
+		panic("Failed to insert eiu memory\n");
+
+	if (request_mem_region(ltq_eiu_resource.start,
+			resource_size(&ltq_eiu_resource), "eiu") < 0)
+		panic("Failed to request eiu memory\n");
+
+	ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
+				resource_size(&ltq_eiu_resource));
+	if (!ltq_eiu_membase)
+		panic("Failed to remap eiu memory\n");
+
+	/* make sure all irqs are turned off by default */
+	for (i = 0; i < 5; i++)
+		ltq_icu_w32(0, LTQ_ICU_IM0_IER + (i * LTQ_ICU_OFFSET));
+
+	/* clear all possibly pending interrupts */
+	ltq_icu_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
+
+	mips_cpu_irq_init();
+
+	for (i = 2; i <= 6; i++)
+		setup_irq(i, &cascade);
+
+	if (cpu_has_vint) {
+		pr_info("Setting up vectored interrupts\n");
+		set_vi_handler(2, ltq_hw0_irqdispatch);
+		set_vi_handler(3, ltq_hw1_irqdispatch);
+		set_vi_handler(4, ltq_hw2_irqdispatch);
+		set_vi_handler(5, ltq_hw3_irqdispatch);
+		set_vi_handler(6, ltq_hw4_irqdispatch);
+		set_vi_handler(7, ltq_hw5_irqdispatch);
+	}
+
+	for (i = INT_NUM_IRQ0;
+		i <= (INT_NUM_IRQ0 + (5 * INT_NUM_IM_OFFSET)); i++)
+		if ((i == LTQ_EIU_IR0) || (i == LTQ_EIU_IR1) ||
+			(i == LTQ_EIU_IR2))
+			irq_set_chip_and_handler(i, &ltq_eiu_type,
+				handle_level_irq);
+		/* EIU3-5 only exist on ar9 and vr9 */
+		else if (((i == LTQ_EIU_IR3) || (i == LTQ_EIU_IR4) ||
+			(i == LTQ_EIU_IR5)) && (ltq_is_ar9() || ltq_is_vr9()))
+			irq_set_chip_and_handler(i, &ltq_eiu_type,
+				handle_level_irq);
+		else
+			irq_set_chip_and_handler(i, &ltq_irq_type,
+				handle_level_irq);
+
+#if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 |
+		IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
+#else
+	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ0 | IE_IRQ1 |
+		IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
+#endif
+}
+
+unsigned int __cpuinit
+get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
new file mode 100644
index 0000000..d873830
--- /dev/null
+++ b/arch/mips/lantiq/prom.c
@@ -0,0 +1,77 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+
+#include <lantiq.h>
+
+#include "prom.h"
+#include "clk.h"
+
+static struct ltq_soc_info soc_info;
+
+unsigned int
+ltq_get_cpu_ver(void)
+{
+	return soc_info.rev;
+}
+EXPORT_SYMBOL(ltq_get_cpu_ver);
+
+unsigned int
+ltq_get_soc_type(void)
+{
+	return soc_info.type;
+}
+EXPORT_SYMBOL(ltq_get_soc_type);
+
+const char*
+get_system_type(void)
+{
+	return soc_info.sys_type;
+}
+
+void
+prom_free_prom_memory(void)
+{
+}
+
+static void __init
+prom_init_cmdline(void)
+{
+	int argc = fw_arg0;
+	char **argv = (char **) KSEG1ADDR(fw_arg1);
+	int i;
+
+	for (i = 0; i < argc; i++) {
+		char *p = (char *)  KSEG1ADDR(argv[i]);
+
+		if (p && *p) {
+			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
+			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
+		}
+	}
+}
+
+void __init
+prom_init(void)
+{
+	struct clk *clk;
+
+	ltq_soc_detect(&soc_info);
+	clk_init();
+	clk = clk_get(0, "cpu");
+	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev1.%d",
+		soc_info.name, soc_info.rev);
+	clk_put(clk);
+	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
+	pr_info("SoC: %s\n", soc_info.sys_type);
+	prom_init_cmdline();
+}
diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
new file mode 100644
index 0000000..b9d6562
--- /dev/null
+++ b/arch/mips/lantiq/prom.h
@@ -0,0 +1,24 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_PROM_H__
+#define _LTQ_PROM_H__
+
+#define LTQ_SYS_TYPE_LEN	0x100
+
+struct ltq_soc_info {
+	unsigned char *name;
+	unsigned int rev;
+	unsigned int partnum;
+	unsigned int type;
+	unsigned char sys_type[LTQ_SYS_TYPE_LEN];
+};
+
+void ltq_soc_detect(struct ltq_soc_info *i);
+
+#endif
diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
new file mode 100644
index 0000000..edeb076
--- /dev/null
+++ b/arch/mips/lantiq/setup.c
@@ -0,0 +1,47 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <asm/bootinfo.h>
+
+#include <lantiq_soc.h>
+
+void __init
+plat_mem_setup(void)
+{
+	/* assume 16M as default incase uboot fails to pass proper ramsize */
+	unsigned long memsize = 16;
+	char **envp = (char **) KSEG1ADDR(fw_arg2);
+	u32 status;
+
+	/* make sure to have no "reverse endian" for user mode */
+	status = read_c0_status();
+	status &= (~(1<<25));
+	write_c0_status(status);
+
+	ioport_resource.start = IOPORT_RESOURCE_START;
+	ioport_resource.end = IOPORT_RESOURCE_END;
+	iomem_resource.start = IOMEM_RESOURCE_START;
+	iomem_resource.end = IOMEM_RESOURCE_END;
+
+	set_io_port_base((unsigned long) KSEG1);
+
+	while (*envp) {
+		char *e = (char *)KSEG1ADDR(*envp);
+		if (!strncmp(e, "memsize=", 8)) {
+			e += 8;
+			strict_strtoul(e, 0, &memsize);
+		}
+		envp++;
+	}
+	memsize *= 1024 * 1024;
+	add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
+}
-- 
1.7.2.3
