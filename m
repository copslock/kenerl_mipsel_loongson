Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:27:03 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45001 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006541AbcACP0jnB-u7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:26:39 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 03D6328C02F;
        Sun,  3 Jan 2016 16:26:10 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:09 +0100 (CET)
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
Subject: [PATCH 02/12] net-next: mediatek: add the drivers core files
Date:   Sun,  3 Jan 2016 16:26:05 +0100
Message-Id: <1451834775-15789-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50821
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

This patch adds the main chunk of the driver. The ethernet core is used in
all of the Mediatek/Ralink Wireless SoCs. Over the years we have seen
various changes to
* the register layout
* the type of ports (single/dual gbit, internal FE/Gbit switch)
* dma engine (PDMA/QDMA)

and new offloading features were added, such as
* checksum
* VLAN TX/RX
* TSO
* LRO

The core functionality has however remained the same allowing us to use
the same code for all SoCs.

The abstraction for the various SoCs uses the typical ops struct pattern
which allows us to extend or override the core functionality depending on
which SoC we are on. The code to bring up the switches and external ports
has also been split into separate files.

There are 2 types of DMA engine, PDMA and the newer QDMA. PDMA uses a
typical ring buffer while QDMA uses a linked list. Unfortunatley we have
the MT7621 which has a few silicon issues. Due to these issues we need to
PDMA for RX and QDMA for TX. All SoCs newer than the MT7621 can can run on
QDMA exclusively.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
---
 drivers/net/ethernet/mediatek/ethtool.c     |  234 +++
 drivers/net/ethernet/mediatek/ethtool.h     |   22 +
 drivers/net/ethernet/mediatek/mdio.c        |  258 ++++
 drivers/net/ethernet/mediatek/mdio.h        |   27 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2073 +++++++++++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  572 ++++++++
 6 files changed, 3186 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/ethtool.c
 create mode 100644 drivers/net/ethernet/mediatek/ethtool.h
 create mode 100644 drivers/net/ethernet/mediatek/mdio.c
 create mode 100644 drivers/net/ethernet/mediatek/mdio.h
 create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_soc.c
 create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_soc.h

diff --git a/drivers/net/ethernet/mediatek/ethtool.c b/drivers/net/ethernet/mediatek/ethtool.c
new file mode 100644
index 0000000..a372bd0
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/ethtool.c
@@ -0,0 +1,234 @@
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
+#include "mtk_eth_soc.h"
+
+static const char fe_gdma_str[][ETH_GSTRING_LEN] = {
+#define _FE(x...)	# x,
+FE_STAT_REG_DECLARE
+#undef _FE
+};
+
+static int fe_get_settings(struct net_device *dev,
+			   struct ethtool_cmd *cmd)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	int err;
+
+	if (!priv->phy_dev)
+		goto out_gset;
+
+	if (priv->phy_flags == FE_PHY_FLAG_ATTACH) {
+		err = phy_read_status(priv->phy_dev);
+		if (err)
+			goto out_gset;
+	}
+
+	return phy_ethtool_gset(priv->phy_dev, cmd);
+
+out_gset:
+	return -ENODEV;
+}
+
+static int fe_set_settings(struct net_device *dev,
+			   struct ethtool_cmd *cmd)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	if (!priv->phy_dev)
+		goto out_sset;
+
+	if (cmd->phy_address != priv->phy_dev->addr) {
+		if (priv->phy->phy_node[cmd->phy_address]) {
+			priv->phy_dev = priv->phy->phy[cmd->phy_address];
+			priv->phy_flags = FE_PHY_FLAG_PORT;
+		} else if (priv->mii_bus &&
+			   priv->mii_bus->phy_map[cmd->phy_address]) {
+			priv->phy_dev =
+				priv->mii_bus->phy_map[cmd->phy_address];
+			priv->phy_flags = FE_PHY_FLAG_ATTACH;
+		} else {
+			goto out_sset;
+		}
+	}
+
+	return phy_ethtool_sset(priv->phy_dev, cmd);
+
+out_sset:
+	return -ENODEV;
+}
+
+static void fe_get_drvinfo(struct net_device *dev,
+			   struct ethtool_drvinfo *info)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct fe_soc_data *soc = priv->soc;
+
+	strlcpy(info->driver, priv->device->driver->name, sizeof(info->driver));
+	strlcpy(info->bus_info, dev_name(priv->device), sizeof(info->bus_info));
+
+	if (soc->reg_table[FE_REG_FE_COUNTER_BASE])
+		info->n_stats = ARRAY_SIZE(fe_gdma_str);
+}
+
+static u32 fe_get_msglevel(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	return priv->msg_enable;
+}
+
+static void fe_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	priv->msg_enable = value;
+}
+
+static int fe_nway_reset(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	if (!priv->phy_dev)
+		goto out_nway_reset;
+
+	return genphy_restart_aneg(priv->phy_dev);
+
+out_nway_reset:
+	return -EOPNOTSUPP;
+}
+
+static u32 fe_get_link(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	int err;
+
+	if (!priv->phy_dev)
+		goto out_get_link;
+
+	if (priv->phy_flags == FE_PHY_FLAG_ATTACH) {
+		err = genphy_update_link(priv->phy_dev);
+		if (err)
+			goto out_get_link;
+	}
+
+	return priv->phy_dev->link;
+
+out_get_link:
+	return ethtool_op_get_link(dev);
+}
+
+static int fe_set_ringparam(struct net_device *dev,
+			    struct ethtool_ringparam *ring)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	if ((ring->tx_pending < 2) ||
+	    (ring->rx_pending < 2) ||
+	    (ring->rx_pending > MAX_DMA_DESC) ||
+	    (ring->tx_pending > MAX_DMA_DESC))
+		return -EINVAL;
+
+	dev->netdev_ops->ndo_stop(dev);
+
+	priv->tx_ring.tx_ring_size = BIT(fls(ring->tx_pending) - 1);
+	priv->rx_ring_p.rx_ring_size = BIT(fls(ring->rx_pending) - 1);
+
+	dev->netdev_ops->ndo_open(dev);
+
+	return 0;
+}
+
+static void fe_get_ringparam(struct net_device *dev,
+			     struct ethtool_ringparam *ring)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	ring->rx_max_pending = MAX_DMA_DESC;
+	ring->tx_max_pending = MAX_DMA_DESC;
+	ring->rx_pending = priv->rx_ring_p.rx_ring_size;
+	ring->tx_pending = priv->tx_ring.tx_ring_size;
+}
+
+static void fe_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(data, *fe_gdma_str, sizeof(fe_gdma_str));
+		break;
+	}
+}
+
+static int fe_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(fe_gdma_str);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void fe_get_ethtool_stats(struct net_device *dev,
+				 struct ethtool_stats *stats, u64 *data)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct fe_hw_stats *hwstats = priv->hw_stats;
+	u64 *data_src, *data_dst;
+	unsigned int start;
+	int i;
+
+	if (netif_running(dev) && netif_device_present(dev)) {
+		if (spin_trylock(&hwstats->stats_lock)) {
+			fe_stats_update(priv);
+			spin_unlock(&hwstats->stats_lock);
+		}
+	}
+
+	do {
+		data_src = &hwstats->tx_bytes;
+		data_dst = data;
+		start = u64_stats_fetch_begin_irq(&hwstats->syncp);
+
+		for (i = 0; i < ARRAY_SIZE(fe_gdma_str); i++)
+			*data_dst++ = *data_src++;
+
+	} while (u64_stats_fetch_retry_irq(&hwstats->syncp, start));
+}
+
+static struct ethtool_ops fe_ethtool_ops = {
+	.get_settings		= fe_get_settings,
+	.set_settings		= fe_set_settings,
+	.get_drvinfo		= fe_get_drvinfo,
+	.get_msglevel		= fe_get_msglevel,
+	.set_msglevel		= fe_set_msglevel,
+	.nway_reset		= fe_nway_reset,
+	.get_link		= fe_get_link,
+	.set_ringparam		= fe_set_ringparam,
+	.get_ringparam		= fe_get_ringparam,
+};
+
+void fe_set_ethtool_ops(struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+	struct fe_soc_data *soc = priv->soc;
+
+	if (soc->reg_table[FE_REG_FE_COUNTER_BASE]) {
+		fe_ethtool_ops.get_strings = fe_get_strings;
+		fe_ethtool_ops.get_sset_count = fe_get_sset_count;
+		fe_ethtool_ops.get_ethtool_stats = fe_get_ethtool_stats;
+	}
+
+	netdev->ethtool_ops = &fe_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/mediatek/ethtool.h b/drivers/net/ethernet/mediatek/ethtool.h
new file mode 100644
index 0000000..955b84f
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/ethtool.h
@@ -0,0 +1,22 @@
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
+#ifndef FE_ETHTOOL_H
+#define FE_ETHTOOL_H
+
+#include <linux/ethtool.h>
+
+void fe_set_ethtool_ops(struct net_device *netdev);
+
+#endif /* FE_ETHTOOL_H */
diff --git a/drivers/net/ethernet/mediatek/mdio.c b/drivers/net/ethernet/mediatek/mdio.c
new file mode 100644
index 0000000..169c937
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mdio.c
@@ -0,0 +1,258 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2015 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/phy.h>
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+
+#include "mtk_eth_soc.h"
+#include "mdio.h"
+
+static int fe_mdio_reset(struct mii_bus *bus)
+{
+	/* TODO */
+	return 0;
+}
+
+static void fe_phy_link_adjust(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&priv->phy->lock, flags);
+	for (i = 0; i < 8; i++) {
+		if (priv->phy->phy_node[i]) {
+			struct phy_device *phydev = priv->phy->phy[i];
+			int status_change = 0;
+
+			if (phydev->link)
+				if (priv->phy->duplex[i] != phydev->duplex ||
+				    priv->phy->speed[i] != phydev->speed)
+					status_change = 1;
+
+			if (phydev->link != priv->link[i])
+				status_change = 1;
+
+			switch (phydev->speed) {
+			case SPEED_1000:
+			case SPEED_100:
+			case SPEED_10:
+				priv->link[i] = phydev->link;
+				priv->phy->duplex[i] = phydev->duplex;
+				priv->phy->speed[i] = phydev->speed;
+
+				if (status_change &&
+				    priv->soc->mdio_adjust_link)
+					priv->soc->mdio_adjust_link(priv, i);
+				break;
+			}
+		}
+	}
+}
+
+int fe_connect_phy_node(struct fe_priv *priv, struct device_node *phy_node)
+{
+	const __be32 *_port = NULL;
+	struct phy_device *phydev;
+	int phy_mode, port;
+
+	_port = of_get_property(phy_node, "reg", NULL);
+
+	if (!_port || (be32_to_cpu(*_port) >= 0x20)) {
+		pr_err("%s: invalid port id\n", phy_node->name);
+		return -EINVAL;
+	}
+	port = be32_to_cpu(*_port);
+	phy_mode = of_get_phy_mode(phy_node);
+	if (phy_mode < 0) {
+		dev_err(priv->device, "incorrect phy-mode %d\n", phy_mode);
+		priv->phy->phy_node[port] = NULL;
+		return -EINVAL;
+	}
+
+	phydev = of_phy_connect(priv->netdev, phy_node, fe_phy_link_adjust,
+				0, phy_mode);
+	if (IS_ERR(phydev)) {
+		dev_err(priv->device, "could not connect to PHY\n");
+		priv->phy->phy_node[port] = NULL;
+		return PTR_ERR(phydev);
+	}
+
+	phydev->supported &= PHY_GBIT_FEATURES;
+	phydev->advertising = phydev->supported;
+
+	dev_info(priv->device,
+		 "connected port %d to PHY at %s [uid=%08x, driver=%s]\n",
+		 port, dev_name(&phydev->dev), phydev->phy_id,
+		 phydev->drv->name);
+
+	priv->phy->phy[port] = phydev;
+	priv->link[port] = 0;
+
+	return 0;
+}
+
+static void phy_init(struct fe_priv *priv, struct phy_device *phy)
+{
+	phy_attach(priv->netdev, dev_name(&phy->dev), PHY_INTERFACE_MODE_MII);
+
+	phy->autoneg = AUTONEG_ENABLE;
+	phy->speed = 0;
+	phy->duplex = 0;
+	phy->supported &= PHY_BASIC_FEATURES;
+	phy->advertising = phy->supported | ADVERTISED_Autoneg;
+
+	phy_start_aneg(phy);
+}
+
+static int fe_phy_connect(struct fe_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if (priv->phy->phy_node[i]) {
+			if (!priv->phy_dev) {
+				priv->phy_dev = priv->phy->phy[i];
+				priv->phy_flags = FE_PHY_FLAG_PORT;
+			}
+		} else if (priv->mii_bus && priv->mii_bus->phy_map[i]) {
+			phy_init(priv, priv->mii_bus->phy_map[i]);
+			if (!priv->phy_dev) {
+				priv->phy_dev = priv->mii_bus->phy_map[i];
+				priv->phy_flags = FE_PHY_FLAG_ATTACH;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void fe_phy_disconnect(struct fe_priv *priv)
+{
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		if (priv->phy->phy_fixed[i]) {
+			spin_lock_irqsave(&priv->phy->lock, flags);
+			priv->link[i] = 0;
+			if (priv->soc->mdio_adjust_link)
+				priv->soc->mdio_adjust_link(priv, i);
+			spin_unlock_irqrestore(&priv->phy->lock, flags);
+		} else if (priv->phy->phy[i]) {
+			phy_disconnect(priv->phy->phy[i]);
+		} else if (priv->mii_bus && priv->mii_bus->phy_map[i]) {
+			phy_detach(priv->mii_bus->phy_map[i]);
+		}
+}
+
+static void fe_phy_start(struct fe_priv *priv)
+{
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if (priv->phy->phy_fixed[i]) {
+			spin_lock_irqsave(&priv->phy->lock, flags);
+			priv->link[i] = 1;
+			if (priv->soc->mdio_adjust_link)
+				priv->soc->mdio_adjust_link(priv, i);
+			spin_unlock_irqrestore(&priv->phy->lock, flags);
+		} else if (priv->phy->phy[i]) {
+			phy_start(priv->phy->phy[i]);
+		}
+	}
+}
+
+static void fe_phy_stop(struct fe_priv *priv)
+{
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		if (priv->phy->phy_fixed[i]) {
+			spin_lock_irqsave(&priv->phy->lock, flags);
+			priv->link[i] = 0;
+			if (priv->soc->mdio_adjust_link)
+				priv->soc->mdio_adjust_link(priv, i);
+			spin_unlock_irqrestore(&priv->phy->lock, flags);
+		} else if (priv->phy->phy[i]) {
+			phy_stop(priv->phy->phy[i]);
+		}
+}
+
+static struct fe_phy phy_ralink = {
+	.connect = fe_phy_connect,
+	.disconnect = fe_phy_disconnect,
+	.start = fe_phy_start,
+	.stop = fe_phy_stop,
+};
+
+int fe_mdio_init(struct fe_priv *priv)
+{
+	struct device_node *mii_np;
+	int err;
+
+	if (!priv->soc->mdio_read || !priv->soc->mdio_write)
+		return 0;
+
+	spin_lock_init(&phy_ralink.lock);
+	priv->phy = &phy_ralink;
+
+	mii_np = of_get_child_by_name(priv->device->of_node, "mdio-bus");
+	if (!mii_np) {
+		dev_err(priv->device, "no %s child node found", "mdio-bus");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_available(mii_np)) {
+		err = 0;
+		goto err_put_node;
+	}
+
+	priv->mii_bus = mdiobus_alloc();
+	if (!priv->mii_bus) {
+		err = -ENOMEM;
+		goto err_put_node;
+	}
+
+	priv->mii_bus->name = "mdio";
+	priv->mii_bus->read = priv->soc->mdio_read;
+	priv->mii_bus->write = priv->soc->mdio_write;
+	priv->mii_bus->reset = fe_mdio_reset;
+	priv->mii_bus->priv = priv;
+	priv->mii_bus->parent = priv->device;
+
+	snprintf(priv->mii_bus->id, MII_BUS_ID_SIZE, "%s", mii_np->name);
+	err = of_mdiobus_register(priv->mii_bus, mii_np);
+	if (err)
+		goto err_free_bus;
+
+	return 0;
+
+err_free_bus:
+	kfree(priv->mii_bus);
+err_put_node:
+	of_node_put(mii_np);
+	priv->mii_bus = NULL;
+	return err;
+}
+
+void fe_mdio_cleanup(struct fe_priv *priv)
+{
+	if (!priv->mii_bus)
+		return;
+
+	mdiobus_unregister(priv->mii_bus);
+	of_node_put(priv->mii_bus->dev.of_node);
+	kfree(priv->mii_bus);
+}
diff --git a/drivers/net/ethernet/mediatek/mdio.h b/drivers/net/ethernet/mediatek/mdio.h
new file mode 100644
index 0000000..b7d4a24
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mdio.h
@@ -0,0 +1,27 @@
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
+#ifndef _RALINK_MDIO_H__
+#define _RALINK_MDIO_H__
+
+#ifdef CONFIG_NET_MEDIATEK_MDIO
+int fe_mdio_init(struct fe_priv *priv);
+void fe_mdio_cleanup(struct fe_priv *priv);
+int fe_connect_phy_node(struct fe_priv *priv,
+			struct device_node *phy_node);
+#else
+static inline int fe_mdio_init(struct fe_priv *priv) { return 0; }
+static inline void fe_mdio_cleanup(struct fe_priv *priv) {}
+#endif
+#endif
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
new file mode 100644
index 0000000..826baf5
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -0,0 +1,2073 @@
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
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+#include <linux/if_vlan.h>
+#include <linux/reset.h>
+#include <linux/tcp.h>
+#include <linux/io.h>
+#include <linux/bug.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "mdio.h"
+#include "ethtool.h"
+
+#define	MAX_RX_LENGTH		1536
+#define FE_RX_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
+#define FE_RX_HLEN		(NET_SKB_PAD + FE_RX_ETH_HLEN + NET_IP_ALIGN)
+#define DMA_DUMMY_DESC		0xffffffff
+#define FE_DEFAULT_MSG_ENABLE \
+		(NETIF_MSG_DRV | \
+		NETIF_MSG_PROBE | \
+		NETIF_MSG_LINK | \
+		NETIF_MSG_TIMER | \
+		NETIF_MSG_IFDOWN | \
+		NETIF_MSG_IFUP | \
+		NETIF_MSG_RX_ERR | \
+		NETIF_MSG_TX_ERR)
+
+#define TX_DMA_DESP2_DEF	(TX_DMA_LS0 | TX_DMA_DONE)
+#define NEXT_TX_DESP_IDX(X)	(((X) + 1) & (ring->tx_ring_size - 1))
+#define NEXT_RX_DESP_IDX(X)	(((X) + 1) & (ring->rx_ring_size - 1))
+
+#define SYSC_REG_RSTCTRL	0x34
+
+static int fe_msg_level = -1;
+module_param_named(msg_level, fe_msg_level, int, 0);
+MODULE_PARM_DESC(msg_level, "Message level (-1=defaults,0=none,...,16=all)");
+
+static const u16 fe_reg_table_default[FE_REG_COUNT] = {
+	[FE_REG_PDMA_GLO_CFG] = FE_PDMA_GLO_CFG,
+	[FE_REG_PDMA_RST_CFG] = FE_PDMA_RST_CFG,
+	[FE_REG_DLY_INT_CFG] = FE_DLY_INT_CFG,
+	[FE_REG_TX_BASE_PTR0] = FE_TX_BASE_PTR0,
+	[FE_REG_TX_MAX_CNT0] = FE_TX_MAX_CNT0,
+	[FE_REG_TX_CTX_IDX0] = FE_TX_CTX_IDX0,
+	[FE_REG_TX_DTX_IDX0] = FE_TX_DTX_IDX0,
+	[FE_REG_RX_BASE_PTR0] = FE_RX_BASE_PTR0,
+	[FE_REG_RX_MAX_CNT0] = FE_RX_MAX_CNT0,
+	[FE_REG_RX_CALC_IDX0] = FE_RX_CALC_IDX0,
+	[FE_REG_RX_DRX_IDX0] = FE_RX_DRX_IDX0,
+	[FE_REG_FE_INT_ENABLE] = FE_FE_INT_ENABLE,
+	[FE_REG_FE_INT_STATUS] = FE_FE_INT_STATUS,
+	[FE_REG_FE_DMA_VID_BASE] = FE_DMA_VID0,
+	[FE_REG_FE_COUNTER_BASE] = FE_GDMA1_TX_GBCNT,
+	[FE_REG_FE_RST_GL] = FE_FE_RST_GL,
+};
+
+static const u16 *fe_reg_table = fe_reg_table_default;
+
+struct fe_work_t {
+	int bitnr;
+	void (*action)(struct fe_priv *);
+};
+
+static void __iomem *fe_base;
+
+void fe_w32(u32 val, unsigned reg)
+{
+	__raw_writel(val, fe_base + reg);
+}
+
+u32 fe_r32(unsigned reg)
+{
+	return __raw_readl(fe_base + reg);
+}
+
+static void fe_reg_w32(u32 val, enum fe_reg reg)
+{
+	fe_w32(val, fe_reg_table[reg]);
+}
+
+static u32 fe_reg_r32(enum fe_reg reg)
+{
+	return fe_r32(fe_reg_table[reg]);
+}
+
+void fe_reset(u32 reset_bits)
+{
+	u32 t;
+
+	t = rt_sysc_r32(SYSC_REG_RSTCTRL);
+	t |= reset_bits;
+	rt_sysc_w32(t, SYSC_REG_RSTCTRL);
+	usleep_range(10, 20);
+
+	t &= ~reset_bits;
+	rt_sysc_w32(t, SYSC_REG_RSTCTRL);
+	usleep_range(10, 20);
+}
+
+static inline void fe_irq_ack(struct fe_priv *priv, u32 mask)
+{
+	if (priv->soc->dma_type & FE_PDMA)
+		fe_reg_w32(mask, FE_REG_FE_INT_STATUS);
+	if (priv->soc->dma_type & FE_QDMA)
+		fe_w32(mask, FE_QFE_INT_STATUS);
+}
+
+static inline u32 fe_irq_pending(struct fe_priv *priv)
+{
+	u32 status = 0;
+
+	if (priv->soc->dma_type & FE_PDMA)
+		status |= fe_reg_r32(FE_REG_FE_INT_STATUS);
+
+	if (priv->soc->dma_type & FE_QDMA)
+		status |= fe_r32(FE_QFE_INT_STATUS);
+
+	return status;
+}
+
+static void fe_irq_ack_status(struct fe_priv *priv, u32 mask)
+{
+	u32 status_reg = FE_REG_FE_INT_STATUS;
+
+	if (fe_reg_table[FE_REG_FE_INT_STATUS2])
+		status_reg = FE_REG_FE_INT_STATUS2;
+
+	fe_reg_w32(mask, status_reg);
+}
+
+static u32 fe_irq_pending_status(struct fe_priv *priv)
+{
+	u32 status_reg = FE_REG_FE_INT_STATUS;
+
+	if (fe_reg_table[FE_REG_FE_INT_STATUS2])
+		status_reg = FE_REG_FE_INT_STATUS2;
+
+	return fe_reg_r32(status_reg);
+}
+
+static inline void fe_irq_disable(struct fe_priv *priv, u32 mask)
+{
+	u32 val;
+
+	if (priv->soc->dma_type & FE_PDMA) {
+		val = fe_reg_r32(FE_REG_FE_INT_ENABLE);
+		fe_reg_w32(val & ~mask, FE_REG_FE_INT_ENABLE);
+		/* flush write */
+		fe_reg_r32(FE_REG_FE_INT_ENABLE);
+	}
+
+	if (priv->soc->dma_type & FE_QDMA) {
+		val = fe_r32(FE_QFE_INT_ENABLE);
+		fe_w32(val & ~mask, FE_QFE_INT_ENABLE);
+		/* flush write */
+		fe_r32(FE_QFE_INT_ENABLE);
+	}
+}
+
+static inline void fe_irq_enable(struct fe_priv *priv, u32 mask)
+{
+	u32 val;
+
+	if (priv->soc->dma_type & FE_PDMA) {
+		val = fe_reg_r32(FE_REG_FE_INT_ENABLE);
+		fe_reg_w32(val | mask, FE_REG_FE_INT_ENABLE);
+		/* flush write */
+		fe_reg_r32(FE_REG_FE_INT_ENABLE);
+	}
+
+	if (priv->soc->dma_type & FE_QDMA) {
+		val = fe_r32(FE_QFE_INT_ENABLE);
+		fe_w32(val | mask, FE_QFE_INT_ENABLE);
+		/* flush write */
+		fe_r32(FE_QFE_INT_ENABLE);
+	}
+}
+
+static inline u32 fe_irq_enabled(struct fe_priv *priv)
+{
+	u32 enabled = 0;
+
+	if (priv->soc->dma_type & FE_PDMA)
+		enabled |= fe_reg_r32(FE_REG_FE_INT_ENABLE);
+
+	if (priv->soc->dma_type & FE_QDMA)
+		enabled |= fe_reg_r32(FE_QFE_INT_ENABLE);
+
+	return enabled;
+}
+
+static inline void fe_hw_set_macaddr(struct fe_priv *priv, unsigned char *mac)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->page_lock, flags);
+	fe_w32((mac[0] << 8) | mac[1], FE_GDMA1_MAC_ADRH);
+	fe_w32((mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5],
+	       FE_GDMA1_MAC_ADRL);
+	spin_unlock_irqrestore(&priv->page_lock, flags);
+}
+
+static int fe_set_mac_address(struct net_device *dev, void *p)
+{
+	int ret = eth_mac_addr(dev, p);
+
+	if (!ret) {
+		struct fe_priv *priv = netdev_priv(dev);
+
+		if (priv->soc->set_mac)
+			priv->soc->set_mac(priv, dev->dev_addr);
+		else
+			fe_hw_set_macaddr(priv, p);
+	}
+
+	return ret;
+}
+
+static inline int fe_max_frag_size(int mtu)
+{
+	/* make sure buf_size will be at least MAX_RX_LENGTH */
+	if (mtu + FE_RX_ETH_HLEN < MAX_RX_LENGTH)
+		mtu = MAX_RX_LENGTH - FE_RX_ETH_HLEN;
+
+	return SKB_DATA_ALIGN(FE_RX_HLEN + mtu) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+}
+
+static inline int fe_max_buf_size(int frag_size)
+{
+	int buf_size = frag_size - NET_SKB_PAD - NET_IP_ALIGN -
+		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	WARN_ON(buf_size < MAX_RX_LENGTH);
+	return buf_size;
+}
+
+static inline void fe_get_rxd(struct fe_rx_dma *rxd, struct fe_rx_dma *dma_rxd)
+{
+	rxd->rxd1 = READ_ONCE(dma_rxd->rxd1);
+	rxd->rxd2 = READ_ONCE(dma_rxd->rxd2);
+	rxd->rxd3 = READ_ONCE(dma_rxd->rxd3);
+	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
+}
+
+static inline void fe_set_txd_pdma(struct fe_tx_dma *txd,
+				   struct fe_tx_dma *dma_txd)
+{
+	WRITE_ONCE(dma_txd->txd1, txd->txd1);
+	WRITE_ONCE(dma_txd->txd3, txd->txd3);
+	WRITE_ONCE(dma_txd->txd4, txd->txd4);
+	/* clean dma done flag last */
+	WRITE_ONCE(dma_txd->txd2, txd->txd2);
+}
+
+static void fe_clean_rx(struct fe_priv *priv, struct fe_rx_ring *ring)
+{
+	int i;
+
+	if (ring->rx_data) {
+		for (i = 0; i < ring->rx_ring_size; i++)
+			if (ring->rx_data[i]) {
+				if (ring->rx_dma && ring->rx_dma[i].rxd1)
+					dma_unmap_single(&priv->netdev->dev,
+							 ring->rx_dma[i].rxd1,
+							 ring->rx_buf_size,
+							 DMA_FROM_DEVICE);
+				put_page(virt_to_head_page(ring->rx_data[i]));
+			}
+
+		kfree(ring->rx_data);
+		ring->rx_data = NULL;
+	}
+
+	if (ring->rx_dma) {
+		dma_free_coherent(&priv->netdev->dev,
+				  ring->rx_ring_size * sizeof(*ring->rx_dma),
+				  ring->rx_dma,
+				  ring->rx_phys);
+		ring->rx_dma = NULL;
+	}
+}
+
+static int fe_dma_rx_alloc(struct fe_priv *priv, struct fe_rx_ring *ring)
+{
+	struct net_device *netdev = priv->netdev;
+	int i, pad;
+
+	ring->frag_size = fe_max_frag_size(ETH_DATA_LEN);
+	ring->rx_buf_size = fe_max_buf_size(ring->frag_size);
+	ring->rx_ring_size = NUM_DMA_DESC;
+	if (priv->flags & FE_FLAG_NAPI_WEIGHT)
+		ring->rx_ring_size *= 4;
+
+	ring->rx_data = kcalloc(ring->rx_ring_size, sizeof(*ring->rx_data),
+			GFP_KERNEL);
+	if (!ring->rx_data)
+		goto no_rx_mem;
+
+	for (i = 0; i < ring->rx_ring_size; i++) {
+		ring->rx_data[i] = netdev_alloc_frag(ring->frag_size);
+		if (!ring->rx_data[i])
+			goto no_rx_mem;
+	}
+
+	ring->rx_dma = dma_alloc_coherent(&netdev->dev,
+			ring->rx_ring_size * sizeof(*ring->rx_dma),
+			&ring->rx_phys,
+			GFP_ATOMIC | __GFP_ZERO);
+	if (!ring->rx_dma)
+		goto no_rx_mem;
+
+	if (priv->flags & FE_FLAG_RX_2B_OFFSET)
+		pad = 0;
+	else
+		pad = NET_IP_ALIGN;
+	for (i = 0; i < ring->rx_ring_size; i++) {
+		dma_addr_t dma_addr = dma_map_single(&netdev->dev,
+				ring->rx_data[i] + NET_SKB_PAD + pad,
+				ring->rx_buf_size,
+				DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(&netdev->dev, dma_addr)))
+			goto no_rx_mem;
+		ring->rx_dma[i].rxd1 = (unsigned int)dma_addr;
+
+		if (priv->flags & FE_FLAG_RX_SG_DMA)
+			ring->rx_dma[i].rxd2 = RX_DMA_PLEN0(ring->rx_buf_size);
+		else
+			ring->rx_dma[i].rxd2 = RX_DMA_LSO;
+	}
+	ring->rx_calc_idx = ring->rx_ring_size - 1;
+	/* make sure that all changes to the dma ring are flushed before we
+	 * continue
+	 */
+	wmb();
+
+	return 0;
+
+no_rx_mem:
+	return -ENOMEM;
+}
+
+static void fe_txd_unmap(struct device *dev, struct fe_tx_buf *tx_buf)
+{
+	if (tx_buf->flags & FE_TX_FLAGS_SINGLE0) {
+		dma_unmap_single(dev,
+				 dma_unmap_addr(tx_buf, dma_addr0),
+				 dma_unmap_len(tx_buf, dma_len0),
+				 DMA_TO_DEVICE);
+	} else if (tx_buf->flags & FE_TX_FLAGS_PAGE0) {
+		dma_unmap_page(dev,
+			       dma_unmap_addr(tx_buf, dma_addr0),
+			       dma_unmap_len(tx_buf, dma_len0),
+			       DMA_TO_DEVICE);
+	}
+	if (tx_buf->flags & FE_TX_FLAGS_PAGE1)
+		dma_unmap_page(dev,
+			       dma_unmap_addr(tx_buf, dma_addr1),
+			       dma_unmap_len(tx_buf, dma_len1),
+			       DMA_TO_DEVICE);
+
+	tx_buf->flags = 0;
+	if (tx_buf->skb && (tx_buf->skb != (struct sk_buff *)DMA_DUMMY_DESC))
+		dev_kfree_skb_any(tx_buf->skb);
+	tx_buf->skb = NULL;
+}
+
+static void fe_pdma_tx_clean(struct fe_priv *priv)
+{
+	int i;
+	struct device *dev = &priv->netdev->dev;
+	struct fe_tx_ring *ring = &priv->tx_ring;
+
+	if (ring->tx_buf) {
+		for (i = 0; i < ring->tx_ring_size; i++)
+			fe_txd_unmap(dev, &ring->tx_buf[i]);
+		kfree(ring->tx_buf);
+		ring->tx_buf = NULL;
+	}
+
+	if (ring->tx_dma) {
+		dma_free_coherent(dev,
+				  ring->tx_ring_size * sizeof(*ring->tx_dma),
+				  ring->tx_dma,
+				  ring->tx_phys);
+		ring->tx_dma = NULL;
+	}
+}
+
+static void fe_qdma_tx_clean(struct fe_priv *priv)
+{
+	int i;
+	struct device *dev = &priv->netdev->dev;
+	struct fe_tx_ring *ring = &priv->tx_ring;
+
+	if (ring->tx_buf) {
+		for (i = 0; i < ring->tx_ring_size; i++)
+			fe_txd_unmap(dev, &ring->tx_buf[i]);
+		kfree(ring->tx_buf);
+		ring->tx_buf = NULL;
+	}
+
+	if (ring->tx_dma) {
+		dma_free_coherent(dev,
+				  ring->tx_ring_size * sizeof(*ring->tx_dma),
+				  ring->tx_dma,
+				  ring->tx_phys);
+		ring->tx_dma = NULL;
+	}
+}
+
+void fe_stats_update(struct fe_priv *priv)
+{
+	struct fe_hw_stats *hwstats = priv->hw_stats;
+	unsigned int base = fe_reg_table[FE_REG_FE_COUNTER_BASE];
+	u64 stats;
+
+	u64_stats_update_begin(&hwstats->syncp);
+
+	if (IS_ENABLED(CONFIG_SOC_MT7621)) {
+		hwstats->rx_bytes			+= fe_r32(base);
+		stats					=  fe_r32(base + 0x04);
+		if (stats)
+			hwstats->rx_bytes		+= (stats << 32);
+		hwstats->rx_packets			+= fe_r32(base + 0x08);
+		hwstats->rx_overflow			+= fe_r32(base + 0x10);
+		hwstats->rx_fcs_errors			+= fe_r32(base + 0x14);
+		hwstats->rx_short_errors		+= fe_r32(base + 0x18);
+		hwstats->rx_long_errors			+= fe_r32(base + 0x1c);
+		hwstats->rx_checksum_errors		+= fe_r32(base + 0x20);
+		hwstats->rx_flow_control_packets	+= fe_r32(base + 0x24);
+		hwstats->tx_skip			+= fe_r32(base + 0x28);
+		hwstats->tx_collisions			+= fe_r32(base + 0x2c);
+		hwstats->tx_bytes			+= fe_r32(base + 0x30);
+		stats					=  fe_r32(base + 0x34);
+		if (stats)
+			hwstats->tx_bytes		+= (stats << 32);
+		hwstats->tx_packets			+= fe_r32(base + 0x38);
+	} else {
+		hwstats->tx_bytes			+= fe_r32(base);
+		hwstats->tx_packets			+= fe_r32(base + 0x04);
+		hwstats->tx_skip			+= fe_r32(base + 0x08);
+		hwstats->tx_collisions			+= fe_r32(base + 0x0c);
+		hwstats->rx_bytes			+= fe_r32(base + 0x20);
+		hwstats->rx_packets			+= fe_r32(base + 0x24);
+		hwstats->rx_overflow			+= fe_r32(base + 0x28);
+		hwstats->rx_fcs_errors			+= fe_r32(base + 0x2c);
+		hwstats->rx_short_errors		+= fe_r32(base + 0x30);
+		hwstats->rx_long_errors			+= fe_r32(base + 0x34);
+		hwstats->rx_checksum_errors		+= fe_r32(base + 0x38);
+		hwstats->rx_flow_control_packets	+= fe_r32(base + 0x3c);
+	}
+
+	u64_stats_update_end(&hwstats->syncp);
+}
+
+static struct rtnl_link_stats64 *fe_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *storage)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct fe_hw_stats *hwstats = priv->hw_stats;
+	unsigned int base = fe_reg_table[FE_REG_FE_COUNTER_BASE];
+	unsigned int start;
+
+	if (!base) {
+		netdev_stats_to_stats64(storage, &dev->stats);
+		return storage;
+	}
+
+	if (netif_running(dev) && netif_device_present(dev)) {
+		if (spin_trylock(&hwstats->stats_lock)) {
+			fe_stats_update(priv);
+			spin_unlock(&hwstats->stats_lock);
+		}
+	}
+
+	do {
+		start = u64_stats_fetch_begin_irq(&hwstats->syncp);
+		storage->rx_packets = hwstats->rx_packets;
+		storage->tx_packets = hwstats->tx_packets;
+		storage->rx_bytes = hwstats->rx_bytes;
+		storage->tx_bytes = hwstats->tx_bytes;
+		storage->collisions = hwstats->tx_collisions;
+		storage->rx_length_errors = hwstats->rx_short_errors +
+			hwstats->rx_long_errors;
+		storage->rx_over_errors = hwstats->rx_overflow;
+		storage->rx_crc_errors = hwstats->rx_fcs_errors;
+		storage->rx_errors = hwstats->rx_checksum_errors;
+		storage->tx_aborted_errors = hwstats->tx_skip;
+	} while (u64_stats_fetch_retry_irq(&hwstats->syncp, start));
+
+	storage->tx_errors = priv->netdev->stats.tx_errors;
+	storage->rx_dropped = priv->netdev->stats.rx_dropped;
+	storage->tx_dropped = priv->netdev->stats.tx_dropped;
+
+	return storage;
+}
+
+static int fe_vlan_rx_add_vid(struct net_device *dev,
+			      __be16 proto, u16 vid)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	u32 idx = (vid & 0xf);
+	u32 vlan_cfg;
+
+	if (!((fe_reg_table[FE_REG_FE_DMA_VID_BASE]) &&
+	      (dev->features & NETIF_F_HW_VLAN_CTAG_TX)))
+		return 0;
+
+	if (test_bit(idx, &priv->vlan_map)) {
+		netdev_warn(dev, "disable tx vlan offload\n");
+		dev->wanted_features &= ~NETIF_F_HW_VLAN_CTAG_TX;
+		netdev_update_features(dev);
+	} else {
+		vlan_cfg = fe_r32(fe_reg_table[FE_REG_FE_DMA_VID_BASE] +
+				((idx >> 1) << 2));
+		if (idx & 0x1) {
+			vlan_cfg &= 0xffff;
+			vlan_cfg |= (vid << 16);
+		} else {
+			vlan_cfg &= 0xffff0000;
+			vlan_cfg |= vid;
+		}
+		fe_w32(vlan_cfg, fe_reg_table[FE_REG_FE_DMA_VID_BASE] +
+				((idx >> 1) << 2));
+		set_bit(idx, &priv->vlan_map);
+	}
+
+	return 0;
+}
+
+static int fe_vlan_rx_kill_vid(struct net_device *dev,
+			       __be16 proto, u16 vid)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	u32 idx = (vid & 0xf);
+
+	if (!((fe_reg_table[FE_REG_FE_DMA_VID_BASE]) &&
+	      (dev->features & NETIF_F_HW_VLAN_CTAG_TX)))
+		return 0;
+
+	clear_bit(idx, &priv->vlan_map);
+
+	return 0;
+}
+
+static inline u32 fe_pdma_empty_txd(struct fe_tx_ring *ring)
+{
+	barrier();
+	return (u32)(ring->tx_ring_size -
+			((ring->tx_next_idx - ring->tx_free_idx) &
+			 (ring->tx_ring_size - 1)));
+}
+
+static int fe_skb_padto(struct sk_buff *skb, struct fe_priv *priv)
+{
+	unsigned int len;
+	int ret;
+
+	if (unlikely(skb->len >= VLAN_ETH_ZLEN))
+		return 0;
+
+	if ((priv->flags & FE_FLAG_PADDING_64B) &&
+	    !(priv->flags & FE_FLAG_PADDING_BUG))
+		return 0;
+
+	if (skb_vlan_tag_present(skb))
+		len = ETH_ZLEN;
+	else if (skb->protocol == cpu_to_be16(ETH_P_8021Q))
+		len = VLAN_ETH_ZLEN;
+	else if (!(priv->flags & FE_FLAG_PADDING_64B))
+		len = ETH_ZLEN;
+	else
+		return 0;
+
+	if (skb->len >= len)
+		return 0;
+
+	ret = skb_pad(skb, len - skb->len);
+	if (ret < 0)
+		return ret;
+	skb->len = len;
+	skb_set_tail_pointer(skb, len);
+
+	return ret;
+}
+
+static int fe_pdma_tx_map(struct sk_buff *skb, struct net_device *dev,
+			  int tx_num, struct fe_tx_ring *ring, bool gso)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct skb_frag_struct *frag;
+	struct fe_tx_dma txd, *ptxd;
+	struct fe_tx_buf *tx_buf;
+	dma_addr_t mapped_addr;
+	unsigned int nr_frags;
+	u32 def_txd4;
+	int i, j, k, frag_size, frag_map_size, offset;
+
+	if (fe_skb_padto(skb, priv)) {
+		netif_warn(priv, tx_err, dev, "tx padding failed!\n");
+		return -1;
+	}
+
+	tx_buf = &ring->tx_buf[ring->tx_next_idx];
+	memset(tx_buf, 0, sizeof(*tx_buf));
+	memset(&txd, 0, sizeof(txd));
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
+	/* init tx descriptor */
+	def_txd4 = priv->soc->txd4;
+	txd.txd4 = def_txd4;
+
+	/* TX Checksum offload */
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		txd.txd4 |= TX_DMA_CHKSUM;
+
+	/* VLAN header offload */
+	if (skb_vlan_tag_present(skb)) {
+		u16 tag = skb_vlan_tag_get(skb);
+
+		txd.txd4 |= TX_DMA_INS_VLAN |
+			    ((tag >> VLAN_PRIO_SHIFT) << 4) |
+			    (tag & 0xF);
+	}
+
+	mapped_addr = dma_map_single(&dev->dev, skb->data,
+				     skb_headlen(skb), DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(&dev->dev, mapped_addr)))
+		return -1;
+
+	txd.txd1 = mapped_addr;
+	txd.txd2 = TX_DMA_PLEN0(skb_headlen(skb));
+
+	tx_buf->flags |= FE_TX_FLAGS_SINGLE0;
+	dma_unmap_addr_set(tx_buf, dma_addr0, mapped_addr);
+	dma_unmap_len_set(tx_buf, dma_len0, skb_headlen(skb));
+
+	/* TX SG offload */
+	j = ring->tx_next_idx;
+	k = 0;
+	for (i = 0; i < nr_frags; i++) {
+		offset = 0;
+		frag = &skb_shinfo(skb)->frags[i];
+		frag_size = skb_frag_size(frag);
+
+		while (frag_size > 0) {
+			frag_map_size = min(frag_size, TX_DMA_BUF_LEN);
+			mapped_addr = skb_frag_dma_map(&dev->dev, frag, offset,
+						       frag_map_size,
+						       DMA_TO_DEVICE);
+			if (unlikely(dma_mapping_error(&dev->dev, mapped_addr)))
+				goto err_dma;
+
+			if (k & 0x1) {
+				j = NEXT_TX_DESP_IDX(j);
+				txd.txd1 = mapped_addr;
+				txd.txd2 = TX_DMA_PLEN0(frag_map_size);
+				txd.txd4 = def_txd4;
+
+				tx_buf = &ring->tx_buf[j];
+				memset(tx_buf, 0, sizeof(*tx_buf));
+
+				tx_buf->flags |= FE_TX_FLAGS_PAGE0;
+				dma_unmap_addr_set(tx_buf, dma_addr0,
+						   mapped_addr);
+				dma_unmap_len_set(tx_buf, dma_len0,
+						  frag_map_size);
+			} else {
+				txd.txd3 = mapped_addr;
+				txd.txd2 |= TX_DMA_PLEN1(frag_map_size);
+
+				tx_buf->skb = (struct sk_buff *)DMA_DUMMY_DESC;
+				tx_buf->flags |= FE_TX_FLAGS_PAGE1;
+				dma_unmap_addr_set(tx_buf, dma_addr1,
+						   mapped_addr);
+				dma_unmap_len_set(tx_buf, dma_len1,
+						  frag_map_size);
+
+				if (!((i == (nr_frags - 1)) &&
+				      (frag_map_size == frag_size))) {
+					fe_set_txd_pdma(&txd, &ring->tx_dma[j]);
+					memset(&txd, 0, sizeof(txd));
+				}
+			}
+			frag_size -= frag_map_size;
+			offset += frag_map_size;
+			k++;
+		}
+	}
+
+	/* set last segment */
+	if (k & 0x1)
+		txd.txd2 |= TX_DMA_LS1;
+	else
+		txd.txd2 |= TX_DMA_LS0;
+	fe_set_txd_pdma(&txd, &ring->tx_dma[j]);
+
+	/* store skb to cleanup */
+	tx_buf->skb = skb;
+
+	netdev_sent_queue(dev, skb->len);
+	skb_tx_timestamp(skb);
+
+	ring->tx_next_idx = NEXT_TX_DESP_IDX(j);
+	/* make sure that all changes to the dma ring are flushed before we
+	 * continue
+	 */
+	wmb();
+	atomic_set(&ring->tx_free_count, fe_pdma_empty_txd(ring));
+
+	if (netif_xmit_stopped(netdev_get_tx_queue(dev, 0)) || !skb->xmit_more)
+		fe_reg_w32(ring->tx_next_idx, FE_REG_TX_CTX_IDX0);
+
+	return 0;
+
+err_dma:
+	j = ring->tx_next_idx;
+	for (i = 0; i < tx_num; i++) {
+		ptxd = &ring->tx_dma[j];
+		tx_buf = &ring->tx_buf[j];
+
+		/* unmap dma */
+		fe_txd_unmap(&dev->dev, tx_buf);
+
+		ptxd->txd2 = TX_DMA_DESP2_DEF;
+		j = NEXT_TX_DESP_IDX(j);
+	}
+	/* make sure that all changes to the dma ring are flushed before we
+	 * continue
+	 */
+	wmb();
+	return -1;
+}
+
+static void *fe_qdma_phys_to_virt(struct fe_tx_ring *ring, u32 desc)
+{
+	void *ret = ring->tx_dma;
+
+	return ret + (desc - ring->tx_phys);
+}
+
+static int fe_qdma_desc_to_index(struct fe_tx_ring *ring,
+				 struct fe_tx_dma *desc)
+{
+	return desc - ring->tx_dma;
+}
+
+static struct fe_tx_dma *fe_tx_next_qdma(struct fe_tx_ring *ring,
+					 struct fe_tx_dma *txd)
+{
+	return fe_qdma_phys_to_virt(ring, txd->txd2);
+}
+
+static struct fe_tx_buf *fe_desc_to_tx_buf(struct fe_tx_ring *ring,
+					   struct fe_tx_dma *txd)
+{
+	int idx = fe_qdma_desc_to_index(ring, txd);
+
+	return &ring->tx_buf[idx];
+}
+
+static int fe_qdma_tx_map(struct sk_buff *skb, struct net_device *dev,
+			  int tx_num, struct fe_tx_ring *ring, bool gso)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct fe_tx_dma *itxd, *txd;
+	struct fe_tx_buf *tx_buf;
+	dma_addr_t mapped_addr;
+	unsigned int nr_frags;
+	int i, n_desc = 1;
+	u32 txd4 = priv->soc->txd4;
+
+	itxd = ring->tx_next_free;
+	if (itxd == ring->tx_last_free)
+		return -ENOMEM;
+
+	tx_buf = fe_desc_to_tx_buf(ring, itxd);
+	memset(tx_buf, 0, sizeof(*tx_buf));
+
+	if (gso)
+		txd4 |= TX_DMA_TSO;
+
+	/* TX Checksum offload */
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		txd4 |= TX_DMA_CHKSUM;
+
+	/* VLAN header offload */
+	if (skb_vlan_tag_present(skb))
+		txd4 |= TX_DMA_INS_VLAN_MT7621 | skb_vlan_tag_get(skb);
+
+	mapped_addr = dma_map_single(&dev->dev, skb->data,
+				     skb_headlen(skb), DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(&dev->dev, mapped_addr)))
+		return -ENOMEM;
+
+	WRITE_ONCE(itxd->txd1, mapped_addr);
+	tx_buf->flags |= FE_TX_FLAGS_SINGLE0;
+	dma_unmap_addr_set(tx_buf, dma_addr0, mapped_addr);
+	dma_unmap_len_set(tx_buf, dma_len0, skb_headlen(skb));
+
+	/* TX SG offload */
+	txd = itxd;
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	for (i = 0; i < nr_frags; i++) {
+		struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[i];
+		unsigned int offset = 0;
+		int frag_size = skb_frag_size(frag);
+
+		while (frag_size) {
+			bool last_frag = false;
+			unsigned int frag_map_size;
+
+			txd = fe_tx_next_qdma(ring, txd);
+			if (txd == ring->tx_last_free)
+				goto err_dma;
+
+			n_desc++;
+			frag_map_size = min(frag_size, TX_DMA_BUF_LEN);
+			mapped_addr = skb_frag_dma_map(&dev->dev, frag, offset,
+						       frag_map_size,
+						       DMA_TO_DEVICE);
+			if (unlikely(dma_mapping_error(&dev->dev, mapped_addr)))
+				goto err_dma;
+
+			if (i == nr_frags - 1 &&
+			    (frag_size - frag_map_size) == 0)
+				last_frag = true;
+
+			WRITE_ONCE(txd->txd1, mapped_addr);
+			WRITE_ONCE(txd->txd3, (QDMA_TX_SWC |
+					       TX_DMA_PLEN0(frag_map_size) |
+					       last_frag * TX_DMA_LS0));
+			WRITE_ONCE(txd->txd4, 0);
+
+			tx_buf->skb = (struct sk_buff *)DMA_DUMMY_DESC;
+			tx_buf = fe_desc_to_tx_buf(ring, txd);
+			memset(tx_buf, 0, sizeof(*tx_buf));
+
+			tx_buf->flags |= FE_TX_FLAGS_PAGE0;
+			dma_unmap_addr_set(tx_buf, dma_addr0, mapped_addr);
+			dma_unmap_len_set(tx_buf, dma_len0, frag_map_size);
+			frag_size -= frag_map_size;
+			offset += frag_map_size;
+		}
+	}
+
+	/* store skb to cleanup */
+	tx_buf->skb = skb;
+
+	WRITE_ONCE(itxd->txd4, txd4);
+	WRITE_ONCE(itxd->txd3, (QDMA_TX_SWC | TX_DMA_PLEN0(skb_headlen(skb)) |
+				(!nr_frags * TX_DMA_LS0)));
+
+	netdev_sent_queue(dev, skb->len);
+	skb_tx_timestamp(skb);
+
+	ring->tx_next_free = fe_tx_next_qdma(ring, txd);
+	atomic_sub(n_desc, &ring->tx_free_count);
+
+	/* make sure that all changes to the dma ring are flushed before we
+	 * continue
+	 */
+	wmb();
+
+	if (netif_xmit_stopped(netdev_get_tx_queue(dev, 0)) || !skb->xmit_more)
+		fe_w32(txd->txd2, FE_QTX_CTX_PTR);
+
+	return 0;
+
+err_dma:
+	do {
+		tx_buf = fe_desc_to_tx_buf(ring, txd);
+
+		/* unmap dma */
+		fe_txd_unmap(&dev->dev, tx_buf);
+
+		itxd->txd3 = TX_DMA_DESP2_DEF;
+		itxd = fe_tx_next_qdma(ring, itxd);
+	} while (itxd != txd);
+
+	return -ENOMEM;
+}
+
+static inline int fe_cal_txd_req(struct sk_buff *skb)
+{
+	int i, nfrags;
+	struct skb_frag_struct *frag;
+
+	nfrags = 1;
+	if (skb_is_gso(skb)) {
+		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+			frag = &skb_shinfo(skb)->frags[i];
+			nfrags += DIV_ROUND_UP(frag->size, TX_DMA_BUF_LEN);
+		}
+	} else {
+		nfrags += skb_shinfo(skb)->nr_frags;
+	}
+
+	return DIV_ROUND_UP(nfrags, 2);
+}
+
+static int fe_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct fe_tx_ring *ring = &priv->tx_ring;
+	struct net_device_stats *stats = &dev->stats;
+	int tx_num;
+	int len = skb->len;
+	bool gso = false;
+
+	tx_num = fe_cal_txd_req(skb);
+	if (unlikely(atomic_read(&ring->tx_free_count) <= tx_num)) {
+		netif_stop_queue(dev);
+		netif_err(priv, tx_queued, dev,
+			  "Tx Ring full when queue awake!\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	/* TSO: fill MSS info in tcp checksum field */
+	if (skb_is_gso(skb)) {
+		if (skb_cow_head(skb, 0)) {
+			netif_warn(priv, tx_err, dev,
+				   "GSO expand head fail.\n");
+			goto drop;
+		}
+
+		if (skb_shinfo(skb)->gso_type &
+				(SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+			gso = true;
+			tcp_hdr(skb)->check = htons(skb_shinfo(skb)->gso_size);
+		}
+	}
+
+	if (ring->tx_map(skb, dev, tx_num, ring, gso) < 0)
+		goto drop;
+
+	stats->tx_packets++;
+	stats->tx_bytes += len;
+
+	if (unlikely(atomic_read(&ring->tx_free_count) <= ring->tx_thresh)) {
+		netif_stop_queue(dev);
+		smp_mb();
+		if (unlikely(atomic_read(&ring->tx_free_count) >
+			     ring->tx_thresh))
+			netif_wake_queue(dev);
+	}
+
+	return NETDEV_TX_OK;
+
+drop:
+	stats->tx_dropped++;
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static int fe_poll_rx(struct napi_struct *napi, int budget,
+		      struct fe_priv *priv, u32 rx_intr)
+{
+	struct net_device *netdev = priv->netdev;
+	struct net_device_stats *stats = &netdev->stats;
+	struct fe_soc_data *soc = priv->soc;
+	struct fe_rx_ring *ring = &priv->rx_ring_p;
+	int idx = ring->rx_calc_idx;
+	u32 checksum_bit;
+	struct sk_buff *skb;
+	u8 *data, *new_data;
+	struct fe_rx_dma *rxd, trxd;
+	int done = 0, pad;
+
+	if (netdev->features & NETIF_F_RXCSUM)
+		checksum_bit = soc->checksum_bit;
+	else
+		checksum_bit = 0;
+
+	if (priv->flags & FE_FLAG_RX_2B_OFFSET)
+		pad = 0;
+	else
+		pad = NET_IP_ALIGN;
+
+	while (done < budget) {
+		unsigned int pktlen;
+		dma_addr_t dma_addr;
+
+		idx = NEXT_RX_DESP_IDX(idx);
+		rxd = &ring->rx_dma[idx];
+		data = ring->rx_data[idx];
+
+		fe_get_rxd(&trxd, rxd);
+		if (!(trxd.rxd2 & RX_DMA_DONE))
+			break;
+
+		/* alloc new buffer */
+		new_data = napi_alloc_frag(ring->frag_size);
+		if (unlikely(!new_data)) {
+			stats->rx_dropped++;
+			goto release_desc;
+		}
+		dma_addr = dma_map_single(&netdev->dev,
+					  new_data + NET_SKB_PAD + pad,
+					  ring->rx_buf_size,
+					  DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(&netdev->dev, dma_addr))) {
+			put_page(virt_to_head_page(new_data));
+			goto release_desc;
+		}
+
+		/* receive data */
+		skb = build_skb(data, ring->frag_size);
+		if (unlikely(!skb)) {
+			put_page(virt_to_head_page(new_data));
+			goto release_desc;
+		}
+		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
+
+		dma_unmap_single(&netdev->dev, trxd.rxd1,
+				 ring->rx_buf_size, DMA_FROM_DEVICE);
+		pktlen = RX_DMA_GET_PLEN0(trxd.rxd2);
+		skb->dev = netdev;
+		skb_put(skb, pktlen);
+		if (trxd.rxd4 & checksum_bit)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		else
+			skb_checksum_none_assert(skb);
+		skb->protocol = eth_type_trans(skb, netdev);
+
+		stats->rx_packets++;
+		stats->rx_bytes += pktlen;
+
+		if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX &&
+		    trxd.rxd2 & TX_DMA_TAG) {
+			u16 vid = trxd.rxd3 & TX_DMA_TAG_MASK;
+
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+		}
+		napi_gro_receive(napi, skb);
+
+		ring->rx_data[idx] = new_data;
+		rxd->rxd1 = (unsigned int)dma_addr;
+
+release_desc:
+		if (priv->flags & FE_FLAG_RX_SG_DMA)
+			rxd->rxd2 = RX_DMA_PLEN0(ring->rx_buf_size);
+		else
+			rxd->rxd2 = RX_DMA_LSO;
+
+		ring->rx_calc_idx = idx;
+		/* make sure that all changes to the dma ring are flushed before
+		 * we continue
+		 */
+		wmb();
+		fe_reg_w32(ring->rx_calc_idx, FE_REG_RX_CALC_IDX0);
+		done++;
+	}
+
+	if (done < budget)
+		fe_irq_ack(priv, rx_intr);
+
+	return done;
+}
+
+static int fe_pdma_tx_poll(struct fe_priv *priv, int budget, bool *tx_again,
+			   unsigned int *bytes)
+{
+	struct net_device *netdev = priv->netdev;
+	struct device *dev = &netdev->dev;
+	struct sk_buff *skb;
+	struct fe_tx_buf *tx_buf;
+	int done = 0;
+	u32 idx, hwidx;
+	struct fe_tx_ring *ring = &priv->tx_ring;
+
+	idx = ring->tx_free_idx;
+	hwidx = fe_reg_r32(FE_REG_TX_DTX_IDX0);
+
+	while ((idx != hwidx) && budget) {
+		tx_buf = &ring->tx_buf[idx];
+		skb = tx_buf->skb;
+
+		if (!skb)
+			break;
+
+		if (skb != (struct sk_buff *)DMA_DUMMY_DESC) {
+			*bytes += skb->len;
+			done++;
+			budget--;
+		}
+		fe_txd_unmap(dev, tx_buf);
+		idx = NEXT_TX_DESP_IDX(idx);
+	}
+	ring->tx_free_idx = idx;
+	atomic_set(&ring->tx_free_count, fe_pdma_empty_txd(ring));
+
+	/* read hw index again make sure no new tx packet */
+	if (idx != hwidx || idx != fe_reg_r32(FE_REG_TX_DTX_IDX0))
+		*tx_again = 1;
+
+	return done;
+}
+
+static int fe_qdma_tx_poll(struct fe_priv *priv, int budget, bool *tx_again,
+			   unsigned int *bytes)
+{
+	struct net_device *netdev = priv->netdev;
+	struct fe_tx_ring *ring = &priv->tx_ring;
+	struct device *dev = &netdev->dev;
+	struct fe_tx_dma *desc;
+	struct sk_buff *skb;
+	struct fe_tx_buf *tx_buf;
+	int done = 0;
+	u32 cpu, dma;
+	static int condition;
+
+	cpu = fe_r32(FE_QTX_CRX_PTR);
+	dma = fe_r32(FE_QTX_DRX_PTR);
+
+	desc = fe_qdma_phys_to_virt(ring, cpu);
+
+	while ((cpu != dma) && budget) {
+		u32 next_cpu = desc->txd2;
+
+		desc = fe_tx_next_qdma(ring, desc);
+		if ((desc->txd3 & QDMA_TX_OWNER_CPU) == 0)
+			break;
+
+		tx_buf = fe_desc_to_tx_buf(ring, desc);
+		skb = tx_buf->skb;
+		if (!skb) {
+			condition = 1;
+			break;
+		}
+
+		if (skb != (struct sk_buff *)DMA_DUMMY_DESC) {
+			*bytes += skb->len;
+			done++;
+			budget--;
+		}
+		fe_txd_unmap(dev, tx_buf);
+
+		ring->tx_last_free->txd2 = next_cpu;
+		ring->tx_last_free = desc;
+		atomic_inc(&ring->tx_free_count);
+
+		cpu = next_cpu;
+	}
+
+	fe_w32(cpu, FE_QTX_CRX_PTR);
+
+	/* read hw index again make sure no new tx packet */
+	if (cpu != dma || cpu != fe_r32(FE_QTX_DRX_PTR))
+		*tx_again = true;
+
+	return done;
+}
+
+static int fe_poll_tx(struct fe_priv *priv, int budget, u32 tx_intr,
+		      bool *tx_again)
+{
+	struct fe_tx_ring *ring = &priv->tx_ring;
+	struct net_device *netdev = priv->netdev;
+	int done, bytes_compl = 0;
+
+	done = priv->tx_ring.tx_poll(priv, budget, tx_again, &bytes_compl);
+	if (!*tx_again)
+		fe_irq_ack(priv, tx_intr);
+
+	if (!done)
+		return 0;
+
+	netdev_completed_queue(netdev, done, bytes_compl);
+	smp_mb();
+	if (unlikely(!netif_queue_stopped(netdev)))
+		return done;
+
+	if (atomic_read(&ring->tx_free_count) > ring->tx_thresh)
+		netif_wake_queue(netdev);
+
+	return done;
+}
+
+static int fe_poll(struct napi_struct *napi, int budget)
+{
+	struct fe_priv *priv = container_of(napi, struct fe_priv, rx_napi);
+	struct fe_hw_stats *hwstat = priv->hw_stats;
+	u32 status, fe_status, mask, tx_intr, rx_intr, status_intr;
+	int tx_done, rx_done;
+	bool tx_again = false;
+
+	status = fe_irq_pending(priv);
+	fe_status = fe_irq_pending_status(priv);
+	tx_intr = priv->soc->tx_int;
+	rx_intr = priv->soc->rx_int;
+	status_intr = priv->soc->status_int;
+	tx_done = 0;
+	rx_done = 0;
+	tx_again = 0;
+
+	if (status & tx_intr)
+		tx_done = fe_poll_tx(priv, budget, tx_intr, &tx_again);
+
+	if (status & rx_intr)
+		rx_done = fe_poll_rx(napi, budget, priv, rx_intr);
+
+	if (unlikely(fe_status & status_intr)) {
+		if (hwstat && spin_trylock(&hwstat->stats_lock)) {
+			fe_stats_update(priv);
+			spin_unlock(&hwstat->stats_lock);
+		}
+		fe_irq_ack_status(priv, status_intr);
+	}
+
+	if (unlikely(netif_msg_intr(priv))) {
+		mask = fe_irq_enabled(priv);
+		netdev_info(priv->netdev,
+			    "done tx %d, rx %d, intr 0x%08x/0x%x\n",
+			    tx_done, rx_done, status, mask);
+	}
+
+	if (tx_again || rx_done == budget)
+		return budget;
+
+	status = fe_irq_pending(priv);
+	if (status & (tx_intr | rx_intr))
+		return budget;
+
+	napi_complete(napi);
+	fe_irq_enable(priv, tx_intr | rx_intr);
+
+	return rx_done;
+}
+
+static int fe_pdma_tx_alloc(struct fe_priv *priv)
+{
+	int i;
+	struct fe_tx_ring *ring = &priv->tx_ring;
+
+	ring->tx_ring_size = NUM_DMA_DESC;
+	if (priv->flags & FE_FLAG_NAPI_WEIGHT)
+		ring->tx_ring_size *= 4;
+
+	ring->tx_free_idx = 0;
+	ring->tx_next_idx = 0;
+	ring->tx_thresh = max((unsigned long)ring->tx_ring_size >> 2,
+			      MAX_SKB_FRAGS);
+
+	ring->tx_buf = kcalloc(ring->tx_ring_size, sizeof(*ring->tx_buf),
+			GFP_KERNEL);
+	if (!ring->tx_buf)
+		goto no_tx_mem;
+
+	ring->tx_dma = dma_alloc_coherent(&priv->netdev->dev,
+			ring->tx_ring_size * sizeof(*ring->tx_dma),
+			&ring->tx_phys,
+			GFP_ATOMIC | __GFP_ZERO);
+	if (!ring->tx_dma)
+		goto no_tx_mem;
+
+	for (i = 0; i < ring->tx_ring_size; i++) {
+		ring->tx_dma[i].txd2 = TX_DMA_DESP2_DEF;
+		ring->tx_dma[i].txd4 = priv->soc->txd4;
+	}
+
+	atomic_set(&ring->tx_free_count, fe_pdma_empty_txd(ring));
+	ring->tx_map = fe_pdma_tx_map;
+	ring->tx_poll = fe_pdma_tx_poll;
+	ring->tx_clean = fe_pdma_tx_clean;
+
+	/* make sure that all changes to the dma ring are flushed before we
+	 * continue
+	 */
+	wmb();
+
+	fe_reg_w32(ring->tx_phys, FE_REG_TX_BASE_PTR0);
+	fe_reg_w32(ring->tx_ring_size, FE_REG_TX_MAX_CNT0);
+	fe_reg_w32(0, FE_REG_TX_CTX_IDX0);
+	fe_reg_w32(FE_PST_DTX_IDX0, FE_REG_PDMA_RST_CFG);
+
+	return 0;
+
+no_tx_mem:
+	return -ENOMEM;
+}
+
+/* the qdma core needs scratch memory to be setup */
+static int fq_init_fq_dma(struct fe_priv *priv)
+{
+	unsigned int phy_ring_head, phy_ring_tail, phy_scratch_head;
+	struct fe_tx_dma *ring_head;
+	int cnt = NUM_DMA_DESC;
+	dma_addr_t dma_addr;
+	void *scratch_head;
+	int i;
+
+	ring_head = dma_alloc_coherent(&priv->netdev->dev,
+				       cnt * sizeof(struct fe_tx_dma),
+				       &phy_ring_head,
+				       GFP_ATOMIC | __GFP_ZERO);
+	if (unlikely(!ring_head))
+		return -ENOMEM;
+
+	scratch_head = kcalloc(cnt, QDMA_PAGE_SIZE,
+			       GFP_KERNEL);
+	dma_addr = dma_map_single(&priv->netdev->dev,
+				  scratch_head, cnt * QDMA_PAGE_SIZE,
+				  DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(&priv->netdev->dev, dma_addr)))
+		return -ENOMEM;
+
+	memset(ring_head, 0x0, sizeof(struct fe_tx_dma) * cnt);
+	phy_ring_tail = phy_ring_head + (sizeof(struct fe_tx_dma) * (cnt - 1));
+
+	for (i = 0; i < cnt; i++) {
+		ring_head[i].txd1 = (phy_scratch_head + (i * QDMA_PAGE_SIZE));
+		if (i < cnt - 1)
+			ring_head[i].txd2 = (phy_ring_head +
+					((i + 1) * sizeof(struct fe_tx_dma)));
+		ring_head[i].txd3 = TX_QDMA_SDL(QDMA_PAGE_SIZE);
+	}
+
+	fe_w32(phy_ring_head, FE_QDMA_FQ_HEAD);
+	fe_w32(phy_ring_tail, FE_QDMA_FQ_TAIL);
+	fe_w32((cnt << 16) | cnt, FE_QDMA_FQ_CNT);
+	fe_w32(QDMA_PAGE_SIZE << 16, FE_QDMA_FQ_BLEN);
+
+	return 0;
+}
+
+static int fe_qdma_tx_alloc_tx(struct fe_priv *priv)
+{
+	struct fe_tx_ring *ring = &priv->tx_ring;
+	int i;
+
+	ring->tx_ring_size = NUM_DMA_DESC;
+	if (priv->flags & FE_FLAG_NAPI_WEIGHT)
+		ring->tx_ring_size *= 4;
+
+	ring->tx_buf = kcalloc(ring->tx_ring_size, sizeof(*ring->tx_buf),
+			GFP_KERNEL);
+	if (!ring->tx_buf)
+		goto no_tx_mem;
+
+	ring->tx_dma = dma_alloc_coherent(&priv->netdev->dev,
+			ring->tx_ring_size * sizeof(*ring->tx_dma),
+			&ring->tx_phys,
+			GFP_ATOMIC | __GFP_ZERO);
+	if (!ring->tx_dma)
+		goto no_tx_mem;
+
+	memset(ring->tx_dma, 0, ring->tx_ring_size * sizeof(*ring->tx_dma));
+	for (i = 0; i < ring->tx_ring_size; i++) {
+		int next = (i + 1) % ring->tx_ring_size;
+		u32 next_ptr = ring->tx_phys + next * sizeof(*ring->tx_dma);
+
+		ring->tx_dma[i].txd2 = next_ptr;
+		ring->tx_dma[i].txd3 = TX_DMA_DESP2_DEF;
+	}
+
+	atomic_set(&ring->tx_free_count, ring->tx_ring_size - 2);
+	ring->tx_next_free = &ring->tx_dma[0];
+	ring->tx_last_free = &ring->tx_dma[ring->tx_ring_size - 2];
+	ring->tx_thresh = max((unsigned long)ring->tx_ring_size >> 2,
+			      MAX_SKB_FRAGS);
+
+	ring->tx_map = fe_qdma_tx_map;
+	ring->tx_poll = fe_qdma_tx_poll;
+	ring->tx_clean = fe_qdma_tx_clean;
+
+	/* make sure that all changes to the dma ring are flushed before we
+	 * continue
+	 */
+	wmb();
+
+	fe_w32(ring->tx_phys, FE_QTX_CTX_PTR);
+	fe_w32(ring->tx_phys, FE_QTX_DTX_PTR);
+	fe_w32(ring->tx_phys + ((ring->tx_ring_size - 1) * sizeof(*ring->tx_dma)),
+	       FE_QTX_CRX_PTR);
+	fe_w32(ring->tx_phys + ((ring->tx_ring_size - 1) * sizeof(*ring->tx_dma)),
+	       FE_QTX_DRX_PTR);
+
+	return 0;
+
+no_tx_mem:
+	return -ENOMEM;
+}
+
+static int fe_qdma_init(struct fe_priv *priv)
+{
+	int err;
+
+	err = fq_init_fq_dma(priv);
+	if (err)
+		return err;
+
+	err = fe_qdma_tx_alloc_tx(priv);
+	if (err)
+		return err;
+
+	err = fe_dma_rx_alloc(priv, &priv->rx_ring_q);
+	if (err)
+		return err;
+
+	fe_w32(priv->rx_ring_q.rx_phys, FE_QRX_BASE_PTR0);
+	fe_w32(priv->rx_ring_q.rx_ring_size, FE_QRX_MAX_CNT0);
+	fe_w32(priv->rx_ring_q.rx_calc_idx, FE_QRX_CRX_IDX0);
+	fe_w32(FE_PST_DRX_IDX0, FE_QDMA_RST_IDX);
+
+	err = fe_dma_rx_alloc(priv, &priv->rx_ring_p);
+	if (err)
+		return err;
+
+	fe_reg_w32(priv->rx_ring_p.rx_phys, FE_REG_RX_BASE_PTR0);
+	fe_reg_w32(priv->rx_ring_p.rx_ring_size, FE_REG_RX_MAX_CNT0);
+	fe_reg_w32(priv->rx_ring_p.rx_calc_idx, FE_REG_RX_CALC_IDX0);
+	fe_reg_w32(FE_PST_DRX_IDX0, FE_REG_PDMA_RST_CFG);
+
+	/* Enable randon early drop and set drop threshold automatically */
+	fe_w32(0x174444, FE_QDMA_FC_THRES);
+	fe_w32(0x0, FE_QDMA_HRED2);
+
+	return 0;
+}
+
+static int fe_pdma_init(struct fe_priv *priv)
+{
+	struct fe_rx_ring *ring = &priv->rx_ring_p;
+	int err;
+
+	err = fe_pdma_tx_alloc(priv);
+	if (err)
+		return err;
+
+	err = fe_dma_rx_alloc(priv, ring);
+	if (err)
+		return err;
+
+	fe_reg_w32(ring->rx_phys, FE_REG_RX_BASE_PTR0);
+	fe_reg_w32(ring->rx_ring_size, FE_REG_RX_MAX_CNT0);
+	fe_reg_w32(ring->rx_calc_idx, FE_REG_RX_CALC_IDX0);
+	fe_reg_w32(FE_PST_DRX_IDX0, FE_REG_PDMA_RST_CFG);
+
+	return 0;
+}
+
+static void fe_dma_free(struct fe_priv *priv)
+{
+	priv->tx_ring.tx_clean(priv);
+	netdev_reset_queue(priv->netdev);
+	fe_clean_rx(priv, &priv->rx_ring_p);
+	fe_clean_rx(priv, &priv->rx_ring_q);
+}
+
+static void fe_tx_timeout(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct fe_tx_ring *ring = &priv->tx_ring;
+
+	priv->netdev->stats.tx_errors++;
+	netif_err(priv, tx_err, dev,
+		  "transmit timed out\n");
+	if (priv->soc->dma_type & FE_PDMA) {
+		netif_info(priv, drv, dev, "pdma_cfg:%08x\n",
+			   fe_reg_r32(FE_REG_PDMA_GLO_CFG));
+		netif_info(priv, drv, dev, "tx_ring=%d, "
+			   "base=%08x, max=%u, ctx=%u, dtx=%u, fdx=%hu, next=%hu\n",
+			   0, fe_reg_r32(FE_REG_TX_BASE_PTR0),
+			   fe_reg_r32(FE_REG_TX_MAX_CNT0),
+			   fe_reg_r32(FE_REG_TX_CTX_IDX0),
+			   fe_reg_r32(FE_REG_TX_DTX_IDX0),
+			   ring->tx_free_idx,
+			   ring->tx_next_idx);
+	}
+	if (priv->soc->dma_type & FE_QDMA) {
+		netif_info(priv, drv, dev, "qdma_cfg:%08x\n",
+			   fe_r32(FE_QDMA_GLO_CFG));
+		netif_info(priv, drv, dev, "tx_ring=%d, "
+			   "ctx=%08x, dtx=%08x, crx=%08x, drx=%08x, free=%hu\n",
+			   0, fe_r32(FE_QTX_CTX_PTR),
+			   fe_r32(FE_QTX_DTX_PTR),
+			   fe_r32(FE_QTX_CRX_PTR),
+			   fe_r32(FE_QTX_DRX_PTR),
+			   atomic_read(&ring->tx_free_count));
+	}
+	netif_info(priv, drv, dev,
+		   "rx_ring=%d, base=%08x, max=%u, calc=%u, drx=%u\n",
+		   0, fe_reg_r32(FE_REG_RX_BASE_PTR0),
+		   fe_reg_r32(FE_REG_RX_MAX_CNT0),
+		   fe_reg_r32(FE_REG_RX_CALC_IDX0),
+		   fe_reg_r32(FE_REG_RX_DRX_IDX0));
+
+	if (!test_and_set_bit(FE_FLAG_RESET_PENDING, priv->pending_flags))
+		schedule_work(&priv->pending_work);
+}
+
+static irqreturn_t fe_handle_irq(int irq, void *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	u32 status, int_mask;
+
+	status = fe_irq_pending(priv);
+	if (unlikely(!status))
+		return IRQ_NONE;
+
+	int_mask = (priv->soc->rx_int | priv->soc->tx_int);
+	if (likely(status & int_mask)) {
+		if (likely(napi_schedule_prep(&priv->rx_napi)))
+			__napi_schedule(&priv->rx_napi);
+	} else {
+		fe_irq_ack(priv, status);
+	}
+	fe_irq_disable(priv, int_mask);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fe_poll_controller(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	u32 int_mask = priv->soc->tx_int | priv->soc->rx_int;
+
+	fe_irq_disable(priv, int_mask);
+	fe_handle_irq(dev->irq, dev);
+	fe_irq_enable(priv, int_mask);
+}
+#endif
+
+int fe_set_clock_cycle(struct fe_priv *priv)
+{
+	unsigned long sysclk = priv->sysclk;
+
+	sysclk /= FE_US_CYC_CNT_DIVISOR;
+	sysclk <<= FE_US_CYC_CNT_SHIFT;
+
+	fe_w32((fe_r32(FE_FE_GLO_CFG) &
+			~(FE_US_CYC_CNT_MASK << FE_US_CYC_CNT_SHIFT)) |
+			sysclk,
+			FE_FE_GLO_CFG);
+	return 0;
+}
+
+void fe_fwd_config(struct fe_priv *priv)
+{
+	u32 fwd_cfg;
+
+	fwd_cfg = fe_r32(FE_GDMA1_FWD_CFG);
+
+	/* disable jumbo frame */
+	if (priv->flags & FE_FLAG_JUMBO_FRAME)
+		fwd_cfg &= ~FE_GDM1_JMB_EN;
+
+	/* set unicast/multicast/broadcast frame to cpu */
+	fwd_cfg &= ~0xffff;
+
+	fe_w32(fwd_cfg, FE_GDMA1_FWD_CFG);
+}
+
+static void fe_rxcsum_config(bool enable)
+{
+	if (enable)
+		fe_w32(fe_r32(FE_GDMA1_FWD_CFG) | (FE_GDM1_ICS_EN |
+					FE_GDM1_TCS_EN | FE_GDM1_UCS_EN),
+				FE_GDMA1_FWD_CFG);
+	else
+		fe_w32(fe_r32(FE_GDMA1_FWD_CFG) & ~(FE_GDM1_ICS_EN |
+					FE_GDM1_TCS_EN | FE_GDM1_UCS_EN),
+				FE_GDMA1_FWD_CFG);
+}
+
+static void fe_txcsum_config(bool enable)
+{
+	if (enable)
+		fe_w32(fe_r32(FE_CDMA_CSG_CFG) | (FE_ICS_GEN_EN |
+					FE_TCS_GEN_EN | FE_UCS_GEN_EN),
+				FE_CDMA_CSG_CFG);
+	else
+		fe_w32(fe_r32(FE_CDMA_CSG_CFG) & ~(FE_ICS_GEN_EN |
+					FE_TCS_GEN_EN | FE_UCS_GEN_EN),
+				FE_CDMA_CSG_CFG);
+}
+
+void fe_csum_config(struct fe_priv *priv)
+{
+	struct net_device *dev = priv_netdev(priv);
+
+	fe_txcsum_config((dev->features & NETIF_F_IP_CSUM));
+	fe_rxcsum_config((dev->features & NETIF_F_RXCSUM));
+}
+
+static int fe_hw_init(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	int i, err;
+
+	err = devm_request_irq(priv->device, dev->irq, fe_handle_irq, 0,
+			       dev_name(priv->device), dev);
+	if (err)
+		return err;
+
+	if (priv->soc->set_mac)
+		priv->soc->set_mac(priv, dev->dev_addr);
+	else
+		fe_hw_set_macaddr(priv, dev->dev_addr);
+
+	/* disable delay interrupt */
+	fe_reg_w32(0, FE_REG_DLY_INT_CFG);
+
+	fe_irq_disable(priv, priv->soc->tx_int | priv->soc->rx_int);
+
+	/* frame engine will push VLAN tag regarding to VIDX field in Tx desc */
+	if (fe_reg_table[FE_REG_FE_DMA_VID_BASE])
+		for (i = 0; i < 16; i += 2)
+			fe_w32(((i + 1) << 16) + i,
+			       fe_reg_table[FE_REG_FE_DMA_VID_BASE] +
+			       (i * 2));
+
+	if (priv->soc->fwd_config(priv))
+		netdev_err(dev, "unable to get clock\n");
+
+	if (fe_reg_table[FE_REG_FE_RST_GL]) {
+		fe_reg_w32(1, FE_REG_FE_RST_GL);
+		fe_reg_w32(0, FE_REG_FE_RST_GL);
+	}
+
+	return 0;
+}
+
+static int fe_open(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	u32 val;
+	int err;
+
+	if (priv->soc->dma_type == FE_PDMA)
+		err = fe_pdma_init(priv);
+	else
+		err = fe_qdma_init(priv);
+	if (err) {
+		fe_dma_free(priv);
+		return err;
+	}
+
+	spin_lock_irqsave(&priv->page_lock, flags);
+
+	val = FE_TX_WB_DDONE | FE_RX_DMA_EN | FE_TX_DMA_EN;
+	if (priv->flags & FE_FLAG_RX_2B_OFFSET)
+		val |= FE_RX_2B_OFFSET;
+	val |= priv->soc->pdma_glo_cfg;
+
+	if (priv->soc->dma_type & FE_PDMA)
+		fe_reg_w32(val, FE_REG_PDMA_GLO_CFG);
+
+	if (priv->soc->dma_type & FE_QDMA)
+		fe_w32(val, FE_QDMA_GLO_CFG);
+
+	spin_unlock_irqrestore(&priv->page_lock, flags);
+
+	if (priv->phy)
+		priv->phy->start(priv);
+
+	if (priv->soc->has_carrier && priv->soc->has_carrier(priv))
+		netif_carrier_on(dev);
+
+	napi_enable(&priv->rx_napi);
+	fe_irq_enable(priv, priv->soc->tx_int | priv->soc->rx_int);
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+static void fe_stop_dma(struct fe_priv *priv, u32 glo_cfg)
+{
+	unsigned long flags;
+	u32 val;
+	int i;
+
+	spin_lock_irqsave(&priv->page_lock, flags);
+	val = fe_r32(glo_cfg);
+	fe_w32(val & ~(FE_TX_WB_DDONE | FE_RX_DMA_EN | FE_TX_DMA_EN), glo_cfg);
+	spin_unlock_irqrestore(&priv->page_lock, flags);
+
+	/* wait dma stop */
+	for (i = 0; i < 10; i++) {
+		val = fe_r32(glo_cfg);
+		if (val & (FE_TX_DMA_BUSY | FE_RX_DMA_BUSY)) {
+			msleep(20);
+			continue;
+		}
+		break;
+	}
+}
+
+static int fe_stop(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	netif_tx_disable(dev);
+	fe_irq_disable(priv, priv->soc->tx_int | priv->soc->rx_int);
+	napi_disable(&priv->rx_napi);
+
+	if (priv->phy)
+		priv->phy->stop(priv);
+
+	if (priv->soc->dma_type & FE_PDMA)
+		fe_stop_dma(priv, priv->soc->reg_table[FE_REG_PDMA_GLO_CFG]);
+
+	if (priv->soc->dma_type & FE_QDMA)
+		fe_stop_dma(priv, FE_QDMA_GLO_CFG);
+
+	fe_dma_free(priv);
+
+	return 0;
+}
+
+static int __init fe_init(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	struct device_node *port;
+	const char *mac_addr;
+	int err;
+
+	priv->soc->reset_fe();
+
+	if (priv->soc->switch_init)
+		if (priv->soc->switch_init(priv)) {
+			netdev_err(dev, "failed to initialize switch core\n");
+			return -ENODEV;
+		}
+
+	mac_addr = of_get_mac_address(priv->device->of_node);
+	if (mac_addr)
+		ether_addr_copy(dev->dev_addr, mac_addr);
+
+	/* If the mac address is invalid, use random mac address  */
+	if (!is_valid_ether_addr(dev->dev_addr)) {
+		random_ether_addr(dev->dev_addr);
+		dev_err(priv->device, "generated random MAC address %pM\n",
+			dev->dev_addr);
+	}
+
+	err = fe_mdio_init(priv);
+	if (err)
+		return err;
+
+	if (priv->soc->port_init)
+		for_each_child_of_node(priv->device->of_node, port)
+			if (of_device_is_compatible(port,
+						    "mediatek,eth-port") &&
+			    of_device_is_available(port))
+				priv->soc->port_init(priv, port);
+
+	if (priv->phy) {
+		err = priv->phy->connect(priv);
+		if (err)
+			goto err_phy_disconnect;
+	}
+
+	err = fe_hw_init(dev);
+	if (!err)
+		return 0;
+
+err_phy_disconnect:
+	if (priv->phy)
+		priv->phy->disconnect(priv);
+	fe_mdio_cleanup(priv);
+
+	return err;
+}
+
+static void fe_uninit(struct net_device *dev)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	if (priv->phy)
+		priv->phy->disconnect(priv);
+	fe_mdio_cleanup(priv);
+
+	fe_irq_disable(priv, ~0);
+	free_irq(dev->irq, dev);
+}
+
+static int fe_do_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+
+	if (!priv->phy_dev)
+		return -ENODEV;
+
+	switch (cmd) {
+	case SIOCGMIIPHY:
+	case SIOCGMIIREG:
+	case SIOCSMIIREG:
+		return phy_mii_ioctl(priv->phy_dev, ifr, cmd);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int fe_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct fe_priv *priv = netdev_priv(dev);
+	int frag_size, old_mtu;
+	u32 fwd_cfg;
+
+	if (!(priv->flags & FE_FLAG_JUMBO_FRAME))
+		return eth_change_mtu(dev, new_mtu);
+
+	frag_size = fe_max_frag_size(new_mtu);
+	if (new_mtu < 68 || frag_size > PAGE_SIZE)
+		return -EINVAL;
+
+	old_mtu = dev->mtu;
+	dev->mtu = new_mtu;
+
+	/* return early if the buffer sizes will not change */
+	if (old_mtu <= ETH_DATA_LEN && new_mtu <= ETH_DATA_LEN)
+		return 0;
+	if (old_mtu > ETH_DATA_LEN && new_mtu > ETH_DATA_LEN)
+		return 0;
+
+	if (new_mtu <= ETH_DATA_LEN)
+		priv->rx_ring_p.frag_size = fe_max_frag_size(ETH_DATA_LEN);
+	else
+		priv->rx_ring_p.frag_size = PAGE_SIZE;
+	priv->rx_ring_p.rx_buf_size =
+				fe_max_buf_size(priv->rx_ring_p.frag_size);
+
+	if (!netif_running(dev))
+		return 0;
+
+	fe_stop(dev);
+	fwd_cfg = fe_r32(FE_GDMA1_FWD_CFG);
+	if (new_mtu <= ETH_DATA_LEN) {
+		fwd_cfg &= ~FE_GDM1_JMB_EN;
+	} else {
+		fwd_cfg &= ~(FE_GDM1_JMB_LEN_MASK << FE_GDM1_JMB_LEN_SHIFT);
+		fwd_cfg |= (DIV_ROUND_UP(frag_size, 1024) <<
+				FE_GDM1_JMB_LEN_SHIFT) | FE_GDM1_JMB_EN;
+	}
+	fe_w32(fwd_cfg, FE_GDMA1_FWD_CFG);
+
+	return fe_open(dev);
+}
+
+static const struct net_device_ops fe_netdev_ops = {
+	.ndo_init		= fe_init,
+	.ndo_uninit		= fe_uninit,
+	.ndo_open		= fe_open,
+	.ndo_stop		= fe_stop,
+	.ndo_start_xmit		= fe_start_xmit,
+	.ndo_set_mac_address	= fe_set_mac_address,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_do_ioctl		= fe_do_ioctl,
+	.ndo_change_mtu		= fe_change_mtu,
+	.ndo_tx_timeout		= fe_tx_timeout,
+	.ndo_get_stats64        = fe_get_stats64,
+	.ndo_vlan_rx_add_vid	= fe_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= fe_vlan_rx_kill_vid,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= fe_poll_controller,
+#endif
+};
+
+static void fe_reset_pending(struct fe_priv *priv)
+{
+	struct net_device *dev = priv->netdev;
+	int err;
+
+	rtnl_lock();
+	fe_stop(dev);
+
+	err = fe_open(dev);
+	if (err) {
+		netif_alert(priv, ifup, dev,
+			    "Driver up/down cycle failed, closing device.\n");
+		dev_close(dev);
+	}
+	rtnl_unlock();
+}
+
+static const struct fe_work_t fe_work[] = {
+	{FE_FLAG_RESET_PENDING, fe_reset_pending},
+};
+
+static void fe_pending_work(struct work_struct *work)
+{
+	struct fe_priv *priv = container_of(work, struct fe_priv, pending_work);
+	int i;
+	bool pending;
+
+	for (i = 0; i < ARRAY_SIZE(fe_work); i++) {
+		pending = test_and_clear_bit(fe_work[i].bitnr,
+					     priv->pending_flags);
+		if (pending)
+			fe_work[i].action(priv);
+	}
+}
+
+static int fe_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	const struct of_device_id *match;
+	struct fe_soc_data *soc;
+	struct net_device *netdev;
+	struct fe_priv *priv;
+	struct clk *sysclk;
+	int err, napi_weight;
+
+	device_reset(&pdev->dev);
+
+	match = of_match_device(of_fe_match, &pdev->dev);
+	soc = (struct fe_soc_data *)match->data;
+
+	if (soc->reg_table)
+		fe_reg_table = soc->reg_table;
+	else
+		soc->reg_table = fe_reg_table;
+
+	fe_base = devm_ioremap_resource(&pdev->dev, res);
+	if (!fe_base) {
+		err = -EADDRNOTAVAIL;
+		goto err_out;
+	}
+
+	netdev = alloc_etherdev(sizeof(*priv));
+	if (!netdev) {
+		dev_err(&pdev->dev, "alloc_etherdev failed\n");
+		err = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	netdev->netdev_ops = &fe_netdev_ops;
+	netdev->base_addr = (unsigned long)fe_base;
+
+	netdev->irq = platform_get_irq(pdev, 0);
+	if (netdev->irq < 0) {
+		dev_err(&pdev->dev, "no IRQ resource found\n");
+		err = -ENXIO;
+		goto err_free_dev;
+	}
+
+	if (soc->init_data)
+		soc->init_data(soc, netdev);
+	netdev->vlan_features = netdev->hw_features &
+		~(NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
+	netdev->features |= netdev->hw_features;
+
+	/* fake rx vlan filter func. to support tx vlan offload func */
+	if (fe_reg_table[FE_REG_FE_DMA_VID_BASE])
+		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	priv = netdev_priv(netdev);
+	spin_lock_init(&priv->page_lock);
+	if (fe_reg_table[FE_REG_FE_COUNTER_BASE]) {
+		priv->hw_stats = kzalloc(sizeof(*priv->hw_stats), GFP_KERNEL);
+		if (!priv->hw_stats) {
+			err = -ENOMEM;
+			goto err_free_dev;
+		}
+		spin_lock_init(&priv->hw_stats->stats_lock);
+	}
+
+	sysclk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(sysclk)) {
+		priv->sysclk = clk_get_rate(sysclk);
+	} else if ((priv->flags & FE_FLAG_CALIBRATE_CLK)) {
+		dev_err(&pdev->dev, "this soc needs a clk for calibration\n");
+		err = -ENXIO;
+		goto err_free_dev;
+	}
+
+	priv->switch_np = of_parse_phandle(pdev->dev.of_node,
+					   "mediatek,switch", 0);
+	if ((priv->flags & FE_FLAG_HAS_SWITCH) && !priv->switch_np) {
+		dev_err(&pdev->dev, "failed to read switch phandle\n");
+		err = -ENODEV;
+		goto err_free_dev;
+	}
+
+	priv->netdev = netdev;
+	priv->device = &pdev->dev;
+	priv->soc = soc;
+	priv->msg_enable = netif_msg_init(fe_msg_level, FE_DEFAULT_MSG_ENABLE);
+	INIT_WORK(&priv->pending_work, fe_pending_work);
+
+	napi_weight = 32;
+	if (priv->flags & FE_FLAG_NAPI_WEIGHT)
+		napi_weight *= 4;
+	netif_napi_add(netdev, &priv->rx_napi, fe_poll, napi_weight);
+	fe_set_ethtool_ops(netdev);
+
+	err = register_netdev(netdev);
+	if (err) {
+		dev_err(&pdev->dev, "error bringing up device\n");
+		goto err_free_dev;
+	}
+
+	platform_set_drvdata(pdev, netdev);
+
+	netif_info(priv, probe, netdev, "mediatek frame engine at 0x%08lx, irq %d\n",
+		   netdev->base_addr, netdev->irq);
+
+	return 0;
+
+err_free_dev:
+	free_netdev(netdev);
+err_iounmap:
+	devm_iounmap(&pdev->dev, fe_base);
+err_out:
+	return err;
+}
+
+static int fe_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct fe_priv *priv = netdev_priv(dev);
+
+	netif_napi_del(&priv->rx_napi);
+	kfree(priv->hw_stats);
+
+	cancel_work_sync(&priv->pending_work);
+
+	unregister_netdev(dev);
+	free_netdev(dev);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver fe_driver = {
+	.probe = fe_probe,
+	.remove = fe_remove,
+	.driver = {
+		.name = "mtk_soc_eth",
+		.owner = THIS_MODULE,
+		.of_match_table = of_fe_match,
+	},
+};
+
+module_platform_driver(fe_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("Ethernet driver for Ralink SoC");
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
new file mode 100644
index 0000000..2a6fc98
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -0,0 +1,572 @@
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
+#ifndef FE_ETH_H
+#define FE_ETH_H
+
+#include <linux/mii.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
+#include <linux/phy.h>
+#include <linux/ethtool.h>
+#include <linux/version.h>
+#include <linux/atomic.h>
+
+enum fe_reg {
+	FE_REG_PDMA_GLO_CFG = 0,
+	FE_REG_PDMA_RST_CFG,
+	FE_REG_DLY_INT_CFG,
+	FE_REG_TX_BASE_PTR0,
+	FE_REG_TX_MAX_CNT0,
+	FE_REG_TX_CTX_IDX0,
+	FE_REG_TX_DTX_IDX0,
+	FE_REG_RX_BASE_PTR0,
+	FE_REG_RX_MAX_CNT0,
+	FE_REG_RX_CALC_IDX0,
+	FE_REG_RX_DRX_IDX0,
+	FE_REG_FE_INT_ENABLE,
+	FE_REG_FE_INT_STATUS,
+	FE_REG_FE_DMA_VID_BASE,
+	FE_REG_FE_COUNTER_BASE,
+	FE_REG_FE_RST_GL,
+	FE_REG_FE_INT_STATUS2,
+	FE_REG_COUNT
+};
+
+enum fe_work_flag {
+	FE_FLAG_RESET_PENDING,
+	FE_FLAG_MAX
+};
+
+/* power of 2 to let NEXT_TX_DESP_IDX work */
+#define NUM_DMA_DESC		BIT(7)
+#define MAX_DMA_DESC		0xfff
+
+#define FE_DELAY_EN_INT		0x80
+#define FE_DELAY_MAX_INT	0x04
+#define FE_DELAY_MAX_TOUT	0x04
+#define FE_DELAY_TIME		20
+#define FE_DELAY_CHAN		(((FE_DELAY_EN_INT | FE_DELAY_MAX_INT) << 8) | \
+				 FE_DELAY_MAX_TOUT)
+#define FE_DELAY_INIT		((FE_DELAY_CHAN << 16) | FE_DELAY_CHAN)
+#define FE_PSE_FQFC_CFG_INIT	0x80504000
+#define FE_PSE_FQFC_CFG_256Q	0xff908000
+
+/* interrupt bits */
+#define FE_CNT_PPE_AF		BIT(31)
+#define FE_CNT_GDM_AF		BIT(29)
+#define FE_PSE_P2_FC		BIT(26)
+#define FE_PSE_BUF_DROP		BIT(24)
+#define FE_GDM_OTHER_DROP	BIT(23)
+#define FE_PSE_P1_FC		BIT(22)
+#define FE_PSE_P0_FC		BIT(21)
+#define FE_PSE_FQ_EMPTY		BIT(20)
+#define FE_GE1_STA_CHG		BIT(18)
+#define FE_TX_COHERENT		BIT(17)
+#define FE_RX_COHERENT		BIT(16)
+#define FE_TX_DONE_INT3		BIT(11)
+#define FE_TX_DONE_INT2		BIT(10)
+#define FE_TX_DONE_INT1		BIT(9)
+#define FE_TX_DONE_INT0		BIT(8)
+#define FE_RX_DONE_INT0		BIT(2)
+#define FE_TX_DLY_INT		BIT(1)
+#define FE_RX_DLY_INT		BIT(0)
+
+#define FE_RX_DONE_INT		FE_RX_DONE_INT0
+#define FE_TX_DONE_INT		(FE_TX_DONE_INT0 | FE_TX_DONE_INT1 | \
+				 FE_TX_DONE_INT2 | FE_TX_DONE_INT3)
+
+#define RT5350_RX_DLY_INT	BIT(30)
+#define RT5350_TX_DLY_INT	BIT(28)
+#define RT5350_RX_DONE_INT1	BIT(17)
+#define RT5350_RX_DONE_INT0	BIT(16)
+#define RT5350_TX_DONE_INT3	BIT(3)
+#define RT5350_TX_DONE_INT2	BIT(2)
+#define RT5350_TX_DONE_INT1	BIT(1)
+#define RT5350_TX_DONE_INT0	BIT(0)
+
+#define RT5350_RX_DONE_INT	(RT5350_RX_DONE_INT0 | RT5350_RX_DONE_INT1)
+#define RT5350_TX_DONE_INT	(RT5350_TX_DONE_INT0 | RT5350_TX_DONE_INT1 | \
+				 RT5350_TX_DONE_INT2 | RT5350_TX_DONE_INT3)
+
+/* registers */
+#define FE_FE_OFFSET		0x0000
+#define FE_GDMA_OFFSET		0x0020
+#define FE_PSE_OFFSET		0x0040
+#define FE_GDMA2_OFFSET		0x0060
+#define FE_CDMA_OFFSET		0x0080
+#define FE_DMA_VID0		0x00a8
+#define FE_PDMA_OFFSET		0x0100
+#define FE_PPE_OFFSET		0x0200
+#define FE_CMTABLE_OFFSET	0x0400
+#define FE_POLICYTABLE_OFFSET	0x1000
+
+#define RT5350_PDMA_OFFSET	0x0800
+#define RT5350_SDM_OFFSET	0x0c00
+
+#define FE_MDIO_ACCESS		(FE_FE_OFFSET + 0x00)
+#define FE_MDIO_CFG		(FE_FE_OFFSET + 0x04)
+#define FE_FE_GLO_CFG		(FE_FE_OFFSET + 0x08)
+#define FE_FE_RST_GL		(FE_FE_OFFSET + 0x0C)
+#define FE_FE_INT_STATUS	(FE_FE_OFFSET + 0x10)
+#define FE_FE_INT_ENABLE	(FE_FE_OFFSET + 0x14)
+#define FE_MDIO_CFG2		(FE_FE_OFFSET + 0x18)
+#define FE_FOC_TS_T		(FE_FE_OFFSET + 0x1C)
+
+#define	FE_GDMA1_FWD_CFG	(FE_GDMA_OFFSET + 0x00)
+#define FE_GDMA1_SCH_CFG	(FE_GDMA_OFFSET + 0x04)
+#define FE_GDMA1_SHPR_CFG	(FE_GDMA_OFFSET + 0x08)
+#define FE_GDMA1_MAC_ADRL	(FE_GDMA_OFFSET + 0x0C)
+#define FE_GDMA1_MAC_ADRH	(FE_GDMA_OFFSET + 0x10)
+
+#define	FE_GDMA2_FWD_CFG	(FE_GDMA2_OFFSET + 0x00)
+#define FE_GDMA2_SCH_CFG	(FE_GDMA2_OFFSET + 0x04)
+#define FE_GDMA2_SHPR_CFG	(FE_GDMA2_OFFSET + 0x08)
+#define FE_GDMA2_MAC_ADRL	(FE_GDMA2_OFFSET + 0x0C)
+#define FE_GDMA2_MAC_ADRH	(FE_GDMA2_OFFSET + 0x10)
+
+#define FE_PSE_FQ_CFG		(FE_PSE_OFFSET + 0x00)
+#define FE_CDMA_FC_CFG		(FE_PSE_OFFSET + 0x04)
+#define FE_GDMA1_FC_CFG		(FE_PSE_OFFSET + 0x08)
+#define FE_GDMA2_FC_CFG		(FE_PSE_OFFSET + 0x0C)
+
+#define FE_CDMA_CSG_CFG		(FE_CDMA_OFFSET + 0x00)
+#define FE_CDMA_SCH_CFG		(FE_CDMA_OFFSET + 0x04)
+
+#ifdef CONFIG_SOC_MT7621
+#define MT7620A_GDMA_OFFSET		0x0500
+#else
+#define MT7620A_GDMA_OFFSET		0x0600
+#endif
+#define	MT7620A_GDMA1_FWD_CFG		(MT7620A_GDMA_OFFSET + 0x00)
+#define MT7620A_FE_GDMA1_SCH_CFG	(MT7620A_GDMA_OFFSET + 0x04)
+#define MT7620A_FE_GDMA1_SHPR_CFG	(MT7620A_GDMA_OFFSET + 0x08)
+#define MT7620A_FE_GDMA1_MAC_ADRL	(MT7620A_GDMA_OFFSET + 0x0C)
+#define MT7620A_FE_GDMA1_MAC_ADRH	(MT7620A_GDMA_OFFSET + 0x10)
+
+#define RT5350_TX_BASE_PTR0	(RT5350_PDMA_OFFSET + 0x00)
+#define RT5350_TX_MAX_CNT0	(RT5350_PDMA_OFFSET + 0x04)
+#define RT5350_TX_CTX_IDX0	(RT5350_PDMA_OFFSET + 0x08)
+#define RT5350_TX_DTX_IDX0	(RT5350_PDMA_OFFSET + 0x0C)
+#define RT5350_TX_BASE_PTR1	(RT5350_PDMA_OFFSET + 0x10)
+#define RT5350_TX_MAX_CNT1	(RT5350_PDMA_OFFSET + 0x14)
+#define RT5350_TX_CTX_IDX1	(RT5350_PDMA_OFFSET + 0x18)
+#define RT5350_TX_DTX_IDX1	(RT5350_PDMA_OFFSET + 0x1C)
+#define RT5350_TX_BASE_PTR2	(RT5350_PDMA_OFFSET + 0x20)
+#define RT5350_TX_MAX_CNT2	(RT5350_PDMA_OFFSET + 0x24)
+#define RT5350_TX_CTX_IDX2	(RT5350_PDMA_OFFSET + 0x28)
+#define RT5350_TX_DTX_IDX2	(RT5350_PDMA_OFFSET + 0x2C)
+#define RT5350_TX_BASE_PTR3	(RT5350_PDMA_OFFSET + 0x30)
+#define RT5350_TX_MAX_CNT3	(RT5350_PDMA_OFFSET + 0x34)
+#define RT5350_TX_CTX_IDX3	(RT5350_PDMA_OFFSET + 0x38)
+#define RT5350_TX_DTX_IDX3	(RT5350_PDMA_OFFSET + 0x3C)
+#define RT5350_RX_BASE_PTR0	(RT5350_PDMA_OFFSET + 0x100)
+#define RT5350_RX_MAX_CNT0	(RT5350_PDMA_OFFSET + 0x104)
+#define RT5350_RX_CALC_IDX0	(RT5350_PDMA_OFFSET + 0x108)
+#define RT5350_RX_DRX_IDX0	(RT5350_PDMA_OFFSET + 0x10C)
+#define RT5350_RX_BASE_PTR1	(RT5350_PDMA_OFFSET + 0x110)
+#define RT5350_RX_MAX_CNT1	(RT5350_PDMA_OFFSET + 0x114)
+#define RT5350_RX_CALC_IDX1	(RT5350_PDMA_OFFSET + 0x118)
+#define RT5350_RX_DRX_IDX1	(RT5350_PDMA_OFFSET + 0x11C)
+#define RT5350_PDMA_GLO_CFG	(RT5350_PDMA_OFFSET + 0x204)
+#define RT5350_PDMA_RST_CFG	(RT5350_PDMA_OFFSET + 0x208)
+#define RT5350_DLY_INT_CFG	(RT5350_PDMA_OFFSET + 0x20c)
+#define RT5350_FE_INT_STATUS	(RT5350_PDMA_OFFSET + 0x220)
+#define RT5350_FE_INT_ENABLE	(RT5350_PDMA_OFFSET + 0x228)
+#define RT5350_PDMA_SCH_CFG	(RT5350_PDMA_OFFSET + 0x280)
+
+#define FE_PDMA_GLO_CFG		(FE_PDMA_OFFSET + 0x00)
+#define FE_PDMA_RST_CFG		(FE_PDMA_OFFSET + 0x04)
+#define FE_PDMA_SCH_CFG		(FE_PDMA_OFFSET + 0x08)
+#define FE_DLY_INT_CFG		(FE_PDMA_OFFSET + 0x0C)
+#define FE_TX_BASE_PTR0		(FE_PDMA_OFFSET + 0x10)
+#define FE_TX_MAX_CNT0		(FE_PDMA_OFFSET + 0x14)
+#define FE_TX_CTX_IDX0		(FE_PDMA_OFFSET + 0x18)
+#define FE_TX_DTX_IDX0		(FE_PDMA_OFFSET + 0x1C)
+#define FE_TX_BASE_PTR1		(FE_PDMA_OFFSET + 0x20)
+#define FE_TX_MAX_CNT1		(FE_PDMA_OFFSET + 0x24)
+#define FE_TX_CTX_IDX1		(FE_PDMA_OFFSET + 0x28)
+#define FE_TX_DTX_IDX1		(FE_PDMA_OFFSET + 0x2C)
+#define FE_RX_BASE_PTR0		(FE_PDMA_OFFSET + 0x30)
+#define FE_RX_MAX_CNT0		(FE_PDMA_OFFSET + 0x34)
+#define FE_RX_CALC_IDX0		(FE_PDMA_OFFSET + 0x38)
+#define FE_RX_DRX_IDX0		(FE_PDMA_OFFSET + 0x3C)
+#define FE_TX_BASE_PTR2		(FE_PDMA_OFFSET + 0x40)
+#define FE_TX_MAX_CNT2		(FE_PDMA_OFFSET + 0x44)
+#define FE_TX_CTX_IDX2		(FE_PDMA_OFFSET + 0x48)
+#define FE_TX_DTX_IDX2		(FE_PDMA_OFFSET + 0x4C)
+#define FE_TX_BASE_PTR3		(FE_PDMA_OFFSET + 0x50)
+#define FE_TX_MAX_CNT3		(FE_PDMA_OFFSET + 0x54)
+#define FE_TX_CTX_IDX3		(FE_PDMA_OFFSET + 0x58)
+#define FE_TX_DTX_IDX3		(FE_PDMA_OFFSET + 0x5C)
+#define FE_RX_BASE_PTR1		(FE_PDMA_OFFSET + 0x60)
+#define FE_RX_MAX_CNT1		(FE_PDMA_OFFSET + 0x64)
+#define FE_RX_CALC_IDX1		(FE_PDMA_OFFSET + 0x68)
+#define FE_RX_DRX_IDX1		(FE_PDMA_OFFSET + 0x6C)
+
+/* Switch DMA configuration */
+#define RT5350_SDM_CFG		(RT5350_SDM_OFFSET + 0x00)
+#define RT5350_SDM_RRING	(RT5350_SDM_OFFSET + 0x04)
+#define RT5350_SDM_TRING	(RT5350_SDM_OFFSET + 0x08)
+#define RT5350_SDM_MAC_ADRL	(RT5350_SDM_OFFSET + 0x0C)
+#define RT5350_SDM_MAC_ADRH	(RT5350_SDM_OFFSET + 0x10)
+#define RT5350_SDM_TPCNT	(RT5350_SDM_OFFSET + 0x100)
+#define RT5350_SDM_TBCNT	(RT5350_SDM_OFFSET + 0x104)
+#define RT5350_SDM_RPCNT	(RT5350_SDM_OFFSET + 0x108)
+#define RT5350_SDM_RBCNT	(RT5350_SDM_OFFSET + 0x10C)
+#define RT5350_SDM_CS_ERR	(RT5350_SDM_OFFSET + 0x110)
+
+#define RT5350_SDM_ICS_EN	BIT(16)
+#define RT5350_SDM_TCS_EN	BIT(17)
+#define RT5350_SDM_UCS_EN	BIT(18)
+
+/* QDMA registers */
+#define FE_QRX_BASE_PTR0	0x1900
+#define FE_QRX_MAX_CNT0		0x1904
+#define FE_QRX_CRX_IDX0		0x1908
+#define FE_QRX_DRX_IDX0		0x190C
+#define FE_QDMA_GLO_CFG		0x1A04
+#define FE_QDMA_RST_IDX		0x1A08
+#define FE_QDMA_DELAY_INT	0x1A0C
+#define FE_QDMA_FC_THRES	0x1A10
+#define FE_QFE_INT_STATUS	0x1A18
+#define FE_QFE_INT_ENABLE	0x1A1C
+#define FE_QDMA_HRED2		0x1A44
+
+#define FE_QTX_CTX_PTR		0x1B00
+#define FE_QTX_DTX_PTR		0x1B04
+
+#define FE_QTX_CRX_PTR		0x1B10
+#define FE_QTX_DRX_PTR		0x1B14
+
+#define FE_QDMA_FQ_HEAD		0x1B20
+#define FE_QDMA_FQ_TAIL		0x1B24
+#define FE_QDMA_FQ_CNT		0x1B28
+#define FE_QDMA_FQ_BLEN		0x1B2C
+
+#define QDMA_PAGE_SIZE		2048
+#define QDMA_TX_OWNER_CPU	BIT(31)
+#define QDMA_TX_SWC		BIT(14)
+#define TX_QDMA_SDL(_x)		(((_x) & 0x3fff) << 16)
+
+/* MDIO_CFG register bits */
+#define FE_MDIO_CFG_AUTO_POLL_EN	BIT(29)
+#define FE_MDIO_CFG_GP1_BP_EN		BIT(16)
+#define FE_MDIO_CFG_GP1_FRC_EN		BIT(15)
+#define FE_MDIO_CFG_GP1_SPEED_10	(0 << 13)
+#define FE_MDIO_CFG_GP1_SPEED_100	(1 << 13)
+#define FE_MDIO_CFG_GP1_SPEED_1000	(2 << 13)
+#define FE_MDIO_CFG_GP1_DUPLEX		BIT(12)
+#define FE_MDIO_CFG_GP1_FC_TX		BIT(11)
+#define FE_MDIO_CFG_GP1_FC_RX		BIT(10)
+#define FE_MDIO_CFG_GP1_LNK_DWN		BIT(9)
+#define FE_MDIO_CFG_GP1_AN_FAIL		BIT(8)
+#define FE_MDIO_CFG_MDC_CLK_DIV_1	(0 << 6)
+#define FE_MDIO_CFG_MDC_CLK_DIV_2	(1 << 6)
+#define FE_MDIO_CFG_MDC_CLK_DIV_4	(2 << 6)
+#define FE_MDIO_CFG_MDC_CLK_DIV_8	(3 << 6)
+#define FE_MDIO_CFG_TURBO_MII_FREQ	BIT(5)
+#define FE_MDIO_CFG_TURBO_MII_MODE	BIT(4)
+#define FE_MDIO_CFG_RX_CLK_SKEW_0	(0 << 2)
+#define FE_MDIO_CFG_RX_CLK_SKEW_200	(1 << 2)
+#define FE_MDIO_CFG_RX_CLK_SKEW_400	(2 << 2)
+#define FE_MDIO_CFG_RX_CLK_SKEW_INV	(3 << 2)
+#define FE_MDIO_CFG_TX_CLK_SKEW_0	0
+#define FE_MDIO_CFG_TX_CLK_SKEW_200	1
+#define FE_MDIO_CFG_TX_CLK_SKEW_400	2
+#define FE_MDIO_CFG_TX_CLK_SKEW_INV	3
+
+/* uni-cast port */
+#define FE_GDM1_JMB_LEN_MASK	0xf
+#define FE_GDM1_JMB_LEN_SHIFT	28
+#define FE_GDM1_ICS_EN		BIT(22)
+#define FE_GDM1_TCS_EN		BIT(21)
+#define FE_GDM1_UCS_EN		BIT(20)
+#define FE_GDM1_JMB_EN		BIT(19)
+#define FE_GDM1_STRPCRC		BIT(16)
+#define FE_GDM1_UFRC_P_CPU	(0 << 12)
+#define FE_GDM1_UFRC_P_GDMA1	(1 << 12)
+#define FE_GDM1_UFRC_P_PPE	(6 << 12)
+
+/* checksums */
+#define FE_ICS_GEN_EN		BIT(2)
+#define FE_UCS_GEN_EN		BIT(1)
+#define FE_TCS_GEN_EN		BIT(0)
+
+/* dma mode */
+#define FE_PDMA			BIT(0)
+#define FE_QDMA			BIT(1)
+#define FE_PDMA_RX_QDMA_TX	(FE_PDMA | FE_QDMA)
+
+/* dma ring */
+#define FE_PST_DRX_IDX0		BIT(16)
+#define FE_PST_DTX_IDX3		BIT(3)
+#define FE_PST_DTX_IDX2		BIT(2)
+#define FE_PST_DTX_IDX1		BIT(1)
+#define FE_PST_DTX_IDX0		BIT(0)
+
+#define FE_RX_2B_OFFSET		BIT(31)
+#define FE_TX_WB_DDONE		BIT(6)
+#define FE_RX_DMA_BUSY		BIT(3)
+#define FE_TX_DMA_BUSY		BIT(1)
+#define FE_RX_DMA_EN		BIT(2)
+#define FE_TX_DMA_EN		BIT(0)
+
+#define FE_PDMA_SIZE_4DWORDS	(0 << 4)
+#define FE_PDMA_SIZE_8DWORDS	(1 << 4)
+#define FE_PDMA_SIZE_16DWORDS	(2 << 4)
+
+#define FE_US_CYC_CNT_MASK	0xff
+#define FE_US_CYC_CNT_SHIFT	0x8
+#define FE_US_CYC_CNT_DIVISOR	1000000
+
+/* rxd2 */
+#define RX_DMA_DONE		BIT(31)
+#define RX_DMA_LSO		BIT(30)
+#define RX_DMA_PLEN0(_x)	(((_x) & 0x3fff) << 16)
+#define RX_DMA_GET_PLEN0(_x)	(((_x) >> 16) & 0x3fff)
+#define RX_DMA_TAG		BIT(15)
+/* rxd3 */
+#define RX_DMA_TPID(_x)		(((_x) >> 16) & 0xffff)
+#define RX_DMA_VID(_x)		((_x) & 0xffff)
+/* rxd4 */
+#define RX_DMA_L4VALID		BIT(30)
+
+struct fe_rx_dma {
+	unsigned int rxd1;
+	unsigned int rxd2;
+	unsigned int rxd3;
+	unsigned int rxd4;
+} __packed __aligned(4);
+
+#define TX_DMA_BUF_LEN		0x3fff
+#define TX_DMA_PLEN0_MASK	(TX_DMA_BUF_LEN << 16)
+#define TX_DMA_PLEN0(_x)	(((_x) & TX_DMA_BUF_LEN) << 16)
+#define TX_DMA_PLEN1(_x)	((_x) & TX_DMA_BUF_LEN)
+#define TX_DMA_GET_PLEN0(_x)    (((_x) >> 16) & TX_DMA_BUF_LEN)
+#define TX_DMA_GET_PLEN1(_x)    ((_x) & TX_DMA_BUF_LEN)
+#define TX_DMA_LS1		BIT(14)
+#define TX_DMA_LS0		BIT(30)
+#define TX_DMA_DONE		BIT(31)
+
+#define TX_DMA_INS_VLAN_MT7621	BIT(16)
+#define TX_DMA_INS_VLAN		BIT(7)
+#define TX_DMA_INS_PPPOE	BIT(12)
+#define TX_DMA_TAG		BIT(15)
+#define TX_DMA_TAG_MASK		BIT(15)
+#define TX_DMA_QN(_x)		((_x) << 16)
+#define TX_DMA_PN(_x)		((_x) << 24)
+#define TX_DMA_QN_MASK		TX_DMA_QN(0x7)
+#define TX_DMA_PN_MASK		TX_DMA_PN(0x7)
+#define TX_DMA_UDF		BIT(20)
+#define TX_DMA_CHKSUM		(0x7 << 29)
+#define TX_DMA_TSO		BIT(28)
+
+#define TX_DMA_DESP4_DEF	(TX_DMA_QN(3) | TX_DMA_PN(1))
+
+/* frame engine counters */
+#define FE_PPE_AC_BCNT0		(FE_CMTABLE_OFFSET + 0x00)
+#define FE_GDMA1_TX_GBCNT	(FE_CMTABLE_OFFSET + 0x300)
+#define FE_GDMA2_TX_GBCNT	(FE_GDMA1_TX_GBCNT + 0x40)
+
+/* phy device flags */
+#define FE_PHY_FLAG_PORT	BIT(0)
+#define FE_PHY_FLAG_ATTACH	BIT(1)
+
+struct fe_tx_dma {
+	unsigned int txd1;
+	unsigned int txd2;
+	unsigned int txd3;
+	unsigned int txd4;
+} __packed __aligned(4);
+
+struct fe_priv;
+
+struct fe_phy {
+	/* make sure that phy operations are atomic */
+	spinlock_t		lock;
+
+	struct phy_device	*phy[8];
+	struct device_node	*phy_node[8];
+	const __be32		*phy_fixed[8];
+	int			duplex[8];
+	int			speed[8];
+	int			tx_fc[8];
+	int			rx_fc[8];
+	int (*connect)(struct fe_priv *priv);
+	void (*disconnect)(struct fe_priv *priv);
+	void (*start)(struct fe_priv *priv);
+	void (*stop)(struct fe_priv *priv);
+};
+
+struct fe_soc_data {
+	const u16 *reg_table;
+
+	void (*init_data)(struct fe_soc_data *data, struct net_device *netdev);
+	void (*reset_fe)(void);
+	void (*set_mac)(struct fe_priv *priv, unsigned char *mac);
+	int (*fwd_config)(struct fe_priv *priv);
+	int (*switch_init)(struct fe_priv *priv);
+	void (*port_init)(struct fe_priv *priv, struct device_node *port);
+	int (*has_carrier)(struct fe_priv *priv);
+	int (*mdio_init)(struct fe_priv *priv);
+	void (*mdio_cleanup)(struct fe_priv *priv);
+	int (*mdio_write)(struct mii_bus *bus, int phy_addr, int phy_reg,
+			  u16 val);
+	int (*mdio_read)(struct mii_bus *bus, int phy_addr, int phy_reg);
+	void (*mdio_adjust_link)(struct fe_priv *priv, int port);
+
+	void *swpriv;
+	u32 dma_type;
+	u32 pdma_glo_cfg;
+	u32 rx_int;
+	u32 tx_int;
+	u32 status_int;
+	u32 checksum_bit;
+	u32 txd4;
+};
+
+#define FE_FLAG_PADDING_64B		BIT(0)
+#define FE_FLAG_PADDING_BUG		BIT(1)
+#define FE_FLAG_JUMBO_FRAME		BIT(2)
+#define FE_FLAG_RX_2B_OFFSET		BIT(3)
+#define FE_FLAG_RX_SG_DMA		BIT(4)
+#define FE_FLAG_RX_VLAN_CTAG		BIT(5)
+#define FE_FLAG_NAPI_WEIGHT		BIT(6)
+#define FE_FLAG_CALIBRATE_CLK		BIT(7)
+#define FE_FLAG_HAS_SWITCH		BIT(8)
+
+#define FE_STAT_REG_DECLARE		\
+	_FE(tx_bytes)			\
+	_FE(tx_packets)			\
+	_FE(tx_skip)			\
+	_FE(tx_collisions)		\
+	_FE(rx_bytes)			\
+	_FE(rx_packets)			\
+	_FE(rx_overflow)		\
+	_FE(rx_fcs_errors)		\
+	_FE(rx_short_errors)		\
+	_FE(rx_long_errors)		\
+	_FE(rx_checksum_errors)		\
+	_FE(rx_flow_control_packets)
+
+struct fe_hw_stats {
+	/* make sure that stats operations are atomic */
+	spinlock_t stats_lock;
+
+	struct u64_stats_sync syncp;
+#define _FE(x) u64 x;
+	FE_STAT_REG_DECLARE
+#undef _FE
+};
+
+enum fe_tx_flags {
+	FE_TX_FLAGS_SINGLE0	= 0x01,
+	FE_TX_FLAGS_PAGE0	= 0x02,
+	FE_TX_FLAGS_PAGE1	= 0x04,
+};
+
+struct fe_tx_buf {
+	struct sk_buff *skb;
+	u32 flags;
+	DEFINE_DMA_UNMAP_ADDR(dma_addr0);
+	DEFINE_DMA_UNMAP_LEN(dma_len0);
+	DEFINE_DMA_UNMAP_ADDR(dma_addr1);
+	DEFINE_DMA_UNMAP_LEN(dma_len1);
+};
+
+struct fe_tx_ring {
+	struct fe_tx_dma *tx_dma;
+	struct fe_tx_buf *tx_buf;
+	dma_addr_t tx_phys;
+	struct fe_tx_dma *tx_next_free;
+	struct fe_tx_dma *tx_last_free;
+	u16 tx_thresh;
+
+	int (*tx_map)(struct sk_buff *skb, struct net_device *dev, int tx_num,
+		      struct fe_tx_ring *ring, bool gso);
+	int (*tx_poll)(struct fe_priv *priv, int budget, bool *tx_again,
+		       unsigned int *bytes_compl);
+	void (*tx_clean)(struct fe_priv *priv);
+
+	/* PDMA only */
+	u16 tx_ring_size;
+	u16 tx_free_idx;
+
+	/* QDMA only */
+	u16 tx_next_idx;
+	atomic_t tx_free_count;
+};
+
+struct fe_rx_ring {
+	struct fe_rx_dma *rx_dma;
+	u8 **rx_data;
+	dma_addr_t rx_phys;
+	u16 rx_ring_size;
+	u16 frag_size;
+	u16 rx_buf_size;
+	u16 rx_calc_idx;
+};
+
+struct fe_priv {
+	/* make sure that register operations are atomic */
+	spinlock_t			page_lock;
+
+	struct fe_soc_data		*soc;
+	struct net_device		*netdev;
+	struct device_node		*switch_np;
+	u32				msg_enable;
+	u32				flags;
+
+	struct device			*device;
+	unsigned long			sysclk;
+
+	struct fe_rx_ring		rx_ring_p;
+	struct fe_rx_ring		rx_ring_q;
+	struct napi_struct		rx_napi;
+
+	struct fe_tx_ring               tx_ring;
+
+	struct fe_phy			*phy;
+	struct mii_bus			*mii_bus;
+	struct phy_device		*phy_dev;
+	u32				phy_flags;
+
+	int				link[8];
+
+	struct fe_hw_stats		*hw_stats;
+	unsigned long			vlan_map;
+	struct work_struct		pending_work;
+	DECLARE_BITMAP(pending_flags, FE_FLAG_MAX);
+};
+
+extern const struct of_device_id of_fe_match[];
+
+void fe_w32(u32 val, unsigned reg);
+u32 fe_r32(unsigned reg);
+
+int fe_set_clock_cycle(struct fe_priv *priv);
+void fe_csum_config(struct fe_priv *priv);
+void fe_stats_update(struct fe_priv *priv);
+void fe_fwd_config(struct fe_priv *priv);
+
+void fe_reset(u32 reset_bits);
+
+static inline void *priv_netdev(struct fe_priv *priv)
+{
+	return (char *)priv - ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+}
+
+#endif /* FE_ETH_H */
-- 
1.7.10.4
