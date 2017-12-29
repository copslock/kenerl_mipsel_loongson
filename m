Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:44:58 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:50818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994675AbdL2IXpKnBTH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a3+mmScdBUKGDuk3d8S0sCgPJ1IKJd7Rin9lMj9dD+g=; b=FeYWzSPgkf6eEmVo8I1oZjEOE
        6OxkaRQPdl/O5KnC+8H9cUWhykWkdT4IGwMZ+gbMsufee7jNEEEB452NcgD2ohKr+cAkIobPYLX85
        KE6wwEuFl+uUA+oF5JaAbw2H5nXZg5Vu4quxOb2R2gd2/SUZjC3so9xNFVOXf5GTGl03AwGHQzpbM
        cHZjua9rpKMg/HmXLrHdt4CUCh+GEfa98m4o2I5/5IkEpDDBU5Nrjx/aJpVebgE3YrLBS8V/wNRri
        QWTwjAPU3ugfr5DtNlF7XvqKwQLoI3Q25voBV/lGxaAIXoo7bG3pjUbGCZsvPmosJpoE2sxERYk8m
        CEX2wDc5Q==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpws-0003eU-MY; Fri, 29 Dec 2017 08:23:27 +0000
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
Subject: [PATCH 57/67] ia64: clean up swiotlb support
Date:   Fri, 29 Dec 2017 09:19:01 +0100
Message-Id: <20171229081911.2802-58-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61754
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

Move the few remaining bits of swiotlb glue towards their callers,
and remove the pointless on ia64 swiotlb variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/dma-mapping.h |  1 -
 arch/ia64/include/asm/swiotlb.h     | 18 ------------------
 arch/ia64/kernel/dma-mapping.c      |  9 +++++++++
 arch/ia64/kernel/pci-dma.c          | 12 ++++++++++--
 arch/ia64/kernel/pci-swiotlb.c      | 36 ------------------------------------
 drivers/iommu/intel-iommu.c         |  2 +-
 6 files changed, 20 insertions(+), 58 deletions(-)
 delete mode 100644 arch/ia64/include/asm/swiotlb.h
 delete mode 100644 arch/ia64/kernel/pci-swiotlb.c

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index eabee56d995c..76e4d6632d68 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -8,7 +8,6 @@
  */
 #include <asm/machvec.h>
 #include <linux/scatterlist.h>
-#include <asm/swiotlb.h>
 #include <linux/dma-debug.h>
 
 #define ARCH_HAS_DMA_GET_REQUIRED_MASK
diff --git a/arch/ia64/include/asm/swiotlb.h b/arch/ia64/include/asm/swiotlb.h
deleted file mode 100644
index 841e2c7d0b21..000000000000
--- a/arch/ia64/include/asm/swiotlb.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASM_IA64__SWIOTLB_H
-#define ASM_IA64__SWIOTLB_H
-
-#include <linux/dma-mapping.h>
-#include <linux/swiotlb.h>
-
-#ifdef CONFIG_SWIOTLB
-extern int swiotlb;
-extern void pci_swiotlb_init(void);
-#else
-#define swiotlb 0
-static inline void pci_swiotlb_init(void)
-{
-}
-#endif
-
-#endif /* ASM_IA64__SWIOTLB_H */
diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
index 7a82c9259609..f2d57e66fd86 100644
--- a/arch/ia64/kernel/dma-mapping.c
+++ b/arch/ia64/kernel/dma-mapping.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
 #include <linux/export.h>
 
 /* Set this to 1 if there is a HW IOMMU in the system */
@@ -23,3 +24,11 @@ const struct dma_map_ops *dma_get_ops(struct device *dev)
 	return dma_ops;
 }
 EXPORT_SYMBOL(dma_get_ops);
+
+#ifdef CONFIG_SWIOTLB
+void __init swiotlb_dma_init(void)
+{
+	dma_ops = &swiotlb_dma_ops;
+	swiotlb_init(1);
+}
+#endif
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 3ba87c22dfbc..35e0cad33b7d 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -104,8 +104,16 @@ void __init pci_iommu_alloc(void)
 	detect_intel_iommu();
 
 #ifdef CONFIG_SWIOTLB
-	pci_swiotlb_init();
-#endif
+	if (!iommu_detected) {
+#ifdef CONFIG_IA64_GENERIC
+		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
+		machvec_init("dig");
+		swiotlb_dma_init();
+#else
+		panic("Unable to find Intel IOMMU");
+#endif /* CONFIG_IA64_GENERIC */
+	}
+#endif /* CONFIG_SWIOTLB */
 }
 
 #endif
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
deleted file mode 100644
index 0f8d5fbd86bd..000000000000
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Glue code to lib/swiotlb.c */
-
-#include <linux/pci.h>
-#include <linux/gfp.h>
-#include <linux/cache.h>
-#include <linux/module.h>
-#include <linux/dma-mapping.h>
-#include <linux/swiotlb.h>
-#include <asm/dma.h>
-#include <asm/iommu.h>
-#include <asm/machvec.h>
-
-int swiotlb __read_mostly;
-EXPORT_SYMBOL(swiotlb);
-
-void __init swiotlb_dma_init(void)
-{
-	dma_ops = &swiotlb_dma_ops;
-	swiotlb_init(1);
-}
-
-void __init pci_swiotlb_init(void)
-{
-	if (!iommu_detected) {
-#ifdef CONFIG_IA64_GENERIC
-		swiotlb = 1;
-		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
-		machvec_init("dig");
-		swiotlb_init(1);
-		dma_ops = &swiotlb_dma_ops;
-#else
-		panic("Unable to find Intel IOMMU");
-#endif
-	}
-}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6c9df0773b78..569a9328e53e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4807,7 +4807,7 @@ int __init intel_iommu_init(void)
 	up_write(&dmar_global_lock);
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	swiotlb = 0;
 #endif
 	dma_ops = &intel_dma_ops;
-- 
2.14.2
