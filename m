Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:43:39 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:47919 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994670AbdL2IXeAGQnT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A0kfiSMeqvEnCbWIrVFOWN+hMDNGIZs6YHa3GV4n6ME=; b=reycdxmsrvl9S2hLFWvFHC2xg
        n0duzSFmSvBqMrZgRltZhOZuznN8QZmoORSIGRIYi2Y5lMRwZUjxMJyfWnkm83wKResPJkKb5t5zY
        JorYbOB6FiUbUWfo/rjtEPh7RmtP0qqwEZOIy1BEimEU9k3vVCXDp1o0/ar5ZfgcoVNhJn4CaCYVj
        wS35IN4WolH2uBjTCk4s5Z5p8G29efhe3hKTvK2mZH4tpUzeFdUuqE/p5W31zE25BzLkxH6oya4t9
        cEC7j/FfLPd4x5PTL+jYGEMpSnz494OKyMPRzP7fKG6KQehIkQgNZYgJJ+iJgGRHIRvq9LGFRMWzq
        tfTsMrisA==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpwf-0003Ur-5D; Fri, 29 Dec 2017 08:23:13 +0000
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
Subject: [PATCH 54/67] x86: remove sta2x11_dma_ops
Date:   Fri, 29 Dec 2017 09:18:58 +0100
Message-Id: <20171229081911.2802-55-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61751
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

Both the swiotlb and the dma-direct code already call into phys_to_dma
to translate the DMA address.  So the sta2x11 into phys_to_dma and
dma_to_phys are enough to handle this "special" device, and we can use
the plain old swiotlb ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/device.h |  3 +++
 arch/x86/pci/sta2x11-fixup.c  | 46 +++++--------------------------------------
 2 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index 5e12c63b47aa..812bd6c5d602 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -6,6 +6,9 @@ struct dev_archdata {
 #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
 	void *iommu; /* hook for IOMMU specific extension */
 #endif
+#ifdef CONFIG_STA2X11
+	bool is_sta2x11 : 1;
+#endif
 };
 
 #if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 15ad3025e439..7a5bafb76d77 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -159,43 +159,6 @@ static dma_addr_t a2p(dma_addr_t a, struct pci_dev *pdev)
 	return p;
 }
 
-/**
- * sta2x11_swiotlb_alloc_coherent - Allocate swiotlb bounce buffers
- *     returns virtual address. This is the only "special" function here.
- * @dev: PCI device
- * @size: Size of the buffer
- * @dma_handle: DMA address
- * @flags: memory flags
- */
-static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
-					    size_t size,
-					    dma_addr_t *dma_handle,
-					    gfp_t flags,
-					    unsigned long attrs)
-{
-	void *vaddr;
-
-	vaddr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
-	*dma_handle = p2a(*dma_handle, to_pci_dev(dev));
-	return vaddr;
-}
-
-/* We have our own dma_ops: the same as swiotlb but from alloc (above) */
-static const struct dma_map_ops sta2x11_dma_ops = {
-	.alloc = sta2x11_swiotlb_alloc_coherent,
-	.free = swiotlb_free,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = dma_direct_supported,
-};
-
 /* At setup time, we use our own ops if the device is a ConneXt one */
 static void sta2x11_setup_pdev(struct pci_dev *pdev)
 {
@@ -205,7 +168,8 @@ static void sta2x11_setup_pdev(struct pci_dev *pdev)
 		return;
 	pci_set_consistent_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
 	pci_set_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
-	pdev->dev.dma_ops = &sta2x11_dma_ops;
+	pdev->dev.dma_ops = &swiotlb_dma_ops;
+	pdev->dev.archdata.is_sta2x11 = true;
 
 	/* We must enable all devices as master, for audio DMA to work */
 	pci_set_master(pdev);
@@ -225,7 +189,7 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	struct sta2x11_mapping *map;
 
-	if (dev->dma_ops != &sta2x11_dma_ops) {
+	if (!dev->archdata.is_sta2x11) {
 		if (!dev->dma_mask)
 			return false;
 		return addr + size - 1 <= *dev->dma_mask;
@@ -249,7 +213,7 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
  */
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	if (dev->dma_ops != &sta2x11_dma_ops)
+	if (!dev->archdata.is_sta2x11)
 		return paddr;
 	return p2a(paddr, to_pci_dev(dev));
 }
@@ -261,7 +225,7 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
  */
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	if (dev->dma_ops != &sta2x11_dma_ops)
+	if (!dev->archdata.is_sta2x11)
 		return daddr;
 	return a2p(daddr, to_pci_dev(dev));
 }
-- 
2.14.2
