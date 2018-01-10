Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:10:49 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:40988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbeAJIBypL5qS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:01:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CX1zuxJARuw9pJjSQKZbBPexsVAZhsP7gC/aAs5WFL8=; b=ok34micRRuZ2v46DA5l98zY1c
        VFYKnCQ5Rui2yQdMeOjRlUAq6BvwS2PLPFiTyuPpYs0wF5+XVhyFbL2G9IjdJD7OMQLXdwIVF05wu
        4nE7alAAA7+xl4/f7ySeOpWyoAaNvCDcJkZyxLA0voXWD/CnuqOgDv5ON6cB2bKbhi+hXhzS2gzdp
        nigOYlSsgVISnmkHjc0rlunw0B11Jjh6fA78uh3loeHtpVLm/OO6FVcp8lDkQ8o5+5bCspTcqMOTL
        lnGGSx3q6txnVVOEjO0ZOfjHCzm8l1LtNWVC/BP8/+jFvX/3xSxecXKl82Rd5n8v8/0gJIg+TGb7x
        ocrr/pFCw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBKR-0005Kg-0y; Wed, 10 Jan 2018 08:01:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/33] dma-direct: use phys_to_dma
Date:   Wed, 10 Jan 2018 09:00:18 +0100
Message-Id: <20180110080027.13879-25-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61989
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

This means it uses whatever linear remapping scheme that the architecture
provides is used in the generic dma_direct ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 lib/dma-direct.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 0ec3262a3148..12ea9653781b 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	lib/dma-noop.c
- *
- * DMA operations that map to physical addresses without flushing memory.
+ * DMA operations that map physical memory directly without using an IOMMU or
+ * flushing caches.
  */
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
 
@@ -17,7 +16,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 	if (ret)
-		*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
+		*dma_handle = phys_to_dma(dev, virt_to_phys(ret));
 
 	return ret;
 }
@@ -32,7 +31,7 @@ static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
+	return phys_to_dma(dev, page_to_phys(page)) + offset;
 }
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
@@ -42,12 +41,9 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 
 	for_each_sg(sgl, sg, nents, i) {
-		dma_addr_t offset = PFN_PHYS(dev->dma_pfn_offset);
-		void *va;
-
 		BUG_ON(!sg_page(sg));
-		va = sg_virt(sg);
-		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va) - offset;
+
+		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.14.2
