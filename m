Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:41:47 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:48799 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994659AbdL2IXRx2kVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tNqLEm8pT0mbKh+Ndi8Tch49tf+ODOlpzHPx2fUwYcg=; b=dbfEtsLDdbptBDl3e8npMFWDf
        xoGYwDJqEjKyo0GjkPAIwzVdEbnfdByEfR1/Ar1c+RmJoOygjhAFmab6rZlGmFV3zf57JWQusDFLf
        2EuX3TzmaRu3NX3/8bkqkn5/OI/gHpBVlVVky1EaYure+ImcOKwHnbig469sC8uaq/TMAWo7z83Uc
        fpkcBBynRpt5WbNIgxdkRE0r+IT3/joAkIHy8Fhf1epH+EjVQHajJCxVMJfeCUjjLASoSzc61b1wb
        cZYesobVlUpc+NrUeoPDNNVNVNmcKM5r4TJw1tMI5axJ7F+6u/LnEF2z67hAimOBRGSLaVSjQv/jt
        ugPwWBZRQ==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpwM-0003IU-VO; Fri, 29 Dec 2017 08:22:55 +0000
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
Subject: [PATCH 50/67] swiotlb: refactor coherent buffer allocation
Date:   Fri, 29 Dec 2017 09:18:54 +0100
Message-Id: <20171229081911.2802-51-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61747
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

Factor out a new swiotlb_alloc_buffer helper that allocates DMA coherent
memory from the swiotlb bounce buffer.

This allows to simplify the swiotlb_alloc implemenation that uses
dma_direct_alloc to try to allocate a reachable buffer first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 100 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index adb4dd0091fa..905eea6353a3 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -709,67 +709,69 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 }
 EXPORT_SYMBOL_GPL(swiotlb_tbl_sync_single);
 
+static void *
+swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle)
+{
+	phys_addr_t phys_addr;
+
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		goto out_warn;
+
+	phys_addr = swiotlb_tbl_map_single(dev,
+			swiotlb_phys_to_dma(dev, io_tlb_start),
+			0, size, DMA_FROM_DEVICE, 0);
+	if (phys_addr == SWIOTLB_MAP_ERROR)
+		goto out_warn;
+
+	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
+
+	/* Confirm address can be DMA'd by device */
+	if (*dma_handle + size - 1 > dev->coherent_dma_mask)
+		goto out_unmap;
+
+	memset(phys_to_virt(phys_addr), 0, size);
+	return phys_to_virt(phys_addr);
+
+out_unmap:
+	dev_warn(dev, "hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
+		(unsigned long long)dev->coherent_dma_mask,
+		(unsigned long long)*dma_handle);
+
+	/*
+	 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
+	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
+	 */
+	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
+			DMA_ATTR_SKIP_CPU_SYNC);
+out_warn:
+	dev_warn(dev,
+		"swiotlb: coherent allocation failed, size=%zu\n", size);
+	dump_stack();
+	return NULL;
+}
+
 void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
 {
-	dma_addr_t dev_addr;
-	void *ret;
 	int order = get_order(size);
+	void *ret;
 
 	ret = (void *)__get_free_pages(flags, order);
 	if (ret) {
-		dev_addr = swiotlb_virt_to_bus(hwdev, ret);
-		if (dev_addr + size - 1 > hwdev->coherent_dma_mask) {
-			/*
-			 * The allocated memory isn't reachable by the device.
-			 */
-			free_pages((unsigned long) ret, order);
-			ret = NULL;
+		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
+		if (*dma_handle  + size - 1 <= hwdev->coherent_dma_mask) {
+			memset(ret, 0, size);
+			return ret;
 		}
-	}
-	if (!ret) {
+
 		/*
-		 * We are either out of memory or the device can't DMA to
-		 * GFP_DMA memory; fall back on map_single(), which
-		 * will grab memory from the lowest available address range.
+		 * The allocated memory isn't reachable by the device.
 		 */
-		phys_addr_t paddr = map_single(hwdev, 0, size,
-					       DMA_FROM_DEVICE, 0);
-		if (paddr == SWIOTLB_MAP_ERROR)
-			goto err_warn;
-
-		ret = phys_to_virt(paddr);
-		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
-
-		/* Confirm address can be DMA'd by device */
-		if (dev_addr + size - 1 > hwdev->coherent_dma_mask) {
-			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
-			       (unsigned long long)hwdev->coherent_dma_mask,
-			       (unsigned long long)dev_addr);
-
-			/*
-			 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
-			 * The DMA_ATTR_SKIP_CPU_SYNC is optional.
-			 */
-			swiotlb_tbl_unmap_single(hwdev, paddr,
-						 size, DMA_TO_DEVICE,
-						 DMA_ATTR_SKIP_CPU_SYNC);
-			goto err_warn;
-		}
+		free_pages((unsigned long) ret, order);
 	}
 
-	*dma_handle = dev_addr;
-	memset(ret, 0, size);
-
-	return ret;
-
-err_warn:
-	pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
-		dev_name(hwdev), size);
-	dump_stack();
-
-	return NULL;
+	return swiotlb_alloc_buffer(hwdev, size, dma_handle);
 }
 EXPORT_SYMBOL(swiotlb_alloc_coherent);
 
@@ -1105,7 +1107,7 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
 	if (!vaddr)
-		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle);
 	return vaddr;
 }
 
-- 
2.14.2
