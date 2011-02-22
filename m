Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2011 22:00:47 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14003 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491774Ab1BVU6Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Feb 2011 21:58:24 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d6423a30000>; Tue, 22 Feb 2011 12:59:15 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 Feb 2011 12:58:23 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 Feb 2011 12:58:22 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1MKwHME020923;
        Tue, 22 Feb 2011 12:58:17 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1MKwHC4020922;
        Tue, 22 Feb 2011 12:58:17 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH 06/10] MIPS: Octeon: Initialize and fixup device tree.
Date:   Tue, 22 Feb 2011 12:57:50 -0800
Message-Id: <1298408274-20856-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
References: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 22 Feb 2011 20:58:22.0941 (UTC) FILETIME=[3DF240D0:01CBD2D3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                         |    2 +
 arch/mips/cavium-octeon/octeon-platform.c |  280 +++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c           |   17 ++
 3 files changed, 299 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4baf7f2..a8fc970 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -699,6 +699,7 @@ config CAVIUM_OCTEON_SIMULATOR
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_CPU_CAVIUM_OCTEON
+	select OF_DYNAMIC
 	help
 	  The Octeon simulator is software performance model of the Cavium
 	  Octeon Processor. It supports simulating Octeon processors on x86
@@ -715,6 +716,7 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
+	select OF_DYNAMIC
 	select SWAP_IO_SPACE
 	select HW_HAS_PCI
 	select ARCH_SUPPORTS_MSI
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index cecaf62..428de0d 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,10 +13,14 @@
 #include <linux/usb.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-rnm-defs.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-board.h>
 
 static struct octeon_cf_data octeon_cf_data;
 
@@ -440,6 +444,282 @@ device_initcall(octeon_ohci_device_init);
 
 #endif /* CONFIG_USB */
 
+static struct of_device_id __initdata octeon_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init set_phy_addr_prop(struct device_node *n, int phy)
+{
+	u32 *vp;
+	struct property *old_p;
+	struct property *p = kzalloc(sizeof(struct device_node) + sizeof(u32), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	/* The value will immediatly follow the node in memory. */
+	vp = (u32 *)(&p[1]);
+	p->name = "reg";
+	p->length = sizeof(u32);
+	p->value = vp;
+
+	*vp = cpu_to_be32((u32)phy);
+
+	old_p = of_find_property(n, "reg", NULL);
+	if (old_p)
+		prom_remove_property(n, old_p);
+	return prom_add_property(n, p);
+}
+
+static int __init set_mac_addr_prop(struct device_node *n, u64 mac)
+{
+	u8 *vp;
+	struct property *old_p;
+	struct property *p = kzalloc(sizeof(struct device_node) + 6, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	/* The value will immediatly follow the node in memory. */
+	vp = (u8 *)(&p[1]);
+	p->name = "local-mac-address";
+	p->length = 6;
+	p->value = vp;
+
+	vp[0] = (mac >> 40) & 0xff;
+	vp[1] = (mac >> 32) & 0xff;
+	vp[2] = (mac >> 24) & 0xff;
+	vp[3] = (mac >> 16) & 0xff;
+	vp[4] = (mac >> 8) & 0xff;
+	vp[5] = mac & 0xff;
+
+	old_p = of_find_property(n, "local-mac-address", NULL);
+	if (old_p)
+		prom_remove_property(n, old_p);
+	return prom_add_property(n, p);
+}
+
+static struct device_node * __init octeon_of_get_child(const struct device_node *parent,
+						       int reg_val)
+{
+	struct device_node *node = NULL;
+	int size;
+	const __be32 *addr;
+
+	for (;;) {
+		node = of_get_next_child(parent, node);
+		if (!node)
+			break;
+		addr = of_get_property(node, "reg", &size);
+		if (addr && (be32_to_cpu(*addr) == reg_val))
+			break;
+	}
+	return node;
+}
+
+int __init octeon_prune_device_tree(void)
+{
+	int i, p, max_port;
+	const char *node_path;
+	char name_buffer[20];
+	struct device_node *aliases;
+	struct device_node *pip;
+	struct device_node *iface;
+	struct device_node *eth;
+	struct device_node *node;
+
+	aliases = of_find_node_by_path("/aliases");
+	if (!aliases) {
+		pr_err("Error: No /aliases node in device tree.");
+		return -EINVAL;
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX) || OCTEON_IS_MODEL(OCTEON_CN63XX))
+		max_port = 2;
+	else if (OCTEON_IS_MODEL(OCTEON_CN56XX))
+		max_port = 1;
+	else
+		max_port = 0;
+
+	for (i = 0; i < 2; i++) {
+		struct device_node *mgmt;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "ethernet-mgmt%d", i);
+		node_path = of_get_property(aliases, name_buffer, NULL);
+		if (node_path) {
+			mgmt = of_find_node_by_path(node_path);
+			if (!mgmt)
+				continue;
+			if (i >= max_port) {
+				pr_notice("Deleting mgmt%d\n", i);
+				node = of_parse_phandle(mgmt, "phy-handle", 0);
+				if (node) {
+					of_detach_node(node);
+					of_node_put(node);
+				}
+				of_node_put(node);
+
+				of_detach_node(mgmt);
+				of_node_put(mgmt);
+			}
+			of_node_put(mgmt);
+		}
+	}
+
+	node_path = of_get_property(aliases, "pip", NULL);
+	if (node_path && (pip = of_find_node_by_path(node_path))) {
+		for (i = 0; i < 4; i++) {
+			cvmx_helper_interface_enumerate(i);
+			iface = octeon_of_get_child(pip, i);
+			if (!iface)
+				continue;
+			for (p = 0; p < 4; p++) {
+				eth = octeon_of_get_child(iface, p);
+				if (!eth)
+					continue;
+				node = of_parse_phandle(eth, "phy-handle", 0);
+				if (p < cvmx_helper_ports_on_interface(i)) {
+					int phy = cvmx_helper_board_get_mii_address(16 * i + p);
+					if (node && phy < 0) {
+						struct property *p = of_find_property(eth, "phy-handle", NULL);
+						of_detach_node(node);
+						of_node_put(node);
+						prom_remove_property(eth, p);
+					}
+				} else {
+					pr_notice("Deleting Ethernet %x:%x\n", i, p);
+					if (node) {
+						of_detach_node(node);
+						of_node_put(node);
+					}
+					of_detach_node(eth);
+					of_node_put(eth);
+				}
+				of_node_put(node);
+				of_node_put(eth);
+			}
+			of_node_put(iface);
+		}
+		of_node_put(pip);
+	}
+
+	/* I2C */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN63XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN56XX))
+		max_port = 2;
+	else
+		max_port = 1;
+
+	for (i = 0; i < 2; i++) {
+		struct device_node *i2c;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "i2c%d", i);
+		node_path = of_get_property(aliases, name_buffer, NULL);
+		if (node_path) {
+			i2c = of_find_node_by_path(node_path);
+			if (!i2c)
+				continue;
+			if (i >= max_port) {
+				pr_notice("Deleting i2c%d\n", i);
+
+				of_detach_node(i2c);
+				of_node_put(i2c);
+			}
+			of_node_put(i2c);
+		}
+	}
+
+	of_node_put(aliases);
+	return 0;
+}
+
+int __init octeon_fix_device_tree(void)
+{
+	int i, p;
+	int rv;
+	const char *node_path;
+	char name_buffer[20];
+	u64 mac_addr_base;
+	struct device_node *aliases;
+	struct device_node *pip;
+	struct device_node *iface;
+	struct device_node *eth;
+	struct device_node *node;
+
+	/*
+	 * Edit the device tree to reflect known board
+	 * configurations.
+	 */
+	mac_addr_base =
+		((octeon_bootinfo->mac_addr_base[0] & 0xffull)) << 40 |
+		((octeon_bootinfo->mac_addr_base[1] & 0xffull)) << 32 |
+		((octeon_bootinfo->mac_addr_base[2] & 0xffull)) << 24 |
+		((octeon_bootinfo->mac_addr_base[3] & 0xffull)) << 16 |
+		((octeon_bootinfo->mac_addr_base[4] & 0xffull)) << 8 |
+		(octeon_bootinfo->mac_addr_base[5] & 0xffull);
+
+	aliases = of_find_node_by_path("/aliases");
+	if (!aliases) {
+		pr_err("Error: No /aliases node in device tree.");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 2; i++) {
+		struct device_node *mgmt;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "ethernet-mgmt%d", i);
+		node_path = of_get_property(aliases, name_buffer, NULL);
+		if (node_path) {
+			mgmt = of_find_node_by_path(node_path);
+			if (!mgmt)
+				continue;
+			/* Set the ethernet address */
+			rv = set_mac_addr_prop(mgmt, mac_addr_base);
+			if (rv)
+				goto err;
+			mac_addr_base++;
+
+			of_node_put(mgmt);
+		}
+	}
+
+	node_path = of_get_property(aliases, "pip", NULL);
+	if (node_path && (pip = of_find_node_by_path(node_path))) {
+		for (i = 0; i < 4; i++) {
+			iface = octeon_of_get_child(pip, i);
+			if (!iface)
+				continue;
+			for (p = 0; p < 4; p++) {
+				int phy = cvmx_helper_board_get_mii_address(16 * i + p);
+				eth = octeon_of_get_child(iface, p);
+				if (!eth)
+					continue;
+				node = of_parse_phandle(eth, "phy-handle", 0);
+				rv = set_mac_addr_prop(eth, mac_addr_base);
+				mac_addr_base++;
+				if (node && phy >= 0)
+					set_phy_addr_prop(node, cvmx_helper_board_get_mii_address(16 * i + p));
+				of_node_put(node);
+				of_node_put(eth);
+			}
+			of_node_put(iface);
+		}
+		of_node_put(pip);
+	}
+
+	of_node_put(aliases);
+	return 0;
+err:
+	return rv;
+}
+arch_initcall(octeon_fix_device_tree);
+
+static int __init octeon_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, octeon_ids, NULL);
+}
+device_initcall(octeon_publish_devices);
+
+
 MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Platform driver for Octeon SOC");
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index ab1a106..818f66d5 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/of_fdt.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/initrd.h>
 #endif
@@ -797,3 +798,19 @@ void prom_free_prom_memory(void)
 	}
 #endif
 }
+
+int octeon_prune_device_tree(void);
+
+extern const char __dtb_octeon_3xxx_begin;
+extern const char __dtb_octeon_3xxx_end;
+void __init device_tree_init(void)
+{
+	int dt_size = &__dtb_octeon_3xxx_end - &__dtb_octeon_3xxx_begin;
+	/* Copy the default tree from init memory. */
+	initial_boot_params = early_init_dt_alloc_memory_arch(dt_size, 8);
+	if (initial_boot_params == NULL)
+		panic("Could not allocate initial_boot_params\n");
+	memcpy(initial_boot_params, &__dtb_octeon_3xxx_begin, dt_size);
+	unflatten_device_tree();
+	octeon_prune_device_tree();
+}
-- 
1.7.2.3
