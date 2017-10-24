Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 20:20:14 +0200 (CEST)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41280 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992079AbdJXSRCZOOvV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 20:17:02 +0200
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 0A70B30C032;
        Tue, 24 Oct 2017 11:16:45 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 66E0681EAD;
        Tue, 24 Oct 2017 11:16:42 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 3/8] PCI: host: brcmstb: Broadcom PCIe Host Controller
Date:   Tue, 24 Oct 2017 14:15:44 -0400
Message-Id: <1508868949-16652-4-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

This commit adds the basic Broadcom STB PCIe controller.  Missing is
the ability to process MSI and also handle dma-ranges for inbound
memory accesses.  These two functionalities are added in subsequent
commits.

The PCIe block contains an MDIO interface.  This is a local interface
only accessible by the PCIe controller.  It cannot be used or shared
by any other HW.  As such, the small amount of code for this
controller is included in this driver as there is little upside to put
it elsewhere.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/host/Kconfig       |    8 +
 drivers/pci/host/Makefile      |    1 +
 drivers/pci/host/pci-brcmstb.c | 1195 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pci-brcmstb.h |   33 ++
 4 files changed, 1237 insertions(+)
 create mode 100644 drivers/pci/host/pci-brcmstb.c
 create mode 100644 drivers/pci/host/pci-brcmstb.h

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index b868803..b9b4f11 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -220,4 +220,12 @@ config VMD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vmd.
 
+config PCI_BRCMSTB
+	tristate "Broadcom Brcmstb PCIe platform host driver"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on OF
+	depends on SOC_BRCMSTB
+	default ARCH_BRCMSTB || BMIPS_GENERIC
+	help
+	  Adds support for Broadcom Settop Box PCIe host controller.
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 1238278..4398d2c 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
+obj-$(CONFIG_PCI_BRCMSTB) += pci-brcmstb.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/host/pci-brcmstb.c b/drivers/pci/host/pci-brcmstb.c
new file mode 100644
index 0000000..883b435
--- /dev/null
+++ b/drivers/pci/host/pci-brcmstb.c
@@ -0,0 +1,1195 @@
+/*
+ * Copyright (C) 2009 - 2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/printk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <soc/brcmstb/memory_api.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include "pci-brcmstb.h"
+
+/* Broadcom Settop Box PCIE Register Offsets.  */
+#define PCIE_RC_CFG_PCIE_LINK_CAPABILITY		0x00b8
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL		0x00bc
+#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL		0x00c8
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_2		0x00dc
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1		0x0188
+#define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
+#define PCIE_RC_DL_MDIO_ADDR				0x1100
+#define PCIE_RC_DL_MDIO_WR_DATA				0x1104
+#define PCIE_RC_DL_MDIO_RD_DATA				0x1108
+#define PCIE_MISC_MISC_CTRL				0x4008
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
+#define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
+#define PCIE_MISC_RC_BAR1_CONFIG_HI			0x4030
+#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
+#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
+#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
+#define PCIE_MISC_RC_BAR3_CONFIG_HI			0x4040
+#define PCIE_MISC_PCIE_CTRL				0x4064
+#define PCIE_MISC_PCIE_STATUS				0x4068
+#define PCIE_MISC_REVISION				0x406c
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT	0x4070
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI		0x4080
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI		0x4084
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
+
+/* Broadcom Settop Box PCIE Register Field Shift, Mask Info.  */
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_NEG_LINK_WIDTH_MASK  0x3f00000
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_NEG_LINK_WIDTH_SHIFT	0x14
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_NEG_LINK_SPEED_MASK	0xf0000
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_NEG_LINK_SPEED_SHIFT	0x10
+#define PCIE_RC_CFG_PCIE_LINK_CAPABILITY_MAX_LINK_SPEED_MASK		0xf
+#define PCIE_RC_CFG_PCIE_LINK_CAPABILITY_MAX_LINK_SPEED_SHIFT		0x0
+#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK		0x10
+#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_SHIFT		0x4
+#define	PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_2_TARGET_LINK_SPEED_MASK	0xf
+#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_2_TARGET_LINK_SPEED_SHIFT	0x0
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR1_MASK	0x3
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR1_SHIFT	0x0
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_SHIFT	0x2
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR3_MASK	0x30
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR3_SHIFT	0x4
+#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK		0xffffff
+#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_SHIFT		0x0
+#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK			0x1000
+#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_SHIFT			0xc
+#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK		0x2000
+#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_SHIFT		0xd
+#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK			0x300000
+#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_SHIFT		0x14
+#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK			0xf8000000
+#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_SHIFT			0x1b
+#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK			0x7c00000
+#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_SHIFT			0x16
+#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK			0x1f
+#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_SHIFT			0x0
+#define PCIE_MISC_RC_BAR1_CONFIG_LO_MATCH_ADDRESS_MASK		0xfffff000
+#define PCIE_MISC_RC_BAR1_CONFIG_LO_MATCH_ADDRESS_SHIFT		0xc
+#define PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK			0x1f
+#define PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_SHIFT			0x0
+#define PCIE_MISC_RC_BAR2_CONFIG_LO_MATCH_ADDRESS_MASK		0xfffff000
+#define PCIE_MISC_RC_BAR2_CONFIG_LO_MATCH_ADDRESS_SHIFT		0xc
+#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK			0x1f
+#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_SHIFT			0x0
+#define PCIE_MISC_RC_BAR3_CONFIG_LO_MATCH_ADDRESS_MASK		0xfffff000
+#define PCIE_MISC_RC_BAR3_CONFIG_LO_MATCH_ADDRESS_SHIFT		0xc
+#define PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK			0x1f
+#define PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_SHIFT			0x0
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK			0x4
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_SHIFT			0x2
+#define PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK		0x1
+#define PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_SHIFT		0x0
+#define PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK			0x80
+#define PCIE_MISC_PCIE_STATUS_PCIE_PORT_SHIFT			0x7
+#define PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK		0x20
+#define PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_SHIFT		0x5
+#define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK		0x10
+#define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_SHIFT		0x4
+#define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK		0x40
+#define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_SHIFT		0x6
+#define PCIE_MISC_REVISION_MAJMIN_MASK				0xffff
+#define PCIE_MISC_REVISION_MAJMIN_SHIFT				0
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_SHIFT	0x14
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK	0xfff0
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_SHIFT	0x4
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS	0xc
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK		0xff
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_SHIFT	0x0
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK	0xff
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_SHIFT	0x0
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_SHIFT 0x1
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_SHIFT	0x1b
+#define PCIE_RGR1_SW_INIT_1_PERST_MASK				0x1
+#define PCIE_RGR1_SW_INIT_1_PERST_SHIFT				0x0
+
+#define BRCM_NUM_PCI_OUT_WINS		0x4
+#define BRCM_MAX_SCB			0x4
+
+#define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
+#define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
+
+#define BURST_SIZE_128			0
+#define BURST_SIZE_256			1
+#define BURST_SIZE_512			2
+
+/* Offsets from PCIE_INTR2_CPU_BASE */
+#define STATUS				0x0
+#define SET				0x4
+#define CLR				0x8
+#define MASK_STATUS			0xc
+#define MASK_SET			0x10
+#define MASK_CLR			0x14
+
+#define PCI_BUSNUM_SHIFT		20
+#define PCI_SLOT_SHIFT			15
+#define PCI_FUNC_SHIFT			12
+
+#if defined(__BIG_ENDIAN)
+#define	DATA_ENDIAN		2	/* PCI->DDR inbound accesses */
+#define MMIO_ENDIAN		2	/* CPU->PCI outbound accesses */
+#else
+#define	DATA_ENDIAN		0
+#define MMIO_ENDIAN		0
+#endif
+
+#define MDIO_PORT0		0x0
+#define MDIO_DATA_MASK		0x7fffffff
+#define MDIO_DATA_SHIFT		0x0
+#define MDIO_PORT_MASK		0xf0000
+#define MDIO_PORT_SHIFT		0x16
+#define MDIO_REGAD_MASK		0xffff
+#define MDIO_REGAD_SHIFT	0x0
+#define MDIO_CMD_MASK		0xfff00000
+#define MDIO_CMD_SHIFT		0x14
+#define MDIO_CMD_READ		0x1
+#define MDIO_CMD_WRITE		0x0
+#define MDIO_DATA_DONE_MASK	0x80000000
+#define MDIO_RD_DONE(x)		(((x) & MDIO_DATA_DONE_MASK) ? 1 : 0)
+#define MDIO_WT_DONE(x)		(((x) & MDIO_DATA_DONE_MASK) ? 0 : 1)
+#define SSC_REGS_ADDR		0x1100
+#define SET_ADDR_OFFSET		0x1f
+#define SSC_CNTL_OFFSET		0x2
+#define SSC_CNTL_OVRD_EN_MASK	0x8000
+#define SSC_CNTL_OVRD_EN_SHIFT	0xf
+#define SSC_CNTL_OVRD_VAL_MASK	0x4000
+#define SSC_CNTL_OVRD_VAL_SHIFT	0xe
+#define SSC_STATUS_OFFSET	0x1
+#define SSC_STATUS_SSC_MASK	0x400
+#define SSC_STATUS_SSC_SHIFT	0xa
+#define SSC_STATUS_PLL_LOCK_MASK	0x800
+#define SSC_STATUS_PLL_LOCK_SHIFT	0xb
+
+#define IDX_ADDR(pcie)	\
+	((pcie)->reg_offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)	\
+	((pcie)->reg_offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie) \
+	((pcie)->reg_offsets[RGR1_SW_INIT_1])
+
+enum {
+	RGR1_SW_INIT_1,
+	EXT_CFG_INDEX,
+	EXT_CFG_DATA,
+};
+
+enum {
+	RGR1_SW_INIT_1_INIT_MASK,
+	RGR1_SW_INIT_1_INIT_SHIFT,
+	RGR1_SW_INIT_1_PERST_MASK,
+	RGR1_SW_INIT_1_PERST_SHIFT,
+};
+
+enum pcie_type {
+	BCM7425,
+	BCM7435,
+	GENERIC,
+	BCM7278,
+};
+
+#define RD_FLD(base, reg, field) \
+	rd_fld(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT)
+#define WR_FLD(base, reg, field, val) \
+	wr_fld(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT, val)
+#define WR_FLD_RB(base, reg, field, val) \
+	wr_fld_rb(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT, val)
+#define WR_FLD_WITH_OFFSET(base, off, reg, field, val) \
+	wr_fld(base + reg + off, reg##_##field##_MASK, \
+	       reg##_##field##_SHIFT, val)
+#define EXTRACT_FIELD(val, reg, field) \
+	((val & reg##_##field##_MASK) >> reg##_##field##_SHIFT)
+#define INSERT_FIELD(val, reg, field, field_val) \
+	((val & ~reg##_##field##_MASK) | \
+	 (reg##_##field##_MASK & (field_val << reg##_##field##_SHIFT)))
+
+struct pcie_cfg_data {
+	const int *reg_field_info;
+	const int *offsets;
+	const enum pcie_type type;
+};
+
+static const int pcie_reg_field_info[] = {
+	[RGR1_SW_INIT_1_INIT_MASK] = 0x2,
+	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
+};
+
+static const int pcie_reg_field_info_bcm7278[] = {
+	[RGR1_SW_INIT_1_INIT_MASK] = 0x1,
+	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x0,
+};
+
+static const int pcie_offset_bcm7425[] = {
+	[RGR1_SW_INIT_1] = 0x8010,
+	[EXT_CFG_INDEX]  = 0x8300,
+	[EXT_CFG_DATA]   = 0x8304,
+};
+
+static const struct pcie_cfg_data bcm7425_cfg = {
+	.reg_field_info	= pcie_reg_field_info,
+	.offsets	= pcie_offset_bcm7425,
+	.type		= BCM7425,
+};
+
+static const int pcie_offsets[] = {
+	[RGR1_SW_INIT_1] = 0x9210,
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x9004,
+};
+
+static const struct pcie_cfg_data bcm7435_cfg = {
+	.reg_field_info	= pcie_reg_field_info,
+	.offsets	= pcie_offsets,
+	.type		= BCM7435,
+};
+
+static const struct pcie_cfg_data generic_cfg = {
+	.reg_field_info	= pcie_reg_field_info,
+	.offsets	= pcie_offsets,
+	.type		= GENERIC,
+};
+
+static const int pcie_offset_bcm7278[] = {
+	[RGR1_SW_INIT_1] = 0xc010,
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x9004,
+};
+
+static const struct pcie_cfg_data bcm7278_cfg = {
+	.reg_field_info = pcie_reg_field_info_bcm7278,
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+};
+
+static void __iomem *brcm_pci_map_cfg(struct pci_bus *bus, unsigned int devfn,
+				      int where);
+
+static struct pci_ops brcm_pci_ops = {
+	.map_bus = brcm_pci_map_cfg,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
+struct brcm_dev_pwr_supply {
+	struct list_head node;
+	char name[32];
+	struct regulator *regulator;
+};
+
+struct brcm_window {
+	dma_addr_t pci_addr;
+	phys_addr_t cpu_addr;
+	dma_addr_t size;
+};
+
+/* Internal Bus Controller Information.*/
+struct brcm_pcie {
+	struct list_head	list;
+	void __iomem		*base;
+	char			name[BRCM_PCIE_NAME_SIZE];
+	bool			suspended;
+	struct clk		*clk;
+	struct device_node	*dn;
+	int			irq;
+	int			num_out_wins;
+	bool			ssc;
+	int			gen;
+	struct brcm_window	out_wins[BRCM_NUM_PCI_OUT_WINS];
+	struct list_head	resources;
+	struct device		*dev;
+	struct list_head	pwr_supplies;
+	unsigned int		rev;
+	unsigned int		num;
+	bool			bridge_setup_done;
+	const int		*reg_offsets;
+	const int		*reg_field_info;
+	enum pcie_type		type;
+	struct pci_bus		*root_bus;
+	int			id;
+};
+
+static struct list_head brcm_pcie = LIST_HEAD_INIT(brcm_pcie);
+static phys_addr_t scb_size[BRCM_MAX_SCB];
+static int num_memc;
+static DEFINE_MUTEX(brcm_pcie_lock);
+
+/*
+ * The roundup_pow_of_two() from log2.h invokes
+ * __roundup_pow_of_two(unsigned long), but we really need a
+ * such a function to take a native u64 since unsigned long
+ * is 32 bits on some configurations.  So we provide this helper
+ * function below.
+ */
+static u64 roundup_pow_of_two_64(u64 n)
+{
+	return 1ULL << fls64(n - 1);
+}
+
+static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
+{
+	mutex_lock(&brcm_pcie_lock);
+	snprintf(pcie->name, sizeof(pcie->name) - 1, "PCIe%d", pcie->id);
+	list_add_tail(&pcie->list, &brcm_pcie);
+	mutex_unlock(&brcm_pcie_lock);
+
+	return 0;
+}
+
+static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
+{
+	struct list_head *pos, *q;
+	struct brcm_pcie *tmp;
+
+	mutex_lock(&brcm_pcie_lock);
+	list_for_each_safe(pos, q, &brcm_pcie) {
+		tmp = list_entry(pos, struct brcm_pcie, list);
+		if (tmp == pcie) {
+			list_del(pos);
+			if (list_empty(&brcm_pcie))
+				num_memc = 0;
+			break;
+		}
+	}
+	mutex_unlock(&brcm_pcie_lock);
+}
+
+/* This is to convert the size of the inbound bar region to the
+ * non-liniear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
+ */
+int encode_ibar_size(u64 size)
+{
+	int log2_in = ilog2(size);
+
+	if (log2_in >= 12 && log2_in <= 15)
+		/* Covers 4KB to 32KB (inclusive) */
+		return (log2_in - 12) + 0x1c;
+	else if (log2_in >= 16 && log2_in <= 37)
+		/* Covers 64KB to 32GB, (inclusive) */
+		return log2_in - 15;
+	/* Something is awry so disable */
+	return 0;
+}
+
+static u32 mdio_form_pkt(int port, int regad, int cmd)
+{
+	u32 pkt = 0;
+
+	pkt |= (port << MDIO_PORT_SHIFT) & MDIO_PORT_MASK;
+	pkt |= (regad << MDIO_REGAD_SHIFT) & MDIO_REGAD_MASK;
+	pkt |= (cmd << MDIO_CMD_SHIFT) & MDIO_CMD_MASK;
+
+	return pkt;
+}
+
+/* negative return value indicates error */
+static int mdio_read(void __iomem *base, u8 port, u8 regad)
+{
+	int tries;
+	u32 data;
+
+	bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_READ),
+		   base + PCIE_RC_DL_MDIO_ADDR);
+	bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);
+
+	data = bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
+	for (tries = 0; !MDIO_RD_DONE(data) && tries < 10; tries++) {
+		udelay(10);
+		data = bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
+	}
+
+	return MDIO_RD_DONE(data)
+		? (data & MDIO_DATA_MASK) >> MDIO_DATA_SHIFT
+		: -EIO;
+}
+
+/* negative return value indicates error */
+static int mdio_write(void __iomem *base, u8 port, u8 regad, u16 wrdata)
+{
+	int tries;
+	u32 data;
+
+	bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_WRITE),
+		   base + PCIE_RC_DL_MDIO_ADDR);
+	bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);
+	bcm_writel(MDIO_DATA_DONE_MASK | wrdata,
+		   base + PCIE_RC_DL_MDIO_WR_DATA);
+
+	data = bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
+	for (tries = 0; !MDIO_WT_DONE(data) && tries < 10; tries++) {
+		udelay(10);
+		data = bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
+	}
+
+	return MDIO_WT_DONE(data) ? 0 : -EIO;
+}
+
+static u32 rd_fld(void __iomem *p, u32 mask, int shift)
+{
+	return (bcm_readl(p) & mask) >> shift;
+}
+
+static void wr_fld(void __iomem *p, u32 mask, int shift, u32 val)
+{
+	u32 reg = bcm_readl(p);
+
+	reg = (reg & ~mask) | ((val << shift) & mask);
+	bcm_writel(reg, p);
+}
+
+static void wr_fld_rb(void __iomem *p, u32 mask, int shift, u32 val)
+{
+	wr_fld(p, mask, shift, val);
+	(void)bcm_readl(p);
+}
+
+/* configures device for ssc mode; negative return value indicates error */
+static int set_ssc(void __iomem *base)
+{
+	int tmp;
+	u16 wrdata;
+	int pll, ssc;
+
+	tmp = mdio_write(base, MDIO_PORT0, SET_ADDR_OFFSET, SSC_REGS_ADDR);
+	if (tmp < 0)
+		return tmp;
+
+	tmp = mdio_read(base, MDIO_PORT0, SSC_CNTL_OFFSET);
+	if (tmp < 0)
+		return tmp;
+
+	wrdata = INSERT_FIELD(tmp, SSC_CNTL_OVRD, EN, 1);
+	wrdata = INSERT_FIELD(wrdata, SSC_CNTL_OVRD, VAL, 1);
+	tmp = mdio_write(base, MDIO_PORT0, SSC_CNTL_OFFSET, wrdata);
+	if (tmp < 0)
+		return tmp;
+
+	usleep_range(1000, 2000);
+	tmp = mdio_read(base, MDIO_PORT0, SSC_STATUS_OFFSET);
+	if (tmp < 0)
+		return tmp;
+
+	ssc = EXTRACT_FIELD(tmp, SSC_STATUS, SSC);
+	pll = EXTRACT_FIELD(tmp, SSC_STATUS, PLL_LOCK);
+
+	return (ssc && pll) ? 0 : -EIO;
+}
+
+/* limits operation to a specific generation (1, 2, or 3) */
+static void set_gen(void __iomem *base, int gen)
+{
+	WR_FLD(base, PCIE_RC_CFG_PCIE_LINK_CAPABILITY, MAX_LINK_SPEED, gen);
+	WR_FLD(base, PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_2,
+	       TARGET_LINK_SPEED, gen);
+}
+
+static void set_pcie_outbound_win(struct brcm_pcie *pcie, unsigned int win,
+				  phys_addr_t cpu_addr, dma_addr_t  pci_addr,
+				  dma_addr_t size)
+{
+	void __iomem *base = pcie->base;
+	phys_addr_t cpu_addr_mb, limit_addr_mb;
+	u32 tmp;
+
+	/* Set the base of the pci_addr window */
+	bcm_writel(lower_32_bits(pci_addr) + MMIO_ENDIAN,
+		   base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + (win * 8));
+	bcm_writel(upper_32_bits(pci_addr),
+		   base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + (win * 8));
+
+	cpu_addr_mb = cpu_addr >> 20;
+	limit_addr_mb = (cpu_addr + size - 1) >> 20;
+
+	/* Write the addr base low register */
+	WR_FLD_WITH_OFFSET(base, (win * 4),
+			   PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
+			   BASE, cpu_addr_mb);
+	/* Write the addr limit low register */
+	WR_FLD_WITH_OFFSET(base, (win * 4),
+			   PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
+			   LIMIT, limit_addr_mb);
+
+	if (pcie->type != BCM7435 && pcie->type != BCM7425) {
+		/* Write the cpu addr high register */
+		tmp = (u32)(cpu_addr_mb >>
+			PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS);
+		WR_FLD_WITH_OFFSET(base, (win * 8),
+				   PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI,
+				   BASE, tmp);
+		/* Write the cpu limit high register */
+		tmp = (u32)(limit_addr_mb >>
+			PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS);
+		WR_FLD_WITH_OFFSET(base, (win * 8),
+				   PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI,
+				   LIMIT, tmp);
+	}
+}
+
+static int is_pcie_link_up(struct brcm_pcie *pcie, bool silent)
+{
+	void __iomem *base = pcie->base;
+	u32 val = bcm_readl(base + PCIE_MISC_PCIE_STATUS);
+	u32 dla = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_DL_ACTIVE);
+	u32 plu = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_PHYLINKUP);
+	u32 rc = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_PORT);
+
+	if (!rc && !silent)
+		dev_err(pcie->dev, "controller configured in EP mode\n");
+
+	return  (rc && dla && plu) ? 1 : 0;
+}
+
+static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie,
+						unsigned int val)
+{
+	unsigned int offset;
+	unsigned int shift = pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
+	u32 mask =  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MASK];
+
+	if (pcie->type != BCM7278) {
+		wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie), mask, shift,
+			  val);
+	} else if (of_machine_is_compatible("brcm,bcm7278a0")) {
+		/* The two PCIE instance on 7278a0 are not even consistent with
+		 * respect to each other for internal offsets, here we offset
+		 * by 0x14000 + RGR1_SW_INIT_1's relative offset to account for
+		 * that.
+		 */
+		offset = pcie->id ? 0x14010 : pcie->reg_offsets[RGR1_SW_INIT_1];
+		wr_fld_rb(pcie->base + offset, mask, shift, val);
+	} else {
+		wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie), mask, shift,
+			  val);
+	}
+}
+
+static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie,
+				       unsigned int val)
+{
+	if (pcie->type != BCM7278)
+		wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
+			  PCIE_RGR1_SW_INIT_1_PERST_MASK,
+			  PCIE_RGR1_SW_INIT_1_PERST_SHIFT, val);
+	else
+		/* Assert = 0, de-assert = 1 on 7278 */
+		WR_FLD_RB(pcie->base, PCIE_MISC_PCIE_CTRL, PCIE_PERSTB, !val);
+}
+
+static int brcm_parse_ranges(struct brcm_pcie *pcie)
+{
+	struct resource_entry *win;
+	int ret;
+
+	ret = of_pci_get_host_bridge_resources(pcie->dn, 0, 0xff,
+					       &pcie->resources, NULL);
+	if (ret) {
+		dev_err(pcie->dev, "failed to get host resources\n");
+		return ret;
+	}
+
+	resource_list_for_each_entry(win, &pcie->resources) {
+		struct resource *parent, *res = win->res;
+		dma_addr_t offset = (dma_addr_t)win->offset;
+
+		if (resource_type(res) == IORESOURCE_IO) {
+			parent = &ioport_resource;
+		} else if (resource_type(res) == IORESOURCE_MEM) {
+			if (pcie->num_out_wins >= BRCM_NUM_PCI_OUT_WINS) {
+				dev_err(pcie->dev, "too many outbound wins\n");
+				return -EINVAL;
+			}
+			pcie->out_wins[pcie->num_out_wins].cpu_addr
+				= (phys_addr_t)res->start;
+			pcie->out_wins[pcie->num_out_wins].pci_addr
+				= (dma_addr_t)(res->start
+					       - (phys_addr_t)offset);
+			pcie->out_wins[pcie->num_out_wins].size
+				= (dma_addr_t)(res->end - res->start + 1);
+			pcie->num_out_wins++;
+			parent = &iomem_resource;
+		} else {
+			continue;
+		}
+
+		ret = devm_request_resource(pcie->dev, parent, res);
+		if (ret) {
+			dev_err(pcie->dev, "failed to get res %pR\n", res);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static void set_regulators(struct brcm_pcie *pcie, bool on)
+{
+	struct list_head *pos;
+
+	list_for_each(pos, &pcie->pwr_supplies) {
+		struct brcm_dev_pwr_supply *supply
+			= list_entry(pos, struct brcm_dev_pwr_supply, node);
+
+		if (on && regulator_enable(supply->regulator))
+			pr_debug("Unable to turn on %s supply.\n",
+				 supply->name);
+		else if (!on && regulator_disable(supply->regulator))
+			pr_debug("Unable to turn off %s supply.\n",
+				 supply->name);
+	}
+}
+
+static void brcm_pcie_setup_prep(struct brcm_pcie *pcie)
+{
+	void __iomem *base = pcie->base;
+	unsigned int scb_size_val;
+	u64 rc_bar2_size = 0, rc_bar2_offset = 0, total_mem_size = 0;
+	u32 tmp, burst;
+	int i;
+
+	/* reset the bridge and the endpoint device */
+	/* field: PCIE_BRIDGE_SW_INIT = 1 */
+	brcm_pcie_bridge_sw_init_set(pcie, 1);
+
+	/* field: PCIE_SW_PERST = 1, on 7278, we start de-asserted already */
+	if (pcie->type != BCM7278)
+		brcm_pcie_perst_set(pcie, 1);
+
+	usleep_range(100, 200);
+
+	/* take the bridge out of reset */
+	/* field: PCIE_BRIDGE_SW_INIT = 0 */
+	brcm_pcie_bridge_sw_init_set(pcie, 0);
+
+	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
+	/* wait for serdes to be stable */
+	usleep_range(100, 200);
+
+	/* Grab the PCIe hw revision number */
+	tmp = bcm_readl(base + PCIE_MISC_REVISION);
+	pcie->rev = EXTRACT_FIELD(tmp, PCIE_MISC_REVISION, MAJMIN);
+
+	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
+	tmp = INSERT_FIELD(0, PCIE_MISC_MISC_CTRL, SCB_ACCESS_EN, 1);
+	tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, CFG_READ_UR_MODE, 1);
+	burst = (pcie->type == GENERIC || pcie->type == BCM7278)
+		? BURST_SIZE_512 : BURST_SIZE_256;
+	tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, MAX_BURST_SIZE, burst);
+	bcm_writel(tmp, base + PCIE_MISC_MISC_CTRL);
+
+	/* Set up inbound memory view for the EP (called RC_BAR2,
+	 * not to be confused with the BARs that are advertised by
+	 * the EP).
+	 */
+	for (i = 0; i < num_memc; i++)
+		total_mem_size += scb_size[i];
+
+	/* The PCI host controller by design must set the inbound
+	 * viewport to be a contiguous arrangement of all of the
+	 * system's memory.  In addition, its size mut be a power of
+	 * two.  To further complicate matters, the viewport must
+	 * start on a pci-address that is aligned on a multiple of its
+	 * size.  If a portion of the viewport does not represent
+	 * system memory -- e.g. 3GB of memory requires a 4GB viewport
+	 * -- we can map the outbound memory in or after 3GB and even
+	 * though the viewport will overlap the outbound memory the
+	 * controller will know to send outbound memory downstream and
+	 * everything else upstream.
+	 */
+	rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
+
+	/* Set simple configuration based on memory sizes
+	 * only.  We always start the viewport at address 0.
+	 */
+	rc_bar2_offset = 0;
+
+	tmp = lower_32_bits(rc_bar2_offset);
+	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
+			   encode_ibar_size(rc_bar2_size));
+	bcm_writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
+	bcm_writel(upper_32_bits(rc_bar2_offset),
+		   base + PCIE_MISC_RC_BAR2_CONFIG_HI);
+
+	/* field: SCB0_SIZE, default = 0xf (1 GB) */
+	scb_size_val = scb_size[0]
+		? ilog2(scb_size[0]) - 15 : 0xf;
+	WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB0_SIZE, scb_size_val);
+
+	/* field: SCB1_SIZE, default = 0xf (1 GB) */
+	if (num_memc > 1) {
+		scb_size_val = scb_size[1]
+			? ilog2(scb_size[1]) - 15 : 0xf;
+		WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB1_SIZE, scb_size_val);
+	}
+
+	/* field: SCB2_SIZE, default = 0xf (1 GB) */
+	if (num_memc > 2) {
+		scb_size_val = scb_size[2]
+			? ilog2(scb_size[2]) - 15 : 0xf;
+		WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB2_SIZE, scb_size_val);
+	}
+
+	/* disable the PCIE->GISB memory window (RC_BAR1) */
+	WR_FLD(base, PCIE_MISC_RC_BAR1_CONFIG_LO, SIZE, 0);
+
+	/* disable the PCIE->SCB memory window (RC_BAR3) */
+	WR_FLD(base, PCIE_MISC_RC_BAR3_CONFIG_LO, SIZE, 0);
+
+	if (!pcie->suspended) {
+		/* clear any interrupts we find on boot */
+		bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + CLR);
+		(void)bcm_readl(base + PCIE_INTR2_CPU_BASE + CLR);
+	}
+
+	/* Mask all interrupts since we are not handling any yet */
+	bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + MASK_SET);
+	(void)bcm_readl(base + PCIE_INTR2_CPU_BASE + MASK_SET);
+
+	if (pcie->gen)
+		set_gen(base, pcie->gen);
+
+	/* take the EP device out of reset */
+	/* field: PCIE_SW_PERST = 0 */
+	brcm_pcie_perst_set(pcie, 0);
+}
+
+static const char *link_speed_to_str(int s)
+{
+	switch (s) {
+	case 1:
+		return "2.5";
+	case 2:
+		return "5.0";
+	case 3:
+		return "8.0";
+	default:
+		break;
+	}
+	return "???";
+}
+
+static int brcm_pcie_setup_bridge(struct brcm_pcie *pcie)
+{
+	void __iomem *base = pcie->base;
+	const int limit = pcie->suspended ? 1000 : 100;
+	unsigned int status;
+	int i, j, ret;
+	u32 neg_width, neg_speed;
+	bool ssc_good = false;
+
+	/* Give the RC/EP time to wake up, before trying to configure RC.
+	 * Intermittently check status for link-up, up to a total of 100ms
+	 * when we don't know if the device is there, and up to 1000ms if
+	 * we do know the device is there.
+	 */
+	for (i = 1, j = 0; j < limit && !is_pcie_link_up(pcie, true);
+	     j += i, i = i * 2)
+		msleep(i + j > limit ? limit - j : i);
+
+	if (!is_pcie_link_up(pcie, false)) {
+		dev_info(pcie->dev, "link down\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < pcie->num_out_wins; i++)
+		set_pcie_outbound_win(pcie, i, pcie->out_wins[i].cpu_addr,
+				      pcie->out_wins[i].pci_addr,
+				      pcie->out_wins[i].size);
+
+	/* For config space accesses on the RC, show the right class for
+	 * a PCI-PCI bridge
+	 */
+	WR_FLD_RB(base, PCIE_RC_CFG_PRIV1_ID_VAL3, CLASS_CODE, 0x060400);
+
+	if (pcie->ssc) {
+		ret = set_ssc(base);
+		if (ret == 0)
+			ssc_good = true;
+		else
+			dev_err(pcie->dev,
+				"failed attempt to enter ssc mode\n");
+	}
+
+	status = bcm_readl(base + PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL);
+	neg_width = EXTRACT_FIELD(status, PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL,
+				  NEG_LINK_WIDTH);
+	neg_speed = EXTRACT_FIELD(status, PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL,
+				  NEG_LINK_SPEED);
+	dev_info(pcie->dev, "link up, %s Gbps x%u %s\n",
+		 link_speed_to_str(neg_speed), neg_width,
+		 ssc_good ? "(SSC)" : "(!SSC)");
+
+	/* Enable configuration request retry (see pci_scan_device()) */
+	/* field RC_CRS_EN = 1 */
+	WR_FLD(base, PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL, RC_CRS_EN, 1);
+
+	/* PCIE->SCB endian mode for BAR */
+	/* field ENDIAN_MODE_BAR2 = DATA_ENDIAN */
+	WR_FLD_RB(base, PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1,
+		  ENDIAN_MODE_BAR2, DATA_ENDIAN);
+
+	/* Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
+	 * is enabled =>  setting the CLKREQ_DEBUG_ENABLE field to 1.
+	 */
+	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, CLKREQ_DEBUG_ENABLE, 1);
+
+	pcie->bridge_setup_done = true;
+
+	return 0;
+}
+
+static void enter_l23(struct brcm_pcie *pcie)
+{
+	void __iomem *base = pcie->base;
+	int tries, l23;
+
+	/* assert request for L23 */
+	WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 1);
+	/* poll L23 status */
+	for (tries = 0, l23 = 0; tries < 1000 && !l23; tries++)
+		l23 = RD_FLD(base, PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);
+	if (!l23)
+		dev_err(pcie->dev, "failed to enter L23\n");
+}
+
+static void turn_off(struct brcm_pcie *pcie)
+{
+	void __iomem *base = pcie->base;
+
+	if (is_pcie_link_up(pcie, true))
+		enter_l23(pcie);
+	/* Reset endpoint device */
+	brcm_pcie_perst_set(pcie, 1);
+	/* deassert request for L23 in case it was asserted */
+	WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 0);
+	/* SERDES_IDDQ = 1 */
+	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 1);
+	/* Shutdown PCIe bridge */
+	brcm_pcie_bridge_sw_init_set(pcie, 1);
+}
+
+static int brcm_pcie_suspend(struct device *dev)
+{
+	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->bridge_setup_done)
+		return 0;
+
+	turn_off(pcie);
+	clk_disable_unprepare(pcie->clk);
+	set_regulators(pcie, false);
+	pcie->suspended = true;
+
+	return 0;
+}
+
+static int brcm_pcie_resume(struct device *dev)
+{
+	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	void __iomem *base;
+	int ret;
+
+	if (!pcie->bridge_setup_done)
+		return 0;
+
+	base = pcie->base;
+	set_regulators(pcie, true);
+	clk_prepare_enable(pcie->clk);
+
+	/* Take bridge out of reset so we can access the SERDES reg */
+	brcm_pcie_bridge_sw_init_set(pcie, 0);
+
+	/* SERDES_IDDQ = 0 */
+	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
+	/* wait for serdes to be stable */
+	usleep_range(100, 200);
+
+	brcm_pcie_setup_prep(pcie);
+
+	ret = brcm_pcie_setup_bridge(pcie);
+	if (ret)
+		return ret;
+
+	pcie->suspended = false;
+
+	return 0;
+}
+
+/* Configuration space read/write support */
+static int cfg_index(int busnr, int devfn, int reg)
+{
+	return ((PCI_SLOT(devfn) & 0x1f) << PCI_SLOT_SHIFT)
+		| ((PCI_FUNC(devfn) & 0x07) << PCI_FUNC_SHIFT)
+		| (busnr << PCI_BUSNUM_SHIFT)
+		| (reg & ~3);
+}
+
+static void __iomem *brcm_pci_map_cfg(struct pci_bus *bus, unsigned int devfn,
+				      int where)
+{
+	struct brcm_pcie *pcie = bus->sysdata;
+	void __iomem *base = pcie->base;
+	bool rc_access = pci_is_root_bus(bus);
+	int idx;
+
+	if (!is_pcie_link_up(pcie, true))
+		return NULL;
+
+	base = pcie->base;
+	idx = cfg_index(bus->number, devfn, where);
+
+	bcm_writel(idx, pcie->base + IDX_ADDR(pcie));
+
+	if (rc_access) {
+		if (PCI_SLOT(devfn))
+			return NULL;
+		return base + (where & ~3);
+	}
+
+	return pcie->base + DATA_ADDR(pcie);
+}
+
+static void __attribute__((__section__("pci_fixup_early")))
+brcm_pcibios_fixup(struct pci_dev *dev)
+{
+	struct brcm_pcie *pcie = dev->bus->sysdata;
+	u8 slot = PCI_SLOT(dev->devfn);
+
+	dev_info(pcie->dev,
+		 "found device %04x:%04x on bus %d (%s), slot %d (irq %d)\n",
+		 dev->vendor, dev->device, dev->bus->number, pcie->name,
+		 slot, of_irq_parse_and_map_pci(dev, slot, 1));
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, brcm_pcibios_fixup);
+
+static const struct of_device_id brcm_pci_match[] = {
+	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
+	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
+	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
+	{},
+};
+MODULE_DEVICE_TABLE(of, brcm_pci_match);
+
+static void _brcm_pcie_remove(struct brcm_pcie *pcie)
+{
+	turn_off(pcie);
+	clk_disable_unprepare(pcie->clk);
+	clk_put(pcie->clk);
+	set_regulators(pcie, false);
+	brcm_pcie_remove_controller(pcie);
+}
+
+static int brcm_pcie_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct property *pp;
+	const struct of_device_id *of_id;
+	const struct pcie_cfg_data *data;
+	int ret;
+	struct brcm_pcie *pcie;
+	struct resource *res;
+	void __iomem *base;
+	u32 tmp;
+	struct brcm_dev_pwr_supply *supply;
+	struct pci_host_bridge *bridge;
+	struct pci_bus *child;
+	u32 domain;
+
+	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = pci_host_bridge_priv(bridge);
+	INIT_LIST_HEAD(&pcie->resources);
+
+	of_id = of_match_node(brcm_pci_match, dn);
+	if (!of_id) {
+		pr_err("failed to look up compatible string\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(dn, "dma-ranges", &tmp) == 0) {
+		pr_err("cannot yet handle dma-ranges\n");
+		return -EINVAL;
+	}
+
+	data = of_id->data;
+	pcie->reg_offsets = data->offsets;
+	pcie->reg_field_info = data->reg_field_info;
+	pcie->type = data->type;
+	pcie->dn = dn;
+	pcie->dev = &pdev->dev;
+
+	if (of_property_read_u32(dn, "linux,pci-domain", &domain) == 0) {
+		pcie->id = (int)domain;
+	} else {
+		dev_err(pcie->dev, "linux,pci-domain prop missing\n");
+		return -EINVAL;
+	}
+
+	INIT_LIST_HEAD(&pcie->pwr_supplies);
+	for_each_property_of_node(dn, pp) {
+		const int n = strlen(pp->name);
+
+		if (n < 7)
+			continue;
+		if (strncmp(pp->name + n - 7, "-supply", 7))
+			continue;
+		if (n > sizeof(supply->name) - 1) {
+			dev_err(&pdev->dev, "prop supply name %s too long\n",
+				pp->name);
+			continue;
+		}
+		supply = devm_kzalloc(&pdev->dev, sizeof(*supply), GFP_KERNEL);
+		if (!supply)
+			return -ENOMEM;
+		strcpy(supply->name, pp->name);
+		supply->name[n - 7] = 0; /* remove "-supply" */
+		supply->regulator = devm_regulator_get(&pdev->dev, supply->name);
+
+		if (IS_ERR(supply->regulator)) {
+			dev_err(&pdev->dev, "Unable to get %s, err=%d\n",
+				pp->name, (int)PTR_ERR(supply->regulator));
+			continue;
+		}
+		list_add_tail(&supply->node, &pcie->pwr_supplies);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pcie->clk = of_clk_get_by_name(dn, "sw_pcie");
+	if (IS_ERR(pcie->clk)) {
+		dev_err(&pdev->dev, "could not get clock\n");
+		pcie->clk = NULL;
+	}
+	pcie->base = base;
+
+	ret = of_pci_get_max_link_speed(dn);
+	pcie->gen = (ret < 0) ? 0 : ret;
+
+	pcie->ssc = of_property_read_bool(dn, "brcm,ssc");
+
+	ret = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (ret == 0)
+		/* keep going, as we don't use this intr yet */
+		dev_warn(pcie->dev, "cannot get pcie interrupt\n");
+	else
+		pcie->irq = ret;
+
+	ret = brcm_parse_ranges(pcie);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable clock\n");
+		return ret;
+	}
+
+	ret = brcm_pcie_add_controller(pcie);
+	if (ret)
+		return ret;
+
+	set_regulators(pcie, true);
+	brcm_pcie_setup_prep(pcie);
+	ret = brcm_pcie_setup_bridge(pcie);
+	if (ret)
+		goto fail;
+
+	list_splice_init(&pcie->resources, &bridge->windows);
+	bridge->dev.parent = &pdev->dev;
+	bridge->busnr = 0;
+	bridge->ops = &brcm_pci_ops;
+	bridge->sysdata = pcie;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		dev_err(pcie->dev, "Scanning root bridge failed");
+		goto fail;
+	}
+
+	pci_assign_unassigned_bus_resources(bridge->bus);
+	list_for_each_entry(child, &bridge->bus->children, node)
+		pcie_bus_configure_settings(child);
+	pci_bus_add_devices(bridge->bus);
+	platform_set_drvdata(pdev, pcie);
+	pcie->root_bus = bridge->bus;
+
+	return 0;
+
+fail:
+	_brcm_pcie_remove(pcie);
+	return ret;
+}
+
+static int brcm_pcie_remove(struct platform_device *pdev)
+{
+	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
+
+	pci_stop_root_bus(pcie->root_bus);
+	pci_remove_root_bus(pcie->root_bus);
+	_brcm_pcie_remove(pcie);
+
+	return 0;
+}
+
+static const struct dev_pm_ops brcm_pcie_pm_ops = {
+	.suspend_noirq = brcm_pcie_suspend,
+	.resume_noirq = brcm_pcie_resume,
+};
+
+static struct platform_driver __refdata brcm_pci_driver = {
+	.probe = brcm_pcie_probe,
+	.remove = brcm_pcie_remove,
+	.driver = {
+		.name = "brcm-pci",
+		.owner = THIS_MODULE,
+		.of_match_table = brcm_pci_match,
+		.pm = &brcm_pcie_pm_ops,
+	},
+};
+
+module_platform_driver(brcm_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Broadcom STB PCIE RC driver");
+MODULE_AUTHOR("Broadcom");
diff --git a/drivers/pci/host/pci-brcmstb.h b/drivers/pci/host/pci-brcmstb.h
new file mode 100644
index 0000000..86f9cd1
--- /dev/null
+++ b/drivers/pci/host/pci-brcmstb.h
@@ -0,0 +1,33 @@
+#ifndef __BRCMSTB_PCI_H
+#define __BRCMSTB_PCI_H
+
+/*
+ * Copyright (C) 2015 - 2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define BRCM_PCIE_NAME_SIZE		8
+#define BRCM_INT_PCI_MSI_NR		32
+#define BRCM_PCIE_HW_REV_33		0x0303
+
+/* Broadcom PCIE Offsets */
+#define PCIE_INTR2_CPU_BASE		0x4300
+
+#if defined(CONFIG_MIPS)
+/* Broadcom MIPs HW implicitly does the swapping if necessary */
+#define bcm_readl(a)		__raw_readl(a)
+#define bcm_writel(d, a)	__raw_writel(d, a)
+#else
+#define bcm_readl(a)		readl(a)
+#define bcm_writel(d, a)	writel(d, a)
+#endif
+
+#endif /* __BRCMSTB_PCI_H */
-- 
1.9.0.138.g2de3478
