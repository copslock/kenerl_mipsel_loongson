Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:21:32 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:43678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994685AbeAJIKedNJ3S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q3So1L/9ey1WXyrUNf1ovVxj5byto7gwDeaE1X8lxJU=; b=q234mAWokhCvRPdNf/Fc8qy31
        HkC6hhiKnrZKY+oepJCGw+/asirCL0LvxtvNZubX8RSv6xJ5JakezHSSO+htIKJVzPIRPPKpGp8iP
        Ba3tCCHFuQyck2RA42uny3GnbyrLjrYlrAjh3w4k8rbqElpA/06a1cZeeN7Qap2AkEq8tjZ2SPyiW
        vNfxna5lK7pkNSuQb6DDIzs0/5EgpxSrCudUuzm7pYEf1oRlPbXrEP9Iw9G3AwYIoDVd4L3lBFX8A
        eAh4Yl6f7+Vl5itJlYf1WOCfd+CNBd9CS52N9EDbdqmUDgXFEZxdpAgL5NY12Hyrt0rDBnMIL/e5z
        H5vR9RIuQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSq-0000Tm-38; Wed, 10 Jan 2018 08:10:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/22] tile: replace ZONE_DMA with ZONE_DMA32
Date:   Wed, 10 Jan 2018 09:09:27 +0100
Message-Id: <20180110080932.14157-18-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62015
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

tile uses ZONE_DMA for allocations below 32-bits.  These days we
name the zone for that ZONE_DMA32, which will allow to use the
dma-direct and generic swiotlb code as-is, so rename it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/tile/Kconfig          | 2 +-
 arch/tile/kernel/pci-dma.c | 4 ++--
 arch/tile/kernel/setup.c   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 02f269cfa538..30c586686f29 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -249,7 +249,7 @@ config HIGHMEM
 
 	  If unsure, say "true".
 
-config ZONE_DMA
+config ZONE_DMA32
 	def_bool y
 
 config IOMMU_HELPER
diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index f2abedc8a080..a267fa740048 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -54,7 +54,7 @@ static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
 	 * which case we will return NULL.  But such devices are uncommon.
 	 */
 	if (dma_mask <= DMA_BIT_MASK(32)) {
-		gfp |= GFP_DMA;
+		gfp |= GFP_DMA32;
 		node = 0;
 	}
 
@@ -513,7 +513,7 @@ static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
 					 unsigned long attrs)
 {
-	gfp |= GFP_DMA;
+	gfp |= GFP_DMA32;
 	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
 }
 
diff --git a/arch/tile/kernel/setup.c b/arch/tile/kernel/setup.c
index ad83c1e66dbd..eb4e198f6f93 100644
--- a/arch/tile/kernel/setup.c
+++ b/arch/tile/kernel/setup.c
@@ -814,11 +814,11 @@ static void __init zone_sizes_init(void)
 #endif
 
 		if (start < dma_end) {
-			zones_size[ZONE_DMA] = min(zones_size[ZONE_NORMAL],
+			zones_size[ZONE_DMA32] = min(zones_size[ZONE_NORMAL],
 						   dma_end - start);
-			zones_size[ZONE_NORMAL] -= zones_size[ZONE_DMA];
+			zones_size[ZONE_NORMAL] -= zones_size[ZONE_DMA32];
 		} else {
-			zones_size[ZONE_DMA] = 0;
+			zones_size[ZONE_DMA32] = 0;
 		}
 
 		/* Take zone metadata from controller 0 if we're isolnode. */
@@ -830,7 +830,7 @@ static void __init zone_sizes_init(void)
 		       PFN_UP(node_percpu[i]));
 
 		/* Track the type of memory on each node */
-		if (zones_size[ZONE_NORMAL] || zones_size[ZONE_DMA])
+		if (zones_size[ZONE_NORMAL] || zones_size[ZONE_DMA32])
 			node_set_state(i, N_NORMAL_MEMORY);
 #ifdef CONFIG_HIGHMEM
 		if (end != start)
-- 
2.14.2
