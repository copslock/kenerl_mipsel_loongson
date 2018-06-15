Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:17:06 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994672AbeFOLKCUQihT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:10:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hqQ+2LS2dqNGFQxATNLhqYjxsns6lRNl2MBylDlnqUE=; b=BobmVxDYJoOrFV9wjKPw3tog1
        OKHHhvr5Ndb7XRknZ9GiBdD/tMlHXnJmtMJkjJysttAjhAijhgxpDojiFtN1D/XjuDgCORKQ21Tuo
        TPNlT1ttAMbr+D9poC5kxqbcfHwUy300EO8WyKctitiFta7zDwtgXTNWJkeS8FL2bttV+2jcyGWKi
        ZA+dF8dAcanae2ltQ6LD8ioHw504qNAcqoGwmP1Gu8M4MZAXDGa6nbmL2Xq1fyeNS/EvJlqHSlUxw
        af1EdAv0LMXDFG7wx1gTwQPnXR1DWeHU9EwWVyzlss3+OWTQEk+ttkK6skku26h5782QH+oFdG3dZ
        d96fSgR9A==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmcB-0005HN-Jj; Fri, 15 Jun 2018 11:10:00 +0000
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
Subject: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Date:   Fri, 15 Jun 2018 13:08:47 +0200
Message-Id: <20180615110854.19253-19-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64299
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
 arch/mips/Kconfig                             |  1 +
 .../asm/mach-loongson64/dma-coherence.h       | 69 -------------------
 arch/mips/loongson64/Kconfig                  |  2 -
 arch/mips/loongson64/common/Makefile          |  1 +
 arch/mips/loongson64/common/dma.c             | 16 +++++
 5 files changed, 18 insertions(+), 71 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson64/dma-coherence.h
 create mode 100644 arch/mips/loongson64/common/dma.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 326bd73bc5bf..e192e484b1b8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1827,6 +1827,7 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select ARCH_HAS_PHYS_TO_DMA
 
 config CPU_LOONGSON1
 	bool
diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
deleted file mode 100644
index 651dd2eb3ee5..000000000000
--- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006, 07  Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- */
-#ifndef __ASM_MACH_LOONGSON64_DMA_COHERENCE_H
-#define __ASM_MACH_LOONGSON64_DMA_COHERENCE_H
-
-#ifdef CONFIG_SWIOTLB
-#include <linux/swiotlb.h>
-#endif
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-					  size_t size)
-{
-	return virt_to_phys(addr) | 0x80000000;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-					       struct page *page)
-{
-	return page_to_phys(page) | 0x80000000;
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
-	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
-#else
-	return dma_addr & 0x7fffffff;
-#endif
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
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-#endif /* __ASM_MACH_LOONGSON64_DMA_COHERENCE_H */
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index a785bf8da3f3..c865b4b9b775 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -13,7 +13,6 @@ config LEMOTE_FULOONG2E
 	select CSRC_R4K
 	select SYS_HAS_CPU_LOONGSON2E
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select BOARD_SCACHE
 	select HW_HAS_PCI
@@ -45,7 +44,6 @@ config LEMOTE_MACH2F
 	select CS5536
 	select CSRC_R4K if ! MIPS_EXTERNAL_TIMER
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select HAVE_CLK
 	select HW_HAS_PCI
diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index 684624f61f5a..57ee03022941 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -6,6 +6,7 @@
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
     bonito-irq.o mem.o machtype.o platform.o serial.o
 obj-$(CONFIG_PCI) += pci.o
+obj-$(CONFIG_CPU_LOONGSON2) += dma.o
 
 #
 # Serial port support
diff --git a/arch/mips/loongson64/common/dma.c b/arch/mips/loongson64/common/dma.c
new file mode 100644
index 000000000000..95ede4b0fbbb
--- /dev/null
+++ b/arch/mips/loongson64/common/dma.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-direct.h>
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr | 0x80000000;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+	if (dma_addr > 0x8fffffff)
+		return dma_addr;
+#endif
+	return dma_addr & 0x0fffffff;
+}
-- 
2.17.1
