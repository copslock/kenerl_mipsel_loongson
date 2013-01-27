Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 19:08:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41593 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833520Ab3A0SGuQJYPB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Jan 2013 19:06:50 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 06/10] MIPS: ralink: adds OF code
Date:   Sun, 27 Jan 2013 19:03:58 +0100
Message-Id: <1359309842-31925-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35574
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

Until there is a generic MIPS way of handing the DTB over from bootloader to
kernel we rely on a built in devicetrees. The OF code also remaps those register
ranges that we use global in our drivers.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/of.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 arch/mips/ralink/of.c

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
new file mode 100644
index 0000000..4165e70
--- /dev/null
+++ b/arch/mips/ralink/of.c
@@ -0,0 +1,107 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/of_fdt.h>
+#include <linux/kernel.h>
+#include <linux/bootmem.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+#include <asm/reboot.h>
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+
+#include "common.h"
+
+__iomem void *rt_sysc_membase;
+__iomem void *rt_memc_membase;
+
+extern struct boot_param_header __dtb_start;
+
+__iomem void *plat_of_remap_node(const char *node)
+{
+	struct resource res;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, node);
+	if (!np)
+		panic("Failed to find %s node", node);
+
+	if (of_address_to_resource(np, 0, &res))
+		panic("Failed to get resource for %s", node);
+
+	if ((request_mem_region(res.start,
+				resource_size(&res),
+				res.name) < 0))
+		panic("Failed to request resources for %s", node);
+
+	return ioremap_nocache(res.start, resource_size(&res));
+}
+
+void __init device_tree_init(void)
+{
+	unsigned long base, size;
+	void *fdt_copy;
+
+	if (!initial_boot_params)
+		return;
+
+	base = virt_to_phys((void *)initial_boot_params);
+	size = be32_to_cpu(initial_boot_params->totalsize);
+
+	/* Before we do anything, lets reserve the dt blob */
+	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
+
+	/* The strings in the flattened tree are referenced directly by the
+	 * device tree, so copy the flattened device tree from init memory
+	 * to regular memory.
+	 */
+	fdt_copy = alloc_bootmem(size);
+	memcpy(fdt_copy, initial_boot_params, size);
+	initial_boot_params = fdt_copy;
+
+	unflatten_device_tree();
+
+	/* free the space reserved for the dt blob */
+	free_bootmem(base, size);
+}
+
+void __init plat_mem_setup(void)
+{
+	set_io_port_base(KSEG1);
+
+	/*
+	 * Load the builtin devicetree. This causes the chosen node to be
+	 * parsed resulting in our memory appearing
+	 */
+	__dt_setup_arch(&__dtb_start);
+}
+
+static int __init plat_of_setup(void)
+{
+	static struct of_device_id of_ids[3];
+	int len = sizeof(of_ids[0].compatible);
+
+	if (!of_have_populated_dt())
+		panic("device tree not present");
+
+	strncpy(of_ids[0].compatible, soc_info.compatible, len);
+	strncpy(of_ids[1].compatible, "palmbus", len);
+
+	if (of_platform_populate(NULL, of_ids, NULL, NULL))
+		panic("failed to populate DT\n");
+
+	return 0;
+}
+
+arch_initcall(plat_of_setup);
-- 
1.7.10.4
