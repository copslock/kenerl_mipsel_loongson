Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:23:25 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:54378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994888AbdFPSMw5X67W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iSNtUveBfyJBYYDqWco6+Q0JXCXRuNYFw4IVbIRDF2U=; b=Yw3ybMVkFgELhfp2KwDocMDVo
        HgWSi+V9ddp/96Ju0a9gbUmK+Hw+B3t+9l1dFPOU2W+kw/LTRhqKAMG6iGu3CZuZqwabi+QUwmjGC
        iOjt8i43te1va+EwidsRpbefvM3TINoS48OJ6NuBF0NcoVW3pbkRlno80kpnyGbSptNKMP5vzWpEA
        iQd5dGSOYeoXwY4dzYW7BJWETlpJu+cG58Cq9ueW9gGNJuTscq61HYRIPv9/fQtz/ssNIuskuUWvn
        S6jO76XaSwY+GW1mGkzvO+Uonqh/JQ7Hok0Xks/NYLwd6R7DmlVrnS2H7nPQ0euRhLX5iNyWLiPDU
        k4bjwGSYg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvjg-0006AM-IM; Fri, 16 Jun 2017 18:12:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 28/44] sparc: remove arch specific dma_supported implementations
Date:   Fri, 16 Jun 2017 20:10:43 +0200
Message-Id: <20170616181059.19206-29-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58559
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

Usually dma_supported decisions are done by the dma_map_ops instance.
Switch sparc to that model by providing a ->dma_supported instance for
sbus that always returns false, and implementations tailored to the sun4u
and sun4v cases for sparc64, and leave it unimplemented for PCI on
sparc32, which means always supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma-mapping.h |  3 ---
 arch/sparc/kernel/iommu.c            | 40 +++++++++++++++---------------------
 arch/sparc/kernel/ioport.c           | 22 ++++++--------------
 arch/sparc/kernel/pci_sun4v.c        | 17 +++++++++++++++
 4 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 98da9f92c318..60bf1633d554 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -5,9 +5,6 @@
 #include <linux/mm.h>
 #include <linux/dma-debug.h>
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-int dma_supported(struct device *dev, u64 mask);
-
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 				  enum dma_data_direction dir)
 {
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index dafa316d978d..fcbcc031f615 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -746,6 +746,21 @@ static int dma_4u_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return dma_addr == SPARC_MAPPING_ERROR;
 }
 
+static int dma_4u_supported(struct device *dev, u64 device_mask)
+{
+	struct iommu *iommu = dev->archdata.iommu;
+
+	if (device_mask > DMA_BIT_MASK(32))
+		return 0;
+	if ((device_mask & iommu->dma_addr_mask) == iommu->dma_addr_mask)
+		return 1;
+#ifdef CONFIG_PCI
+	if (dev_is_pci(dev))
+		return pci64_dma_supported(to_pci_dev(dev), device_mask);
+#endif
+	return 0;
+}
+
 static const struct dma_map_ops sun4u_dma_ops = {
 	.alloc			= dma_4u_alloc_coherent,
 	.free			= dma_4u_free_coherent,
@@ -755,32 +770,9 @@ static const struct dma_map_ops sun4u_dma_ops = {
 	.unmap_sg		= dma_4u_unmap_sg,
 	.sync_single_for_cpu	= dma_4u_sync_single_for_cpu,
 	.sync_sg_for_cpu	= dma_4u_sync_sg_for_cpu,
+	.dma_supported		= dma_4u_supported,
 	.mapping_error		= dma_4u_mapping_error,
 };
 
 const struct dma_map_ops *dma_ops = &sun4u_dma_ops;
 EXPORT_SYMBOL(dma_ops);
-
-int dma_supported(struct device *dev, u64 device_mask)
-{
-	struct iommu *iommu = dev->archdata.iommu;
-	u64 dma_addr_mask = iommu->dma_addr_mask;
-
-	if (device_mask > DMA_BIT_MASK(32)) {
-		if (iommu->atu)
-			dma_addr_mask = iommu->atu->dma_addr_mask;
-		else
-			return 0;
-	}
-
-	if ((device_mask & dma_addr_mask) == dma_addr_mask)
-		return 1;
-
-#ifdef CONFIG_PCI
-	if (dev_is_pci(dev))
-		return pci64_dma_supported(to_pci_dev(dev), device_mask);
-#endif
-
-	return 0;
-}
-EXPORT_SYMBOL(dma_supported);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index dd081d557609..12894f259bea 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -401,6 +401,11 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	BUG();
 }
 
+static int sbus_dma_supported(struct device *dev, u64 mask)
+{
+	return 0;
+}
+
 static const struct dma_map_ops sbus_dma_ops = {
 	.alloc			= sbus_alloc_coherent,
 	.free			= sbus_free_coherent,
@@ -410,6 +415,7 @@ static const struct dma_map_ops sbus_dma_ops = {
 	.unmap_sg		= sbus_unmap_sg,
 	.sync_sg_for_cpu	= sbus_sync_sg_for_cpu,
 	.sync_sg_for_device	= sbus_sync_sg_for_device,
+	.dma_supported		= sbus_dma_supported,
 };
 
 static int __init sparc_register_ioport(void)
@@ -655,22 +661,6 @@ EXPORT_SYMBOL(pci32_dma_ops);
 const struct dma_map_ops *dma_ops = &sbus_dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-
-/*
- * Return whether the given PCI device DMA address mask can be
- * supported properly.  For example, if your device can only drive the
- * low 24-bits during PCI bus mastering, then you would pass
- * 0x00ffffff as the mask to this function.
- */
-int dma_supported(struct device *dev, u64 mask)
-{
-	if (dev_is_pci(dev))
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL(dma_supported);
-
 #ifdef CONFIG_PROC_FS
 
 static int sparc_io_proc_show(struct seq_file *m, void *v)
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 8e2a56f4c03a..24f21c726dfa 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -24,6 +24,7 @@
 
 #include "pci_impl.h"
 #include "iommu_common.h"
+#include "kernel.h"
 
 #include "pci_sun4v.h"
 
@@ -669,6 +670,21 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	local_irq_restore(flags);
 }
 
+static int dma_4v_supported(struct device *dev, u64 device_mask)
+{
+	struct iommu *iommu = dev->archdata.iommu;
+	u64 dma_addr_mask;
+
+	if (device_mask > DMA_BIT_MASK(32) && iommu->atu)
+		dma_addr_mask = iommu->atu->dma_addr_mask;
+	else
+		dma_addr_mask = iommu->dma_addr_mask;
+
+	if ((device_mask & dma_addr_mask) == dma_addr_mask)
+		return 1;
+	return pci64_dma_supported(to_pci_dev(dev), device_mask);
+}
+
 static int dma_4v_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == SPARC_MAPPING_ERROR;
@@ -681,6 +697,7 @@ static const struct dma_map_ops sun4v_dma_ops = {
 	.unmap_page			= dma_4v_unmap_page,
 	.map_sg				= dma_4v_map_sg,
 	.unmap_sg			= dma_4v_unmap_sg,
+	.dma_supported			= dma_4v_supported,
 	.mapping_error			= dma_4v_mapping_error,
 };
 
-- 
2.11.0
