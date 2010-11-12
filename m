Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:52:27 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56903 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492156Ab0KLVvy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:54 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 50B7F41C002;
        Fri, 12 Nov 2010 22:51:49 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id CED2E270002;
        Fri, 12 Nov 2010 22:51:47 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 01/18] MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X SoCs
Date:   Fri, 12 Nov 2010 22:51:07 +0100
Message-Id: <1289598684-30624-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1225FA2FF1 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds initial support for various Atheros SoCs based on the
MIPS 24Kc core. The following models are supported at the moment:

  - AR7130
  - AR7141
  - AR7161
  - AR9130
  - AR9132
  - AR7240
  - AR7241
  - AR7242

The current patch contains minimal support only, but the resulting
kernel can boot into user-space with using of an initramfs image on
various boards which are using these SoCs. Support for more built-in
devices and individual boards will be implemented in further patches.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |   15 ++
 arch/mips/ath79/Kconfig                            |   15 ++
 arch/mips/ath79/Makefile                           |   15 ++
 arch/mips/ath79/Platform                           |    7 +
 arch/mips/ath79/common.c                           |  113 +++++++++
 arch/mips/ath79/common.h                           |   62 +++++
 arch/mips/ath79/dev-uart.c                         |   59 +++++
 arch/mips/ath79/dev-uart.h                         |   17 ++
 arch/mips/ath79/early_printk.c                     |   36 +++
 arch/mips/ath79/irq.c                              |  187 ++++++++++++++
 arch/mips/ath79/prom.c                             |   57 +++++
 arch/mips/ath79/setup.c                            |  263 ++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |  207 +++++++++++++++
 arch/mips/include/asm/mach-ath79/ath79.h           |   50 ++++
 .../include/asm/mach-ath79/cpu-feature-overrides.h |   56 ++++
 arch/mips/include/asm/mach-ath79/irq.h             |   36 +++
 .../include/asm/mach-ath79/kernel-entry-init.h     |   32 +++
 arch/mips/include/asm/mach-ath79/war.h             |   25 ++
 19 files changed, 1253 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/Kconfig
 create mode 100644 arch/mips/ath79/Makefile
 create mode 100644 arch/mips/ath79/Platform
 create mode 100644 arch/mips/ath79/common.c
 create mode 100644 arch/mips/ath79/common.h
 create mode 100644 arch/mips/ath79/dev-uart.c
 create mode 100644 arch/mips/ath79/dev-uart.h
 create mode 100644 arch/mips/ath79/early_printk.c
 create mode 100644 arch/mips/ath79/irq.c
 create mode 100644 arch/mips/ath79/prom.c
 create mode 100644 arch/mips/ath79/setup.c
 create mode 100644 arch/mips/include/asm/mach-ath79/ar71xx_regs.h
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79.h
 create mode 100644 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ath79/irq.h
 create mode 100644 arch/mips/include/asm/mach-ath79/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-ath79/war.h

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 78439b8..7ff9b54 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -2,6 +2,7 @@
 
 platforms += alchemy
 platforms += ar7
+platforms += ath79
 platforms += bcm47xx
 platforms += bcm63xx
 platforms += cavium-octeon
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cf8d094..5da5f81 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -58,6 +58,20 @@ config AR7
 	  Support for the Texas Instruments AR7 System-on-a-Chip
 	  family: TNETD7100, 7200 and 7300.
 
+config ATH79
+	bool "Atheros AR71XX/AR724X/AR913X based boards"
+	select BOOT_RAW
+	select CEVT_R4K
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	help
+	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
+
 config BCM47XX
 	bool "Broadcom BCM47XX based boards"
 	select CEVT_R4K
@@ -707,6 +721,7 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
+source "arch/mips/ath79/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
new file mode 100644
index 0000000..32e2658
--- /dev/null
+++ b/arch/mips/ath79/Kconfig
@@ -0,0 +1,15 @@
+if ATH79
+
+config SOC_AR71XX
+	def_bool n
+
+config SOC_AR724X
+	def_bool n
+
+config SOC_AR913X
+	def_bool n
+
+config ATH79_DEV_UART
+	def_bool y
+
+endif
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
new file mode 100644
index 0000000..438929f
--- /dev/null
+++ b/arch/mips/ath79/Makefile
@@ -0,0 +1,15 @@
+#
+# Makefile for the Atheros AR71XX/AR724X/AR913X specific parts of the kernel
+#
+# Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+# Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License version 2 as published
+# by the Free Software Foundation.
+
+obj-y	:= prom.o setup.o irq.o common.o
+
+obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
+
+obj-$(CONFIG_ATH79_DEV_UART)		+= dev-uart.o
diff --git a/arch/mips/ath79/Platform b/arch/mips/ath79/Platform
new file mode 100644
index 0000000..2bd6636
--- /dev/null
+++ b/arch/mips/ath79/Platform
@@ -0,0 +1,7 @@
+#
+# Atheros AR71xx/AR724x/AR913x
+#
+
+platform-$(CONFIG_ATH79)	+= ath79/
+cflags-$(CONFIG_ATH79)		+= -I$(srctree)/arch/mips/include/asm/mach-ath79
+load-$(CONFIG_ATH79)		= 0xffffffff80060000
diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
new file mode 100644
index 0000000..b6eaaf5
--- /dev/null
+++ b/arch/mips/ath79/common.c
@@ -0,0 +1,113 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X common routines
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "common.h"
+
+static DEFINE_SPINLOCK(ath79_device_lock);
+
+u32 ath79_cpu_freq;
+EXPORT_SYMBOL_GPL(ath79_cpu_freq);
+
+u32 ath79_ahb_freq;
+EXPORT_SYMBOL_GPL(ath79_ahb_freq);
+
+u32 ath79_ddr_freq;
+EXPORT_SYMBOL_GPL(ath79_ddr_freq);
+
+enum ath79_soc_type ath79_soc;
+
+void __iomem *ath79_pll_base;
+void __iomem *ath79_reset_base;
+EXPORT_SYMBOL_GPL(ath79_reset_base);
+void __iomem *ath79_ddr_base;
+
+void ath79_ddr_wb_flush(u32 reg)
+{
+	void __iomem *flush_reg = ath79_ddr_base + reg;
+
+	/* Flush the DDR write buffer. */
+	__raw_writel(0x1, flush_reg);
+	while (__raw_readl(flush_reg) & 0x1)
+		;
+
+	/* It must be run twice. */
+	__raw_writel(0x1, flush_reg);
+	while (__raw_readl(flush_reg) & 0x1)
+		;
+}
+EXPORT_SYMBOL_GPL(ath79_ddr_wb_flush);
+
+void ath79_device_stop(u32 mask)
+{
+	unsigned long flags;
+	u32 mask_inv;
+	u32 t;
+
+	if (soc_is_ar71xx()) {
+		spin_lock_irqsave(&ath79_device_lock, flags);
+		t = ath79_reset_rr(AR71XX_RESET_REG_RESET_MODULE);
+		ath79_reset_wr(AR71XX_RESET_REG_RESET_MODULE, t | mask);
+		spin_unlock_irqrestore(&ath79_device_lock, flags);
+	} else if (soc_is_ar724x()) {
+		mask_inv = mask & AR724X_RESET_OHCI_DLL;
+		spin_lock_irqsave(&ath79_device_lock, flags);
+		t = ath79_reset_rr(AR724X_RESET_REG_RESET_MODULE);
+		t |= mask;
+		t &= ~mask_inv;
+		ath79_reset_wr(AR724X_RESET_REG_RESET_MODULE, t);
+		spin_unlock_irqrestore(&ath79_device_lock, flags);
+	} else if (soc_is_ar913x()) {
+		spin_lock_irqsave(&ath79_device_lock, flags);
+		t = ath79_reset_rr(AR913X_RESET_REG_RESET_MODULE);
+		ath79_reset_wr(AR913X_RESET_REG_RESET_MODULE, t | mask);
+		spin_unlock_irqrestore(&ath79_device_lock, flags);
+	} else {
+		BUG();
+	}
+}
+EXPORT_SYMBOL_GPL(ath79_device_stop);
+
+void ath79_device_start(u32 mask)
+{
+	unsigned long flags;
+	u32 mask_inv;
+	u32 t;
+
+	if (soc_is_ar71xx()) {
+		spin_lock_irqsave(&ath79_device_lock, flags);
+		t = ath79_reset_rr(AR71XX_RESET_REG_RESET_MODULE);
+		ath79_reset_wr(AR71XX_RESET_REG_RESET_MODULE, t & ~mask);
+		spin_unlock_irqrestore(&ath79_device_lock, flags);
+	} else if (soc_is_ar724x()) {
+		mask_inv = mask & AR724X_RESET_OHCI_DLL;
+		spin_lock_irqsave(&ath79_device_lock, flags);
+		t = ath79_reset_rr(AR724X_RESET_REG_RESET_MODULE);
+		t &= ~mask;
+		t |= mask_inv;
+		ath79_reset_wr(AR724X_RESET_REG_RESET_MODULE, t);
+		spin_unlock_irqrestore(&ath79_device_lock, flags);
+	} else if (soc_is_ar913x()) {
+		spin_lock_irqsave(&ath79_device_lock, flags);
+		t = ath79_reset_rr(AR913X_RESET_REG_RESET_MODULE);
+		ath79_reset_wr(AR913X_RESET_REG_RESET_MODULE, t & ~mask);
+		spin_unlock_irqrestore(&ath79_device_lock, flags);
+	} else {
+		BUG();
+	}
+}
+EXPORT_SYMBOL_GPL(ath79_device_start);
diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
new file mode 100644
index 0000000..62d7503
--- /dev/null
+++ b/arch/mips/ath79/common.h
@@ -0,0 +1,62 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X common definitions
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __ATH79_COMMON_H
+#define __ATH79_COMMON_H
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+
+#define ATH79_MEM_SIZE_MIN	(2 * 1024 * 1024)
+#define ATH79_MEM_SIZE_MAX	(128 * 1024 * 1024)
+
+extern void __iomem *ath79_ddr_base;
+void ath79_ddr_wb_flush(unsigned int reg);
+
+enum ath79_soc_type {
+	ATH79_SOC_UNKNOWN,
+	ATH79_SOC_AR7130,
+	ATH79_SOC_AR7141,
+	ATH79_SOC_AR7161,
+	ATH79_SOC_AR7240,
+	ATH79_SOC_AR7241,
+	ATH79_SOC_AR7242,
+	ATH79_SOC_AR9130,
+	ATH79_SOC_AR9132
+};
+
+extern enum ath79_soc_type ath79_soc;
+
+static inline int soc_is_ar71xx(void)
+{
+	return (ath79_soc == ATH79_SOC_AR7130 ||
+		ath79_soc == ATH79_SOC_AR7141 ||
+		ath79_soc == ATH79_SOC_AR7161);
+}
+
+static inline int soc_is_ar724x(void)
+{
+	return (ath79_soc == ATH79_SOC_AR7240 ||
+		ath79_soc == ATH79_SOC_AR7241 ||
+		ath79_soc == ATH79_SOC_AR7242);
+}
+
+static inline int soc_is_ar913x(void)
+{
+	return (ath79_soc == ATH79_SOC_AR9130 ||
+		ath79_soc == ATH79_SOC_AR9132);
+}
+
+#endif /* __ATH79_COMMON_H */
diff --git a/arch/mips/ath79/dev-uart.c b/arch/mips/ath79/dev-uart.c
new file mode 100644
index 0000000..d7ca5d6
--- /dev/null
+++ b/arch/mips/ath79/dev-uart.c
@@ -0,0 +1,59 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X UART device
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "common.h"
+#include "dev-uart.h"
+
+static struct resource ath79_uart_resources[] = {
+	{
+		.start	= AR71XX_UART_BASE,
+		.end	= AR71XX_UART_BASE + AR71XX_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+#define AR71XX_UART_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP)
+static struct plat_serial8250_port ath79_uart_data[] = {
+	{
+		.mapbase	= AR71XX_UART_BASE,
+		.irq		= ATH79_MISC_IRQ_UART,
+		.flags		= AR71XX_UART_FLAGS,
+		.iotype		= UPIO_MEM32,
+		.regshift	= 2,
+	}, {
+		/* terminating entry */
+	}
+};
+
+static struct platform_device ath79_uart_device = {
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
+	.resource	= ath79_uart_resources,
+	.num_resources	= ARRAY_SIZE(ath79_uart_resources),
+	.dev = {
+		.platform_data	= ath79_uart_data
+	},
+};
+
+void __init ath79_register_uart(void)
+{
+	ath79_uart_data[0].uartclk = ath79_ahb_freq;
+	platform_device_register(&ath79_uart_device);
+}
diff --git a/arch/mips/ath79/dev-uart.h b/arch/mips/ath79/dev-uart.h
new file mode 100644
index 0000000..fc1680a
--- /dev/null
+++ b/arch/mips/ath79/dev-uart.h
@@ -0,0 +1,17 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X UART device
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_DEV_UART_H
+#define _ATH79_DEV_UART_H
+
+void ath79_register_uart(void) __init;
+
+#endif /* _ATH79_DEV_UART_H */
diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
new file mode 100644
index 0000000..7499b0e
--- /dev/null
+++ b/arch/mips/ath79/early_printk.c
@@ -0,0 +1,36 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X SoC early printk support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/serial_reg.h>
+#include <asm/addrspace.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+static inline void prom_wait_thre(void __iomem *base)
+{
+	u32 lsr;
+
+	do {
+		lsr = __raw_readl(base + UART_LSR * 4);
+		if (lsr & UART_LSR_THRE)
+			break;
+	} while (1);
+}
+
+void prom_putchar(unsigned char ch)
+{
+	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
+
+	prom_wait_thre(base);
+	__raw_writel(ch, base + UART_TX * 4);
+	prom_wait_thre(base);
+}
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
new file mode 100644
index 0000000..1bf7f71
--- /dev/null
+++ b/arch/mips/ath79/irq.c
@@ -0,0 +1,187 @@
+/*
+ *  Atheros AR71xx/AR724x/AR913x specific interrupt handling
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "common.h"
+
+static unsigned int ath79_ip2_flush_reg;
+static unsigned int ath79_ip3_flush_reg;
+
+static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	void __iomem *base = ath79_reset_base;
+	u32 pending;
+
+	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
+		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+
+	if (pending & MISC_INT_UART)
+		generic_handle_irq(ATH79_MISC_IRQ_UART);
+
+	else if (pending & MISC_INT_DMA)
+		generic_handle_irq(ATH79_MISC_IRQ_DMA);
+
+	else if (pending & MISC_INT_PERFC)
+		generic_handle_irq(ATH79_MISC_IRQ_PERFC);
+
+	else if (pending & MISC_INT_TIMER)
+		generic_handle_irq(ATH79_MISC_IRQ_TIMER);
+
+	else if (pending & MISC_INT_OHCI)
+		generic_handle_irq(ATH79_MISC_IRQ_OHCI);
+
+	else if (pending & MISC_INT_ERROR)
+		generic_handle_irq(ATH79_MISC_IRQ_ERROR);
+
+	else if (pending & MISC_INT_GPIO)
+		generic_handle_irq(ATH79_MISC_IRQ_GPIO);
+
+	else if (pending & MISC_INT_WDOG)
+		generic_handle_irq(ATH79_MISC_IRQ_WDOG);
+
+	else
+		spurious_interrupt();
+}
+
+static void ar71xx_misc_irq_unmask(unsigned int irq)
+{
+	void __iomem *base = ath79_reset_base;
+	u32 t;
+
+	irq -= ATH79_MISC_IRQ_BASE;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(t | (1 << irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+}
+
+static void ar71xx_misc_irq_mask(unsigned int irq)
+{
+	void __iomem *base = ath79_reset_base;
+	u32 t;
+
+	irq -= ATH79_MISC_IRQ_BASE;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+}
+
+static void ar724x_misc_irq_ack(unsigned int irq)
+{
+	void __iomem *base = ath79_reset_base;
+	u32 t;
+
+	irq -= ATH79_MISC_IRQ_BASE;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
+	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_MISC_INT_STATUS);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
+}
+
+static struct irq_chip ath79_misc_irq_chip = {
+	.name		= "MISC",
+	.unmask		= ar71xx_misc_irq_unmask,
+	.mask		= ar71xx_misc_irq_mask,
+};
+
+static void __init ath79_misc_irq_init(void)
+{
+	void __iomem *base = ath79_reset_base;
+	int i;
+
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
+
+	if (soc_is_ar71xx() || soc_is_ar913x())
+		ath79_misc_irq_chip.mask_ack = ar71xx_misc_irq_mask;
+	else if (soc_is_ar724x())
+		ath79_misc_irq_chip.ack = ar724x_misc_irq_ack;
+	else
+		BUG();
+
+	for (i = ATH79_MISC_IRQ_BASE;
+	     i < ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		set_irq_chip_and_handler(i, &ath79_misc_irq_chip,
+					 handle_level_irq);
+	}
+
+	set_irq_chained_handler(ATH79_CPU_IRQ_MISC, ath79_misc_irq_handler);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long pending;
+
+	pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (pending & STATUSF_IP7)
+		do_IRQ(ATH79_CPU_IRQ_TIMER);
+
+	else if (pending & STATUSF_IP2) {
+		ath79_ddr_wb_flush(ath79_ip2_flush_reg);
+		do_IRQ(ATH79_CPU_IRQ_IP2);
+	}
+
+	else if (pending & STATUSF_IP4)
+		do_IRQ(ATH79_CPU_IRQ_GE0);
+
+	else if (pending & STATUSF_IP5)
+		do_IRQ(ATH79_CPU_IRQ_GE1);
+
+	else if (pending & STATUSF_IP3) {
+		ath79_ddr_wb_flush(ath79_ip3_flush_reg);
+		do_IRQ(ATH79_CPU_IRQ_USB);
+	}
+
+	else if (pending & STATUSF_IP6)
+		do_IRQ(ATH79_CPU_IRQ_MISC);
+
+	else
+		spurious_interrupt();
+}
+
+void __init arch_init_irq(void)
+{
+	if (soc_is_ar71xx()) {
+		ath79_ip2_flush_reg = AR71XX_DDR_REG_FLUSH_PCI;
+		ath79_ip3_flush_reg = AR71XX_DDR_REG_FLUSH_USB;
+	} else if (soc_is_ar724x()) {
+		ath79_ip2_flush_reg = AR724X_DDR_REG_FLUSH_PCIE;
+		ath79_ip3_flush_reg = AR724X_DDR_REG_FLUSH_USB;
+	} else if (soc_is_ar913x()) {
+		ath79_ip2_flush_reg = AR913X_DDR_REG_FLUSH_WMAC;
+		ath79_ip3_flush_reg = AR913X_DDR_REG_FLUSH_USB;
+	} else
+		BUG();
+
+	cp0_perfcount_irq = ATH79_MISC_IRQ_PERFC;
+	mips_cpu_irq_init();
+	ath79_misc_irq_init();
+}
diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
new file mode 100644
index 0000000..e9cbd7c
--- /dev/null
+++ b/arch/mips/ath79/prom.c
@@ -0,0 +1,57 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X specific prom routines
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+
+#include "common.h"
+
+static inline int is_valid_ram_addr(void *addr)
+{
+	if (((u32) addr > KSEG0) &&
+	    ((u32) addr < (KSEG0 + ATH79_MEM_SIZE_MAX)))
+		return 1;
+
+	if (((u32) addr > KSEG1) &&
+	    ((u32) addr < (KSEG1 + ATH79_MEM_SIZE_MAX)))
+		return 1;
+
+	return 0;
+}
+
+static __init void ath79_prom_init_cmdline(int argc, char **argv)
+{
+	int i;
+
+	if (!is_valid_ram_addr(argv))
+		return;
+
+	for (i = 0; i < argc; i++)
+		if (is_valid_ram_addr(argv[i])) {
+			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
+			strlcat(arcs_cmdline, argv[i], sizeof(arcs_cmdline));
+		}
+}
+
+void __init prom_init(void)
+{
+	ath79_prom_init_cmdline(fw_arg0, (char **)fw_arg1);
+}
+
+void __init prom_free_prom_memory(void)
+{
+	/* We do not have to prom memory to free */
+}
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
new file mode 100644
index 0000000..63896b9
--- /dev/null
+++ b/arch/mips/ath79/setup.c
@@ -0,0 +1,263 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X specific setup
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <asm/time.h>		/* for mips_hpt_frequency */
+#include <asm/reboot.h>		/* for _machine_{restart,halt} */
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "common.h"
+#include "dev-uart.h"
+
+#define ATH79_SYS_TYPE_LEN	64
+
+#define AR71XX_BASE_FREQ	40000000
+#define AR724X_BASE_FREQ	5000000
+#define AR913X_BASE_FREQ	5000000
+
+static char ath79_sys_type[ATH79_SYS_TYPE_LEN];
+
+static void ath79_restart(char *command)
+{
+	ath79_device_stop(AR71XX_RESET_FULL_CHIP);
+	for (;;)
+		if (cpu_wait)
+			cpu_wait();
+}
+
+static void ath79_halt(void)
+{
+	while (1)
+		cpu_wait();
+}
+
+static void __init ath79_detect_mem_size(void)
+{
+	unsigned long size;
+
+	for (size = ATH79_MEM_SIZE_MIN; size < ATH79_MEM_SIZE_MAX;
+	     size <<= 1) {
+		if (!memcmp(ath79_detect_mem_size,
+			    ath79_detect_mem_size + size, 1024))
+			break;
+	}
+
+	add_memory_region(0, size, BOOT_MEM_RAM);
+}
+
+static void __init ath79_detect_sys_type(void)
+{
+	char *chip = "????";
+	u32 id;
+	u32 major;
+	u32 minor;
+	u32 rev = 0;
+
+	id = ath79_reset_rr(AR71XX_RESET_REG_REV_ID);
+	major = id & REV_ID_MAJOR_MASK;
+
+	switch (major) {
+	case REV_ID_MAJOR_AR71XX:
+		minor = id & AR71XX_REV_ID_MINOR_MASK;
+		rev = id >> AR71XX_REV_ID_REVISION_SHIFT;
+		rev &= AR71XX_REV_ID_REVISION_MASK;
+		switch (minor) {
+		case AR71XX_REV_ID_MINOR_AR7130:
+			ath79_soc = ATH79_SOC_AR7130;
+			chip = "7130";
+			break;
+
+		case AR71XX_REV_ID_MINOR_AR7141:
+			ath79_soc = ATH79_SOC_AR7141;
+			chip = "7141";
+			break;
+
+		case AR71XX_REV_ID_MINOR_AR7161:
+			ath79_soc = ATH79_SOC_AR7161;
+			chip = "7161";
+			break;
+		}
+		break;
+
+	case REV_ID_MAJOR_AR7240:
+		ath79_soc = ATH79_SOC_AR7240;
+		chip = "7240";
+		rev = (id & AR724X_REV_ID_REVISION_MASK);
+		break;
+
+	case REV_ID_MAJOR_AR7241:
+		ath79_soc = ATH79_SOC_AR7241;
+		chip = "7241";
+		rev = (id & AR724X_REV_ID_REVISION_MASK);
+		break;
+
+	case REV_ID_MAJOR_AR7242:
+		ath79_soc = ATH79_SOC_AR7242;
+		chip = "7242";
+		rev = (id & AR724X_REV_ID_REVISION_MASK);
+		break;
+
+	case REV_ID_MAJOR_AR913X:
+		minor = id & AR913X_REV_ID_MINOR_MASK;
+		rev = id >> AR913X_REV_ID_REVISION_SHIFT;
+		rev &= AR913X_REV_ID_REVISION_MASK;
+		switch (minor) {
+		case AR913X_REV_ID_MINOR_AR9130:
+			ath79_soc = ATH79_SOC_AR9130;
+			chip = "9130";
+			break;
+
+		case AR913X_REV_ID_MINOR_AR9132:
+			ath79_soc = ATH79_SOC_AR9132;
+			chip = "9132";
+			break;
+		}
+		break;
+
+	default:
+		panic("ath79: unknown SoC, id:0x%08x\n", id);
+	}
+
+	sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
+}
+
+static void __init ar71xx_detect_sys_frequency(void)
+{
+	u32 pll;
+	u32 freq;
+	u32 div;
+
+	pll = ath79_pll_rr(AR71XX_PLL_REG_CPU_CONFIG);
+
+	div = ((pll >> AR71XX_PLL_DIV_SHIFT) & AR71XX_PLL_DIV_MASK) + 1;
+	freq = div * AR71XX_BASE_FREQ;
+
+	div = ((pll >> AR71XX_CPU_DIV_SHIFT) & AR71XX_CPU_DIV_MASK) + 1;
+	ath79_cpu_freq = freq / div;
+
+	div = ((pll >> AR71XX_DDR_DIV_SHIFT) & AR71XX_DDR_DIV_MASK) + 1;
+	ath79_ddr_freq = freq / div;
+
+	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
+	ath79_ahb_freq = ath79_cpu_freq / div;
+}
+
+static void __init ar724x_detect_sys_frequency(void)
+{
+	u32 pll;
+	u32 freq;
+	u32 div;
+
+	pll = ath79_pll_rr(AR724X_PLL_REG_CPU_CONFIG);
+
+	div = ((pll >> AR724X_PLL_DIV_SHIFT) & AR724X_PLL_DIV_MASK);
+	freq = div * AR724X_BASE_FREQ;
+
+	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK);
+	freq *= div;
+
+	ath79_cpu_freq = freq;
+
+	div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
+	ath79_ddr_freq = freq / div;
+
+	div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
+	ath79_ahb_freq = ath79_cpu_freq / div;
+}
+
+static void __init ar913x_detect_sys_frequency(void)
+{
+	u32 pll;
+	u32 freq;
+	u32 div;
+
+	pll = ath79_pll_rr(AR913X_PLL_REG_CPU_CONFIG);
+
+	div = ((pll >> AR913X_PLL_DIV_SHIFT) & AR913X_PLL_DIV_MASK);
+	freq = div * AR913X_BASE_FREQ;
+
+	ath79_cpu_freq = freq;
+
+	div = ((pll >> AR913X_DDR_DIV_SHIFT) & AR913X_DDR_DIV_MASK) + 1;
+	ath79_ddr_freq = freq / div;
+
+	div = (((pll >> AR913X_AHB_DIV_SHIFT) & AR913X_AHB_DIV_MASK) + 1) * 2;
+	ath79_ahb_freq = ath79_cpu_freq / div;
+}
+
+static void __init ath79_detect_sys_frequency(void)
+{
+	if (soc_is_ar71xx())
+		ar71xx_detect_sys_frequency();
+	else if (soc_is_ar724x())
+		ar724x_detect_sys_frequency();
+	else if (soc_is_ar913x())
+		ar913x_detect_sys_frequency();
+	else
+		BUG();
+}
+
+const char *get_system_type(void)
+{
+	return ath79_sys_type;
+}
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
+
+void __init plat_mem_setup(void)
+{
+	set_io_port_base(KSEG1);
+
+	ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
+					   AR71XX_RESET_SIZE);
+	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
+					 AR71XX_PLL_SIZE);
+
+	ath79_ddr_base = ioremap_nocache(AR71XX_DDR_CTRL_BASE,
+					 AR71XX_DDR_CTRL_SIZE);
+
+	ath79_detect_sys_type();
+	ath79_detect_mem_size();
+	ath79_detect_sys_frequency();
+
+	pr_info("SoC: %s, CPU:%u.%03u MHz, DDR:%u.%03u MHz, AHB:%u.%03u MHz\n",
+		ath79_sys_type,
+		ath79_cpu_freq / 1000000, (ath79_cpu_freq / 1000) % 1000,
+		ath79_ddr_freq / 1000000, (ath79_ddr_freq / 1000) % 1000,
+		ath79_ahb_freq / 1000000, (ath79_ahb_freq / 1000) % 1000);
+
+	_machine_restart = ath79_restart;
+	_machine_halt = ath79_halt;
+	pm_power_off = ath79_halt;
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = ath79_cpu_freq / 2;
+}
+
+static int __init ath79_setup(void)
+{
+	ath79_register_uart();
+	return 0;
+}
+
+arch_initcall(ath79_setup);
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
new file mode 100644
index 0000000..5a9e5e1
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -0,0 +1,207 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X SoC register definitions
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_AR71XX_REGS_H
+#define __ASM_MACH_AR71XX_REGS_H
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+
+#define AR71XX_APB_BASE		0x18000000
+
+#define AR71XX_DDR_CTRL_BASE	(AR71XX_APB_BASE + 0x00000000)
+#define AR71XX_DDR_CTRL_SIZE	0x100
+#define AR71XX_UART_BASE	(AR71XX_APB_BASE + 0x00020000)
+#define AR71XX_UART_SIZE	0x100
+#define AR71XX_PLL_BASE		(AR71XX_APB_BASE + 0x00050000)
+#define AR71XX_PLL_SIZE		0x100
+#define AR71XX_RESET_BASE	(AR71XX_APB_BASE + 0x00060000)
+#define AR71XX_RESET_SIZE	0x100
+
+/*
+ * DDR_CTRL block
+ */
+#define AR71XX_DDR_REG_PCI_WIN0		0x7c
+#define AR71XX_DDR_REG_PCI_WIN1		0x80
+#define AR71XX_DDR_REG_PCI_WIN2		0x84
+#define AR71XX_DDR_REG_PCI_WIN3		0x88
+#define AR71XX_DDR_REG_PCI_WIN4		0x8c
+#define AR71XX_DDR_REG_PCI_WIN5		0x90
+#define AR71XX_DDR_REG_PCI_WIN6		0x94
+#define AR71XX_DDR_REG_PCI_WIN7		0x98
+#define AR71XX_DDR_REG_FLUSH_GE0	0x9c
+#define AR71XX_DDR_REG_FLUSH_GE1	0xa0
+#define AR71XX_DDR_REG_FLUSH_USB	0xa4
+#define AR71XX_DDR_REG_FLUSH_PCI	0xa8
+
+#define AR724X_DDR_REG_FLUSH_GE0	0x7c
+#define AR724X_DDR_REG_FLUSH_GE1	0x80
+#define AR724X_DDR_REG_FLUSH_USB	0x84
+#define AR724X_DDR_REG_FLUSH_PCIE	0x88
+
+#define AR913X_DDR_REG_FLUSH_GE0	0x7c
+#define AR913X_DDR_REG_FLUSH_GE1	0x80
+#define AR913X_DDR_REG_FLUSH_USB	0x84
+#define AR913X_DDR_REG_FLUSH_WMAC	0x88
+
+/*
+ * PLL block
+ */
+#define AR71XX_PLL_REG_CPU_CONFIG	0x00
+#define AR71XX_PLL_REG_SEC_CONFIG	0x04
+#define AR71XX_PLL_REG_ETH0_INT_CLOCK	0x10
+#define AR71XX_PLL_REG_ETH1_INT_CLOCK	0x14
+
+#define AR71XX_PLL_DIV_SHIFT		3
+#define AR71XX_PLL_DIV_MASK		0x1f
+#define AR71XX_CPU_DIV_SHIFT		16
+#define AR71XX_CPU_DIV_MASK		0x3
+#define AR71XX_DDR_DIV_SHIFT		18
+#define AR71XX_DDR_DIV_MASK		0x3
+#define AR71XX_AHB_DIV_SHIFT		20
+#define AR71XX_AHB_DIV_MASK		0x7
+
+#define AR724X_PLL_REG_CPU_CONFIG	0x00
+#define AR724X_PLL_REG_PCIE_CONFIG	0x18
+
+#define AR724X_PLL_DIV_SHIFT		0
+#define AR724X_PLL_DIV_MASK		0x3ff
+#define AR724X_PLL_REF_DIV_SHIFT	10
+#define AR724X_PLL_REF_DIV_MASK		0xf
+#define AR724X_AHB_DIV_SHIFT		19
+#define AR724X_AHB_DIV_MASK		0x1
+#define AR724X_DDR_DIV_SHIFT		22
+#define AR724X_DDR_DIV_MASK		0x3
+
+#define AR913X_PLL_REG_CPU_CONFIG	0x00
+#define AR913X_PLL_REG_ETH_CONFIG	0x04
+#define AR913X_PLL_REG_ETH0_INT_CLOCK	0x14
+#define AR913X_PLL_REG_ETH1_INT_CLOCK	0x18
+
+#define AR913X_PLL_DIV_SHIFT		0
+#define AR913X_PLL_DIV_MASK		0x3ff
+#define AR913X_DDR_DIV_SHIFT		22
+#define AR913X_DDR_DIV_MASK		0x3
+#define AR913X_AHB_DIV_SHIFT		19
+#define AR913X_AHB_DIV_MASK		0x1
+
+/*
+ * RESET block
+ */
+#define AR71XX_RESET_REG_TIMER			0x00
+#define AR71XX_RESET_REG_TIMER_RELOAD		0x04
+#define AR71XX_RESET_REG_WDOG_CTRL		0x08
+#define AR71XX_RESET_REG_WDOG			0x0c
+#define AR71XX_RESET_REG_MISC_INT_STATUS	0x10
+#define AR71XX_RESET_REG_MISC_INT_ENABLE	0x14
+#define AR71XX_RESET_REG_PCI_INT_STATUS		0x18
+#define AR71XX_RESET_REG_PCI_INT_ENABLE		0x1c
+#define AR71XX_RESET_REG_GLOBAL_INT_STATUS	0x20
+#define AR71XX_RESET_REG_RESET_MODULE		0x24
+#define AR71XX_RESET_REG_PERFC_CTRL		0x2c
+#define AR71XX_RESET_REG_PERFC0			0x30
+#define AR71XX_RESET_REG_PERFC1			0x34
+#define AR71XX_RESET_REG_REV_ID			0x90
+
+#define AR913X_RESET_REG_GLOBAL_INT_STATUS	0x18
+#define AR913X_RESET_REG_RESET_MODULE		0x1c
+#define AR913X_RESET_REG_PERF_CTRL		0x20
+#define AR913X_RESET_REG_PERFC0			0x24
+#define AR913X_RESET_REG_PERFC1			0x28
+
+#define AR724X_RESET_REG_RESET_MODULE		0x1c
+
+#define MISC_INT_DMA			BIT(7)
+#define MISC_INT_OHCI			BIT(6)
+#define MISC_INT_PERFC			BIT(5)
+#define MISC_INT_WDOG			BIT(4)
+#define MISC_INT_UART			BIT(3)
+#define MISC_INT_GPIO			BIT(2)
+#define MISC_INT_ERROR			BIT(1)
+#define MISC_INT_TIMER			BIT(0)
+
+#define AR71XX_RESET_EXTERNAL		BIT(28)
+#define AR71XX_RESET_FULL_CHIP		BIT(24)
+#define AR71XX_RESET_CPU_NMI		BIT(21)
+#define AR71XX_RESET_CPU_COLD		BIT(20)
+#define AR71XX_RESET_DMA		BIT(19)
+#define AR71XX_RESET_SLIC		BIT(18)
+#define AR71XX_RESET_STEREO		BIT(17)
+#define AR71XX_RESET_DDR		BIT(16)
+#define AR71XX_RESET_GE1_MAC		BIT(13)
+#define AR71XX_RESET_GE1_PHY		BIT(12)
+#define AR71XX_RESET_USBSUS_OVERRIDE	BIT(10)
+#define AR71XX_RESET_GE0_MAC		BIT(9)
+#define AR71XX_RESET_GE0_PHY		BIT(8)
+#define AR71XX_RESET_USB_OHCI_DLL	BIT(6)
+#define AR71XX_RESET_USB_HOST		BIT(5)
+#define AR71XX_RESET_USB_PHY		BIT(4)
+#define AR71XX_RESET_PCI_BUS		BIT(1)
+#define AR71XX_RESET_PCI_CORE		BIT(0)
+
+#define AR724X_RESET_GE1_MDIO		BIT(23)
+#define AR724X_RESET_GE0_MDIO		BIT(22)
+#define AR724X_RESET_PCIE_PHY_SERIAL	BIT(10)
+#define AR724X_RESET_PCIE_PHY		BIT(7)
+#define AR724X_RESET_PCIE		BIT(6)
+#define AR724X_RESET_OHCI_DLL		BIT(3)
+
+#define AR913X_RESET_AMBA2WMAC		BIT(22)
+
+#define REV_ID_MAJOR_MASK		0xfff0
+#define REV_ID_MAJOR_AR71XX		0x00a0
+#define REV_ID_MAJOR_AR913X		0x00b0
+#define REV_ID_MAJOR_AR7240		0x00c0
+#define REV_ID_MAJOR_AR7241		0x0100
+#define REV_ID_MAJOR_AR7242		0x1100
+
+#define AR71XX_REV_ID_MINOR_MASK	0x3
+#define AR71XX_REV_ID_MINOR_AR7130	0x0
+#define AR71XX_REV_ID_MINOR_AR7141	0x1
+#define AR71XX_REV_ID_MINOR_AR7161	0x2
+#define AR71XX_REV_ID_REVISION_MASK	0x3
+#define AR71XX_REV_ID_REVISION_SHIFT	2
+
+#define AR913X_REV_ID_MINOR_MASK	0x3
+#define AR913X_REV_ID_MINOR_AR9130	0x0
+#define AR913X_REV_ID_MINOR_AR9132	0x1
+#define AR913X_REV_ID_REVISION_MASK	0x3
+#define AR913X_REV_ID_REVISION_SHIFT	2
+
+#define AR724X_REV_ID_REVISION_MASK	0x3
+
+/*
+ * SPI block
+ */
+#define AR71XX_SPI_REG_FS	0x00	/* Function Select */
+#define AR71XX_SPI_REG_CTRL	0x04	/* SPI Control */
+#define AR71XX_SPI_REG_IOC	0x08	/* SPI I/O Control */
+#define AR71XX_SPI_REG_RDS	0x0c	/* Read Data Shift */
+
+#define AR71XX_SPI_FS_GPIO	BIT(0)	/* Enable GPIO mode */
+
+#define AR71XX_SPI_CTRL_RD	BIT(6)	/* Remap Disable */
+#define AR71XX_SPI_CTRL_DIV_MASK 0x3f
+
+#define AR71XX_SPI_IOC_DO	BIT(0)	/* Data Out pin */
+#define AR71XX_SPI_IOC_CLK	BIT(8)	/* CLK pin */
+#define AR71XX_SPI_IOC_CS(n)	BIT(16 + (n))
+#define AR71XX_SPI_IOC_CS0	AR71XX_SPI_IOC_CS(0)
+#define AR71XX_SPI_IOC_CS1	AR71XX_SPI_IOC_CS(1)
+#define AR71XX_SPI_IOC_CS2	AR71XX_SPI_IOC_CS(2)
+#define AR71XX_SPI_IOC_CS_ALL	(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1 | \
+				 AR71XX_SPI_IOC_CS2)
+
+#endif /* __ASM_MACH_AR71XX_REGS_H */
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
new file mode 100644
index 0000000..14248c9
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -0,0 +1,50 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X common definitions
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_ATH79_H
+#define __ASM_MACH_ATH79_H
+
+#include <linux/types.h>
+#include <linux/io.h>
+
+extern u32 ath79_ahb_freq;
+extern u32 ath79_cpu_freq;
+extern u32 ath79_ddr_freq;
+
+extern void __iomem *ath79_pll_base;
+extern void __iomem *ath79_reset_base;
+
+static inline void ath79_pll_wr(unsigned reg, u32 val)
+{
+	__raw_writel(val, ath79_pll_base + reg);
+}
+
+static inline u32 ath79_pll_rr(unsigned reg)
+{
+	return __raw_readl(ath79_pll_base + reg);
+}
+
+static inline void ath79_reset_wr(unsigned reg, u32 val)
+{
+	__raw_writel(val, ath79_reset_base + reg);
+}
+
+static inline u32 ath79_reset_rr(unsigned reg)
+{
+	return __raw_readl(ath79_reset_base + reg);
+}
+
+void ath79_device_stop(u32 mask);
+void ath79_device_start(u32 mask);
+
+#endif /* __ASM_MACH_ATH79_H */
diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
new file mode 100644
index 0000000..4476fa0
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -0,0 +1,56 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X specific CPU feature overrides
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H
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
+#define cpu_has_dsp		0
+#define cpu_has_mipsmt		0
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+
+#endif /* __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
new file mode 100644
index 0000000..189bc6e
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -0,0 +1,36 @@
+/*
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+#ifndef __ASM_MACH_ATH79_IRQ_H
+#define __ASM_MACH_ATH79_IRQ_H
+
+#define MIPS_CPU_IRQ_BASE	0
+#define NR_IRQS			16
+
+#define ATH79_MISC_IRQ_BASE	8
+#define ATH79_MISC_IRQ_COUNT	8
+
+#define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
+#define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
+#define ATH79_CPU_IRQ_GE0	(MIPS_CPU_IRQ_BASE + 4)
+#define ATH79_CPU_IRQ_GE1	(MIPS_CPU_IRQ_BASE + 5)
+#define ATH79_CPU_IRQ_MISC	(MIPS_CPU_IRQ_BASE + 6)
+#define ATH79_CPU_IRQ_TIMER	(MIPS_CPU_IRQ_BASE + 7)
+
+#define ATH79_MISC_IRQ_TIMER	(ATH79_MISC_IRQ_BASE + 0)
+#define ATH79_MISC_IRQ_ERROR	(ATH79_MISC_IRQ_BASE + 1)
+#define ATH79_MISC_IRQ_GPIO	(ATH79_MISC_IRQ_BASE + 2)
+#define ATH79_MISC_IRQ_UART	(ATH79_MISC_IRQ_BASE + 3)
+#define ATH79_MISC_IRQ_WDOG	(ATH79_MISC_IRQ_BASE + 4)
+#define ATH79_MISC_IRQ_PERFC	(ATH79_MISC_IRQ_BASE + 5)
+#define ATH79_MISC_IRQ_OHCI	(ATH79_MISC_IRQ_BASE + 6)
+#define ATH79_MISC_IRQ_DMA	(ATH79_MISC_IRQ_BASE + 7)
+
+#include_next <irq.h>
+
+#endif /* __ASM_MACH_ATH79_IRQ_H */
diff --git a/arch/mips/include/asm/mach-ath79/kernel-entry-init.h b/arch/mips/include/asm/mach-ath79/kernel-entry-init.h
new file mode 100644
index 0000000..d8d046b
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/kernel-entry-init.h
@@ -0,0 +1,32 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X specific kernel entry setup
+ *
+ *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_MACH_ATH79_KERNEL_ENTRY_H
+#define __ASM_MACH_ATH79_KERNEL_ENTRY_H
+
+	/*
+	 * Some bootloaders set the 'Kseg0 coherency algorithm' to
+	 * 'Cacheable, noncoherent, write-through, no write allocate'
+	 * and this cause performance issues. Let's go and change it to
+	 * 'Cacheable, noncoherent, write-back, write allocate'
+	 */
+	.macro	kernel_entry_setup
+	mfc0	t0, CP0_CONFIG
+	li	t1, ~CONF_CM_CMASK
+	and	t0, t1
+	ori	t0, CONF_CM_CACHABLE_NONCOHERENT
+	mtc0	t0, CP0_CONFIG
+	nop
+	.endm
+
+	.macro	smp_slave_setup
+	.endm
+
+#endif /* __ASM_MACH_ATH79_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-ath79/war.h b/arch/mips/include/asm/mach-ath79/war.h
new file mode 100644
index 0000000..323d9f1
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MACH_ATH79_WAR_H
+#define __ASM_MACH_ATH79_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MACH_ATH79_WAR_H */
-- 
1.7.2.1
