Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:03:05 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55023 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022855AbZFCOCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:33 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id CD316112406C; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 8/8] bcm63xx: fix oops when removing bcm63xx_enet module.
Date:	Wed,  3 Jun 2009 16:02:27 +0200
Message-Id: <1244037747-27144-9-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

SET_NETDEV_DEV has to be called before registering netdevice, not
after, otherwise we get unbalanced kobject get/put when unregistering.

This patch also adds missing platform_set_drvdata(pdev, NULL) before
freiing netdevice.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/bcm63xx_enet.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index 660ffa2..09d2709 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -1788,6 +1788,7 @@ static int __devinit bcm_enet_probe(struct platform_device *pdev)
 	netif_napi_add(dev, &priv->napi, bcm_enet_poll, 16);
 
 	SET_ETHTOOL_OPS(dev, &bcm_enet_ethtool_ops);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	ret = register_netdev(dev);
 	if (ret)
@@ -1797,7 +1798,6 @@ static int __devinit bcm_enet_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 	priv->pdev = pdev;
 	priv->net_dev = dev;
-	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	return 0;
 
@@ -1877,6 +1877,7 @@ static int __devexit bcm_enet_remove(struct platform_device *pdev)
 	clk_disable(priv->mac_clk);
 	clk_put(priv->mac_clk);
 
+	platform_set_drvdata(pdev, NULL);
 	free_netdev(dev);
 	return 0;
 }
-- 
1.6.0.4
