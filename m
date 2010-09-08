Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 01:12:49 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:50208 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491055Ab0IHXMj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Sep 2010 01:12:39 +0200
Received: (qmail 5586 invoked from network); 8 Sep 2010 23:12:35 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 8 Sep 2010 23:12:35 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Wed, 08 Sep 2010 16:12:35 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 8 Sep 2010 16:02:16 -0700
Subject: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Message-Id: <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
In-Reply-To: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 27733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6796

On noncoherent processors with a readahead cache, an extra platform-
specific invalidation is required during the dma_sync_*_for_cpu()
operations to keep drivers from seeing stale prefetched data.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   13 +++++++++++++
 arch/mips/include/asm/mach-generic/dma-coherence.h |   13 +++++++++++++
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |   13 +++++++++++++
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |   13 +++++++++++++
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |   13 +++++++++++++
 .../mips/include/asm/mach-loongson/dma-coherence.h |   13 +++++++++++++
 arch/mips/include/asm/mach-powertv/dma-coherence.h |   13 +++++++++++++
 arch/mips/mm/dma-default.c                         |    3 +++
 8 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 17d5794..8192683 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -52,6 +52,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	mb();
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 1;
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 8da9807..20728eb 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -52,6 +52,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	return;
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index d3d0401..b1cb862 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -62,6 +62,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	return;
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 3785595..c870003 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -84,6 +84,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	return;
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index f93aee5..dd7b8e3 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -52,6 +52,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	return;
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index 981c75f..7565bbc 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -58,6 +58,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	return;
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
index f76029c..1134961 100644
--- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -105,6 +105,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
 	return;
 }
 
+static inline void plat_extra_sync_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, unsigned long offset, size_t size,
+	enum dma_data_direction direction)
+{
+	return;
+}
+
+static inline void plat_extra_sync_for_cpu_sg(struct device *dev,
+	struct scatterlist *sg, enum dma_data_direction direction)
+{
+	return;
+}
+
 static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 79dfb9c..ed1baaf 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -287,6 +287,7 @@ EXPORT_SYMBOL(dma_unmap_sg);
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	size_t size, enum dma_data_direction direction)
 {
+	plat_extra_sync_for_cpu(dev, dma_handle, 0, size, direction);
 	if (cpu_is_noncoherent_r10000(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
 			   dma_handle & ~PAGE_MASK, size, direction);
@@ -308,6 +309,7 @@ EXPORT_SYMBOL(dma_sync_single_for_device);
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	unsigned long offset, size_t size, enum dma_data_direction direction)
 {
+	plat_extra_sync_for_cpu(dev, dma_handle, offset, size, direction);
 	if (cpu_is_noncoherent_r10000(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle), offset, size,
 			   direction);
@@ -333,6 +335,7 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
+		plat_extra_sync_for_cpu_sg(dev, sg, direction);
 		if (cpu_is_noncoherent_r10000(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
-- 
1.7.0.4
