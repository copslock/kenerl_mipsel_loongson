Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 18:36:41 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:45217 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993111AbcKJRgaWP6tO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 18:36:30 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 10 Nov 2016 09:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,619,1473145200"; 
   d="scan'208";a="1066806656"
Received: from ahduyck-blue-test.jf.intel.com ([134.134.2.201])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2016 09:36:23 -0800
Subject: [mm PATCH v3 11/23] arch/mips: Add option to skip DMA sync as a
 part of map and unmap
From:   Alexander Duyck <alexander.h.duyck@intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-mips@linux-mips.org, Keguang Zhang <keguang.zhang@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        netdev@vger.kernel.org
Date:   Thu, 10 Nov 2016 06:35:13 -0500
Message-ID: <20161110113513.76501.32321.stgit@ahduyck-blue-test.jf.intel.com>
In-Reply-To: <20161110113027.76501.63030.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161110113027.76501.63030.stgit@ahduyck-blue-test.jf.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <alexander.h.duyck@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.h.duyck@intel.com
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

This change allows us to pass DMA_ATTR_SKIP_CPU_SYNC which allows us to
avoid invoking cache line invalidation if the driver will just handle it
via a sync_for_cpu or sync_for_device call.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 arch/mips/loongson64/common/dma-swiotlb.c |    2 +-
 arch/mips/mm/dma-default.c                |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 1a80b6f..aab4fd6 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -61,7 +61,7 @@ static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
 				int nents, enum dma_data_direction dir,
 				unsigned long attrs)
 {
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, 0);
+	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, attrs);
 	mb();
 
 	return r;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index b2eadd6..dd998d7 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -293,7 +293,7 @@ static inline void __dma_sync(struct page *page,
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, unsigned long attrs)
 {
-	if (cpu_needs_post_dma_flush(dev))
+	if (cpu_needs_post_dma_flush(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
 			   dma_addr & ~PAGE_MASK, size, direction);
 	plat_post_dma_flush(dev);
@@ -307,7 +307,8 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 
 	for_each_sg(sglist, sg, nents, i) {
-		if (!plat_device_is_coherent(dev))
+		if (!plat_device_is_coherent(dev) &&
+		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -324,7 +325,7 @@ static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction,
 	unsigned long attrs)
 {
-	if (!plat_device_is_coherent(dev))
+	if (!plat_device_is_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync(page, offset, size, direction);
 
 	return plat_map_dma_mem_page(dev, page) + offset;
@@ -339,6 +340,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 
 	for_each_sg(sglist, sg, nhwentries, i) {
 		if (!plat_device_is_coherent(dev) &&
+		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    direction != DMA_TO_DEVICE)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
