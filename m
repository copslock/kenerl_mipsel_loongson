Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:28:33 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45051 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009384AbcACP06tHGI7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:26:58 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C6CF928C186;
        Sun,  3 Jan 2016 16:26:27 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:27 +0100 (CET)
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
Subject: [PATCH 07/12] net-next: mediatek: add support for rt3050
Date:   Sun,  3 Jan 2016 16:26:10 +0100
Message-Id: <1451834775-15789-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50826
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

Add support for SoCs from the rt3050 family. This include rt3050, rt3052,
rt3352 and rt5350. These all have a builtin 5 port 100mbit switch.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
---
 drivers/net/ethernet/mediatek/soc_rt3050.c |  154 ++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/soc_rt3050.c

diff --git a/drivers/net/ethernet/mediatek/soc_rt3050.c b/drivers/net/ethernet/mediatek/soc_rt3050.c
new file mode 100644
index 0000000..8364c4a
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/soc_rt3050.c
@@ -0,0 +1,154 @@
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
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "mdio_rt2880.h"
+
+#define RT305X_RESET_FE         BIT(21)
+#define RT305X_RESET_ESW        BIT(23)
+
+static const u16 rt5350_reg_table[FE_REG_COUNT] = {
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
+	[FE_REG_FE_RST_GL] = 0,
+	[FE_REG_FE_DMA_VID_BASE] = 0,
+};
+
+static void rt305x_init_data(struct fe_soc_data *data,
+			     struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+
+	priv->flags = FE_FLAG_PADDING_64B | FE_FLAG_PADDING_BUG |
+		FE_FLAG_CALIBRATE_CLK | FE_FLAG_HAS_SWITCH;
+	netdev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM |
+		NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX;
+}
+
+static int rt3050_fwd_config(struct fe_priv *priv)
+{
+	int ret;
+
+	if (ralink_soc != RT305X_SOC_RT3052) {
+		ret = fe_set_clock_cycle(priv);
+		if (ret)
+			return ret;
+	}
+
+	fe_fwd_config(priv);
+	if (ralink_soc != RT305X_SOC_RT3352)
+		fe_w32(FE_PSE_FQFC_CFG_INIT, FE_PSE_FQ_CFG);
+	fe_csum_config(priv);
+
+	return 0;
+}
+
+static void rt305x_fe_reset(void)
+{
+	fe_reset(RT305X_RESET_FE);
+}
+
+static void rt5350_init_data(struct fe_soc_data *data,
+			     struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+
+	priv->flags = FE_FLAG_HAS_SWITCH;
+	netdev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM;
+}
+
+static void rt5350_set_mac(struct fe_priv *priv, unsigned char *mac)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->page_lock, flags);
+	fe_w32((mac[0] << 8) | mac[1], RT5350_SDM_MAC_ADRH);
+	fe_w32((mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5],
+	       RT5350_SDM_MAC_ADRL);
+	spin_unlock_irqrestore(&priv->page_lock, flags);
+}
+
+static void rt5350_rxcsum_config(bool enable)
+{
+	if (enable)
+		fe_w32(fe_r32(RT5350_SDM_CFG) | (RT5350_SDM_ICS_EN |
+				RT5350_SDM_TCS_EN | RT5350_SDM_UCS_EN),
+				RT5350_SDM_CFG);
+	else
+		fe_w32(fe_r32(RT5350_SDM_CFG) & ~(RT5350_SDM_ICS_EN |
+				RT5350_SDM_TCS_EN | RT5350_SDM_UCS_EN),
+				RT5350_SDM_CFG);
+}
+
+static int rt5350_fwd_config(struct fe_priv *priv)
+{
+	struct net_device *dev = priv_netdev(priv);
+
+	rt5350_rxcsum_config((dev->features & NETIF_F_RXCSUM));
+
+	return 0;
+}
+
+static void rt5350_fe_reset(void)
+{
+	fe_reset(RT305X_RESET_FE | RT305X_RESET_ESW);
+}
+
+static struct fe_soc_data rt3050_data = {
+	.dma_type = FE_PDMA,
+	.init_data = rt305x_init_data,
+	.reset_fe = rt305x_fe_reset,
+	.fwd_config = rt3050_fwd_config,
+	.pdma_glo_cfg = FE_PDMA_SIZE_8DWORDS,
+	.checksum_bit = RX_DMA_L4VALID,
+	.rx_int = FE_RX_DONE_INT,
+	.tx_int = FE_TX_DONE_INT,
+	.status_int = FE_CNT_GDM_AF,
+};
+
+static struct fe_soc_data rt5350_data = {
+	.dma_type = FE_PDMA,
+	.init_data = rt5350_init_data,
+	.reg_table = rt5350_reg_table,
+	.reset_fe = rt5350_fe_reset,
+	.set_mac = rt5350_set_mac,
+	.fwd_config = rt5350_fwd_config,
+	.pdma_glo_cfg = FE_PDMA_SIZE_8DWORDS,
+	.checksum_bit = RX_DMA_L4VALID,
+	.rx_int = RT5350_RX_DONE_INT,
+	.tx_int = RT5350_TX_DONE_INT,
+};
+
+const struct of_device_id of_fe_match[] = {
+	{ .compatible = "ralink,rt3050-eth", .data = &rt3050_data },
+	{ .compatible = "ralink,rt5350-eth", .data = &rt5350_data },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_fe_match);
-- 
1.7.10.4
