Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 21:22:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11443 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491876Ab1FFTUN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 21:20:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ded28ac0000>; Mon, 06 Jun 2011 12:21:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:20:11 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:20:11 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p56JK80m027135;
        Mon, 6 Jun 2011 12:20:08 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p56JK7Vh027134;
        Mon, 6 Jun 2011 12:20:07 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v5 6/6] MIPS: Octeon: Initialize and fixup device tree.
Date:   Mon,  6 Jun 2011 12:19:46 -0700
Message-Id: <1307387986-27069-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
References: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 06 Jun 2011 19:20:11.0189 (UTC) FILETIME=[C1263E50:01CC247E]
X-archive-position: 30264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4754

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                         |    1 +
 arch/mips/cavium-octeon/Makefile          |    3 +
 arch/mips/cavium-octeon/octeon-platform.c |  319 +++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c           |   39 ++++
 4 files changed, 362 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d2849b4..97f044a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1402,6 +1402,7 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select LIBFDT
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index b8d4f63..a11b35a 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -9,6 +9,9 @@
 # Copyright (C) 2005-2009 Cavium Networks
 #
 
+CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
+CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
+
 obj-y := cpu.o setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o flash_setup.o
 obj-y += octeon-memcpy.o
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index cd61d72..17329e5 100644
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
 
@@ -440,6 +446,319 @@ device_initcall(octeon_ohci_device_init);
 
 #endif /* CONFIG_USB */
 
+static struct of_device_id __initdata octeon_ids[] = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "cavium,octeon-6335-uctl", },
+	{ .compatible = "cavium,octeon-3860-bootbus", },
+	{},
+};
+
+static bool __init octeon_has_88e1145(void)
+{
+	return !OCTEON_IS_MODEL(OCTEON_CN52XX) &&
+	       !OCTEON_IS_MODEL(OCTEON_CN6XXX) &&
+	       !OCTEON_IS_MODEL(OCTEON_CN56XX);
+}
+
+static void __init octeon_fdt_set_phy(int eth, int phy_addr)
+{
+	const __be32 *phy_handle;
+	const __be32 *reg;
+	u32 phandle;
+	int phy;
+	const char *p;
+	int current_len;
+	char new_name[20];
+
+	phy_handle = fdt_getprop(initial_boot_params, eth, "phy-handle", NULL);
+	if (!phy_handle)
+		return;
+
+	phandle = be32_to_cpup(phy_handle);
+	phy = fdt_node_offset_by_phandle(initial_boot_params, phandle);
+	if (phy_addr < 0 || phy < 0) {
+		/* Delete the PHY things */
+		fdt_nop_property(initial_boot_params, eth, "phy-handle");
+		if (phy >= 0)
+			fdt_nop_node(initial_boot_params, phy);
+		return;
+	}
+
+	if (octeon_has_88e1145()) {
+		fdt_nop_property(initial_boot_params, phy, "marvell,reg-init");
+		memset(new_name, 0, sizeof(new_name));
+		strcpy(new_name, "marvell,88e1145");
+		p = fdt_getprop(initial_boot_params, phy, "compatible",
+				&current_len);
+		if (p && current_len >= strlen(new_name))
+			fdt_setprop_inplace(initial_boot_params, phy,
+					"compatible", new_name, current_len);
+	}
+
+	reg = fdt_getprop(initial_boot_params, phy, "reg", NULL);
+	if (phy_addr == be32_to_cpup(reg))
+		return;
+
+	fdt_setprop_inplace_cell(initial_boot_params, phy, "reg", phy_addr);
+
+	snprintf(new_name, sizeof(new_name), "ethernet-phy@%x", phy_addr);
+
+	p = fdt_get_name(initial_boot_params, phy, &current_len);
+	if (p && current_len == strlen(new_name))
+		fdt_set_name(initial_boot_params, phy, new_name);
+	else
+		pr_err("Error: could not rename ethernet phy: <%s>", p);
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
+	snprintf(name_buffer, sizeof(name_buffer), "ethernet@%x", p);
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
+	for (p = 0; p < 16; p++)
+		octeon_fdt_pip_port(iface, idx, p, pmac);
+}
+
+int __init octeon_prune_device_tree(void)
+{
+	int i, max_port, uart_mask;
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
+				pr_notice("Deleting twsi%d\n", i);
+				fdt_nop_node(initial_boot_params, i2c);
+				fdt_nop_property(initial_boot_params, aliases,
+						 name_buffer);
+			}
+		}
+	}
+
+	/* SMI/MDIO Same number of ports as I2C*/
+
+	for (i = 0; i < 2; i++) {
+		const char *alias_prop;
+		int i2c;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "smi%d", i);
+		alias_prop = fdt_getprop(initial_boot_params, aliases,
+					name_buffer, NULL);
+
+		if (alias_prop) {
+			i2c = fdt_path_offset(initial_boot_params, alias_prop);
+			if (i2c < 0)
+				continue;
+			if (i >= max_port) {
+				pr_notice("Deleting smi%d\n", i);
+				fdt_nop_node(initial_boot_params, i2c);
+				fdt_nop_property(initial_boot_params, aliases,
+						 name_buffer);
+			}
+		}
+	}
+
+	/* Serial */
+	uart_mask = 0;
+
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	/*
+	 * If we are configured to run as the second of two kernels,
+	 * disable uart0 and enable uart1. Uart0 is owned by the first
+	 * kernel
+	 */
+	uart_mask |= 2; /* uart1 */
+#else
+	/*
+	 * We are configured for the first kernel. We'll enable uart0
+	 * if the bootloader told us to use 0, otherwise will enable
+	 * uart 1.
+	 */
+	if (octeon_get_boot_uart() == 0)
+		uart_mask |= 1; /* uart0 */
+	if (octeon_get_boot_uart() == 1)
+		uart_mask |= 2; /* uart1 */
+
+#ifdef CONFIG_KGDB
+	uart_mask |= 2; /* uart1 */
+#endif
+#endif
+
+	/* Right now CN52XX is the only chip with a third uart */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		uart_mask |= 4; /* uart2 */
+
+	for (i = 0; i < 3; i++) {
+		const char *alias_prop;
+		int uart;
+		snprintf(name_buffer, sizeof(name_buffer),
+			 "uart%d", i);
+		alias_prop = fdt_getprop(initial_boot_params, aliases,
+					name_buffer, NULL);
+
+		if (alias_prop) {
+			uart = fdt_path_offset(initial_boot_params, alias_prop);
+			if (uart_mask & (1 << i))
+				continue;
+			pr_notice("Deleting uart%d\n", i);
+			fdt_nop_node(initial_boot_params, uart);
+			fdt_nop_property(initial_boot_params, aliases,
+					 name_buffer);
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
index 36221b3..15f876e 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -20,6 +20,8 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/initrd.h>
 #endif
@@ -797,3 +799,40 @@ void prom_free_prom_memory(void)
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
+	int dt_size;
+	struct boot_param_header *fdt;
+	bool do_prune;
+
+	if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
+		fdt = (struct boot_param_header *)PHYS_TO_XKSEG_CACHED(octeon_bootinfo->fdt_addr);
+		if (fdt_check_header(fdt))
+			panic("Corrupt Device Tree passed to kernel.");
+		dt_size = be32_to_cpu(fdt->totalsize);
+		do_prune = false;
+	} else {
+		fdt = (struct boot_param_header *)&__dtb_octeon_3xxx_begin;
+		dt_size = &__dtb_octeon_3xxx_end - &__dtb_octeon_3xxx_begin;
+		do_prune = true;
+	}
+
+	/* Copy the default tree from init memory. */
+	initial_boot_params = early_init_dt_alloc_memory_arch(dt_size, 8);
+	if (initial_boot_params == NULL)
+		panic("Could not allocate initial_boot_params\n");
+	memcpy(initial_boot_params, fdt, dt_size);
+
+	if (do_prune) {
+		octeon_prune_device_tree();
+		pr_info("Using internal Device Tree.\n");
+	} else {
+		pr_info("Using passed Device Tree.\n");
+	}
+	unflatten_device_tree();
+}
-- 
1.7.2.3
