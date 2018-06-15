Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:12:10 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992907AbeFOLJ2sGEQT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IpkzqgBh2ABkgTqmWALq9xoDOHOF+Kz+4V5IIK1xmfc=; b=kQBz8FEObbI8smMEOspwwhWou
        /7XPgZ27YgQlmb02xmLi0UsYlXTNFvyke+XyTxe+8rleO45lEZZkpgM3Kg6VI5j4IA0FkYzQmSsHZ
        sBPO59lWqSs4zpMG6sTayScojCwQOw0ahYp8buR9bXvu7zA83Yrz9OXEQVLB9PdfYMAyLObhjQb8B
        1Xib413M7vKOCwtfTR7AZtAVIo9kqrChDKExZTuNRwuQxqTkWSjnjeKM0RHSeE9eV11Mcyv8qwRwI
        VeIzFUFATEO8aBJB2SHwZoSkaIJ/riuBYC615V+zrL1/jocl4reN7pQx/SNZqlF7SuBmFFQ5T0htn
        3Wazasvmg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbc-0004ys-SU; Fri, 15 Jun 2018 11:09:25 +0000
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
Subject: [PATCH 08/25] MIPS: remove the mips_dma_map_ops indirection
Date:   Fri, 15 Jun 2018 13:08:37 +0200
Message-Id: <20180615110854.19253-9-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64289
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

And use mips_default_dma_map_ops directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/dma-mapping.h | 4 ++--
 arch/mips/mm/dma-default.c          | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index ebcce3e22297..f24b052ec740 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -10,7 +10,7 @@
 #include <dma-coherence.h>
 #endif
 
-extern const struct dma_map_ops *mips_dma_map_ops;
+extern const struct dma_map_ops mips_default_dma_map_ops;
 extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
@@ -18,7 +18,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #ifdef CONFIG_SWIOTLB
 	return &mips_swiotlb_ops;
 #else
-	return mips_dma_map_ops;
+	return &mips_default_dma_map_ops;
 #endif
 }
 
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index f9fef0028ca2..2db6c2a6f964 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -384,7 +384,7 @@ static void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		__dma_sync_virtual(vaddr, size, direction);
 }
 
-static const struct dma_map_ops mips_default_dma_map_ops = {
+const struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc = mips_dma_alloc_coherent,
 	.free = mips_dma_free_coherent,
 	.mmap = mips_dma_mmap,
@@ -399,6 +399,4 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 	.dma_supported = mips_dma_supported,
 	.cache_sync = mips_dma_cache_sync,
 };
-
-const struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
-EXPORT_SYMBOL(mips_dma_map_ops);
+EXPORT_SYMBOL(mips_default_dma_map_ops);
-- 
2.17.1
