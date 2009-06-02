Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 00:48:39 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:54293 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022121AbZFBXrm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 00:47:42 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 30307112408D; Wed,  3 Jun 2009 01:47:37 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 3/3] bcm63xx: use NET_IP_ALIGN
Date:	Wed,  3 Jun 2009 01:47:37 +0200
Message-Id: <1243986457-27088-4-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243986457-27088-1-git-send-email-mbizon@freebox.fr>
References: <1243986457-27088-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Replace hardcoded 2 with NET_IP_ALIGN.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/bcm63xx_enet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index 322ed03..660ffa2 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -320,7 +320,7 @@ static int bcm_enet_receive_queue(struct net_device *dev, int budget)
 		if (len < copybreak) {
 			struct sk_buff *nskb;
 
-			nskb = netdev_alloc_skb(dev, len + 2);
+			nskb = netdev_alloc_skb(dev, len + NET_IP_ALIGN);
 			if (!nskb) {
 				/* forget packet, just rearm desc */
 				priv->stats.rx_dropped++;
-- 
1.6.0.4
