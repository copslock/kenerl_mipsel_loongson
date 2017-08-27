Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 18:13:28 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:37829 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994938AbdH0QKzEdpBp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 18:10:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uwu+9A0z95q/irkl2CO2BDnLQWOKgUa9OVgShS5p5uE=; b=PJiOOCrt3FVLiLl+AWE3ThKB/
        qKCRES1Doj/FHIaQapWEeMl8ZammS4W3YB3q95OB2QtaJcKVd7qFfs4Z9md1lSuSwZn7uz9rz7vXb
        HQmxnFU1og9u+ukxmlqnsMz7Tcx5e60JGHiyhEE1D6fG/EuuuoI2d7OZp9Cniix8icD9o2pW5m6vT
        V+mym6JJxxNVD2p1BhjGoB+WN0q5qCBkN1yP2aR2BxYkyOSuN7NtfWXbH6XTdqLGidnmyxkRhNsXa
        ZUN98M0i8Gl1OYREB5l22DpfN0sPmErsHAK7Jno/p4yhWJsAQcedahCxPIuX7FgvxPWh/L0ihXUsd
        hkJAzdZQg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dm09A-0006sA-Pe; Sun, 27 Aug 2017 16:10:49 +0000
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
Subject: [PATCH 05/12] ia64: make dma_cache_sync a no-op
Date:   Sun, 27 Aug 2017 18:10:25 +0200
Message-Id: <20170827161032.22772-6-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59820
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

ia64 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
make any sense to do any work in dma_cache_sync given that it must be a
no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/dma-mapping.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 3ce5ab4339f3..99dfc1aa9d3c 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -48,11 +48,6 @@ static inline void
 dma_cache_sync (struct device *dev, void *vaddr, size_t size,
 	enum dma_data_direction dir)
 {
-	/*
-	 * IA-64 is cache-coherent, so this is mostly a no-op.  However, we do need to
-	 * ensure that dma_cache_sync() enforces order, hence the mb().
-	 */
-	mb();
 }
 
 #endif /* _ASM_IA64_DMA_MAPPING_H */
-- 
2.11.0
