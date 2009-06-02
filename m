Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 00:47:50 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:54287 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021937AbZFBXrm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 00:47:42 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 28A7A112406C; Wed,  3 Jun 2009 01:47:37 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/3] bcm63xx: don't use BUS_ID_SIZE in bcm63xx_enet.
Date:	Wed,  3 Jun 2009 01:47:35 +0200
Message-Id: <1243986457-27088-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243986457-27088-1-git-send-email-mbizon@freebox.fr>
References: <1243986457-27088-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Networking recently got rid of BUS_ID_SIZE. Use MII_BUS_ID_SIZE
instead in bcm63xx_enet.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/bcm63xx_enet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index 36324b3..af0114a 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -793,7 +793,7 @@ static int bcm_enet_open(struct net_device *dev)
 	struct phy_device *phydev;
 	int i, ret;
 	unsigned int size;
-	char phy_id[BUS_ID_SIZE];
+	char phy_id[MII_BUS_ID_SIZE + 3];
 	void *p;
 	u32 val;
 
@@ -802,7 +802,7 @@ static int bcm_enet_open(struct net_device *dev)
 
 	if (priv->has_phy) {
 		/* connect to PHY */
-		snprintf(phy_id, BUS_ID_SIZE, PHY_ID_FMT,
+		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT,
 			 priv->mac_id ? "1" : "0", priv->phy_id);
 
 		phydev = phy_connect(dev, phy_id, &bcm_enet_adjust_phy_link, 0,
-- 
1.6.0.4
