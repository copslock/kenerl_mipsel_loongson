Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 16:51:00 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:55498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994565AbeH0OutbHpWR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2018 16:50:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+1q0YrFsje/c9JxM7S1GXJ+Selqn9u0h3rTaKOuMI/w=; b=Feku2z1fclxXa0Ut9Nz9geDnn
        maNgDvV2C2czxu0uGKCaHrPF7v+jaIvmtTCV0sbrR0wzBVLaqCME6G28pMOT70zPcqqDUDpDEIoR1
        6BUZMtvnFKfXhUtEDpC0fTPlq7kYGXsw2Ag5UMme2hbPeLqtnXkqKdO8I1daJa6v/YLTtvvT5L4+h
        VMSRInXTKaSLPuCMCdfXftkIzT2AC1n6xTTHmakF/v2kFFJ+odLOMJgnwVjwNTg/2mVEPVDQ4WUgw
        wf3xyLW+ACrvnS/KMe+fzaOXvyLmhGFv4hQnMyBqk3dLNeCg8rPdmG8hGwje0f6tfL+SNgUnPsmD6
        dgpx0JN6Q==;
Received: from 089144202128.atnat0011.highway.a1.net ([89.144.202.128] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuIqo-0004VR-IC; Mon, 27 Aug 2018 14:50:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] MIPS: don't select DMA_MAYBE_COHERENT from DMA_PERDEV_COHERENT
Date:   Mon, 27 Aug 2018 16:50:28 +0200
Message-Id: <20180827145032.9522-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827145032.9522-1-hch@lst.de>
References: <20180827145032.9522-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0060dd1d165dc04ea21d+5482+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65750
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

While both option select a form of conditional dma coherence they don't
actually share any code in the implementation, so untangle them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig        |  2 +-
 arch/mips/kernel/setup.c |  2 +-
 arch/mips/mm/c-r4k.c     | 17 ++++++++---------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..0b25180028b8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1111,7 +1111,7 @@ config DMA_MAYBE_COHERENT
 
 config DMA_PERDEV_COHERENT
 	bool
-	select DMA_MAYBE_COHERENT
+	select DMA_NONCOHERENT
 
 config DMA_NONCOHERENT
 	bool
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb7da59..6d840a44fa36 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -1067,7 +1067,7 @@ static int __init debugfs_mips(void)
 arch_initcall(debugfs_mips);
 #endif
 
-#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
+#ifdef CONFIG_DMA_MAYBE_COHERENT
 /* User defined DMA coherency from command line. */
 enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
 EXPORT_SYMBOL_GPL(coherentio);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a9ef057c79fe..05bd77727fb9 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1955,22 +1955,21 @@ void r4k_cache_init(void)
 	__flush_icache_user_range	= r4k_flush_icache_user_range;
 	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
-# if defined(CONFIG_DMA_PERDEV_COHERENT)
-	if (0) {
-# else
-	if ((coherentio == IO_COHERENCE_ENABLED) ||
-	    ((coherentio == IO_COHERENCE_DEFAULT) && hw_coherentio)) {
-# endif
+#ifdef CONFIG_DMA_NONCOHERENT
+#ifdef CONFIG_DMA_MAYBE_COHERENT
+	if (coherentio == IO_COHERENCE_ENABLED ||
+	    (coherentio == IO_COHERENCE_DEFAULT && hw_coherentio)) {
 		_dma_cache_wback_inv	= (void *)cache_noop;
 		_dma_cache_wback	= (void *)cache_noop;
 		_dma_cache_inv		= (void *)cache_noop;
-	} else {
+	} else
+#endif /* CONFIG_DMA_MAYBE_COHERENT */
+	{
 		_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
 		_dma_cache_wback	= r4k_dma_cache_wback_inv;
 		_dma_cache_inv		= r4k_dma_cache_inv;
 	}
-#endif
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 	build_clear_page();
 	build_copy_page();
-- 
2.18.0
