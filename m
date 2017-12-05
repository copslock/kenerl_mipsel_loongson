Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2017 12:51:11 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:51990 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990488AbdLELujOBM48 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Dec 2017 12:50:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GUo/gbJVzNbn04s6XTM3PogXsJbbF1gSqSzskXQ1NuE=; b=lPThn/a6aiRNQrgIlmkXG+FCDH
        xjtMAYoK3c20HI98VX4Y0z3qxcfSHxE/uHMueGrofGCvyyVry1LT/0O90S5V1+F7P1nk9Z1+5v3L8
        qkC/sZHwG6AY7QU8zbQn6fb3rM38rlSe6Ux4GOpPFEjTt2wH5j5zUD2LNQLBi5Kpa4vU=;
Received: by maeck.lan (Postfix, from userid 501)
        id CF9CC8324BD; Tue,  5 Dec 2017 12:50:34 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: mm: remove no-op dma_map_ops where possible
Date:   Tue,  5 Dec 2017 12:50:34 +0100
Message-Id: <20171205115034.15078-2-nbd@nbd.name>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171205115034.15078-1-nbd@nbd.name>
References: <20171205115034.15078-1-nbd@nbd.name>
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

If no post-DMA flush is required, and the platform does not provide
plat_unmap_dma_mem(), there is no need to include unmap or sync_for_cpu
ops.

With this patch they are compiled out to improve icache footprint
on devices that handle lots of DMA traffic (especially network routers).

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/Kconfig          |  9 +++++++++
 arch/mips/mm/dma-default.c | 29 +++++++++++++++++------------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..95e58d45a9c1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -220,6 +220,7 @@ config BMIPS_GENERIC
 	select BRCMSTB_L2_IRQ
 	select IRQ_MIPS_CPU
 	select DMA_NONCOHERENT
+	select DMA_UNMAP_POST_FLUSH
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -347,6 +348,7 @@ config MACH_JAZZ
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select GENERIC_ISA_DMA
+	select DMA_UNMAP_POST_FLUSH
 	select HAVE_PCSPKR_PLATFORM
 	select IRQ_MIPS_CPU
 	select I8253
@@ -1109,6 +1111,9 @@ config DMA_NONCOHERENT
 	bool
 	select NEED_DMA_MAP_STATE
 
+config DMA_UNMAP_POST_FLUSH
+	bool
+
 config NEED_DMA_MAP_STATE
 	bool
 
@@ -1633,6 +1638,7 @@ config CPU_R10000
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select DMA_UNMAP_POST_FLUSH
 	help
 	  MIPS Technologies R10000-series processors.
 
@@ -1881,9 +1887,11 @@ config SYS_HAS_CPU_MIPS32_R3_5
 	bool
 
 config SYS_HAS_CPU_MIPS32_R5
+	select DMA_UNMAP_POST_FLUSH
 	bool
 
 config SYS_HAS_CPU_MIPS32_R6
+	select DMA_UNMAP_POST_FLUSH
 	bool
 
 config SYS_HAS_CPU_MIPS64_R1
@@ -1893,6 +1901,7 @@ config SYS_HAS_CPU_MIPS64_R2
 	bool
 
 config SYS_HAS_CPU_MIPS64_R6
+	select DMA_UNMAP_POST_FLUSH
 	bool
 
 config SYS_HAS_CPU_R3000
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 1af0cd90cc34..ecca8782d6fb 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -267,8 +267,9 @@ static inline void __dma_sync(struct page *page,
 	} while (left);
 }
 
-static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction, unsigned long attrs)
+static void __maybe_unused
+mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
+		    enum dma_data_direction direction, unsigned long attrs)
 {
 	if (cpu_needs_post_dma_flush(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
@@ -308,9 +309,10 @@ static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 	return plat_map_dma_mem_page(dev, page) + offset;
 }
 
-static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-	int nhwentries, enum dma_data_direction direction,
-	unsigned long attrs)
+static void __maybe_unused
+mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		  int nhwentries, enum dma_data_direction direction,
+		  unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -325,8 +327,9 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	}
 }
 
-static void mips_dma_sync_single_for_cpu(struct device *dev,
-	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
+static void __maybe_unused
+mips_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
+			     size_t size, enum dma_data_direction direction)
 {
 	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
@@ -342,9 +345,9 @@ static void mips_dma_sync_single_for_device(struct device *dev,
 			   dma_handle & ~PAGE_MASK, size, direction);
 }
 
-static void mips_dma_sync_sg_for_cpu(struct device *dev,
-	struct scatterlist *sglist, int nelems,
-	enum dma_data_direction direction)
+static void __maybe_unused
+mips_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
+			 int nelems, enum dma_data_direction direction)
 {
 	int i;
 	struct scatterlist *sg;
@@ -392,12 +395,14 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 	.free = mips_dma_free_coherent,
 	.mmap = mips_dma_mmap,
 	.map_page = mips_dma_map_page,
-	.unmap_page = mips_dma_unmap_page,
 	.map_sg = mips_dma_map_sg,
+#ifdef CONFIG_DMA_UNMAP_POST_FLUSH
+	.unmap_page = mips_dma_unmap_page,
 	.unmap_sg = mips_dma_unmap_sg,
 	.sync_single_for_cpu = mips_dma_sync_single_for_cpu,
-	.sync_single_for_device = mips_dma_sync_single_for_device,
 	.sync_sg_for_cpu = mips_dma_sync_sg_for_cpu,
+#endif
+	.sync_single_for_device = mips_dma_sync_single_for_device,
 	.sync_sg_for_device = mips_dma_sync_sg_for_device,
 	.dma_supported = mips_dma_supported,
 	.cache_sync = mips_dma_cache_sync,
-- 
2.14.2
