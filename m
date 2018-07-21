Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 21:15:28 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:50550 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993256AbeGUTOlG1SRY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Jul 2018 21:14:41 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id BC7DE47CB6;
        Sat, 21 Jul 2018 21:14:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Qg8sRKzyItpm; Sat, 21 Jul 2018 21:14:32 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] net: dsa: Add Lantiq / Intel DSA driver for vrx200
Date:   Sat, 21 Jul 2018 21:13:58 +0200
Message-Id: <20180721191358.13952-5-hauke@hauke-m.de>
In-Reply-To: <20180721191358.13952-1-hauke@hauke-m.de>
References: <20180721191358.13952-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65025
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
2.0, there are other SoCs using different versions of this IP block, but
this driver was only tested with the version found in the VRX200.
Currently only the basic features are implemented which will forward all
packages to the CPU and let the CPU do the forwarding. The hardware also
support Layer 2 offloading which is not yet implemented in this driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 MAINTAINERS                    |   1 +
 drivers/net/dsa/Kconfig        |   8 +
 drivers/net/dsa/Makefile       |   1 +
 drivers/net/dsa/lantiq-gswip.c | 750 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h   | 153 +++++++++
 5 files changed, 913 insertions(+)
 create mode 100644 drivers/net/dsa/lantiq-gswip.c
 create mode 100644 drivers/net/dsa/lantiq_pce.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0607a58c51..761446ff9dd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8016,6 +8016,7 @@ S:	Maintained
 F:	net/dsa/tag_gswip.c
 F:	drivers/net/ethernet/lantiq_xrx200.c
 F:	drivers/net/dsa/lantiq_pce.h
+F:	drivers/net/dsa/intel-gswip.c
 
 LANTIQ MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 2b81b97e994f..f1280aa3f9bd 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -23,6 +23,14 @@ config NET_DSA_LOOP
 	  This enables support for a fake mock-up switch chip which
 	  exercises the DSA APIs.
 
+config NET_DSA_GSWIP
+	tristate "Intel / Lantiq GSWIP"
+	depends on NET_DSA
+	select NET_DSA_TAG_GSWIP
+	---help---
+	  This enables support for the Intel / Lantiq GSWIP 2.0 found in
+	  the xrx200 / VR9 SoC.
+
 config NET_DSA_MT7530
 	tristate "Mediatek MT7530 Ethernet switch support"
 	depends on NET_DSA
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 15c2a831edf1..11143d860a95 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
 ifdef CONFIG_NET_DSA_LOOP
 obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
 endif
+obj-$(CONFIG_NET_DSA_GSWIP)	+= lantiq-gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
 obj-$(CONFIG_NET_DSA_QCA8K)	+= qca8k.o
diff --git a/drivers/net/dsa/lantiq-gswip.c b/drivers/net/dsa/lantiq-gswip.c
new file mode 100644
index 000000000000..b6e64ba7ff12
--- /dev/null
+++ b/drivers/net/dsa/lantiq-gswip.c
@@ -0,0 +1,750 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lantiq / Intel GSWIP switch driver for VRX200 SoCs
+ *
+ * Copyright (C) 2010 Lantiq Deutschland
+ * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/if_vlan.h>
+#include <linux/if_bridge.h>
+#include <net/dsa.h>
+
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+#include <linux/of_platform.h>
+#include <linux/version.h>
+
+#include "lantiq_pce.h"
+
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
+#define  GSWIP_MDIO_PHY_LINK_DOWN	0x4000
+#define  GSWIP_MDIO_PHY_LINK_UP		0x2000
+#define  GSWIP_MDIO_PHY_SPEED_M10	0x0000
+#define  GSWIP_MDIO_PHY_SPEED_M100	0x0800
+#define  GSWIP_MDIO_PHY_SPEED_G1	0x1000
+#define  GSWIP_MDIO_PHY_FDUP_EN		0x0200
+#define  GSWIP_MDIO_PHY_FDUP_DIS	0x0600
+#define  GSWIP_MDIO_PHY_FCONTX_EN	0x0100
+#define  GSWIP_MDIO_PHY_FCONTX_DIS	0x0180
+#define  GSWIP_MDIO_PHY_FCONRX_EN	0x0020
+#define  GSWIP_MDIO_PHY_FCONRX_DIS	0x0060
+#define  GSWIP_MDIO_PHY_LINK_MASK	0x6000
+#define  GSWIP_MDIO_PHY_SPEED_MASK	0x1800
+#define  GSWIP_MDIO_PHY_FDUP_MASK	0x0600
+#define  GSWIP_MDIO_PHY_FCONTX_MASK	0x0180
+#define  GSWIP_MDIO_PHY_FCONRX_MASK	0x0060
+#define  GSWIP_MDIO_PHY_ADDR_MASK	0x001f
+#define  GSWIP_MDIO_PHY_MASK		(GSWIP_MDIO_PHY_ADDR_MASK | \
+					 GSWIP_MDIO_PHY_FCONRX_MASK | \
+					 GSWIP_MDIO_PHY_FCONTX_MASK | \
+					 GSWIP_MDIO_PHY_LINK_MASK | \
+					 GSWIP_MDIO_PHY_SPEED_MASK | \
+					 GSWIP_MDIO_PHY_FDUP_MASK)
+
+/* GSWIP MII Registers */
+#define GSWIP_MII_CFGp(p)		((p) * 2)
+#define  GSWIP_MII_CFG_EN		BIT(14)
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
+
+/* GSWIP Core Registers */
+#define GSWIP_ETHSW_SWRES		0x000
+#define  GSWIP_ETHSW_SWRES_R1		BIT(1)	/* GSWIP Software reset */
+#define  GSWIP_ETHSW_SWRES_R0		BIT(0)	/* GSWIP Hardware reset */
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
+struct gswip_priv {
+	__iomem void *gswip;
+	__iomem void *mdio;
+	__iomem void *mii;
+	int cpu_port;
+	struct dsa_switch *ds;
+	struct device *dev;
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
+	/** Receive Unicast Packet Count. */
+	MIB_DESC(1, 0x23, "RxUnicastPkts"),
+	/** Receive Multicast Packet Count. */
+	MIB_DESC(1, 0x22, "RxMulticastPkts"),
+	/** Receive FCS Error Packet Count. */
+	MIB_DESC(1, 0x21, "RxFCSErrorPkts"),
+	/** Receive Undersize Good Packet Count. */
+	MIB_DESC(1, 0x1D, "RxUnderSizeGoodPkts"),
+	/** Receive Undersize Error Packet Count. */
+	MIB_DESC(1, 0x1E, "RxUnderSizeErrorPkts"),
+	/** Receive Oversize Good Packet Count. */
+	MIB_DESC(1, 0x1B, "RxOversizeGoodPkts"),
+	/** Receive Oversize Error Packet Count. */
+	MIB_DESC(1, 0x1C, "RxOversizeErrorPkts"),
+	/** Receive Good Pause Packet Count. */
+	MIB_DESC(1, 0x20, "RxGoodPausePkts"),
+	/** Receive Align Error Packet Count. */
+	MIB_DESC(1, 0x1A, "RxAlignErrorPkts"),
+	/** Receive Size 64 Packet Count. */
+	MIB_DESC(1, 0x12, "Rx64BytePkts"),
+	/** Receive Size 65-127 Packet Count. */
+	MIB_DESC(1, 0x13, "Rx127BytePkts"),
+	/** Receive Size 128-255 Packet Count. */
+	MIB_DESC(1, 0x14, "Rx255BytePkts"),
+	/** Receive Size 256-511 Packet Count. */
+	MIB_DESC(1, 0x15, "Rx511BytePkts"),
+	/** Receive Size 512-1023 Packet Count. */
+	MIB_DESC(1, 0x16, "Rx1023BytePkts"),
+	/** Receive Size 1024-1522 (or more, if configured) Packet Count. */
+	MIB_DESC(1, 0x17, "RxMaxBytePkts"),
+	/** Receive Dropped Packet Count. */
+	MIB_DESC(1, 0x18, "RxDroppedPkts"),
+	/** Filtered Packet Count. */
+	MIB_DESC(1, 0x19, "RxFilteredPkts"),
+	/** Receive Good Byte Count (64 bit). */
+	MIB_DESC(2, 0x24, "RxGoodBytes"),
+	/** Receive Bad Byte Count (64 bit). */
+	MIB_DESC(2, 0x26, "RxBadBytes"),
+	/** Transmit Dropped Packet Count, based on Congestion Management. */
+	MIB_DESC(1, 0x11, "TxAcmDroppedPkts"),
+	/** Transmit Packet Count. */
+	MIB_DESC(1, 0x0C, "TxGoodPkts"),
+	/** Transmit Unicast Packet Count. */
+	MIB_DESC(1, 0x06, "TxUnicastPkts"),
+	/** Transmit Multicast Packet Count. */
+	MIB_DESC(1, 0x07, "TxMulticastPkts"),
+	/** Transmit Size 64 Packet Count. */
+	MIB_DESC(1, 0x00, "Tx64BytePkts"),
+	/** Transmit Size 65-127 Packet Count. */
+	MIB_DESC(1, 0x01, "Tx127BytePkts"),
+	/** Transmit Size 128-255 Packet Count. */
+	MIB_DESC(1, 0x02, "Tx255BytePkts"),
+	/** Transmit Size 256-511 Packet Count. */
+	MIB_DESC(1, 0x03, "Tx511BytePkts"),
+	/** Transmit Size 512-1023 Packet Count. */
+	MIB_DESC(1, 0x04, "Tx1023BytePkts"),
+	/** Transmit Size 1024-1522 (or more, if configured) Packet Count. */
+	MIB_DESC(1, 0x05, "TxMaxBytePkts"),
+	/** Transmit Single Collision Count. */
+	MIB_DESC(1, 0x08, "TxSingleCollCount"),
+	/** Transmit Multiple Collision Count. */
+	MIB_DESC(1, 0x09, "TxMultCollCount"),
+	/** Transmit Late Collision Count. */
+	MIB_DESC(1, 0x0A, "TxLateCollCount"),
+	/** Transmit Excessive Collision Count. */
+	MIB_DESC(1, 0x0B, "TxExcessCollCount"),
+	/** Transmit Pause Packet Count. */
+	MIB_DESC(1, 0x0D, "TxPauseCount"),
+	/** Transmit Drop Packet Count. */
+	MIB_DESC(1, 0x10, "TxDroppedPkts"),
+	/** Transmit Good Byte Count (64 bit). */
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
+	return __raw_writel(val, priv->gswip + (offset * 4));
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
+static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
+{
+	return __raw_readl(priv->mdio + (offset * 4));
+}
+
+static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
+{
+	return __raw_writel(val, priv->mdio + (offset * 4));
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
+	return __raw_writel(val, priv->mii + (offset * 4));
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
+static int xrx200_mdio_poll(struct gswip_priv *priv)
+{
+	int cnt = 10000;
+
+	while (likely(cnt--)) {
+		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
+
+		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
+			return 0;
+		cpu_relax();
+	}
+
+	return 1;
+}
+
+static int xrx200_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
+{
+	struct gswip_priv *priv = bus->priv;
+
+	if (xrx200_mdio_poll(priv))
+		return -EIO;
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
+static int xrx200_mdio_rd(struct mii_bus *bus, int addr, int reg)
+{
+	struct gswip_priv *priv = bus->priv;
+
+	if (xrx200_mdio_poll(priv))
+		return -EIO;
+
+	gswip_mdio_w(priv, GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_RD |
+		((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
+		(reg & GSWIP_MDIO_CTRL_REGAD_MASK),
+		GSWIP_MDIO_CTRL);
+
+	if (xrx200_mdio_poll(priv))
+		return -EIO;
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
+	ds->slave_mii_bus->read = xrx200_mdio_rd;
+	ds->slave_mii_bus->write = xrx200_mdio_wr;
+	ds->slave_mii_bus->name = "lantiq,xrx200-mdio";
+	snprintf(ds->slave_mii_bus->id, MII_BUS_ID_SIZE, "%x", 0);
+	ds->slave_mii_bus->parent = priv->dev;
+	ds->slave_mii_bus->phy_mask = ~ds->phys_mii_mask;
+
+	return of_mdiobus_register(ds->slave_mii_bus, mdio_np);
+}
+
+static void gswip_wait_pce_tbl_ready(struct gswip_priv *priv)
+{
+	while (gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL) & GSWIP_PCE_TBL_CTRL_BAS)
+		cond_resched();
+}
+
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phy)
+{
+	struct gswip_priv *priv = (struct gswip_priv *)ds->priv;
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
+	return 0;
+}
+
+static void gswip_port_disable(struct dsa_switch *ds, int port,
+			       struct phy_device *phy)
+{
+	struct gswip_priv *priv = (struct gswip_priv *)ds->priv;
+
+	gswip_switch_mask(priv, GSWIP_FDMA_PCTRL_EN, 0,
+			  GSWIP_FDMA_PCTRLp(port));
+	gswip_switch_mask(priv, GSWIP_SDMA_PCTRL_EN, 0,
+			  GSWIP_SDMA_PCTRLp(port));
+}
+
+static void xrx200_pci_microcode(struct gswip_priv *priv)
+{
+	int i;
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
+		// start the table access:
+		gswip_switch_mask(priv, 0, GSWIP_PCE_TBL_CTRL_BAS,
+				  GSWIP_PCE_TBL_CTRL);
+		gswip_wait_pce_tbl_ready(priv);
+	}
+
+	/* tell the switch that the microcode is loaded */
+	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_MC_VALID,
+			  GSWIP_PCE_GCTRL_0);
+}
+
+static int gswip_setup(struct dsa_switch *ds)
+{
+	struct gswip_priv *priv = ds->priv;
+	int i;
+
+	gswip_switch_w(priv, GSWIP_ETHSW_SWRES_R0, GSWIP_ETHSW_SWRES);
+	usleep_range(5000, 10000);
+	gswip_switch_w(priv, 0, GSWIP_ETHSW_SWRES);
+
+	/* disable port fetch/store dma, assume CPU port is last port */
+	for (i = 0; i <= priv->cpu_port; i++)
+		gswip_port_disable(ds, i, NULL);
+
+	/* enable Switch */
+	gswip_mdio_mask(priv, 0, GSWIP_MDIO_GLOB_ENABLE, GSWIP_MDIO_GLOB);
+
+	xrx200_pci_microcode(priv);
+
+	/* Default unknown Broadcast/Multicast/Unicast port maps */
+	gswip_switch_w(priv, BIT(priv->cpu_port), GSWIP_PCE_PMAP1);
+	gswip_switch_w(priv, BIT(priv->cpu_port), GSWIP_PCE_PMAP2);
+	gswip_switch_w(priv, BIT(priv->cpu_port), GSWIP_PCE_PMAP3);
+
+	/* disable auto polling */
+	gswip_mdio_w(priv, 0x0, GSWIP_MDIO_MDC_CFG0);
+
+	/* enable special tag insertion on cpu port */
+	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_STEN,
+			  GSWIP_FDMA_PCTRLp(priv->cpu_port));
+
+	gswip_switch_mask(priv, 0, GSWIP_MAC_CTRL_2_MLEN,
+			  GSWIP_MAC_CTRL_2p(priv->cpu_port));
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
+	gswip_port_enable(ds, priv->cpu_port, NULL);
+	return 0;
+}
+
+static void gswip_adjust_link(struct dsa_switch *ds, int port,
+			      struct phy_device *phydev)
+{
+	struct gswip_priv *priv = (struct gswip_priv *)ds->priv;
+	u16 phyaddr = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
+	u16 miirate = 0;
+	u16 miimode;
+	u16 lcl_adv = 0, rmt_adv = 0;
+	u8 flowctrl;
+
+	/* do not run this for the CPU port 6 */
+	if (port >= priv->cpu_port)
+		return;
+
+	miimode = gswip_mdio_r(priv, GSWIP_MII_CFGp(port));
+	miimode &= GSWIP_MII_CFG_MODE_MASK;
+
+	switch (phydev->speed) {
+	case SPEED_1000:
+		phyaddr |= GSWIP_MDIO_PHY_SPEED_G1;
+		miirate = GSWIP_MII_CFG_RATE_M125;
+		break;
+
+	case SPEED_100:
+		phyaddr |= GSWIP_MDIO_PHY_SPEED_M100;
+		switch (miimode) {
+		case GSWIP_MII_CFG_MODE_RMIIM:
+		case GSWIP_MII_CFG_MODE_RMIIP:
+			miirate = GSWIP_MII_CFG_RATE_M50;
+			break;
+		default:
+			miirate = GSWIP_MII_CFG_RATE_M25;
+			break;
+		}
+		break;
+
+	default:
+		phyaddr |= GSWIP_MDIO_PHY_SPEED_M10;
+		miirate = GSWIP_MII_CFG_RATE_M2P5;
+		break;
+	}
+
+	if (phydev->link)
+		phyaddr |= GSWIP_MDIO_PHY_LINK_UP;
+	else
+		phyaddr |= GSWIP_MDIO_PHY_LINK_DOWN;
+
+	if (phydev->duplex == DUPLEX_FULL)
+		phyaddr |= GSWIP_MDIO_PHY_FDUP_EN;
+	else
+		phyaddr |= GSWIP_MDIO_PHY_FDUP_DIS;
+
+	if (phydev->pause)
+		rmt_adv = LPA_PAUSE_CAP;
+	if (phydev->asym_pause)
+		rmt_adv |= LPA_PAUSE_ASYM;
+
+	if (phydev->advertising & ADVERTISED_Pause)
+		lcl_adv |= ADVERTISE_PAUSE_CAP;
+	if (phydev->advertising & ADVERTISED_Asym_Pause)
+		lcl_adv |= ADVERTISE_PAUSE_ASYM;
+
+	flowctrl = mii_resolve_flowctrl_fdx(lcl_adv, rmt_adv);
+
+	if (flowctrl & FLOW_CTRL_TX)
+		phyaddr |= GSWIP_MDIO_PHY_FCONTX_EN;
+	else
+		phyaddr |= GSWIP_MDIO_PHY_FCONTX_DIS;
+	if (flowctrl & FLOW_CTRL_RX)
+		phyaddr |= GSWIP_MDIO_PHY_FCONRX_EN;
+	else
+		phyaddr |= GSWIP_MDIO_PHY_FCONRX_DIS;
+
+	gswip_mdio_mask(priv, GSWIP_MDIO_PHY_MASK, phyaddr,
+			GSWIP_MDIO_PHYp(port));
+	gswip_mii_mask(priv, GSWIP_MII_CFG_RATE_MASK, miirate,
+		       GSWIP_MII_CFGp(port));
+}
+
+static enum dsa_tag_protocol gswip_get_tag_protocol(struct dsa_switch *ds,
+						    int port)
+{
+	return DSA_TAG_PROTO_GSWIP;
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
+
+	gswip_switch_w(priv, index, GSWIP_BM_RAM_ADDR);
+	gswip_switch_mask(priv, GSWIP_BM_RAM_CTRL_ADDR_MASK |
+				GSWIP_BM_RAM_CTRL_OPMOD,
+			      table | GSWIP_BM_RAM_CTRL_BAS,
+			      GSWIP_BM_RAM_CTRL);
+
+	while (gswip_switch_r(priv, GSWIP_BM_RAM_CTRL) & GSWIP_BM_RAM_CTRL_BAS)
+		cond_resched();
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
+	.adjust_link		= gswip_adjust_link,
+	.port_enable		= gswip_port_enable,
+	.port_disable		= gswip_port_disable,
+	.get_strings		= gswip_get_strings,
+	.get_ethtool_stats	= gswip_get_ethtool_stats,
+	.get_sset_count		= gswip_get_sset_count,
+};
+
+static int gswip_probe(struct platform_device *pdev)
+{
+	struct gswip_priv *priv;
+	struct resource *gswip_res, *mdio_res, *mii_res;
+	struct device_node *mdio_np;
+	struct device *dev = &pdev->dev;
+	int err;
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
+	priv->ds = dsa_switch_alloc(dev, DSA_MAX_PORTS);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->priv = priv;
+	priv->ds->ops = &gswip_switch_ops;
+	priv->dev = dev;
+	priv->cpu_port = 6;
+
+	/* bring up the mdio bus */
+	mdio_np = of_find_compatible_node(pdev->dev.of_node, NULL,
+					  "lantiq,xrx200-mdio");
+	if (mdio_np) {
+		err = gswip_mdio(priv, mdio_np);
+		if (err) {
+			dev_err(dev, "mdio probe failed\n");
+			return err;
+		}
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	err = dsa_register_switch(priv->ds);
+	if (err) {
+		dev_err(dev, "dsa switch register failed: %i\n", err);
+		if (mdio_np)
+			mdiobus_unregister(priv->ds->slave_mii_bus);
+	}
+
+	return err;
+}
+
+static int gswip_remove(struct platform_device *pdev)
+{
+	struct gswip_priv *priv = platform_get_drvdata(pdev);
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
+	return 0;
+}
+
+static const struct of_device_id gswip_of_match[] = {
+	{ .compatible = "lantiq,xrx200-gswip" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xrx200_match);
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
+MODULE_DESCRIPTION("Intel / Lantiq GSWIP driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/dsa/lantiq_pce.h b/drivers/net/dsa/lantiq_pce.h
new file mode 100644
index 000000000000..aa57d9fe7089
--- /dev/null
+++ b/drivers/net/dsa/lantiq_pce.h
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCE microcode extracted from UGW 7.1.1 switch api
+ *
+ * Copyright (c) 2012, 2014, 2015 Lantiq Deutschland GmbH
+ * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
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
+	{ val, msk, (ns << 10 | out << 4 | len >> 1),\
+		(len & 1) << 15 | type << 13 | flags << 9 | ipv4_len << 8 }
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
