Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:26:19 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:50537 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994898AbdFPSNUhOfZW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:13:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vSHdJ0fRN3QhYzmwkOg9MVJJCwgAKWOmRXXsBosPrLA=; b=s6sm8SHy1u7ZUfijHkD30WP6O
        t17xJ7UwTMyOGFdiGinHphgpSkT4Je5L+WBKA9ku7D7nNuXWF3NUuYSCjy2Gg/pzHe6DoDDiKEd2h
        zpoOD0C4HTPB2EMn0DyV/vptLREAQ/5i99okV6Tk8F3pgYXi05Nh8K0zWLY+TjxQVWQeB1cjb16hV
        SI/ffQ5VkWwsd/1/eZgNTZpaJV3B2dER3V7m+IfHisVF2cplW0Y5WoAjpfNeYjP2GA0JNlE0MUcxy
        gEbnpblEqjOexY8Q+JOHdonp7kfsxxdqydbF7WPtNlg9i6XA5VAEUSnEHbcJRbBevwOIIHaRKoSEe
        LXPEvWN9w==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvk9-0006kK-EH; Fri, 16 Jun 2017 18:13:14 +0000
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
Subject: [PATCH 35/44] x86: remove arch specific dma_supported implementation
Date:   Fri, 16 Jun 2017 20:10:50 +0200
Message-Id: <20170616181059.19206-36-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58566
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

And instead wire it up as method for all the dma_map_ops instances.

Note that this also means the arch specific check will be fully instead
of partially applied in the AMD iommu driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 3 ---
 arch/x86/include/asm/iommu.h       | 2 ++
 arch/x86/kernel/amd_gart_64.c      | 1 +
 arch/x86/kernel/pci-calgary_64.c   | 1 +
 arch/x86/kernel/pci-dma.c          | 7 +------
 arch/x86/kernel/pci-nommu.c        | 1 +
 arch/x86/pci/sta2x11-fixup.c       | 3 ++-
 drivers/iommu/amd_iommu.c          | 2 ++
 drivers/iommu/intel-iommu.c        | 3 +++
 9 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index c35d228aa381..398c79889f5c 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -33,9 +33,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
 #define arch_dma_alloc_attrs arch_dma_alloc_attrs
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-extern int dma_supported(struct device *hwdev, u64 mask);
-
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_addr, gfp_t flag,
 					unsigned long attrs);
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 793869879464..fca144a104e4 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -6,6 +6,8 @@ extern int force_iommu, no_iommu;
 extern int iommu_detected;
 extern int iommu_pass_through;
 
+int x86_dma_supported(struct device *dev, u64 mask);
+
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
 
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 815dd63f49d0..cc0e8bc0ea3f 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -704,6 +704,7 @@ static const struct dma_map_ops gart_dma_ops = {
 	.alloc				= gart_alloc_coherent,
 	.free				= gart_free_coherent,
 	.mapping_error			= gart_mapping_error,
+	.dma_supported			= x86_dma_supported,
 };
 
 static void gart_iommu_shutdown(void)
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index e75b490f2b0b..5286a4a92cf7 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -493,6 +493,7 @@ static const struct dma_map_ops calgary_dma_ops = {
 	.map_page = calgary_map_page,
 	.unmap_page = calgary_unmap_page,
 	.mapping_error = calgary_mapping_error,
+	.dma_supported = x86_dma_supported,
 };
 
 static inline void __iomem * busno_to_bbar(unsigned char num)
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 3a216ec869cd..b6f5684be3b5 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -213,10 +213,8 @@ static __init int iommu_setup(char *p)
 }
 early_param("iommu", iommu_setup);
 
-int dma_supported(struct device *dev, u64 mask)
+int x86_dma_supported(struct device *dev, u64 mask)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
 #ifdef CONFIG_PCI
 	if (mask > 0xffffffff && forbid_dac > 0) {
 		dev_info(dev, "PCI: Disallowing DAC for device\n");
@@ -224,9 +222,6 @@ int dma_supported(struct device *dev, u64 mask)
 	}
 #endif
 
-	if (ops->dma_supported)
-		return ops->dma_supported(dev, mask);
-
 	/* Copied from i386. Doesn't make much sense, because it will
 	   only work for pci_alloc_coherent.
 	   The caller just has to use GFP_DMA in this case. */
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index 085fe6ce4049..a6d404087fe3 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -104,4 +104,5 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
 	.mapping_error		= nommu_mapping_error,
+	.dma_supported		= x86_dma_supported,
 };
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index ec008e800b45..53d600217973 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -26,6 +26,7 @@
 #include <linux/pci_ids.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <asm/iommu.h>
 
 #define STA2X11_SWIOTLB_SIZE (4*1024*1024)
 extern int swiotlb_late_init_with_default_size(size_t default_size);
@@ -191,7 +192,7 @@ static const struct dma_map_ops sta2x11_dma_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = NULL, /* FIXME: we should use this instead! */
+	.dma_supported = x86_dma_supported,
 };
 
 /* At setup time, we use our own ops if the device is a ConneXt one */
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d41280e869de..521fdf2d41bc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2731,6 +2731,8 @@ static void free_coherent(struct device *dev, size_t size,
  */
 static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 {
+	if (!x86_dma_supported(dev, mask))
+		return 0;
 	return check_device(dev);
 }
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fc2765ccdb57..53cc0a393f04 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3981,6 +3981,9 @@ struct dma_map_ops intel_dma_ops = {
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
 	.mapping_error = intel_mapping_error,
+#ifdef CONFIG_X86
+	.dma_supported = x86_dma_supported,
+#endif
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.11.0
