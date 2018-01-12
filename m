Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 10:05:54 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:36621 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994642AbeALIpyg95mJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:45:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qLMBnGBgqkewwHo8PqZ7pyXUSA8cUYYRLu7htx6D/Ks=; b=W6zOe300tB9k5M2knvwcwRqst
        8ygWoQ2QRvG0qRpBmlNVxpxHpelLy+6AF3h+IL7AfXXhQ+JGjF+5Aejp55BlOVA0c4vB08cOdZtFy
        P+ocRW+jpZjFrYk28tiPmZAKK/swkDlXnk2jFxfG8ujDXOIeeTEpq4A4x/U6WXRaO4BbCjk90Dz5M
        QZZp5txBZxVwzDFHqIOGv0YlINMzdQW7B7SGTMMCLEk7L8+0UvGfUX/VnCQAr6VVzj4xRM+8XZuDE
        kQA6bWn8mM0siYVMgcfq/sBvpeeN2Ovi3M25Rb85PSokpZW+EM3bWkDe80coW+wHkoWPBuAgzODGC
        qb7CH6usQ==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuwn-0000TB-Dh; Fri, 12 Jan 2018 08:44:21 +0000
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
Subject: [PATCH 34/34] h8300: use dma-direct
Date:   Fri, 12 Jan 2018 09:42:32 +0100
Message-Id: <20180112084232.2857-35-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62096
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

Replace the bare-bones h8300 direct dma mapping implementation with
the fully featured generic dma-direct one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/h8300/Kconfig                   |  1 +
 arch/h8300/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/dma-mapping.h | 12 -------
 arch/h8300/kernel/Makefile           |  2 +-
 arch/h8300/kernel/dma.c              | 66 ------------------------------------
 5 files changed, 3 insertions(+), 79 deletions(-)
 delete mode 100644 arch/h8300/include/asm/dma-mapping.h
 delete mode 100644 arch/h8300/kernel/dma.c

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index f8d3fde08190..091d6d04b5e5 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -23,6 +23,7 @@ config H8300
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
+	select DMA_DIRECT_OPS
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index bc077491d299..642752c94306 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += delay.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/h8300/include/asm/dma-mapping.h b/arch/h8300/include/asm/dma-mapping.h
deleted file mode 100644
index 21bb1fc3a6f1..000000000000
--- a/arch/h8300/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _H8300_DMA_MAPPING_H
-#define _H8300_DMA_MAPPING_H
-
-extern const struct dma_map_ops h8300_dma_map_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &h8300_dma_map_ops;
-}
-
-#endif
diff --git a/arch/h8300/kernel/Makefile b/arch/h8300/kernel/Makefile
index b62e830525c6..307aa51576dd 100644
--- a/arch/h8300/kernel/Makefile
+++ b/arch/h8300/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y := vmlinux.lds
 
 obj-y := process.o traps.o ptrace.o \
 	 signal.o setup.o syscalls.o \
-	 irq.o entry.o dma.o
+	 irq.o entry.o
 
 obj-$(CONFIG_ROMKERNEL) += head_rom.o
 obj-$(CONFIG_RAMKERNEL) += head_ram.o
diff --git a/arch/h8300/kernel/dma.c b/arch/h8300/kernel/dma.c
deleted file mode 100644
index d44ba5db4ac3..000000000000
--- a/arch/h8300/kernel/dma.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/kernel.h>
-#include <linux/scatterlist.h>
-#include <linux/module.h>
-#include <asm/pgalloc.h>
-
-static void *dma_alloc(struct device *dev, size_t size,
-		       dma_addr_t *dma_handle, gfp_t gfp,
-		       unsigned long attrs)
-{
-	void *ret;
-
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
-	}
-	return ret;
-}
-
-static void dma_free(struct device *dev, size_t size,
-		     void *vaddr, dma_addr_t dma_handle,
-		     unsigned long attrs)
-
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static dma_addr_t map_page(struct device *dev, struct page *page,
-				  unsigned long offset, size_t size,
-				  enum dma_data_direction direction,
-				  unsigned long attrs)
-{
-	return page_to_phys(page) + offset;
-}
-
-static int map_sg(struct device *dev, struct scatterlist *sgl,
-		  int nents, enum dma_data_direction direction,
-		  unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg);
-	}
-
-	return nents;
-}
-
-const struct dma_map_ops h8300_dma_map_ops = {
-	.alloc = dma_alloc,
-	.free = dma_free,
-	.map_page = map_page,
-	.map_sg = map_sg,
-};
-EXPORT_SYMBOL(h8300_dma_map_ops);
-- 
2.14.2
