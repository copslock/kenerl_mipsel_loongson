Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 14:01:04 +0200 (CEST)
Received: from [192.95.5.64] ([192.95.5.64]:55513 "EHLO frisell.zx2c4.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991232AbdGJMA5wJyZ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jul 2017 14:00:57 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b88dd73f;
        Mon, 10 Jul 2017 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id; s=mail; bh=o+Vkn7eBavdl+H1N/ybCtWowIJA
        =; b=DqbA1Eg4eHUGbsl5/StqTF1n0gaLKAJ8HFkQqtex+ntRJ7dfVlcgdplnIRd
        AXNqDY3GWqEfM0VsEnpYkh0/xFWU4N6XC7QU/v5P6VAWXFIyIYB2uSt3VTGV0TF5
        5DdYwuqLufkSwacpuPlFqY4k0vRH7uqi8/lmOAlRM6Ijg8Duc6IYMuJiqdqk7F/o
        BsrXNxB0dpC/DCLyWGc1oKb8C2q4WjYH5rFblrqZq8WsDd8Zq7qoeNk69bJyiCyw
        IKzKhOuQ2we8n0sGIQBQg+ykoATF/B9mV+Stt+zpkAEuW31x0uUQHPH2emJah8Xn
        EIVWEDdX6CLVfWivO0KwJrKqNzA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 711d4c36 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 10 Jul 2017 11:56:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, davem@davemloft.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] ioc3-eth: store pointer to net_device for priviate area
Date:   Mon, 10 Jul 2017 14:00:32 +0200
Message-Id: <20170710120032.11173-1-Jason@zx2c4.com>
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Computing the alignment manually for going from priv to pub is probably
not such a good idea, and in general the assumption that going from priv
to pub is possible trivially could change, so rather than relying on
that, we change things to just store a pointer to pub. This was sugested
by DaveM in [1].

[1] http://www.spinics.net/lists/netdev/msg443992.html

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Ralf - I don't have the platform to test this out, so you might want to
briefly put it through the paces before giving it your sign-off.

 drivers/net/ethernet/sgi/ioc3-eth.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index b607936e1b3e..9c0488e0f08e 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -90,17 +90,13 @@ struct ioc3_private {
 	spinlock_t ioc3_lock;
 	struct mii_if_info mii;
 
+	struct net_device *dev;
 	struct pci_dev *pdev;
 
 	/* Members used by autonegotiation  */
 	struct timer_list ioc3_timer;
 };
 
-static inline struct net_device *priv_netdev(struct ioc3_private *dev)
-{
-	return (void *)dev - ((sizeof(struct net_device) + 31) & ~31);
-}
-
 static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void ioc3_set_multicast_list(struct net_device *dev);
 static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -427,7 +423,7 @@ static void ioc3_get_eaddr_nic(struct ioc3_private *ip)
 		nic[i] = nic_read_byte(ioc3);
 
 	for (i = 2; i < 8; i++)
-		priv_netdev(ip)->dev_addr[i - 2] = nic[i];
+		ip->dev->dev_addr[i - 2] = nic[i];
 }
 
 /*
@@ -439,7 +435,7 @@ static void ioc3_get_eaddr(struct ioc3_private *ip)
 {
 	ioc3_get_eaddr_nic(ip);
 
-	printk("Ethernet address is %pM.\n", priv_netdev(ip)->dev_addr);
+	printk("Ethernet address is %pM.\n", ip->dev->dev_addr);
 }
 
 static void __ioc3_set_mac_address(struct net_device *dev)
@@ -790,13 +786,12 @@ static void ioc3_timer(unsigned long data)
  */
 static int ioc3_mii_init(struct ioc3_private *ip)
 {
-	struct net_device *dev = priv_netdev(ip);
 	int i, found = 0, res = 0;
 	int ioc3_phy_workaround = 1;
 	u16 word;
 
 	for (i = 0; i < 32; i++) {
-		word = ioc3_mdio_read(dev, i, MII_PHYSID1);
+		word = ioc3_mdio_read(ip->dev, i, MII_PHYSID1);
 
 		if (word != 0xffff && word != 0x0000) {
 			found = 1;
@@ -1276,6 +1271,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	ip = netdev_priv(dev);
+	ip->dev = dev;
 
 	dev->irq = pdev->irq;
 
-- 
2.13.2
