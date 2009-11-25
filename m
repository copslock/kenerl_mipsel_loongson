Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 21:00:58 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:11617 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493432AbZKYUAc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 21:00:32 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAccDUurRN+K/2dsb2JhbAC+GZdrhDIEgXE
X-IronPort-AV: E=Sophos;i="4.47,288,1257120000"; 
   d="scan'208";a="109641201"
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-5.cisco.com with ESMTP; 25 Nov 2009 20:00:27 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id nAPK0RQQ023593;
        Wed, 25 Nov 2009 20:00:27 GMT
Date:   Wed, 25 Nov 2009 15:00:28 -0500
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 2/2] Set of fixes for DMA when dma_addr_t != physical
        address
Message-ID: <20091125200027.GA13748@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Fixes for using DMA on systems where the DMA address and the physical address
differ.

Signed-off-by: Dezhong Diao <dediao@cisco.com>
Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/mm/dma-default.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 414d7ff..eaa7fb4 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -24,8 +24,11 @@ static inline unsigned long dma_addr_to_virt(struct device *dev,
 	dma_addr_t dma_addr)
 {
 	unsigned long addr = plat_dma_addr_to_phys(dev, dma_addr);
+	unsigned int offset = (dma_addr & ~PAGE_MASK);
+	struct page *pg;
 
-	return (unsigned long)phys_to_virt(addr);
+	pg = pfn_to_page(addr >> PAGE_SHIFT);
+	return (unsigned long)(page_address(pg) + offset);
 }
 
 /*
@@ -136,7 +139,6 @@ EXPORT_SYMBOL(dma_free_coherent);
 static inline void __dma_sync(unsigned long addr, size_t size,
 	enum dma_data_direction direction)
 {
-
 	BUG_ON(addr < KSEG0);
 
 	switch (direction) {
@@ -197,8 +199,8 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		addr = (unsigned long) sg_virt(sg);
 		if (!plat_device_is_coherent(dev) && (addr >= KSEG0))
 			__dma_sync(addr, sg->length, direction);
-
-		sg->dma_address = sg_phys(sg);
+		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
+			sg->offset;
 	}
 
 	return nents;
@@ -253,7 +255,8 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		unsigned long addr;
 
 		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr, size, direction);
+		if (addr >= KSEG0)
+			__dma_sync(addr, size, direction);
 	}
 }
 
@@ -269,7 +272,8 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 		unsigned long addr;
 
 		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr, size, direction);
+		if (addr >= KSEG0)
+			__dma_sync(addr, size, direction);
 	}
 }
 
@@ -284,7 +288,8 @@ void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		unsigned long addr;
 
 		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr + offset, size, direction);
+		if (addr >= KSEG0)
+			__dma_sync(addr + offset, size, direction);
 	}
 }
 
@@ -300,7 +305,8 @@ void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 		unsigned long addr;
 
 		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr + offset, size, direction);
+		if (addr >= KSEG0)
+			__dma_sync(addr + offset, size, direction);
 	}
 }
 
