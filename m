Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:29:30 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45099 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009469AbcACP1RZ7L17 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:27:17 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5DD5228C06D;
        Sun,  3 Jan 2016 16:26:45 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:45 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <blogic@openwrt.org>,
        Felix Fietkau <nbd@nbd.name>, Michael Lee <igvtee@gmail.com>,
        =?UTF-8?q?Steven=20Liu=20=28=E5=8A=89=E4=BA=BA=E8=B1=AA=29?= 
        <steven.liu@mediatek.com>,
        =?UTF-8?q?Fred=20Chang=20=28=E5=BC=B5=E5=98=89=E5=AE=8F=29?= 
        <Fred.Chang@mediatek.com>
Subject: [PATCH 10/12] net-next: mediatek: add support for mt7621
Date:   Sun,  3 Jan 2016 16:26:13 +0100
Message-Id: <1451834775-15789-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add support for SoCs from the mt7621 family. These all have 2 GMAC ports,
both of which are attached to the same internal 1000MBit switch. Currently
we only support GMAC1 as the sole CPU port.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
---
 drivers/net/ethernet/mediatek/soc_mt7621.c |  162 ++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/soc_mt7621.c

diff --git a/drivers/net/ethernet/mediatek/soc_mt7621.c b/drivers/net/ethernet/mediatek/soc_mt7621.c
new file mode 100644
index 0000000..4f4141c
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/soc_mt7621.c
@@ -0,0 +1,162 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2015 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/if_vlan.h>
+#include <linux/of_net.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+#include "mt7530.h"
+#include "mdio.h"
+
+#define MT7620A_CDMA_CSG_CFG	0x400
+#define MT7621_CDMP_IG_CTRL	(MT7620A_CDMA_CSG_CFG + 0x00)
+#define MT7621_CDMP_EG_CTRL	(MT7620A_CDMA_CSG_CFG + 0x04)
+#define MT7621_RESET_FE		BIT(6)
+#define MT7621_L4_VALID		BIT(24)
+
+#define MT7621_TX_DMA_UDF	BIT(19)
+#define MT7621_TX_DMA_FPORT	BIT(25)
+
+#define CDMA_ICS_EN		BIT(2)
+#define CDMA_UCS_EN		BIT(1)
+#define CDMA_TCS_EN		BIT(0)
+
+#define GDMA_ICS_EN		BIT(22)
+#define GDMA_TCS_EN		BIT(21)
+#define GDMA_UCS_EN		BIT(20)
+
+/* frame engine counters */
+#define MT7621_REG_MIB_OFFSET	0x2000
+#define MT7621_PPE_AC_BCNT0	(MT7621_REG_MIB_OFFSET + 0x00)
+#define MT7621_GDM1_TX_GBCNT	(MT7621_REG_MIB_OFFSET + 0x400)
+#define MT7621_GDM2_TX_GBCNT	(MT7621_GDM1_TX_GBCNT + 0x40)
+
+#define GSW_REG_GDMA1_MAC_ADRL	0x508
+#define GSW_REG_GDMA1_MAC_ADRH	0x50C
+
+#define MT7621_FE_RST_GL	(FE_FE_OFFSET + 0x04)
+#define MT7620_FE_INT_STATUS2	(FE_FE_OFFSET + 0x08)
+
+/* FE_INT_STATUS reg on mt7620 define CNT_GDM1_AF at BIT(29)
+ * but after test it should be BIT(13).
+ */
+#define MT7621_FE_GDM1_AF	BIT(28)
+#define MT7621_FE_GDM2_AF	BIT(29)
+
+static const u16 mt7621_reg_table[FE_REG_COUNT] = {
+	[FE_REG_PDMA_GLO_CFG] = RT5350_PDMA_GLO_CFG,
+	[FE_REG_PDMA_RST_CFG] = RT5350_PDMA_RST_CFG,
+	[FE_REG_DLY_INT_CFG] = RT5350_DLY_INT_CFG,
+	[FE_REG_TX_BASE_PTR0] = RT5350_TX_BASE_PTR0,
+	[FE_REG_TX_MAX_CNT0] = RT5350_TX_MAX_CNT0,
+	[FE_REG_TX_CTX_IDX0] = RT5350_TX_CTX_IDX0,
+	[FE_REG_TX_DTX_IDX0] = RT5350_TX_DTX_IDX0,
+	[FE_REG_RX_BASE_PTR0] = RT5350_RX_BASE_PTR0,
+	[FE_REG_RX_MAX_CNT0] = RT5350_RX_MAX_CNT0,
+	[FE_REG_RX_CALC_IDX0] = RT5350_RX_CALC_IDX0,
+	[FE_REG_RX_DRX_IDX0] = RT5350_RX_DRX_IDX0,
+	[FE_REG_FE_INT_ENABLE] = RT5350_FE_INT_ENABLE,
+	[FE_REG_FE_INT_STATUS] = RT5350_FE_INT_STATUS,
+	[FE_REG_FE_DMA_VID_BASE] = 0,
+	[FE_REG_FE_COUNTER_BASE] = MT7621_GDM1_TX_GBCNT,
+	[FE_REG_FE_RST_GL] = MT7621_FE_RST_GL,
+	[FE_REG_FE_INT_STATUS2] = MT7620_FE_INT_STATUS2,
+};
+
+static int mt7621_gsw_config(struct fe_priv *priv)
+{
+	if (priv->mii_bus && priv->mii_bus->phy_map[0x1f])
+		mt7530_probe(priv->device, NULL, priv->mii_bus, 1);
+
+	return 0;
+}
+
+static void mt7621_fe_reset(void)
+{
+	fe_reset(MT7621_RESET_FE);
+}
+
+static int mt7621_fwd_config(struct fe_priv *priv)
+{
+	/* Setup GMAC1 only, there is no support for GMAC2 yet */
+	fe_w32(fe_r32(MT7620A_GDMA1_FWD_CFG) & ~0xffff,
+	       MT7620A_GDMA1_FWD_CFG);
+
+	/* Enable RX checksum */
+	fe_w32(fe_r32(MT7620A_GDMA1_FWD_CFG) | (GDMA_ICS_EN |
+		       GDMA_TCS_EN | GDMA_UCS_EN),
+		       MT7620A_GDMA1_FWD_CFG);
+	/* Enable RX VLan Offloading */
+	fe_w32(1, MT7621_CDMP_EG_CTRL);
+
+	return 0;
+}
+
+static void mt7621_init_data(struct fe_soc_data *data,
+			     struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+
+	priv->flags = FE_FLAG_PADDING_64B | FE_FLAG_RX_2B_OFFSET |
+		FE_FLAG_RX_SG_DMA | FE_FLAG_NAPI_WEIGHT |
+		FE_FLAG_HAS_SWITCH;
+
+	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
+		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+		NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_IPV6_CSUM;
+}
+
+static void mt7621_set_mac(struct fe_priv *priv, unsigned char *mac)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->page_lock, flags);
+	fe_w32((mac[0] << 8) | mac[1], GSW_REG_GDMA1_MAC_ADRH);
+	fe_w32((mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5],
+	       GSW_REG_GDMA1_MAC_ADRL);
+	spin_unlock_irqrestore(&priv->page_lock, flags);
+}
+
+static struct fe_soc_data mt7621_data = {
+	.dma_type = FE_PDMA_RX_QDMA_TX,
+	.txd4 = MT7621_TX_DMA_FPORT,
+	.init_data = mt7621_init_data,
+	.reset_fe = mt7621_fe_reset,
+	.set_mac = mt7621_set_mac,
+	.fwd_config = mt7621_fwd_config,
+	.switch_init = mtk_gsw_init,
+	.switch_config = mt7621_gsw_config,
+	.reg_table = mt7621_reg_table,
+	.pdma_glo_cfg = FE_PDMA_SIZE_16DWORDS,
+	.rx_int = RT5350_RX_DONE_INT,
+	.tx_int = RT5350_TX_DONE_INT,
+	.status_int = (MT7621_FE_GDM1_AF | MT7621_FE_GDM2_AF),
+	.checksum_bit = MT7621_L4_VALID,
+	.has_carrier = mt7620_has_carrier,
+	.mdio_read = mt7620_mdio_read,
+	.mdio_write = mt7620_mdio_write,
+	.mdio_adjust_link = mt7620_mdio_link_adjust,
+};
+
+const struct of_device_id of_fe_match[] = {
+	{ .compatible = "mediatek,mt7621-eth", .data = &mt7621_data },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_fe_match);
-- 
1.7.10.4
