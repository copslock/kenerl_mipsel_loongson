Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:22:48 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:40646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994632AbeAJIKk1TbeS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DHcBWcNEKcDOGecpqthIPivQz5mhze0o77ZrI7OEQE8=; b=YsNa/ip0I4IDEmjLESEUWtC7F
        8LoUuhHMkN7TjDSCWZMF5GhszGbuKAwWYGeS8fIh0MIEdXWagaEKsNRt+szLfMtuePmke/5M1l/IQ
        DsNplWcOGgTRMdf8GRGeTCb+lXYuATANghhFv5b/q8DhkOuBhc7NPWH+JMFZoI8B1VWECtA4k/oYj
        4XCa6tNUIxv/0RuS9ZPSzF0Ois0FxA7EAVJ/MW2jOCEXeBQzNdpJrVPqcAHHzrnYHnOrBAHWg+Qxy
        9HO52Pppz6GLHczuL8ezxrOie1seOYXhspnFRFAqJhnnWv1LGhBG5jsTq6s0401wf5Y5wkmFCTF6o
        0RZ7Fspgw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSw-0000gO-2N; Wed, 10 Jan 2018 08:10:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/22] mips/netlogic: remove swiotlb support
Date:   Wed, 10 Jan 2018 09:09:29 +0100
Message-Id: <20180110080932.14157-20-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62018
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

nlm_swiotlb_dma_ops is unused code, so the whole swiotlb support is dead.
If it gets resurrected at some point it should use the generic
swiotlb_dma_ops instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/netlogic/common.h |  3 --
 arch/mips/netlogic/Kconfig              |  5 --
 arch/mips/netlogic/common/Makefile      |  1 -
 arch/mips/netlogic/common/nlm-dma.c     | 94 ---------------------------------
 4 files changed, 103 deletions(-)
 delete mode 100644 arch/mips/netlogic/common/nlm-dma.c

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index a6e6cbebe046..57616649b4f3 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -87,9 +87,6 @@ unsigned int nlm_get_cpu_frequency(void);
 extern const struct plat_smp_ops nlm_smp_ops;
 extern char nlm_reset_entry[], nlm_reset_entry_end[];
 
-/* SWIOTLB */
-extern const struct dma_map_ops nlm_swiotlb_dma_ops;
-
 extern unsigned int nlm_threads_per_core;
 extern cpumask_t nlm_cpumask;
 
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 8296b13affd2..7fcfc7fe9f14 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -89,9 +89,4 @@ config IOMMU_HELPER
 config NEED_SG_DMA_LENGTH
 	bool
 
-config SWIOTLB
-	def_bool y
-	select NEED_SG_DMA_LENGTH
-	select IOMMU_HELPER
-
 endif
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index 60d00b5d748e..89f6e3f39fed 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y				+= irq.o time.o
-obj-y				+= nlm-dma.o
 obj-y				+= reset.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
deleted file mode 100644
index 49c975b6aa28..000000000000
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
-*  Copyright (C) 2003-2013 Broadcom Corporation
-*  All Rights Reserved
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the Broadcom
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-#include <linux/dma-mapping.h>
-#include <linux/scatterlist.h>
-#include <linux/bootmem.h>
-#include <linux/export.h>
-#include <linux/swiotlb.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-
-#include <asm/bootinfo.h>
-
-static char *nlm_swiotlb;
-
-static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-#ifdef CONFIG_ZONE_DMA32
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
-		gfp |= __GFP_DMA32;
-#endif
-
-	/* Don't invoke OOM killer */
-	gfp |= __GFP_NORETRY;
-
-	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
-}
-
-static void nlm_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
-const struct dma_map_ops nlm_swiotlb_dma_ops = {
-	.alloc = nlm_dma_alloc_coherent,
-	.free = nlm_dma_free_coherent,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = swiotlb_dma_supported
-};
-
-void __init plat_swiotlb_setup(void)
-{
-	size_t swiotlbsize;
-	unsigned long swiotlb_nslabs;
-
-	swiotlbsize = 1 << 20; /* 1 MB for now */
-	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
-	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
-	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
-
-	nlm_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
-	swiotlb_init_with_tbl(nlm_swiotlb, swiotlb_nslabs, 1);
-}
-- 
2.14.2
