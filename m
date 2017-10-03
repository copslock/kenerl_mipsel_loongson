Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:44:44 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:41276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993095AbdJCKn3IydF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=faEStaeaDWxnhfJ1+XNS89aZa8l4IH6p0N65C/ygaGA=; b=GFloh83zAuSMlV0VEI1SedYGH
        Q0VNWJyMyJM9zuf6SUScC2AYraSvwdlGApKNP4YChE8jUL1ZNf528W7FRgmL0DzeHWtDpIG3aeK5k
        uQdIEXNquFzhiFX713Zxuv0PhcYjSzM9+kshYRyUQsybvg4aekhnluSUqlyt+i6BM3OhF8zB3qgrp
        CQq+cHsrZmoAntEVv0KYacbDX5rwFQ6rV88+wyvaqrUvnMV/PMPRMDxsSpCCGC8CtUQM5GHNO1fix
        8d7kAGvwuCu1K92jpkwWxfpucnK3FlqRR2tDFgnGucYlUpZVzwYI0MdSe7yvRNzICDV/k1ir2FPac
        Sz4yb0uuA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKfb-0000Ou-AT; Tue, 03 Oct 2017 10:43:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] frv: make dma_cache_sync a no-op
Date:   Tue,  3 Oct 2017 12:43:03 +0200
Message-Id: <20171003104311.10058-4-hch@lst.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60224
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

frv does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
make any sense to do any work in dma_cache_sync given that it must be a
no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/frv/include/asm/dma-mapping.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/frv/include/asm/dma-mapping.h b/arch/frv/include/asm/dma-mapping.h
index 354900917585..da0e5c9744c4 100644
--- a/arch/frv/include/asm/dma-mapping.h
+++ b/arch/frv/include/asm/dma-mapping.h
@@ -18,7 +18,6 @@ static inline
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
-	flush_write_buffers();
 }
 
 #endif  /* _ASM_DMA_MAPPING_H */
-- 
2.14.1
