Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2011 21:48:23 +0200 (CEST)
Received: from rere.qmqm.pl ([89.167.52.164]:59496 "EHLO rere.qmqm.pl"
        rhost-flags-OK-FAIL-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491018Ab1DLTsT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Apr 2011 21:48:19 +0200
Received: by rere.qmqm.pl (Postfix, from userid 1000)
        id 3420713A65; Tue, 12 Apr 2011 21:48:17 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] net: ioc3: convert to hw_features
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-Id: <20110412194817.3420713A65@rere.qmqm.pl>
Date:   Tue, 12 Apr 2011 21:48:17 +0200 (CEST)
Return-Path: <mirq@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirq-linux@rere.qmqm.pl
Precedence: bulk
X-list: linux-mips

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/net/ioc3-eth.c |   30 ++----------------------------
 1 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
index c8ee8d2..96c9561 100644
--- a/drivers/net/ioc3-eth.c
+++ b/drivers/net/ioc3-eth.c
@@ -90,8 +90,6 @@ struct ioc3_private {
 	u32 emcr, ehar_h, ehar_l;
 	spinlock_t ioc3_lock;
 	struct mii_if_info mii;
-	unsigned long flags;
-#define IOC3_FLAG_RX_CHECKSUMS	1
 
 	struct pci_dev *pdev;
 
@@ -609,7 +607,7 @@ static inline void ioc3_rx(struct net_device *dev)
 				goto next;
 			}
 
-			if (likely(ip->flags & IOC3_FLAG_RX_CHECKSUMS))
+			if (likely(dev->features & NETIF_F_RXCSUM))
 				ioc3_tcpudp_checksum(skb,
 					w0 & ERXBUF_IPCKSUM_MASK, len);
 
@@ -1328,6 +1326,7 @@ static int __devinit ioc3_probe(struct pci_dev *pdev,
 	dev->watchdog_timeo	= 5 * HZ;
 	dev->netdev_ops		= &ioc3_netdev_ops;
 	dev->ethtool_ops	= &ioc3_ethtool_ops;
+	dev->hw_features	= NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
 	dev->features		= NETIF_F_IP_CSUM;
 
 	sw_physid1 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID1);
@@ -1618,37 +1617,12 @@ static u32 ioc3_get_link(struct net_device *dev)
 	return rc;
 }
 
-static u32 ioc3_get_rx_csum(struct net_device *dev)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-
-	return ip->flags & IOC3_FLAG_RX_CHECKSUMS;
-}
-
-static int ioc3_set_rx_csum(struct net_device *dev, u32 data)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-
-	spin_lock_bh(&ip->ioc3_lock);
-	if (data)
-		ip->flags |= IOC3_FLAG_RX_CHECKSUMS;
-	else
-		ip->flags &= ~IOC3_FLAG_RX_CHECKSUMS;
-	spin_unlock_bh(&ip->ioc3_lock);
-
-	return 0;
-}
-
 static const struct ethtool_ops ioc3_ethtool_ops = {
 	.get_drvinfo		= ioc3_get_drvinfo,
 	.get_settings		= ioc3_get_settings,
 	.set_settings		= ioc3_set_settings,
 	.nway_reset		= ioc3_nway_reset,
 	.get_link		= ioc3_get_link,
-	.get_rx_csum		= ioc3_get_rx_csum,
-	.set_rx_csum		= ioc3_set_rx_csum,
-	.get_tx_csum		= ethtool_op_get_tx_csum,
-	.set_tx_csum		= ethtool_op_set_tx_csum
 };
 
 static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
1.7.2.5
