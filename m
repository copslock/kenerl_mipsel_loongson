Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 19:07:07 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41578 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833500Ab3A0SGqux1Uz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Jan 2013 19:06:46 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 01/10] MIPS: ralink: adds include files
Date:   Sun, 27 Jan 2013 19:03:53 +0100
Message-Id: <1359309842-31925-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Before we start adding the platform code we add the common include files.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/ralink_regs.h |   39 ++++++++++++++++++++
 arch/mips/include/asm/mach-ralink/war.h         |   25 +++++++++++++
 arch/mips/ralink/common.h                       |   44 +++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/ralink_regs.h
 create mode 100644 arch/mips/include/asm/mach-ralink/war.h
 create mode 100644 arch/mips/ralink/common.h

diff --git a/arch/mips/include/asm/mach-ralink/ralink_regs.h b/arch/mips/include/asm/mach-ralink/ralink_regs.h
new file mode 100644
index 0000000..5a508f9
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/ralink_regs.h
@@ -0,0 +1,39 @@
+/*
+ *  Ralink SoC register definitions
+ *
+ *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _RALINK_REGS_H_
+#define _RALINK_REGS_H_
+
+extern __iomem void *rt_sysc_membase;
+extern __iomem void *rt_memc_membase;
+
+static inline void rt_sysc_w32(u32 val, unsigned reg)
+{
+	__raw_writel(val, rt_sysc_membase + reg);
+}
+
+static inline u32 rt_sysc_r32(unsigned reg)
+{
+	return __raw_readl(rt_sysc_membase + reg);
+}
+
+static inline void rt_memc_w32(u32 val, unsigned reg)
+{
+	__raw_writel(val, rt_memc_membase + reg);
+}
+
+static inline u32 rt_memc_r32(unsigned reg)
+{
+	return __raw_readl(rt_memc_membase + reg);
+}
+
+#endif /* _RALINK_REGS_H_ */
diff --git a/arch/mips/include/asm/mach-ralink/war.h b/arch/mips/include/asm/mach-ralink/war.h
new file mode 100644
index 0000000..a7b712c
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MACH_RALINK_WAR_H
+#define __ASM_MACH_RALINK_WAR_H
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
+#endif /* __ASM_MACH_RALINK_WAR_H */
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
new file mode 100644
index 0000000..3009903
--- /dev/null
+++ b/arch/mips/ralink/common.h
@@ -0,0 +1,44 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _RALINK_COMMON_H__
+#define _RALINK_COMMON_H__
+
+#define RAMIPS_SYS_TYPE_LEN	32
+
+struct ralink_pinmux_grp {
+	const char *name;
+	u32 mask;
+	int gpio_first;
+	int gpio_last;
+};
+
+struct ralink_pinmux {
+	struct ralink_pinmux_grp *mode;
+	struct ralink_pinmux_grp *uart;
+	int uart_shift;
+	void (*wdt_reset)(void);
+};
+extern struct ralink_pinmux gpio_pinmux;
+
+struct ralink_soc_info {
+	unsigned char sys_type[RAMIPS_SYS_TYPE_LEN];
+	unsigned char *compatible;
+};
+extern struct ralink_soc_info soc_info;
+
+extern void ralink_of_remap(void);
+
+extern void ralink_clk_init(void);
+extern void ralink_clk_add(const char *dev, unsigned long rate);
+
+extern void prom_soc_init(struct ralink_soc_info *soc_info);
+
+__iomem void *plat_of_remap_node(const char *node);
+
+#endif /* _RALINK_COMMON_H__ */
-- 
1.7.10.4
