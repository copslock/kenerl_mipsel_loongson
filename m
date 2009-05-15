Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 16:23:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52251 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022700AbZEOPXf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 May 2009 16:23:35 +0100
Received: from localhost.localdomain (p3076-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0F036AC0D; Sat, 16 May 2009 00:23:30 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] txx9dmac: use dma_unmap_single if DMA_COMPL_{SRC,DEST}_UNMAP_SINGLE was set
Date:	Sat, 16 May 2009 00:23:30 +0900
Message-Id: <1242401010-17017-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch does not change actual behaviour since dma_unmap_page is just
an alias of dma_unmap_single on MIPS.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-mips.org linux-queue tree.
Please queue this or fold into "DMA: TXx9 Soc DMA Controller driver" patch.

 drivers/dma/txx9dmac.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 9aa9ea9..88dab52 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -432,23 +432,27 @@ txx9dmac_descriptor_complete(struct txx9dmac_chan *dc,
 	list_splice_init(&txd->tx_list, &dc->free_list);
 	list_move(&desc->desc_node, &dc->free_list);
 
-	/*
-	 * We use dma_unmap_page() regardless of how the buffers were
-	 * mapped before they were submitted...
-	 */
 	if (!ds) {
 		dma_addr_t dmaaddr;
 		if (!(txd->flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
 			dmaaddr = is_dmac64(dc) ?
 				desc->hwdesc.DAR : desc->hwdesc32.DAR;
-			dma_unmap_page(chan2parent(&dc->chan), dmaaddr,
-				       desc->len, DMA_FROM_DEVICE);
+			if (txd->flags & DMA_COMPL_DEST_UNMAP_SINGLE)
+				dma_unmap_single(chan2parent(&dc->chan),
+					dmaaddr, desc->len, DMA_FROM_DEVICE);
+			else
+				dma_unmap_page(chan2parent(&dc->chan),
+					dmaaddr, desc->len, DMA_FROM_DEVICE);
 		}
 		if (!(txd->flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
 			dmaaddr = is_dmac64(dc) ?
 				desc->hwdesc.SAR : desc->hwdesc32.SAR;
-			dma_unmap_page(chan2parent(&dc->chan), dmaaddr,
-				       desc->len, DMA_TO_DEVICE);
+			if (txd->flags & DMA_COMPL_SRC_UNMAP_SINGLE)
+				dma_unmap_single(chan2parent(&dc->chan),
+					dmaaddr, desc->len, DMA_TO_DEVICE);
+			else
+				dma_unmap_page(chan2parent(&dc->chan),
+					dmaaddr, desc->len, DMA_TO_DEVICE);
 		}
 	}
 
-- 
1.5.6.5
