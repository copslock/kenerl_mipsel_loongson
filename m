Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:28:17 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45038 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009031AbcACP0ze-Av7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:26:55 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6F10628C185;
        Sun,  3 Jan 2016 16:26:24 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:24 +0100 (CET)
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
Subject: [PATCH 06/12] net-next: mediatek: add support for rt2880
Date:   Sun,  3 Jan 2016 16:26:09 +0100
Message-Id: <1451834775-15789-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50825
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

rt2880 is the oldest SoC with this core. It has a single gBit port that
will normally be attached to an external phy or switch. The patch also
adds the code required to drive the mdio bus.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
---
 drivers/net/ethernet/mediatek/mdio_rt2880.c |  223 +++++++++++++++++++++++++++
 drivers/net/ethernet/mediatek/mdio_rt2880.h |   23 +++
 drivers/net/ethernet/mediatek/soc_rt2880.c  |   78 ++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/mdio_rt2880.c
 create mode 100644 drivers/net/ethernet/mediatek/mdio_rt2880.h
 create mode 100644 drivers/net/ethernet/mediatek/soc_rt2880.c

diff --git a/drivers/net/ethernet/mediatek/mdio_rt2880.c b/drivers/net/ethernet/mediatek/mdio_rt2880.c
new file mode 100644
index 0000000..b1b5b83
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mdio_rt2880.c
@@ -0,0 +1,223 @@
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
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+
+#include "mtk_eth_soc.h"
+#include "mdio_rt2880.h"
+#include "mdio.h"
+
+#define FE_MDIO_RETRY	1000
+
+static unsigned char *rt2880_speed_str(struct fe_priv *priv)
+{
+	switch (priv->phy->speed[0]) {
+	case SPEED_1000:
+		return "1000";
+	case SPEED_100:
+		return "100";
+	case SPEED_10:
+		return "10";
+	}
+
+	return "?";
+}
+
+void rt2880_mdio_link_adjust(struct fe_priv *priv, int port)
+{
+	u32 mdio_cfg;
+
+	if (!priv->link[0]) {
+		netif_carrier_off(priv->netdev);
+		netdev_info(priv->netdev, "link down\n");
+		return;
+	}
+
+	mdio_cfg = FE_MDIO_CFG_TX_CLK_SKEW_200 |
+		   FE_MDIO_CFG_RX_CLK_SKEW_200 |
+		   FE_MDIO_CFG_GP1_FRC_EN;
+
+	if (priv->phy->duplex[0] == DUPLEX_FULL)
+		mdio_cfg |= FE_MDIO_CFG_GP1_DUPLEX;
+
+	if (priv->phy->tx_fc[0])
+		mdio_cfg |= FE_MDIO_CFG_GP1_FC_TX;
+
+	if (priv->phy->rx_fc[0])
+		mdio_cfg |= FE_MDIO_CFG_GP1_FC_RX;
+
+	switch (priv->phy->speed[0]) {
+	case SPEED_10:
+		mdio_cfg |= FE_MDIO_CFG_GP1_SPEED_10;
+		break;
+	case SPEED_100:
+		mdio_cfg |= FE_MDIO_CFG_GP1_SPEED_100;
+		break;
+	case SPEED_1000:
+		mdio_cfg |= FE_MDIO_CFG_GP1_SPEED_1000;
+		break;
+	default:
+		netdev_err(priv->netdev, "unknown link speed\n");
+		return;
+	}
+
+	fe_w32(mdio_cfg, FE_MDIO_CFG);
+
+	netif_carrier_on(priv->netdev);
+	netdev_info(priv->netdev, "link up (%sMbps/%s duplex)\n",
+		    rt2880_speed_str(priv),
+		    (priv->phy->duplex[0] == DUPLEX_FULL) ? "Full" : "Half");
+}
+
+static int rt2880_mdio_wait_ready(struct fe_priv *priv)
+{
+	int retries;
+
+	retries = FE_MDIO_RETRY;
+	while (1) {
+		u32 t;
+
+		t = fe_r32(FE_MDIO_ACCESS);
+		if ((t & BIT(31)) == 0)
+			return 0;
+
+		if (retries-- == 0)
+			break;
+
+		udelay(1);
+	}
+
+	dev_err(priv->device, "MDIO operation timed out\n");
+	return -ETIMEDOUT;
+}
+
+int rt2880_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg)
+{
+	struct fe_priv *priv = bus->priv;
+	int err;
+	u32 t;
+
+	err = rt2880_mdio_wait_ready(priv);
+	if (err)
+		return 0xffff;
+
+	t = (phy_addr << 24) | (phy_reg << 16);
+	fe_w32(t, FE_MDIO_ACCESS);
+	t |= BIT(31);
+	fe_w32(t, FE_MDIO_ACCESS);
+
+	err = rt2880_mdio_wait_ready(priv);
+	if (err)
+		return 0xffff;
+
+	pr_debug("%s: addr=%04x, reg=%04x, value=%04x\n", __func__,
+		 phy_addr, phy_reg, fe_r32(FE_MDIO_ACCESS) & 0xffff);
+
+	return fe_r32(FE_MDIO_ACCESS) & 0xffff;
+}
+
+int rt2880_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg, u16 val)
+{
+	struct fe_priv *priv = bus->priv;
+	int err;
+	u32 t;
+
+	pr_debug("%s: addr=%04x, reg=%04x, value=%04x\n", __func__,
+		 phy_addr, phy_reg, fe_r32(FE_MDIO_ACCESS) & 0xffff);
+
+	err = rt2880_mdio_wait_ready(priv);
+	if (err)
+		return err;
+
+	t = (1 << 30) | (phy_addr << 24) | (phy_reg << 16) | val;
+	fe_w32(t, FE_MDIO_ACCESS);
+	t |= BIT(31);
+	fe_w32(t, FE_MDIO_ACCESS);
+
+	return rt2880_mdio_wait_ready(priv);
+}
+
+void rt2880_port_init(struct fe_priv *priv, struct device_node *np)
+{
+	const __be32 *id = of_get_property(np, "reg", NULL);
+	const __be32 *link;
+	int size;
+	int phy_mode;
+
+	if (!id || (be32_to_cpu(*id) != 0)) {
+		pr_err("%s: invalid port id\n", np->name);
+		return;
+	}
+
+	priv->phy->phy_fixed[0] = of_get_property(np,
+						  "mediatek,fixed-link", &size);
+	if (priv->phy->phy_fixed[0] &&
+	    (size != (4 * sizeof(*priv->phy->phy_fixed[0])))) {
+		pr_err("%s: invalid fixed link property\n", np->name);
+		priv->phy->phy_fixed[0] = NULL;
+		return;
+	}
+
+	phy_mode = of_get_phy_mode(np);
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		break;
+	case PHY_INTERFACE_MODE_MII:
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		break;
+	default:
+		if (!priv->phy->phy_fixed[0])
+			dev_err(priv->device, "port %d - invalid phy mode\n",
+				priv->phy->speed[0]);
+		break;
+	}
+
+	priv->phy->phy_node[0] = of_parse_phandle(np, "phy-handle", 0);
+	if (!priv->phy->phy_node[0] && !priv->phy->phy_fixed[0])
+		return;
+
+	if (priv->phy->phy_fixed[0]) {
+		link = priv->phy->phy_fixed[0];
+		priv->phy->speed[0] = be32_to_cpup(link++);
+		priv->phy->duplex[0] = be32_to_cpup(link++);
+		priv->phy->tx_fc[0] = be32_to_cpup(link++);
+		priv->phy->rx_fc[0] = be32_to_cpup(link++);
+
+		priv->link[0] = 1;
+		switch (priv->phy->speed[0]) {
+		case SPEED_10:
+			break;
+		case SPEED_100:
+			break;
+		case SPEED_1000:
+			break;
+		default:
+			dev_err(priv->device, "invalid link speed: %d\n",
+				priv->phy->speed[0]);
+			priv->phy->phy_fixed[0] = 0;
+			return;
+		}
+		dev_info(priv->device, "using fixed link parameters\n");
+		rt2880_mdio_link_adjust(priv, 0);
+		return;
+	}
+
+	if (priv->phy->phy_node[0] && priv->mii_bus->phy_map[0])
+		fe_connect_phy_node(priv, priv->phy->phy_node[0]);
+}
diff --git a/drivers/net/ethernet/mediatek/mdio_rt2880.h b/drivers/net/ethernet/mediatek/mdio_rt2880.h
new file mode 100644
index 0000000..6884894
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mdio_rt2880.h
@@ -0,0 +1,23 @@
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
+#ifndef _RALINK_MDIO_RT2880_H__
+#define _RALINK_MDIO_RT2880_H__
+
+void rt2880_mdio_link_adjust(struct fe_priv *priv, int port);
+int rt2880_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg);
+int rt2880_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg, u16 val);
+void rt2880_port_init(struct fe_priv *priv, struct device_node *np);
+
+#endif
diff --git a/drivers/net/ethernet/mediatek/soc_rt2880.c b/drivers/net/ethernet/mediatek/soc_rt2880.c
new file mode 100644
index 0000000..47666cb
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/soc_rt2880.c
@@ -0,0 +1,78 @@
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
+#define RT2880_RESET_FE			BIT(18)
+
+static void rt2880_init_data(struct fe_soc_data *data,
+			     struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+
+	priv->flags = FE_FLAG_PADDING_64B | FE_FLAG_PADDING_BUG |
+		FE_FLAG_JUMBO_FRAME | FE_FLAG_CALIBRATE_CLK;
+	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_TX;
+	/* this should work according to the datasheet but actually does not*/
+	/* netdev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_RXCSUM; */
+}
+
+void rt2880_fe_reset(void)
+{
+	fe_reset(RT2880_RESET_FE);
+}
+
+static int rt2880_fwd_config(struct fe_priv *priv)
+{
+	int ret;
+
+	ret = fe_set_clock_cycle(priv);
+	if (ret)
+		return ret;
+
+	fe_fwd_config(priv);
+	fe_w32(FE_PSE_FQFC_CFG_INIT, FE_PSE_FQ_CFG);
+	fe_csum_config(priv);
+
+	return ret;
+}
+
+struct fe_soc_data rt2880_data = {
+	.dma_type = FE_PDMA,
+	.txd4 = TX_DMA_DESP4_DEF,
+	.init_data = rt2880_init_data,
+	.reset_fe = rt2880_fe_reset,
+	.fwd_config = rt2880_fwd_config,
+	.pdma_glo_cfg = FE_PDMA_SIZE_8DWORDS,
+	.checksum_bit = RX_DMA_L4VALID,
+	.rx_int = FE_RX_DONE_INT,
+	.tx_int = FE_TX_DONE_INT,
+	.status_int = FE_CNT_GDM_AF,
+	.mdio_read = rt2880_mdio_read,
+	.mdio_write = rt2880_mdio_write,
+	.mdio_adjust_link = rt2880_mdio_link_adjust,
+	.port_init = rt2880_port_init,
+};
+
+const struct of_device_id of_fe_match[] = {
+	{ .compatible = "ralink,rt2880-eth", .data = &rt2880_data },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_fe_match);
-- 
1.7.10.4
