Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:09:56 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993008AbeFOLJLMcoTT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OublZJkBDwdfjJYZf/oaaRMAE8PSzEN3t7HP4vDXBz4=; b=sKjDVQqdmr0vqP4yWqP/ULehs
        Zw83F/tgHaAK2uChO8Cj8X02vZn4mRei5SMC381COC9h2DqYTeEcX/JioreoJTpmASiRd9THZYYh/
        u4EZWJb59PrYjnl053L9TnIGzIKjMXvHfOOBgdq2Tf3Ar5P2UObRaCT8y4S979IrV1Sbz1GqIoxyD
        ptgSBYImED9P6718HseZ4qm0+u6DN4MZXxxZ+cyDWpV8EtX693My7ZtLVQtYjCULEP6SHZe0SZs4A
        2byCG99QLW9VbI9NPvhrAneOfHHjfwy50rBN7Z6uY5tInL68ene5TFm4DVfkyjX9spNLNC08FbmhY
        /SugjUxTw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbI-0004lq-Cq; Fri, 15 Jun 2018 11:09:05 +0000
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
Subject: [PATCH 02/25] MIPS: simplify CONFIG_DMA_NONCOHERENT ifdefs
Date:   Fri, 15 Jun 2018 13:08:31 +0200
Message-Id: <20180615110854.19253-3-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64283
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

CONFIG_DMA_MAYBE_COHERENT already selects CONFIG_DMA_NONCOHERENT, so we
can remove the extra conditions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/include/asm/io.h | 4 ++--
 arch/mips/mm/c-r4k.c       | 4 ++--
 arch/mips/mm/cache.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index a7d0b836f2f7..6d6bdc6a48eb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -588,7 +588,7 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int
  *
  * This API used to be exported; it now is for arch code internal use only.
  */
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+#ifdef CONFIG_DMA_NONCOHERENT
 
 extern void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
 extern void (*_dma_cache_wback)(unsigned long start, unsigned long size);
@@ -607,7 +607,7 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define dma_cache_inv(start,size)	\
 	do { (void) (start); (void) (size); } while (0)
 
-#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
  * Read a 32-bit register that requires a 64-bit read cycle on the bus.
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e12dfa48b478..b83ecfb2fbfc 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -830,7 +830,7 @@ static void r4k_flush_icache_user_range(unsigned long start, unsigned long end)
 	return __r4k_flush_icache_range(start, end, true);
 }
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+#ifdef CONFIG_DMA_NONCOHERENT
 
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
@@ -904,7 +904,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	bc_inv(addr, size);
 	__sync();
 }
-#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 struct flush_cache_sigtramp_args {
 	struct mm_struct *mm;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 0d3c656feba0..70a523151ff3 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
 EXPORT_SYMBOL(flush_icache_all);
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+#ifdef CONFIG_DMA_NONCOHERENT
 
 /* DMA cache operations. */
 void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
@@ -65,7 +65,7 @@ void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 EXPORT_SYMBOL(_dma_cache_wback_inv);
 
-#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
  * We could optimize the case where the cache argument is not BCACHE but
-- 
2.17.1
