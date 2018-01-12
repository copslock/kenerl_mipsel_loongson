Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 09:59:23 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:48735 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbeALIoXLz63J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:44:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=01FVK7YGZS5IcvQMFYjkZ5jWZV0wHvfX7e4F1MK9uDQ=; b=ZtXw8mo+vOawCG/q8X5Au9Gea
        voK5omW5JRWeJ+H38XC12VrfJhlAY8KSfiRQFTSH5a6/kQYixoJ+JIFAQhQ8Lfoh+XVLHe3rh+DSj
        duZmu0VuXrOmnlBP1GgCfjyx5bYl0K8hSJ+Ne8NT4TK+3D7MW1c5ukPNxtFcJiSJrYX9jF407OHDQ
        sZwqQEROm9EMdzdXJsSmUQfzOC+IgAfoSm9zdz+OI/AlEsqpgQ7Auy6ZDeT9uwzFKxlkLgPKnEB0e
        GcetGs79+Pm4WJF5KM51eDOk/RMx1EV+AzSzhDVlRx1CFqIQTcqSy08E02Xc9SIJMJG3bF0VdgHpU
        5wfiKphvQ==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuw2-00087Z-Ti; Fri, 12 Jan 2018 08:43:35 +0000
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
Subject: [PATCH 18/34] microblaze: remove the dead !NOT_COHERENT_CACHE dma code
Date:   Fri, 12 Jan 2018 09:42:16 +0100
Message-Id: <20180112084232.2857-19-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62080
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
index b45d8f8967af..c91e8cef98dd 100644
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
