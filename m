Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 20:46:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11828 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491991Ab1CDTmy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 20:42:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d7140f30000>; Fri, 04 Mar 2011 11:43:47 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Mar 2011 11:42:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Mar 2011 11:42:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p24Jgl4f017366;
        Fri, 4 Mar 2011 11:42:47 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p24Jgl7T017365;
        Fri, 4 Mar 2011 11:42:47 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v2 08/12] MIPS: Octeon: Initialize and fixup device tree.
Date:   Fri,  4 Mar 2011 11:42:20 -0800
Message-Id: <1299267744-17278-9-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 04 Mar 2011 19:42:52.0810 (UTC) FILETIME=[59E89EA0:01CBDAA4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                         |    1 +
 arch/mips/cavium-octeon/octeon-platform.c |  234 +++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c           |   17 ++
 3 files changed, 252 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4baf7f2..021be61 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1355,6 +1355,7 @@ config CPU_CAVIUM_OCTEON
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
 	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select LIBFDT
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index cecaf62..87512c5 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,10 +13,16 @@
 #include <linux/usb.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-rnm-defs.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-board.h>
 
 static struct octeon_cf_data octeon_cf_data;
 
@@ -440,6 +446,234 @@ device_initcall(octeon_ohci_device_init);
 
 #endif /* CONFIG_USB */
 
+static struct of_device_id __initdata octeon_ids[] = {
+	{ .name = "soc@0", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static void __init octeon_fdt_set_phy(int eth, int phy_addr)
+{
+	const __be32 *phy_handle;
+	const __be32 *reg;
+	struct fdt_node_header *raw_node;
+	u32 phandle;
+	int phy;
+	char new_address[3];
+	char *cp;
+
+	phy_handle = fdt_getprop(initial_boot_params, eth, "phy-handle", NULL);
+	if (!phy_handle)
+		return;
+
+	phandle = be32_to_cpup(phy_handle);
+	phy = fdt_node_offset_by_phandle(initial_boot_params, phandle);
+	if (phy_addr < 0 || phy < 0) {
+		/* Delete the PHY things */
+		if (phy >= 0)
+			fdt_nop_node(initial_boot_params, phy);
+		fdt_nop_property(initial_boot_params, eth, "phy-handle");
+		return;
+	}
+
+	reg = fdt_getprop(initial_boot_params, phy, "reg", NULL);
+	if (phy_addr == be32_to_cpup(reg))
+		return;
+
+	fdt_setprop_inplace_cell(initial_boot_params, phy, "reg", phy_addr);
+
+	snprintf(new_address, sizeof(new_address), "%x", phy_addr);
+	/*
+	 * All PHYs in the template have a name like 'ethernet-phy@0',
+	 * that is 14 characters, which allows us to replace the
+	 * address portion with up to two characters without
+	 * clobbering things past a multiple of 4 boundry.
+	 */
+	raw_node = (void *)fdt_offset_ptr(initial_boot_params, phy, 0);
+	cp = strchr(raw_node->name, '@');
+	if (!cp)
+		return;
+	cp++;
+	cp[0] = new_address[0];
+	cp[1] = new_address[1];
+
+}
+
+static void __init octeon_fdt_set_mac_addr(int n, u64 *pmac)
+{
+	u8 new_mac[6];
+	u64 mac = *pmac;
+	int r;
+
+	new_mac[0] = (mac >> 40) & 0xff;
+	new_mac[1] = (mac >> 32) & 0xff;
+	new_mac[2] = (mac >> 24) & 0xff;
+	new_mac[3] = (mac >> 16) & 0xff;
+	new_mac[4] = (mac >> 8) & 0xff;
+	new_mac[5] = mac & 0xff;
+
+	r = fdt_setprop_inplace(initial_boot_params, n, "local-mac-address",
+				new_mac, sizeof(new_mac));
+
+	if (r) {
+		pr_err("Setting \"local-mac-address\" failed %d", r);
+		return;
+	}
+	*pmac = mac + 1;
+}
+
+static void __init octeon_fdt_rm_ethernet(int node)
+{
+	const __be32 *phy_handle;
+
+	phy_handle = fdt_getprop(initial_boot_params, node, "phy-handle", NULL);
+	if (phy_handle) {
+		u32 ph = be32_to_cpup(phy_handle);
+		int p = fdt_node_offset_by_phandle(initial_boot_params, ph);
+		if (p >= 0)
+			fdt_nop_node(initial_boot_params, p);
+	}
+	fdt_nop_node(initial_boot_params, node);
+}
+
+static void __init octeon_fdt_pip_port(int iface, int i, int p, u64 *pmac)
+{
+	char name_buffer[20];
+	int eth;
+	int phy_addr;
+
+	snprintf(name_buffer, sizeof(name_buffer), "ethernet@%d", p);
+	eth = fdt_subnode_offset(initial_boot_params, iface, name_buffer);
+	if (eth < 0)
+		return;
+	if (p >= cvmx_helper_ports_on_interface(i)) {
+		pr_notice("Deleting port %x:%x\n", i, p);
+		octeon_fdt_rm_ethernet(eth);
+		return;
+	}
+
+	phy_addr = cvmx_helper_board_get_mii_address(16 * i + p);
+	octeon_fdt_set_phy(eth, phy_addr);
+	octeon_fdt_set_mac_addr(eth, pmac);
+}
+
+static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
+{
+	char name_buffer[20];
+	int iface;
+	int p;
+
+	cvmx_helper_interface_enumerate(idx);
+	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
+	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
+	if (iface < 0)
+		return;
+
+	for (p = 0; p < 4; p++)
+		octeon_fdt_pip_port(iface, idx, p, pmac);
+}
+
+int __init octeon_prune_device_tree(void)
+{
+	int i, max_port;
+	const char *pip_path;
+	char name_buffer[20];
+	int aliases;
+	u64 mac_addr_base;
+
+	if (fdt_check_header(initial_boot_params))
+		panic("Corrupt Device Tree.");
+
+	aliases = fdt_path_offset(initial_boot_params, "/aliases");
+	if (aliases < 0) {
+		pr_err("Error: No /aliases node in device tree.");
+		return -EINVAL;
+	}
+
+
+	mac_addr_base =
+		((octeon_bootinfo->mac_addr_base[0] & 0xffull)) << 40 |
+		((octeon_bootinfo->mac_addr_base[1] & 0xffull)) << 32 |
+		((octeon_bootinfo->mac_addr_base[2] & 0xffull)) << 24 |
+		((octeon_bootinfo->mac_addr_base[3] & 0xffull)) << 16 |
+		((octeon_bootinfo->mac_addr_base[4] & 0xffull)) << 8 |
+		(octeon_bootinfo->mac_addr_base[5] & 0xffull);
+
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX) || OCTEON_IS_MODEL(OCTEON_CN63XX))
+		max_port = 2;
+	else if (OCTEON_IS_MODEL(OCTEON_CN56XX))
+		max_port = 1;
+	else
+		max_port = 0;
+
+	for (i = 0; i < 2; i++) {
+		const char *alias_prop;
+		int mgmt;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "mix%d", i);
+		alias_prop = fdt_getprop(initial_boot_params, aliases,
+					name_buffer, NULL);
+		if (alias_prop) {
+			mgmt = fdt_path_offset(initial_boot_params, alias_prop);
+			if (mgmt < 0)
+				continue;
+			if (i >= max_port) {
+				pr_notice("Deleting mix%d\n", i);
+				octeon_fdt_rm_ethernet(mgmt);
+				fdt_nop_property(initial_boot_params, aliases,
+						 name_buffer);
+			} else {
+				octeon_fdt_set_phy(mgmt, i);
+				octeon_fdt_set_mac_addr(mgmt, &mac_addr_base);
+			}
+		}
+	}
+
+	pip_path = fdt_getprop(initial_boot_params, aliases, "pip", NULL);
+	if (pip_path) {
+		int pip = fdt_path_offset(initial_boot_params, pip_path);
+		if (pip  >= 0)
+			for (i = 0; i < 4; i++)
+				octeon_fdt_pip_iface(pip, i, &mac_addr_base);
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
+		const char *alias_prop;
+		int i2c;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "twsi%d", i);
+		alias_prop = fdt_getprop(initial_boot_params, aliases,
+					name_buffer, NULL);
+
+		if (alias_prop) {
+			i2c = fdt_path_offset(initial_boot_params, alias_prop);
+			if (i2c < 0)
+				continue;
+			if (i >= max_port) {
+				pr_notice("Deleting i2c%d\n", i);
+				fdt_nop_node(initial_boot_params, i2c);
+			}
+		}
+	}
+
+	return 0;
+}
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
index ab1a106..02765d6 100644
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
+	octeon_prune_device_tree();
+	unflatten_device_tree();
+}
-- 
1.7.2.3
