Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:32:37 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:48968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990487AbdL2IVpYiGLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:21:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZYQ0pTm9tl6ZI9zEM+q8Be7x6zZ6YPq+/uJWAGk+tFA=; b=U+NGxmGeY0p+dW5yc7FHHLtDL
        VAdqe6Vg1izSM5enhQMX025eSwG3mvtaYDI9ZpqSCP9yHWtUNc+8SvmHV9xnX+WLI4hF4cJT/ENzR
        gWaEp/hv/bjGl1dylrI6vlYnvkSHjqVNR7ybfgMn9GUIyzCjmQjqDvtCuhVT2lLTXoy75Q3TvIZ65
        cDiWKKYm/0r22wHCcMfNjOn6uUNHJTX9vikMCsCfejz0pPQdJziDZBApXUQAseNy+QQO9HBpI9xQL
        2/t7DJUjBKbUdVUWM0pYKwWKyrY0EOvJINnUnWP3rn+Cb+a51+MoxXQa2Z2aUPjp8LtSpRN+FvONW
        y9lO/387A==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpuz-0002I0-Mw; Fri, 29 Dec 2017 08:21:30 +0000
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
Subject: [PATCH 30/67] dma-direct: retry allocations using GFP_DMA for small masks
Date:   Fri, 29 Dec 2017 09:18:34 +0100
Message-Id: <20171229081911.2802-31-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61727
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

If we got back an allocation that wasn't inside the support coherent mask,
retry the allocation using GFP_DMA.

Based on the x86 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index ab81de3ac1d3..f8467cb3d89a 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -28,6 +28,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 	return true;
 }
 
+static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+{
+	return phys_to_dma(dev, phys) + size <= dev->coherent_dma_mask;
+}
+
 static void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -35,11 +40,29 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	int page_order = get_order(size);
 	struct page *page = NULL;
 
+again:
 	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp))
+	if (gfpflags_allow_blocking(gfp)) {
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
+		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+			dma_release_from_contiguous(dev, page, count);
+			page = NULL;
+		}
+	}
 	if (!page)
 		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
+
+	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+		__free_pages(page, page_order);
+		page = NULL;
+
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    !(gfp & GFP_DMA)) {
+			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
+			goto again;
+		}
+	}
+
 	if (!page)
 		return NULL;
 
-- 
2.14.2
