Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 20:43:09 +0100 (CET)
Received: from mail-fx0-f210.google.com ([209.85.220.210]:58847 "EHLO
        mail-fx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492162Ab0BOTnF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 20:43:05 +0100
Received: by fxm2 with SMTP id 2so2276081fxm.27
        for <multiple recipients>; Mon, 15 Feb 2010 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=eugNmN2OyxRKYqiSg1FcAVkcbzagt4J1mnEUYH/QI1c=;
        b=dfkX4ahaN/7RkGG40as9N7yhShxzne5LeO+duh5+n4LjyN4TzY7zEnFQ8yC9YO5Lt9
         SaO5v7MlaDYnFeqkaYCh9nK6cGtuSNn4jgd4qddRye1WNlQBRZKUfTK77wFQyHqyb0Hf
         N5B5I6kn3k4cjZHqPowFGku8DZqclypwtMj20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Q5qNozqDFfjI/WOIhovsKSHoBkzA1PrbAhhgqWgpIc/9vm6wP2npjTj+ICAITZyCTF
         6YWwLgibWSh7NzVfvjg4WhkxGlB3w01HJXz7RMqic4w1ebKSJh1NekeBUh7CqScsbaAL
         KBq2TkHZLbgAg8CnvwaN+pVdgWsDGWRWgWrPc=
Received: by 10.223.100.150 with SMTP id y22mr6184177fan.99.1266262978161;
        Mon, 15 Feb 2010 11:42:58 -0800 (PST)
Received: from localhost.localdomain (p5496BF25.dip.t-dialin.net [84.150.191.37])
        by mx.google.com with ESMTPS id b17sm10661729fka.16.2010.02.15.11.42.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 11:42:55 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        =?UTF-8?q?Ralf=20B=E4chle?= <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue] MIPS/net: fix au1000_eth.c build and warnings
Date:   Mon, 15 Feb 2010 20:43:37 +0100
Message-Id: <1266263017-6874-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.6.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

- buildfix: DECLARE_MAC_BUF was removed recently.
- remove various warnings spit out during build

Only compile-tested.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Hi Ralf!  Please fold this into the patch titled
"NET: au1000-eth: convert to platform_driver model"
in mips-queue, thank you!

 drivers/net/au1000_eth.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 1acf2c1..6e5a68e 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -397,11 +397,12 @@ static int mii_probe (struct net_device *dev)
 				/* find the first (lowest address) non-attached PHY on
 				 * the MAC0 MII bus */
 				for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
-					if (aup->mac_id == 1)
-						break;
 					struct phy_device *const tmp_phydev =
 							aup->mii_bus->phy_map[phy_addr];
 
+					if (aup->mac_id == 1)
+						break;
+
 					if (!tmp_phydev)
 						continue; /* no PHY here... */
 
@@ -650,7 +651,6 @@ static int au1000_init(struct net_device *dev)
 
 static inline void update_rx_stats(struct net_device *dev, u32 status)
 {
-	struct au1000_private *aup = netdev_priv(dev);
 	struct net_device_stats *ps = &dev->stats;
 
 	ps->rx_packets++;
@@ -908,7 +908,7 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	pDB = aup->tx_db_inuse[aup->tx_head];
-	skb_copy_from_linear_data(skb, pDB->vaddr, skb->len);
+	skb_copy_from_linear_data(skb, (void *)pDB->vaddr, skb->len);
 	if (skb->len < ETH_ZLEN) {
 		for (i=skb->len; i<ETH_ZLEN; i++) {
 			((char *)pDB->vaddr)[i] = 0;
@@ -1006,7 +1006,7 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	db_dest_t *pDB, *pDBfree;
 	int irq, i, err = 0;
 	struct resource *base, *macen;
-	DECLARE_MAC_BUF(ethaddr);
+	char ethaddr[6];
 
 	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!base) {
@@ -1207,8 +1207,8 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	printk("%s: Au1xx0 Ethernet found at 0x%x, irq %d\n",
-					dev->name, base->start, irq);
+	printk("%s: Au1xx0 Ethernet found at 0x%lx, irq %d\n",
+			dev->name, (unsigned long)base->start, irq);
 	if (version_printed++ == 0)
 		printk("%s version %s %s\n", DRV_NAME, DRV_VERSION, DRV_AUTHOR);
 
-- 
1.6.6.1
