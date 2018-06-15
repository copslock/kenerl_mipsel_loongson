Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:17:23 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeFOLKF63wqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:10:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=INiFf7vji0iLGbwW+dAujo5fzv9PWOg83uloOSculcg=; b=cmit0ynZTo4MUwoDrAn4Vb7Rp
        GtDQwEUoKiuvdw9z9AbFx4+6P4s289Oj2IJJtuN3yjr+uf7uGMB+WU+MgCzpWMpFySbxepytb5G17
        6YHBTcFc62A3EUT2KxqrOPcYcrnJ1Wvwv4WpPEl+z0oVdzGase4nGN08otdo3VvZtWwSY2pjzPCLS
        pXsp7rmflM2VPl/p5akzgV15Xwq/604oq3ThyD2oDNma/u8pv4aQ+03mOFO28AUHu5LbDqIb+Qs6a
        addAs8Vc7pSNsvyWkfx6p5c6kVVY0aWMng2b91BGve9e4pFAvSIuhkYrxsPg9WYGkDm4I+GFDREk0
        Lk/Jq6Y2w==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmcE-0005IZ-SB; Fri, 15 Jun 2018 11:10:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: [PATCH 19/25] MIPS: IP32: use generic dma noncoherent ops
Date:   Fri, 15 Jun 2018 13:08:48 +0200
Message-Id: <20180615110854.19253-20-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64300
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

Provide phys_to_dma/dma_to_phys helpers, everything else is generic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                             |  2 +-
 .../include/asm/mach-ip32/dma-coherence.h     | 92 -------------------
 arch/mips/sgi-ip32/Makefile                   |  2 +-
 arch/mips/sgi-ip32/ip32-dma.c                 | 37 ++++++++
 4 files changed, 39 insertions(+), 94 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ip32/dma-coherence.h
 create mode 100644 arch/mips/sgi-ip32/ip32-dma.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e192e484b1b8..8e84d14c17fe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -725,6 +725,7 @@ config SGI_IP28
 
 config SGI_IP32
 	bool "SGI IP32 (O2)"
+	select ARCH_HAS_PHYS_TO_DMA
 	select FW_ARC
 	select FW_ARC32
 	select BOOT_ELF32
@@ -733,7 +734,6 @@ config SGI_IP32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select R5000_CPU_SCACHE
 	select RM7000_CPU_SCACHE
 	select SYS_HAS_CPU_R5000
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
deleted file mode 100644
index 7bdf212587a0..000000000000
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- *
- */
-#ifndef __ASM_MACH_IP32_DMA_COHERENCE_H
-#define __ASM_MACH_IP32_DMA_COHERENCE_H
-
-#include <asm/ip32/crime.h>
-
-struct device;
-
-/*
- * Few notes.
- * 1. CPU sees memory as two chunks: 0-256M@0x0, and the rest @0x40000000+256M
- * 2. PCI sees memory as one big chunk @0x0 (or we could use 0x40000000 for
- *    native-endian)
- * 3. All other devices see memory as one big chunk at 0x40000000
- * 4. Non-PCI devices will pass NULL as struct device*
- *
- * Thus we translate differently, depending on device.
- */
-
-#define RAM_OFFSET_MASK 0x3fffffffUL
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-	size_t size)
-{
-	dma_addr_t pa = virt_to_phys(addr) & RAM_OFFSET_MASK;
-
-	if (dev == NULL)
-		pa += CRIME_HI_MEM_BASE;
-
-	return pa;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	dma_addr_t pa;
-
-	pa = page_to_phys(page) & RAM_OFFSET_MASK;
-
-	if (dev == NULL)
-		pa += CRIME_HI_MEM_BASE;
-
-	return pa;
-}
-
-/* This is almost certainly wrong but it's what dma-ip32.c used to use	*/
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	unsigned long addr = dma_addr & RAM_OFFSET_MASK;
-
-	if (dma_addr >= 256*1024*1024)
-		addr += CRIME_HI_MEM_BASE;
-
-	return addr;
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;		/* IP32 is non-coherent */
-}
-
-#endif /* __ASM_MACH_IP32_DMA_COHERENCE_H */
diff --git a/arch/mips/sgi-ip32/Makefile b/arch/mips/sgi-ip32/Makefile
index 60f0227425e7..4745cd94df11 100644
--- a/arch/mips/sgi-ip32/Makefile
+++ b/arch/mips/sgi-ip32/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-y	+= ip32-berr.o ip32-irq.o ip32-platform.o ip32-setup.o ip32-reset.o \
-	   crime.o ip32-memory.o
+	   crime.o ip32-memory.o ip32-dma.o
diff --git a/arch/mips/sgi-ip32/ip32-dma.c b/arch/mips/sgi-ip32/ip32-dma.c
new file mode 100644
index 000000000000..fa7b17cb5385
--- /dev/null
+++ b/arch/mips/sgi-ip32/ip32-dma.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <linux/dma-direct.h>
+#include <asm/ip32/crime.h>
+
+/*
+ * Few notes.
+ * 1. CPU sees memory as two chunks: 0-256M@0x0, and the rest @0x40000000+256M
+ * 2. PCI sees memory as one big chunk @0x0 (or we could use 0x40000000 for
+ *    native-endian)
+ * 3. All other devices see memory as one big chunk at 0x40000000
+ * 4. Non-PCI devices will pass NULL as struct device*
+ *
+ * Thus we translate differently, depending on device.
+ */
+
+#define RAM_OFFSET_MASK 0x3fffffffUL
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	dma_addr_t dma_addr = paddr & RAM_OFFSET_MASK;
+
+	if (!dev)
+		dma_addr += CRIME_HI_MEM_BASE;
+	return dma_addr;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	phys_addr_t paddr = dma_addr & RAM_OFFSET_MASK;
+
+	if (dma_addr >= 256*1024*1024)
+		paddr += CRIME_HI_MEM_BASE;
+	return paddr;
+}
-- 
2.17.1
