Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:31:25 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:48314 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010002AbaI1SbElfQU4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:04 +0200
Received: by mail-lb0-f172.google.com with SMTP id b6so1325454lbj.3
        for <multiple recipients>; Sun, 28 Sep 2014 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z2Vi19mDUaCm0l7YtbrmGZUVSvvI/5uS7McaMmaOaDU=;
        b=vd5coIvUC5kSWkvPXpZIg/+gEyYfK7VQUlAzODJPkkf7nyns5hG5mJxTEST0gjQLCz
         TOMperTk6RQa9tAL2VN+tARQXzWp9oMY+m2OuB2THGKdSBwqxwkue5aTOfIvvqXffjUa
         HocWL7LkBB1vo+Ou6UEVbfVwDdHn+riFOUmjaLT/1HS3n66ruEpOHg1VAcOUA9tc4qxg
         azAF5QuAtpE5uZQs/fVJj2OA/sDERelHzz34/7NEhJGHtQeVE/sGZ6M44xyFLsOxFrXb
         n0cMp+KA3egtLb+kHtlkl/M+XZltaV0r3v8NgmIyViFKkWbDgYEdySzA+N+okqGIRV35
         dnzg==
X-Received: by 10.112.25.65 with SMTP id a1mr32734356lbg.85.1411929058907;
        Sun, 28 Sep 2014 11:30:58 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.30.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:30:58 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 01/16] MIPS: ar231x: add common parts
Date:   Sun, 28 Sep 2014 22:33:00 +0400
Message-Id: <1411929195-23775-2-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/Kbuild.platforms                         |  1 +
 arch/mips/Kconfig                                  | 13 ++++
 arch/mips/ar231x/Makefile                          | 11 ++++
 arch/mips/ar231x/Platform                          |  6 ++
 arch/mips/ar231x/board.c                           | 53 +++++++++++++++
 arch/mips/ar231x/devices.c                         | 20 ++++++
 arch/mips/ar231x/devices.h                         | 22 +++++++
 arch/mips/ar231x/prom.c                            | 26 ++++++++
 arch/mips/include/asm/mach-ar231x/ar231x.h         | 29 +++++++++
 .../asm/mach-ar231x/cpu-feature-overrides.h        | 76 ++++++++++++++++++++++
 arch/mips/include/asm/mach-ar231x/dma-coherence.h  | 64 ++++++++++++++++++
 arch/mips/include/asm/mach-ar231x/gpio.h           | 16 +++++
 arch/mips/include/asm/mach-ar231x/war.h            | 25 +++++++
 13 files changed, 362 insertions(+)
 create mode 100644 arch/mips/ar231x/Makefile
 create mode 100644 arch/mips/ar231x/Platform
 create mode 100644 arch/mips/ar231x/board.c
 create mode 100644 arch/mips/ar231x/devices.c
 create mode 100644 arch/mips/ar231x/devices.h
 create mode 100644 arch/mips/ar231x/prom.c
 create mode 100644 arch/mips/include/asm/mach-ar231x/ar231x.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/gpio.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/war.h

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index f5e18bf..ee1940a 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -1,6 +1,7 @@
 # All platforms listed in alphabetic order
 
 platforms += alchemy
+platforms += ar231x
 platforms += ar7
 platforms += ath79
 platforms += bcm47xx
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 01c0389..6adae4c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -73,6 +73,19 @@ config MIPS_ALCHEMY
 	select SYS_SUPPORTS_ZBOOT
 	select COMMON_CLK
 
+config AR231X
+	bool "Atheros AR231x/AR531x SoC support"
+	select CEVT_R4K
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Support for Atheros AR231x and Atheros AR531x based boards
+
 config AR7
 	bool "Texas Instruments AR7"
 	select BOOT_ELF32
diff --git a/arch/mips/ar231x/Makefile b/arch/mips/ar231x/Makefile
new file mode 100644
index 0000000..9199fa1
--- /dev/null
+++ b/arch/mips/ar231x/Makefile
@@ -0,0 +1,11 @@
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2006 FON Technology, SL.
+# Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+# Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
+#
+
+obj-y += board.o prom.o devices.o
diff --git a/arch/mips/ar231x/Platform b/arch/mips/ar231x/Platform
new file mode 100644
index 0000000..c924fd1
--- /dev/null
+++ b/arch/mips/ar231x/Platform
@@ -0,0 +1,6 @@
+#
+# Atheros AR531X/AR231X WiSoC
+#
+platform-$(CONFIG_AR231X)	+= ar231x/
+cflags-$(CONFIG_AR231X)		+= -I$(srctree)/arch/mips/include/asm/mach-ar231x
+load-$(CONFIG_AR231X)		+= 0xffffffff80041000
diff --git a/arch/mips/ar231x/board.c b/arch/mips/ar231x/board.c
new file mode 100644
index 0000000..9cde045
--- /dev/null
+++ b/arch/mips/ar231x/board.c
@@ -0,0 +1,53 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/irq_cpu.h>
+#include <asm/reboot.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+
+static void ar231x_halt(void)
+{
+	local_irq_disable();
+	while (1)
+		;
+}
+
+void __init plat_mem_setup(void)
+{
+	_machine_halt = ar231x_halt;
+	pm_power_off = ar231x_halt;
+
+	/* Disable data watchpoints */
+	write_c0_watchlo0(0);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+}
+
+void __init plat_time_init(void)
+{
+}
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
+
+void __init arch_init_irq(void)
+{
+	clear_c0_status(ST0_IM);
+	mips_cpu_irq_init();
+}
+
diff --git a/arch/mips/ar231x/devices.c b/arch/mips/ar231x/devices.c
new file mode 100644
index 0000000..f71a643
--- /dev/null
+++ b/arch/mips/ar231x/devices.c
@@ -0,0 +1,20 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/bootinfo.h>
+
+#include "devices.h"
+
+int ar231x_devtype = DEV_TYPE_UNKNOWN;
+
+static const char * const devtype_strings[] = {
+	[DEV_TYPE_UNKNOWN] = "Atheros (unknown)",
+};
+
+const char *get_system_type(void)
+{
+	if ((ar231x_devtype >= ARRAY_SIZE(devtype_strings)) ||
+	    !devtype_strings[ar231x_devtype])
+		return devtype_strings[DEV_TYPE_UNKNOWN];
+	return devtype_strings[ar231x_devtype];
+}
+
diff --git a/arch/mips/ar231x/devices.h b/arch/mips/ar231x/devices.h
new file mode 100644
index 0000000..1590577
--- /dev/null
+++ b/arch/mips/ar231x/devices.h
@@ -0,0 +1,22 @@
+#ifndef __AR231X_DEVICES_H
+#define __AR231X_DEVICES_H
+
+#include <linux/cpu.h>
+
+enum {
+	DEV_TYPE_UNKNOWN
+};
+
+extern int ar231x_devtype;
+
+static inline bool is_2315(void)
+{
+	return (current_cpu_data.cputype == CPU_4KEC);
+}
+
+static inline bool is_5312(void)
+{
+	return !is_2315();
+}
+
+#endif
diff --git a/arch/mips/ar231x/prom.c b/arch/mips/ar231x/prom.c
new file mode 100644
index 0000000..522357f
--- /dev/null
+++ b/arch/mips/ar231x/prom.c
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright MontaVista Software Inc
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ */
+
+/*
+ * Prom setup file for ar231x
+ */
+
+#include <linux/init.h>
+#include <asm/bootinfo.h>
+
+void __init prom_init(void)
+{
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/include/asm/mach-ar231x/ar231x.h b/arch/mips/include/asm/mach-ar231x/ar231x.h
new file mode 100644
index 0000000..b830723
--- /dev/null
+++ b/arch/mips/include/asm/mach-ar231x/ar231x.h
@@ -0,0 +1,29 @@
+#ifndef __ASM_MACH_AR231X_H
+#define __ASM_MACH_AR231X_H
+
+#include <linux/io.h>
+
+#define AR231X_REG_MS(_val, _field)	(((_val) & _field##_M) >> _field##_S)
+
+static inline u32 ar231x_read_reg(u32 reg)
+{
+	return __raw_readl((void __iomem *)KSEG1ADDR(reg));
+}
+
+static inline void ar231x_write_reg(u32 reg, u32 val)
+{
+	__raw_writel(val, (void __iomem *)KSEG1ADDR(reg));
+}
+
+static inline u32 ar231x_mask_reg(u32 reg, u32 mask, u32 val)
+{
+	u32 ret = ar231x_read_reg(reg);
+
+	ret &= ~mask;
+	ret |= val;
+	ar231x_write_reg(reg, ret);
+
+	return ret;
+}
+
+#endif	/* __ASM_MACH_AR231X_H */
diff --git a/arch/mips/include/asm/mach-ar231x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ar231x/cpu-feature-overrides.h
new file mode 100644
index 0000000..337fe3e
--- /dev/null
+++ b/arch/mips/include/asm/mach-ar231x/cpu-feature-overrides.h
@@ -0,0 +1,76 @@
+/*
+ *  Atheros AR231x/AR531x SoC specific CPU feature overrides
+ *
+ *  Copyright (C) 2008 Gabor Juhos <juhosg@openwrt.org>
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
+#ifndef __ASM_MACH_AR231X_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_AR231X_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * The Atheros AR531x/AR231x SoCs have MIPS 4Kc/4KEc core.
+ */
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_tx39_cache		0
+#define cpu_has_sb1_cache		0
+#define cpu_has_fpu			0
+#define cpu_has_32fpr			0
+#define cpu_has_counter			1
+/* #define cpu_has_watch		? */
+/* #define cpu_has_divec		? */
+/* #define cpu_has_vce			? */
+/* #define cpu_has_cache_cdex_p		? */
+/* #define cpu_has_cache_cdex_s		? */
+/* #define cpu_has_prefetch		? */
+/* #define cpu_has_mcheck		? */
+#define cpu_has_ejtag			1
+
+/*
+ * The MIPS 4Kc V0.9 core in the AR5312/AR2312 have problems with the
+ * ll/sc instructions.
+ */
+#define cpu_has_llsc			0
+
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+
+/* #define cpu_has_vtag_icache		? */
+/* #define cpu_has_dc_aliases		? */
+/* #define cpu_has_ic_fills_f_dc	? */
+/* #define cpu_has_pindexed_dcache	? */
+
+/* #define cpu_icache_snoops_remote_store	? */
+
+#define cpu_has_mips32r1		1
+
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+
+/* #define cpu_has_nofpuex		? */
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+#define cpu_has_64bit_gp_regs		0
+#define cpu_has_64bit_addresses		0
+
+/* #define cpu_has_inclusive_pcaches	? */
+
+/* #define cpu_dcache_line_size()	? */
+/* #define cpu_icache_line_size()	? */
+
+#endif /* __ASM_MACH_AR231X_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ar231x/dma-coherence.h b/arch/mips/include/asm/mach-ar231x/dma-coherence.h
new file mode 100644
index 0000000..ed32240
--- /dev/null
+++ b/arch/mips/include/asm/mach-ar231x/dma-coherence.h
@@ -0,0 +1,64 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2007  Felix Fietkau <nbd@openwrt.org>
+ *
+ */
+#ifndef __ASM_MACH_AR231X_DMA_COHERENCE_H
+#define __ASM_MACH_AR231X_DMA_COHERENCE_H
+
+#include <linux/device.h>
+
+static inline dma_addr_t
+plat_map_dma_mem(struct device *dev, void *addr, size_t size)
+{
+	return virt_to_phys(addr);
+}
+
+static inline dma_addr_t
+plat_map_dma_mem_page(struct device *dev, struct page *page)
+{
+	return page_to_phys(page);
+}
+
+static inline unsigned long
+plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr;
+}
+
+static inline void
+plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr, size_t size,
+		   enum dma_data_direction direction)
+{
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+#ifdef CONFIG_DMA_COHERENT
+	return 1;
+#endif
+#ifdef CONFIG_DMA_NONCOHERENT
+	return 0;
+#endif
+}
+
+#endif /* __ASM_MACH_AR231X_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-ar231x/gpio.h b/arch/mips/include/asm/mach-ar231x/gpio.h
new file mode 100644
index 0000000..89d29f1
--- /dev/null
+++ b/arch/mips/include/asm/mach-ar231x/gpio.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_MACH_AR231X_GPIO_H
+#define __ASM_MACH_AR231X_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
+#define gpio_cansleep __gpio_cansleep
+#define gpio_to_irq __gpio_to_irq
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+
+#endif	/* __ASM_MACH_AR231X_GPIO_H */
diff --git a/arch/mips/include/asm/mach-ar231x/war.h b/arch/mips/include/asm/mach-ar231x/war.h
new file mode 100644
index 0000000..5faf9da
--- /dev/null
+++ b/arch/mips/include/asm/mach-ar231x/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Felix Fietkau <nbd@openwrt.org>
+ */
+#ifndef __ASM_MACH_AR231X_WAR_H
+#define __ASM_MACH_AR231X_WAR_H
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
+#endif /* __ASM_MACH_AR231X_WAR_H */
-- 
1.8.5.5
