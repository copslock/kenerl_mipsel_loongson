Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:24:06 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992851AbeEYJVtPtgeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1phzsr1I0Yw/1Z9EmNM6XatCYZd5mSuyIGtty7kH5kQ=; b=jEo8vrtVX/acV46+KHiq90+iy
        uyXvm6WJ0CERacmM6N4y9jVQFh4/v19rKuGM8tcKC75HYfbInOhJ3K3yNnKMFFQbF9GX5LN9gvyPp
        u3m3dEyg/xDdr8/bnJs4owr7/DqfAl8trq+BaNIrf2jF73K1LRNXKlG7mNSqx/vqOVOxmC47sp4St
        Cv+doMQQ0R7wFec0gmCRsE/VTF2EaNItM1Wu36szQeivvmShCN47Yo1eX8vK4AC0CDYNjBduL8h66
        epkXtq+8pbkWXh2KSSHJjYsYFP6HacFBjHZKAaxgHmJN5yVMpI6xAL7diNkRki/hjriBxORaIBfO7
        sis3HFUZg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8ux-0001jx-2l; Fri, 25 May 2018 09:21:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 10/25] MIPS: Octeon: remove mips dma-default stubs
Date:   Fri, 25 May 2018 11:20:56 +0200
Message-Id: <20180525092111.18516-11-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64023
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
2.17.0
