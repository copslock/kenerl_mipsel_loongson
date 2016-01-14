Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 02:13:00 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:59608 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010453AbcANBML5YuO9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 02:12:11 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 13 Jan 2016
 18:12:04 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Wed, 13 Jan 2016
 18:19:51 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH v5 06/14] MIPS: Add support for PIC32MZDA platform
Date:   Wed, 13 Jan 2016 18:15:39 -0700
Message-ID: <1452734299-460-7-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

This adds support for the Microchip PIC32 MIPS microcontroller with the
specific variant PIC32MZDA. PIC32MZDA is based on the MIPS m14KEc core
and boots using device tree.

This includes an early pin setup and early clock setup needed prior to
device tree being initialized. In additon, an interface is provided to
synchronize access to registers shared across several peripherals.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Changes since v4:
	- Select config PIC32_EVIC for PIC32MZDA
	- Implement get_c0_compare_int() in platform using DTS
Changes since v3: None
Changes since v2: None
Changes since v1:
	- Remove redundant probing 'pb7_clk' to find CPU clock.
	- Make platform PIC32[_CLR|_SET|_INV] register macros safer
	- Remove unused functions
	- Rename sdhc to sdhci
	- Address missing static on local functions and other sparse
	  warnings in several drivers.
---
 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |    9 +
 .../include/asm/mach-pic32/cpu-feature-overrides.h |   32 +++
 arch/mips/include/asm/mach-pic32/irq.h             |   22 ++
 arch/mips/include/asm/mach-pic32/pic32.h           |   44 ++++
 arch/mips/include/asm/mach-pic32/spaces.h          |   24 ++
 arch/mips/pic32/Kconfig                            |   35 +++
 arch/mips/pic32/Makefile                           |    6 +
 arch/mips/pic32/Platform                           |    7 +
 arch/mips/pic32/common/Makefile                    |    5 +
 arch/mips/pic32/common/irq.c                       |   21 ++
 arch/mips/pic32/common/reset.c                     |   62 +++++
 arch/mips/pic32/pic32mzda/Makefile                 |    9 +
 arch/mips/pic32/pic32mzda/config.c                 |  126 +++++++++
 arch/mips/pic32/pic32mzda/early_clk.c              |  106 ++++++++
 arch/mips/pic32/pic32mzda/early_console.c          |  171 ++++++++++++
 arch/mips/pic32/pic32mzda/early_pin.c              |  275 ++++++++++++++++++++
 arch/mips/pic32/pic32mzda/early_pin.h              |  241 +++++++++++++++++
 arch/mips/pic32/pic32mzda/init.c                   |  156 +++++++++++
 arch/mips/pic32/pic32mzda/pic32mzda.h              |   29 +++
 arch/mips/pic32/pic32mzda/time.c                   |   73 ++++++
 include/linux/platform_data/sdhci-pic32.h          |   22 ++
 22 files changed, 1476 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-pic32/irq.h
 create mode 100644 arch/mips/include/asm/mach-pic32/pic32.h
 create mode 100644 arch/mips/include/asm/mach-pic32/spaces.h
 create mode 100644 arch/mips/pic32/Kconfig
 create mode 100644 arch/mips/pic32/Makefile
 create mode 100644 arch/mips/pic32/Platform
 create mode 100644 arch/mips/pic32/common/Makefile
 create mode 100644 arch/mips/pic32/common/irq.c
 create mode 100644 arch/mips/pic32/common/reset.c
 create mode 100644 arch/mips/pic32/pic32mzda/Makefile
 create mode 100644 arch/mips/pic32/pic32mzda/config.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_clk.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_console.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_pin.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_pin.h
 create mode 100644 arch/mips/pic32/pic32mzda/init.c
 create mode 100644 arch/mips/pic32/pic32mzda/pic32mzda.h
 create mode 100644 arch/mips/pic32/pic32mzda/time.c
 create mode 100644 include/linux/platform_data/sdhci-pic32.h

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index a96c81d..c5cd63a 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -21,6 +21,7 @@ platforms += mti-malta
 platforms += mti-sead3
 platforms += netlogic
 platforms += paravirt
+platforms += pic32
 platforms += pistachio
 platforms += pmcs-msp71xx
 platforms += pnx833x
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a8..a989e76 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -481,6 +481,14 @@ config MIPS_MALTA
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
 
+config MACH_PIC32
+	bool "Microchip PIC32 Family"
+	help
+	  This enables support for the Microchip PIC32 family of platforms.
+
+	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
+	  microcontrollers.
+
 config MIPS_SEAD3
 	bool "MIPS SEAD3 board"
 	select BOOT_ELF32
@@ -980,6 +988,7 @@ source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
 source "arch/mips/lantiq/Kconfig"
 source "arch/mips/lasat/Kconfig"
+source "arch/mips/pic32/Kconfig"
 source "arch/mips/pistachio/Kconfig"
 source "arch/mips/pmcs-msp71xx/Kconfig"
 source "arch/mips/ralink/Kconfig"
diff --git a/arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h b/arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h
new file mode 100644
index 0000000..4682308
--- /dev/null
+++ b/arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h
@@ -0,0 +1,32 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_MACH_PIC32_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_PIC32_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * CPU feature overrides for PIC32 boards
+ */
+#ifdef CONFIG_CPU_MIPS32
+#define cpu_has_vint		1
+#define cpu_has_veic		0
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+#define cpu_has_fpu		0
+#define cpu_has_counter		1
+#define cpu_has_llsc		1
+#define cpu_has_nofpuex		0
+#define cpu_icache_snoops_remote_store 1
+#endif
+
+#ifdef CONFIG_CPU_MIPS64
+#error This platform does not support 64bit.
+#endif
+
+#endif /* __ASM_MACH_PIC32_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-pic32/irq.h b/arch/mips/include/asm/mach-pic32/irq.h
new file mode 100644
index 0000000..864330c
--- /dev/null
+++ b/arch/mips/include/asm/mach-pic32/irq.h
@@ -0,0 +1,22 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#ifndef __ASM_MACH_PIC32_IRQ_H
+#define __ASM_MACH_PIC32_IRQ_H
+
+#define NR_IRQS	256
+#define MIPS_CPU_IRQ_BASE 0
+
+#include_next <irq.h>
+
+#endif /* __ASM_MACH_PIC32_IRQ_H */
diff --git a/arch/mips/include/asm/mach-pic32/pic32.h b/arch/mips/include/asm/mach-pic32/pic32.h
new file mode 100644
index 0000000..ce52e91
--- /dev/null
+++ b/arch/mips/include/asm/mach-pic32/pic32.h
@@ -0,0 +1,44 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#ifndef _ASM_MACH_PIC32_H
+#define _ASM_MACH_PIC32_H
+
+#include <linux/io.h>
+
+/*
+ * PIC32 register offsets for SET/CLR/INV where supported.
+ */
+#define PIC32_CLR(_reg)		((_reg) + 0x04)
+#define PIC32_SET(_reg)		((_reg) + 0x08)
+#define PIC32_INV(_reg)		((_reg) + 0x0C)
+
+/*
+ * PIC32 Base Register Offsets
+ */
+#define PIC32_BASE_CONFIG	0x1f800000
+#define PIC32_BASE_OSC		0x1f801200
+#define PIC32_BASE_RESET	0x1f801240
+#define PIC32_BASE_PPS		0x1f801400
+#define PIC32_BASE_UART		0x1f822000
+#define PIC32_BASE_PORT		0x1f860000
+#define PIC32_BASE_DEVCFG2	0x1fc4ff44
+
+/*
+ * Register unlock sequence required for some register access.
+ */
+void pic32_syskey_unlock_debug(const char *fn, const ulong ln);
+#define pic32_syskey_unlock()	\
+	pic32_syskey_unlock_debug(__func__, __LINE__)
+
+#endif /* _ASM_MACH_PIC32_H */
diff --git a/arch/mips/include/asm/mach-pic32/spaces.h b/arch/mips/include/asm/mach-pic32/spaces.h
new file mode 100644
index 0000000..046a0a9
--- /dev/null
+++ b/arch/mips/include/asm/mach-pic32/spaces.h
@@ -0,0 +1,24 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#ifndef _ASM_MACH_PIC32_SPACES_H
+#define _ASM_MACH_PIC32_SPACES_H
+
+#ifdef CONFIG_PIC32MZDA
+#define PHYS_OFFSET	_AC(0x08000000, UL)
+#define UNCAC_BASE	_AC(0xa8000000, UL)
+#endif
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_MACH_PIC32_SPACES_H */
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
new file mode 100644
index 0000000..9be43c1
--- /dev/null
+++ b/arch/mips/pic32/Kconfig
@@ -0,0 +1,35 @@
+if MACH_PIC32
+
+choice
+	prompt "Machine Type"
+
+config PIC32MZDA
+	bool "Microchip PIC32MZDA Platform"
+	select BOOT_ELF32
+	select BOOT_RAW
+	select CEVT_R4K
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_MACH_CLKDEV
+	select COMMON_CLK
+	select CLKDEV_LOOKUP
+	select LIBFDT
+	select USE_OF
+	select PINCTRL
+	select PIC32_EVIC
+	help
+	  Support for the Microchip PIC32MZDA microcontroller.
+
+	  This is a 32-bit microcontroller with support for external or
+	  internally packaged DDR2 memory up to 128MB.
+
+	  For more information, see <http://www.microchip.com/>.
+
+endchoice
+
+endif # MACH_PIC32
diff --git a/arch/mips/pic32/Makefile b/arch/mips/pic32/Makefile
new file mode 100644
index 0000000..fd357f4
--- /dev/null
+++ b/arch/mips/pic32/Makefile
@@ -0,0 +1,6 @@
+#
+# Joshua Henderson, <joshua.henderson@microchip.com>
+# Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
+#
+obj-$(CONFIG_MACH_PIC32) += common/
+obj-$(CONFIG_PIC32MZDA) += pic32mzda/
diff --git a/arch/mips/pic32/Platform b/arch/mips/pic32/Platform
new file mode 100644
index 0000000..cd2084f
--- /dev/null
+++ b/arch/mips/pic32/Platform
@@ -0,0 +1,7 @@
+#
+# PIC32MZDA
+#
+platform-$(CONFIG_PIC32MZDA)	+= pic32/
+cflags-$(CONFIG_PIC32MZDA)	+= -I$(srctree)/arch/mips/include/asm/mach-pic32
+load-$(CONFIG_PIC32MZDA)	+= 0xffffffff88000000
+all-$(CONFIG_PIC32MZDA)		:= $(COMPRESSION_FNAME).bin
diff --git a/arch/mips/pic32/common/Makefile b/arch/mips/pic32/common/Makefile
new file mode 100644
index 0000000..be1909c
--- /dev/null
+++ b/arch/mips/pic32/common/Makefile
@@ -0,0 +1,5 @@
+#
+# Joshua Henderson, <joshua.henderson@microchip.com>
+# Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
+#
+obj-y = reset.o irq.o
diff --git a/arch/mips/pic32/common/irq.c b/arch/mips/pic32/common/irq.c
new file mode 100644
index 0000000..6df347e
--- /dev/null
+++ b/arch/mips/pic32/common/irq.c
@@ -0,0 +1,21 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <asm/irq.h>
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
diff --git a/arch/mips/pic32/common/reset.c b/arch/mips/pic32/common/reset.c
new file mode 100644
index 0000000..8334575
--- /dev/null
+++ b/arch/mips/pic32/common/reset.c
@@ -0,0 +1,62 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <asm/reboot.h>
+#include <asm/mach-pic32/pic32.h>
+
+#define PIC32_RSWRST		0x10
+
+static void pic32_halt(void)
+{
+	while (1) {
+		__asm__(".set push;\n"
+			".set arch=r4000;\n"
+			"wait;\n"
+			".set pop;\n"
+		);
+	}
+}
+
+static void pic32_machine_restart(char *command)
+{
+	void __iomem *reg =
+		ioremap(PIC32_BASE_RESET + PIC32_RSWRST, sizeof(u32));
+
+	pic32_syskey_unlock();
+
+	/* magic write/read */
+	__raw_writel(1, reg);
+	(void)__raw_readl(reg);
+
+	pic32_halt();
+}
+
+static void pic32_machine_halt(void)
+{
+	local_irq_disable();
+
+	pic32_halt();
+}
+
+static int __init mips_reboot_setup(void)
+{
+	_machine_restart = pic32_machine_restart;
+	_machine_halt = pic32_machine_halt;
+	pm_power_off = pic32_machine_halt;
+
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
diff --git a/arch/mips/pic32/pic32mzda/Makefile b/arch/mips/pic32/pic32mzda/Makefile
new file mode 100644
index 0000000..4a4c272
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/Makefile
@@ -0,0 +1,9 @@
+#
+# Joshua Henderson, <joshua.henderson@microchip.com>
+# Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
+#
+obj-y			:= init.o time.o config.o
+
+obj-$(CONFIG_EARLY_PRINTK)	+= early_console.o      \
+				   early_pin.o		\
+				   early_clk.o
diff --git a/arch/mips/pic32/pic32mzda/config.c b/arch/mips/pic32/pic32mzda/config.c
new file mode 100644
index 0000000..fe293a0
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/config.c
@@ -0,0 +1,126 @@
+/*
+ * Purna Chandra Mandal, purna.mandal@microchip.com
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach-pic32/pic32.h>
+
+#include "pic32mzda.h"
+
+#define PIC32_CFGCON	0x0000
+#define PIC32_DEVID	0x0020
+#define PIC32_SYSKEY	0x0030
+#define PIC32_CFGEBIA	0x00c0
+#define PIC32_CFGEBIC	0x00d0
+#define PIC32_CFGCON2	0x00f0
+#define PIC32_RCON	0x1240
+
+static void __iomem *pic32_conf_base;
+static DEFINE_SPINLOCK(config_lock);
+static u32 pic32_reset_status;
+
+static u32 pic32_conf_get_reg_field(u32 offset, u32 rshift, u32 mask)
+{
+	u32 v;
+
+	v = readl(pic32_conf_base + offset);
+	v >>= rshift;
+	v &= mask;
+
+	return v;
+}
+
+static u32 pic32_conf_modify_atomic(u32 offset, u32 mask, u32 set)
+{
+	u32 v;
+	unsigned long flags;
+
+	spin_lock_irqsave(&config_lock, flags);
+	v = readl(pic32_conf_base + offset);
+	v &= ~mask;
+	v |= (set & mask);
+	writel(v, pic32_conf_base + offset);
+	spin_unlock_irqrestore(&config_lock, flags);
+
+	return 0;
+}
+
+int pic32_enable_lcd(void)
+{
+	return pic32_conf_modify_atomic(PIC32_CFGCON2, BIT(31), BIT(31));
+}
+
+int pic32_disable_lcd(void)
+{
+	return pic32_conf_modify_atomic(PIC32_CFGCON2, BIT(31), 0);
+}
+
+int pic32_set_lcd_mode(int mode)
+{
+	u32 mask = mode ? BIT(30) : 0;
+
+	return pic32_conf_modify_atomic(PIC32_CFGCON2, BIT(30), mask);
+}
+
+int pic32_set_sdhci_adma_fifo_threshold(u32 rthrsh, u32 wthrsh)
+{
+	u32 clr, set;
+
+	clr = (0x3ff << 4) | (0x3ff << 16);
+	set = (rthrsh << 4) | (wthrsh << 16);
+	return pic32_conf_modify_atomic(PIC32_CFGCON2, clr, set);
+}
+
+void pic32_syskey_unlock_debug(const char *func, const ulong line)
+{
+	void __iomem *syskey = pic32_conf_base + PIC32_SYSKEY;
+
+	pr_debug("%s: called from %s:%lu\n", __func__, func, line);
+	writel(0x00000000, syskey);
+	writel(0xAA996655, syskey);
+	writel(0x556699AA, syskey);
+}
+
+static u32 pic32_get_device_id(void)
+{
+	return pic32_conf_get_reg_field(PIC32_DEVID, 0, 0x0fffffff);
+}
+
+static u32 pic32_get_device_version(void)
+{
+	return pic32_conf_get_reg_field(PIC32_DEVID, 28, 0xf);
+}
+
+u32 pic32_get_boot_status(void)
+{
+	return pic32_reset_status;
+}
+EXPORT_SYMBOL(pic32_get_boot_status);
+
+void __init pic32_config_init(void)
+{
+	pic32_conf_base = ioremap(PIC32_BASE_CONFIG, 0x110);
+	if (!pic32_conf_base)
+		panic("pic32: config base not mapped");
+
+	/* Boot Status */
+	pic32_reset_status = readl(pic32_conf_base + PIC32_RCON);
+	writel(-1, PIC32_CLR(pic32_conf_base + PIC32_RCON));
+
+	/* Device Inforation */
+	pr_info("Device Id: 0x%08x, Device Ver: 0x%04x\n",
+		pic32_get_device_id(),
+		pic32_get_device_version());
+}
diff --git a/arch/mips/pic32/pic32mzda/early_clk.c b/arch/mips/pic32/pic32mzda/early_clk.c
new file mode 100644
index 0000000..96c090e
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/early_clk.c
@@ -0,0 +1,106 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <asm/mach-pic32/pic32.h>
+
+#include "pic32mzda.h"
+
+/* Oscillators, PLL & clocks */
+#define ICLK_MASK	0x00000080
+#define PLLDIV_MASK	0x00000007
+#define CUROSC_MASK	0x00000007
+#define PLLMUL_MASK	0x0000007F
+#define PB_MASK		0x00000007
+#define FRC1		0
+#define FRC2		7
+#define SPLL		1
+#define POSC		2
+#define FRC_CLK		8000000
+
+#define PIC32_POSC_FREQ	24000000
+
+#define OSCCON		0x0000
+#define SPLLCON		0x0020
+#define PB1DIV		0x0140
+
+u32 pic32_get_sysclk(void)
+{
+	u32 osc_freq = 0;
+	u32 pllclk;
+	u32 frcdivn;
+	u32 osccon;
+	u32 spllcon;
+	int curr_osc;
+
+	u32 plliclk;
+	u32 pllidiv;
+	u32 pllodiv;
+	u32 pllmult;
+	u32 frcdiv;
+
+	void __iomem *osc_base = ioremap(PIC32_BASE_OSC, 0x200);
+
+	osccon = __raw_readl(osc_base + OSCCON);
+	spllcon = __raw_readl(osc_base + SPLLCON);
+
+	plliclk = (spllcon & ICLK_MASK);
+	pllidiv = ((spllcon >> 8) & PLLDIV_MASK) + 1;
+	pllodiv = ((spllcon >> 24) & PLLDIV_MASK);
+	pllmult = ((spllcon >> 16) & PLLMUL_MASK) + 1;
+	frcdiv = ((osccon >> 24) & PLLDIV_MASK);
+
+	pllclk = plliclk ? FRC_CLK : PIC32_POSC_FREQ;
+	frcdivn = ((1 << frcdiv) + 1) + (128 * (frcdiv == 7));
+
+	if (pllodiv < 2)
+		pllodiv = 2;
+	else if (pllodiv < 5)
+		pllodiv = (1 << pllodiv);
+	else
+		pllodiv = 32;
+
+	curr_osc = (int)((osccon >> 12) & CUROSC_MASK);
+
+	switch (curr_osc) {
+	case FRC1:
+	case FRC2:
+		osc_freq = FRC_CLK / frcdivn;
+		break;
+	case SPLL:
+		osc_freq = ((pllclk / pllidiv) * pllmult) / pllodiv;
+		break;
+	case POSC:
+		osc_freq = PIC32_POSC_FREQ;
+		break;
+	default:
+		break;
+	}
+
+	iounmap(osc_base);
+
+	return osc_freq;
+}
+
+u32 pic32_get_pbclk(int bus)
+{
+	u32 clk_freq;
+	void __iomem *osc_base = ioremap(PIC32_BASE_OSC, 0x200);
+	u32 pbxdiv = PB1DIV + ((bus - 1) * 0x10);
+	u32 pbdiv = (__raw_readl(osc_base + pbxdiv) & PB_MASK) + 1;
+
+	iounmap(osc_base);
+
+	clk_freq = pic32_get_sysclk();
+
+	return clk_freq / pbdiv;
+}
diff --git a/arch/mips/pic32/pic32mzda/early_console.c b/arch/mips/pic32/pic32mzda/early_console.c
new file mode 100644
index 0000000..d7b7834
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/early_console.c
@@ -0,0 +1,171 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <asm/mach-pic32/pic32.h>
+#include <asm/fw/fw.h>
+
+#include "pic32mzda.h"
+#include "early_pin.h"
+
+/* Default early console parameters */
+#define EARLY_CONSOLE_PORT	1
+#define EARLY_CONSOLE_BAUDRATE	115200
+
+#define UART_ENABLE		BIT(15)
+#define UART_ENABLE_RX		BIT(12)
+#define UART_ENABLE_TX		BIT(10)
+#define UART_TX_FULL		BIT(9)
+
+/* UART1(x == 0) - UART6(x == 5) */
+#define UART_BASE(x)	((x) * 0x0200)
+#define U_MODE(x)	UART_BASE(x)
+#define U_STA(x)	(UART_BASE(x) + 0x10)
+#define U_TXR(x)	(UART_BASE(x) + 0x20)
+#define U_BRG(x)	(UART_BASE(x) + 0x40)
+
+static void __iomem *uart_base;
+static char console_port = -1;
+
+static int __init configure_uart_pins(int port)
+{
+	switch (port) {
+	case 1:
+		pic32_pps_input(IN_FUNC_U2RX, IN_RPB0);
+		pic32_pps_output(OUT_FUNC_U2TX, OUT_RPG9);
+		break;
+	case 5:
+		pic32_pps_input(IN_FUNC_U6RX, IN_RPD0);
+		pic32_pps_output(OUT_FUNC_U6TX, OUT_RPB8);
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+static void __init configure_uart(char port, int baud)
+{
+	u32 pbclk;
+
+	pbclk = pic32_get_pbclk(2);
+
+	__raw_writel(0, uart_base + U_MODE(port));
+	__raw_writel(((pbclk / baud) / 16) - 1, uart_base + U_BRG(port));
+	__raw_writel(UART_ENABLE, uart_base + U_MODE(port));
+	__raw_writel(UART_ENABLE_TX | UART_ENABLE_RX,
+		     uart_base + PIC32_SET(U_STA(port)));
+}
+
+static void __init setup_early_console(char port, int baud)
+{
+	if (configure_uart_pins(port))
+		return;
+
+	console_port = port;
+	configure_uart(console_port, baud);
+}
+
+static char * __init pic32_getcmdline(void)
+{
+	/*
+	 * arch_mem_init() has not been called yet, so we don't have a real
+	 * command line setup if using CONFIG_CMDLINE_BOOL.
+	 */
+#ifdef CONFIG_CMDLINE_OVERRIDE
+	return CONFIG_CMDLINE;
+#else
+	return fw_getcmdline();
+#endif
+}
+
+static int __init get_port_from_cmdline(char *arch_cmdline)
+{
+	char *s;
+	int port = -1;
+
+	if (!arch_cmdline || *arch_cmdline == '\0')
+		goto _out;
+
+	s = strstr(arch_cmdline, "earlyprintk=");
+	if (s) {
+		s = strstr(s, "ttyS");
+		if (s)
+			s += 4;
+		else
+			goto _out;
+
+		port = (*s) - '0';
+	}
+
+_out:
+	return port;
+}
+
+static int __init get_baud_from_cmdline(char *arch_cmdline)
+{
+	char *s;
+	int baud = -1;
+
+	if (!arch_cmdline || *arch_cmdline == '\0')
+		goto _out;
+
+	s = strstr(arch_cmdline, "earlyprintk=");
+	if (s) {
+		s = strstr(s, "ttyS");
+		if (s)
+			s += 6;
+		else
+			goto _out;
+
+		baud = 0;
+		while (*s >= '0' && *s <= '9')
+			baud = baud * 10 + *s++ - '0';
+	}
+
+_out:
+	return baud;
+}
+
+void __init fw_init_early_console(char port)
+{
+	char *arch_cmdline = pic32_getcmdline();
+	int baud = -1;
+
+	uart_base = ioremap_nocache(PIC32_BASE_UART, 0xc00);
+
+	baud = get_baud_from_cmdline(arch_cmdline);
+	if (port == -1)
+		port = get_port_from_cmdline(arch_cmdline);
+
+	if (port == -1)
+		port = EARLY_CONSOLE_PORT;
+
+	if (baud == -1)
+		baud = EARLY_CONSOLE_BAUDRATE;
+
+	setup_early_console(port, baud);
+}
+
+int prom_putchar(char c)
+{
+	if (console_port >= 0) {
+		while (__raw_readl(
+				uart_base + U_STA(console_port)) & UART_TX_FULL)
+			;
+
+		__raw_writel(c, uart_base + U_TXR(console_port));
+	}
+
+	return 1;
+}
diff --git a/arch/mips/pic32/pic32mzda/early_pin.c b/arch/mips/pic32/pic32mzda/early_pin.c
new file mode 100644
index 0000000..aa673f8
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/early_pin.c
@@ -0,0 +1,275 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <asm/io.h>
+
+#include "early_pin.h"
+
+#define PPS_BASE 0x1f800000
+
+/* Input PPS Registers */
+#define INT1R 0x1404
+#define INT2R 0x1408
+#define INT3R 0x140C
+#define INT4R 0x1410
+#define T2CKR 0x1418
+#define T3CKR 0x141C
+#define T4CKR 0x1420
+#define T5CKR 0x1424
+#define T6CKR 0x1428
+#define T7CKR 0x142C
+#define T8CKR 0x1430
+#define T9CKR 0x1434
+#define IC1R 0x1438
+#define IC2R 0x143C
+#define IC3R 0x1440
+#define IC4R 0x1444
+#define IC5R 0x1448
+#define IC6R 0x144C
+#define IC7R 0x1450
+#define IC8R 0x1454
+#define IC9R 0x1458
+#define OCFAR 0x1460
+#define U1RXR 0x1468
+#define U1CTSR 0x146C
+#define U2RXR 0x1470
+#define U2CTSR 0x1474
+#define U3RXR 0x1478
+#define U3CTSR 0x147C
+#define U4RXR 0x1480
+#define U4CTSR 0x1484
+#define U5RXR 0x1488
+#define U5CTSR 0x148C
+#define U6RXR 0x1490
+#define U6CTSR 0x1494
+#define SDI1R 0x149C
+#define SS1R 0x14A0
+#define SDI2R 0x14A8
+#define SS2R 0x14AC
+#define SDI3R 0x14B4
+#define SS3R 0x14B8
+#define SDI4R 0x14C0
+#define SS4R 0x14C4
+#define SDI5R 0x14CC
+#define SS5R 0x14D0
+#define SDI6R 0x14D8
+#define SS6R 0x14DC
+#define C1RXR 0x14E0
+#define C2RXR 0x14E4
+#define REFCLKI1R 0x14E8
+#define REFCLKI3R 0x14F0
+#define REFCLKI4R 0x14F4
+
+static const struct
+{
+	int function;
+	int reg;
+} input_pin_reg[] = {
+	{ IN_FUNC_INT3, INT3R },
+	{ IN_FUNC_T2CK, T2CKR },
+	{ IN_FUNC_T6CK, T6CKR },
+	{ IN_FUNC_IC3, IC3R  },
+	{ IN_FUNC_IC7, IC7R },
+	{ IN_FUNC_U1RX, U1RXR },
+	{ IN_FUNC_U2CTS, U2CTSR },
+	{ IN_FUNC_U5RX, U5RXR },
+	{ IN_FUNC_U6CTS, U6CTSR },
+	{ IN_FUNC_SDI1, SDI1R },
+	{ IN_FUNC_SDI3, SDI3R },
+	{ IN_FUNC_SDI5, SDI5R },
+	{ IN_FUNC_SS6, SS6R },
+	{ IN_FUNC_REFCLKI1, REFCLKI1R },
+	{ IN_FUNC_INT4, INT4R },
+	{ IN_FUNC_T5CK, T5CKR },
+	{ IN_FUNC_T7CK, T7CKR },
+	{ IN_FUNC_IC4, IC4R },
+	{ IN_FUNC_IC8, IC8R },
+	{ IN_FUNC_U3RX, U3RXR },
+	{ IN_FUNC_U4CTS, U4CTSR },
+	{ IN_FUNC_SDI2, SDI2R },
+	{ IN_FUNC_SDI4, SDI4R },
+	{ IN_FUNC_C1RX, C1RXR },
+	{ IN_FUNC_REFCLKI4, REFCLKI4R },
+	{ IN_FUNC_INT2, INT2R },
+	{ IN_FUNC_T3CK, T3CKR },
+	{ IN_FUNC_T8CK, T8CKR },
+	{ IN_FUNC_IC2, IC2R },
+	{ IN_FUNC_IC5, IC5R },
+	{ IN_FUNC_IC9, IC9R },
+	{ IN_FUNC_U1CTS, U1CTSR },
+	{ IN_FUNC_U2RX, U2RXR },
+	{ IN_FUNC_U5CTS, U5CTSR },
+	{ IN_FUNC_SS1, SS1R },
+	{ IN_FUNC_SS3, SS3R },
+	{ IN_FUNC_SS4, SS4R },
+	{ IN_FUNC_SS5, SS5R },
+	{ IN_FUNC_C2RX, C2RXR },
+	{ IN_FUNC_INT1, INT1R },
+	{ IN_FUNC_T4CK, T4CKR },
+	{ IN_FUNC_T9CK, T9CKR },
+	{ IN_FUNC_IC1, IC1R },
+	{ IN_FUNC_IC6, IC6R },
+	{ IN_FUNC_U3CTS, U3CTSR },
+	{ IN_FUNC_U4RX, U4RXR },
+	{ IN_FUNC_U6RX, U6RXR },
+	{ IN_FUNC_SS2, SS2R },
+	{ IN_FUNC_SDI6, SDI6R },
+	{ IN_FUNC_OCFA, OCFAR },
+	{ IN_FUNC_REFCLKI3, REFCLKI3R },
+};
+
+void pic32_pps_input(int function, int pin)
+{
+	void __iomem *pps_base = ioremap_nocache(PPS_BASE, 0xF4);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(input_pin_reg); i++) {
+		if (input_pin_reg[i].function == function) {
+			__raw_writel(pin, pps_base + input_pin_reg[i].reg);
+			return;
+		}
+	}
+
+	iounmap(pps_base);
+}
+
+/* Output PPS Registers */
+#define RPA14R 0x1538
+#define RPA15R 0x153C
+#define RPB0R 0x1540
+#define RPB1R 0x1544
+#define RPB2R 0x1548
+#define RPB3R 0x154C
+#define RPB5R 0x1554
+#define RPB6R 0x1558
+#define RPB7R 0x155C
+#define RPB8R 0x1560
+#define RPB9R 0x1564
+#define RPB10R 0x1568
+#define RPB14R 0x1578
+#define RPB15R 0x157C
+#define RPC1R 0x1584
+#define RPC2R 0x1588
+#define RPC3R 0x158C
+#define RPC4R 0x1590
+#define RPC13R 0x15B4
+#define RPC14R 0x15B8
+#define RPD0R 0x15C0
+#define RPD1R 0x15C4
+#define RPD2R 0x15C8
+#define RPD3R 0x15CC
+#define RPD4R 0x15D0
+#define RPD5R 0x15D4
+#define RPD6R 0x15D8
+#define RPD7R 0x15DC
+#define RPD9R 0x15E4
+#define RPD10R 0x15E8
+#define RPD11R 0x15EC
+#define RPD12R 0x15F0
+#define RPD14R 0x15F8
+#define RPD15R 0x15FC
+#define RPE3R 0x160C
+#define RPE5R 0x1614
+#define RPE8R 0x1620
+#define RPE9R 0x1624
+#define RPF0R 0x1640
+#define RPF1R 0x1644
+#define RPF2R 0x1648
+#define RPF3R 0x164C
+#define RPF4R 0x1650
+#define RPF5R 0x1654
+#define RPF8R 0x1660
+#define RPF12R 0x1670
+#define RPF13R 0x1674
+#define RPG0R 0x1680
+#define RPG1R 0x1684
+#define RPG6R 0x1698
+#define RPG7R 0x169C
+#define RPG8R 0x16A0
+#define RPG9R 0x16A4
+
+static const struct
+{
+	int pin;
+	int reg;
+} output_pin_reg[] = {
+	{ OUT_RPD2, RPD2R },
+	{ OUT_RPG8, RPG8R },
+	{ OUT_RPF4, RPF4R },
+	{ OUT_RPD10, RPD10R },
+	{ OUT_RPF1, RPF1R },
+	{ OUT_RPB9, RPB9R },
+	{ OUT_RPB10, RPB10R },
+	{ OUT_RPC14, RPC14R },
+	{ OUT_RPB5, RPB5R },
+	{ OUT_RPC1, RPC1R },
+	{ OUT_RPD14, RPD14R },
+	{ OUT_RPG1, RPG1R },
+	{ OUT_RPA14, RPA14R },
+	{ OUT_RPD6, RPD6R },
+	{ OUT_RPD3, RPD3R },
+	{ OUT_RPG7, RPG7R },
+	{ OUT_RPF5, RPF5R },
+	{ OUT_RPD11, RPD11R },
+	{ OUT_RPF0, RPF0R },
+	{ OUT_RPB1, RPB1R },
+	{ OUT_RPE5, RPE5R },
+	{ OUT_RPC13, RPC13R },
+	{ OUT_RPB3, RPB3R },
+	{ OUT_RPC4, RPC4R },
+	{ OUT_RPD15, RPD15R },
+	{ OUT_RPG0, RPG0R },
+	{ OUT_RPA15, RPA15R },
+	{ OUT_RPD7, RPD7R },
+	{ OUT_RPD9, RPD9R },
+	{ OUT_RPG6, RPG6R },
+	{ OUT_RPB8, RPB8R },
+	{ OUT_RPB15, RPB15R },
+	{ OUT_RPD4, RPD4R },
+	{ OUT_RPB0, RPB0R },
+	{ OUT_RPE3, RPE3R },
+	{ OUT_RPB7, RPB7R },
+	{ OUT_RPF12, RPF12R },
+	{ OUT_RPD12, RPD12R },
+	{ OUT_RPF8, RPF8R },
+	{ OUT_RPC3, RPC3R },
+	{ OUT_RPE9, RPE9R },
+	{ OUT_RPD1, RPD1R },
+	{ OUT_RPG9, RPG9R },
+	{ OUT_RPB14, RPB14R },
+	{ OUT_RPD0, RPD0R },
+	{ OUT_RPB6, RPB6R },
+	{ OUT_RPD5, RPD5R },
+	{ OUT_RPB2, RPB2R },
+	{ OUT_RPF3, RPF3R },
+	{ OUT_RPF13, RPF13R },
+	{ OUT_RPC2, RPC2R },
+	{ OUT_RPE8, RPE8R },
+	{ OUT_RPF2, RPF2R },
+};
+
+void pic32_pps_output(int function, int pin)
+{
+	void __iomem *pps_base = ioremap_nocache(PPS_BASE, 0x170);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(output_pin_reg); i++) {
+		if (output_pin_reg[i].pin == pin) {
+			__raw_writel(function,
+				pps_base + output_pin_reg[i].reg);
+			return;
+		}
+	}
+
+	iounmap(pps_base);
+}
diff --git a/arch/mips/pic32/pic32mzda/early_pin.h b/arch/mips/pic32/pic32mzda/early_pin.h
new file mode 100644
index 0000000..417fae9
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/early_pin.h
@@ -0,0 +1,241 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#ifndef _PIC32MZDA_EARLY_PIN_H
+#define _PIC32MZDA_EARLY_PIN_H
+
+/*
+ * This is a complete, yet overly simplistic and unoptimized, PIC32MZDA PPS
+ * configuration only useful before we have full pinctrl initialized.
+ */
+
+/* Input PPS Functions */
+enum {
+	IN_FUNC_INT3,
+	IN_FUNC_T2CK,
+	IN_FUNC_T6CK,
+	IN_FUNC_IC3,
+	IN_FUNC_IC7,
+	IN_FUNC_U1RX,
+	IN_FUNC_U2CTS,
+	IN_FUNC_U5RX,
+	IN_FUNC_U6CTS,
+	IN_FUNC_SDI1,
+	IN_FUNC_SDI3,
+	IN_FUNC_SDI5,
+	IN_FUNC_SS6,
+	IN_FUNC_REFCLKI1,
+	IN_FUNC_INT4,
+	IN_FUNC_T5CK,
+	IN_FUNC_T7CK,
+	IN_FUNC_IC4,
+	IN_FUNC_IC8,
+	IN_FUNC_U3RX,
+	IN_FUNC_U4CTS,
+	IN_FUNC_SDI2,
+	IN_FUNC_SDI4,
+	IN_FUNC_C1RX,
+	IN_FUNC_REFCLKI4,
+	IN_FUNC_INT2,
+	IN_FUNC_T3CK,
+	IN_FUNC_T8CK,
+	IN_FUNC_IC2,
+	IN_FUNC_IC5,
+	IN_FUNC_IC9,
+	IN_FUNC_U1CTS,
+	IN_FUNC_U2RX,
+	IN_FUNC_U5CTS,
+	IN_FUNC_SS1,
+	IN_FUNC_SS3,
+	IN_FUNC_SS4,
+	IN_FUNC_SS5,
+	IN_FUNC_C2RX,
+	IN_FUNC_INT1,
+	IN_FUNC_T4CK,
+	IN_FUNC_T9CK,
+	IN_FUNC_IC1,
+	IN_FUNC_IC6,
+	IN_FUNC_U3CTS,
+	IN_FUNC_U4RX,
+	IN_FUNC_U6RX,
+	IN_FUNC_SS2,
+	IN_FUNC_SDI6,
+	IN_FUNC_OCFA,
+	IN_FUNC_REFCLKI3,
+};
+
+/* Input PPS Pins */
+#define IN_RPD2 0x00
+#define IN_RPG8 0x01
+#define IN_RPF4 0x02
+#define IN_RPD10 0x03
+#define IN_RPF1 0x04
+#define IN_RPB9 0x05
+#define IN_RPB10 0x06
+#define IN_RPC14 0x07
+#define IN_RPB5 0x08
+#define IN_RPC1 0x0A
+#define IN_RPD14 0x0B
+#define IN_RPG1 0x0C
+#define IN_RPA14 0x0D
+#define IN_RPD6 0x0E
+#define IN_RPD3 0x00
+#define IN_RPG7 0x01
+#define IN_RPF5 0x02
+#define IN_RPD11 0x03
+#define IN_RPF0 0x04
+#define IN_RPB1 0x05
+#define IN_RPE5 0x06
+#define IN_RPC13 0x07
+#define IN_RPB3 0x08
+#define IN_RPC4 0x0A
+#define IN_RPD15 0x0B
+#define IN_RPG0 0x0C
+#define IN_RPA15 0x0D
+#define IN_RPD7 0x0E
+#define IN_RPD9 0x00
+#define IN_RPG6 0x01
+#define IN_RPB8 0x02
+#define IN_RPB15 0x03
+#define IN_RPD4 0x04
+#define IN_RPB0 0x05
+#define IN_RPE3 0x06
+#define IN_RPB7 0x07
+#define IN_RPF12 0x09
+#define IN_RPD12 0x0A
+#define IN_RPF8 0x0B
+#define IN_RPC3 0x0C
+#define IN_RPE9 0x0D
+#define IN_RPD1 0x00
+#define IN_RPG9 0x01
+#define IN_RPB14 0x02
+#define IN_RPD0 0x03
+#define IN_RPB6 0x05
+#define IN_RPD5 0x06
+#define IN_RPB2 0x07
+#define IN_RPF3 0x08
+#define IN_RPF13 0x09
+#define IN_RPF2 0x0B
+#define IN_RPC2 0x0C
+#define IN_RPE8 0x0D
+
+/* Output PPS Pins */
+enum {
+	OUT_RPD2,
+	OUT_RPG8,
+	OUT_RPF4,
+	OUT_RPD10,
+	OUT_RPF1,
+	OUT_RPB9,
+	OUT_RPB10,
+	OUT_RPC14,
+	OUT_RPB5,
+	OUT_RPC1,
+	OUT_RPD14,
+	OUT_RPG1,
+	OUT_RPA14,
+	OUT_RPD6,
+	OUT_RPD3,
+	OUT_RPG7,
+	OUT_RPF5,
+	OUT_RPD11,
+	OUT_RPF0,
+	OUT_RPB1,
+	OUT_RPE5,
+	OUT_RPC13,
+	OUT_RPB3,
+	OUT_RPC4,
+	OUT_RPD15,
+	OUT_RPG0,
+	OUT_RPA15,
+	OUT_RPD7,
+	OUT_RPD9,
+	OUT_RPG6,
+	OUT_RPB8,
+	OUT_RPB15,
+	OUT_RPD4,
+	OUT_RPB0,
+	OUT_RPE3,
+	OUT_RPB7,
+	OUT_RPF12,
+	OUT_RPD12,
+	OUT_RPF8,
+	OUT_RPC3,
+	OUT_RPE9,
+	OUT_RPD1,
+	OUT_RPG9,
+	OUT_RPB14,
+	OUT_RPD0,
+	OUT_RPB6,
+	OUT_RPD5,
+	OUT_RPB2,
+	OUT_RPF3,
+	OUT_RPF13,
+	OUT_RPC2,
+	OUT_RPE8,
+	OUT_RPF2,
+};
+
+/* Output PPS Functions */
+#define OUT_FUNC_U3TX 0x01
+#define OUT_FUNC_U4RTS 0x02
+#define OUT_FUNC_SDO1 0x05
+#define OUT_FUNC_SDO2 0x06
+#define OUT_FUNC_SDO3 0x07
+#define OUT_FUNC_SDO5 0x09
+#define OUT_FUNC_SS6 0x0A
+#define OUT_FUNC_OC3 0x0B
+#define OUT_FUNC_OC6 0x0C
+#define OUT_FUNC_REFCLKO4 0x0D
+#define OUT_FUNC_C2OUT 0x0E
+#define OUT_FUNC_C1TX 0x0F
+#define OUT_FUNC_U1TX 0x01
+#define OUT_FUNC_U2RTS 0x02
+#define OUT_FUNC_U5TX 0x03
+#define OUT_FUNC_U6RTS 0x04
+#define OUT_FUNC_SDO1 0x05
+#define OUT_FUNC_SDO2 0x06
+#define OUT_FUNC_SDO3 0x07
+#define OUT_FUNC_SDO4 0x08
+#define OUT_FUNC_SDO5 0x09
+#define OUT_FUNC_OC4 0x0B
+#define OUT_FUNC_OC7 0x0C
+#define OUT_FUNC_REFCLKO1 0x0F
+#define OUT_FUNC_U3RTS 0x01
+#define OUT_FUNC_U4TX 0x02
+#define OUT_FUNC_U6TX 0x04
+#define OUT_FUNC_SS1 0x05
+#define OUT_FUNC_SS3 0x07
+#define OUT_FUNC_SS4 0x08
+#define OUT_FUNC_SS5 0x09
+#define OUT_FUNC_SDO6 0x0A
+#define OUT_FUNC_OC5 0x0B
+#define OUT_FUNC_OC8 0x0C
+#define OUT_FUNC_C1OUT 0x0E
+#define OUT_FUNC_REFCLKO3 0x0F
+#define OUT_FUNC_U1RTS 0x01
+#define OUT_FUNC_U2TX 0x02
+#define OUT_FUNC_U5RTS 0x03
+#define OUT_FUNC_U6TX 0x04
+#define OUT_FUNC_SS2 0x06
+#define OUT_FUNC_SDO4 0x08
+#define OUT_FUNC_SDO6 0x0A
+#define OUT_FUNC_OC2 0x0B
+#define OUT_FUNC_OC1 0x0C
+#define OUT_FUNC_OC9 0x0D
+#define OUT_FUNC_C2TX 0x0F
+
+void pic32_pps_input(int function, int pin);
+void pic32_pps_output(int function, int pin);
+
+#endif
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
new file mode 100644
index 0000000..775ff90
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -0,0 +1,156 @@
+/*
+ * Joshua Henderson, joshua.henderson@microchip.com
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/platform_data/sdhci-pic32.h>
+
+#include <asm/fw/fw.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/prom.h>
+
+#include "pic32mzda.h"
+
+const char *get_system_type(void)
+{
+	return "PIC32MZDA";
+}
+
+static ulong get_fdtaddr(void)
+{
+	ulong ftaddr = 0;
+
+	if ((fw_arg0 == -2) && fw_arg1 && !fw_arg2 && !fw_arg3)
+		return (ulong)fw_arg1;
+
+	if (__dtb_start < __dtb_end)
+		ftaddr = (ulong)__dtb_start;
+
+	return ftaddr;
+}
+
+void __init plat_mem_setup(void)
+{
+	void *dtb;
+
+	dtb = (void *)get_fdtaddr();
+	if (!dtb) {
+		pr_err("pic32: no DTB found.\n");
+		return;
+	}
+
+	/*
+	 * Load the builtin device tree. This causes the chosen node to be
+	 * parsed resulting in our memory appearing.
+	 */
+	__dt_setup_arch(dtb);
+
+	pr_info("Found following command lines\n");
+	pr_info(" boot_command_line: %s\n", boot_command_line);
+	pr_info(" arcs_cmdline     : %s\n", arcs_cmdline);
+#ifdef CONFIG_CMDLINE_BOOL
+	pr_info(" builtin_cmdline  : %s\n", CONFIG_CMDLINE);
+#endif
+	if (dtb != __dtb_start)
+		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+
+#ifdef CONFIG_EARLY_PRINTK
+	fw_init_early_console(-1);
+#endif
+	pic32_config_init();
+}
+
+static __init void pic32_init_cmdline(int argc, char *argv[])
+{
+	unsigned int count = COMMAND_LINE_SIZE - 1;
+	int i;
+	char *dst = &(arcs_cmdline[0]);
+	char *src;
+
+	for (i = 1; i < argc && count; ++i) {
+		src = argv[i];
+		while (*src && count) {
+			*dst++ = *src++;
+			--count;
+		}
+		*dst++ = ' ';
+	}
+	if (i > 1)
+		--dst;
+
+	*dst = 0;
+}
+
+void __init prom_init(void)
+{
+	pic32_init_cmdline((int)fw_arg0, (char **)fw_arg1);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init device_tree_init(void)
+{
+	if (!initial_boot_params)
+		return;
+
+	unflatten_and_copy_device_tree();
+}
+
+static struct pic32_sdhci_platform_data sdhci_data = {
+	.setup_dma = pic32_set_sdhci_adma_fifo_threshold,
+};
+
+static struct of_dev_auxdata pic32_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("microchip,pic32mzda-sdhci", 0, "sdhci", &sdhci_data),
+	{ /* sentinel */}
+};
+
+static int __init pic32_of_prepare_platform_data(struct of_dev_auxdata *lookup)
+{
+	struct device_node *root, *np;
+	struct resource res;
+
+	root = of_find_node_by_path("/");
+
+	for (; lookup->compatible; lookup++) {
+		np = of_find_compatible_node(NULL, NULL, lookup->compatible);
+		if (np) {
+			lookup->name = (char *)np->name;
+			if (lookup->phys_addr)
+				continue;
+			if (!of_address_to_resource(np, 0, &res))
+				lookup->phys_addr = res.start;
+		}
+	}
+
+	return 0;
+}
+
+static int __init plat_of_setup(void)
+{
+	if (!of_have_populated_dt())
+		panic("Device tree not present");
+
+	pic32_of_prepare_platform_data(pic32_auxdata_lookup);
+	if (of_platform_populate(NULL, of_default_bus_match_table,
+				 pic32_auxdata_lookup, NULL))
+		panic("Failed to populate DT");
+
+	return 0;
+}
+arch_initcall(plat_of_setup);
diff --git a/arch/mips/pic32/pic32mzda/pic32mzda.h b/arch/mips/pic32/pic32mzda/pic32mzda.h
new file mode 100644
index 0000000..96d10e2
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/pic32mzda.h
@@ -0,0 +1,29 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#ifndef PIC32MZDA_COMMON_H
+#define PIC32MZDA_COMMON_H
+
+/* early clock */
+u32 pic32_get_pbclk(int bus);
+u32 pic32_get_sysclk(void);
+
+/* Device configuration */
+void __init pic32_config_init(void);
+int pic32_set_lcd_mode(int mode);
+int pic32_set_sdhci_adma_fifo_threshold(u32 rthrs, u32 wthrs);
+u32 pic32_get_boot_status(void);
+int pic32_disable_lcd(void);
+int pic32_enable_lcd(void);
+
+#endif
diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
new file mode 100644
index 0000000..ca6a62b
--- /dev/null
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -0,0 +1,73 @@
+/*
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+
+#include <asm/time.h>
+
+#include "pic32mzda.h"
+
+static const struct of_device_id pic32_infra_match[] = {
+	{ .compatible = "microchip,pic32mzda-infra", },
+	{ },
+};
+
+#define DEFAULT_CORE_TIMER_INTERRUPT 0
+
+static unsigned int pic32_xlate_core_timer_irq(void)
+{
+	static struct device_node *node;
+	unsigned int irq;
+
+	node = of_find_matching_node(NULL, pic32_infra_match);
+
+	if (WARN_ON(!node))
+		goto default_map;
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq)
+		goto default_map;
+
+	return irq;
+
+default_map:
+
+	return irq_create_mapping(NULL, DEFAULT_CORE_TIMER_INTERRUPT);
+}
+
+unsigned int get_c0_compare_int(void)
+{
+	return pic32_xlate_core_timer_irq();
+}
+
+void __init plat_time_init(void)
+{
+	struct clk *clk;
+
+	of_clk_init(NULL);
+	clk = clk_get_sys("cpu_clk", NULL);
+	if (IS_ERR(clk))
+		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
+
+	clk_prepare_enable(clk);
+	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+
+	clocksource_probe();
+}
diff --git a/include/linux/platform_data/sdhci-pic32.h b/include/linux/platform_data/sdhci-pic32.h
new file mode 100644
index 0000000..7e0efe6
--- /dev/null
+++ b/include/linux/platform_data/sdhci-pic32.h
@@ -0,0 +1,22 @@
+/*
+ * Purna Chandra Mandal, purna.mandal@microchip.com
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#ifndef __PIC32_SDHCI_PDATA_H__
+#define __PIC32_SDHCI_PDATA_H__
+
+struct pic32_sdhci_platform_data {
+	/* read & write fifo threshold */
+	int (*setup_dma)(u32 rfifo, u32 wfifo);
+};
+
+#endif
-- 
1.7.9.5
