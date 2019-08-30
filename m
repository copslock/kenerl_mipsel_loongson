Return-Path: <SRS0=WyAB=W2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A4C3A5A4
	for <linux-mips@archiver.kernel.org>; Fri, 30 Aug 2019 09:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B4521726
	for <linux-mips@archiver.kernel.org>; Fri, 30 Aug 2019 09:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH3J0R (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:26:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:41762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728201AbfH3JZ7 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 30 Aug 2019 05:25:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 117A1B0B3;
        Fri, 30 Aug 2019 09:25:57 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 net-next 11/15] net: sgi: ioc3-eth: use dma-direct for dma allocations
Date:   Fri, 30 Aug 2019 11:25:34 +0200
Message-Id: <20190830092539.24550-12-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190830092539.24550-1-tbogendoerfer@suse.de>
References: <20190830092539.24550-1-tbogendoerfer@suse.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Replace the homegrown DMA memory allocation, which only works on
SGI-IP27 machines, with the generic dma allocations.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 146 ++++++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 7531944d2e95..ed8f997a3cec 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -36,7 +36,6 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
-#include <linux/dma-mapping.h>
 #include <linux/gfp.h>
 
 #ifdef CONFIG_SERIAL_8250
@@ -49,6 +48,8 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/skbuff.h>
+#include <linux/dma-direct.h>
+
 #include <net/ip.h>
 
 #include <asm/byteorder.h>
@@ -64,10 +65,12 @@
 #define RX_BUFFS		64
 #define RX_RING_ENTRIES		512		/* fixed in hardware */
 #define RX_RING_MASK		(RX_RING_ENTRIES - 1)
+#define RX_RING_SIZE		(RX_RING_ENTRIES * sizeof(u64))
 
 /* 128 TX buffers (not tunable) */
 #define TX_RING_ENTRIES		128
 #define TX_RING_MASK		(TX_RING_ENTRIES - 1)
+#define TX_RING_SIZE		(TX_RING_ENTRIES * sizeof(struct ioc3_etxd))
 
 /* IOC3 does dma transfers in 128 byte blocks */
 #define IOC3_DMA_XFER_LEN	128UL
@@ -83,9 +86,12 @@
 struct ioc3_private {
 	struct ioc3_ethregs *regs;
 	struct ioc3 *all_regs;
+	struct device *dma_dev;
 	u32 *ssram;
 	unsigned long *rxr;		/* pointer to receiver ring */
 	struct ioc3_etxd *txr;
+	dma_addr_t rxr_dma;
+	dma_addr_t txr_dma;
 	struct sk_buff *rx_skbs[RX_RING_ENTRIES];
 	struct sk_buff *tx_skbs[TX_RING_ENTRIES];
 	int rx_ci;			/* RX consumer index */
@@ -125,9 +131,11 @@ static inline unsigned long aligned_rx_skb_addr(unsigned long addr)
 	return (~addr + 1) & (IOC3_DMA_XFER_LEN - 1UL);
 }
 
-static inline int ioc3_alloc_skb(struct sk_buff **skb, struct ioc3_erxbuf **rxb)
+static inline int ioc3_alloc_skb(struct ioc3_private *ip, struct sk_buff **skb,
+				 struct ioc3_erxbuf **rxb, dma_addr_t *rxb_dma)
 {
 	struct sk_buff *new_skb;
+	dma_addr_t d;
 	int offset;
 
 	new_skb = alloc_skb(RX_BUF_SIZE + IOC3_DMA_XFER_LEN - 1, GFP_ATOMIC);
@@ -139,6 +147,14 @@ static inline int ioc3_alloc_skb(struct sk_buff **skb, struct ioc3_erxbuf **rxb)
 	if (offset)
 		skb_reserve(new_skb, offset);
 
+	d = dma_map_single(ip->dma_dev, new_skb->data,
+			   RX_BUF_SIZE, DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(ip->dma_dev, d)) {
+		dev_kfree_skb_any(new_skb);
+		return -ENOMEM;
+	}
+	*rxb_dma = d;
 	*rxb = (struct ioc3_erxbuf *)new_skb->data;
 	skb_reserve(new_skb, RX_OFFSET);
 	*skb = new_skb;
@@ -146,17 +162,22 @@ static inline int ioc3_alloc_skb(struct sk_buff **skb, struct ioc3_erxbuf **rxb)
 	return 0;
 }
 
-static inline unsigned long ioc3_map(void *ptr, unsigned long vdev)
+#ifdef CONFIG_PCI_XTALK_BRIDGE
+static inline unsigned long ioc3_map(dma_addr_t addr, unsigned long attr)
 {
-#ifdef CONFIG_SGI_IP27
-	vdev <<= 57;   /* Shift to PCI64_ATTR_VIRTUAL */
+	return (addr & ~PCI64_ATTR_BAR) | attr;
+}
 
-	return vdev | (0xaUL << PCI64_ATTR_TARG_SHFT) | PCI64_ATTR_PREF |
-	       ((unsigned long)ptr & TO_PHYS_MASK);
+#define ERBAR_VAL	(ERBAR_BARRIER_BIT << ERBAR_RXBARR_SHIFT)
 #else
-	return virt_to_bus(ptr);
-#endif
+static inline unsigned long ioc3_map(dma_addr_t addr, unsigned long attr)
+{
+	return addr;
 }
+
+#define ERBAR_VAL	0
+#endif
+
 #define IOC3_SIZE 0x100000
 
 static inline u32 mcr_pack(u32 pulse, u32 sample)
@@ -523,6 +544,7 @@ static inline void ioc3_rx(struct net_device *dev)
 	int rx_entry, n_entry, len;
 	struct ioc3_erxbuf *rxb;
 	unsigned long *rxr;
+	dma_addr_t d;
 	u32 w0, err;
 
 	rxr = ip->rxr;		/* Ring base */
@@ -540,12 +562,13 @@ static inline void ioc3_rx(struct net_device *dev)
 			skb_put(skb, len);
 			skb->protocol = eth_type_trans(skb, dev);
 
-			if (ioc3_alloc_skb(&new_skb, &rxb)) {
+			if (ioc3_alloc_skb(ip, &new_skb, &rxb, &d)) {
 				/* Ouch, drop packet and just recycle packet
 				 * to keep the ring filled.
 				 */
 				dev->stats.rx_dropped++;
 				new_skb = skb;
+				d = rxr[rx_entry];
 				goto next;
 			}
 
@@ -554,6 +577,9 @@ static inline void ioc3_rx(struct net_device *dev)
 						     w0 & ERXBUF_IPCKSUM_MASK,
 						     len);
 
+			dma_unmap_single(ip->dma_dev, rxr[rx_entry],
+					 RX_BUF_SIZE, DMA_FROM_DEVICE);
+
 			netif_rx(skb);
 
 			ip->rx_skbs[rx_entry] = NULL;	/* Poison  */
@@ -566,15 +592,17 @@ static inline void ioc3_rx(struct net_device *dev)
 			 * recycle it.
 			 */
 			new_skb = skb;
+			d = rxr[rx_entry];
 			dev->stats.rx_errors++;
 		}
 		if (err & ERXBUF_CRCERR)	/* Statistics */
 			dev->stats.rx_crc_errors++;
 		if (err & ERXBUF_FRAMERR)
 			dev->stats.rx_frame_errors++;
+
 next:
 		ip->rx_skbs[n_entry] = new_skb;
-		rxr[n_entry] = cpu_to_be64(ioc3_map(rxb, 1));
+		rxr[n_entry] = cpu_to_be64(ioc3_map(d, PCI64_ATTR_BAR));
 		rxb->w0 = 0;				/* Clear valid flag */
 		n_entry = (n_entry + 1) & RX_RING_MASK;	/* Update erpir */
 
@@ -767,6 +795,26 @@ static void ioc3_mii_start(struct ioc3_private *ip)
 	add_timer(&ip->ioc3_timer);
 }
 
+static inline void ioc3_tx_unmap(struct ioc3_private *ip, int entry)
+{
+	struct ioc3_etxd *desc;
+	u32 cmd, bufcnt, len;
+
+	desc = &ip->txr[entry];
+	cmd = be32_to_cpu(desc->cmd);
+	bufcnt = be32_to_cpu(desc->bufcnt);
+	if (cmd & ETXD_B1V) {
+		len = (bufcnt & ETXD_B1CNT_MASK) >> ETXD_B1CNT_SHIFT;
+		dma_unmap_single(ip->dma_dev, be64_to_cpu(desc->p1),
+				 len, DMA_TO_DEVICE);
+	}
+	if (cmd & ETXD_B2V) {
+		len = (bufcnt & ETXD_B2CNT_MASK) >> ETXD_B2CNT_SHIFT;
+		dma_unmap_single(ip->dma_dev, be64_to_cpu(desc->p2),
+				 len, DMA_TO_DEVICE);
+	}
+}
+
 static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 {
 	struct sk_buff *skb;
@@ -775,6 +823,7 @@ static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 	for (i = 0; i < TX_RING_ENTRIES; i++) {
 		skb = ip->tx_skbs[i];
 		if (skb) {
+			ioc3_tx_unmap(ip, i);
 			ip->tx_skbs[i] = NULL;
 			dev_kfree_skb_any(skb);
 		}
@@ -787,13 +836,19 @@ static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 static void ioc3_free_rx_bufs(struct ioc3_private *ip)
 {
 	int rx_entry, n_entry;
+	struct sk_buff *skb;
 
 	n_entry = ip->rx_ci;
 	rx_entry = ip->rx_pi;
 
 	while (n_entry != rx_entry) {
-		dev_kfree_skb_any(ip->rx_skbs[n_entry]);
-
+		skb = ip->rx_skbs[n_entry];
+		if (skb) {
+			dma_unmap_single(ip->dma_dev,
+					 be64_to_cpu(ip->rxr[n_entry]),
+					 RX_BUF_SIZE, DMA_FROM_DEVICE);
+			dev_kfree_skb_any(skb);
+		}
 		n_entry = (n_entry + 1) & RX_RING_MASK;
 	}
 }
@@ -802,6 +857,7 @@ static int ioc3_alloc_rx_bufs(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 	struct ioc3_erxbuf *rxb;
+	dma_addr_t d;
 	int i;
 
 	/* Now the rx buffers.  The RX ring may be larger but
@@ -809,11 +865,11 @@ static int ioc3_alloc_rx_bufs(struct net_device *dev)
 	 * this for performance and memory later.
 	 */
 	for (i = 0; i < RX_BUFFS; i++) {
-		if (ioc3_alloc_skb(&ip->rx_skbs[i], &rxb))
+		if (ioc3_alloc_skb(ip, &ip->rx_skbs[i], &rxb, &d))
 			return -ENOMEM;
 
 		rxb->w0 = 0;	/* Clear valid flag */
-		ip->rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
+		ip->rxr[i] = cpu_to_be64(ioc3_map(d, PCI64_ATTR_BAR));
 	}
 	ip->rx_ci = 0;
 	ip->rx_pi = RX_BUFFS;
@@ -859,13 +915,7 @@ static void ioc3_init(struct net_device *dev)
 	readl(&regs->emcr);
 
 	/* Misc registers  */
-#ifdef CONFIG_SGI_IP27
-	/* Barrier on last store */
-	writel(PCI64_ATTR_BAR >> 32, &regs->erbar);
-#else
-	/* Let PCI API get it right */
-	writel(0, &regs->erbar);
-#endif
+	writel(ERBAR_VAL, &regs->erbar);
 	readl(&regs->etcdc);			/* Clear on read */
 	writel(15, &regs->ercsr);		/* RX low watermark  */
 	writel(0, &regs->ertr);			/* Interrupt immediately */
@@ -881,13 +931,13 @@ static void ioc3_start(struct ioc3_private *ip)
 	unsigned long ring;
 
 	/* Now the rx ring base, consume & produce registers.  */
-	ring = ioc3_map(ip->rxr, 0);
+	ring = ioc3_map(ip->rxr_dma, PCI64_ATTR_PREC);
 	writel(ring >> 32, &regs->erbr_h);
 	writel(ring & 0xffffffff, &regs->erbr_l);
 	writel(ip->rx_ci << 3, &regs->ercir);
 	writel((ip->rx_pi << 3) | ERPIR_ARM, &regs->erpir);
 
-	ring = ioc3_map(ip->txr, 0);
+	ring = ioc3_map(ip->txr_dma, PCI64_ATTR_PREC);
 
 	ip->txqlen = 0;					/* nothing queued  */
 
@@ -1161,6 +1211,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ip = netdev_priv(dev);
 	ip->dev = dev;
+	ip->dma_dev = &pdev->dev;
 
 	dev->irq = pdev->irq;
 
@@ -1187,7 +1238,8 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ioc3_stop(ip);
 
 	/* Allocate rx ring.  4kb = 512 entries, must be 4kb aligned */
-	ip->rxr = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+	ip->rxr = dma_direct_alloc_pages(ip->dma_dev, RX_RING_SIZE,
+					 &ip->rxr_dma, GFP_ATOMIC, 0);
 	if (!ip->rxr) {
 		pr_err("ioc3-eth: rx ring allocation failed\n");
 		err = -ENOMEM;
@@ -1195,7 +1247,9 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* Allocate tx rings.  16kb = 128 bufs, must be 16kb aligned  */
-	ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
+	ip->txr = dma_direct_alloc_pages(ip->dma_dev, TX_RING_SIZE,
+					 &ip->txr_dma,
+					 GFP_KERNEL | __GFP_ZERO, 0);
 	if (!ip->txr) {
 		pr_err("ioc3-eth: tx ring allocation failed\n");
 		err = -ENOMEM;
@@ -1255,9 +1309,11 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 out_stop:
 	del_timer_sync(&ip->ioc3_timer);
 	if (ip->rxr)
-		free_page((unsigned long)ip->rxr);
+		dma_direct_free_pages(ip->dma_dev, RX_RING_SIZE, ip->rxr,
+				      ip->rxr_dma, 0);
 	if (ip->txr)
-		free_pages((unsigned long)ip->txr, 2);
+		dma_direct_free_pages(ip->dma_dev, TX_RING_SIZE, ip->txr,
+				      ip->txr_dma, 0);
 out_res:
 	pci_release_regions(pdev);
 out_free:
@@ -1275,8 +1331,10 @@ static void ioc3_remove_one(struct pci_dev *pdev)
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct ioc3_private *ip = netdev_priv(dev);
 
-	free_page((unsigned long)ip->rxr);
-	free_pages((unsigned long)ip->txr, 2);
+	dma_direct_free_pages(ip->dma_dev, RX_RING_SIZE, ip->rxr,
+			      ip->rxr_dma, 0);
+	dma_direct_free_pages(ip->dma_dev, TX_RING_SIZE, ip->txr,
+			      ip->txr_dma, 0);
 
 	unregister_netdev(dev);
 	del_timer_sync(&ip->ioc3_timer);
@@ -1382,18 +1440,32 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		unsigned long b2 = (data | 0x3fffUL) + 1UL;
 		unsigned long s1 = b2 - data;
 		unsigned long s2 = data + len - b2;
+		dma_addr_t d1, d2;
 
 		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE |
 					   ETXD_B1V | ETXD_B2V | w0);
 		desc->bufcnt = cpu_to_be32((s1 << ETXD_B1CNT_SHIFT) |
 					   (s2 << ETXD_B2CNT_SHIFT));
-		desc->p1     = cpu_to_be64(ioc3_map(skb->data, 1));
-		desc->p2     = cpu_to_be64(ioc3_map((void *)b2, 1));
+		d1 = dma_map_single(ip->dma_dev, skb->data, s1, DMA_TO_DEVICE);
+		if (dma_mapping_error(ip->dma_dev, d1))
+			goto drop_packet;
+		d2 = dma_map_single(ip->dma_dev, (void *)b2, s1, DMA_TO_DEVICE);
+		if (dma_mapping_error(ip->dma_dev, d2)) {
+			dma_unmap_single(ip->dma_dev, d1, len, DMA_TO_DEVICE);
+			goto drop_packet;
+		}
+		desc->p1     = cpu_to_be64(ioc3_map(d1, PCI64_ATTR_PREF));
+		desc->p2     = cpu_to_be64(ioc3_map(d2, PCI64_ATTR_PREF));
 	} else {
+		dma_addr_t d;
+
 		/* Normal sized packet that doesn't cross a page boundary. */
 		desc->cmd = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_B1V | w0);
 		desc->bufcnt = cpu_to_be32(len << ETXD_B1CNT_SHIFT);
-		desc->p1     = cpu_to_be64(ioc3_map(skb->data, 1));
+		d = dma_map_single(ip->dma_dev, skb->data, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(ip->dma_dev, d))
+			goto drop_packet;
+		desc->p1     = cpu_to_be64(ioc3_map(d, PCI64_ATTR_PREF));
 	}
 
 	mb(); /* make sure all descriptor changes are visible */
@@ -1411,6 +1483,14 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_unlock_irq(&ip->ioc3_lock);
 
 	return NETDEV_TX_OK;
+
+drop_packet:
+	dev_kfree_skb_any(skb);
+	dev->stats.tx_dropped++;
+
+	spin_unlock_irq(&ip->ioc3_lock);
+
+	return NETDEV_TX_OK;
 }
 
 static void ioc3_timeout(struct net_device *dev)
-- 
2.13.7

