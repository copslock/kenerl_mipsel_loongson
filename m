Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:33:03 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:60121 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbdL2IVvJGRjC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=djhv6KYp/Unqg6wSNceOXXQHdgLyp14SBGLrM/1hUTE=; b=CSqQe7t2Nmei+/5TZmSmIJvx7
        w9EL3RqkKBPGoqNVHVFwjGNCgbrVL87VuNg89dvy8tbkXrudpk1kSnRXaJ8zQ3LC4K2ycRJJsQuzN
        Nb778/i7pEZbALh0HcGD8u2mEQ/czhhZcnFpwerBxNrmdoG7yXMgKrdkzKd+mcFipLzM2ATTkHOBd
        hO1HJRwgQ37cRuTqkN9Gw3JYxLnHMsACazJlGkNJrjB8OaQ5A8Cy94TLUjc8Dy24sTTgdM8r4Cof5
        wvY3jq4Kq/lWdcyHBycyQv0po1vj3OLALewDIUgVd0J115M46HPUGhEe0OA4RLM+8m+0pIJIz/0EE
        vluuH666A==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpv3-0002Ke-Po; Fri, 29 Dec 2017 08:21:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/67] dma-direct: make dma_direct_{alloc,free} available to other implementations
Date:   Fri, 29 Dec 2017 09:18:35 +0100
Message-Id: <20171229081911.2802-32-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61728
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

So that they don't need to indirect through the operation vector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c | 9 +++------
 include/linux/dma-direct.h      | 5 +++++
 lib/dma-direct.c                | 6 +++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 49e9831dc0f1..b4cf3e4e9d4a 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -11,7 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 
 #include <asm/cachetype.h>
@@ -39,7 +39,6 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 				 unsigned long attrs)
 
 {
-	const struct dma_map_ops *ops = &dma_direct_ops;
 	void *ret;
 
 	/*
@@ -48,7 +47,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 	 */
 
 	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		return ops->alloc(dev, size, dma_handle, gfp, attrs);
+		return dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
 
 	ret = dma_alloc_from_global_coherent(size, dma_handle);
 
@@ -70,10 +69,8 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr,
 			       unsigned long attrs)
 {
-	const struct dma_map_ops *ops = &dma_direct_ops;
-
 	if (attrs & DMA_ATTR_NON_CONSISTENT) {
-		ops->free(dev, size, cpu_addr, dma_addr, attrs);
+		dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
 	} else {
 		int ret = dma_release_from_global_coherent(get_order(size),
 							   cpu_addr);
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 10e924b7cba7..4788bf0bf683 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -38,4 +38,9 @@ static inline void dma_mark_clean(void *addr, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
 
+void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs);
+void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs);
+
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index f8467cb3d89a..7e913728e099 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -33,8 +33,8 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 	return phys_to_dma(dev, phys) + size <= dev->coherent_dma_mask;
 }
 
-static void *dma_direct_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int page_order = get_order(size);
@@ -71,7 +71,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	return page_address(page);
 }
 
-static void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
+void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-- 
2.14.2
