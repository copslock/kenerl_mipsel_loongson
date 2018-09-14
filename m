Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:58:53 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:47662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994240AbeINJ60crJ9I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 11:58:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aYDMexnkrCtlRs/Rk2EfhjL4KIhddofkXoarJAzdIfI=; b=ZYiyBxkEUu7Qq5pBeoBMWctVg
        X6pAc/QURs38uWk9Hui6rkmvQvtpMpJKiIF/wsjHsl6lyQiQWDIARLfOYKglKnolOq7pGRMKTRAoH
        0rt2gEQJUcuh4nj0KRJw1Uu+bA2NBDob3Vu4wR0peOrKFuBnc/4CJvlMBDh/IlxGo5C2gYyMNN2ux
        ur0mP4/rRLkXnGJSiZOddErccotgd6S/ldPZBh/dnCtKsds7KJCniX6rtXVXSy1ZlzJbLKlkFCN5c
        54UASZEQ2yDueWN11+dIXnq0eMGqSf6X+5I+XW7bV7Ff5ku5vZkFlF7sEl2zBjg2j4oNCUsaNLt5E
        K0yVAD78g==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0kri-0000S3-Tk; Fri, 14 Sep 2018 09:58:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] MIPS: don't select DMA_MAYBE_COHERENT from DMA_PERDEV_COHERENT
Date:   Fri, 14 Sep 2018 11:58:04 +0200
Message-Id: <20180914095808.22202-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914095808.22202-1-hch@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+df237881911bfff71047+5500+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66251
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
Acked-by: Paul Burton <paul.burton@mips.com>
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
