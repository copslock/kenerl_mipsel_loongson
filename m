Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 13:10:58 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52031 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833397Ab3AWMIo4CqDi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 13:08:44 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RFC 07/11] MIPS: ralink: adds OF code
Date:   Wed, 23 Jan 2013 13:05:51 +0100
Message-Id: <1358942755-25371-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35513
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
 arch/mips/ralink/of.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 arch/mips/ralink/of.c

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
new file mode 100644
index 0000000..02814b3
--- /dev/null
+++ b/arch/mips/ralink/of.c
@@ -0,0 +1,105 @@
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
+void __init ralink_of_remap(void)
+{
+	struct resource res_sysc, res_memc;
+	struct device_node *np_sysc =
+			of_find_compatible_node(NULL, NULL, "ralink,sysc");
+	struct device_node *np_memc =
+			of_find_compatible_node(NULL, NULL, "ralink,memc");
+
+	if (!np_sysc || !np_memc)
+		panic("Failed to load core nodes from devicetree");
+
+	if (of_address_to_resource(np_sysc, 0, &res_sysc) ||
+			of_address_to_resource(np_memc, 0, &res_memc))
+		panic("Failed to get core resources");
+
+	if ((request_mem_region(res_sysc.start, resource_size(&res_sysc),
+				res_sysc.name) < 0) ||
+		(request_mem_region(res_memc.start, resource_size(&res_memc),
+				res_memc.name) < 0))
+		pr_err("Failed to request core resources");
+
+	rt_sysc_membase = ioremap_nocache(res_sysc.start,
+						resource_size(&res_sysc));
+	rt_memc_membase = ioremap_nocache(res_memc.start,
+						resource_size(&res_memc));
+
+	if (!rt_sysc_membase || !rt_memc_membase)
+		panic("Failed to remap core resources");
+}
+
+void __init device_tree_init(void)
+{
+	unsigned long base, size;
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
+	unflatten_device_tree();
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
