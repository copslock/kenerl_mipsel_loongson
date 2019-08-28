Return-Path: <SRS0=KjQ3=WY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3110AC3A5A1
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E5D22CED
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 14:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfH1OEB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:04:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfH1ODe (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 28 Aug 2019 10:03:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11C2EB64F;
        Wed, 28 Aug 2019 14:03:32 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next 10/15] net: sgi: ioc3-eth: refactor rx buffer allocation
Date:   Wed, 28 Aug 2019 16:03:09 +0200
Message-Id: <20190828140315.17048-11-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190828140315.17048-1-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Move common code for rx buffer setup into ioc3_alloc_skb and deal
with allocation failures. Also clean up allocation size calculation.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 95 ++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index e51922b5ca04..ecd3bc135cc0 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -11,11 +11,8 @@
  *
  * To do:
  *
- *  o Handle allocation failures in ioc3_alloc_skb() more gracefully.
- *  o Handle allocation failures in ioc3_init_rings().
  *  o Use prefetching for large packets.  What is a good lower limit for
  *    prefetching?
- *  o We're probably allocating a bit too much memory.
  *  o Use hardware checksums.
  *  o Convert to using a IOC3 meta driver.
  *  o Which PHYs might possibly be attached to the IOC3 in real live,
@@ -72,6 +69,13 @@
 #define TX_RING_ENTRIES		128
 #define TX_RING_MASK		(TX_RING_ENTRIES - 1)
 
+/* IOC3 does dma transfers in 128 byte blocks */
+#define IOC3_DMA_XFER_LEN	128UL
+
+/* Every RX buffer starts with 8 byte descriptor data */
+#define RX_OFFSET		(sizeof(struct ioc3_erxbuf) + NET_IP_ALIGN)
+#define RX_BUF_SIZE		(13 * IOC3_DMA_XFER_LEN)
+
 #define ETCSR_FD   ((17 << ETCSR_IPGR2_SHIFT) | (11 << ETCSR_IPGR1_SHIFT) | 21)
 #define ETCSR_HD   ((21 << ETCSR_IPGR2_SHIFT) | (21 << ETCSR_IPGR1_SHIFT) | 21)
 
@@ -108,36 +112,38 @@ static inline unsigned int ioc3_hash(const unsigned char *addr);
 static void ioc3_start(struct ioc3_private *ip);
 static inline void ioc3_stop(struct ioc3_private *ip);
 static void ioc3_init(struct net_device *dev);
-static void ioc3_alloc_rx_bufs(struct net_device *dev);
+static int ioc3_alloc_rx_bufs(struct net_device *dev);
 static void ioc3_free_rx_bufs(struct ioc3_private *ip);
 static inline void ioc3_clean_tx_ring(struct ioc3_private *ip);
 
 static const char ioc3_str[] = "IOC3 Ethernet";
 static const struct ethtool_ops ioc3_ethtool_ops;
 
-/* We use this to acquire receive skb's that we can DMA directly into. */
-
-#define IOC3_CACHELINE	128UL
 
 static inline unsigned long aligned_rx_skb_addr(unsigned long addr)
 {
-	return (~addr + 1) & (IOC3_CACHELINE - 1UL);
+	return (~addr + 1) & (IOC3_DMA_XFER_LEN - 1UL);
 }
 
-static inline struct sk_buff *ioc3_alloc_skb(unsigned long length,
-					     unsigned int gfp_mask)
+static inline int ioc3_alloc_skb(struct sk_buff **skb, struct ioc3_erxbuf **rxb)
 {
-	struct sk_buff *skb;
+	struct sk_buff *new_skb;
+	int offset;
 
-	skb = alloc_skb(length + IOC3_CACHELINE - 1, gfp_mask);
-	if (likely(skb)) {
-		int offset = aligned_rx_skb_addr((unsigned long)skb->data);
+	new_skb = alloc_skb(RX_BUF_SIZE + IOC3_DMA_XFER_LEN - 1, GFP_ATOMIC);
+	if (!new_skb)
+		return -ENOMEM;
 
-		if (offset)
-			skb_reserve(skb, offset);
-	}
+	/* ensure buffer is aligned to IOC3_DMA_XFER_LEN */
+	offset = aligned_rx_skb_addr((unsigned long)new_skb->data);
+	if (offset)
+		skb_reserve(new_skb, offset);
+
+	*rxb = (struct ioc3_erxbuf *)new_skb->data;
+	skb_reserve(new_skb, RX_OFFSET);
+	*skb = new_skb;
 
-	return skb;
+	return 0;
 }
 
 static inline unsigned long ioc3_map(void *ptr, unsigned long vdev)
@@ -151,13 +157,6 @@ static inline unsigned long ioc3_map(void *ptr, unsigned long vdev)
 	return virt_to_bus(ptr);
 #endif
 }
-
-/* BEWARE: The IOC3 documentation documents the size of rx buffers as
- * 1644 while it's actually 1664.  This one was nasty to track down ...
- */
-#define RX_OFFSET		10
-#define RX_BUF_ALLOC_SIZE	(1664 + RX_OFFSET + IOC3_CACHELINE)
-
 #define IOC3_SIZE 0x100000
 
 static inline u32 mcr_pack(u32 pulse, u32 sample)
@@ -538,11 +537,10 @@ static inline void ioc3_rx(struct net_device *dev)
 		err = be32_to_cpu(rxb->err);		/* It's valid ...  */
 		if (err & ERXBUF_GOODPKT) {
 			len = ((w0 >> ERXBUF_BYTECNT_SHIFT) & 0x7ff) - 4;
-			skb_trim(skb, len);
+			skb_put(skb, len);
 			skb->protocol = eth_type_trans(skb, dev);
 
-			new_skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
-			if (!new_skb) {
+			if (ioc3_alloc_skb(&new_skb, &rxb)) {
 				/* Ouch, drop packet and just recycle packet
 				 * to keep the ring filled.
 				 */
@@ -560,11 +558,6 @@ static inline void ioc3_rx(struct net_device *dev)
 
 			ip->rx_skbs[rx_entry] = NULL;	/* Poison  */
 
-			/* Because we reserve afterwards. */
-			skb_put(new_skb, (1664 + RX_OFFSET));
-			rxb = (struct ioc3_erxbuf *)new_skb->data;
-			skb_reserve(new_skb, RX_OFFSET);
-
 			dev->stats.rx_packets++;		/* Statistics */
 			dev->stats.rx_bytes += len;
 		} else {
@@ -667,7 +660,11 @@ static void ioc3_error(struct net_device *dev, u32 eisr)
 	ioc3_clean_tx_ring(ip);
 
 	ioc3_init(dev);
-	ioc3_alloc_rx_bufs(dev);
+	if (ioc3_alloc_rx_bufs(dev)) {
+		netdev_err(dev, "ioc3_error: rx buffer allocation failed\n");
+		spin_unlock(&ip->ioc3_lock);
+		return;
+	}
 	ioc3_start(ip);
 	ioc3_mii_init(ip);
 
@@ -804,7 +801,7 @@ static void ioc3_free_rx_bufs(struct ioc3_private *ip)
 	}
 }
 
-static void ioc3_alloc_rx_bufs(struct net_device *dev)
+static int ioc3_alloc_rx_bufs(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 	struct ioc3_erxbuf *rxb;
@@ -815,24 +812,15 @@ static void ioc3_alloc_rx_bufs(struct net_device *dev)
 	 * this for performance and memory later.
 	 */
 	for (i = 0; i < RX_BUFFS; i++) {
-		struct sk_buff *skb;
-
-		skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
-		if (!skb) {
-			show_free_areas(0, NULL);
-			continue;
-		}
-
-		ip->rx_skbs[i] = skb;
+		if (ioc3_alloc_skb(&ip->rx_skbs[i], &rxb))
+			return -ENOMEM;
 
-		/* Because we reserve afterwards. */
-		skb_put(skb, (1664 + RX_OFFSET));
-		rxb = (struct ioc3_erxbuf *)skb->data;
 		ip->rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
-		skb_reserve(skb, RX_OFFSET);
 	}
 	ip->rx_ci = 0;
 	ip->rx_pi = RX_BUFFS;
+
+	return 0;
 }
 
 static inline void ioc3_ssram_disc(struct ioc3_private *ip)
@@ -944,7 +932,10 @@ static int ioc3_open(struct net_device *dev)
 	ip->ehar_l = 0;
 
 	ioc3_init(dev);
-	ioc3_alloc_rx_bufs(dev);
+	if (ioc3_alloc_rx_bufs(dev)) {
+		netdev_err(dev, "ioc3_open: rx buffer allocation failed\n");
+		return -ENOMEM;
+	}
 	ioc3_start(ip);
 	ioc3_mii_start(ip);
 
@@ -1435,7 +1426,11 @@ static void ioc3_timeout(struct net_device *dev)
 	ioc3_clean_tx_ring(ip);
 
 	ioc3_init(dev);
-	ioc3_alloc_rx_bufs(dev);
+	if (ioc3_alloc_rx_bufs(dev)) {
+		netdev_err(dev, "ioc3_timeout: rx buffer allocation failed\n");
+		spin_unlock_irq(&ip->ioc3_lock);
+		return;
+	}
 	ioc3_start(ip);
 	ioc3_mii_init(ip);
 	ioc3_mii_start(ip);
-- 
2.13.7

