Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 12:55:33 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:35267 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903425Ab2FOKya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 12:54:30 +0200
Received: by dadm1 with SMTP id m1so3910160dad.36
        for <multiple recipients>; Fri, 15 Jun 2012 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ULVK9r2c5CKE8mMmt+aZkUEa8OZqyFIFgzdHgNpuzUM=;
        b=NPOFp5Evbaimu4MvWAw86fVgzbTrYfFgLvjDAOZh3C49VJ6SJ0sOdKH95eu++rksX8
         8eE9SksBI/M7fQsBMyWGAWe82dieIv7QKMU/jElApCxQNbfpA1AoLbTIiioMBkDr3lum
         SoxlRRy0GDF6aMJ+2qMC2QLdUXabgV0BKjbLnOQlu9GnPNZ0cCY4JiuerhcKReXgdEIo
         VR1y7zhdxWXqIsrCck/bFEi6+io07/Lml5b2ebEpwcC5sV8aljKetVnw+9gGBeT6V8bk
         zOqk9gUwdmd62g7gFAYRmSH2Wud6b1jEBYS9Ct87ow3UM+Ycyw3LbRLWJJf0MOhWd2RZ
         woNQ==
Received: by 10.68.222.9 with SMTP id qi9mr18676596pbc.164.1339757663411;
        Fri, 15 Jun 2012 03:54:23 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id gj8sm12873641pbc.39.2012.06.15.03.54.18
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 03:54:22 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     wuzhangjin@gmail.com, zhzhl555@gmail.com,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
Date:   Fri, 15 Jun 2012 18:53:35 +0800
Message-Id: <1339757617-2187-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 33658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch adds basic platform devices for Loongson1B,
including serial port, ethernet, usb, rtc and interrupt handler.

Loongson1B UART is compatible with NS16550A.
Loongson1B GMAC is built around Synopsys IP Core.

Use normal descriptor instead of enhanced descriptor.
Thanks to Giuseppe for updating the normal descriptor
in stmmac driver.

Thanks to Zhao Zhang for implementing the RTC driver.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson1/irq.h       |   73 ++++++++++
 arch/mips/include/asm/mach-loongson1/loongson1.h |   44 ++++++
 arch/mips/include/asm/mach-loongson1/platform.h  |   23 +++
 arch/mips/include/asm/mach-loongson1/prom.h      |   24 +++
 arch/mips/include/asm/mach-loongson1/regs-clk.h  |   33 +++++
 arch/mips/include/asm/mach-loongson1/regs-wdt.h  |   22 +++
 arch/mips/include/asm/mach-loongson1/war.h       |   25 ++++
 arch/mips/loongson1/common/clock.c               |  165 ++++++++++++++++++++++
 arch/mips/loongson1/common/irq.c                 |  147 +++++++++++++++++++
 arch/mips/loongson1/common/platform.c            |  130 +++++++++++++++++
 arch/mips/loongson1/common/prom.c                |   87 ++++++++++++
 arch/mips/loongson1/common/reset.c               |   45 ++++++
 arch/mips/loongson1/common/setup.c               |   29 ++++
 arch/mips/loongson1/ls1b/board.c                 |   39 +++++
 14 files changed, 886 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson1/irq.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/loongson1.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/platform.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/prom.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-clk.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-wdt.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/war.h
 create mode 100644 arch/mips/loongson1/common/clock.c
 create mode 100644 arch/mips/loongson1/common/irq.c
 create mode 100644 arch/mips/loongson1/common/platform.c
 create mode 100644 arch/mips/loongson1/common/prom.c
 create mode 100644 arch/mips/loongson1/common/reset.c
 create mode 100644 arch/mips/loongson1/common/setup.c
 create mode 100644 arch/mips/loongson1/ls1b/board.c

diff --git a/arch/mips/include/asm/mach-loongson1/irq.h b/arch/mips/include/asm/mach-loongson1/irq.h
new file mode 100644
index 0000000..ccc42cc
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/irq.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * IRQ mappings for Loongson1.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+#ifndef __ASM_MACH_LOONGSON1_IRQ_H
+#define __ASM_MACH_LOONGSON1_IRQ_H
+
+/*
+ * CPU core Interrupt Numbers
+ */
+#define MIPS_CPU_IRQ_BASE		0
+#define MIPS_CPU_IRQ(x)			(MIPS_CPU_IRQ_BASE + (x))
+
+#define SOFTINT0_IRQ			MIPS_CPU_IRQ(0)
+#define SOFTINT1_IRQ			MIPS_CPU_IRQ(1)
+#define INT0_IRQ			MIPS_CPU_IRQ(2)
+#define INT1_IRQ			MIPS_CPU_IRQ(3)
+#define INT2_IRQ			MIPS_CPU_IRQ(4)
+#define INT3_IRQ			MIPS_CPU_IRQ(5)
+#define INT4_IRQ			MIPS_CPU_IRQ(6)
+#define TIMER_IRQ			MIPS_CPU_IRQ(7)		/* cpu timer */
+
+#define MIPS_CPU_IRQS		(MIPS_CPU_IRQ(7) + 1 - MIPS_CPU_IRQ_BASE)
+
+/*
+ * INT0~3 Interrupt Numbers
+ */
+#define LS1X_IRQ_BASE			MIPS_CPU_IRQS
+#define LS1X_IRQ(n, x)			(LS1X_IRQ_BASE + (n << 5) + (x))
+
+#define LS1X_UART0_IRQ			LS1X_IRQ(0, 2)
+#define LS1X_UART1_IRQ			LS1X_IRQ(0, 3)
+#define LS1X_UART2_IRQ			LS1X_IRQ(0, 4)
+#define LS1X_UART3_IRQ			LS1X_IRQ(0, 5)
+#define LS1X_CAN0_IRQ			LS1X_IRQ(0, 6)
+#define LS1X_CAN1_IRQ			LS1X_IRQ(0, 7)
+#define LS1X_SPI0_IRQ			LS1X_IRQ(0, 8)
+#define LS1X_SPI1_IRQ			LS1X_IRQ(0, 9)
+#define LS1X_AC97_IRQ			LS1X_IRQ(0, 10)
+#define LS1X_DMA0_IRQ			LS1X_IRQ(0, 13)
+#define LS1X_DMA1_IRQ			LS1X_IRQ(0, 14)
+#define LS1X_DMA2_IRQ			LS1X_IRQ(0, 15)
+#define LS1X_PWM0_IRQ			LS1X_IRQ(0, 17)
+#define LS1X_PWM1_IRQ			LS1X_IRQ(0, 18)
+#define LS1X_PWM2_IRQ			LS1X_IRQ(0, 19)
+#define LS1X_PWM3_IRQ			LS1X_IRQ(0, 20)
+#define LS1X_RTC_INT0_IRQ		LS1X_IRQ(0, 21)
+#define LS1X_RTC_INT1_IRQ		LS1X_IRQ(0, 22)
+#define LS1X_RTC_INT2_IRQ		LS1X_IRQ(0, 23)
+#define LS1X_TOY_INT0_IRQ		LS1X_IRQ(0, 24)
+#define LS1X_TOY_INT1_IRQ		LS1X_IRQ(0, 25)
+#define LS1X_TOY_INT2_IRQ		LS1X_IRQ(0, 26)
+#define LS1X_RTC_TICK_IRQ		LS1X_IRQ(0, 27)
+#define LS1X_TOY_TICK_IRQ		LS1X_IRQ(0, 28)
+
+#define LS1X_EHCI_IRQ			LS1X_IRQ(1, 0)
+#define LS1X_OHCI_IRQ			LS1X_IRQ(1, 1)
+#define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
+#define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
+
+#define LS1X_IRQS		(LS1X_IRQ(4, 31) + 1 - LS1X_IRQ_BASE)
+
+#define NR_IRQS			(MIPS_CPU_IRQS + LS1X_IRQS)
+
+#endif /* __ASM_MACH_LOONGSON1_IRQ_H */
diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h b/arch/mips/include/asm/mach-loongson1/loongson1.h
new file mode 100644
index 0000000..0440627
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/loongson1.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Register mappings for Loongson1.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+#ifndef __ASM_MACH_LOONGSON1_LOONGSON1_H
+#define __ASM_MACH_LOONGSON1_LOONGSON1_H
+
+#define DEFAULT_MEMSIZE			256	/* If no memsize provided */
+
+/* Loongson1 Register Bases */
+#define LS1X_INTC_BASE			0x1fd01040
+#define LS1X_EHCI_BASE			0x1fe00000
+#define LS1X_OHCI_BASE			0x1fe08000
+#define LS1X_GMAC0_BASE			0x1fe10000
+#define LS1X_GMAC1_BASE			0x1fe20000
+
+#define LS1X_UART0_BASE			0x1fe40000
+#define LS1X_UART1_BASE			0x1fe44000
+#define LS1X_UART2_BASE			0x1fe48000
+#define LS1X_UART3_BASE			0x1fe4c000
+#define LS1X_CAN0_BASE			0x1fe50000
+#define LS1X_CAN1_BASE			0x1fe54000
+#define LS1X_I2C0_BASE			0x1fe58000
+#define LS1X_I2C1_BASE			0x1fe68000
+#define LS1X_I2C2_BASE			0x1fe70000
+#define LS1X_PWM_BASE			0x1fe5c000
+#define LS1X_WDT_BASE			0x1fe5c060
+#define LS1X_RTC_BASE			0x1fe64000
+#define LS1X_AC97_BASE			0x1fe74000
+#define LS1X_NAND_BASE			0x1fe78000
+#define LS1X_CLK_BASE			0x1fe78030
+
+#include <regs-clk.h>
+#include <regs-wdt.h>
+
+#endif /* __ASM_MACH_LOONGSON1_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson1/platform.h b/arch/mips/include/asm/mach-loongson1/platform.h
new file mode 100644
index 0000000..2f17161
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/platform.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+#ifndef __ASM_MACH_LOONGSON1_PLATFORM_H
+#define __ASM_MACH_LOONGSON1_PLATFORM_H
+
+#include <linux/platform_device.h>
+
+extern struct platform_device ls1x_uart_device;
+extern struct platform_device ls1x_eth0_device;
+extern struct platform_device ls1x_ehci_device;
+extern struct platform_device ls1x_rtc_device;
+
+void ls1x_serial_setup(void);
+
+#endif /* __ASM_MACH_LOONGSON1_PLATFORM_H */
diff --git a/arch/mips/include/asm/mach-loongson1/prom.h b/arch/mips/include/asm/mach-loongson1/prom.h
new file mode 100644
index 0000000..b871dc4
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/prom.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON1_PROM_H
+#define __ASM_MACH_LOONGSON1_PROM_H
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+/* environment arguments from bootloader */
+extern unsigned long memsize, highmemsize;
+
+/* loongson-specific command line, env and memory initialization */
+extern char *prom_getenv(char *name);
+extern void __init prom_init_cmdline(void);
+
+#endif /* __ASM_MACH_LOONGSON1_PROM_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson1/regs-clk.h
new file mode 100644
index 0000000..5b9635a
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson1 Clock Register Definitions.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
+#define __ASM_MACH_LOONGSON1_REGS_CLK_H
+
+#define LS1X_CLK_REG(x) \
+		((void __iomem *)KSEG1ADDR(LS1X_CLK_BASE + (x)))
+
+#define LS1X_CLK_PLL_FREQ		LS1X_CLK_REG(0x0)
+#define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
+
+/* Clock PLL Divisor Register Bits */
+#define DIV_DC_EN			(0x1 << 31)
+#define DIV_DC				(0x1f << 26)
+#define DIV_CPU_EN			(0x1 << 25)
+#define DIV_CPU				(0x1f << 20)
+#define DIV_DDR_EN			(0x1 << 19)
+#define DIV_DDR				(0x1f << 14)
+
+#define DIV_DC_SHIFT			26
+#define DIV_CPU_SHIFT			20
+#define DIV_DDR_SHIFT			14
+
+#endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-wdt.h b/arch/mips/include/asm/mach-loongson1/regs-wdt.h
new file mode 100644
index 0000000..d339fe7
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/regs-wdt.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson1 Watchdog register definitions.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON1_REGS_WDT_H
+#define __ASM_MACH_LOONGSON1_REGS_WDT_H
+
+#define LS1X_WDT_REG(x) \
+		((void __iomem *)KSEG1ADDR(LS1X_WDT_BASE + (x)))
+
+#define LS1X_WDT_EN			LS1X_WDT_REG(0x0)
+#define LS1X_WDT_SET			LS1X_WDT_REG(0x4)
+#define LS1X_WDT_TIMER			LS1X_WDT_REG(0x8)
+
+#endif /* __ASM_MACH_LOONGSON1_REGS_WDT_H */
diff --git a/arch/mips/include/asm/mach-loongson1/war.h b/arch/mips/include/asm/mach-loongson1/war.h
new file mode 100644
index 0000000..e3680a8
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MACH_LOONGSON1_WAR_H
+#define __ASM_MACH_LOONGSON1_WAR_H
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
+#endif /* __ASM_MACH_LOONGSON1_WAR_H */
diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/common/clock.c
new file mode 100644
index 0000000..2d98fb0
--- /dev/null
+++ b/arch/mips/loongson1/common/clock.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <asm/clock.h>
+#include <asm/time.h>
+
+#include <loongson1.h>
+
+static LIST_HEAD(clocks);
+static DEFINE_MUTEX(clocks_mutex);
+
+struct clk *clk_get(struct device *dev, const char *name)
+{
+	struct clk *c;
+	struct clk *ret = NULL;
+
+	mutex_lock(&clocks_mutex);
+	list_for_each_entry(c, &clocks, node) {
+		if (!strcmp(c->name, name)) {
+			ret = c;
+			break;
+		}
+	}
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_get);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+static void pll_clk_init(struct clk *clk)
+{
+	u32 pll;
+
+	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+	clk->rate = (12 + (pll & 0x3f)) * 33 / 2
+			+ ((pll >> 8) & 0x3ff) * 33 / 1024 / 2;
+	clk->rate *= 1000000;
+}
+
+static void cpu_clk_init(struct clk *clk)
+{
+	u32 pll, ctrl;
+
+	pll = clk_get_rate(clk->parent);
+	ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_CPU;
+	clk->rate = pll / (ctrl >> DIV_CPU_SHIFT);
+}
+
+static void ddr_clk_init(struct clk *clk)
+{
+	u32 pll, ctrl;
+
+	pll = clk_get_rate(clk->parent);
+	ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_DDR;
+	clk->rate = pll / (ctrl >> DIV_DDR_SHIFT);
+}
+
+static void dc_clk_init(struct clk *clk)
+{
+	u32 pll, ctrl;
+
+	pll = clk_get_rate(clk->parent);
+	ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_DC;
+	clk->rate = pll / (ctrl >> DIV_DC_SHIFT);
+}
+
+static struct clk_ops pll_clk_ops = {
+	.init	= pll_clk_init,
+};
+
+static struct clk_ops cpu_clk_ops = {
+	.init	= cpu_clk_init,
+};
+
+static struct clk_ops ddr_clk_ops = {
+	.init	= ddr_clk_init,
+};
+
+static struct clk_ops dc_clk_ops = {
+	.init	= dc_clk_init,
+};
+
+static struct clk pll_clk = {
+	.name	= "pll",
+	.ops	= &pll_clk_ops,
+};
+
+static struct clk cpu_clk = {
+	.name	= "cpu",
+	.parent = &pll_clk,
+	.ops	= &cpu_clk_ops,
+};
+
+static struct clk ddr_clk = {
+	.name	= "ddr",
+	.parent = &pll_clk,
+	.ops	= &ddr_clk_ops,
+};
+
+static struct clk dc_clk = {
+	.name	= "dc",
+	.parent = &pll_clk,
+	.ops	= &dc_clk_ops,
+};
+
+int clk_register(struct clk *clk)
+{
+	mutex_lock(&clocks_mutex);
+	list_add(&clk->node, &clocks);
+	if (clk->ops->init)
+		clk->ops->init(clk);
+	mutex_unlock(&clocks_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_register);
+
+static struct clk *ls1x_clks[] = {
+	&pll_clk,
+	&cpu_clk,
+	&ddr_clk,
+	&dc_clk,
+};
+
+int __init ls1x_clock_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ls1x_clks); i++)
+		clk_register(ls1x_clks[i]);
+
+	return 0;
+}
+
+void __init plat_time_init(void)
+{
+	struct clk *clk;
+
+	/* Initialize LS1X clocks */
+	ls1x_clock_init();
+
+	/* setup mips r4k timer */
+	clk = clk_get(NULL, "cpu");
+	if (IS_ERR(clk))
+		panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
+
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+}
diff --git a/arch/mips/loongson1/common/irq.c b/arch/mips/loongson1/common/irq.c
new file mode 100644
index 0000000..41bc8ff
--- /dev/null
+++ b/arch/mips/loongson1/common/irq.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/irq_cpu.h>
+
+#include <loongson1.h>
+#include <irq.h>
+
+#define LS1X_INTC_REG(n, x) \
+		((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (n * 0x18) + (x)))
+
+#define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
+#define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
+#define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
+#define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
+#define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
+#define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
+
+static void ls1x_irq_ack(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
+			| (1 << bit), LS1X_INTC_INTCLR(n));
+}
+
+static void ls1x_irq_mask(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
+			& ~(1 << bit), LS1X_INTC_INTIEN(n));
+}
+
+static void ls1x_irq_mask_ack(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
+			& ~(1 << bit), LS1X_INTC_INTIEN(n));
+	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
+			| (1 << bit), LS1X_INTC_INTCLR(n));
+}
+
+static void ls1x_irq_unmask(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
+			| (1 << bit), LS1X_INTC_INTIEN(n));
+}
+
+static struct irq_chip ls1x_irq_chip = {
+	.name		= "LS1X-INTC",
+	.irq_ack	= ls1x_irq_ack,
+	.irq_mask	= ls1x_irq_mask,
+	.irq_mask_ack	= ls1x_irq_mask_ack,
+	.irq_unmask	= ls1x_irq_unmask,
+};
+
+static void ls1x_irq_dispatch(int n)
+{
+	u32 int_status, irq;
+
+	/* Get pending sources, masked by current enables */
+	int_status = __raw_readl(LS1X_INTC_INTISR(n)) &
+			__raw_readl(LS1X_INTC_INTIEN(n));
+
+	if (int_status) {
+		irq = LS1X_IRQ(n, __ffs(int_status));
+		do_IRQ(irq);
+	}
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending;
+
+	pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+	if (pending & CAUSEF_IP7)
+		do_IRQ(TIMER_IRQ);
+	else if (pending & CAUSEF_IP2)
+		ls1x_irq_dispatch(0); /* INT0 */
+	else if (pending & CAUSEF_IP3)
+		ls1x_irq_dispatch(1); /* INT1 */
+	else if (pending & CAUSEF_IP4)
+		ls1x_irq_dispatch(2); /* INT2 */
+	else if (pending & CAUSEF_IP5)
+		ls1x_irq_dispatch(3); /* INT3 */
+	else if (pending & CAUSEF_IP6)
+		ls1x_irq_dispatch(4); /* INT4 */
+	else
+		spurious_interrupt();
+
+}
+
+struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
+};
+
+static void __init ls1x_irq_init(int base)
+{
+	int n;
+
+	/* Disable interrupts and clear pending,
+	 * setup all IRQs as high level triggered
+	 */
+	for (n = 0; n < 4; n++) {
+		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
+		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
+		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
+		/* set DMA0, DMA1 and DMA2 to edge trigger */
+		__raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
+	}
+
+
+	for (n = base; n < LS1X_IRQS; n++) {
+		irq_set_chip_and_handler(n, &ls1x_irq_chip,
+					 handle_level_irq);
+	}
+
+	setup_irq(INT0_IRQ, &cascade_irqaction);
+	setup_irq(INT1_IRQ, &cascade_irqaction);
+	setup_irq(INT2_IRQ, &cascade_irqaction);
+	setup_irq(INT3_IRQ, &cascade_irqaction);
+}
+
+void __init arch_init_irq(void)
+{
+	mips_cpu_irq_init();
+	ls1x_irq_init(LS1X_IRQ_BASE);
+}
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
new file mode 100644
index 0000000..d928af5
--- /dev/null
+++ b/arch/mips/loongson1/common/platform.c
@@ -0,0 +1,130 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/phy.h>
+#include <linux/serial_8250.h>
+#include <linux/stmmac.h>
+#include <asm-generic/sizes.h>
+
+#include <loongson1.h>
+
+#define LS1X_UART(_id)						\
+	{							\
+		.mapbase	= LS1X_UART ## _id ## _BASE,	\
+		.irq		= LS1X_UART ## _id ## _IRQ,	\
+		.iotype		= UPIO_MEM,			\
+		.flags		= UPF_IOREMAP | UPF_FIXED_TYPE,	\
+		.type		= PORT_16550A,			\
+	}
+
+static struct plat_serial8250_port ls1x_serial8250_port[] = {
+	LS1X_UART(0),
+	LS1X_UART(1),
+	LS1X_UART(2),
+	LS1X_UART(3),
+	{},
+};
+
+struct platform_device ls1x_uart_device = {
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
+	.dev		= {
+		.platform_data = ls1x_serial8250_port,
+	},
+};
+
+void __init ls1x_serial_setup(void)
+{
+	struct clk *clk;
+	struct plat_serial8250_port *p;
+
+	clk = clk_get(NULL, "dc");
+	if (IS_ERR(clk))
+		panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
+
+	for (p = ls1x_serial8250_port; p->flags != 0; ++p)
+		p->uartclk = clk_get_rate(clk);
+}
+
+/* Synopsys Ethernet GMAC */
+#if IS_ENABLED(CONFIG_STMMAC_ETH)
+static struct resource ls1x_eth0_resources[] = {
+	[0] = {
+		.start	= LS1X_GMAC0_BASE,
+		.end	= LS1X_GMAC0_BASE + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "macirq",
+		.start	= LS1X_GMAC0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
+	.bus_id		= 0,
+	.phy_mask	= 0,
+};
+
+static struct plat_stmmacenet_data ls1x_eth_data = {
+	.bus_id		= 0,
+	.phy_addr	= -1,
+	.mdio_bus_data	= &ls1x_mdio_bus_data,
+	.pbl		= 32,
+	.has_gmac	= 1,
+	.tx_coe		= 1,
+};
+
+struct platform_device ls1x_eth0_device = {
+	.name		= "stmmaceth",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
+	.resource	= ls1x_eth0_resources,
+	.dev		= {
+		.platform_data = &ls1x_eth_data,
+	},
+};
+#endif
+
+/* EHCI */
+#if IS_ENABLED(CONFIG_USB_EHCI_HCD)
+static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
+
+static struct resource ls1x_ehci_resources[] = {
+	[0] = {
+		.start	= LS1X_EHCI_BASE,
+		.end	= LS1X_EHCI_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= LS1X_EHCI_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_ehci_device = {
+	.name		= "ls1x-ehci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
+	.resource	= ls1x_ehci_resources,
+	.dev		= {
+		.dma_mask = &ls1x_ehci_dmamask,
+	},
+};
+#endif
+
+#if IS_ENABLED(CONFIG_RTC_DRV_LOONGSON1)
+struct platform_device ls1x_rtc_device = {
+	.name		= "ls1x-rtc",
+	.id		= -1,
+};
+#endif
diff --git a/arch/mips/loongson1/common/prom.c b/arch/mips/loongson1/common/prom.c
new file mode 100644
index 0000000..1f8e49f
--- /dev/null
+++ b/arch/mips/loongson1/common/prom.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Modified from arch/mips/pnx833x/common/prom.c.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/serial_reg.h>
+#include <asm/bootinfo.h>
+
+#include <loongson1.h>
+#include <prom.h>
+
+int prom_argc;
+char **prom_argv, **prom_envp;
+unsigned long memsize, highmemsize;
+
+char *prom_getenv(char *envname)
+{
+	char **env = prom_envp;
+	int i;
+
+	i = strlen(envname);
+
+	while (*env) {
+		if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
+			return *env + i + 1;
+		env++;
+	}
+
+	return 0;
+}
+
+static inline unsigned long env_or_default(char *env, unsigned long dfl)
+{
+	char *str = prom_getenv(env);
+	return str ? simple_strtol(str, 0, 0) : dfl;
+}
+
+void __init prom_init_cmdline(void)
+{
+	char *c = &(arcs_cmdline[0]);
+	int i;
+
+	for (i = 1; i < prom_argc; i++) {
+		strcpy(c, prom_argv[i]);
+		c += strlen(prom_argv[i]);
+		if (i < prom_argc-1)
+			*c++ = ' ';
+	}
+	*c = 0;
+}
+
+void __init prom_init(void)
+{
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize = env_or_default("memsize", DEFAULT_MEMSIZE);
+	highmemsize = env_or_default("highmemsize", 0x0);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+#define PORT(offset)	(u8 *)(KSEG1ADDR(LS1X_UART0_BASE + offset))
+
+void __init prom_putchar(char c)
+{
+	int timeout;
+
+	timeout = 1024;
+
+	while (((readb(PORT(UART_LSR)) & UART_LSR_THRE) == 0)
+			&& (timeout-- > 0))
+		;
+
+	writeb(c, PORT(UART_TX));
+}
diff --git a/arch/mips/loongson1/common/reset.c b/arch/mips/loongson1/common/reset.c
new file mode 100644
index 0000000..fb979a7
--- /dev/null
+++ b/arch/mips/loongson1/common/reset.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <asm/reboot.h>
+
+#include <loongson1.h>
+
+static void ls1x_restart(char *command)
+{
+	__raw_writel(0x1, LS1X_WDT_EN);
+	__raw_writel(0x5000000, LS1X_WDT_TIMER);
+	__raw_writel(0x1, LS1X_WDT_SET);
+}
+
+static void ls1x_halt(void)
+{
+	while (1) {
+		if (cpu_wait)
+			cpu_wait();
+	}
+}
+
+static void ls1x_power_off(void)
+{
+	ls1x_halt();
+}
+
+static int __init ls1x_reboot_setup(void)
+{
+	_machine_restart = ls1x_restart;
+	_machine_halt = ls1x_halt;
+	pm_power_off = ls1x_power_off;
+
+	return 0;
+}
+
+arch_initcall(ls1x_reboot_setup);
diff --git a/arch/mips/loongson1/common/setup.c b/arch/mips/loongson1/common/setup.c
new file mode 100644
index 0000000..62128cc
--- /dev/null
+++ b/arch/mips/loongson1/common/setup.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/bootinfo.h>
+
+#include <prom.h>
+
+void __init plat_mem_setup(void)
+{
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+}
+
+const char *get_system_type(void)
+{
+	unsigned int processor_id = (&current_cpu_data)->processor_id;
+
+	switch (processor_id & PRID_REV_MASK) {
+	case PRID_REV_LOONGSON1B:
+		return "LOONGSON LS1B";
+	default:
+		return "LOONGSON (unknown)";
+	}
+}
diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls1b/board.c
new file mode 100644
index 0000000..1ec350d
--- /dev/null
+++ b/arch/mips/loongson1/ls1b/board.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <platform.h>
+
+#include <linux/serial_8250.h>
+#include <loongson1.h>
+
+static struct platform_device *ls1b_platform_devices[] __initdata = {
+	&ls1x_uart_device,
+#if IS_ENABLED(CONFIG_STMMAC_ETH)
+	&ls1x_eth0_device,
+#endif
+#if IS_ENABLED(CONFIG_USB_EHCI_HCD)
+	&ls1x_ehci_device,
+#endif
+#if IS_ENABLED(CONFIG_RTC_DRV_LOONGSON1)
+	&ls1x_rtc_device,
+#endif
+};
+
+static int __init ls1b_platform_init(void)
+{
+	int err;
+
+	ls1x_serial_setup();
+
+	err = platform_add_devices(ls1b_platform_devices,
+				   ARRAY_SIZE(ls1b_platform_devices));
+	return err;
+}
+
+arch_initcall(ls1b_platform_init);
-- 
1.7.1
