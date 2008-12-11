Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:46:58 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44843 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207776AbYLKXku (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:40:50 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a3d30000>; Thu, 11 Dec 2008 18:35:52 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:54 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:54 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBBNXngD031927;
	Thu, 11 Dec 2008 15:33:49 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBBNXnDn031926;
	Thu, 11 Dec 2008 15:33:49 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 18/20] MIPS: Adjust the dma-common.c platform hooks.
Date:	Thu, 11 Dec 2008 15:33:36 -0800
Message-Id: <1229038418-31833-18-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4941A2F5.1010202@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
X-OriginalArrivalTime: 11 Dec 2008 23:33:54.0551 (UTC) FILETIME=[EE4FB070:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Cavium OCTEON CPU support, requires a couple of additional hooks in
dem-default.c

We add a dev parameter to plat_unmap_dma_mem(), and hooks for
plat_dma_supported() and plat_extra_sync_for_device() which should be
nop changes for all existing targets.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mach-generic/dma-coherence.h |   26 +++++++++++++++++++-
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |   26 +++++++++++++++++++-
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |   26 +++++++++++++++++++-
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |   26 +++++++++++++++++++-
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   26 +++++++++++++++++++-
 arch/mips/mm/dma-default.c                         |   25 +++++++-----------
 6 files changed, 135 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 76e04e7..36c611b 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -28,10 +28,34 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr;
 }
 
-static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 {
 }
 
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 static inline int plat_device_is_coherent(struct device *dev)
 {
 #ifdef CONFIG_DMA_COHERENT
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index ed7e622..4c21bfc 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -38,10 +38,34 @@ static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr & ~(0xffUL << 56);
 }
 
-static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 {
 }
 
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 1;		/* IP27 non-cohernet mode is unsupported */
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index a5511eb..7ae40f4 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -60,10 +60,34 @@ static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return addr;
 }
 
-static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 {
 }
 
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;		/* IP32 is non-cohernet */
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index d66979a..1c7cd27 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -27,11 +27,35 @@ static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return vdma_log2phys(dma_addr);
 }
 
-static void plat_unmap_dma_mem(dma_addr_t dma_addr)
+static void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 {
 	vdma_free(dma_addr);
 }
 
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;
diff --git a/arch/mips/include/asm/mach-lemote/dma-coherence.h b/arch/mips/include/asm/mach-lemote/dma-coherence.h
index 7e91477..38fad7d 100644
--- a/arch/mips/include/asm/mach-lemote/dma-coherence.h
+++ b/arch/mips/include/asm/mach-lemote/dma-coherence.h
@@ -30,10 +30,34 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr & 0x7fffffff;
 }
 
-static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 {
 }
 
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 static inline int plat_device_is_coherent(struct device *dev)
 {
 	return 0;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e6708b3..546e697 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(dma_alloc_coherent);
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
-	plat_unmap_dma_mem(dma_handle);
+	plat_unmap_dma_mem(dev, dma_handle);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -122,7 +122,7 @@ void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	unsigned long addr = (unsigned long) vaddr;
 
-	plat_unmap_dma_mem(dma_handle);
+	plat_unmap_dma_mem(dev, dma_handle);
 
 	if (!plat_device_is_coherent(dev))
 		addr = CAC_ADDR(addr);
@@ -173,7 +173,7 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 		__dma_sync(dma_addr_to_virt(dma_addr), size,
 		           direction);
 
-	plat_unmap_dma_mem(dma_addr);
+	plat_unmap_dma_mem(dev, dma_addr);
 }
 
 EXPORT_SYMBOL(dma_unmap_single);
@@ -229,7 +229,7 @@ void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 		dma_cache_wback_inv(addr, size);
 	}
 
-	plat_unmap_dma_mem(dma_address);
+	plat_unmap_dma_mem(dev, dma_address);
 }
 
 EXPORT_SYMBOL(dma_unmap_page);
@@ -249,7 +249,7 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 			if (addr)
 				__dma_sync(addr, sg->length, direction);
 		}
-		plat_unmap_dma_mem(sg->dma_address);
+		plat_unmap_dma_mem(dev, sg->dma_address);
 	}
 }
 
@@ -275,6 +275,7 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 {
 	BUG_ON(direction == DMA_NONE);
 
+	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
 
@@ -305,6 +306,7 @@ void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 {
 	BUG_ON(direction == DMA_NONE);
 
+	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
 
@@ -351,22 +353,14 @@ EXPORT_SYMBOL(dma_sync_sg_for_device);
 
 int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
-	return 0;
+	return plat_dma_mapping_error(dev, dma_addr);
 }
 
 EXPORT_SYMBOL(dma_mapping_error);
 
 int dma_supported(struct device *dev, u64 mask)
 {
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
+	return plat_dma_supported(dev, mask);
 }
 
 EXPORT_SYMBOL(dma_supported);
@@ -383,6 +377,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 {
 	BUG_ON(direction == DMA_NONE);
 
+	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev))
 		__dma_sync((unsigned long)vaddr, size, direction);
 }
-- 
1.5.6.5
