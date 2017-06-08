Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:27:23 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:43295 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993919AbdFHN03KGJwT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:26:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xoP2LCqO7QfJ0Ziz0LwJ8pRAbwNJ/Jq/mNCumwHegNs=; b=SZ7kXXuugCkWghUBQ/PtAqdOs
        Znc17rilXgxyGhWnhEcz9Nogp6+yZsqRbEfQGOeF4pPb46a7cJjmriBcODfP5n7PjAHzUny4JJ8eM
        IlmM32k0Tsobh4AN8zchLDP8PskhIb7qNgBS+Cl//cdp45OO/zkBzbBlfbwZqn6b8aJoBBjPjG0Z3
        qpLzZqifJzsmchn6icW7ExCsYQca02VPMTgN5Fi+foaTsXaITMle9I6gZpiQPuUlMuQRXrmKIm1/U
        G/3lWFCpsd2+uAlX/oU4dEKcxDxmNR/QXHeTsfdh6xZMrTuUFOWLVY4YYkXWWAyn34OptuH52sOmI
        kAZDsLAEg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxSB-0004qr-Mk; Thu, 08 Jun 2017 13:26:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/44] ibmveth: properly unwind on init errors
Date:   Thu,  8 Jun 2017 15:25:27 +0200
Message-Id: <20170608132609.32662-3-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

That way the driver doesn't have to rely on DMA_ERROR_CODE, which
is not a public API and going away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/ibm/ibmveth.c | 159 +++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 72ab7b6bf20b..3ac27f59e595 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -467,56 +467,6 @@ static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter)
 	}
 }
 
-static void ibmveth_cleanup(struct ibmveth_adapter *adapter)
-{
-	int i;
-	struct device *dev = &adapter->vdev->dev;
-
-	if (adapter->buffer_list_addr != NULL) {
-		if (!dma_mapping_error(dev, adapter->buffer_list_dma)) {
-			dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
-					DMA_BIDIRECTIONAL);
-			adapter->buffer_list_dma = DMA_ERROR_CODE;
-		}
-		free_page((unsigned long)adapter->buffer_list_addr);
-		adapter->buffer_list_addr = NULL;
-	}
-
-	if (adapter->filter_list_addr != NULL) {
-		if (!dma_mapping_error(dev, adapter->filter_list_dma)) {
-			dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-					DMA_BIDIRECTIONAL);
-			adapter->filter_list_dma = DMA_ERROR_CODE;
-		}
-		free_page((unsigned long)adapter->filter_list_addr);
-		adapter->filter_list_addr = NULL;
-	}
-
-	if (adapter->rx_queue.queue_addr != NULL) {
-		dma_free_coherent(dev, adapter->rx_queue.queue_len,
-				  adapter->rx_queue.queue_addr,
-				  adapter->rx_queue.queue_dma);
-		adapter->rx_queue.queue_addr = NULL;
-	}
-
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[i]);
-
-	if (adapter->bounce_buffer != NULL) {
-		if (!dma_mapping_error(dev, adapter->bounce_buffer_dma)) {
-			dma_unmap_single(&adapter->vdev->dev,
-					adapter->bounce_buffer_dma,
-					adapter->netdev->mtu + IBMVETH_BUFF_OH,
-					DMA_BIDIRECTIONAL);
-			adapter->bounce_buffer_dma = DMA_ERROR_CODE;
-		}
-		kfree(adapter->bounce_buffer);
-		adapter->bounce_buffer = NULL;
-	}
-}
-
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
         union ibmveth_buf_desc rxq_desc, u64 mac_address)
 {
@@ -573,14 +523,17 @@ static int ibmveth_open(struct net_device *netdev)
 	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[i].size;
 
+	rc = -ENOMEM;
 	adapter->buffer_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
-	adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!adapter->buffer_list_addr) {
+		netdev_err(netdev, "unable to allocate list pages\n");
+		goto out;
+	}
 
-	if (!adapter->buffer_list_addr || !adapter->filter_list_addr) {
-		netdev_err(netdev, "unable to allocate filter or buffer list "
-			   "pages\n");
-		rc = -ENOMEM;
-		goto err_out;
+	adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!adapter->filter_list_addr) {
+		netdev_err(netdev, "unable to allocate filter pages\n");
+		goto out_free_buffer_list;
 	}
 
 	dev = &adapter->vdev->dev;
@@ -590,22 +543,21 @@ static int ibmveth_open(struct net_device *netdev)
 	adapter->rx_queue.queue_addr =
 		dma_alloc_coherent(dev, adapter->rx_queue.queue_len,
 				   &adapter->rx_queue.queue_dma, GFP_KERNEL);
-	if (!adapter->rx_queue.queue_addr) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
+	if (!adapter->rx_queue.queue_addr)
+		goto out_free_filter_list;
 
 	adapter->buffer_list_dma = dma_map_single(dev,
 			adapter->buffer_list_addr, 4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma)) {
+		netdev_err(netdev, "unable to map buffer list pages\n");
+		goto out_free_queue_mem;
+	}
+
 	adapter->filter_list_dma = dma_map_single(dev,
 			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
-
-	if ((dma_mapping_error(dev, adapter->buffer_list_dma)) ||
-	    (dma_mapping_error(dev, adapter->filter_list_dma))) {
-		netdev_err(netdev, "unable to map filter or buffer list "
-			   "pages\n");
-		rc = -ENOMEM;
-		goto err_out;
+	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
+		netdev_err(netdev, "unable to map filter list pages\n");
+		goto out_unmap_buffer_list;
 	}
 
 	adapter->rx_queue.index = 0;
@@ -636,7 +588,7 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto err_out;
+		goto out_unmap_filter_list;
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
@@ -646,7 +598,7 @@ static int ibmveth_open(struct net_device *netdev)
 			netdev_err(netdev, "unable to alloc pool\n");
 			adapter->rx_buff_pool[i].active = 0;
 			rc = -ENOMEM;
-			goto err_out;
+			goto out_free_buffer_pools;
 		}
 	}
 
@@ -660,22 +612,21 @@ static int ibmveth_open(struct net_device *netdev)
 			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 
-		goto err_out;
+		goto out_free_buffer_pools;
 	}
 
+	rc = -ENOMEM;
 	adapter->bounce_buffer =
 	    kmalloc(netdev->mtu + IBMVETH_BUFF_OH, GFP_KERNEL);
-	if (!adapter->bounce_buffer) {
-		rc = -ENOMEM;
-		goto err_out_free_irq;
-	}
+	if (!adapter->bounce_buffer)
+		goto out_free_irq;
+
 	adapter->bounce_buffer_dma =
 	    dma_map_single(&adapter->vdev->dev, adapter->bounce_buffer,
 			   netdev->mtu + IBMVETH_BUFF_OH, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dev, adapter->bounce_buffer_dma)) {
 		netdev_err(netdev, "unable to map bounce buffer\n");
-		rc = -ENOMEM;
-		goto err_out_free_irq;
+		goto out_free_bounce_buffer;
 	}
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
@@ -687,10 +638,31 @@ static int ibmveth_open(struct net_device *netdev)
 
 	return 0;
 
-err_out_free_irq:
+out_free_bounce_buffer:
+	kfree(adapter->bounce_buffer);
+out_free_irq:
 	free_irq(netdev->irq, netdev);
-err_out:
-	ibmveth_cleanup(adapter);
+out_free_buffer_pools:
+	while (--i >= 0) {
+		if (adapter->rx_buff_pool[i].active)
+			ibmveth_free_buffer_pool(adapter,
+						 &adapter->rx_buff_pool[i]);
+	}
+out_unmap_filter_list:
+	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
+			 DMA_BIDIRECTIONAL);
+out_unmap_buffer_list:
+	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
+			 DMA_BIDIRECTIONAL);
+out_free_queue_mem:
+	dma_free_coherent(dev, adapter->rx_queue.queue_len,
+			  adapter->rx_queue.queue_addr,
+			  adapter->rx_queue.queue_dma);
+out_free_filter_list:
+	free_page((unsigned long)adapter->filter_list_addr);
+out_free_buffer_list:
+	free_page((unsigned long)adapter->buffer_list_addr);
+out:
 	napi_disable(&adapter->napi);
 	return rc;
 }
@@ -698,7 +670,9 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	struct device *dev = &adapter->vdev->dev;
 	long lpar_rc;
+	int i;
 
 	netdev_dbg(netdev, "close starting\n");
 
@@ -722,7 +696,27 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
-	ibmveth_cleanup(adapter);
+	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
+			 DMA_BIDIRECTIONAL);
+	free_page((unsigned long)adapter->buffer_list_addr);
+
+	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
+			 DMA_BIDIRECTIONAL);
+	free_page((unsigned long)adapter->filter_list_addr);
+
+	dma_free_coherent(dev, adapter->rx_queue.queue_len,
+			  adapter->rx_queue.queue_addr,
+			  adapter->rx_queue.queue_dma);
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		if (adapter->rx_buff_pool[i].active)
+			ibmveth_free_buffer_pool(adapter,
+						 &adapter->rx_buff_pool[i]);
+
+	dma_unmap_single(&adapter->vdev->dev, adapter->bounce_buffer_dma,
+			 adapter->netdev->mtu + IBMVETH_BUFF_OH,
+			 DMA_BIDIRECTIONAL);
+	kfree(adapter->bounce_buffer);
 
 	netdev_dbg(netdev, "close complete\n");
 
@@ -1648,11 +1642,6 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	}
 
 	netdev_dbg(netdev, "adapter @ 0x%p\n", adapter);
-
-	adapter->buffer_list_dma = DMA_ERROR_CODE;
-	adapter->filter_list_dma = DMA_ERROR_CODE;
-	adapter->rx_queue.queue_dma = DMA_ERROR_CODE;
-
 	netdev_dbg(netdev, "registering netdev...\n");
 
 	ibmveth_set_features(netdev, netdev->features);
-- 
2.11.0
