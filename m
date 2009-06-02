Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 00:49:04 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:54290 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022109AbZFBXrn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 00:47:43 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 2BA59112408B; Wed,  3 Jun 2009 01:47:37 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/3] bcm63xx: make it possible to change MTU on bcm63xx_enet.
Date:	Wed,  3 Jun 2009 01:47:36 +0200
Message-Id: <1243986457-27088-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243986457-27088-1-git-send-email-mbizon@freebox.fr>
References: <1243986457-27088-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

bcm63xx integrated ethernet mac  supports receiving and sending frames
bigger than 1500 bytes, this patch adds support for changing MTU.

This patch also fixes the reception of 802.1q frames for default MTU
which were reported as oversized.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/bcm63xx_enet.c |   71 +++++++++++++++++++++++++++++++++++++++-----
 drivers/net/bcm63xx_enet.h |   15 +++++++--
 2 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index af0114a..322ed03 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/if_vlan.h>
 
 #include <bcm63xx_dev_enet.h>
 #include "bcm63xx_enet.h"
@@ -189,18 +190,18 @@ static int bcm_enet_refill_rx(struct net_device *dev)
 		desc = &priv->rx_desc_cpu[desc_idx];
 
 		if (!priv->rx_skb[desc_idx]) {
-			skb = netdev_alloc_skb(dev, BCMENET_MAX_RX_SIZE);
+			skb = netdev_alloc_skb(dev, priv->rx_skb_size);
 			if (!skb)
 				break;
 			priv->rx_skb[desc_idx] = skb;
 
 			p = dma_map_single(&priv->pdev->dev, skb->data,
-					   BCMENET_MAX_RX_SIZE,
+					   priv->rx_skb_size,
 					   DMA_FROM_DEVICE);
 			desc->address = p;
 		}
 
-		len_stat = BCMENET_MAX_RX_SIZE << DMADESC_LENGTH_SHIFT;
+		len_stat = priv->rx_skb_size << DMADESC_LENGTH_SHIFT;
 		len_stat |= DMADESC_OWNER_MASK;
 		if (priv->rx_dirty_desc == priv->rx_ring_size - 1) {
 			len_stat |= DMADESC_WRAP_MASK;
@@ -337,7 +338,7 @@ static int bcm_enet_receive_queue(struct net_device *dev, int budget)
 			skb = nskb;
 		} else {
 			dma_unmap_single(&priv->pdev->dev, desc->address,
-					 BCMENET_MAX_RX_SIZE, DMA_FROM_DEVICE);
+					 priv->rx_skb_size, DMA_FROM_DEVICE);
 			priv->rx_skb[desc_idx] = NULL;
 		}
 
@@ -943,8 +944,8 @@ static int bcm_enet_open(struct net_device *dev)
 	enet_dma_writel(priv, 0, ENETDMA_SRAM4_REG(priv->tx_chan));
 
 	/* set max rx/tx length */
-	enet_writel(priv, BCMENET_MAX_RX_SIZE, ENET_RXMAXLEN_REG);
-	enet_writel(priv, BCMENET_MAX_TX_SIZE, ENET_TXMAXLEN_REG);
+	enet_writel(priv, priv->hw_mtu, ENET_RXMAXLEN_REG);
+	enet_writel(priv, priv->hw_mtu, ENET_TXMAXLEN_REG);
 
 	/* set dma maximum burst len */
 	enet_dma_writel(priv, BCMENET_DMA_MAXBURST,
@@ -1003,7 +1004,7 @@ out:
 			continue;
 
 		desc = &priv->rx_desc_cpu[i];
-		dma_unmap_single(kdev, desc->address, BCMENET_MAX_RX_SIZE,
+		dma_unmap_single(kdev, desc->address, priv->rx_skb_size,
 				 DMA_FROM_DEVICE);
 		kfree_skb(priv->rx_skb[i]);
 	}
@@ -1120,7 +1121,7 @@ static int bcm_enet_stop(struct net_device *dev)
 			continue;
 
 		desc = &priv->rx_desc_cpu[i];
-		dma_unmap_single(kdev, desc->address, BCMENET_MAX_RX_SIZE,
+		dma_unmap_single(kdev, desc->address, priv->rx_skb_size,
 				 DMA_FROM_DEVICE);
 		kfree_skb(priv->rx_skb[i]);
 	}
@@ -1510,6 +1511,55 @@ static int bcm_enet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 }
 
 /*
+ * calculate actual hardware mtu
+ */
+static int compute_hw_mtu(struct bcm_enet_priv *priv, int mtu)
+{
+	int actual_mtu;
+
+	actual_mtu = mtu;
+
+	/* add ethernet header + vlan tag size */
+	actual_mtu += VLAN_ETH_HLEN;
+
+	if (actual_mtu < 64 || actual_mtu > BCMENET_MAX_MTU)
+		return -EINVAL;
+
+	/*
+	 * setup maximum size before we get overflow mark in
+	 * descriptor, note that this will not prevent reception of
+	 * big frames, they will be split into multiple buffers
+	 * anyway
+	 */
+	priv->hw_mtu = actual_mtu;
+
+	/*
+	 * align rx buffer size to dma burst len, account FCS since
+	 * it's appended
+	 */
+	priv->rx_skb_size = ALIGN(actual_mtu + ETH_FCS_LEN,
+				  BCMENET_DMA_MAXBURST * 4);
+	return 0;
+}
+
+/*
+ * adjust mtu, can't be called while device is running
+ */
+static int bcm_enet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	int ret;
+
+	if (netif_running(dev))
+		return -EBUSY;
+
+	ret = compute_hw_mtu(netdev_priv(dev), new_mtu);
+	if (ret)
+		return ret;
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+/*
  * preinit hardware to allow mii operation while device is down
  */
 static void bcm_enet_hw_preinit(struct bcm_enet_priv *priv)
@@ -1559,6 +1609,7 @@ static const struct net_device_ops bcm_enet_ops = {
 	.ndo_set_mac_address	= bcm_enet_set_mac_address,
 	.ndo_set_multicast_list = bcm_enet_set_multicast_list,
 	.ndo_do_ioctl		= bcm_enet_ioctl,
+	.ndo_change_mtu		= bcm_enet_change_mtu,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = bcm_enet_netpoll,
 #endif
@@ -1597,6 +1648,10 @@ static int __devinit bcm_enet_probe(struct platform_device *pdev)
 	priv = netdev_priv(dev);
 	memset(priv, 0, sizeof(*priv));
 
+	ret = compute_hw_mtu(priv, dev->mtu);
+	if (ret)
+		goto out;
+
 	iomem_size = res_mem->end - res_mem->start + 1;
 	if (!request_mem_region(res_mem->start, iomem_size, "bcm63xx_enet")) {
 		ret = -EBUSY;
diff --git a/drivers/net/bcm63xx_enet.h b/drivers/net/bcm63xx_enet.h
index 0da8973..bd3684d 100644
--- a/drivers/net/bcm63xx_enet.h
+++ b/drivers/net/bcm63xx_enet.h
@@ -23,9 +23,12 @@
  * not overflow the fifo  */
 #define BCMENET_TX_FIFO_TRESH	32
 
-/* maximum rx/tx packet size */
-#define	BCMENET_MAX_RX_SIZE	(ETH_FRAME_LEN + 4)
-#define	BCMENET_MAX_TX_SIZE	(ETH_FRAME_LEN + 4)
+/*
+ * hardware maximum rx/tx packet size including FCS, max mtu is
+ * actually 2047, but if we set max rx size register to 2047 we won't
+ * get overflow information if packet size is 2048 or above
+ */
+#define BCMENET_MAX_MTU		2046
 
 /*
  * rx/tx dma descriptor
@@ -202,6 +205,9 @@ struct bcm_enet_priv {
 	/* next dirty rx descriptor to refill */
 	int rx_dirty_desc;
 
+	/* size of allocated rx skbs */
+	unsigned int rx_skb_size;
+
 	/* list of skb given to hw for rx */
 	struct sk_buff **rx_skb;
 
@@ -289,6 +295,9 @@ struct bcm_enet_priv {
 
 	/* platform device reference */
 	struct platform_device *pdev;
+
+	/* maximum hardware transmit/receive size */
+	unsigned int hw_mtu;
 };
 
 #endif /* ! BCM63XX_ENET_H_ */
-- 
1.6.0.4
