Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:47:38 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:34365 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990487AbdJCKnxh3gh1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o5QzcMJEBuuSdz+qBEHhYvQ++IKhyZrEHlnaVsDY3xQ=; b=RSC9Qshpz7wLgzjYbYf2HQ1aM
        WCQZrJa6aeOZckuW24IRpZouwuKfjyW61Uwr2+V9DCmNrQF2JoEndwYos5ZRYtIAZ+zuqrJXKidn5
        XSAtcXme//n+QceX0evK4sOObKzFFsMTwX0+HY6ZxNdtLI/g1aOG3XzymxPPIxlo3sG+IOJovancD
        1o86OQzpLqbcYVC1vnoOCElWWJRPGNh29i8faf/uHay8yIqSTFeEWASvM1PjJ+eMLvPtZf94yJNeN
        QNU/D/Y9wUARsUK7Fjpq1SWEwTpITnarm9aVola8qjXSjv5BV0yHls1Pbt2G3skahpJa8yW0EEieG
        O1e1PbziQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKfz-0000UW-L4; Tue, 03 Oct 2017 10:43:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] sh: make dma_cache_sync a no-op
Date:   Tue,  3 Oct 2017 12:43:10 +0200
Message-Id: <20171003104311.10058-11-hch@lst.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60231
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

sh does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

On the other hand sh uses dma_cache_sync internally in the dma_ops
implementation and for the maple bus that does not use the DMA API,
so a the old functionality for dma_cache_sync is still provided under
the name sh_sync_dma_for_device, and without the redundant dev
argument.  While at it two of the syncing dma_ops also go the proper
_for_device postfix.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/dma-mapping.h |  9 +++++++--
 arch/sh/kernel/dma-nommu.c        | 17 +++++++++--------
 arch/sh/mm/consistent.c           |  6 +++---
 drivers/sh/maple/maple.c          |  5 ++---
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 9b06be07db4d..b46194ecef17 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -9,8 +9,10 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction dir);
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		    enum dma_data_direction dir)
+{
+}
 
 /* arch/sh/mm/consistent.c */
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
@@ -20,4 +22,7 @@ extern void dma_generic_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_handle,
 				      unsigned long attrs);
 
+void sh_sync_dma_for_device(void *vaddr, size_t size,
+	    enum dma_data_direction dir);
+
 #endif /* __ASM_SH_DMA_MAPPING_H */
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index d24c707b2181..62b485107eae 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -9,6 +9,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <asm/cacheflush.h>
 
 static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
@@ -20,7 +21,7 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	WARN_ON(size == 0);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_cache_sync(dev, page_address(page) + offset, size, dir);
+		sh_sync_dma_for_device(page_address(page) + offset, size, dir);
 
 	return addr;
 }
@@ -38,7 +39,7 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 		BUG_ON(!sg_page(s));
 
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			dma_cache_sync(dev, sg_virt(s), s->length, dir);
+			sh_sync_dma_for_device(sg_virt(s), s->length, dir);
 
 		s->dma_address = sg_phys(s);
 		s->dma_length = s->length;
@@ -48,20 +49,20 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 }
 
 #ifdef CONFIG_DMA_NONCOHERENT
-static void nommu_sync_single(struct device *dev, dma_addr_t addr,
+static void nommu_sync_single_for_device(struct device *dev, dma_addr_t addr,
 			      size_t size, enum dma_data_direction dir)
 {
-	dma_cache_sync(dev, phys_to_virt(addr), size, dir);
+	sh_sync_dma_for_device(phys_to_virt(addr), size, dir);
 }
 
-static void nommu_sync_sg(struct device *dev, struct scatterlist *sg,
+static void nommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 			  int nelems, enum dma_data_direction dir)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nelems, i)
-		dma_cache_sync(dev, sg_virt(s), s->length, dir);
+		sh_sync_dma_for_device(sg_virt(s), s->length, dir);
 }
 #endif
 
@@ -71,8 +72,8 @@ const struct dma_map_ops nommu_dma_ops = {
 	.map_page		= nommu_map_page,
 	.map_sg			= nommu_map_sg,
 #ifdef CONFIG_DMA_NONCOHERENT
-	.sync_single_for_device	= nommu_sync_single,
-	.sync_sg_for_device	= nommu_sync_sg,
+	.sync_single_for_device	= nommu_sync_single_for_device,
+	.sync_sg_for_device	= nommu_sync_sg_for_device,
 #endif
 	.is_phys		= 1,
 };
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index d1275adfa0ef..6ea3aab508f2 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -49,7 +49,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	 * Pages from the page allocator may have data present in
 	 * cache. So flush the cache before using uncached memory.
 	 */
-	dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);
+	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
 
 	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
 	if (!ret_nocache) {
@@ -78,7 +78,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 	iounmap(vaddr);
 }
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+void sh_sync_dma_for_device(void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
 	void *addr;
@@ -100,7 +100,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		BUG();
 	}
 }
-EXPORT_SYMBOL(dma_cache_sync);
+EXPORT_SYMBOL(sh_sync_dma_for_device);
 
 static int __init memchunk_setup(char *str)
 {
diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index bec81c2404f7..7525039d812c 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -300,7 +300,7 @@ static void maple_send(void)
 	mutex_unlock(&maple_wlist_lock);
 	if (maple_packets > 0) {
 		for (i = 0; i < (1 << MAPLE_DMA_PAGES); i++)
-			dma_cache_sync(0, maple_sendbuf + i * PAGE_SIZE,
+			sh_sync_dma_for_device(maple_sendbuf + i * PAGE_SIZE,
 				       PAGE_SIZE, DMA_BIDIRECTIONAL);
 	}
 
@@ -642,8 +642,7 @@ static void maple_dma_handler(struct work_struct *work)
 		list_for_each_entry_safe(mq, nmq, &maple_sentq, list) {
 			mdev = mq->dev;
 			recvbuf = mq->recvbuf->buf;
-			dma_cache_sync(&mdev->dev, recvbuf, 0x400,
-				DMA_FROM_DEVICE);
+			sh_sync_dma_for_device(recvbuf, 0x400, DMA_FROM_DEVICE);
 			code = recvbuf[0];
 			kfree(mq->sendbuf);
 			list_del_init(&mq->list);
-- 
2.14.1
