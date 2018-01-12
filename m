Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 10:04:00 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:48461 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994654AbeALIpfb1IhJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:45:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KqTQ9gpRM5mdnZ4+PbKZZztFOTdS84gvO3UIDdU61M0=; b=C/rP/EPej76j2mvbcQC2JcaYP
        R/ae4h99gj4nbPHg7lH6fLCoDs+ALVgUkuwuDZKedNFD3yMSJmGb/Tyg3A8LCsF457XbYZxjVMnTX
        ejJDxVQRZdSHnAOr9I5H1NckA8L05trp47DMBk3CLSBlF/ZMZVaJkv2DfTk3rwVx5Q8Lfmif0kwI5
        14s4DDKROGiU2eXvUDA9QV2UJWd+3nvsvJpq14e8+jTRfu7nBiNEhXGQCHvRN7HiwCZdWBgeqTh1p
        PLvnpp+tqVPEV62EHazJ+i9A8QzjqBRU2C3krbwCTk4fMCDGOrdDGv5Fke+3nC+VxSiOThSyuguuL
        HSM7SeKwQ==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuwY-0000D6-UB; Fri, 12 Jan 2018 08:44:07 +0000
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
Subject: [PATCH 29/34] dma-direct: add support for allocation from ZONE_DMA and ZONE_DMA32
Date:   Fri, 12 Jan 2018 09:42:27 +0100
Message-Id: <20180112084232.2857-30-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62091
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

This allows to dip into zones for lower memory if they are available.
If one of the zones is not available the corresponding GFP_* flag
will evaluate to 0 so they won't change anything.  We provide an
arch tunable for those architectures that do not use GFP_DMA for
the lowest 24-bits, given that there are a few.

Roughly based on the x86 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index f04a424f91fa..8f76032ebc3c 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -12,6 +12,14 @@
 
 #define DIRECT_MAPPING_ERROR		0
 
+/*
+ * Most architectures use ZONE_DMA for the first 16 Megabytes, but
+ * some use it for entirely different regions:
+ */
+#ifndef ARCH_ZONE_DMA_BITS
+#define ARCH_ZONE_DMA_BITS 24
+#endif
+
 static bool
 check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 		const char *caller)
@@ -34,6 +42,12 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	int page_order = get_order(size);
 	struct page *page = NULL;
 
+	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+		gfp |= GFP_DMA;
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
+		gfp |= GFP_DMA32;
+
 	/* CMA can be used only in the context which permits sleeping */
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
-- 
2.14.2
