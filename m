Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2012 17:46:18 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:56228 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903627Ab2APQoY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2012 17:44:24 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 14/17] NET: MIPS: lantiq: non existing phy was not handled gracefully
Date:   Mon, 16 Jan 2012 17:43:42 +0100
Message-Id: <1326732224-21336-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
References: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The code blindly assumed that that a PHY device was present causing a BadVA.
In addition the driver should not fail to load incase no PHY was found.
Instead we print the following line and continue with no attached PHY.

   etop: mdio probe failed

Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: David S. Miller <davem@davemloft.net>

---
Changes in V2:
* remove superflous ";" in line 778

 drivers/net/ethernet/lantiq_etop.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index d3d4931..643faf9 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -612,7 +612,8 @@ ltq_etop_open(struct net_device *dev)
 		ltq_dma_open(&ch->dma);
 		napi_enable(&ch->napi);
 	}
-	phy_start(priv->phydev);
+	if (priv->phydev)
+		phy_start(priv->phydev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }
@@ -624,7 +625,8 @@ ltq_etop_stop(struct net_device *dev)
 	int i;
 
 	netif_tx_stop_all_queues(dev);
-	phy_stop(priv->phydev);
+	if (priv->phydev)
+		phy_stop(priv->phydev);
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
@@ -770,9 +772,10 @@ ltq_etop_init(struct net_device *dev)
 	if (err)
 		goto err_netdev;
 	ltq_etop_set_multicast_list(dev);
-	err = ltq_etop_mdio_init(dev);
-	if (err)
-		goto err_netdev;
+	if (!ltq_etop_mdio_init(dev))
+		dev->ethtool_ops = &ltq_etop_ethtool_ops;
+	else
+		pr_warn("etop: mdio probe failed\n");
 	return 0;
 
 err_netdev:
@@ -868,7 +871,6 @@ ltq_etop_probe(struct platform_device *pdev)
 	dev = alloc_etherdev_mq(sizeof(struct ltq_etop_priv), 4);
 	strcpy(dev->name, "eth%d");
 	dev->netdev_ops = &ltq_eth_netdev_ops;
-	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
 	priv->res = res;
 	priv->pldata = dev_get_platdata(&pdev->dev);
-- 
1.7.7.1
