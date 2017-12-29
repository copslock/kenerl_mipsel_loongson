Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:30:24 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:58599 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdL2IVRMYFWC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:21:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DHGJJSw/acttBauGb4jSlhDiF/XOuH3SCWat7Ast2xc=; b=sMb7yAHBqCLSJEy63wYGS1wS+
        V1rokn8KMvVQIrs2yUGWi8ojWcjxf8Y9Xf9bggCOZW/zEZChGojWN08GPgG8sm4a/otfelnX9mCt+
        f+Lg+4HLeU7p/Xid2bUQZarQY9Np1SBTpaMuZ7XXdvwfKtn1QHFQyE07iNhDKYmrzEoFVPz6TnxjN
        ED32sGAdtqbpULeLuu3uTu2+I743vg8bFQelOBDvuYlCzVkTCZg7mAaRVrLjcmbhATuHBIBK4I2DN
        s9tOnizpFRLAKTt/PUBNyuIuuMtKMG0yosOib8Yw4miR1V2PUmo4EKwDwxtIgdqvlmr/hTfDxHIsL
        ySc8LyRRw==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpue-0001ny-Ii; Fri, 29 Dec 2017 08:21:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/67] dma-direct: rename dma_noop to dma_direct
Date:   Fri, 29 Dec 2017 09:18:29 +0100
Message-Id: <20171229081911.2802-26-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61722
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

The trivial direct mapping implementation already does a virtual to
physical translation which isn't strictly a noop, and will soon learn
to do non-direct but linear physical to dma translations through the
device offset and a few small tricks.  Rename it to a better fitting
name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                        |  2 +-
 arch/arm/Kconfig                   |  2 +-
 arch/arm/include/asm/dma-mapping.h |  2 +-
 arch/arm/mm/dma-mapping-nommu.c    |  8 ++++----
 arch/m32r/Kconfig                  |  2 +-
 arch/riscv/Kconfig                 |  2 +-
 arch/s390/Kconfig                  |  2 +-
 include/asm-generic/dma-mapping.h  |  2 +-
 include/linux/dma-mapping.h        |  2 +-
 lib/Kconfig                        |  2 +-
 lib/Makefile                       |  2 +-
 lib/{dma-noop.c => dma-direct.c}   | 35 +++++++++++++++--------------------
 12 files changed, 29 insertions(+), 34 deletions(-)
 rename lib/{dma-noop.c => dma-direct.c} (53%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8b35d9f41b2..b4005fe06e4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4336,7 +4336,7 @@ T:	git git://git.infradead.org/users/hch/dma-mapping.git
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 S:	Supported
 F:	lib/dma-debug.c
-F:	lib/dma-noop.c
+F:	lib/dma-direct.c
 F:	lib/dma-virt.c
 F:	drivers/base/dma-mapping.c
 F:	drivers/base/dma-coherent.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 00d889a37965..430a0aa710d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -25,7 +25,7 @@ config ARM
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select DMA_NOOP_OPS if !MMU
+	select DMA_DIRECT_OPS if !MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index e5d9020c9ee1..8436f6ade57d 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -18,7 +18,7 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
+	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_direct_ops;
 }
 
 #ifdef __arch_page_to_dma
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 1cced700e45a..49e9831dc0f1 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -22,7 +22,7 @@
 #include "dma.h"
 
 /*
- *  dma_noop_ops is used if
+ *  dma_direct_ops is used if
  *   - MMU/MPU is off
  *   - cpu is v7m w/o cache support
  *   - device is coherent
@@ -39,7 +39,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 				 unsigned long attrs)
 
 {
-	const struct dma_map_ops *ops = &dma_noop_ops;
+	const struct dma_map_ops *ops = &dma_direct_ops;
 	void *ret;
 
 	/*
@@ -70,7 +70,7 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr,
 			       unsigned long attrs)
 {
-	const struct dma_map_ops *ops = &dma_noop_ops;
+	const struct dma_map_ops *ops = &dma_direct_ops;
 
 	if (attrs & DMA_ATTR_NON_CONSISTENT) {
 		ops->free(dev, size, cpu_addr, dma_addr, attrs);
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(arm_nommu_dma_ops);
 
 static const struct dma_map_ops *arm_nommu_get_dma_map_ops(bool coherent)
 {
-	return coherent ? &dma_noop_ops : &arm_nommu_dma_ops;
+	return coherent ? &dma_direct_ops : &arm_nommu_dma_ops;
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 498398d915c1..dd84ee194579 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -19,7 +19,7 @@ config M32R
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select CPU_NO_EFFICIENT_FFS
-	select DMA_NOOP_OPS
+	select DMA_DIRECT_OPS
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 
 config SBUS
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2c6adf12713a..865e14f50c14 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -83,7 +83,7 @@ config PGTABLE_LEVELS
 config HAVE_KPROBES
 	def_bool n
 
-config DMA_NOOP_OPS
+config DMA_DIRECT_OPS
 	def_bool y
 
 menu "Platform type"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 829c67986db7..9376637229c9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -140,7 +140,7 @@ config S390
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
-	select DMA_NOOP_OPS
+	select DMA_DIRECT_OPS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index 164031531d85..880a292d792f 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -4,7 +4,7 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return &dma_noop_ops;
+	return &dma_direct_ops;
 }
 
 #endif /* _ASM_GENERIC_DMA_MAPPING_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 72568bf4fc12..ff3528de5322 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -143,7 +143,7 @@ struct dma_map_ops {
 	bool is_phys;
 };
 
-extern const struct dma_map_ops dma_noop_ops;
+extern const struct dma_map_ops dma_direct_ops;
 extern const struct dma_map_ops dma_virt_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
diff --git a/lib/Kconfig b/lib/Kconfig
index c5e84fbcb30b..9d3d649c9dc9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -409,7 +409,7 @@ config HAS_DMA
 	depends on !NO_DMA
 	default y
 
-config DMA_NOOP_OPS
+config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index d11c48ec8ffd..749851abe85a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,7 +28,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
-lib-$(CONFIG_DMA_NOOP_OPS) += dma-noop.o
+lib-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
 lib-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
 
 lib-y	+= kobject.o klist.o
diff --git a/lib/dma-noop.c b/lib/dma-direct.c
similarity index 53%
rename from lib/dma-noop.c
rename to lib/dma-direct.c
index c3728a0551f5..439db40854b7 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-direct.c
@@ -10,9 +10,8 @@
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
 
-static void *dma_noop_alloc(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t gfp,
-			    unsigned long attrs)
+static void *dma_direct_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -23,24 +22,21 @@ static void *dma_noop_alloc(struct device *dev, size_t size,
 	return ret;
 }
 
-static void dma_noop_free(struct device *dev, size_t size,
-			  void *cpu_addr, dma_addr_t dma_addr,
-			  unsigned long attrs)
+static void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
 
-static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
-				      unsigned long offset, size_t size,
-				      enum dma_data_direction dir,
-				      unsigned long attrs)
+static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
 }
 
-static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-			     enum dma_data_direction dir,
-			     unsigned long attrs)
+static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -58,12 +54,11 @@ static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nent
 	return nents;
 }
 
-const struct dma_map_ops dma_noop_ops = {
-	.alloc			= dma_noop_alloc,
-	.free			= dma_noop_free,
-	.map_page		= dma_noop_map_page,
-	.map_sg			= dma_noop_map_sg,
+const struct dma_map_ops dma_direct_ops = {
+	.alloc			= dma_direct_alloc,
+	.free			= dma_direct_free,
+	.map_page		= dma_direct_map_page,
+	.map_sg			= dma_direct_map_sg,
 	.is_phys		= true,
 };
-
-EXPORT_SYMBOL(dma_noop_ops);
+EXPORT_SYMBOL(dma_direct_ops);
-- 
2.14.2
