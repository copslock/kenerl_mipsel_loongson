Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:46:23 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:51534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990508AbdL2IX7MwRHL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gHCO/FMTMmLY6q/804twb5+5GZ2LDhEzPaPwzaH/v5I=; b=duBbmVa+NPlchAItiFRBUKVS7
        PY0sOhB/W8RnM13PYol8HE5rSR6UtNDCdablYILLwXvV4mN6PMsrTSGsT83PpRsAn70KnhNo8AJCV
        lVe85RwzGkvkOY8cj+TKUKfT26661klAO1udoJEzp2gWFRP5hal1EnjMzXkUeRrjqIWocHba1PcBY
        rRzqqF18bwBlYiC39XJDI0MqWjvUfDPJilaUYzqDUBGpOWgAxFuYG0Zrqcqr1AT7BGsW1VSm9Hi64
        UQqnXouXD/xUkvTK2YYErnkXVbb+9LDEZ77KQQtsAGmJJOoxt+T8JZvOc7Bpw8m1NNYSe6Gzvfqk4
        5jcflxYuA==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpx6-0003nd-4Z; Fri, 29 Dec 2017 08:23:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 60/67] tile: replace ZONE_DMA with ZONE_DMA32
Date:   Fri, 29 Dec 2017 09:19:04 +0100
Message-Id: <20171229081911.2802-61-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61757
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
index 9072e2c25e59..a9b48520eeb9 100644
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
 
@@ -515,7 +515,7 @@ static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
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
