Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:12:05 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:42530 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025628AbZFARIY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:08:24 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 538BD112408C; Mon,  1 Jun 2009 19:08:15 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx: convert bcm63xx_enet to netdev ops.
Date:	Mon,  1 Jun 2009 19:08:09 +0200
Message-Id: <1243876095-8987-4-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
References: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

This patch makes bcm63xx_enet driver use netdevice ops.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/bcm63xx_enet.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index 20e08ef..36324b3 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -1551,6 +1551,19 @@ static void bcm_enet_hw_preinit(struct bcm_enet_priv *priv)
 	enet_writel(priv, val, ENET_MIBCTL_REG);
 }
 
+static const struct net_device_ops bcm_enet_ops = {
+	.ndo_open		= bcm_enet_open,
+	.ndo_stop		= bcm_enet_stop,
+	.ndo_start_xmit		= bcm_enet_start_xmit,
+	.ndo_get_stats		= bcm_enet_get_stats,
+	.ndo_set_mac_address	= bcm_enet_set_mac_address,
+	.ndo_set_multicast_list = bcm_enet_set_multicast_list,
+	.ndo_do_ioctl		= bcm_enet_ioctl,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = bcm_enet_netpoll,
+#endif
+};
+
 /*
  * allocate netdevice, request register memory and register device.
  */
@@ -1716,17 +1729,8 @@ static int __devinit bcm_enet_probe(struct platform_device *pdev)
 		enet_writel(priv, 0, ENET_MIB_REG(i));
 
 	/* register netdevice */
-	dev->open = bcm_enet_open;
-	dev->stop = bcm_enet_stop;
-	dev->hard_start_xmit = bcm_enet_start_xmit;
-	dev->get_stats = bcm_enet_get_stats;
-	dev->set_mac_address = bcm_enet_set_mac_address;
-	dev->set_multicast_list = bcm_enet_set_multicast_list;
+	dev->netdev_ops = &bcm_enet_ops;
 	netif_napi_add(dev, &priv->napi, bcm_enet_poll, 16);
-	dev->do_ioctl = bcm_enet_ioctl;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = bcm_enet_netpoll;
-#endif
 
 	SET_ETHTOOL_OPS(dev, &bcm_enet_ethtool_ops);
 
-- 
1.6.0.4
