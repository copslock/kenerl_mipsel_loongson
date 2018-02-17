Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:19:38 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:37754 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994664AbeBQUOgLK29G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:36 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:30 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:42 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 12/14] net: pch_gbe: Fix TX RX descriptor accesses for big endian systems
Date:   Sat, 17 Feb 2018 12:10:35 -0800
Message-ID: <20180217201037.3006-13-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898470-321458-308-63287-2
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

From: Hassan Naveed <hassan.naveed@mips.com>

Fix pch_gbe driver for ethernet operations for a big endian CPU.
Values written to and read from transmit and receive descriptors
in the pch_gbe driver are byte swapped from the perspective of a
big endian CPU, since the ethernet controller always operates in
little endian mode. Rectify this by appropriately byte swapping
these descriptor field values in the driver software.

Signed-off-by: Hassan Naveed <hassan.naveed@mips.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org

---

Changes in v5:
- Newly included in this series.

Changes in v4: None
Changes in v3: None
Changes in v2:
- Use __le{16,32} for field types, checked with sparse.

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    | 22 ++++----
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 66 ++++++++++++----------
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
index 8ba9ced2d1fd..7159e39b4685 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
@@ -431,13 +431,13 @@ struct pch_gbe_hw {
  * @reserved2:		Reserved
  */
 struct pch_gbe_rx_desc {
-	u32 buffer_addr;
-	u32 tcp_ip_status;
-	u16 rx_words_eob;
-	u16 gbec_status;
+	__le32 buffer_addr;
+	__le32 tcp_ip_status;
+	__le16 rx_words_eob;
+	__le16 gbec_status;
 	u8 dma_status;
 	u8 reserved1;
-	u16 reserved2;
+	__le16 reserved2;
 };
 
 /**
@@ -452,14 +452,14 @@ struct pch_gbe_rx_desc {
  * @gbec_status:	GMAC Status
  */
 struct pch_gbe_tx_desc {
-	u32 buffer_addr;
-	u16 length;
-	u16 reserved1;
-	u16 tx_words_eob;
-	u16 tx_frame_ctrl;
+	__le32 buffer_addr;
+	__le16 length;
+	__le16 reserved1;
+	__le16 tx_words_eob;
+	__le16 tx_frame_ctrl;
 	u8 dma_status;
 	u8 reserved2;
-	u16 gbec_status;
+	__le16 gbec_status;
 };
 
 
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 8e3ad7dcef0b..a0b8c8f4b4c9 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -1254,11 +1254,11 @@ static void pch_gbe_tx_queue(struct pch_gbe_adapter *adapter,
 
 	/*-- Set Tx descriptor --*/
 	tx_desc = PCH_GBE_TX_DESC(*tx_ring, ring_num);
-	tx_desc->buffer_addr = (buffer_info->dma);
-	tx_desc->length = (skb->len);
-	tx_desc->tx_words_eob = ((skb->len + 3));
-	tx_desc->tx_frame_ctrl = (frame_ctrl);
-	tx_desc->gbec_status = (DSC_INIT16);
+	tx_desc->buffer_addr = cpu_to_le32(buffer_info->dma);
+	tx_desc->length = cpu_to_le16(skb->len);
+	tx_desc->tx_words_eob = cpu_to_le16(skb->len + 3);
+	tx_desc->tx_frame_ctrl = cpu_to_le16(frame_ctrl);
+	tx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 
 	/* Ensure writes to descriptors complete before DMA begins */
 	mmiowb();
@@ -1447,8 +1447,8 @@ pch_gbe_alloc_rx_buffers(struct pch_gbe_adapter *adapter,
 		}
 		buffer_info->mapped = true;
 		rx_desc = PCH_GBE_RX_DESC(*rx_ring, i);
-		rx_desc->buffer_addr = (buffer_info->dma);
-		rx_desc->gbec_status = DSC_INIT16;
+		rx_desc->buffer_addr = cpu_to_le32(buffer_info->dma);
+		rx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 
 		netdev_dbg(netdev,
 			   "i = %d  buffer_info->dma = 0x08%llx  buffer_info->length = 0x%x\n",
@@ -1520,7 +1520,7 @@ static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
 		skb_reserve(skb, PCH_GBE_DMA_ALIGN);
 		buffer_info->skb = skb;
 		tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
-		tx_desc->gbec_status = (DSC_INIT16);
+		tx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 	}
 	return;
 }
@@ -1551,11 +1551,12 @@ pch_gbe_clean_tx(struct pch_gbe_adapter *adapter,
 	i = tx_ring->next_to_clean;
 	tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
 	netdev_dbg(adapter->netdev, "gbec_status:0x%04x  dma_status:0x%04x\n",
-		   tx_desc->gbec_status, tx_desc->dma_status);
+		   le16_to_cpu(tx_desc->gbec_status), tx_desc->dma_status);
 
 	unused = PCH_GBE_DESC_UNUSED(tx_ring);
 	thresh = tx_ring->count - PCH_GBE_TX_WEIGHT;
-	if ((tx_desc->gbec_status == DSC_INIT16) && (unused < thresh))
+	if ((le16_to_cpu(tx_desc->gbec_status) == DSC_INIT16) &&
+	    (unused < thresh))
 	{  /* current marked clean, tx queue filling up, do extra clean */
 		int j, k;
 		if (unused < 8) {  /* tx queue nearly full */
@@ -1570,47 +1571,49 @@ pch_gbe_clean_tx(struct pch_gbe_adapter *adapter,
 		for (j = 0; j < PCH_GBE_TX_WEIGHT; j++)
 		{
 			tx_desc = PCH_GBE_TX_DESC(*tx_ring, k);
-			if (tx_desc->gbec_status != DSC_INIT16) break; /*found*/
+			if (le16_to_cpu(tx_desc->gbec_status) != DSC_INIT16)
+				break; /*found*/
 			if (++k >= tx_ring->count) k = 0;  /*increment, wrap*/
 		}
 		if (j < PCH_GBE_TX_WEIGHT) {
 			netdev_dbg(adapter->netdev,
 				   "clean_tx: unused=%d loops=%d found tx_desc[%x,%x:%x].gbec_status=%04x\n",
 				   unused, j, i, k, tx_ring->next_to_use,
-				   tx_desc->gbec_status);
+				   le16_to_cpu(tx_desc->gbec_status));
 			i = k;  /*found one to clean, usu gbec_status==2000.*/
 		}
 	}
 
-	while ((tx_desc->gbec_status & DSC_INIT16) == 0x0000) {
+	while ((cpu_to_le16(tx_desc->gbec_status) & DSC_INIT16) == 0x0000) {
 		netdev_dbg(adapter->netdev, "gbec_status:0x%04x\n",
-			   tx_desc->gbec_status);
+			   le16_to_cpu(tx_desc->gbec_status));
 		buffer_info = &tx_ring->buffer_info[i];
 		skb = buffer_info->skb;
 		cleaned = true;
 
-		if ((tx_desc->gbec_status & PCH_GBE_TXD_GMAC_STAT_ABT)) {
+		if ((le16_to_cpu(tx_desc->gbec_status) &
+			PCH_GBE_TXD_GMAC_STAT_ABT)) {
 			adapter->stats.tx_aborted_errors++;
 			netdev_err(adapter->netdev, "Transfer Abort Error\n");
-		} else if ((tx_desc->gbec_status & PCH_GBE_TXD_GMAC_STAT_CRSER)
-			  ) {
+		} else if ((le16_to_cpu(tx_desc->gbec_status) &
+				PCH_GBE_TXD_GMAC_STAT_CRSER)) {
 			adapter->stats.tx_carrier_errors++;
 			netdev_err(adapter->netdev,
 				   "Transfer Carrier Sense Error\n");
-		} else if ((tx_desc->gbec_status & PCH_GBE_TXD_GMAC_STAT_EXCOL)
-			  ) {
+		} else if ((le16_to_cpu(tx_desc->gbec_status) &
+					PCH_GBE_TXD_GMAC_STAT_EXCOL)) {
 			adapter->stats.tx_aborted_errors++;
 			netdev_err(adapter->netdev,
 				   "Transfer Collision Abort Error\n");
-		} else if ((tx_desc->gbec_status &
+		} else if ((le16_to_cpu(tx_desc->gbec_status) &
 			    (PCH_GBE_TXD_GMAC_STAT_SNGCOL |
 			     PCH_GBE_TXD_GMAC_STAT_MLTCOL))) {
 			adapter->stats.collisions++;
 			adapter->stats.tx_packets++;
 			adapter->stats.tx_bytes += skb->len;
 			netdev_dbg(adapter->netdev, "Transfer Collision\n");
-		} else if ((tx_desc->gbec_status & PCH_GBE_TXD_GMAC_STAT_CMPLT)
-			  ) {
+		} else if ((le16_to_cpu(tx_desc->gbec_status) &
+				PCH_GBE_TXD_GMAC_STAT_CMPLT)) {
 			adapter->stats.tx_packets++;
 			adapter->stats.tx_bytes += skb->len;
 		}
@@ -1626,7 +1629,7 @@ pch_gbe_clean_tx(struct pch_gbe_adapter *adapter,
 				   "trim buffer_info->skb : %d\n", i);
 			skb_trim(buffer_info->skb, 0);
 		}
-		tx_desc->gbec_status = DSC_INIT16;
+		tx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 		if (unlikely(++i == tx_ring->count))
 			i = 0;
 		tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
@@ -1692,15 +1695,15 @@ pch_gbe_clean_rx(struct pch_gbe_adapter *adapter,
 	while (*work_done < work_to_do) {
 		/* Check Rx descriptor status */
 		rx_desc = PCH_GBE_RX_DESC(*rx_ring, i);
-		if (rx_desc->gbec_status == DSC_INIT16)
+		if (le16_to_cpu(rx_desc->gbec_status) == DSC_INIT16)
 			break;
 		cleaned = true;
 		cleaned_count++;
 
 		dma_status = rx_desc->dma_status;
-		gbec_status = rx_desc->gbec_status;
-		tcp_ip_status = rx_desc->tcp_ip_status;
-		rx_desc->gbec_status = DSC_INIT16;
+		gbec_status = le16_to_cpu(rx_desc->gbec_status);
+		tcp_ip_status = le32_to_cpu(rx_desc->tcp_ip_status);
+		rx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 		buffer_info = &rx_ring->buffer_info[i];
 		skb = buffer_info->skb;
 		buffer_info->skb = NULL;
@@ -1729,8 +1732,9 @@ pch_gbe_clean_rx(struct pch_gbe_adapter *adapter,
 		} else {
 			/* get receive length */
 			/* length convert[-3], length includes FCS length */
-			length = (rx_desc->rx_words_eob) - 3 - ETH_FCS_LEN;
-			if (rx_desc->rx_words_eob & 0x02)
+			length = le16_to_cpu(rx_desc->rx_words_eob) - 3 -
+					ETH_FCS_LEN;
+			if (le16_to_cpu(rx_desc->rx_words_eob) & 0x02)
 				length = length - 4;
 			/*
 			 * buffer_info->rx_buffer: [Header:14][payload]
@@ -1810,7 +1814,7 @@ int pch_gbe_setup_tx_resources(struct pch_gbe_adapter *adapter,
 
 	for (desNo = 0; desNo < tx_ring->count; desNo++) {
 		tx_desc = PCH_GBE_TX_DESC(*tx_ring, desNo);
-		tx_desc->gbec_status = DSC_INIT16;
+		tx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 	}
 	netdev_dbg(adapter->netdev,
 		   "tx_ring->desc = 0x%p  tx_ring->dma = 0x%08llx next_to_clean = 0x%08x  next_to_use = 0x%08x\n",
@@ -1851,7 +1855,7 @@ int pch_gbe_setup_rx_resources(struct pch_gbe_adapter *adapter,
 	rx_ring->next_to_use = 0;
 	for (desNo = 0; desNo < rx_ring->count; desNo++) {
 		rx_desc = PCH_GBE_RX_DESC(*rx_ring, desNo);
-		rx_desc->gbec_status = DSC_INIT16;
+		rx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
 	}
 	netdev_dbg(adapter->netdev,
 		   "rx_ring->desc = 0x%p  rx_ring->dma = 0x%08llx next_to_clean = 0x%08x  next_to_use = 0x%08x\n",
-- 
2.16.1
