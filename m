Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:27:36 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50801 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903637Ab2FLIYj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:39 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so5334465bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AbmLqXhldVeFyIK1+ur1aR/x8/NOdzOjdhTc7UIWOvE=;
        b=oPuGlqtFa6dR+EcVhKkWQkROowxhcxub7vvZOEicCPFR9wJy9/Ij4s4E/lQfMlvFZo
         zuOO1+WbylYO/GCb/o+sbT2ssPW+uatwQNntKzJGcnrDt2F54EAPKnrAFgrsHXWopUFn
         jbXj0k1A7Yutp0yZoKqeq9RNGQOOt3qwQKB5vAvhulElhHap8r1HQ1rWtbu9znoFCImO
         h1KxZmC0gt1KjtXyvHqH1fHU93tRcvEbHAWiVZT1v/vbd1FRIek7Bhyhw+PtTwcrSE6i
         4elPiq4qFHBqmaPzSPNapF1d/SumARAof62QKllWOchSqaEn6MYE2WZ6hg/m0Xbcn8TY
         dzdQ==
Received: by 10.204.129.17 with SMTP id m17mr11452055bks.4.1339489479702;
        Tue, 12 Jun 2012 01:24:39 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.37
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:38 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 6/8] MIPS: BCM63XX: Add PCIe Support for BCM6328
Date:   Tue, 12 Jun 2012 10:23:43 +0200
Message-Id: <1339489425-19037-7-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Add support for the PCIe port found on BCM6328.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/Kconfig                         |    1 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    9 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h   |    6 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   54 ++++++++++
 arch/mips/pci/ops-bcm63xx.c                       |   61 +++++++++++
 arch/mips/pci/pci-bcm63xx.c                       |  112 +++++++++++++++++++++
 arch/mips/pci/pci-bcm63xx.h                       |    5 +
 7 files changed, 248 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 09e93ca..d03e879 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -3,6 +3,7 @@ menu "CPU support"
 
 config BCM63XX_CPU_6328
 	bool "support 6328 CPU"
+	select HW_HAS_PCI
 
 config BCM63XX_CPU_6338
 	bool "support 6338 CPU"
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index b842b6d..e104ddb 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -122,6 +122,7 @@ enum bcm63xx_regs_set {
 	RSET_USBH_PRIV,
 	RSET_MPI,
 	RSET_PCMCIA,
+	RSET_PCIE,
 	RSET_DSL,
 	RSET_ENET0,
 	RSET_ENET1,
@@ -188,6 +189,7 @@ enum bcm63xx_regs_set {
 #define BCM_6328_USBH_PRIV_BASE		(0xdeadbeef)
 #define BCM_6328_MPI_BASE		(0xdeadbeef)
 #define BCM_6328_PCMCIA_BASE		(0xdeadbeef)
+#define BCM_6328_PCIE_BASE		(0xb0e40000)
 #define BCM_6328_SDRAM_REGS_BASE	(0xdeadbeef)
 #define BCM_6328_DSL_BASE		(0xb0001900)
 #define BCM_6328_UBUS_BASE		(0xdeadbeef)
@@ -232,6 +234,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_USBH_PRIV_BASE		(0xdeadbeef)
 #define BCM_6338_MPI_BASE		(0xfffe3160)
 #define BCM_6338_PCMCIA_BASE		(0xdeadbeef)
+#define BCM_6338_PCIE_BASE		(0xdeadbeef)
 #define BCM_6338_SDRAM_REGS_BASE	(0xfffe3100)
 #define BCM_6338_DSL_BASE		(0xfffe1000)
 #define BCM_6338_UBUS_BASE		(0xdeadbeef)
@@ -279,6 +282,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6345_PCMCIA_BASE		(0xfffe2028)
 #define BCM_6345_MPI_BASE		(0xfffe2000)
+#define BCM_6345_PCIE_BASE		(0xdeadbeef)
 #define BCM_6345_OHCI0_BASE		(0xfffe2100)
 #define BCM_6345_OHCI_PRIV_BASE		(0xfffe2200)
 #define BCM_6345_USBH_PRIV_BASE		(0xdeadbeef)
@@ -320,6 +324,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_USBH_PRIV_BASE		(0xdeadbeef)
 #define BCM_6348_MPI_BASE		(0xfffe2000)
 #define BCM_6348_PCMCIA_BASE		(0xfffe2054)
+#define BCM_6348_PCIE_BASE		(0xdeadbeef)
 #define BCM_6348_SDRAM_REGS_BASE	(0xfffe2300)
 #define BCM_6348_M2M_BASE		(0xfffe2800)
 #define BCM_6348_DSL_BASE		(0xfffe3000)
@@ -362,6 +367,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_USBH_PRIV_BASE		(0xfffe1500)
 #define BCM_6358_MPI_BASE		(0xfffe1000)
 #define BCM_6358_PCMCIA_BASE		(0xfffe1054)
+#define BCM_6358_PCIE_BASE		(0xdeadbeef)
 #define BCM_6358_SDRAM_REGS_BASE	(0xfffe2300)
 #define BCM_6358_M2M_BASE		(0xdeadbeef)
 #define BCM_6358_DSL_BASE		(0xfffe3000)
@@ -405,6 +411,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_USBH_PRIV_BASE		(0xb0001700)
 #define BCM_6368_MPI_BASE		(0xb0001000)
 #define BCM_6368_PCMCIA_BASE		(0xb0001054)
+#define BCM_6368_PCIE_BASE		(0xdeadbeef)
 #define BCM_6368_SDRAM_REGS_BASE	(0xdeadbeef)
 #define BCM_6368_M2M_BASE		(0xdeadbeef)
 #define BCM_6368_DSL_BASE		(0xdeadbeef)
@@ -453,6 +460,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, USBH_PRIV)				\
 	__GEN_RSET_BASE(__cpu, MPI)					\
 	__GEN_RSET_BASE(__cpu, PCMCIA)					\
+	__GEN_RSET_BASE(__cpu, PCIE)					\
 	__GEN_RSET_BASE(__cpu, DSL)					\
 	__GEN_RSET_BASE(__cpu, ENET0)					\
 	__GEN_RSET_BASE(__cpu, ENET1)					\
@@ -493,6 +501,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_USBH_PRIV]	= BCM_## __cpu ##_USBH_PRIV_BASE,	\
 	[RSET_MPI]		= BCM_## __cpu ##_MPI_BASE,		\
 	[RSET_PCMCIA]		= BCM_## __cpu ##_PCMCIA_BASE,		\
+	[RSET_PCIE]		= BCM_## __cpu ##_PCIE_BASE,		\
 	[RSET_DSL]		= BCM_## __cpu ##_DSL_BASE,		\
 	[RSET_ENET0]		= BCM_## __cpu ##_ENET0_BASE,		\
 	[RSET_ENET1]		= BCM_## __cpu ##_ENET1_BASE,		\
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
index 6dcd8b2..9203d90 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
@@ -40,6 +40,10 @@
 #define BCM_CB_MEM_END_PA		(BCM_CB_MEM_BASE_PA +		\
 					BCM_CB_MEM_SIZE - 1)
 
+#define BCM_PCIE_MEM_BASE_PA		0x10f00000
+#define BCM_PCIE_MEM_SIZE		(16 * 1024 * 1024)
+#define BCM_PCIE_MEM_END_PA		(BCM_PCIE_MEM_BASE_PA +		\
+					BCM_PCIE_MEM_SIZE - 1)
 
 /*
  * Internal registers are accessed through KSEG3
@@ -85,6 +89,8 @@
 #define bcm_mpi_writel(v, o)	bcm_rset_writel(RSET_MPI, (v), (o))
 #define bcm_pcmcia_readl(o)	bcm_rset_readl(RSET_PCMCIA, (o))
 #define bcm_pcmcia_writel(v, o)	bcm_rset_writel(RSET_PCMCIA, (v), (o))
+#define bcm_pcie_readl(o)	bcm_rset_readl(RSET_PCIE, (o))
+#define bcm_pcie_writel(v, o)	bcm_rset_writel(RSET_PCIE, (v), (o))
 #define bcm_sdram_readl(o)	bcm_rset_readl(RSET_SDRAM, (o))
 #define bcm_sdram_writel(v, o)	bcm_rset_writel(RSET_SDRAM, (v), (o))
 #define bcm_memc_readl(o)	bcm_rset_readl(RSET_MEMC, (o))
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 4fc2ab2..4ccc2a7 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1162,6 +1162,9 @@
 /*************************************************************************
  * _REG relative to RSET_MISC
  *************************************************************************/
+#define MISC_SERDES_CTRL_REG		0x0
+#define SERDES_PCIE_EN			(1 << 0)
+#define SERDES_PCIE_EXD_EN		(1 << 15)
 
 #define MISC_STRAPBUS_6328_REG		0x240
 #define STRAPBUS_6328_FCVO_SHIFT	7
@@ -1169,4 +1172,55 @@
 #define STRAPBUS_6328_BOOT_SEL_SERIAL	(1 << 28)
 #define STRAPBUS_6328_BOOT_SEL_NAND	(0 << 28)
 
+/*************************************************************************
+ * _REG relative to RSET_PCIE
+ *************************************************************************/
+
+#define PCIE_CONFIG2_REG		0x408
+#define CONFIG2_BAR1_SIZE_EN		1
+#define CONFIG2_BAR1_SIZE_MASK		0xf
+
+#define PCIE_IDVAL3_REG			0x43c
+#define IDVAL3_CLASS_CODE_MASK		0xffffff
+#define IDVAL3_SUBCLASS_SHIFT		8
+#define IDVAL3_CLASS_SHIFT		16
+
+#define PCIE_DLSTATUS_REG		0x1048
+#define DLSTATUS_PHYLINKUP		(1 << 13)
+
+#define PCIE_BRIDGE_OPT1_REG		0x2820
+#define OPT1_RD_BE_OPT_EN		(1 << 7)
+#define OPT1_RD_REPLY_BE_FIX_EN		(1 << 9)
+#define OPT1_PCIE_BRIDGE_HOLE_DET_EN	(1 << 11)
+#define OPT1_L1_INT_STATUS_MASK_POL	(1 << 12)
+
+#define PCIE_BRIDGE_OPT2_REG		0x2824
+#define OPT2_UBUS_UR_DECODE_DIS		(1 << 2)
+#define OPT2_TX_CREDIT_CHK_EN		(1 << 4)
+#define OPT2_CFG_TYPE1_BD_SEL		(1 << 7)
+#define OPT2_CFG_TYPE1_BUS_NO_SHIFT	16
+#define OPT2_CFG_TYPE1_BUS_NO_MASK	(0xff << OPT2_CFG_TYPE1_BUS_NO_SHIFT)
+
+#define PCIE_BRIDGE_BAR0_BASEMASK_REG	0x2828
+#define PCIE_BRIDGE_BAR1_BASEMASK_REG	0x2830
+#define BASEMASK_REMAP_EN		(1 << 0)
+#define BASEMASK_SWAP_EN		(1 << 1)
+#define BASEMASK_MASK_SHIFT		4
+#define BASEMASK_MASK_MASK		(0xfff << BASEMASK_MASK_SHIFT)
+#define BASEMASK_BASE_SHIFT		20
+#define BASEMASK_BASE_MASK		(0xfff << BASEMASK_BASE_SHIFT)
+
+#define PCIE_BRIDGE_BAR0_REBASE_ADDR_REG 0x282c
+#define PCIE_BRIDGE_BAR1_REBASE_ADDR_REG 0x2834
+#define REBASE_ADDR_BASE_SHIFT		20
+#define REBASE_ADDR_BASE_MASK		(0xfff << REBASE_ADDR_BASE_SHIFT)
+
+#define PCIE_BRIDGE_RC_INT_MASK_REG	0x2854
+#define PCIE_RC_INT_A			(1 << 0)
+#define PCIE_RC_INT_B			(1 << 1)
+#define PCIE_RC_INT_C			(1 << 2)
+#define PCIE_RC_INT_D			(1 << 3)
+
+#define PCIE_DEVICE_OFFSET		0x8000
+
 #endif /* BCM63XX_REGS_H_ */
diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
index 097239b..65c7bd1 100644
--- a/arch/mips/pci/ops-bcm63xx.c
+++ b/arch/mips/pci/ops-bcm63xx.c
@@ -465,3 +465,64 @@ static void __devinit bcm63xx_fixup(struct pci_dev *dev)
 
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, bcm63xx_fixup);
 #endif
+
+static int bcm63xx_pcie_can_access(struct pci_bus *bus, int devfn)
+{
+	switch (bus->number) {
+	case PCIE_BUS_BRIDGE:
+		return (PCI_SLOT(devfn) == 0);
+	case PCIE_BUS_DEVICE:
+		if (PCI_SLOT(devfn) == 0)
+			return bcm_pcie_readl(PCIE_DLSTATUS_REG)
+					& DLSTATUS_PHYLINKUP;
+	default:
+		return false;
+	}
+}
+
+static int bcm63xx_pcie_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *val)
+{
+	u32 data;
+	u32 reg = where & ~3;
+
+	if (!bcm63xx_pcie_can_access(bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == PCIE_BUS_DEVICE)
+		reg += PCIE_DEVICE_OFFSET;
+
+	data = bcm_pcie_readl(reg);
+
+	*val = postprocess_read(data, where, size);
+
+	return PCIBIOS_SUCCESSFUL;
+
+}
+
+static int bcm63xx_pcie_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 val)
+{
+	u32 data;
+	u32 reg = where & ~3;
+
+	if (!bcm63xx_pcie_can_access(bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == PCIE_BUS_DEVICE)
+		reg += PCIE_DEVICE_OFFSET;
+
+
+	data = bcm_pcie_readl(reg);
+
+	data = preprocess_write(data, val, where, size);
+	bcm_pcie_writel(data, reg);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+struct pci_ops bcm63xx_pcie_ops = {
+	.read   = bcm63xx_pcie_read,
+	.write  = bcm63xx_pcie_write
+};
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index a2b6d55..8a48139 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/bootinfo.h>
 
 #include "pci-bcm63xx.h"
@@ -71,6 +72,26 @@ struct pci_controller bcm63xx_cb_controller = {
 };
 #endif
 
+static struct resource bcm_pcie_mem_resource = {
+	.name   = "bcm63xx PCIe memory space",
+	.start  = BCM_PCIE_MEM_BASE_PA,
+	.end    = BCM_PCIE_MEM_END_PA,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct resource bcm_pcie_io_resource = {
+	.name   = "bcm63xx PCIe IO space",
+	.start  = 0,
+	.end    = 0,
+	.flags  = 0,
+};
+
+struct pci_controller bcm63xx_pcie_controller = {
+	.pci_ops	= &bcm63xx_pcie_ops,
+	.io_resource	= &bcm_pcie_io_resource,
+	.mem_resource	= &bcm_pcie_mem_resource,
+};
+
 static u32 bcm63xx_int_cfg_readl(u32 reg)
 {
 	u32 tmp;
@@ -94,6 +115,95 @@ static void bcm63xx_int_cfg_writel(u32 val, u32 reg)
 
 void __iomem *pci_iospace_start;
 
+static void __init bcm63xx_reset_pcie(void)
+{
+	u32 val;
+
+	/* enable clock */
+	val = bcm_perf_readl(PERF_CKCTL_REG);
+	val |= CKCTL_6328_PCIE_EN;
+	bcm_perf_writel(val, PERF_CKCTL_REG);
+
+	/* enable SERDES */
+	val = bcm_misc_readl(MISC_SERDES_CTRL_REG);
+	val |= SERDES_PCIE_EN | SERDES_PCIE_EXD_EN;
+	bcm_misc_writel(val, MISC_SERDES_CTRL_REG);
+
+	/* reset the PCIe core */
+	val = bcm_perf_readl(PERF_SOFTRESET_6328_REG);
+
+	val &= ~SOFTRESET_6328_PCIE_MASK;
+	val &= ~SOFTRESET_6328_PCIE_CORE_MASK;
+	val &= ~SOFTRESET_6328_PCIE_HARD_MASK;
+	val &= ~SOFTRESET_6328_PCIE_EXT_MASK;
+	bcm_perf_writel(val, PERF_SOFTRESET_6328_REG);
+	mdelay(10);
+
+	val |= SOFTRESET_6328_PCIE_MASK;
+	val |= SOFTRESET_6328_PCIE_CORE_MASK;
+	val |= SOFTRESET_6328_PCIE_HARD_MASK;
+	bcm_perf_writel(val, PERF_SOFTRESET_6328_REG);
+	mdelay(10);
+
+	val |= SOFTRESET_6328_PCIE_EXT_MASK;
+	bcm_perf_writel(val, PERF_SOFTRESET_6328_REG);
+	mdelay(200);
+}
+
+static int __init bcm63xx_register_pcie(void)
+{
+	u32 val;
+
+	bcm63xx_reset_pcie();
+
+	/* configure the PCIe bridge */
+	val = bcm_pcie_readl(PCIE_BRIDGE_OPT1_REG);
+	val |= OPT1_RD_BE_OPT_EN;
+	val |= OPT1_RD_REPLY_BE_FIX_EN;
+	val |= OPT1_PCIE_BRIDGE_HOLE_DET_EN;
+	val |= OPT1_L1_INT_STATUS_MASK_POL;
+	bcm_pcie_writel(val, PCIE_BRIDGE_OPT1_REG);
+
+	/* setup the interrupts */
+	val = bcm_pcie_readl(PCIE_BRIDGE_RC_INT_MASK_REG);
+	val |= PCIE_RC_INT_A | PCIE_RC_INT_B | PCIE_RC_INT_C | PCIE_RC_INT_D;
+	bcm_pcie_writel(val, PCIE_BRIDGE_RC_INT_MASK_REG);
+
+	val = bcm_pcie_readl(PCIE_BRIDGE_OPT2_REG);
+	/* enable credit checking and error checking */
+	val |= OPT2_TX_CREDIT_CHK_EN;
+	val |= OPT2_UBUS_UR_DECODE_DIS;
+
+	/* set device bus/func for the pcie device */
+	val |= (PCIE_BUS_DEVICE << OPT2_CFG_TYPE1_BUS_NO_SHIFT);
+	val |= OPT2_CFG_TYPE1_BD_SEL;
+	bcm_pcie_writel(val, PCIE_BRIDGE_OPT2_REG);
+
+	/* setup class code as bridge */
+	val = bcm_pcie_readl(PCIE_IDVAL3_REG);
+	val &= ~IDVAL3_CLASS_CODE_MASK;
+	val |= (PCI_CLASS_BRIDGE_PCI << IDVAL3_SUBCLASS_SHIFT);
+	bcm_pcie_writel(val, PCIE_IDVAL3_REG);
+
+	/* disable bar1 size */
+	val = bcm_pcie_readl(PCIE_CONFIG2_REG);
+	val &= ~CONFIG2_BAR1_SIZE_MASK;
+	bcm_pcie_writel(val, PCIE_CONFIG2_REG);
+
+	/* set bar0 to little endian */
+	val = (BCM_PCIE_MEM_BASE_PA >> 20) << BASEMASK_BASE_SHIFT;
+	val |= (BCM_PCIE_MEM_BASE_PA >> 20) << BASEMASK_MASK_SHIFT;
+	val |= BASEMASK_REMAP_EN;
+	bcm_pcie_writel(val, PCIE_BRIDGE_BAR0_BASEMASK_REG);
+
+	val = (BCM_PCIE_MEM_BASE_PA >> 20) << REBASE_ADDR_BASE_SHIFT;
+	bcm_pcie_writel(val, PCIE_BRIDGE_BAR0_REBASE_ADDR_REG);
+
+	register_pci_controller(&bcm63xx_pcie_controller);
+
+	return 0;
+}
+
 static int __init bcm63xx_register_pci(void)
 {
 	unsigned int mem_size;
@@ -221,6 +331,8 @@ static int __init bcm63xx_pci_init(void)
 		return -ENODEV;
 
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		return bcm63xx_register_pcie();
 	case BCM6348_CPU_ID:
 	case BCM6358_CPU_ID:
 	case BCM6368_CPU_ID:
diff --git a/arch/mips/pci/pci-bcm63xx.h b/arch/mips/pci/pci-bcm63xx.h
index a6e594e..e6736d5 100644
--- a/arch/mips/pci/pci-bcm63xx.h
+++ b/arch/mips/pci/pci-bcm63xx.h
@@ -13,11 +13,16 @@
  */
 #define CARDBUS_PCI_IDSEL	0x8
 
+
+#define PCIE_BUS_BRIDGE		0
+#define PCIE_BUS_DEVICE		1
+
 /*
  * defined in ops-bcm63xx.c
  */
 extern struct pci_ops bcm63xx_pci_ops;
 extern struct pci_ops bcm63xx_cb_ops;
+extern struct pci_ops bcm63xx_pcie_ops;
 
 /*
  * defined in pci-bcm63xx.c
-- 
1.7.2.5
