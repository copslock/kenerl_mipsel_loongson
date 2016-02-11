Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 14:54:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36675 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012521AbcBKNx5yVuQX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 14:53:57 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CDC088E56CA09;
        Thu, 11 Feb 2016 13:53:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 11 Feb 2016 13:53:50 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 11 Feb 2016 13:53:50 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <tj@kernel.org>, <hdegoede@redhat.com>
CC:     <david.daney@cavium.com>, <aleksey.makarov@caviumnetworks.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [Patch v9] SATA: OCTEON: support SATA on OCTEON platform
Date:   Thu, 11 Feb 2016 13:53:08 +0000
Message-ID: <1455198788-24754-1-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>

The OCTEON SATA controller is currently found on cn71XX devices.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
Changes in v9
- Rename from sata_octeon.c to ahci_octeon.c.

Changes in v8
- Rebase to v4.5-rc3
- Use __force behind the scenes via wrappers to avoid sparse warnings
- Add acked by Rob Herring

Changes in v7
- Rebase to v4.5-rc2
- Use #defines instead of __BITFIELD
- Add sign off from Zubair

Changes in v6
- Rebase to v4.5-rc1
- Tested on utm8 by rhino labs. CN7130

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
---
 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 +++++++++
 arch/mips/include/asm/octeon/cvmx.h                |   9 ++
 drivers/ata/Kconfig                                |   9 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_octeon.c                          | 105 +++++++++++++++++++++
 drivers/ata/ahci_platform.c                        |   1 +
 7 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
 create mode 100644 drivers/ata/ahci_octeon.c

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
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 774bb45..19e139c 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -275,6 +275,11 @@ static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
 		cvmx_read64(CVMX_MIO_BOOT_BIST_STAT);
 }
 
+static inline void cvmx_writeq_csr(void __iomem *csr_addr, uint64_t val)
+{
+	cvmx_write_csr((__force uint64_t)csr_addr, val);
+}
+
 static inline void cvmx_write_io(uint64_t io_addr, uint64_t val)
 {
 	cvmx_write64(io_addr, val);
@@ -287,6 +292,10 @@ static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
 	return val;
 }
 
+static inline uint64_t cvmx_readq_csr(void __iomem *csr_addr)
+{
+	return cvmx_read_csr((__force uint64_t) csr_addr);
+}
 
 static inline void cvmx_send_single(uint64_t data)
 {
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 861643ea..9c15828 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -151,6 +151,15 @@ config AHCI_MVEBU
 
 	  If unsure, say N.
 
+config AHCI_OCTEON
+	tristate "Cavium Octeon Soc Serial ATA"
+	depends on SATA_AHCI_PLATFORM && CAVIUM_OCTEON_SOC
+	default y
+	help
+	  This option enables support for Cavium Octeon SoC Serial ATA.
+
+	  If unsure, say N.
+
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
 	depends on ARCH_SUNXI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index af45eff..1857952 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
+obj-$(CONFIG_AHCI_OCTEON)	+= ahci_octeon.o
 obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_ST)		+= ahci_st.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_TEGRA)	+= ahci_tegra.o libahci.o libahci_platform.o
diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
new file mode 100644
index 0000000..ea865fe
--- /dev/null
+++ b/drivers/ata/ahci_octeon.c
@@ -0,0 +1,105 @@
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
+#define CVMX_SATA_UCTL_SHIM_CFG		0xE8
+
+#define SATA_UCTL_ENDIAN_MODE_BIG	1
+#define SATA_UCTL_ENDIAN_MODE_LITTLE	0
+#define SATA_UCTL_ENDIAN_MODE_MASK	3
+
+#define SATA_UCTL_DMA_ENDIAN_MODE_SHIFT	8
+#define SATA_UCTL_CSR_ENDIAN_MODE_SHIFT	0
+#define SATA_UCTL_DMA_READ_CMD_SHIFT	12
+
+static int ahci_octeon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct resource *res;
+	void __iomem *base;
+	u64 cfg;
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
+	cfg = cvmx_readq_csr(base + CVMX_SATA_UCTL_SHIM_CFG);
+
+	cfg &= ~(SATA_UCTL_ENDIAN_MODE_MASK << SATA_UCTL_DMA_ENDIAN_MODE_SHIFT);
+	cfg &= ~(SATA_UCTL_ENDIAN_MODE_MASK << SATA_UCTL_CSR_ENDIAN_MODE_SHIFT);
+
+#ifdef __BIG_ENDIAN
+	cfg |= SATA_UCTL_ENDIAN_MODE_BIG << SATA_UCTL_DMA_ENDIAN_MODE_SHIFT;
+	cfg |= SATA_UCTL_ENDIAN_MODE_BIG << SATA_UCTL_CSR_ENDIAN_MODE_SHIFT;
+#else
+	cfg |= SATA_UCTL_ENDIAN_MODE_LITTLE << SATA_UCTL_DMA_ENDIAN_MODE_SHIFT;
+	cfg |= SATA_UCTL_ENDIAN_MODE_LITTLE << SATA_UCTL_CSR_ENDIAN_MODE_SHIFT;
+#endif
+
+	cfg |= 1 << SATA_UCTL_DMA_READ_CMD_SHIFT;
+
+	cvmx_writeq_csr(base + CVMX_SATA_UCTL_SHIM_CFG, cfg);
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
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 04975b8..4044233 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -76,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
+	{ .compatible = "cavium,octeon-7130-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.9.1
