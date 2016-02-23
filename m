Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 23:52:13 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33988 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013835AbcBWWwLfzk2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 23:52:11 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id EA648234028;
        Wed, 24 Feb 2016 00:52:10 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 1/3] MIPS: OCTEON: device_tree_init: use separate pass to fill mac addresses
Date:   Wed, 24 Feb 2016 00:52:05 +0200
Message-Id: <1456267927-2492-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Use separate pass to fill MAC addresses. This is needed because we want
to do this also for the appended DTB.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-platform.c | 86 +++++++++++++++++++++++++------
 arch/mips/cavium-octeon/setup.c           |  2 +
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index d113c8d..a7d9f07 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -560,7 +560,7 @@ static void __init octeon_fdt_rm_ethernet(int node)
 	fdt_nop_node(initial_boot_params, node);
 }
 
-static void __init octeon_fdt_pip_port(int iface, int i, int p, int max, u64 *pmac)
+static void __init octeon_fdt_pip_port(int iface, int i, int p, int max)
 {
 	char name_buffer[20];
 	int eth;
@@ -583,10 +583,9 @@ static void __init octeon_fdt_pip_port(int iface, int i, int p, int max, u64 *pm
 
 	phy_addr = cvmx_helper_board_get_mii_address(ipd_port);
 	octeon_fdt_set_phy(eth, phy_addr);
-	octeon_fdt_set_mac_addr(eth, pmac);
 }
 
-static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
+static void __init octeon_fdt_pip_iface(int pip, int idx)
 {
 	char name_buffer[20];
 	int iface;
@@ -602,7 +601,73 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
 		count = cvmx_helper_ports_on_interface(idx);
 
 	for (p = 0; p < 16; p++)
-		octeon_fdt_pip_port(iface, idx, p, count - 1, pmac);
+		octeon_fdt_pip_port(iface, idx, p, count - 1);
+}
+
+void __init octeon_fill_mac_addresses(void)
+{
+	const char *alias_prop;
+	char name_buffer[20];
+	u64 mac_addr_base;
+	int aliases;
+	int pip;
+	int i;
+
+	aliases = fdt_path_offset(initial_boot_params, "/aliases");
+	if (aliases < 0)
+		return;
+
+	mac_addr_base =
+		((octeon_bootinfo->mac_addr_base[0] & 0xffull)) << 40 |
+		((octeon_bootinfo->mac_addr_base[1] & 0xffull)) << 32 |
+		((octeon_bootinfo->mac_addr_base[2] & 0xffull)) << 24 |
+		((octeon_bootinfo->mac_addr_base[3] & 0xffull)) << 16 |
+		((octeon_bootinfo->mac_addr_base[4] & 0xffull)) << 8 |
+		 (octeon_bootinfo->mac_addr_base[5] & 0xffull);
+
+	for (i = 0; i < 2; i++) {
+		int mgmt;
+
+		snprintf(name_buffer, sizeof(name_buffer), "mix%d", i);
+		alias_prop = fdt_getprop(initial_boot_params, aliases,
+					 name_buffer, NULL);
+		if (!alias_prop)
+			continue;
+		mgmt = fdt_path_offset(initial_boot_params, alias_prop);
+		if (mgmt < 0)
+			continue;
+		octeon_fdt_set_mac_addr(mgmt, &mac_addr_base);
+	}
+
+	alias_prop = fdt_getprop(initial_boot_params, aliases, "pip", NULL);
+	if (!alias_prop)
+		return;
+
+	pip = fdt_path_offset(initial_boot_params, alias_prop);
+	if (pip < 0)
+		return;
+
+	for (i = 0; i <= 4; i++) {
+		int iface;
+		int p;
+
+		snprintf(name_buffer, sizeof(name_buffer), "interface@%d", i);
+		iface = fdt_subnode_offset(initial_boot_params, pip,
+					   name_buffer);
+		if (iface < 0)
+			continue;
+		for (p = 0; p < 16; p++) {
+			int eth;
+
+			snprintf(name_buffer, sizeof(name_buffer),
+				 "ethernet@%x", p);
+			eth = fdt_subnode_offset(initial_boot_params, iface,
+						 name_buffer);
+			if (eth < 0)
+				continue;
+			octeon_fdt_set_mac_addr(eth, &mac_addr_base);
+		}
+	}
 }
 
 int __init octeon_prune_device_tree(void)
@@ -612,7 +677,6 @@ int __init octeon_prune_device_tree(void)
 	const char *alias_prop;
 	char name_buffer[20];
 	int aliases;
-	u64 mac_addr_base;
 
 	if (fdt_check_header(initial_boot_params))
 		panic("Corrupt Device Tree.");
@@ -623,15 +687,6 @@ int __init octeon_prune_device_tree(void)
 		return -EINVAL;
 	}
 
-
-	mac_addr_base =
-		((octeon_bootinfo->mac_addr_base[0] & 0xffull)) << 40 |
-		((octeon_bootinfo->mac_addr_base[1] & 0xffull)) << 32 |
-		((octeon_bootinfo->mac_addr_base[2] & 0xffull)) << 24 |
-		((octeon_bootinfo->mac_addr_base[3] & 0xffull)) << 16 |
-		((octeon_bootinfo->mac_addr_base[4] & 0xffull)) << 8 |
-		(octeon_bootinfo->mac_addr_base[5] & 0xffull);
-
 	if (OCTEON_IS_MODEL(OCTEON_CN52XX) || OCTEON_IS_MODEL(OCTEON_CN63XX))
 		max_port = 2;
 	else if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN68XX))
@@ -660,7 +715,6 @@ int __init octeon_prune_device_tree(void)
 			} else {
 				int phy_addr = cvmx_helper_board_get_mii_address(CVMX_HELPER_BOARD_MGMT_IPD_PORT + i);
 				octeon_fdt_set_phy(mgmt, phy_addr);
-				octeon_fdt_set_mac_addr(mgmt, &mac_addr_base);
 			}
 		}
 	}
@@ -670,7 +724,7 @@ int __init octeon_prune_device_tree(void)
 		int pip = fdt_path_offset(initial_boot_params, pip_path);
 		if (pip	 >= 0)
 			for (i = 0; i <= 4; i++)
-				octeon_fdt_pip_iface(pip, i, &mac_addr_base);
+				octeon_fdt_pip_iface(pip, i);
 	}
 
 	/* I2C */
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cd7101f..ed3063f 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1079,6 +1079,7 @@ void __init prom_free_prom_memory(void)
 	}
 }
 
+void __init octeon_fill_mac_addresses(void);
 int octeon_prune_device_tree(void);
 
 extern const char __appended_dtb;
@@ -1114,6 +1115,7 @@ void __init device_tree_init(void)
 
 	if (do_prune) {
 		octeon_prune_device_tree();
+		octeon_fill_mac_addresses();
 		pr_info("Using internal Device Tree.\n");
 	}
 	unflatten_and_copy_device_tree();
-- 
2.4.0
