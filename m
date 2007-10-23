Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 18:13:43 +0100 (BST)
Received: from rn-out-0910.google.com ([64.233.170.190]:45939 "EHLO
	rn-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20031527AbXJWRNe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 18:13:34 +0100
Received: by rn-out-0102.google.com with SMTP id e25so699581rng
        for <linux-mips@linux-mips.org>; Tue, 23 Oct 2007 10:12:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=jSNVkfsWnN0ek4z9gHaBgH51C5OakJdCp2qCCPmQfqg=;
        b=nKUvvuH6c2JwAYH/JlkKo8RY2cIO6Dtwat9QpiTXpmyKPzDxJC4YP4hY3kHpZX+lm3k1uslggm4gfDS7ANiAAW624hNresZo3hNU2pmUOdOkK4mUqseUUeIBXEnpL6aStr0z75Gw8q64utGg+itAoXBT4eaNF7+p7JkvoCmusTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DbtAaP4zk4VvHb3UOPnZVAbVgjx4O2j1iIa3UhvfDFFGDvqfuL0vpXmhPi9ADa1Ltvl8knGG2ctGdCp6jaSIdoUfJQxCSOjnaVAWo+JMkVFK3CSzWPY1PujE6BmMCfos4Cid59C/J6crxMgxTG78JWHepsZxuAhD8e0cCoBIeVE=
Received: by 10.142.97.20 with SMTP id u20mr2067870wfb.1193159552574;
        Tue, 23 Oct 2007 10:12:32 -0700 (PDT)
Received: from ?192.168.0.3? ( [80.117.125.149])
        by mx.google.com with ESMTPS id m6sm8654017wrm.2007.10.23.10.12.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2007 10:12:30 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][MIPS] AR7 ethernet
Date:	Tue, 23 Oct 2007 19:12:22 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org, Eugene Konev <ejka@imfi.kspu.ru>,
	netdev@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
	pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
	kaber@coreworks.de, Andrew Morton <akpm@linux-foundation.org>
References: <200710141810.13752.technoboy85@gmail.com> <4713B055.802@pobox.com>
In-Reply-To: <4713B055.802@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710231912.23446.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Monday 15 October 2007 20:24:21 Jeff Garzik ha scritto:
> applied

Small update to the driver, please apply

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>

diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index ae41973..57541d2 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -460,18 +460,11 @@ static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct cpmac_desc *desc;
 	struct cpmac_priv *priv = netdev_priv(dev);
 
-	if (unlikely(skb_padto(skb, ETH_ZLEN))) {
-		if (netif_msg_tx_err(priv) && net_ratelimit())
-			printk(KERN_WARNING
-			       "%s: tx: padding failed, dropping\n", dev->name);
-		spin_lock(&priv->lock);
-		dev->stats.tx_dropped++;
-		spin_unlock(&priv->lock);
-		return -ENOMEM;
-	}
+	if (unlikely(skb_padto(skb, ETH_ZLEN)))
+		return NETDEV_TX_OK;
 
 	len = max(skb->len, ETH_ZLEN);
-	queue = skb_get_queue_mapping(skb);
+	queue = skb->queue_mapping;
 #ifdef CONFIG_NETDEVICES_MULTIQUEUE
 	netif_stop_subqueue(dev, queue);
 #else
@@ -481,13 +474,9 @@ static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	desc = &priv->desc_ring[queue];
 	if (unlikely(desc->dataflags & CPMAC_OWN)) {
 		if (netif_msg_tx_err(priv) && net_ratelimit())
-			printk(KERN_WARNING "%s: tx dma ring full, dropping\n",
+			printk(KERN_WARNING "%s: tx dma ring full\n",
 			       dev->name);
-		spin_lock(&priv->lock);
-		dev->stats.tx_dropped++;
-		spin_unlock(&priv->lock);
-		dev_kfree_skb_any(skb);
-		return -ENOMEM;
+		return NETDEV_TX_BUSY;
 	}
 
 	spin_lock(&priv->lock);
@@ -509,7 +498,7 @@ static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		cpmac_dump_skb(dev, skb);
 	cpmac_write(priv->regs, CPMAC_TX_PTR(queue), (u32)desc->mapping);
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 static void cpmac_end_xmit(struct net_device *dev, int queue)
@@ -646,12 +635,14 @@ static void cpmac_clear_tx(struct net_device *dev)
 	int i;
 	if (unlikely(!priv->desc_ring))
 		return;
-	for (i = 0; i < CPMAC_QUEUES; i++)
+	for (i = 0; i < CPMAC_QUEUES; i++) {
+		priv->desc_ring[i].dataflags = 0;
 		if (priv->desc_ring[i].skb) {
 			dev_kfree_skb_any(priv->desc_ring[i].skb);
 			if (netif_subqueue_stopped(dev, i))
 			    netif_wake_subqueue(dev, i);
 		}
+	}
 }
 
 static void cpmac_hw_error(struct work_struct *work)
@@ -727,11 +718,13 @@ static void cpmac_tx_timeout(struct net_device *dev)
 #ifdef CONFIG_NETDEVICES_MULTIQUEUE
 	for (i = 0; i < CPMAC_QUEUES; i++)
 		if (priv->desc_ring[i].skb) {
+			priv->desc_ring[i].dataflags = 0;
 			dev_kfree_skb_any(priv->desc_ring[i].skb);
 			netif_wake_subqueue(dev, i);
 			break;
 		}
 #else
+	priv->desc_ring[0].dataflags = 0;
 	if (priv->desc_ring[0].skb)
 		dev_kfree_skb_any(priv->desc_ring[0].skb);
 	netif_wake_queue(dev);
@@ -794,7 +787,7 @@ static int cpmac_set_ringparam(struct net_device *dev, struct ethtool_ringparam*
 {
 	struct cpmac_priv *priv = netdev_priv(dev);
 
-	if (dev->flags && IFF_UP)
+	if (netif_running(dev))
 		return -EBUSY;
 	priv->ring_size = ring->rx_pending;
 	return 0;
