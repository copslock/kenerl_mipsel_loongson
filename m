Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:13:59 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:35979 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994649AbeAJICRwG0CS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:02:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bumtw9yl/qZRv2qatXl7i98vr3DEzCFqYajzLY3Ep1M=; b=S/P3JLhW4BMwy3qbRgfXNA4ch
        pFD5UirDQPn1II4pXQpnPKTrxIo4UvPZLjKCLo1WsBqwvs/aqZOhcbXm+lvtC5RHAVna/4mx7c4I2
        TMXqxtsgcTSyNMejcbkQ4zbagAjz3T53dUMgAjivnf0b02fMmzsNEt1jtU1PXCx05bwC0ZNR3i9Ml
        xvfShMXC7mMEGbfjKqy3iJvW3BCwUZWFbE1dovqj8Pwd4ii2OiKW/aDScKFen5hafU9htM/WQ781w
        pi48q0OjYfxiJvTADLpvEraeO5Y4CLBANWLAKvbo306aPHTJcI1bkngDMJW8f5cShiiLX6Q3u2kRD
        XKTIwyVDQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBKo-0005y2-NV; Wed, 10 Jan 2018 08:02:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/33] cris: use dma-direct
Date:   Wed, 10 Jan 2018 09:00:26 +0100
Message-Id: <20180110080027.13879-33-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61997
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

cris currently has an incomplete direct mapping dma_map_ops implementation
is PCI support is enabled.  Replace it with the fully feature generic
dma-direct implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 arch/cris/Kconfig                       |  4 ++
 arch/cris/arch-v32/drivers/pci/Makefile |  2 +-
 arch/cris/arch-v32/drivers/pci/dma.c    | 77 ---------------------------------
 arch/cris/include/asm/Kbuild            |  1 +
 arch/cris/include/asm/dma-mapping.h     | 20 ---------
 5 files changed, 6 insertions(+), 98 deletions(-)
 delete mode 100644 arch/cris/arch-v32/drivers/pci/dma.c
 delete mode 100644 arch/cris/include/asm/dma-mapping.h

diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 54d3f426763b..cd5a0865c97f 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -33,6 +33,9 @@ config GENERIC_CALIBRATE_DELAY
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
+config NO_DMA
+	def_bool y if !PCI
+
 config FORCE_MAX_ZONEORDER
 	int
 	default 6
@@ -72,6 +75,7 @@ config CRIS
 	select GENERIC_SCHED_CLOCK if ETRAX_ARCH_V32
 	select HAVE_DEBUG_BUGVERBOSE if ETRAX_ARCH_V32
 	select HAVE_NMI
+	select DMA_DIRECT_OPS if PCI
 
 config HZ
 	int
diff --git a/arch/cris/arch-v32/drivers/pci/Makefile b/arch/cris/arch-v32/drivers/pci/Makefile
index bff7482f2444..93c8be6170b1 100644
--- a/arch/cris/arch-v32/drivers/pci/Makefile
+++ b/arch/cris/arch-v32/drivers/pci/Makefile
@@ -2,4 +2,4 @@
 # Makefile for Etrax cardbus driver
 #
 
-obj-$(CONFIG_ETRAX_CARDBUS)        += bios.o dma.o
+obj-$(CONFIG_ETRAX_CARDBUS)        += bios.o
diff --git a/arch/cris/arch-v32/drivers/pci/dma.c b/arch/cris/arch-v32/drivers/pci/dma.c
deleted file mode 100644
index 8c3802244ef3..000000000000
--- a/arch/cris/arch-v32/drivers/pci/dma.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Dynamic DMA mapping support.
- *
- * On cris there is no hardware dynamic DMA address translation,
- * so consistent alloc/free are merely page allocation/freeing.
- * The rest of the dynamic DMA mapping interface is implemented
- * in asm/pci.h.
- *
- * Borrowed from i386.
- */
-
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <linux/gfp.h>
-#include <asm/io.h>
-
-static void *v32_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-	void *ret;
-
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
-
-	ret = (void *)__get_free_pages(gfp,  get_order(size));
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
-	}
-	return ret;
-}
-
-static void v32_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static inline dma_addr_t v32_dma_map_page(struct device *dev,
-		struct page *page, unsigned long offset, size_t size,
-		enum dma_data_direction direction, unsigned long attrs)
-{
-	return page_to_phys(page) + offset;
-}
-
-static inline int v32_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	printk("Map sg\n");
-	return nents;
-}
-
-static inline int v32_dma_supported(struct device *dev, u64 mask)
-{
-        /*
-         * we fall back to GFP_DMA when the mask isn't all 1s,
-         * so we can't guarantee allocations that must be
-         * within a tighter range than GFP_DMA..
-         */
-        if (mask < 0x00ffffff)
-                return 0;
-	return 1;
-}
-
-const struct dma_map_ops v32_dma_ops = {
-	.alloc			= v32_dma_alloc,
-	.free			= v32_dma_free,
-	.map_page		= v32_dma_map_page,
-	.map_sg                 = v32_dma_map_sg,
-	.dma_supported		= v32_dma_supported,
-};
-EXPORT_SYMBOL(v32_dma_ops);
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 460349cb147f..8cf45ac30c1b 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += cmpxchg.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/cris/include/asm/dma-mapping.h b/arch/cris/include/asm/dma-mapping.h
deleted file mode 100644
index 1553bdb30a0c..000000000000
--- a/arch/cris/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_CRIS_DMA_MAPPING_H
-#define _ASM_CRIS_DMA_MAPPING_H
-
-#ifdef CONFIG_PCI
-extern const struct dma_map_ops v32_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &v32_dma_ops;
-}
-#else
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	BUG();
-	return NULL;
-}
-#endif
-
-#endif
-- 
2.14.2
