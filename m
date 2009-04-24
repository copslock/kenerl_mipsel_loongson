Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 02:42:00 +0100 (BST)
Received: from [65.98.92.6] ([65.98.92.6]:18952 "EHLO b32.net")
	by ftp.linux-mips.org with ESMTP id S20021959AbZDXBlv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 02:41:51 +0100
Received: (qmail 22971 invoked from network); 24 Apr 2009 01:41:48 -0000
Received: from softdnserror (HELO two) (127.0.0.1)
  by softdnserror with SMTP; 24 Apr 2009 01:41:48 -0000
Received: by two (sSMTP sendmail emulation); Thu, 23 Apr 2009 18:41:08 -0700
Message-Id: <5c7b8b1a0a84568adda890e80355f45211fd4727.1240533480.git@localhost>
In-Reply-To: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
References: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
From:	Kevin Cernekee <cernekee@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:	Thu, 23 Apr 2009 17:25:12 -0700
Subject: [PATCH 2/3] MIPS: Pass struct device to plat_dma_addr_to_phys()
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22452
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
 arch/mips/mm/dma-default.c                         |   15 ++++++++-------
 7 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 7289e67..17d5794 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -30,7 +30,8 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 	return octeon_map_dma_mem(dev, page_address(page), PAGE_SIZE);
 }
 
-static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
 {
 	return dma_addr;
 }
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 804c2de..8da9807 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -23,7 +23,8 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 	return page_to_phys(page);
 }
 
-static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
 {
 	return dma_addr;
 }
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index 8676673..d3d0401 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -33,7 +33,8 @@ static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 	return pa;
 }
 
-static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+static unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
 {
 	return dma_addr & ~(0xffUL << 56);
 }
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index d41805e..3785595 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -50,7 +50,8 @@ static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 }
 
 /* This is almost certainly wrong but it's what dma-ip32.c used to use  */
-static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+static unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
 {
 	unsigned long addr = dma_addr & RAM_OFFSET_MASK;
 
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index 5f3d7ea..f93aee5 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -22,7 +22,8 @@ static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
 }
 
-static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+static unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
 {
 	return vdma_log2phys(dma_addr);
 }
diff --git a/arch/mips/include/asm/mach-lemote/dma-coherence.h b/arch/mips/include/asm/mach-lemote/dma-coherence.h
index c78f1d8..c8de5e7 100644
--- a/arch/mips/include/asm/mach-lemote/dma-coherence.h
+++ b/arch/mips/include/asm/mach-lemote/dma-coherence.h
@@ -25,7 +25,8 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 	return page_to_phys(page) | 0x80000000;
 }
 
-static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
 {
 	return dma_addr & 0x7fffffff;
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 30b108c..7e48e76 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -20,9 +20,10 @@
 
 #include <dma-coherence.h>
 
-static inline unsigned long dma_addr_to_virt(dma_addr_t dma_addr)
+static inline unsigned long dma_addr_to_virt(struct device *dev,
+	dma_addr_t dma_addr)
 {
-	unsigned long addr = plat_dma_addr_to_phys(dma_addr);
+	unsigned long addr = plat_dma_addr_to_phys(dev, dma_addr);
 
 	return (unsigned long)phys_to_virt(addr);
 }
@@ -170,7 +171,7 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 	enum dma_data_direction direction)
 {
 	if (cpu_is_noncoherent_r10000(dev))
-		__dma_sync(dma_addr_to_virt(dma_addr), size,
+		__dma_sync(dma_addr_to_virt(dev, dma_addr), size,
 		           direction);
 
 	plat_unmap_dma_mem(dev, dma_addr, size, direction);
@@ -246,7 +247,7 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	if (cpu_is_noncoherent_r10000(dev)) {
 		unsigned long addr;
 
-		addr = dma_addr_to_virt(dma_handle);
+		addr = dma_addr_to_virt(dev, dma_handle);
 		__dma_sync(addr, size, direction);
 	}
 }
@@ -262,7 +263,7 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
 
-		addr = dma_addr_to_virt(dma_handle);
+		addr = dma_addr_to_virt(dev, dma_handle);
 		__dma_sync(addr, size, direction);
 	}
 }
@@ -277,7 +278,7 @@ void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	if (cpu_is_noncoherent_r10000(dev)) {
 		unsigned long addr;
 
-		addr = dma_addr_to_virt(dma_handle);
+		addr = dma_addr_to_virt(dev, dma_handle);
 		__dma_sync(addr + offset, size, direction);
 	}
 }
@@ -293,7 +294,7 @@ void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
 
-		addr = dma_addr_to_virt(dma_handle);
+		addr = dma_addr_to_virt(dev, dma_handle);
 		__dma_sync(addr + offset, size, direction);
 	}
 }
-- 
1.5.3.6
