Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:41:23 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:54002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994663AbdL2IXJ3fpdJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p3vgCQXrDnda2/WFmLsq0tbPPXmf96G94BW/MOzrLv0=; b=I8XiC3DCfFX4+km8rB+g26wHe
        52A70U7Nuw+FUx28Ys2XJasOtPGXnQJftYaUM1FDZOyBNsSHniee76VQeLjDijfHdhqMwC3xSdeg5
        SeN4UjX2oSWWTagCDv99GINGoJHf+xprTBklKB9Elnwn3AfdxqiYYelB/q87rO5Wtf+jT73KodPWo
        PJnV757w4tM9JLcVd3IATUGhLK4djTZLTRECDWUzRKu1pH95nLk6k+kLOCvHlVcC/BRm+sACtIcT+
        85ifwp+jxo9zF1VCsAe7Mllh40LEr6ud/kvJ4mHCjFMIrbLjIxNTe59HtbIAaDeMAoOwnsRtejVm2
        fBHqcQphw==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpwI-0003F3-G7; Fri, 29 Dec 2017 08:22:51 +0000
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
Subject: [PATCH 49/67] swiotlb: refactor coherent buffer freeing
Date:   Fri, 29 Dec 2017 09:18:53 +0100
Message-Id: <20171229081911.2802-50-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61746
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

Factor out a new swiotlb_free_buffer helper that checks if an address
is allocated from the swiotlb bounce buffer, and if yes frees it.

This allows to simplify the swiotlb_free implemenation that uses
dma_direct_free to free the non-bounce buffer allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index a14fff30ee9d..adb4dd0091fa 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -773,22 +773,31 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 }
 EXPORT_SYMBOL(swiotlb_alloc_coherent);
 
+static bool swiotlb_free_buffer(struct device *dev, size_t size,
+		dma_addr_t dma_addr)
+{
+	phys_addr_t phys_addr = dma_to_phys(dev, dma_addr);
+
+	WARN_ON_ONCE(irqs_disabled());
+
+	if (!is_swiotlb_buffer(phys_addr))
+		return false;
+
+	/*
+	 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
+	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
+	 */
+	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
+				 DMA_ATTR_SKIP_CPU_SYNC);
+	return true;
+}
+
 void
 swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 		      dma_addr_t dev_addr)
 {
-	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
-
-	WARN_ON(irqs_disabled());
-	if (!is_swiotlb_buffer(paddr))
+	if (!swiotlb_free_buffer(hwdev, size, dev_addr))
 		free_pages((unsigned long)vaddr, get_order(size));
-	else
-		/*
-		 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
-		 * DMA_ATTR_SKIP_CPU_SYNC is optional.
-		 */
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, DMA_TO_DEVICE,
-					 DMA_ATTR_SKIP_CPU_SYNC);
 }
 EXPORT_SYMBOL(swiotlb_free_coherent);
 
@@ -1103,9 +1112,7 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
-		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-	else
+	if (!swiotlb_free_buffer(dev, size, dma_addr))
 		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
 }
 
-- 
2.14.2
