Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2015 09:11:25 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:40459 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011673AbbHQHKwpv3jg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2015 09:10:52 +0200
Received: from 212095007050.public.telering.at ([212.95.7.50] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZREYb-00021X-0j; Mon, 17 Aug 2015 07:10:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dma-mapping: cosolidate dma_mapping_error
Date:   Mon, 17 Aug 2015 09:06:54 +0200
Message-Id: <1439795216-32189-4-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439795216-32189-1-git-send-email-hch@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+d9386a2b82e844863ec9+4376+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48921
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

Currently there are three valid implementations of dma_mapping_error:

 (1) call ->mapping_error
 (2) check for a hardcoded error code
 (3) always return 0

This patch provides a common implementation that calls ->mapping_error
if present, then checks for DMA_ERROR_CODE if defined or otherwise
returns 0.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/dma-mapping.h      |  5 -----
 arch/arm/include/asm/dma-mapping.h        |  9 ---------
 arch/arm64/include/asm/dma-mapping.h      |  7 -------
 arch/h8300/include/asm/dma-mapping.h      |  5 -----
 arch/hexagon/include/asm/dma-mapping.h    | 11 +----------
 arch/ia64/include/asm/dma-mapping.h       |  7 -------
 arch/microblaze/include/asm/dma-mapping.h | 11 -----------
 arch/mips/include/asm/dma-mapping.h       |  8 --------
 arch/openrisc/include/asm/dma-mapping.h   |  5 -----
 arch/powerpc/include/asm/dma-mapping.h    | 17 ++---------------
 arch/s390/include/asm/dma-mapping.h       | 10 ----------
 arch/sh/include/asm/dma-mapping.h         | 13 ++-----------
 arch/sparc/include/asm/dma-mapping.h      |  6 ------
 arch/tile/include/asm/dma-mapping.h       |  7 -------
 arch/unicore32/include/asm/dma-mapping.h  | 10 ----------
 arch/x86/include/asm/dma-mapping.h        | 11 -----------
 include/asm-generic/dma-mapping-common.h  | 14 ++++++++++++++
 17 files changed, 19 insertions(+), 137 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 0552bf0..80ac3e8 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -12,11 +12,6 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return get_dma_ops(dev)->mapping_error(dev, dma_addr);
-}
-
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return get_dma_ops(dev)->dma_supported(dev, mask);
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 2191f9c..b4f1b6b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -172,15 +172,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline void dma_mark_clean(void *addr, size_t size) { }
 
-/*
- * DMA errors are defined by all-bits-set in the DMA address.
- */
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	debug_dma_mapping_error(dev, dma_addr);
-	return dma_addr == DMA_ERROR_CODE;
-}
-
 extern int dma_supported(struct device *dev, u64 mask);
 
 extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 178e60b..f45f444 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -84,13 +84,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 	return (phys_addr_t)dev_addr;
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dev_addr)
-{
-	struct dma_map_ops *ops = get_dma_ops(dev);
-	debug_dma_mapping_error(dev, dev_addr);
-	return ops->mapping_error(dev, dev_addr);
-}
-
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
diff --git a/arch/h8300/include/asm/dma-mapping.h b/arch/h8300/include/asm/dma-mapping.h
index 72465ce..5eef053 100644
--- a/arch/h8300/include/asm/dma-mapping.h
+++ b/arch/h8300/include/asm/dma-mapping.h
@@ -20,9 +20,4 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 	return 0;
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 #endif
diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 58d2d8f..e661192 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -31,6 +31,7 @@
 
 struct device;
 extern int bad_dma_address;
+#define DMA_ERROR_CODE bad_dma_address
 
 extern struct dma_map_ops *dma_ops;
 
@@ -57,14 +58,4 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops->mapping_error)
-		return dma_ops->mapping_error(dev, dma_addr);
-
-	return (dma_addr == bad_dma_address);
-}
-
 #endif
diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index a925ff0..27b713d 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -27,13 +27,6 @@ extern void machvec_dma_sync_sg(struct device *, struct scatterlist *, int,
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t daddr)
-{
-	struct dma_map_ops *ops = platform_dma_get_ops(dev);
-	debug_dma_mapping_error(dev, daddr);
-	return ops->mapping_error(dev, daddr);
-}
-
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	struct dma_map_ops *ops = platform_dma_get_ops(dev);
diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index bc81625..e5b8438 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -87,17 +87,6 @@ static inline void __dma_sync(unsigned long paddr,
 	}
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *ops = get_dma_ops(dev);
-
-	debug_dma_mapping_error(dev, dma_addr);
-	if (ops->mapping_error)
-		return ops->mapping_error(dev, dma_addr);
-
-	return (dma_addr == DMA_ERROR_CODE);
-}
-
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 709b2ba..158bb36 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -37,14 +37,6 @@ static inline int dma_supported(struct device *dev, u64 mask)
 	return ops->dma_supported(dev, mask);
 }
 
-static inline int dma_mapping_error(struct device *dev, u64 mask)
-{
-	struct dma_map_ops *ops = get_dma_ops(dev);
-
-	debug_dma_mapping_error(dev, mask);
-	return ops->mapping_error(dev, mask);
-}
-
 static inline int
 dma_set_mask(struct device *dev, u64 mask)
 {
diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index 57722528..7dfe9d5 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -43,11 +43,6 @@ static inline int dma_supported(struct device *dev, u64 dma_mask)
 	return dma_mask == DMA_BIT_MASK(32);
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index dec0260..72d05ab 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -18,7 +18,9 @@
 #include <asm/io.h>
 #include <asm/swiotlb.h>
 
+#ifdef CONFIG_PPC64
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
+#endif
 
 /* Some dma direct funcs must be visible for use in other dma_ops */
 extern void *dma_direct_alloc_coherent(struct device *dev, size_t size,
@@ -137,21 +139,6 @@ extern int dma_set_mask(struct device *dev, u64 dma_mask);
 extern int __dma_set_mask(struct device *dev, u64 dma_mask);
 extern u64 __dma_get_required_mask(struct device *dev);
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	debug_dma_mapping_error(dev, dma_addr);
-	if (dma_ops->mapping_error)
-		return dma_ops->mapping_error(dev, dma_addr);
-
-#ifdef CONFIG_PPC64
-	return (dma_addr == DMA_ERROR_CODE);
-#else
-	return 0;
-#endif
-}
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index b729efe..3c29329 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -43,14 +43,4 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	debug_dma_mapping_error(dev, dma_addr);
-	if (dma_ops->mapping_error)
-		return dma_ops->mapping_error(dev, dma_addr);
-	return dma_addr == DMA_ERROR_CODE;
-}
-
 #endif /* _ASM_S390_DMA_MAPPING_H */
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 2c3fa2c..98308c4 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -9,6 +9,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 	return dma_ops;
 }
 
+#define DMA_ERROR_CODE 0
+
 #include <asm-generic/dma-mapping-common.h>
 
 static inline int dma_supported(struct device *dev, u64 mask)
@@ -38,17 +40,6 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction dir);
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *ops = get_dma_ops(dev);
-
-	debug_dma_mapping_error(dev, dma_addr);
-	if (ops->mapping_error)
-		return ops->mapping_error(dev, dma_addr);
-
-	return dma_addr == 0;
-}
-
 /* arch/sh/mm/consistent.c */
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_addr, gfp_t flag,
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 2564edc..5069d13 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -38,12 +38,6 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	debug_dma_mapping_error(dev, dma_addr);
-	return (dma_addr == DMA_ERROR_CODE);
-}
-
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PCI
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index e982dfa..f8f7a05 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -75,13 +75,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 }
 
 static inline int
-dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	debug_dma_mapping_error(dev, dma_addr);
-	return get_dma_ops(dev)->mapping_error(dev, dma_addr);
-}
-
-static inline int
 dma_supported(struct device *dev, u64 mask)
 {
 	return get_dma_ops(dev)->dma_supported(dev, mask);
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 636e942..175d7e3 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -38,16 +38,6 @@ static inline int dma_supported(struct device *dev, u64 mask)
 	return dma_ops->dma_supported(dev, mask);
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops->mapping_error)
-		return dma_ops->mapping_error(dev, dma_addr);
-
-	return 0;
-}
-
 #include <asm-generic/dma-mapping-common.h>
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 7e47e4d..bbca62e 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -45,17 +45,6 @@ bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
 
 #include <asm-generic/dma-mapping-common.h>
 
-/* Make sure we keep the same behaviour */
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	struct dma_map_ops *ops = get_dma_ops(dev);
-	debug_dma_mapping_error(dev, dma_addr);
-	if (ops->mapping_error)
-		return ops->mapping_error(dev, dma_addr);
-
-	return (dma_addr == DMA_ERROR_CODE);
-}
-
 extern int dma_supported(struct device *hwdev, u64 mask);
 extern int dma_set_mask(struct device *dev, u64 mask);
 
diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index ec321dd..cdaa241 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -313,4 +313,18 @@ static inline void dma_free_noncoherent(struct device *dev, size_t size,
 	dma_free_attrs(dev, size, cpu_addr, dma_handle, &attrs);
 }
 
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	debug_dma_mapping_error(dev, dma_addr);
+
+	if (get_dma_ops(dev)->mapping_error)
+		return get_dma_ops(dev)->mapping_error(dev, dma_addr);
+
+#ifdef DMA_ERROR_CODE
+	return dma_addr == DMA_ERROR_CODE;
+#else
+	return 0;
+#endif
+}
+
 #endif
-- 
1.9.1
