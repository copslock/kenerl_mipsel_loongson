Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 14:20:56 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43174 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835030Ab3DJMUFscsUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 14:20:05 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 18/18] MIPS: ralink: add support for runtime memory detection
Date:   Wed, 10 Apr 2013 13:47:27 +0200
Message-Id: <1365594447-13068-19-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36054
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

This allows us to add a device_node called "memorydetect" to the DT with
information about the memory windoe of the SoC. Based on this the memory is
detected ar runtime.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Makefile |    2 +-
 arch/mips/ralink/common.h |    3 ++
 arch/mips/ralink/memory.c |  119 +++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ralink/of.c     |    3 ++
 4 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/ralink/memory.c

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index cae7d88..69101a1 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -6,7 +6,7 @@
 # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
 # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
 
-obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o timer.o
+obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o timer.o memory.o
 
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 193c76c..48d3405 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -45,6 +45,9 @@ extern void prom_soc_init(struct ralink_soc_info *soc_info);
 
 __iomem void *plat_of_remap_node(const char *node);
 
+int __init early_init_dt_detect_memory(unsigned long node, const char *uname,
+					int depth, void *data);
+
 void ralink_pinmux(void);
 
 #endif /* _RALINK_COMMON_H__ */
diff --git a/arch/mips/ralink/memory.c b/arch/mips/ralink/memory.c
new file mode 100644
index 0000000..57f3b83
--- /dev/null
+++ b/arch/mips/ralink/memory.c
@@ -0,0 +1,119 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/string.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+
+#include "common.h"
+
+#define MB	(1024 * 1024)
+
+unsigned long ramips_mem_base;
+unsigned long ramips_mem_size_min;
+unsigned long ramips_mem_size_max;
+
+#ifdef CONFIG_SOC_RT305X
+
+#include <asm/mach-ralink/rt305x.h>
+
+static unsigned long rt5350_get_mem_size(void)
+{
+	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
+	unsigned long ret;
+	u32 t;
+
+	t = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG);
+	t = (t >> RT5350_SYSCFG0_DRAM_SIZE_SHIFT) &
+	RT5350_SYSCFG0_DRAM_SIZE_MASK;
+
+	switch (t) {
+	case RT5350_SYSCFG0_DRAM_SIZE_2M:
+		ret = 2 * 1024 * 1024;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_8M:
+		ret = 8 * 1024 * 1024;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_16M:
+		ret = 16 * 1024 * 1024;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_32M:
+		ret = 32 * 1024 * 1024;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_64M:
+		ret = 64 * 1024 * 1024;
+		break;
+	default:
+		panic("rt5350: invalid DRAM size: %u", t);
+		break;
+	}
+
+	return ret;
+}
+
+#endif
+
+static void __init detect_mem_size(void)
+{
+	unsigned long size;
+
+#ifdef CONFIG_SOC_RT305X
+	if (soc_is_rt5350()) {
+		size = rt5350_get_mem_size();
+	} else
+#endif
+	{
+		void *base;
+
+		base = (void *) KSEG1ADDR(detect_mem_size);
+		for (size = ramips_mem_size_min;
+				size < ramips_mem_size_max; size <<= 1) {
+			if (!memcmp(base, base + size, 1024))
+				break;
+		}
+	}
+
+	pr_info("memory detected: %uMB\n", (unsigned int) size / MB);
+
+	add_memory_region(ramips_mem_base, size, BOOT_MEM_RAM);
+}
+
+int __init early_init_dt_detect_memory(unsigned long node, const char *uname,
+				     int depth, void *data)
+{
+	unsigned long l;
+	__be32 *mem;
+
+	/* We are scanning "memorydetect" nodes only */
+	if (depth != 1 || strcmp(uname, "memorydetect") != 0)
+		return 0;
+
+	mem = of_get_flat_dt_prop(node, "ralink,memory", &l);
+	if (mem == NULL)
+		return 0;
+
+	if ((l / sizeof(__be32)) != 3)
+		panic("invalid memorydetect node\n");
+
+	ramips_mem_base = dt_mem_next_cell(dt_root_addr_cells, &mem);
+	ramips_mem_size_min = dt_mem_next_cell(dt_root_size_cells, &mem);
+	ramips_mem_size_max = dt_mem_next_cell(dt_root_size_cells, &mem);
+
+	pr_info("memory window: 0x%llx, min: %uMB, max: %uMB\n",
+		(unsigned long long) ramips_mem_base,
+		(unsigned int) ramips_mem_size_min / MB,
+		(unsigned int) ramips_mem_size_max / MB);
+
+	detect_mem_size();
+
+	return 0;
+}
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index ecf1482..90d66ac 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -85,6 +85,9 @@ void __init plat_mem_setup(void)
 	 * parsed resulting in our memory appearing
 	 */
 	__dt_setup_arch(&__dtb_start);
+
+	/* try to load the mips machine name */
+	of_scan_flat_dt(early_init_dt_detect_memory, NULL);
 }
 
 static int __init plat_of_setup(void)
-- 
1.7.10.4
