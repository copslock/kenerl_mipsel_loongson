Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:39:31 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:52056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994658AbdL2IW535ioC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:22:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rvr1eqMlP4YV89qiiy1bcmkZ+vcF4wJzJ7SgqHnKFeI=; b=E+gturd8ipCiraLkskHpNz/Hz
        a2S3QxpGIlPpMRbdLmPcTfq313Hjqbg00M7sRvyaXp8go1aSNtVR2HQRXB0rt1v71lwt8zgefT3eV
        ZRZJarEnoqq6D9CJdwtV7hnzn5nJvNpyzbiXmTnkSvHA0IyfLwsqLps3PBsTEdBwJRLRSzqYo/0p1
        dMAuwngN/vJYNoVMevMO8nO+IyBOtq6iKbVtTXnKxy+UQeMoZ/auxCLt2jrb1zV0iO9U6kgk74kUD
        sLCiSN7KHgDpq32XPR32sIWCRFKIhTn4iEBpFxQcXTgAjaLhiWiHaPnTksRRXoroWo2LGMC3ajHNP
        VbNKCwPbA==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpw4-00035c-RR; Fri, 29 Dec 2017 08:22:37 +0000
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
Subject: [PATCH 46/67] swiotlb: lift x86 swiotlb_dma_ops to common code
Date:   Fri, 29 Dec 2017 09:18:50 +0100
Message-Id: <20171229081911.2802-47-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61742
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

Including the useful helpers for coherent allocations that first try the
full blown direct mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/swiotlb.h |  8 --------
 arch/x86/kernel/pci-swiotlb.c  | 45 ------------------------------------------
 arch/x86/pci/sta2x11-fixup.c   |  4 ++--
 include/linux/swiotlb.h        |  8 ++++++++
 lib/swiotlb.c                  | 43 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
index 1c6a6cb230ff..ff6c92eff035 100644
--- a/arch/x86/include/asm/swiotlb.h
+++ b/arch/x86/include/asm/swiotlb.h
@@ -27,12 +27,4 @@ static inline void pci_swiotlb_late_init(void)
 {
 }
 #endif
-
-extern void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flags,
-					unsigned long attrs);
-extern void x86_swiotlb_free_coherent(struct device *dev, size_t size,
-					void *vaddr, dma_addr_t dma_addr,
-					unsigned long attrs);
-
 #endif /* _ASM_X86_SWIOTLB_H */
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 57dea60c2473..661583662430 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -17,51 +17,6 @@
 
 int swiotlb __read_mostly;
 
-void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flags,
-					unsigned long attrs)
-{
-	void *vaddr;
-
-	/*
-	 * Don't print a warning when the first allocation attempt fails.
-	 * swiotlb_alloc_coherent() will print a warning when the DMA
-	 * memory allocation ultimately failed.
-	 */
-	flags |= __GFP_NOWARN;
-
-	vaddr = dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
-	if (vaddr)
-		return vaddr;
-
-	return swiotlb_alloc_coherent(hwdev, size, dma_handle, flags);
-}
-
-void x86_swiotlb_free_coherent(struct device *dev, size_t size,
-				      void *vaddr, dma_addr_t dma_addr,
-				      unsigned long attrs)
-{
-	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
-		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-	else
-		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
-}
-
-static const struct dma_map_ops swiotlb_dma_ops = {
-	.mapping_error = swiotlb_dma_mapping_error,
-	.alloc = x86_swiotlb_alloc_coherent,
-	.free = x86_swiotlb_free_coherent,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.dma_supported = NULL,
-};
-
 /*
  * pci_swiotlb_detect_override - set swiotlb to 1 if necessary
  *
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 6c712fe11bdc..4b69b008d5aa 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -175,7 +175,7 @@ static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
 {
 	void *vaddr;
 
-	vaddr = x86_swiotlb_alloc_coherent(dev, size, dma_handle, flags, attrs);
+	vaddr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
 	*dma_handle = p2a(*dma_handle, to_pci_dev(dev));
 	return vaddr;
 }
@@ -183,7 +183,7 @@ static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
 /* We have our own dma_ops: the same as swiotlb but from alloc (above) */
 static const struct dma_map_ops sta2x11_dma_ops = {
 	.alloc = sta2x11_swiotlb_alloc_coherent,
-	.free = x86_swiotlb_free_coherent,
+	.free = swiotlb_free,
 	.map_page = swiotlb_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.map_sg = swiotlb_map_sg_attrs,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 606375e35d87..5b1f2a00491c 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -66,6 +66,12 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 				    enum dma_sync_target target);
 
 /* Accessory functions. */
+
+void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
+		gfp_t flags, unsigned long attrs);
+void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs);
+
 extern void
 *swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			dma_addr_t *dma_handle, gfp_t flags);
@@ -126,4 +132,6 @@ extern void swiotlb_print_info(void);
 extern int is_swiotlb_buffer(phys_addr_t paddr);
 extern void swiotlb_set_max_segment(unsigned int);
 
+extern const struct dma_map_ops swiotlb_dma_ops;
+
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index c1fcd3a32d07..9c100f0173bf 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1084,3 +1084,46 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return swiotlb_phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 EXPORT_SYMBOL(swiotlb_dma_supported);
+
+#ifdef CONFIG_DMA_DIRECT_OPS
+void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
+{
+	void *vaddr;
+
+	/*
+	 * Don't print a warning when the first allocation attempt fails.
+	 * swiotlb_alloc_coherent() will print a warning when the DMA memory
+	 * allocation ultimately failed.
+	 */
+	gfp |= __GFP_NOWARN;
+
+	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	if (!vaddr)
+		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+	return vaddr;
+}
+
+void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
+{
+	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
+		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
+	else
+		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
+}
+
+const struct dma_map_ops swiotlb_dma_ops = {
+	.mapping_error		= swiotlb_dma_mapping_error,
+	.alloc			= swiotlb_alloc,
+	.free			= swiotlb_free,
+	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
+	.sync_single_for_device	= swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device	= swiotlb_sync_sg_for_device,
+	.map_sg			= swiotlb_map_sg_attrs,
+	.unmap_sg		= swiotlb_unmap_sg_attrs,
+	.map_page		= swiotlb_map_page,
+	.unmap_page		= swiotlb_unmap_page,
+};
+#endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.14.2
