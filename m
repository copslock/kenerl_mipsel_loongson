Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:35:27 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:52153 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994634AbdL2IWPYeSCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:22:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DOmDyQ++Y5Y5WGvWNIPx/XVVonhzVqlJBFXWabs+3/g=; b=fbYzrhqAsnXJD3WTFuItQEePZ
        1JYdct179xw8BqtVCfTXNx1A/Mr8oLzTbtpDtFaAPJnPnDDV8v7upAEuIwFRXPE8gsWFN31DrbI8r
        5giAU1Rop6h1fDGvrhRBDhxDzXk14InbDovLUhBwrq2sO2gVR7aHMzrTUVc+LO8Qopf5HshmotLMd
        lgstA0woIy1IhWKc6sd5Z5yCMki5KbSEhGTQUmMZcYeL9VWyWRjsI/ZbXVFrVvxYQUu199knBXnn8
        8Nmz1SBoTEOySepj2EewO/LcrcYyY03h9j4OLhNJ0CeiuL3L0FmV8WUeskAoIlmxH8hTq7b7v52nI
        VlJ3qihkQ==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpvO-0002dp-Uf; Fri, 29 Dec 2017 08:21:55 +0000
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
Subject: [PATCH 36/67] x86: remove dma_alloc_coherent_mask
Date:   Fri, 29 Dec 2017 09:18:40 +0100
Message-Id: <20171229081911.2802-37-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61733
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

These days all devices (including the ISA fallback device) have a coherent
DMA mask set, so remove the workaround.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 18 ++----------------
 arch/x86/kernel/pci-dma.c          | 10 ++++------
 arch/x86/mm/mem_encrypt.c          |  4 +---
 drivers/xen/swiotlb-xen.c          | 16 +---------------
 4 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 6277c83c0eb1..545bf3721bc0 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -44,26 +44,12 @@ extern void dma_generic_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_addr,
 				      unsigned long attrs);
 
-static inline unsigned long dma_alloc_coherent_mask(struct device *dev,
-						    gfp_t gfp)
-{
-	unsigned long dma_mask = 0;
-
-	dma_mask = dev->coherent_dma_mask;
-	if (!dma_mask)
-		dma_mask = (gfp & GFP_DMA) ? DMA_BIT_MASK(24) : DMA_BIT_MASK(32);
-
-	return dma_mask;
-}
-
 static inline gfp_t dma_alloc_coherent_gfp_flags(struct device *dev, gfp_t gfp)
 {
-	unsigned long dma_mask = dma_alloc_coherent_mask(dev, gfp);
-
-	if (dma_mask <= DMA_BIT_MASK(24))
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		gfp |= GFP_DMA;
 #ifdef CONFIG_X86_64
-	if (dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
 		gfp |= GFP_DMA32;
 #endif
        return gfp;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index df7ab02f959f..b59820872ec7 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -80,13 +80,10 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t flag,
 				 unsigned long attrs)
 {
-	unsigned long dma_mask;
 	struct page *page;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	dma_addr_t addr;
 
-	dma_mask = dma_alloc_coherent_mask(dev, flag);
-
 again:
 	page = NULL;
 	/* CMA can be used only in the context which permits sleeping */
@@ -95,7 +92,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 						 flag);
 		if (page) {
 			addr = phys_to_dma(dev, page_to_phys(page));
-			if (addr + size > dma_mask) {
+			if (addr + size > dev->coherent_dma_mask) {
 				dma_release_from_contiguous(dev, page, count);
 				page = NULL;
 			}
@@ -108,10 +105,11 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 
 	addr = phys_to_dma(dev, page_to_phys(page));
-	if (addr + size > dma_mask) {
+	if (addr + size > dev->coherent_dma_mask) {
 		__free_pages(page, get_order(size));
 
-		if (dma_mask < DMA_BIT_MASK(32) && !(flag & GFP_DMA)) {
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    !(flag & GFP_DMA)) {
 			flag = (flag & ~GFP_DMA32) | GFP_DMA;
 			goto again;
 		}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 764b916ef7da..479586b8ca9b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -203,12 +203,10 @@ void __init sme_early_init(void)
 static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		       gfp_t gfp, unsigned long attrs)
 {
-	unsigned long dma_mask;
 	unsigned int order;
 	struct page *page;
 	void *vaddr = NULL;
 
-	dma_mask = dma_alloc_coherent_mask(dev, gfp);
 	order = get_order(size);
 
 	/*
@@ -226,7 +224,7 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		 * mask with it already cleared.
 		 */
 		addr = __sme_clr(phys_to_dma(dev, page_to_phys(page)));
-		if ((addr + size) > dma_mask) {
+		if ((addr + size) > dev->coherent_dma_mask) {
 			__free_pages(page, get_order(size));
 		} else {
 			vaddr = page_address(page);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5bb72d3f8337..e1c60899fdbc 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -53,20 +53,6 @@
  * API.
  */
 
-#ifndef CONFIG_X86
-static unsigned long dma_alloc_coherent_mask(struct device *dev,
-					    gfp_t gfp)
-{
-	unsigned long dma_mask = 0;
-
-	dma_mask = dev->coherent_dma_mask;
-	if (!dma_mask)
-		dma_mask = (gfp & GFP_DMA) ? DMA_BIT_MASK(24) : DMA_BIT_MASK(32);
-
-	return dma_mask;
-}
-#endif
-
 #define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
 
 static char *xen_io_tlb_start, *xen_io_tlb_end;
@@ -328,7 +314,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		return ret;
 
 	if (hwdev && hwdev->coherent_dma_mask)
-		dma_mask = dma_alloc_coherent_mask(hwdev, flags);
+		dma_mask = hwdev->coherent_dma_mask;
 
 	/* At this point dma_handle is the physical address, next we are
 	 * going to set it to the machine address.
-- 
2.14.2
