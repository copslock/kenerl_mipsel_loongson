Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 17:26:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55815 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012546AbcBKQ03eNe8r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 17:26:29 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 069F0653F119C;
        Thu, 11 Feb 2016 16:26:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 11 Feb 2016 16:26:23 +0000
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 11 Feb 2016 16:26:22 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <david.daney@cavium.com>, <aleksey.makarov@caviumnetworks.com>,
        <ulf.hansson@linaro.org>, <robh@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v6 2/3] MIPS: OCTEON: Rename legacy properties in internal device trees.
Date:   Thu, 11 Feb 2016 16:26:15 +0000
Message-ID: <1455207976-2262-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com>
References: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Many OCTEON devices have been shipped in products with fixed DTBs. These
DTBS contain properties which are not compatible with newer kernels with
upstream drivers.
Therefore some mechanism is necessary to convert legacy naming into
upstream naming. In the first instance this is to support the OCTEON MMC
controller, which is in a later patch of this series.
This patch adds a octeon_handle_legacy_device_tree() function which is
always called from device_tree_init() to fix up the device tree so that
drivers need have no knowledge of the legacy naming or properties.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
For reference, the legacy MMC bindings are as follows. Only the
spi-max-frequency and bus-width properties currently need renaming.

mmc: mmc@1180000002000 {
	compatible = "cavium,octeon-6130-mmc";
	reg = <0x11800 0x00002000 0x0 0x100>,
		<0x11800 0x00000168 0x0 0x20>;
	#address-cells = <1>;
	#size-cells = <0>;
	/* EMM irq, DMA irq */
	interrupts = <1 19>, <0 63>;

	/* The board only has a single MMC slot */
	mmc-slot@2 {
		compatible = "cavium,octeon-6130-mmc-slot";
		reg = <2>;
		voltage-ranges = <3300 3300>;
		spi-max-frequency = <26000000>;
		/* Power on GPIO 8, active high */
		/* power-gpios = <&gpio 8 0>; */
		power-gpios = <&gpio 8 1>;

	/*      spi-max-frequency = <52000000>; */
		/* bus width can be 1, 4 or 8 */
		cavium,bus-max-width = <8>;
	};
	mmc-slot@0 {
		compatible = "cavium,octeon-6130-mmc-slot";
		reg = <0>;
		voltage-ranges = <3300 3300>;
		spi-max-frequency = <26000000>;
		/* non-removable; */
		bus-width = <8>;
		/* bus width can be 1, 4 or 8 */
		cavium,bus-max-width = <8>;
	};
};
---
 arch/mips/cavium-octeon/octeon-platform.c | 57 +++++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c           |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index d113c8ded6e2..7933978bdfa5 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -980,6 +980,63 @@ end_led:
 	return 0;
 }
 
+/*
+ * Rename a DT property from legacy to upstream accepted name.
+ * The value is copied from old legacy name to new name.
+ */
+static void __init octeon_fdt_renameprop(int node, const char *old, const char *new)
+{
+	const u32 *pv;
+	u32 v;
+
+	pv = fdt_getprop(initial_boot_params, node, old, NULL);
+	if (pv) {
+		v = *pv;
+		fdt_delprop(initial_boot_params, node, old);
+		fdt_setprop_u32(initial_boot_params, node, new, v);
+	}
+}
+
+/*
+ * This function is called for every machine type to replace legacy entries
+ * in the device tree blob passed from older firmwares.
+ * It is impractical to change the DTB in shipped devices, but to support newer
+ * kernels with upstreamed drivers and DT bindings some massaging of the DTB
+ * must be done.
+ */
+int __init octeon_handle_legacy_device_tree(void)
+{
+	const char *alias_prop;
+	int aliases;
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
+	/* MMC */
+	alias_prop = fdt_getprop(initial_boot_params, aliases,
+				 "emmc", NULL);
+	if (alias_prop) {
+		int mmc = fdt_path_offset(initial_boot_params, alias_prop);
+		int slot = fdt_first_subnode(initial_boot_params, mmc);
+
+		while (slot > 0) {
+			octeon_fdt_renameprop(slot, "cavium,bus-max-width",
+					      "bus-width");
+			octeon_fdt_renameprop(slot, "spi-max-frequency",
+					      "max-frequency");
+			slot = fdt_next_subnode(initial_boot_params, slot);
+		}
+	}
+	return 0;
+}
+
+
 static int __init octeon_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, octeon_ids, NULL);
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cd7101fb6227..f1f5191d02be 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1080,6 +1080,7 @@ void __init prom_free_prom_memory(void)
 }
 
 int octeon_prune_device_tree(void);
+int octeon_handle_legacy_device_tree(void);
 
 extern const char __appended_dtb;
 extern const char __dtb_octeon_3xxx_begin;
@@ -1112,6 +1113,8 @@ void __init device_tree_init(void)
 
 	initial_boot_params = (void *)fdt;
 
+	octeon_handle_legacy_device_tree();
+
 	if (do_prune) {
 		octeon_prune_device_tree();
 		pr_info("Using internal Device Tree.\n");
-- 
2.5.0
