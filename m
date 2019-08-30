Return-Path: <SRS0=WyAB=W2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5435EC3A5A4
	for <linux-mips@archiver.kernel.org>; Fri, 30 Aug 2019 09:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0DB21726
	for <linux-mips@archiver.kernel.org>; Fri, 30 Aug 2019 09:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfH3J07 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:26:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728146AbfH3JZ4 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 30 Aug 2019 05:25:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B9D6AF30;
        Fri, 30 Aug 2019 09:25:54 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 net-next 05/15] net: sgi: ioc3-eth: allocate space for desc rings only once
Date:   Fri, 30 Aug 2019 11:25:28 +0200
Message-Id: <20190830092539.24550-6-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190830092539.24550-1-tbogendoerfer@suse.de>
References: <20190830092539.24550-1-tbogendoerfer@suse.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Memory for descriptor rings are allocated/freed, when interface is
brought up/down. Since the size of the rings is not changeable by
hardware, we now allocate rings now during probe and free it, when
device is removed.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 105 ++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index ba18a53fbbe6..e84239734338 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -800,28 +800,17 @@ static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 
 static void ioc3_free_rings(struct ioc3_private *ip)
 {
-	struct sk_buff *skb;
 	int rx_entry, n_entry;
 
-	if (ip->txr) {
-		ioc3_clean_tx_ring(ip);
-		free_pages((unsigned long)ip->txr, 2);
-		ip->txr = NULL;
-	}
+	ioc3_clean_tx_ring(ip);
 
-	if (ip->rxr) {
-		n_entry = ip->rx_ci;
-		rx_entry = ip->rx_pi;
+	n_entry = ip->rx_ci;
+	rx_entry = ip->rx_pi;
 
-		while (n_entry != rx_entry) {
-			skb = ip->rx_skbs[n_entry];
-			if (skb)
-				dev_kfree_skb_any(skb);
+	while (n_entry != rx_entry) {
+		dev_kfree_skb_any(ip->rx_skbs[n_entry]);
 
-			n_entry = (n_entry + 1) & RX_RING_MASK;
-		}
-		free_page((unsigned long)ip->rxr);
-		ip->rxr = NULL;
+		n_entry = (n_entry + 1) & RX_RING_MASK;
 	}
 }
 
@@ -829,49 +818,34 @@ static void ioc3_alloc_rings(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 	struct ioc3_erxbuf *rxb;
-	unsigned long *rxr;
 	int i;
 
-	if (!ip->rxr) {
-		/* Allocate and initialize rx ring.  4kb = 512 entries  */
-		ip->rxr = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
-		rxr = ip->rxr;
-		if (!rxr)
-			pr_err("%s: get_zeroed_page() failed!\n", __func__);
-
-		/* Now the rx buffers.  The RX ring may be larger but
-		 * we only allocate 16 buffers for now.  Need to tune
-		 * this for performance and memory later.
-		 */
-		for (i = 0; i < RX_BUFFS; i++) {
-			struct sk_buff *skb;
+	/* Now the rx buffers.  The RX ring may be larger but
+	 * we only allocate 16 buffers for now.  Need to tune
+	 * this for performance and memory later.
+	 */
+	for (i = 0; i < RX_BUFFS; i++) {
+		struct sk_buff *skb;
 
-			skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
-			if (!skb) {
-				show_free_areas(0, NULL);
-				continue;
-			}
+		skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
+		if (!skb) {
+			show_free_areas(0, NULL);
+			continue;
+		}
 
-			ip->rx_skbs[i] = skb;
+		ip->rx_skbs[i] = skb;
 
-			/* Because we reserve afterwards. */
-			skb_put(skb, (1664 + RX_OFFSET));
-			rxb = (struct ioc3_erxbuf *)skb->data;
-			rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
-			skb_reserve(skb, RX_OFFSET);
-		}
-		ip->rx_ci = 0;
-		ip->rx_pi = RX_BUFFS;
+		/* Because we reserve afterwards. */
+		skb_put(skb, (1664 + RX_OFFSET));
+		rxb = (struct ioc3_erxbuf *)skb->data;
+		ip->rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
+		skb_reserve(skb, RX_OFFSET);
 	}
+	ip->rx_ci = 0;
+	ip->rx_pi = RX_BUFFS;
 
-	if (!ip->txr) {
-		/* Allocate and initialize tx rings.  16kb = 128 bufs.  */
-		ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
-		if (!ip->txr)
-			pr_err("%s: __get_free_pages() failed!\n", __func__);
-		ip->tx_pi = 0;
-		ip->tx_ci = 0;
-	}
+	ip->tx_pi = 0;
+	ip->tx_ci = 0;
 }
 
 static void ioc3_init_rings(struct net_device *dev)
@@ -1239,6 +1213,23 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
 
 	ioc3_stop(ip);
+
+	/* Allocate rx ring.  4kb = 512 entries, must be 4kb aligned */
+	ip->rxr = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+	if (!ip->rxr) {
+		pr_err("ioc3-eth: rx ring allocation failed\n");
+		err = -ENOMEM;
+		goto out_stop;
+	}
+
+	/* Allocate tx rings.  16kb = 128 bufs, must be 16kb aligned  */
+	ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
+	if (!ip->txr) {
+		pr_err("ioc3-eth: tx ring allocation failed\n");
+		err = -ENOMEM;
+		goto out_stop;
+	}
+
 	ioc3_init(dev);
 
 	ip->pdev = pdev;
@@ -1293,6 +1284,11 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ioc3_stop(ip);
 	del_timer_sync(&ip->ioc3_timer);
 	ioc3_free_rings(ip);
+	if (ip->rxr)
+		free_page((unsigned long)ip->rxr);
+	if (ip->txr)
+		free_pages((unsigned long)ip->txr, 2);
+	kfree(ip->txr);
 out_res:
 	pci_release_regions(pdev);
 out_free:
@@ -1310,6 +1306,9 @@ static void ioc3_remove_one(struct pci_dev *pdev)
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct ioc3_private *ip = netdev_priv(dev);
 
+	free_page((unsigned long)ip->rxr);
+	free_pages((unsigned long)ip->txr, 2);
+
 	unregister_netdev(dev);
 	del_timer_sync(&ip->ioc3_timer);
 
-- 
2.13.7

