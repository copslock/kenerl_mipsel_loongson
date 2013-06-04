Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:54:12 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:59542 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835138Ab3FDVxtH-ONA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:53:49 +0200
Received: by mail-we0-f179.google.com with SMTP id w59so681871wes.24
        for <multiple recipients>; Tue, 04 Jun 2013 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=D4MmHFLhcdsn2dKRJ6FUpkfK/yRoIFQxLm56JgTlP7Y=;
        b=fcHPiog94DFcQqOTDWvrFiTrdURNrEze5mhTNuAIo3N8Fn3Xwd1aTXmZd4ExNR+bV7
         li2yLUmrk/yctVaLtISKozsoNQ7SArXSi+O39+Wj6x+QSUK/zFmNLL2zcUyLvYzkUrV/
         SAPK5YkaT93zHjNFpw0X4dtPci4JYQ5NjRAgfxT0d4vBZ+jjZIMhGYqeZq7G5OekShXt
         0Zt4SfU4FLzaTZFVXHUUJxc+NZBrRSZp7uCSkkc4b9tl0f1PI01vAfeWoXAB3TZ95WN2
         dYtVZaSljm8dQxfk56amJpjcdncaU0gdNQ3R0hhCnx2b/+R/D3FYgqlndaRokva3yhKK
         UyiQ==
X-Received: by 10.194.179.102 with SMTP id df6mr25840288wjc.42.1370382823616;
        Tue, 04 Jun 2013 14:53:43 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id eq15sm5699480wic.4.2013.06.04.14.53.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:53:42 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     davem@davemloft.net
Cc:     ralf@linux-mips.org, blogic@openwrt.org, linux-mips@linux-mips.org,
        cernekee@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        netdev@vger.kernel.org
Subject: [PATCH 1/3 net-next] bcm63xx_enet: implement reset autoneg ethtool callback
Date:   Tue,  4 Jun 2013 22:53:33 +0100
Message-Id: <1370382815-17904-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370382815-17904-1-git-send-email-florian@openwrt.org>
References: <1370382815-17904-1-git-send-email-florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

From: Maxime Bizon <mbizon@freebox.fr>

Implement the rset_nway ethtool callback which uses libphy generic
autonegotiation restart function.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index e46466c..bc1a994 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1328,6 +1328,20 @@ static void bcm_enet_get_ethtool_stats(struct net_device *netdev,
 	mutex_unlock(&priv->mib_update_lock);
 }
 
+static int bcm_enet_nway_reset(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	if (priv->has_phy) {
+		if (!priv->phydev)
+			return -ENODEV;
+		return genphy_restart_aneg(priv->phydev);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int bcm_enet_get_settings(struct net_device *dev,
 				 struct ethtool_cmd *cmd)
 {
@@ -1470,6 +1484,7 @@ static const struct ethtool_ops bcm_enet_ethtool_ops = {
 	.get_strings		= bcm_enet_get_strings,
 	.get_sset_count		= bcm_enet_get_sset_count,
 	.get_ethtool_stats      = bcm_enet_get_ethtool_stats,
+	.nway_reset		= bcm_enet_nway_reset,
 	.get_settings		= bcm_enet_get_settings,
 	.set_settings		= bcm_enet_set_settings,
 	.get_drvinfo		= bcm_enet_get_drvinfo,
-- 
1.7.10.4
