Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 16:58:38 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:6770 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008821AbbCTP6gMn1Sy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 16:58:36 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 20 Mar
 2015 18:58:29 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-ide@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5] SATA: OCTEON: support SATA on OCTEON platform
Date:   Fri, 20 Mar 2015 18:54:59 +0300
Message-ID: <1426866901-7343-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

The OCTEON SATA controller is currently found on cn71XX devices.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 ++++++
 drivers/ata/Kconfig                                |   9 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_platform.c                        |   1 +
 drivers/ata/sata_octeon.c                          | 155 +++++++++++++++++++++
 6 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
 create mode 100644 drivers/ata/sata_octeon.c

Version 4:
https://lkml.kernel.org/g/<1425993989-22770-1-git-send-email-aleksey.makarov@auriga.com>

Changes in v5:
- Sparse warnings are fixed
- Device tree docs are improved

Changes in v4:
- The call to dma_coerce_mask_and_coherent() was removed as suggested
  by Arnd Bergmann dma_mask and coherent_dma_mask are actually set
  in the ahci_platform_init_host() (libahci_platform.c)

Changes in v3:
- Rebased to v4.0-rc2
- Cosmetic changes

Changes in v2:
- The driver was rewritten as a driver for the UCTL SATA controller glue.
  It allowed to get rid of the most changes in ahci_platform.c
- Documentation for the device tree bindings was fixed.

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c2340ee..3d84dca 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
   - "hisilicon,hisi-ahci"
+  - "cavium,octeon-7130-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
   - "snps,dwc-ahci"
diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
new file mode 100644
index 0000000..3bd3c2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
@@ -0,0 +1,42 @@
+* UCTL SATA controller glue
+
+UCTL is the bridge unit between the I/O interconnect (an internal bus)
+and the SATA AHCI host controller (UAHC). It performs the following functions:
+	- provides interfaces for the applications to access the UAHC AHCI
+	  registers on the CN71XX I/O space.
+	- provides a bridge for UAHC to fetch AHCI command table entries and data
+	  buffers from Level 2 Cache.
+	- posts interrupts to the CIU.
+	- contains registers that:
+		- control the behavior of the UAHC
+		- control the clock/reset generation to UAHC
+		- control endian swapping for all UAHC registers and DMA accesses
+
+Properties:
+
+- compatible: "cavium,octeon-7130-sata-uctl"
+
+  Compatibility with the cn7130 SOC.
+
+- reg: The base address of the UCTL register bank.
+
+- #address-cells, #size-cells, ranges and dma-ranges must be present and hold
+	suitable values to map all child nodes.
+
+Example:
+
+	uctl@118006c000000 {
+		compatible = "cavium,octeon-7130-sata-uctl";
+		reg = <0x11800 0x6c000000 0x0 0x100>;
+		ranges; /* Direct mapping */
+		dma-ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		sata: sata@16c0000000000 {
+			compatible = "cavium,octeon-7130-ahci";
+			reg = <0x16c00 0x00000000 0x0 0x200>;
+			interrupt-parent = <&cibsata>;
+			interrupts = <2 4>; /* Bit: 2, level */
+		};
+	};
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5f60155..55ad870 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -188,6 +188,15 @@ config SATA_SIL24
 
 	  If unsure, say N.
 
+config SATA_OCTEON
+	tristate "Cavium Octeon Soc Serial ATA"
+	depends on SATA_AHCI_PLATFORM && CAVIUM_OCTEON_SOC
+	default y
+	help
+	  This option enables support for Cavium Octeon SoC Serial ATA.
+
+	  If unsure, say N.
+
 config ATA_SFF
 	bool "ATA SFF support (for legacy IDE and PATA)"
 	default y
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index ae41107..4a0e5e3 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_ST)		+= ahci_st.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_TEGRA)	+= ahci_tegra.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_XGENE)	+= ahci_xgene.o libahci.o libahci_platform.o
+obj-$(CONFIG_SATA_OCTEON)	+= sata_octeon.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 78d6ae0..2c26cde 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -74,6 +74,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
+	{ .compatible = "cavium,octeon-7130-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
diff --git a/drivers/ata/sata_octeon.c b/drivers/ata/sata_octeon.c
new file mode 100644
index 0000000..50d8452
--- /dev/null
+++ b/drivers/ata/sata_octeon.c
@@ -0,0 +1,155 @@
+/*
+ * SATA glue for Cavium Octeon III SOCs.
+ *
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2015 Cavium Networks
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/bitfield.h>
+
+/**
+ * cvmx_sata_uctl_shim_cfg
+ * from cvmx-sata-defs.h
+ *
+ * Accessible by: only when A_CLKDIV_EN
+ * Reset by: IOI reset (srst_n) or SATA_UCTL_CTL[SATA_UCTL_RST]
+ * This register allows configuration of various shim (UCTL) features.
+ * Fields XS_NCB_OOB_* are captured when there are no outstanding OOB errors
+ * indicated in INTSTAT and a new OOB error arrives.
+ * Fields XS_BAD_DMA_* are captured when there are no outstanding DMA errors
+ * indicated in INTSTAT and a new DMA error arrives.
+ */
+union cvmx_sata_uctl_shim_cfg {
+	uint64_t u64;
+	struct cvmx_sata_uctl_shim_cfg_s {
+	/*
+	 * Read/write error log for out-of-bound UAHC register access.
+	 * 0 = read, 1 = write.
+	 */
+	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn               : 1,
+	__BITFIELD_FIELD(uint64_t reserved_57_62               : 6,
+	/*
+	 * SRCID error log for out-of-bound UAHC register access.
+	 * The IOI outbound SRCID for the OOB error.
+	 */
+	__BITFIELD_FIELD(uint64_t xs_ncb_oob_osrc              : 9,
+	/*
+	 * Read/write error log for bad DMA access from UAHC.
+	 * 0 = read error log, 1 = write error log.
+	 */
+	__BITFIELD_FIELD(uint64_t xm_bad_dma_wrn               : 1,
+	__BITFIELD_FIELD(uint64_t reserved_44_46               : 3,
+	/*
+	 * ErrType error log for bad DMA access from UAHC. Encodes the type of
+	 * error encountered (error largest encoded value has priority).
+	 * See SATA_UCTL_XM_BAD_DMA_TYPE_E.
+	 */
+	__BITFIELD_FIELD(uint64_t xm_bad_dma_type              : 4,
+	__BITFIELD_FIELD(uint64_t reserved_13_39               : 27,
+	/*
+	 * Selects the IOI read command used by DMA accesses.
+	 * See SATA_UCTL_DMA_READ_CMD_E.
+	 */
+	__BITFIELD_FIELD(uint64_t dma_read_cmd                 : 1,
+	__BITFIELD_FIELD(uint64_t reserved_10_11               : 2,
+	/*
+	 * Selects the endian format for DMA accesses to the L2C.
+	 * See SATA_UCTL_ENDIAN_MODE_E.
+	 */
+	__BITFIELD_FIELD(uint64_t dma_endian_mode              : 2,
+	__BITFIELD_FIELD(uint64_t reserved_2_7                 : 6,
+	/*
+	 * Selects the endian format for IOI CSR accesses to the UAHC.
+	 * Note that when UAHC CSRs are accessed via RSL, they are returned
+	 * as big-endian. See SATA_UCTL_ENDIAN_MODE_E.
+	 */
+	__BITFIELD_FIELD(uint64_t csr_endian_mode              : 2,
+		;))))))))))))
+	} s;
+};
+
+#define CVMX_SATA_UCTL_SHIM_CFG 0xE8
+
+static int ahci_octeon_probe(struct platform_device *pdev)
+{
+	union cvmx_sata_uctl_shim_cfg shim_cfg;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
+		return -ENODEV;
+	}
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* set-up endian mode */
+	shim_cfg.u64 = cvmx_read_csr(
+		(__force uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
+#ifdef __BIG_ENDIAN
+	shim_cfg.s.dma_endian_mode = 1;
+	shim_cfg.s.csr_endian_mode = 1;
+#else
+	shim_cfg.s.dma_endian_mode = 0;
+	shim_cfg.s.csr_endian_mode = 0;
+#endif
+	shim_cfg.s.dma_read_cmd = 1; /* No allocate L2C */
+	cvmx_write_csr(
+		(__force uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, shim_cfg.u64);
+
+	if (!node) {
+		dev_err(dev, "no device node, failed to add octeon sata\n");
+		return -ENODEV;
+	}
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to add ahci-platform core\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ahci_octeon_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id octeon_ahci_match[] = {
+	{ .compatible = "cavium,octeon-7130-sata-uctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_ahci_match);
+
+static struct platform_driver ahci_octeon_driver = {
+	.probe          = ahci_octeon_probe,
+	.remove         = ahci_octeon_remove,
+	.driver         = {
+		.name   = "octeon-ahci",
+		.of_match_table = octeon_ahci_match,
+	},
+};
+
+module_platform_driver(ahci_octeon_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium Inc. sata config.");
-- 
2.3.3
