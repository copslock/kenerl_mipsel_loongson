Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Aug 2013 11:29:20 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56690 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865281Ab3HOJ2eFr1lK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Aug 2013 11:28:34 +0200
Received: by nf.lan (Postfix, from userid 501)
        id 7A9AA4FF4DFC; Thu, 15 Aug 2013 11:28:32 +0200 (CEST)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH v3 1/3] MIPS: remove unnecessary platform dma helper functions
Date:   Thu, 15 Aug 2013 11:28:30 +0200
Message-Id: <1376558912-41050-1-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 1.8.0.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

The semantics stay the same - on Cavium Octeon the functions were dead
code (it overrides the MIPS DMA ops) - on other platforms they contained
no code at all.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h | 12 ------------
 arch/mips/include/asm/mach-generic/dma-coherence.h       | 10 ----------
 arch/mips/include/asm/mach-ip27/dma-coherence.h          | 10 ----------
 arch/mips/include/asm/mach-ip32/dma-coherence.h          | 11 -----------
 arch/mips/include/asm/mach-jazz/dma-coherence.h          | 10 ----------
 arch/mips/include/asm/mach-loongson/dma-coherence.h      | 10 ----------
 arch/mips/include/asm/mach-powertv/dma-coherence.h       | 10 ----------
 arch/mips/mm/dma-default.c                               |  4 +---
 8 files changed, 1 insertion(+), 76 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 47fb247..f9f4486 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -52,23 +52,11 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 0;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-	BUG();
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 1;
 }
 
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	BUG();
-	return 0;
-}
-
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
 
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 74cb992..a9e8f6b 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -47,16 +47,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 #ifdef CONFIG_DMA_COHERENT
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index 06c4419..4ffddfd 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -58,16 +58,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 1;		/* IP27 non-cohernet mode is unsupported */
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 073f0c4..104cfbc 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -80,17 +80,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-	return;
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;		/* IP32 is non-cohernet */
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index 9fc1e9a..949003e 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -48,16 +48,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index e143305..aeb2c05 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -53,16 +53,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
index f831672..5d4c3fe 100644
--- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -99,16 +99,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index aaccf1c..63e45d6 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -292,7 +292,6 @@ static void mips_dma_sync_single_for_cpu(struct device *dev,
 static void mips_dma_sync_single_for_device(struct device *dev,
 	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
 			   dma_handle & ~PAGE_MASK, size, direction);
@@ -326,7 +325,7 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
 
 int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
-	return plat_dma_mapping_error(dev, dma_addr);
+	return 0;
 }
 
 int mips_dma_supported(struct device *dev, u64 mask)
@@ -339,7 +338,6 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 {
 	BUG_ON(direction == DMA_NONE);
 
-	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev))
 		__dma_sync_virtual(vaddr, size, direction);
 }
-- 
1.8.0.2
