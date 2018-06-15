Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:13:53 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbeFOLJeD7YDT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1tQ9ZhcazR4RWOWeJHE9Rm+57t/B0fJR4IsF62B9nNc=; b=btXaKNtGIKSdNzVQk5Cs7vIuP
        cGb6aYOHlUA9SHaT8GBkZRxy7piRlHdhAV6Mj0D0eblSjE3e4oLHi13r3ZfnHPAY84yaSv2VZ3wMP
        rlvQvuWTP63wdyHc7inYyDItxhdnOXs/jlds0LzgEOsQ/4cTJcCYqWiRE5lESJAVFG0SW2koXoJsa
        1j16I7E5WEimHTytoxmJ84Ke9dzPAO3+Z8jctFdv/nOlmftUo1r7TSfeNKRAQaMnPUsXUHrBzValt
        Gw3Ke5sPYGvgx3C0hDwWV8NOUkdrs0LMioqYmvqIG7Ph+lgGmmdbK261GPa1xErpwFSEJATVRsA8Z
        yvD2x/dQw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbj-00051W-4D; Fri, 15 Jun 2018 11:09:31 +0000
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
Subject: [PATCH 10/25] MIPS: Octeon: remove mips dma-default stubs
Date:   Fri, 15 Jun 2018 13:08:39 +0200
Message-Id: <20180615110854.19253-11-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64291
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

Octeon doesn't use the dma-default code, and now doesn't built it either,
so these stubs can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../asm/mach-cavium-octeon/dma-coherence.h    | 48 -------------------
 1 file changed, 48 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index c0254c72d97b..66eee98b8b8d 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -4,11 +4,6 @@
  * for more details.
  *
  * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- *
- *
- * Similar to mach-generic/dma-coherence.h except
- * plat_device_is_coherent hard coded to return 1.
- *
  */
 #ifndef __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
 #define __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
@@ -18,49 +13,6 @@
 struct device;
 
 extern void octeon_pci_dma_init(void);
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-	size_t size)
-{
-	BUG();
-	return 0;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	BUG();
-	return 0;
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	BUG();
-	return 0;
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-	BUG();
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	BUG();
-	return 0;
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 1;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
 extern char *octeon_swiotlb;
 
 #endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
-- 
2.17.1
