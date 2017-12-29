Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:27:51 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:40898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdL2IUzi92EC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CIg3Tb/MIA3sbpgB82OZCeysJYra+xA3YC9awVKB9rs=; b=oTaqC+aSOJJ4QgeFbwZIWlG97
        yVtYiAIGzY93Vqsf9dxPPsuDNssS6JoF4RIt4kF5uYud+Pd1Qg6cDg7oZitfF3QuO1JRDLJ6MmKOp
        PL9uqK3HnANoMVaZrnsXPYBMaIT3jcO9L2eXnlNYfur8e8D0s5eQYGK0PVj1UsaJBGrVoxQoSINs5
        UaJ2VWz63xQW+Jg+hNQm7GySBcQHexsdRKL4VN7fbXS0w0FAL0iqhZhA2GFQQAiaXxJVI3o37dwlk
        HPEvF0ySq/jj6D35lEALpa1YLQi+b3NPV4rRmCdFDaFLsHUR3iSWVQOOcX/2+9u2dJzDkuYgu0tPC
        wjCMI8ccA==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpuD-00019U-J5; Fri, 29 Dec 2017 08:20:42 +0000
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
Subject: [PATCH 19/67] microblaze: remove the dead !NOT_COHERENT_CACHE dma code
Date:   Fri, 29 Dec 2017 09:18:23 +0100
Message-Id: <20171229081911.2802-20-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61716
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/kernel/dma.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 49b09648679b..031d889670f5 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -15,42 +15,18 @@
 #include <linux/bug.h>
 #include <asm/cacheflush.h>
 
-#define NOT_COHERENT_CACHE
-
 static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
 				       unsigned long attrs)
 {
-#ifdef NOT_COHERENT_CACHE
 	return consistent_alloc(flag, size, dma_handle);
-#else
-	void *ret;
-	struct page *page;
-	int node = dev_to_node(dev);
-
-	/* ignore region specifiers */
-	flag  &= ~(__GFP_HIGHMEM);
-
-	page = alloc_pages_node(node, flag, get_order(size));
-	if (page == NULL)
-		return NULL;
-	ret = page_address(page);
-	memset(ret, 0, size);
-	*dma_handle = virt_to_phys(ret);
-
-	return ret;
-#endif
 }
 
 static void dma_nommu_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
-#ifdef NOT_COHERENT_CACHE
 	consistent_free(size, vaddr);
-#else
-	free_pages((unsigned long)vaddr, get_order(size));
-#endif
 }
 
 static inline void __dma_sync(unsigned long paddr,
@@ -186,12 +162,8 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 	if (off >= count || user_count > (count - off))
 		return -ENXIO;
 
-#ifdef NOT_COHERENT_CACHE
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	pfn = consistent_virt_to_pfn(cpu_addr);
-#else
-	pfn = virt_to_pfn(cpu_addr);
-#endif
 	return remap_pfn_range(vma, vma->vm_start, pfn + off,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 #else
-- 
2.14.2
