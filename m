Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:33:34 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:38892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994628AbdL2IV4ni-CC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:21:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PueC7iQeB2bQtfDtw8oTIUmzv3wZ1dKWeI2kB84Y3Y0=; b=rSZN0AyCANhkknmx/Lxzky47O
        CULA8Z8ug64ZSEJnJ0n+Ge/zpYBZHGm8ydNTuzbxcDKkOaM/q1tIXNGiavrduBimi1It34c7tLlhg
        wpGjNOoHd0hnLeTgzxMzRgTUjMJi7R+p2QHVq4elrm7NUR8a2S7gT1SehHWf3Ra3sHCTQz/CAQUmx
        nMzTCMwPt0RS2IWGPjRmgmQu89KvgRihBRUIOyVwkbJWgZmUmRPrrSFSrJ0vN/H9GbqHx1Gi7/AHY
        y3Nlk4sTt4h/snqOj4eWet73uP3Sjle5tL8ezzKBh4fl24GbRhBqTY8T9cEjXdfY8i1X3ux2iClCt
        cE+qrQz3g==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpv7-0002NF-S0; Fri, 29 Dec 2017 08:21:38 +0000
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
Subject: [PATCH 32/67] dma-direct: add support for allocation from ZONE_DMA and ZONE_DMA32
Date:   Fri, 29 Dec 2017 09:18:36 +0100
Message-Id: <20171229081911.2802-33-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61729
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
---
 lib/dma-direct.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 7e913728e099..2e9b9494610c 100644
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
@@ -40,6 +48,12 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	int page_order = get_order(size);
 	struct page *page = NULL;
 
+	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
+	if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
+		gfp |= GFP_DMA32;
+	else if (dev->coherent_dma_mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+		gfp |= GFP_DMA;
+
 again:
 	/* CMA can be used only in the context which permits sleeping */
 	if (gfpflags_allow_blocking(gfp)) {
-- 
2.14.2
