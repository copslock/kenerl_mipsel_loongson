Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:15:48 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993081AbeFOLJrc5UZT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ByimZVP5c56rBI8ezOFaAWAQ7i1PRsICeRUYI8jLNaA=; b=mOIXKS9M17apq6AoHbq8lu2yC
        XZgaLdfNc5kis3czz2+mACRabgD6cj4kqXsLUSD2D3+vl4oXF1cx12AnepEYx4RcBdgr8VZ63+HRi
        UQdTD2G2GkQlLHOlwCCf0lP4Y9fC8lODqLvPoVj0z8rWZuJrRQHMAcFOxJfizIxUvGvSZV+dwTzuL
        Bts7UanN2Zt+kjr8OnjhWUJ96ZsWxrJjfCMlG+ZabkBlmK5qiBbqfhlzwZJZIaw7Mpz0H6v2LSCIG
        1BNdUqSXvFfNWbMvE3OQHs9quONXD3EBSBaJovdWols6JkoCQbxd/NUcU6ujP83GXKKVxpX46557r
        cfD90YzyA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbs-00057D-JX; Fri, 15 Jun 2018 11:09:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: [PATCH 13/25] MIPS: loongson: remove loongson-3 handling from dma-coherence.h
Date:   Fri, 15 Jun 2018 13:08:42 +0200
Message-Id: <20180615110854.19253-14-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64295
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

Loongson3 is dma coherent and uses swiotlb, so it will never used any
of these helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../include/asm/mach-loongson64/dma-coherence.h  | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
index b8825a7d1279..651dd2eb3ee5 100644
--- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
@@ -20,29 +20,19 @@ struct device;
 static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 					  size_t size)
 {
-#ifdef CONFIG_CPU_LOONGSON3
-	return __phys_to_dma(dev, virt_to_phys(addr));
-#else
 	return virt_to_phys(addr) | 0x80000000;
-#endif
 }
 
 static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 					       struct page *page)
 {
-#ifdef CONFIG_CPU_LOONGSON3
-	return __phys_to_dma(dev, page_to_phys(page));
-#else
 	return page_to_phys(page) | 0x80000000;
-#endif
 }
 
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
-#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
-	return __dma_to_phys(dev, dma_addr);
-#elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
 #else
 	return dma_addr & 0x7fffffff;
@@ -69,11 +59,7 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-#ifdef CONFIG_DMA_NONCOHERENT
 	return 0;
-#else
-	return 1;
-#endif /* CONFIG_DMA_NONCOHERENT */
 }
 
 static inline void plat_post_dma_flush(struct device *dev)
-- 
2.17.1
