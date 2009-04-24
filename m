Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 02:41:06 +0100 (BST)
Received: from [65.98.92.6] ([65.98.92.6]:17672 "EHLO b32.net")
	by ftp.linux-mips.org with ESMTP id S20021956AbZDXBk5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 02:40:57 +0100
Received: (qmail 22954 invoked from network); 24 Apr 2009 01:40:55 -0000
Received: from softdnserror (HELO two) (127.0.0.1)
  by softdnserror with SMTP; 24 Apr 2009 01:40:55 -0000
Received: by two (sSMTP sendmail emulation); Thu, 23 Apr 2009 18:40:14 -0700
Message-Id: <0483452db22e72f57289e63fcf097120d94c2a73.1240533480.git@localhost>
In-Reply-To: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
References: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
From:	Kevin Cernekee <cernekee@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:	Thu, 23 Apr 2009 17:03:43 -0700
Subject: [PATCH 1/3] MIPS: Add size and direction arguments to plat_unmap_dma_mem()
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../include/asm/mach-cavium-octeon/dma-coherence.h |    3 ++-
 arch/mips/include/asm/mach-generic/dma-coherence.h |    3 ++-
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |    3 ++-
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |    3 ++-
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |    3 ++-
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |    3 ++-
 arch/mips/mm/dma-default.c                         |    8 ++++----
 7 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index f30fce9..7289e67 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -35,7 +35,8 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr;
 }
 
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
 {
 	octeon_unmap_dma_mem(dev, dma_addr);
 }
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 36c611b..804c2de 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -28,7 +28,8 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr;
 }
 
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
 {
 }
 
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index 4c21bfc..8676673 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -38,7 +38,8 @@ static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr & ~(0xffUL << 56);
 }
 
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
 {
 }
 
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 7ae40f4..d41805e 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -60,7 +60,8 @@ static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return addr;
 }
 
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
 {
 }
 
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index 1c7cd27..5f3d7ea 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -27,7 +27,8 @@ static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return vdma_log2phys(dma_addr);
 }
 
-static void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+static void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
 {
 	vdma_free(dma_addr);
 }
diff --git a/arch/mips/include/asm/mach-lemote/dma-coherence.h b/arch/mips/include/asm/mach-lemote/dma-coherence.h
index 38fad7d..c78f1d8 100644
--- a/arch/mips/include/asm/mach-lemote/dma-coherence.h
+++ b/arch/mips/include/asm/mach-lemote/dma-coherence.h
@@ -30,7 +30,8 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr & 0x7fffffff;
 }
 
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
 {
 }
 
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 4fdb7f5..30b108c 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(dma_alloc_coherent);
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
-	plat_unmap_dma_mem(dev, dma_handle);
+	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -122,7 +122,7 @@ void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	unsigned long addr = (unsigned long) vaddr;
 
-	plat_unmap_dma_mem(dev, dma_handle);
+	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
 	if (!plat_device_is_coherent(dev))
 		addr = CAC_ADDR(addr);
@@ -173,7 +173,7 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 		__dma_sync(dma_addr_to_virt(dma_addr), size,
 		           direction);
 
-	plat_unmap_dma_mem(dev, dma_addr);
+	plat_unmap_dma_mem(dev, dma_addr, size, direction);
 }
 
 EXPORT_SYMBOL(dma_unmap_single);
@@ -232,7 +232,7 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 			if (addr)
 				__dma_sync(addr, sg->length, direction);
 		}
-		plat_unmap_dma_mem(dev, sg->dma_address);
+		plat_unmap_dma_mem(dev, sg->dma_address, sg->length, direction);
 	}
 }
 
-- 
1.5.3.6
