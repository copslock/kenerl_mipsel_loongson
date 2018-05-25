Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:27:40 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993339AbeEYJWbTDYRA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DdIRCD8nr2l/N7l4rCxzocfF5Bu7bsm90bZsIriDz/U=; b=RCM5NA24/cxZpAkKCaXXxsq+P
        jkhs0syVgh1Cy/t+A82+VB4tMrq5mgdvf5TmeVt/V+NCSkBjTJvbc179uGm8uen04QAizVF3ut0s7
        Dlq3jfn/XlpYJs5UXxZ+Zh8vICoO3r7cULZ/fjYlr4xIgMR6XCbPf5P03TcqwFQj8MB0vaWjMqGkn
        EL4IVTB9LKWZ4NU7IUIILXhtpTWHWLTpK0HuHJ8nAlCoi+NUO3+LrA7iynFIVJRJnrzI/FVPgzVYX
        WteR9pKPvpEw3cfApwbhYW/NQAkq2Jlmj+4KADkaE26Gsw7P6FWZDdAcz4JdX7+iUUnNrBSQ1vuWq
        yWo1mmxPw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vc-00020K-EE; Fri, 25 May 2018 09:22:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 23/25] MIPS: bmips: use generic dma noncoherent ops
Date:   Fri, 25 May 2018 11:21:09 +0200
Message-Id: <20180525092111.18516-24-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64036
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

Provide phys_to_dma/dma_to_phys helpers, and the special
arch_sync_dma_for_cpu_all hook, everything else is generic

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                             |  3 +-
 arch/mips/bmips/dma.c                         | 32 ++++++-----
 arch/mips/include/asm/bmips.h                 | 16 ------
 .../include/asm/mach-bmips/dma-coherence.h    | 54 -------------------
 4 files changed, 21 insertions(+), 84 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-bmips/dma-coherence.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 25a3c3262554..9ac3c6260b68 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -209,6 +209,8 @@ config ATH79
 
 config BMIPS_GENERIC
 	bool "Broadcom Generic BMIPS kernel"
+	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+	select ARCH_HAS_PHYS_TO_DMA
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
@@ -221,7 +223,6 @@ config BMIPS_GENERIC
 	select BCM7120_L2_IRQ
 	select BRCMSTB_L2_IRQ
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 04790f4e1805..02ba0e38748d 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -17,7 +17,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <dma-coherence.h>
+#include <asm/bmips.h>
 
 /*
  * BCM338x has configurable address translation windows which allow the
@@ -40,7 +40,7 @@ static struct bmips_dma_range *bmips_dma_ranges;
 
 #define FLUSH_RAC		0x100
 
-static dma_addr_t bmips_phys_to_dma(struct device *dev, phys_addr_t pa)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
 {
 	struct bmips_dma_range *r;
 
@@ -52,17 +52,7 @@ static dma_addr_t bmips_phys_to_dma(struct device *dev, phys_addr_t pa)
 	return pa;
 }
 
-dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
-{
-	return bmips_phys_to_dma(dev, virt_to_phys(addr));
-}
-
-dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	return bmips_phys_to_dma(dev, page_to_phys(page));
-}
-
-unsigned long plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	struct bmips_dma_range *r;
 
@@ -74,6 +64,22 @@ unsigned long plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
 	return dma_addr;
 }
 
+void arch_sync_dma_for_cpu_all(struct device *dev)
+{
+	void __iomem *cbr = BMIPS_GET_CBR();
+	u32 cfg;
+
+	if (boot_cpu_type() != CPU_BMIPS3300 &&
+	    boot_cpu_type() != CPU_BMIPS4350 &&
+	    boot_cpu_type() != CPU_BMIPS4380)
+		return;
+
+	/* Flush stale data out of the readahead cache */
+	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
+	__raw_readl(cbr + BMIPS_RAC_CONFIG);
+}
+
 static int __init bmips_init_dma_ranges(void)
 {
 	struct device_node *np =
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index b3e2975f83d3..bf6a8afd7ad2 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -123,22 +123,6 @@ static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
 	barrier();
 }
 
-static inline void bmips_post_dma_flush(struct device *dev)
-{
-	void __iomem *cbr = BMIPS_GET_CBR();
-	u32 cfg;
-
-	if (boot_cpu_type() != CPU_BMIPS3300 &&
-	    boot_cpu_type() != CPU_BMIPS4350 &&
-	    boot_cpu_type() != CPU_BMIPS4380)
-		return;
-
-	/* Flush stale data out of the readahead cache */
-	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
-	__raw_readl(cbr + BMIPS_RAC_CONFIG);
-}
-
 #endif /* !defined(__ASSEMBLY__) */
 
 #endif /* _ASM_BMIPS_H */
diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
deleted file mode 100644
index d29781f02285..000000000000
--- a/arch/mips/include/asm/mach-bmips/dma-coherence.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright (C) 2006 Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2009 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#ifndef __ASM_MACH_BMIPS_DMA_COHERENCE_H
-#define __ASM_MACH_BMIPS_DMA_COHERENCE_H
-
-#include <asm/bmips.h>
-#include <asm/cpu-type.h>
-#include <asm/cpu.h>
-
-struct device;
-
-extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
-extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
-extern unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr);
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
-#define plat_post_dma_flush	bmips_post_dma_flush
-
-#endif /* __ASM_MACH_BMIPS_DMA_COHERENCE_H */
-- 
2.17.0
