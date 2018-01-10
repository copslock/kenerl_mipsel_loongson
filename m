Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:17:53 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:55373 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992079AbeAJIKEigaHS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q03hRYUbpouKbMRNwIy5W1fBLImmhcPJhClaOWFoxeE=; b=W6xDGCEBMNE6dOGPB12HPJ3+K
        KGBH/hKl+i3HLeC3hBZLT88kOOvLCGQpNoN4PYveEb2CjK54QqXoB+cH3OtSc2FMozveB/6zlz7ah
        xqKYlf56cyh+RpHcU7i8dTY+gbTezuIwUTsIO5WB48ANPumZz8st2WwWG0G6kTK7t5j4kW9dF4VwQ
        e7rqJ9jfIWHrZULaroFeVSFoFXWf3ePEm57izaJqP3QPkwm5CapLiyCQO2Od79OzNvqwfT+nRLMe5
        u0aLj2bctQHQ6vDYF7gz1Dtr3Js5OZaAEJtwttLsGcyXI2CWwWp6FYGbMjgnQ3YQMXZ8Er48rCrgz
        hO54YFZfg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSN-00083q-8b; Wed, 10 Jan 2018 08:09:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/22] swiotlb: add common swiotlb_map_ops
Date:   Wed, 10 Jan 2018 09:09:17 +0100
Message-Id: <20180110080932.14157-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62006
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

Currently all architectures that want to use swiotlb have to implement
their own dma_map_ops instances.  Provide a generic one based on the
x86 implementation which first calls into dma_direct to try a full blown
direct mapping implementation (including e.g. CMA) before falling back
allocating from the swiotlb buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h |  8 ++++++++
 lib/swiotlb.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
index cf5311908fa9..0fae2f45c3c0 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1087,3 +1087,46 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
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
