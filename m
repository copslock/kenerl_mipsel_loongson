Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2018 22:21:03 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:13974 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991783AbeIIUUxdA4Q1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Sep 2018 22:20:53 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C997441ED3;
        Sun,  9 Sep 2018 22:20:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id AeW39rjIwYWn; Sun,  9 Sep 2018 22:20:41 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 6/6] net: dsa: Add Lantiq / Intel DSA driver for vrx200
Date:   Sun,  9 Sep 2018 22:20:39 +0200
Message-Id: <20180909202039.471-1-hauke@hauke-m.de>
In-Reply-To: <20180909201647.32727-1-hauke@hauke-m.d>
References: <20180909201647.32727-1-hauke@hauke-m.d>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This adds the DSA driver for the GSWIP Switch found in the VRX200 SoC.
This switch is integrated in the DSL SoC, this SoC uses a GSWIP version
2.1, there are other SoCs using different versions of this IP block, but
this driver was only tested with the version found in the VRX200.
Currently only the basic features are implemented which will forward all
packages to the CPU and let the CPU do the forwarding. The hardware also
support Layer 2 offloading which is not yet implemented in this driver.

The GPHY FW loaded is now done by this driver and not any more by the
separate driver in drivers/soc/lantiq/gphy.c, I will remove this driver
is a separate patch. to make use of the GPHY this switch driver is
needed anyway. Other SoCs have more embedded GPHYs so this driver should
support a variable number of GPHYs. After the firmware was loaded the
GPHY can be probed on the MDIO bus and it behaves like an external GPHY,
without the firmware it can not be probed on the MDIO bus.

The clock names in the sysctrl.c file have to be changed because the
clocks are now used by a different driver. This should be cleaned up and
a real common clock driver should provide the clocks instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 MAINTAINERS                     |    2 +
 arch/mips/lantiq/xway/sysctrl.c |    8 +-
 drivers/net/dsa/Kconfig         |    8 +
 drivers/net/dsa/Makefile        |    1 +
 drivers/net/dsa/lantiq_gswip.c  | 1169 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h    |  153 +++++
 6 files changed, 1337 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq_gswip.c
 create mode 100644 drivers/net/dsa/lantiq_pce.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ffff912d31b5..5ae7385840e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8172,6 +8172,8 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	net/dsa/tag_gswip.c
 F:	drivers/net/ethernet/lantiq_xrx200.c
+F:	drivers/net/dsa/lantiq_pce.h
+F:	drivers/net/dsa/intel_gswip.c
 
 LANTIQ MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index eeb89a37e27e..fe25c99089b7 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -516,8 +516,8 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0, PMU_SWITCH |
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
-		clkdev_add_pmu("1f203020.gphy", NULL, 1, 0, PMU_GPHY);
-		clkdev_add_pmu("1f203068.gphy", NULL, 1, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.gswip", "gphy0", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.gswip", "gphy1", 0, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "afe", 1, 2, PMU_ANALOG_DSL_AFE);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
@@ -540,8 +540,8 @@ void __init ltq_soc_init(void)
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
-		clkdev_add_pmu("1f203020.gphy", NULL, 0, 0, PMU_GPHY);
-		clkdev_add_pmu("1f203068.gphy", NULL, 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.gswip", "gphy0", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.gswip", "gphy1", 0, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index d3ce1e4cb4d3..7c09d8f195ae 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -23,6 +23,14 @@ config NET_DSA_LOOP
 	  This enables support for a fake mock-up switch chip which
 	  exercises the DSA APIs.
 
+config NET_DSA_LANTIQ_GSWIP
+	tristate "Lantiq / Intel GSWIP"
+	depends on NET_DSA
+	select NET_DSA_TAG_GSWIP
+	---help---
+	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
+	  the xrx200 / VR9 SoC.
+
 config NET_DSA_MT7530
 	tristate "Mediatek MT7530 Ethernet switch support"
 	depends on NET_DSA
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 46c1cba91ffe..82e5d794c41f 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
 ifdef CONFIG_NET_DSA_LOOP
 obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
 endif
+obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
 obj-$(CONFIG_NET_DSA_QCA8K)	+= qca8k.o
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
new file mode 100644
index 000000000000..9c28d0b2fcdb
--- /dev/null
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -0,0 +1,1169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lantiq / Intel GSWIP switch driver for VRX200 SoCs
+ *
+ * Copyright (C) 2010 Lantiq Deutschland
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/clk.h>
+#include <linux/etherdevice.h>
+#include <linux/firmware.h>
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <net/dsa.h>
+#include <dt-bindings/mips/lantiq_rcu_gphy.h>
+
+#include "lantiq_pce.h"
+
+/* GSWIP MDIO Registers */
+#define GSWIP_MDIO_GLOB			0x00
+#define  GSWIP_MDIO_GLOB_ENABLE		BIT(15)
+#define GSWIP_MDIO_CTRL			0x08
+#define  GSWIP_MDIO_CTRL_BUSY		BIT(12)
+#define  GSWIP_MDIO_CTRL_RD		BIT(11)
+#define  GSWIP_MDIO_CTRL_WR		BIT(10)
+#define  GSWIP_MDIO_CTRL_PHYAD_MASK	0x1f
+#define  GSWIP_MDIO_CTRL_PHYAD_SHIFT	5
+#define  GSWIP_MDIO_CTRL_REGAD_MASK	0x1f
+#define GSWIP_MDIO_READ			0x09
+#define GSWIP_MDIO_WRITE		0x0A
+#define GSWIP_MDIO_MDC_CFG0		0x0B
+#define GSWIP_MDIO_MDC_CFG1		0x0C
+#define GSWIP_MDIO_PHYp(p)		(0x15 - (p))
+#define  GSWIP_MDIO_PHY_LINK_MASK	0x6000
+#define  GSWIP_MDIO_PHY_LINK_AUTO	0x0000
+#define  GSWIP_MDIO_PHY_LINK_DOWN	0x4000
+#define  GSWIP_MDIO_PHY_LINK_UP		0x2000
+#define  GSWIP_MDIO_PHY_SPEED_MASK	0x1800
+#define  GSWIP_MDIO_PHY_SPEED_AUTO	0x1800
+#define  GSWIP_MDIO_PHY_SPEED_M10	0x0000
+#define  GSWIP_MDIO_PHY_SPEED_M100	0x0800
+#define  GSWIP_MDIO_PHY_SPEED_G1	0x1000
+#define  GSWIP_MDIO_PHY_FDUP_MASK	0x0600
+#define  GSWIP_MDIO_PHY_FDUP_AUTO	0x0000
+#define  GSWIP_MDIO_PHY_FDUP_EN		0x0200
+#define  GSWIP_MDIO_PHY_FDUP_DIS	0x0600
+#define  GSWIP_MDIO_PHY_FCONTX_MASK	0x0180
+#define  GSWIP_MDIO_PHY_FCONTX_AUTO	0x0000
+#define  GSWIP_MDIO_PHY_FCONTX_EN	0x0100
+#define  GSWIP_MDIO_PHY_FCONTX_DIS	0x0180
+#define  GSWIP_MDIO_PHY_FCONRX_MASK	0x0060
+#define  GSWIP_MDIO_PHY_FCONRX_AUTO	0x0000
+#define  GSWIP_MDIO_PHY_FCONRX_EN	0x0020
+#define  GSWIP_MDIO_PHY_FCONRX_DIS	0x0060
+#define  GSWIP_MDIO_PHY_ADDR_MASK	0x001f
+#define  GSWIP_MDIO_PHY_MASK		(GSWIP_MDIO_PHY_ADDR_MASK | \
+					 GSWIP_MDIO_PHY_FCONRX_MASK | \
+					 GSWIP_MDIO_PHY_FCONTX_MASK | \
+					 GSWIP_MDIO_PHY_LINK_MASK | \
+					 GSWIP_MDIO_PHY_SPEED_MASK | \
+					 GSWIP_MDIO_PHY_FDUP_MASK)
+
+/* GSWIP MII Registers */
+#define GSWIP_MII_CFG0			0x00
+#define GSWIP_MII_CFG1			0x02
+#define GSWIP_MII_CFG5			0x04
+#define  GSWIP_MII_CFG_EN		BIT(14)
+#define  GSWIP_MII_CFG_LDCLKDIS		BIT(12)
+#define  GSWIP_MII_CFG_MODE_MIIP	0x0
+#define  GSWIP_MII_CFG_MODE_MIIM	0x1
+#define  GSWIP_MII_CFG_MODE_RMIIP	0x2
+#define  GSWIP_MII_CFG_MODE_RMIIM	0x3
+#define  GSWIP_MII_CFG_MODE_RGMII	0x4
+#define  GSWIP_MII_CFG_MODE_MASK	0xf
+#define  GSWIP_MII_CFG_RATE_M2P5	0x00
+#define  GSWIP_MII_CFG_RATE_M25	0x10
+#define  GSWIP_MII_CFG_RATE_M125	0x20
+#define  GSWIP_MII_CFG_RATE_M50	0x30
+#define  GSWIP_MII_CFG_RATE_AUTO	0x40
+#define  GSWIP_MII_CFG_RATE_MASK	0x70
+#define GSWIP_MII_PCDU0			0x01
+#define GSWIP_MII_PCDU1			0x03
+#define GSWIP_MII_PCDU5			0x05
+#define  GSWIP_MII_PCDU_TXDLY_MASK	GENMASK(2, 0)
+#define  GSWIP_MII_PCDU_RXDLY_MASK	GENMASK(9, 7)
+
+/* GSWIP Core Registers */
+#define GSWIP_SWRES			0x000
+#define  GSWIP_SWRES_R1			BIT(1)	/* GSWIP Software reset */
+#define  GSWIP_SWRES_R0			BIT(0)	/* GSWIP Hardware reset */
+#define GSWIP_VERSION			0x013
+#define  GSWIP_VERSION_REV_SHIFT	0
+#define  GSWIP_VERSION_REV_MASK		GENMASK(7, 0)
+#define  GSWIP_VERSION_MOD_SHIFT	8
+#define  GSWIP_VERSION_MOD_MASK		GENMASK(15, 8)
+#define   GSWIP_VERSION_2_0		0x100
+#define   GSWIP_VERSION_2_1		0x021
+#define   GSWIP_VERSION_2_2		0x122
+#define   GSWIP_VERSION_2_2_ETC		0x022
+
+#define GSWIP_BM_RAM_VAL(x)		(0x043 - (x))
+#define GSWIP_BM_RAM_ADDR		0x044
+#define GSWIP_BM_RAM_CTRL		0x045
+#define  GSWIP_BM_RAM_CTRL_BAS		BIT(15)
+#define  GSWIP_BM_RAM_CTRL_OPMOD	BIT(5)
+#define  GSWIP_BM_RAM_CTRL_ADDR_MASK	GENMASK(4, 0)
+#define GSWIP_BM_QUEUE_GCTRL		0x04A
+#define  GSWIP_BM_QUEUE_GCTRL_GL_MOD	BIT(10)
+/* buffer management Port Configuration Register */
+#define GSWIP_BM_PCFGp(p)		(0x080 + ((p) * 2))
+#define  GSWIP_BM_PCFG_CNTEN		BIT(0)	/* RMON Counter Enable */
+#define  GSWIP_BM_PCFG_IGCNT		BIT(1)	/* Ingres Special Tag RMON count */
+/* buffer management Port Control Register */
+#define GSWIP_BM_RMON_CTRLp(p)		(0x81 + ((p) * 2))
+#define  GSWIP_BM_CTRL_RMON_RAM1_RES	BIT(0)	/* Software Reset for RMON RAM 1 */
+#define  GSWIP_BM_CTRL_RMON_RAM2_RES	BIT(1)	/* Software Reset for RMON RAM 2 */
+
+/* PCE */
+#define GSWIP_PCE_TBL_KEY(x)		(0x447 - (x))
+#define GSWIP_PCE_TBL_MASK		0x448
+#define GSWIP_PCE_TBL_VAL(x)		(0x44D - (x))
+#define GSWIP_PCE_TBL_ADDR		0x44E
+#define GSWIP_PCE_TBL_CTRL		0x44F
+#define  GSWIP_PCE_TBL_CTRL_BAS		BIT(15)
+#define  GSWIP_PCE_TBL_CTRL_TYPE	BIT(13)
+#define  GSWIP_PCE_TBL_CTRL_VLD		BIT(12)
+#define  GSWIP_PCE_TBL_CTRL_KEYFORM	BIT(11)
+#define  GSWIP_PCE_TBL_CTRL_GMAP_MASK	GENMASK(10, 7)
+#define  GSWIP_PCE_TBL_CTRL_OPMOD_MASK	GENMASK(6, 5)
+#define  GSWIP_PCE_TBL_CTRL_OPMOD_ADRD	0x00
+#define  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR	0x20
+#define  GSWIP_PCE_TBL_CTRL_OPMOD_KSRD	0x40
+#define  GSWIP_PCE_TBL_CTRL_OPMOD_KSWR	0x60
+#define  GSWIP_PCE_TBL_CTRL_ADDR_MASK	GENMASK(4, 0)
+#define GSWIP_PCE_PMAP1			0x453	/* Monitoring port map */
+#define GSWIP_PCE_PMAP2			0x454	/* Default Multicast port map */
+#define GSWIP_PCE_PMAP3			0x455	/* Default Unknown Unicast port map */
+#define GSWIP_PCE_GCTRL_0		0x456
+#define  GSWIP_PCE_GCTRL_0_MC_VALID	BIT(3)
+#define  GSWIP_PCE_GCTRL_0_VLAN		BIT(14) /* VLAN aware Switching */
+#define GSWIP_PCE_GCTRL_1		0x457
+#define  GSWIP_PCE_GCTRL_1_MAC_GLOCK	BIT(2)	/* MAC Address table lock */
+#define  GSWIP_PCE_GCTRL_1_MAC_GLOCK_MOD	BIT(3) /* Mac address table lock forwarding mode */
+#define GSWIP_PCE_PCTRL_0p(p)		(0x480 + ((p) * 0xA))
+#define  GSWIP_PCE_PCTRL_0_INGRESS	BIT(11)
+#define  GSWIP_PCE_PCTRL_0_PSTATE_LISTEN	0x0
+#define  GSWIP_PCE_PCTRL_0_PSTATE_RX		0x1
+#define  GSWIP_PCE_PCTRL_0_PSTATE_TX		0x2
+#define  GSWIP_PCE_PCTRL_0_PSTATE_LEARNING	0x3
+#define  GSWIP_PCE_PCTRL_0_PSTATE_FORWARDING	0x7
+#define  GSWIP_PCE_PCTRL_0_PSTATE_MASK	GENMASK(2, 0)
+
+#define GSWIP_MAC_FLEN			0x8C5
+#define GSWIP_MAC_CTRL_2p(p)		(0x905 + ((p) * 0xC))
+#define GSWIP_MAC_CTRL_2_MLEN		BIT(3) /* Maximum Untagged Frame Lnegth */
+
+/* Ethernet Switch Fetch DMA Port Control Register */
+#define GSWIP_FDMA_PCTRLp(p)		(0xA80 + ((p) * 0x6))
+#define  GSWIP_FDMA_PCTRL_EN		BIT(0)	/* FDMA Port Enable */
+#define  GSWIP_FDMA_PCTRL_STEN		BIT(1)	/* Special Tag Insertion Enable */
+#define  GSWIP_FDMA_PCTRL_VLANMOD_MASK	GENMASK(4, 3)	/* VLAN Modification Control */
+#define  GSWIP_FDMA_PCTRL_VLANMOD_SHIFT	3	/* VLAN Modification Control */
+#define  GSWIP_FDMA_PCTRL_VLANMOD_DIS	(0x0 << GSWIP_FDMA_PCTRL_VLANMOD_SHIFT)
+#define  GSWIP_FDMA_PCTRL_VLANMOD_PRIO	(0x1 << GSWIP_FDMA_PCTRL_VLANMOD_SHIFT)
+#define  GSWIP_FDMA_PCTRL_VLANMOD_ID	(0x2 << GSWIP_FDMA_PCTRL_VLANMOD_SHIFT)
+#define  GSWIP_FDMA_PCTRL_VLANMOD_BOTH	(0x3 << GSWIP_FDMA_PCTRL_VLANMOD_SHIFT)
+
+/* Ethernet Switch Store DMA Port Control Register */
+#define GSWIP_SDMA_PCTRLp(p)		(0xBC0 + ((p) * 0x6))
+#define  GSWIP_SDMA_PCTRL_EN		BIT(0)	/* SDMA Port Enable */
+#define  GSWIP_SDMA_PCTRL_FCEN		BIT(1)	/* Flow Control Enable */
+#define  GSWIP_SDMA_PCTRL_PAUFWD	BIT(1)	/* Pause Frame Forwarding */
+
+#define XRX200_GPHY_FW_ALIGN	(16 * 1024)
+
+struct gswip_hw_info {
+	int max_ports;
+	int cpu_port;
+};
+
+struct xway_gphy_match_data {
+	char *fe_firmware_name;
+	char *ge_firmware_name;
+};
+
+struct gswip_gphy_fw {
+	struct clk *clk_gate;
+	struct reset_control *reset;
+	u32 fw_addr_offset;
+	char *fw_name;
+};
+
+struct gswip_priv {
+	__iomem void *gswip;
+	__iomem void *mdio;
+	__iomem void *mii;
+	const struct gswip_hw_info *hw_info;
+	const struct xway_gphy_match_data *gphy_fw_name_cfg;
+	struct dsa_switch *ds;
+	struct device *dev;
+	struct regmap *rcu_regmap;
+	int num_gphy_fw;
+	struct gswip_gphy_fw *gphy_fw;
+};
+
+struct gswip_rmon_cnt_desc {
+	unsigned int size;
+	unsigned int offset;
+	const char *name;
+};
+
+#define MIB_DESC(_size, _offset, _name) {.size = _size, .offset = _offset, .name = _name}
+
+static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
+	/** Receive Packet Count (only packets that are accepted and not discarded). */
+	MIB_DESC(1, 0x1F, "RxGoodPkts"),
+	MIB_DESC(1, 0x23, "RxUnicastPkts"),
+	MIB_DESC(1, 0x22, "RxMulticastPkts"),
+	MIB_DESC(1, 0x21, "RxFCSErrorPkts"),
+	MIB_DESC(1, 0x1D, "RxUnderSizeGoodPkts"),
+	MIB_DESC(1, 0x1E, "RxUnderSizeErrorPkts"),
+	MIB_DESC(1, 0x1B, "RxOversizeGoodPkts"),
+	MIB_DESC(1, 0x1C, "RxOversizeErrorPkts"),
+	MIB_DESC(1, 0x20, "RxGoodPausePkts"),
+	MIB_DESC(1, 0x1A, "RxAlignErrorPkts"),
+	MIB_DESC(1, 0x12, "Rx64BytePkts"),
+	MIB_DESC(1, 0x13, "Rx127BytePkts"),
+	MIB_DESC(1, 0x14, "Rx255BytePkts"),
+	MIB_DESC(1, 0x15, "Rx511BytePkts"),
+	MIB_DESC(1, 0x16, "Rx1023BytePkts"),
+	/** Receive Size 1024-1522 (or more, if configured) Packet Count. */
+	MIB_DESC(1, 0x17, "RxMaxBytePkts"),
+	MIB_DESC(1, 0x18, "RxDroppedPkts"),
+	MIB_DESC(1, 0x19, "RxFilteredPkts"),
+	MIB_DESC(2, 0x24, "RxGoodBytes"),
+	MIB_DESC(2, 0x26, "RxBadBytes"),
+	MIB_DESC(1, 0x11, "TxAcmDroppedPkts"),
+	MIB_DESC(1, 0x0C, "TxGoodPkts"),
+	MIB_DESC(1, 0x06, "TxUnicastPkts"),
+	MIB_DESC(1, 0x07, "TxMulticastPkts"),
+	MIB_DESC(1, 0x00, "Tx64BytePkts"),
+	MIB_DESC(1, 0x01, "Tx127BytePkts"),
+	MIB_DESC(1, 0x02, "Tx255BytePkts"),
+	MIB_DESC(1, 0x03, "Tx511BytePkts"),
+	MIB_DESC(1, 0x04, "Tx1023BytePkts"),
+	/** Transmit Size 1024-1522 (or more, if configured) Packet Count. */
+	MIB_DESC(1, 0x05, "TxMaxBytePkts"),
+	MIB_DESC(1, 0x08, "TxSingleCollCount"),
+	MIB_DESC(1, 0x09, "TxMultCollCount"),
+	MIB_DESC(1, 0x0A, "TxLateCollCount"),
+	MIB_DESC(1, 0x0B, "TxExcessCollCount"),
+	MIB_DESC(1, 0x0D, "TxPauseCount"),
+	MIB_DESC(1, 0x10, "TxDroppedPkts"),
+	MIB_DESC(2, 0x0E, "TxGoodBytes"),
+};
+
+static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
+{
+	return __raw_readl(priv->gswip + (offset * 4));
+}
+
+static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
+{
+	__raw_writel(val, priv->gswip + (offset * 4));
+}
+
+static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
+			      u32 offset)
+{
+	u32 val = gswip_switch_r(priv, offset);
+
+	val &= ~(clear);
+	val |= set;
+	gswip_switch_w(priv, val, offset);
+}
+
+static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
+				  u32 cleared)
+{
+	u32 val;
+
+	return readx_poll_timeout(__raw_readl, priv->gswip + (offset * 4), val,
+				  (val & cleared) == 0, 20, 50000);
+}
+
+static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
+{
+	return __raw_readl(priv->mdio + (offset * 4));
+}
+
+static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
+{
+	__raw_writel(val, priv->mdio + (offset * 4));
+}
+
+static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
+			    u32 offset)
+{
+	u32 val = gswip_mdio_r(priv, offset);
+
+	val &= ~(clear);
+	val |= set;
+	gswip_mdio_w(priv, val, offset);
+}
+
+static u32 gswip_mii_r(struct gswip_priv *priv, u32 offset)
+{
+	return __raw_readl(priv->mii + (offset * 4));
+}
+
+static void gswip_mii_w(struct gswip_priv *priv, u32 val, u32 offset)
+{
+	__raw_writel(val, priv->mii + (offset * 4));
+}
+
+static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
+			   u32 offset)
+{
+	u32 val = gswip_mii_r(priv, offset);
+
+	val &= ~(clear);
+	val |= set;
+	gswip_mii_w(priv, val, offset);
+}
+
+static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
+			       int port)
+{
+	switch (port) {
+	case 0:
+		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFG0);
+		break;
+	case 1:
+		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFG1);
+		break;
+	case 5:
+		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFG5);
+		break;
+	}
+}
+
+static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
+				int port)
+{
+	switch (port) {
+	case 0:
+		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
+		break;
+	case 1:
+		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU1);
+		break;
+	case 5:
+		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU5);
+		break;
+	}
+}
+
+static int gswip_mdio_poll(struct gswip_priv *priv)
+{
+	int cnt = 100;
+
+	while (likely(cnt--)) {
+		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
+
+		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
+			return 0;
+		usleep_range(20, 40);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
+{
+	struct gswip_priv *priv = bus->priv;
+	int err;
+
+	err = gswip_mdio_poll(priv);
+	if (err) {
+		dev_err(&bus->dev, "waiting for MDIO bus busy timed out\n");
+		return err;
+	}
+
+	gswip_mdio_w(priv, val, GSWIP_MDIO_WRITE);
+	gswip_mdio_w(priv, GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_WR |
+		((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
+		(reg & GSWIP_MDIO_CTRL_REGAD_MASK),
+		GSWIP_MDIO_CTRL);
+
+	return 0;
+}
+
+static int gswip_mdio_rd(struct mii_bus *bus, int addr, int reg)
+{
+	struct gswip_priv *priv = bus->priv;
+	int err;
+
+	err = gswip_mdio_poll(priv);
+	if (err) {
+		dev_err(&bus->dev, "waiting for MDIO bus busy timed out\n");
+		return err;
+	}
+
+	gswip_mdio_w(priv, GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_RD |
+		((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
+		(reg & GSWIP_MDIO_CTRL_REGAD_MASK),
+		GSWIP_MDIO_CTRL);
+
+	err = gswip_mdio_poll(priv);
+	if (err) {
+		dev_err(&bus->dev, "waiting for MDIO bus busy timed out\n");
+		return err;
+	}
+
+	return gswip_mdio_r(priv, GSWIP_MDIO_READ);
+}
+
+static int gswip_mdio(struct gswip_priv *priv, struct device_node *mdio_np)
+{
+	struct dsa_switch *ds = priv->ds;
+
+	ds->slave_mii_bus = devm_mdiobus_alloc(priv->dev);
+	if (!ds->slave_mii_bus)
+		return -ENOMEM;
+
+	ds->slave_mii_bus->priv = priv;
+	ds->slave_mii_bus->read = gswip_mdio_rd;
+	ds->slave_mii_bus->write = gswip_mdio_wr;
+	ds->slave_mii_bus->name = "lantiq,xrx200-mdio";
+	snprintf(ds->slave_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
+		 dev_name(priv->dev));
+	ds->slave_mii_bus->parent = priv->dev;
+	ds->slave_mii_bus->phy_mask = ~ds->phys_mii_mask;
+
+	return of_mdiobus_register(ds->slave_mii_bus, mdio_np);
+}
+
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	/* RMON Counter Enable for port */
+	gswip_switch_w(priv, GSWIP_BM_PCFG_CNTEN, GSWIP_BM_PCFGp(port));
+
+	/* enable port fetch/store dma & VLAN Modification */
+	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_EN |
+				   GSWIP_FDMA_PCTRL_VLANMOD_BOTH,
+			 GSWIP_FDMA_PCTRLp(port));
+	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
+			  GSWIP_SDMA_PCTRLp(port));
+	gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_INGRESS,
+			  GSWIP_PCE_PCTRL_0p(port));
+
+	if (!dsa_is_cpu_port(ds, port)) {
+		u32 macconf = GSWIP_MDIO_PHY_LINK_AUTO |
+			      GSWIP_MDIO_PHY_SPEED_AUTO |
+			      GSWIP_MDIO_PHY_FDUP_AUTO |
+			      GSWIP_MDIO_PHY_FCONTX_AUTO |
+			      GSWIP_MDIO_PHY_FCONRX_AUTO |
+			      (phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK);
+
+		gswip_mdio_w(priv, macconf, GSWIP_MDIO_PHYp(port));
+		/* Activate MDIO auto polling */
+		gswip_mdio_mask(priv, 0, BIT(port), GSWIP_MDIO_MDC_CFG0);
+	}
+
+	return 0;
+}
+
+static void gswip_port_disable(struct dsa_switch *ds, int port,
+			       struct phy_device *phy)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (!dsa_is_cpu_port(ds, port)) {
+		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_LINK_DOWN,
+				GSWIP_MDIO_PHY_LINK_MASK,
+				GSWIP_MDIO_PHYp(port));
+		/* Deactivate MDIO auto polling */
+		gswip_mdio_mask(priv, BIT(port), 0, GSWIP_MDIO_MDC_CFG0);
+	}
+
+	gswip_switch_mask(priv, GSWIP_FDMA_PCTRL_EN, 0,
+			  GSWIP_FDMA_PCTRLp(port));
+	gswip_switch_mask(priv, GSWIP_SDMA_PCTRL_EN, 0,
+			  GSWIP_SDMA_PCTRLp(port));
+}
+
+static int gswip_pce_load_microcode(struct gswip_priv *priv)
+{
+	int i;
+	int err;
+
+	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
+				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR, GSWIP_PCE_TBL_CTRL);
+	gswip_switch_w(priv, 0, GSWIP_PCE_TBL_MASK);
+
+	for (i = 0; i < ARRAY_SIZE(gswip_pce_microcode); i++) {
+		gswip_switch_w(priv, i, GSWIP_PCE_TBL_ADDR);
+		gswip_switch_w(priv, gswip_pce_microcode[i].val_0,
+			       GSWIP_PCE_TBL_VAL(0));
+		gswip_switch_w(priv, gswip_pce_microcode[i].val_1,
+			       GSWIP_PCE_TBL_VAL(1));
+		gswip_switch_w(priv, gswip_pce_microcode[i].val_2,
+			       GSWIP_PCE_TBL_VAL(2));
+		gswip_switch_w(priv, gswip_pce_microcode[i].val_3,
+			       GSWIP_PCE_TBL_VAL(3));
+
+		/* start the table access: */
+		gswip_switch_mask(priv, 0, GSWIP_PCE_TBL_CTRL_BAS,
+				  GSWIP_PCE_TBL_CTRL);
+		err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
+					     GSWIP_PCE_TBL_CTRL_BAS);
+		if (err)
+			return err;
+	}
+
+	/* tell the switch that the microcode is loaded */
+	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_MC_VALID,
+			  GSWIP_PCE_GCTRL_0);
+
+	return 0;
+}
+
+static int gswip_setup(struct dsa_switch *ds)
+{
+	struct gswip_priv *priv = ds->priv;
+	unsigned int cpu_port = priv->hw_info->cpu_port;
+	int i;
+	int err;
+
+	gswip_switch_w(priv, GSWIP_SWRES_R0, GSWIP_SWRES);
+	usleep_range(5000, 10000);
+	gswip_switch_w(priv, 0, GSWIP_SWRES);
+
+	/* disable port fetch/store dma on all ports */
+	for (i = 0; i < priv->hw_info->max_ports; i++)
+		gswip_port_disable(ds, i, NULL);
+
+	/* enable Switch */
+	gswip_mdio_mask(priv, 0, GSWIP_MDIO_GLOB_ENABLE, GSWIP_MDIO_GLOB);
+
+	err = gswip_pce_load_microcode(priv);
+	if (err) {
+		dev_err(priv->dev, "writing PCE microcode failed, %i", err);
+		return err;
+	}
+
+	/* Default unknown Broadcast/Multicast/Unicast port maps */
+	gswip_switch_w(priv, BIT(cpu_port), GSWIP_PCE_PMAP1);
+	gswip_switch_w(priv, BIT(cpu_port), GSWIP_PCE_PMAP2);
+	gswip_switch_w(priv, BIT(cpu_port), GSWIP_PCE_PMAP3);
+
+	/* disable PHY auto polling */
+	gswip_mdio_w(priv, 0x0, GSWIP_MDIO_MDC_CFG0);
+	/* Configure the MDIO Clock 2.5 MHz */
+	gswip_mdio_mask(priv, 0xff, 0x09, GSWIP_MDIO_MDC_CFG1);
+
+	/* Disable the xMII link */
+	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_EN, 0, 0);
+	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_EN, 0, 1);
+	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_EN, 0, 5);
+
+	/* enable special tag insertion on cpu port */
+	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_STEN,
+			  GSWIP_FDMA_PCTRLp(cpu_port));
+
+	gswip_switch_mask(priv, 0, GSWIP_MAC_CTRL_2_MLEN,
+			  GSWIP_MAC_CTRL_2p(cpu_port));
+	gswip_switch_w(priv, VLAN_ETH_FRAME_LEN + 8, GSWIP_MAC_FLEN);
+	gswip_switch_mask(priv, 0, GSWIP_BM_QUEUE_GCTRL_GL_MOD,
+			  GSWIP_BM_QUEUE_GCTRL);
+
+	/* VLAN aware Switching */
+	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_VLAN, GSWIP_PCE_GCTRL_0);
+
+	/* Mac Address Table Lock */
+	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_1_MAC_GLOCK |
+				   GSWIP_PCE_GCTRL_1_MAC_GLOCK_MOD,
+			  GSWIP_PCE_GCTRL_1);
+
+	gswip_port_enable(ds, cpu_port, NULL);
+	return 0;
+}
+
+static enum dsa_tag_protocol gswip_get_tag_protocol(struct dsa_switch *ds,
+						    int port)
+{
+	return DSA_TAG_PROTO_GSWIP;
+}
+
+static void gswip_phylink_validate(struct dsa_switch *ds, int port,
+				   unsigned long *supported,
+				   struct phylink_link_state *state)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
+
+	switch (port) {
+	case 0:
+	case 1:
+		if (!phy_interface_mode_is_rgmii(state->interface) &&
+		    state->interface != PHY_INTERFACE_MODE_MII &&
+		    state->interface != PHY_INTERFACE_MODE_REVMII &&
+		    state->interface != PHY_INTERFACE_MODE_RMII) {
+			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
+			dev_err(ds->dev,
+			"Unsupported interface: %d\n", state->interface);
+			return;
+		}
+		break;
+	case 2:
+	case 3:
+	case 4:
+		if (state->interface != PHY_INTERFACE_MODE_INTERNAL) {
+			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
+			dev_err(ds->dev,
+			"Unsupported interface: %d\n", state->interface);
+			return;
+		}
+		break;
+	case 5:
+		if (!phy_interface_mode_is_rgmii(state->interface) &&
+		    state->interface != PHY_INTERFACE_MODE_INTERNAL) {
+			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
+			dev_err(ds->dev,
+			"Unsupported interface: %d\n", state->interface);
+			return;
+		}
+		break;
+	}
+
+	/* Allow all the expected bits */
+	phylink_set(mask, Autoneg);
+	phylink_set_port_modes(mask);
+	phylink_set(mask, Pause);
+	phylink_set(mask, Asym_Pause);
+
+	/* With the exclusion of MII and Reverse MII, we support Gigabit,
+	 * including Half duplex
+	 */
+	if (state->interface != PHY_INTERFACE_MODE_MII &&
+	    state->interface != PHY_INTERFACE_MODE_REVMII) {
+		phylink_set(mask, 1000baseT_Full);
+		phylink_set(mask, 1000baseT_Half);
+	}
+
+	phylink_set(mask, 10baseT_Half);
+	phylink_set(mask, 10baseT_Full);
+	phylink_set(mask, 100baseT_Half);
+	phylink_set(mask, 100baseT_Full);
+
+	bitmap_and(supported, supported, mask,
+		   __ETHTOOL_LINK_MODE_MASK_NBITS);
+	bitmap_and(state->advertising, state->advertising, mask,
+		   __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
+static void gswip_phylink_mac_config(struct dsa_switch *ds, int port,
+				     unsigned int mode,
+				     const struct phylink_link_state *state)
+{
+	struct gswip_priv *priv = ds->priv;
+	u32 miicfg = 0;
+
+	miicfg |= GSWIP_MII_CFG_LDCLKDIS;
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_INTERNAL:
+		miicfg |= GSWIP_MII_CFG_MODE_MIIM;
+		break;
+	case PHY_INTERFACE_MODE_REVMII:
+		miicfg |= GSWIP_MII_CFG_MODE_MIIP;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		miicfg |= GSWIP_MII_CFG_MODE_RMIIM;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		miicfg |= GSWIP_MII_CFG_MODE_RGMII;
+		break;
+	default:
+		dev_err(ds->dev,
+			"Unsupported interface: %d\n", state->interface);
+		return;
+	}
+	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_MODE_MASK, miicfg, port);
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
+					  GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK, 0, port);
+		break;
+	default:
+		break;
+	}
+}
+
+static void gswip_phylink_mac_link_down(struct dsa_switch *ds, int port,
+					unsigned int mode,
+					phy_interface_t interface)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_EN, 0, port);
+}
+
+static void gswip_phylink_mac_link_up(struct dsa_switch *ds, int port,
+				      unsigned int mode,
+				      phy_interface_t interface,
+				      struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	/* Enable the xMII interface only for the external PHY */
+	if (interface != PHY_INTERFACE_MODE_INTERNAL)
+		gswip_mii_mask_cfg(priv, 0, GSWIP_MII_CFG_EN, port);
+}
+
+static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
+			      uint8_t *data)
+{
+	int i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
+		strncpy(data + i * ETH_GSTRING_LEN, gswip_rmon_cnt[i].name,
+			ETH_GSTRING_LEN);
+}
+
+static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
+				    u32 index)
+{
+	u32 result;
+	int err;
+
+	gswip_switch_w(priv, index, GSWIP_BM_RAM_ADDR);
+	gswip_switch_mask(priv, GSWIP_BM_RAM_CTRL_ADDR_MASK |
+				GSWIP_BM_RAM_CTRL_OPMOD,
+			      table | GSWIP_BM_RAM_CTRL_BAS,
+			      GSWIP_BM_RAM_CTRL);
+
+	err = gswip_switch_r_timeout(priv, GSWIP_BM_RAM_CTRL,
+				     GSWIP_BM_RAM_CTRL_BAS);
+	if (err) {
+		dev_err(priv->dev, "timeout while reading table: %u, index: %u",
+			table, index);
+		return 0;
+	}
+
+	result = gswip_switch_r(priv, GSWIP_BM_RAM_VAL(0));
+	result |= gswip_switch_r(priv, GSWIP_BM_RAM_VAL(1)) << 16;
+
+	return result;
+}
+
+static void gswip_get_ethtool_stats(struct dsa_switch *ds, int port,
+				    uint64_t *data)
+{
+	struct gswip_priv *priv = ds->priv;
+	const struct gswip_rmon_cnt_desc *rmon_cnt;
+	int i;
+	u64 high;
+
+	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++) {
+		rmon_cnt = &gswip_rmon_cnt[i];
+
+		data[i] = gswip_bcm_ram_entry_read(priv, port,
+						   rmon_cnt->offset);
+		if (rmon_cnt->size == 2) {
+			high = gswip_bcm_ram_entry_read(priv, port,
+							rmon_cnt->offset + 1);
+			data[i] |= high << 32;
+		}
+	}
+}
+
+static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	return ARRAY_SIZE(gswip_rmon_cnt);
+}
+
+static const struct dsa_switch_ops gswip_switch_ops = {
+	.get_tag_protocol	= gswip_get_tag_protocol,
+	.setup			= gswip_setup,
+	.port_enable		= gswip_port_enable,
+	.port_disable		= gswip_port_disable,
+	.phylink_validate	= gswip_phylink_validate,
+	.phylink_mac_config	= gswip_phylink_mac_config,
+	.phylink_mac_link_down	= gswip_phylink_mac_link_down,
+	.phylink_mac_link_up	= gswip_phylink_mac_link_up,
+	.get_strings		= gswip_get_strings,
+	.get_ethtool_stats	= gswip_get_ethtool_stats,
+	.get_sset_count		= gswip_get_sset_count,
+};
+
+static const struct xway_gphy_match_data xrx200a1x_gphy_data = {
+	.fe_firmware_name = "lantiq/xrx200_phy22f_a14.bin",
+	.ge_firmware_name = "lantiq/xrx200_phy11g_a14.bin",
+};
+
+static const struct xway_gphy_match_data xrx200a2x_gphy_data = {
+	.fe_firmware_name = "lantiq/xrx200_phy22f_a22.bin",
+	.ge_firmware_name = "lantiq/xrx200_phy11g_a22.bin",
+};
+
+static const struct xway_gphy_match_data xrx300_gphy_data = {
+	.fe_firmware_name = "lantiq/xrx300_phy22f_a21.bin",
+	.ge_firmware_name = "lantiq/xrx300_phy11g_a21.bin",
+};
+
+static const struct of_device_id xway_gphy_match[] = {
+	{ .compatible = "lantiq,xrx200-gphy-fw", .data = NULL },
+	{ .compatible = "lantiq,xrx200a1x-gphy-fw", .data = &xrx200a1x_gphy_data },
+	{ .compatible = "lantiq,xrx200a2x-gphy-fw", .data = &xrx200a2x_gphy_data },
+	{ .compatible = "lantiq,xrx300-gphy-fw", .data = &xrx300_gphy_data },
+	{ .compatible = "lantiq,xrx330-gphy-fw", .data = &xrx300_gphy_data },
+	{},
+};
+
+static int gswip_gphy_fw_load(struct gswip_priv *priv, struct gswip_gphy_fw *gphy_fw)
+{
+	struct device *dev = priv->dev;
+	const struct firmware *fw;
+	void *fw_addr;
+	dma_addr_t dma_addr;
+	dma_addr_t dev_addr;
+	size_t size;
+	int ret;
+
+	ret = clk_prepare_enable(gphy_fw->clk_gate);
+	if (ret)
+		return ret;
+
+	reset_control_assert(gphy_fw->reset);
+
+	ret = request_firmware(&fw, gphy_fw->fw_name, dev);
+	if (ret) {
+		dev_err(dev, "failed to load firmware: %s, error: %i\n",
+			gphy_fw->fw_name, ret);
+		return ret;
+	}
+
+	/* GPHY cores need the firmware code in a persistent and contiguous
+	 * memory area with a 16 kB boundary aligned start address.
+	 */
+	size = fw->size + XRX200_GPHY_FW_ALIGN;
+
+	fw_addr = dmam_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
+	if (fw_addr) {
+		fw_addr = PTR_ALIGN(fw_addr, XRX200_GPHY_FW_ALIGN);
+		dev_addr = ALIGN(dma_addr, XRX200_GPHY_FW_ALIGN);
+		memcpy(fw_addr, fw->data, fw->size);
+	} else {
+		dev_err(dev, "failed to alloc firmware memory\n");
+		release_firmware(fw);
+		return -ENOMEM;
+	}
+
+	release_firmware(fw);
+
+	ret = regmap_write(priv->rcu_regmap, gphy_fw->fw_addr_offset, dev_addr);
+	if (ret)
+		return ret;
+
+	reset_control_deassert(gphy_fw->reset);
+
+	return ret;
+}
+
+static int gswip_gphy_fw_probe(struct gswip_priv *priv,
+			       struct gswip_gphy_fw *gphy_fw,
+			       struct device_node *gphy_fw_np, int i)
+{
+	struct device *dev = priv->dev;
+	u32 gphy_mode;
+	int ret;
+	char gphyname[10];
+
+	snprintf(gphyname, sizeof(gphyname), "gphy%d", i);
+
+	gphy_fw->clk_gate = devm_clk_get(dev, gphyname);
+	if (IS_ERR(gphy_fw->clk_gate)) {
+		dev_err(dev, "Failed to lookup gate clock\n");
+		return PTR_ERR(gphy_fw->clk_gate);
+	}
+
+	ret = of_property_read_u32(gphy_fw_np, "reg", &gphy_fw->fw_addr_offset);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(gphy_fw_np, "lantiq,gphy-mode", &gphy_mode);
+	/* Default to GE mode */
+	if (ret)
+		gphy_mode = GPHY_MODE_GE;
+
+	switch (gphy_mode) {
+	case GPHY_MODE_FE:
+		gphy_fw->fw_name = priv->gphy_fw_name_cfg->fe_firmware_name;
+		break;
+	case GPHY_MODE_GE:
+		gphy_fw->fw_name = priv->gphy_fw_name_cfg->ge_firmware_name;
+		break;
+	default:
+		dev_err(dev, "Unknown GPHY mode %d\n", gphy_mode);
+		return -EINVAL;
+	}
+
+	gphy_fw->reset = of_reset_control_array_get_exclusive(gphy_fw_np);
+	if (IS_ERR(priv->gphy_fw)) {
+		if (PTR_ERR(priv->gphy_fw) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to lookup gphy reset\n");
+		return PTR_ERR(priv->gphy_fw);
+	}
+
+	return gswip_gphy_fw_load(priv, gphy_fw);
+}
+
+static void gswip_gphy_fw_remove(struct gswip_priv *priv,
+				 struct gswip_gphy_fw *gphy_fw)
+{
+	int ret;
+
+	/* check if the device was fully probed */
+	if (!gphy_fw->fw_name)
+		return;
+
+	ret = regmap_write(priv->rcu_regmap, gphy_fw->fw_addr_offset, 0);
+	if (ret)
+		dev_err(priv->dev, "can not reset GPHY FW pointer");
+
+	clk_disable_unprepare(gphy_fw->clk_gate);
+
+	reset_control_put(gphy_fw->reset);
+}
+
+static int gswip_gphy_fw_list(struct gswip_priv *priv,
+			      struct device_node *gphy_fw_list_np, u32 version)
+{
+	struct device *dev = priv->dev;
+	struct device_node *gphy_fw_np;
+	const struct of_device_id *match;
+	int err;
+	int i = 0;
+
+	/* The The VRX200 rev 1.1 uses the GSWIP 2.0 and needs the older
+	 * GPHY firmware. The VRX200 rev 1.2 uses the GSWIP 2.1 and also
+	 * needs a different GPHY firmware.
+	 */
+	if (of_device_is_compatible(gphy_fw_list_np, "lantiq,xrx200-gphy-fw")) {
+		switch (version) {
+		case GSWIP_VERSION_2_0:
+			priv->gphy_fw_name_cfg = &xrx200a1x_gphy_data;
+			break;
+		case GSWIP_VERSION_2_1:
+			priv->gphy_fw_name_cfg = &xrx200a2x_gphy_data;
+			break;
+		default:
+			dev_err(dev, "unknown GSWIP version: 0x%x", version);
+			return -ENOENT;
+		}
+	}
+
+	match = of_match_node(xway_gphy_match, gphy_fw_list_np);
+	if (match && match->data)
+		priv->gphy_fw_name_cfg = match->data;
+
+	if (!priv->gphy_fw_name_cfg) {
+		dev_err(dev, "GPHY compatible type not supported");
+		return -ENOENT;
+	}
+
+	priv->num_gphy_fw = of_get_available_child_count(gphy_fw_list_np);
+	if (!priv->num_gphy_fw)
+		return -ENOENT;
+
+	priv->rcu_regmap = syscon_regmap_lookup_by_phandle(gphy_fw_list_np,
+							   "lantiq,rcu");
+	if (IS_ERR(priv->rcu_regmap))
+		return PTR_ERR(priv->rcu_regmap);
+
+	priv->gphy_fw = devm_kmalloc_array(dev, priv->num_gphy_fw,
+					   sizeof(*priv->gphy_fw),
+					   GFP_KERNEL | __GFP_ZERO);
+	if (!priv->gphy_fw)
+		return -ENOMEM;
+
+	for_each_available_child_of_node(gphy_fw_list_np, gphy_fw_np) {
+		err = gswip_gphy_fw_probe(priv, &priv->gphy_fw[i],
+					  gphy_fw_np, i);
+		if (err)
+			goto remove_gphy;
+		i++;
+	}
+
+	return 0;
+
+remove_gphy:
+	for (i = 0; i < priv->num_gphy_fw; i++)
+		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
+	return err;
+}
+
+static int gswip_probe(struct platform_device *pdev)
+{
+	struct gswip_priv *priv;
+	struct resource *gswip_res, *mdio_res, *mii_res;
+	struct device_node *mdio_np, *gphy_fw_np;
+	struct device *dev = &pdev->dev;
+	int err;
+	int i;
+	u32 version;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	gswip_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->gswip = devm_ioremap_resource(dev, gswip_res);
+	if (!priv->gswip)
+		return -ENOMEM;
+
+	mdio_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	priv->mdio = devm_ioremap_resource(dev, mdio_res);
+	if (!priv->mdio)
+		return -ENOMEM;
+
+	mii_res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	priv->mii = devm_ioremap_resource(dev, mii_res);
+	if (!priv->mii)
+		return -ENOMEM;
+
+	priv->hw_info = of_device_get_match_data(dev);
+	if (!priv->hw_info)
+		return -EINVAL;
+
+	priv->ds = dsa_switch_alloc(dev, priv->hw_info->max_ports);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->priv = priv;
+	priv->ds->ops = &gswip_switch_ops;
+	priv->dev = dev;
+	version = gswip_switch_r(priv, GSWIP_VERSION);
+
+	/* bring up the mdio bus */
+	gphy_fw_np = of_find_compatible_node(pdev->dev.of_node, NULL,
+					     "lantiq,gphy-fw");
+	if (gphy_fw_np) {
+		err = gswip_gphy_fw_list(priv, gphy_fw_np, version);
+		if (err) {
+			dev_err(dev, "gphy fw probe failed\n");
+			return err;
+		}
+	}
+
+	/* bring up the mdio bus */
+	mdio_np = of_find_compatible_node(pdev->dev.of_node, NULL,
+					  "lantiq,xrx200-mdio");
+	if (mdio_np) {
+		err = gswip_mdio(priv, mdio_np);
+		if (err) {
+			dev_err(dev, "mdio probe failed\n");
+			goto gphy_fw;
+		}
+	}
+
+	err = dsa_register_switch(priv->ds);
+	if (err) {
+		dev_err(dev, "dsa switch register failed: %i\n", err);
+		goto mdio_bus;
+	}
+	if (priv->ds->dst->cpu_dp->index != priv->hw_info->cpu_port) {
+		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
+			priv->hw_info->cpu_port);
+		err = -EINVAL;
+		goto mdio_bus;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_info(dev, "probed GSWIP version %lx mod %lx\n",
+		 (version & GSWIP_VERSION_REV_MASK) >> GSWIP_VERSION_REV_SHIFT,
+		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
+	return 0;
+
+mdio_bus:
+	if (mdio_np)
+		mdiobus_unregister(priv->ds->slave_mii_bus);
+gphy_fw:
+	for (i = 0; i < priv->num_gphy_fw; i++)
+		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
+	return err;
+}
+
+static int gswip_remove(struct platform_device *pdev)
+{
+	struct gswip_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	if (!priv)
+		return 0;
+
+	/* disable the switch */
+	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
+
+	dsa_unregister_switch(priv->ds);
+
+	if (priv->ds->slave_mii_bus)
+		mdiobus_unregister(priv->ds->slave_mii_bus);
+
+	for (i = 0; i < priv->num_gphy_fw; i++)
+		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
+
+	return 0;
+}
+
+static const struct gswip_hw_info gswip_xrx200 = {
+	.max_ports = 7,
+	.cpu_port = 6,
+};
+
+static const struct of_device_id gswip_of_match[] = {
+	{ .compatible = "lantiq,xrx200-gswip", .data = &gswip_xrx200 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gswip_of_match);
+
+static struct platform_driver gswip_driver = {
+	.probe = gswip_probe,
+	.remove = gswip_remove,
+	.driver = {
+		.name = "gswip",
+		.of_match_table = gswip_of_match,
+	},
+};
+
+module_platform_driver(gswip_driver);
+
+MODULE_AUTHOR("Hauke Mehrtens <hauke@hauke-m.de>");
+MODULE_DESCRIPTION("Lantiq / Intel GSWIP driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/dsa/lantiq_pce.h b/drivers/net/dsa/lantiq_pce.h
new file mode 100644
index 000000000000..180663138e75
--- /dev/null
+++ b/drivers/net/dsa/lantiq_pce.h
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCE microcode extracted from UGW 7.1.1 switch api
+ *
+ * Copyright (c) 2012, 2014, 2015 Lantiq Deutschland GmbH
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+enum {
+	OUT_MAC0 = 0,
+	OUT_MAC1,
+	OUT_MAC2,
+	OUT_MAC3,
+	OUT_MAC4,
+	OUT_MAC5,
+	OUT_ETHTYP,
+	OUT_VTAG0,
+	OUT_VTAG1,
+	OUT_ITAG0,
+	OUT_ITAG1,	/*10 */
+	OUT_ITAG2,
+	OUT_ITAG3,
+	OUT_IP0,
+	OUT_IP1,
+	OUT_IP2,
+	OUT_IP3,
+	OUT_SIP0,
+	OUT_SIP1,
+	OUT_SIP2,
+	OUT_SIP3,	/*20*/
+	OUT_SIP4,
+	OUT_SIP5,
+	OUT_SIP6,
+	OUT_SIP7,
+	OUT_DIP0,
+	OUT_DIP1,
+	OUT_DIP2,
+	OUT_DIP3,
+	OUT_DIP4,
+	OUT_DIP5,	/*30*/
+	OUT_DIP6,
+	OUT_DIP7,
+	OUT_SESID,
+	OUT_PROT,
+	OUT_APP0,
+	OUT_APP1,
+	OUT_IGMP0,
+	OUT_IGMP1,
+	OUT_IPOFF,	/*39*/
+	OUT_NONE = 63,
+};
+
+/* parser's microcode length type */
+#define INSTR		0
+#define IPV6		1
+#define LENACCU		2
+
+/* parser's microcode flag type */
+enum {
+	FLAG_ITAG = 0,
+	FLAG_VLAN,
+	FLAG_SNAP,
+	FLAG_PPPOE,
+	FLAG_IPV6,
+	FLAG_IPV6FL,
+	FLAG_IPV4,
+	FLAG_IGMP,
+	FLAG_TU,
+	FLAG_HOP,
+	FLAG_NN1,	/*10 */
+	FLAG_NN2,
+	FLAG_END,
+	FLAG_NO,	/*13*/
+};
+
+struct gswip_pce_microcode {
+	u16 val_3;
+	u16 val_2;
+	u16 val_1;
+	u16 val_0;
+};
+
+#define MC_ENTRY(val, msk, ns, out, len, type, flags, ipv4_len) \
+	{ val, msk, ((ns) << 10 | (out) << 4 | (len) >> 1),\
+		((len) & 1) << 15 | (type) << 13 | (flags) << 9 | (ipv4_len) << 8 }
+static const struct gswip_pce_microcode gswip_pce_microcode[] = {
+	/*      value    mask    ns  fields      L  type     flags       ipv4_len */
+	MC_ENTRY(0x88c3, 0xFFFF,  1, OUT_ITAG0,  4, INSTR,   FLAG_ITAG,  0),
+	MC_ENTRY(0x8100, 0xFFFF,  2, OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
+	MC_ENTRY(0x88A8, 0xFFFF,  1, OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
+	MC_ENTRY(0x8100, 0xFFFF,  1, OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
+	MC_ENTRY(0x8864, 0xFFFF, 17, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0800, 0xFFFF, 21, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x86DD, 0xFFFF, 22, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x8863, 0xFFFF, 16, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0xF800, 10, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 40, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0600, 0x0600, 40, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 12, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0xAAAA, 0xFFFF, 14, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0300, 0xFF00, 41, OUT_NONE,   0, INSTR,   FLAG_SNAP,  0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_DIP7,   3, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 18, OUT_DIP7,   3, INSTR,   FLAG_PPPOE, 0),
+	MC_ENTRY(0x0021, 0xFFFF, 21, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0057, 0xFFFF, 22, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 40, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x4000, 0xF000, 24, OUT_IP0,    4, INSTR,   FLAG_IPV4,  1),
+	MC_ENTRY(0x6000, 0xF000, 27, OUT_IP0,    3, INSTR,   FLAG_IPV6,  0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 25, OUT_IP3,    2, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 26, OUT_SIP0,   4, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 40, OUT_NONE,   0, LENACCU, FLAG_NO,    0),
+	MC_ENTRY(0x1100, 0xFF00, 39, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0600, 0xFF00, 39, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0xFF00, 33, OUT_IP3,   17, INSTR,   FLAG_HOP,   0),
+	MC_ENTRY(0x2B00, 0xFF00, 33, OUT_IP3,   17, INSTR,   FLAG_NN1,   0),
+	MC_ENTRY(0x3C00, 0xFF00, 33, OUT_IP3,   17, INSTR,   FLAG_NN2,   0),
+	MC_ENTRY(0x0000, 0x0000, 39, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x00E0, 35, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 40, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0xFF00, 33, OUT_NONE,   0, IPV6,    FLAG_HOP,   0),
+	MC_ENTRY(0x2B00, 0xFF00, 33, OUT_NONE,   0, IPV6,    FLAG_NN1,   0),
+	MC_ENTRY(0x3C00, 0xFF00, 33, OUT_NONE,   0, IPV6,    FLAG_NN2,   0),
+	MC_ENTRY(0x0000, 0x0000, 40, OUT_PROT,   1, IPV6,    FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 40, OUT_SIP0,  16, INSTR,   FLAG_NO,    0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_APP0,   4, INSTR,   FLAG_IGMP,  0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+};
-- 
2.11.0
