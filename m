Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 10:28:24 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54234 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992734AbcF3I2SD9lD0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 10:28:18 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O9K002I4SUXMZ80@mailout1.w1.samsung.com>; Thu,
 30 Jun 2016 09:28:10 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-60-5774d819680b
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 67.0E.05254.918D4775; Thu,
 30 Jun 2016 09:28:09 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O9K00F5WSS0I050@eusync2.samsung.com>; Thu,
 30 Jun 2016 09:28:09 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v5 31/44] mips: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 30 Jun 2016 10:25:58 +0200
Message-id: <1467275171-6298-31-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1467275171-6298-1-git-send-email-k.kozlowski@samsung.com>
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <1467275171-6298-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t/xK7qSN0rCDSZeNrOYs34Nm8XGGetZ
        LU5PWMRk8fqFocXlXXPYLCZMncRucWmPigO7x+YVWh4nZvxm8Ti6ci2TR9+WVYwenzfJBbBG
        cdmkpOZklqUW6dslcGXM+LuKreC/VcWRKYuYGhgXGnYxcnBICJhIbG8R6GLkBDLFJC7cW8/W
        xcjFISSwlFFiyZ1PjBBOI5PEyqmHmECq2ASMJTYvX8IGYosI6Eqser6LGaSIWeAuo8TJy3vA
        EsICPhKPJ80Gs1kEVCWe3tzDDmLzCrhLPN85nwVinZzEyWOTWUGu4ASKz/7uD7GshVHi2L5J
        zBMYeRcwMqxiFE0tTS4oTkrPNdQrTswtLs1L10vOz93ECAmoLzsYFx+zOsQowMGoxMPrwFwS
        LsSaWFZcmXuIUYKDWUmEd/sVoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeubvehwgJpCeWpGan
        phakFsFkmTg4pRoY1S8a1Ee+upp+VuAlL3eOs9Q7uxsS32c8vBR390TfrGWfwnhPvmj6uN+y
        92KzBNvBzDsLdNZ5La2OqtGdIs9e05b651PWMm+JtapdjhKrIreGyzv9vLB7vbLlf6nIQq8z
        YvEWwXN2LU3gYtd8r9JTxLTnxIqXeV28EgLZa+7s3FW0yfPunUBJJZbijERDLeai4kQA8ysj
        uyQCAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/mips/cavium-octeon/dma-octeon.c      |  8 ++++----
 arch/mips/loongson64/common/dma-swiotlb.c | 10 +++++-----
 arch/mips/mm/dma-default.c                | 14 +++++++-------
 arch/mips/netlogic/common/nlm-dma.c       |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 2cd45f5f9481..fd69528b24fb 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -125,7 +125,7 @@ static phys_addr_t octeon_small_dma_to_phys(struct device *dev,
 
 static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
 					    direction, attrs);
@@ -135,7 +135,7 @@ static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
 }
 
 static int octeon_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
+	int nents, enum dma_data_direction direction, unsigned long attrs)
 {
 	int r = swiotlb_map_sg_attrs(dev, sg, nents, direction, attrs);
 	mb();
@@ -157,7 +157,7 @@ static void octeon_dma_sync_sg_for_device(struct device *dev,
 }
 
 static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -189,7 +189,7 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void octeon_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 4ffa6fc81c8f..1a80b6f73ab2 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -10,7 +10,7 @@
 #include <dma-coherence.h>
 
 static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -41,7 +41,7 @@ static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void loongson_dma_free_coherent(struct device *dev, size_t size,
-		void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+		void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
@@ -49,7 +49,7 @@ static void loongson_dma_free_coherent(struct device *dev, size_t size,
 static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
 					dir, attrs);
@@ -59,9 +59,9 @@ static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
 
 static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
 				int nents, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
+	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, 0);
 	mb();
 
 	return r;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index cb557d28cb21..0ed9000dc1ff 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -131,7 +131,7 @@ static void *mips_dma_alloc_noncoherent(struct device *dev, size_t size,
 }
 
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t * dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 	struct page *page = NULL;
@@ -176,7 +176,7 @@ static void mips_dma_free_noncoherent(struct device *dev, size_t size,
 }
 
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle, struct dma_attrs *attrs)
+	dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long addr = (unsigned long) vaddr;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -200,7 +200,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	void *cpu_addr, dma_addr_t dma_addr, size_t size,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -291,7 +291,7 @@ static inline void __dma_sync(struct page *page,
 }
 
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
+	size_t size, enum dma_data_direction direction, unsigned long attrs)
 {
 	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
@@ -301,7 +301,7 @@ static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 }
 
 static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
+	int nents, enum dma_data_direction direction, unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -322,7 +322,7 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	if (!plat_device_is_coherent(dev))
 		__dma_sync(page, offset, size, direction);
@@ -332,7 +332,7 @@ static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 
 static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	int nhwentries, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index 3758715d4ab6..0630693bec2a 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -45,7 +45,7 @@
 static char *nlm_swiotlb;
 
 static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
@@ -62,7 +62,7 @@ static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void nlm_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
-- 
1.9.1
