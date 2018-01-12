Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 10:05:05 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:32817 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994658AbeALIpndJsmJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:45:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0s/Tne3vVh2iDi5i9AZoN4Gk9kA0m+jc9VATZndhkhI=; b=tTarzgzpK4Vu9fakL6m+288IW
        JH57nO5RZUNBq6m9AK1MX5yYxCopMuTOCiE1eD3+a1dqQUxrlVXoVUNSbnDt5oebcgt6A7PsQnwF2
        SgXWgNsc5SXynBfm+j9TzOKX5vCNjKPm4SuPPs/X7EHbdbZ0yftXjEyy8dK2TouxZhDU11Y9GH6W5
        1lUpnuKkFch/Sa3e+ULwo7GtBP6leUMHe1gpZxgiV+6hzr4pQdajI29a0mFihNcxl/W2gcGo1eHMS
        WdEaVLQvvCP5qkBdpEliO2ya3JXtfdBNGFF3kKbhEW5XCWGJMW/gCsrz8TPOsjR1/VOfUqmov8yeb
        On8+Hz7iA==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuwh-0000Mx-Is; Fri, 12 Jan 2018 08:44:16 +0000
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
Subject: [PATCH 32/34] dma-direct: reject too small dma masks
Date:   Fri, 12 Jan 2018 09:42:30 +0100
Message-Id: <20180112084232.2857-33-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62094
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-direct.h |  1 +
 lib/dma-direct.c           | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 4788bf0bf683..bcdb1a3e4b1f 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -42,5 +42,6 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
+int dma_direct_supported(struct device *dev, u64 mask);
 
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 784a68dfdbe3..40b1f92f2214 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -122,6 +122,24 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
+int dma_direct_supported(struct device *dev, u64 mask)
+{
+#ifdef CONFIG_ZONE_DMA
+	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+		return 0;
+#else
+	/*
+	 * Because 32-bit DMA masks are so common we expect every architecture
+	 * to be able to satisfy them - either by not supporting more physical
+	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
+	 * architecture needs to use an IOMMU instead of the direct mapping.
+	 */
+	if (mask < DMA_BIT_MASK(32))
+		return 0;
+#endif
+	return 1;
+}
+
 static int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == DIRECT_MAPPING_ERROR;
@@ -132,6 +150,7 @@ const struct dma_map_ops dma_direct_ops = {
 	.free			= dma_direct_free,
 	.map_page		= dma_direct_map_page,
 	.map_sg			= dma_direct_map_sg,
+	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 };
 EXPORT_SYMBOL(dma_direct_ops);
-- 
2.14.2
