Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 03:27:10 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:31998 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20171182AbYIQC1H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 03:27:07 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m8H2QwBb023784;
	Tue, 16 Sep 2008 19:26:59 -0700 (PDT)
Received: from localhost.localdomain ([128.224.162.196]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Sep 2008 19:26:57 -0700
From:	Weiwei Wang <weiwei.wang@windriver.com>
To:	linux-mips@linux-mips.org, jgarzik@redhat.com, ralf@linux-mips.org
Subject: [PATCH] convert sbmac tx to spin_lock_irqsave to prevent early IRQ enable
Date:	Wed, 17 Sep 2008 10:25:37 +0800
Message-Id: <6781da3918e3c34d23e5f7e9cf777ab463a17d5e.1221613284.git.weiwei.wang@windriver.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 17 Sep 2008 02:26:57.0536 (UTC) FILETIME=[DB86F800:01C9186C]
Return-Path: <Weiwei.Wang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiwei.wang@windriver.com
Precedence: bulk
X-list: linux-mips

Netpoll will call the interrupt handler with interrupts
disabled when using kgdboe, so spin_lock_irqsave() should
be used instead of spin_lock_irq() to prevent interrupts
from being incorrectly enabled.

Signed-off-by: Weiwei Wang <weiwei.wang@windriver.com>
---
 drivers/net/sb1250-mac.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/sb1250-mac.c b/drivers/net/sb1250-mac.c
index fe41e4e..ce10cfa 100644
--- a/drivers/net/sb1250-mac.c
+++ b/drivers/net/sb1250-mac.c
@@ -2069,9 +2069,10 @@ static irqreturn_t sbmac_intr(int irq,void *dev_instance)
 static int sbmac_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sbmac_softc *sc = netdev_priv(dev);
+	unsigned long flags;
 
 	/* lock eth irq */
-	spin_lock_irq (&sc->sbm_lock);
+	spin_lock_irqsave(&sc->sbm_lock, flags);
 
 	/*
 	 * Put the buffer on the transmit ring.  If we
@@ -2081,14 +2082,14 @@ static int sbmac_start_tx(struct sk_buff *skb, struct net_device *dev)
 	if (sbdma_add_txbuffer(&(sc->sbm_txdma),skb)) {
 		/* XXX save skb that we could not send */
 		netif_stop_queue(dev);
-		spin_unlock_irq(&sc->sbm_lock);
+		spin_unlock_irqrestore(&sc->sbm_lock, flags);
 
 		return 1;
 	}
 
 	dev->trans_start = jiffies;
 
-	spin_unlock_irq (&sc->sbm_lock);
+	spin_unlock_irqrestore(&sc->sbm_lock, flags);
 
 	return 0;
 }
@@ -2568,14 +2569,15 @@ static void sbmac_mii_poll(struct net_device *dev)
 static void sbmac_tx_timeout (struct net_device *dev)
 {
 	struct sbmac_softc *sc = netdev_priv(dev);
+	unsigned long flags;
 
-	spin_lock_irq (&sc->sbm_lock);
+	spin_lock_irqsave(&sc->sbm_lock, flags);
 
 
 	dev->trans_start = jiffies;
 	dev->stats.tx_errors++;
 
-	spin_unlock_irq (&sc->sbm_lock);
+	spin_unlock_irqrestore(&sc->sbm_lock, flags);
 
 	printk (KERN_WARNING "%s: Transmit timed out\n",dev->name);
 }
-- 
1.5.5.1
