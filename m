Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 21:00:35 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:11617 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493427AbZKYUAb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 21:00:31 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAccDUurRN+J/2dsb2JhbAC+GZdrhDIEgXE
X-IronPort-AV: E=Sophos;i="4.47,288,1257120000"; 
   d="scan'208";a="109641173"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 25 Nov 2009 20:00:23 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nAPK0OKc010488;
        Wed, 25 Nov 2009 20:00:24 GMT
Date:   Wed, 25 Nov 2009 15:00:24 -0500
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 1/2] Set of fixes for DMA when dma_addr_t != physical
        address
Message-ID: <20091125200024.GA13307@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

From: Jon Fraser <jfraser@broadcom.com>
DMA changes from Jon Fraser, slightly tweaked for 2.6.30.

Signed-off-by: Jon Fraser <jfraser@broadcom.com>
Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/mm/dma-default.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 4fdb7f5..70cff1f 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -135,6 +135,9 @@ EXPORT_SYMBOL(dma_free_coherent);
 static inline void __dma_sync(unsigned long addr, size_t size,
 	enum dma_data_direction direction)
 {
+
+	BUG_ON(addr < KSEG0);
+
 	switch (direction) {
 	case DMA_TO_DEVICE:
 		dma_cache_wback(addr, size);
@@ -188,11 +191,13 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
 
+		BUG_ON(!sg_page(sg));
+
 		addr = (unsigned long) sg_virt(sg);
-		if (!plat_device_is_coherent(dev) && addr)
+		if (!plat_device_is_coherent(dev) && (addr >= KSEG0))
 			__dma_sync(addr, sg->length, direction);
-		sg->dma_address = plat_map_dma_mem(dev,
-				                   (void *)addr, sg->length);
+
+		sg->dma_address = sg_phys(sg);
 	}
 
 	return nents;
@@ -229,7 +234,7 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 		if (!plat_device_is_coherent(dev) &&
 		    direction != DMA_TO_DEVICE) {
 			addr = (unsigned long) sg_virt(sg);
-			if (addr)
+			if (addr >= KSEG0)
 				__dma_sync(addr, sg->length, direction);
 		}
 		plat_unmap_dma_mem(dev, sg->dma_address);
@@ -359,6 +364,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
+	BUG_ON(vaddr < (void *)KSEG0);
 
 	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev))
