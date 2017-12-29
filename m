Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:37:39 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:43081 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994651AbdL2IWfG0jSC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:22:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KJOQbsTfxD50jTfv97HWTE0XO6nwI//cMRLyQOTPRUU=; b=K6a5zhsHEKaTy4n+T9NivKUkC
        R5TXmnG3nWqR4JIq/NNWV230zSzeYt7iyz9vJXZ6YdrUsv4xnixwaT+kasKG+K87UcHRccJoRuY3e
        nEgt7EiH0GuEWwkaTtPlU18c/KAjixXbGFeWHQzIPbV60SgFr8biXhXXQJLQNIwqpPeDmVZfcWbhc
        +2CLrqEiLBBSAB8MaUqBI7yIw2cRjfgEwee0vx42aqLI/CBtDVI5ENq/NbZSgB2tDelndkKYJDYix
        TSIq9jFZs2SKKtrSqBDvDSDSb3R3J95hjOxIFl/f1C5A31oJYt2rI81Uwdt0eeMpCZTZgCKJpDvqo
        ZsWM4gGrA==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpvk-0002rM-1d; Fri, 29 Dec 2017 08:22:16 +0000
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
Subject: [PATCH 41/67] x86: remove dma_alloc_coherent_gfp_flags
Date:   Fri, 29 Dec 2017 09:18:45 +0100
Message-Id: <20171229081911.2802-42-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61738
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

All dma_ops implementations used on x86 now take care of setting their own
required GFP_ masks for the allocation.  And given that the common code
now clears harmful flags itself that means we can stop the flags in all
the iommu implementations as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 11 -----------
 arch/x86/kernel/amd_gart_64.c      |  1 -
 arch/x86/kernel/pci-calgary_64.c   |  2 --
 arch/x86/kernel/pci-dma.c          |  2 --
 arch/x86/mm/mem_encrypt.c          |  7 -------
 drivers/iommu/amd_iommu.c          |  1 -
 drivers/iommu/intel-iommu.c        |  1 -
 7 files changed, 25 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index df9816b385eb..89ce4bfd241f 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -36,15 +36,4 @@ int arch_dma_supported(struct device *dev, u64 mask);
 bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
 #define arch_dma_alloc_attrs arch_dma_alloc_attrs
 
-static inline gfp_t dma_alloc_coherent_gfp_flags(struct device *dev, gfp_t gfp)
-{
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
-		gfp |= GFP_DMA;
-#ifdef CONFIG_X86_64
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
-		gfp |= GFP_DMA32;
-#endif
-       return gfp;
-}
-
 #endif
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 92054815023e..7466dd458e0f 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -487,7 +487,6 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 	if (!force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		return dma_direct_alloc(dev, size, dma_addr, flag, attrs);
 
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
 	page = alloc_pages(flag | __GFP_ZERO, get_order(size));
 	if (!page)
 		return NULL;
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 5647853053bd..bbfc8b1e9104 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -446,8 +446,6 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 	npages = size >> PAGE_SHIFT;
 	order = get_order(size);
 
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-
 	/* alloc enough pages (and possibly more) */
 	ret = (void *)__get_free_pages(flag, order);
 	if (!ret)
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index db0b88ea8d1b..14437116ffea 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -82,8 +82,6 @@ bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp)
 	if (!*dev)
 		*dev = &x86_dma_fallback_dev;
 
-	*gfp = dma_alloc_coherent_gfp_flags(*dev, *gfp);
-
 	if (!is_device_dma_capable(*dev))
 		return false;
 	return true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 479586b8ca9b..1c786e751b49 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -208,13 +208,6 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	void *vaddr = NULL;
 
 	order = get_order(size);
-
-	/*
-	 * Memory will be memset to zero after marking decrypted, so don't
-	 * bother clearing it before.
-	 */
-	gfp &= ~__GFP_ZERO;
-
 	page = alloc_pages_node(dev_to_node(dev), gfp, order);
 	if (page) {
 		dma_addr_t addr;
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a2ad149ab0bf..51ce6db86fdd 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2600,7 +2600,6 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	dma_dom   = to_dma_ops_domain(domain);
 	size	  = PAGE_ALIGN(size);
 	dma_mask  = dev->coherent_dma_mask;
-	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
 	flag     |= __GFP_ZERO;
 
 	page = alloc_pages(flag | __GFP_NOWARN,  get_order(size));
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0de8bfe89061..6c9df0773b78 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3718,7 +3718,6 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
-	flags &= ~(GFP_DMA | GFP_DMA32);
 
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
-- 
2.14.2
