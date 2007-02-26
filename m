Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2007 19:52:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15771 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28639682AbXBZTwR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Feb 2007 19:52:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1QJq7aV010320;
	Mon, 26 Feb 2007 19:52:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1QJq60N010319;
	Mon, 26 Feb 2007 19:52:06 GMT
Date:	Mon, 26 Feb 2007 19:52:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dale Farnsworth <dale@farnsworth.org>
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	Jeff Garzik <jeff@garzik.org>
Subject: [RFC][NET] Alignment in mv643xx_eth
Message-ID: <20070226195206.GA10188@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The driver contains this little piece of candy:

#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_NOT_COHERENT_CACHE)
#define ETH_DMA_ALIGN           L1_CACHE_BYTES
#else
#define ETH_DMA_ALIGN           8
#endif

Any reason why we're not using dma_get_cache_alignment() instead?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index d98e53e..3e045a6 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -147,13 +147,13 @@ static void mv643xx_eth_rx_refill_descs(struct net_device *dev)
 	int unaligned;
 
 	while (mp->rx_desc_count < mp->rx_ring_size) {
-		skb = dev_alloc_skb(ETH_RX_SKB_SIZE + ETH_DMA_ALIGN);
+		skb = dev_alloc_skb(ETH_RX_SKB_SIZE + dma_get_cache_alignment());
 		if (!skb)
 			break;
 		mp->rx_desc_count++;
-		unaligned = (u32)skb->data & (ETH_DMA_ALIGN - 1);
+		unaligned = (u32)skb->data & (dma_get_cache_alignment() - 1);
 		if (unaligned)
-			skb_reserve(skb, ETH_DMA_ALIGN - unaligned);
+			skb_reserve(skb, dma_get_cache_alignment() - unaligned);
 		pkt_info.cmd_sts = ETH_RX_ENABLE_INTERRUPT;
 		pkt_info.byte_cnt = ETH_RX_SKB_SIZE;
 		pkt_info.buf_ptr = dma_map_single(NULL, skb->data,
diff --git a/drivers/net/mv643xx_eth.h b/drivers/net/mv643xx_eth.h
index 33c5faf..7cb0a41 100644
--- a/drivers/net/mv643xx_eth.h
+++ b/drivers/net/mv643xx_eth.h
@@ -42,17 +42,6 @@
 #define MAX_DESCS_PER_SKB	1
 #endif
 
-/*
- * The MV643XX HW requires 8-byte alignment.  However, when I/O
- * is non-cache-coherent, we need to ensure that the I/O buffers
- * we use don't share cache lines with other data.
- */
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_NOT_COHERENT_CACHE)
-#define ETH_DMA_ALIGN		L1_CACHE_BYTES
-#else
-#define ETH_DMA_ALIGN		8
-#endif
-
 #define ETH_VLAN_HLEN		4
 #define ETH_FCS_LEN		4
 #define ETH_HW_IP_ALIGN		2		/* hw aligns IP header */
