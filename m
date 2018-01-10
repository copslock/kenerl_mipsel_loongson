Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:20:18 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:48606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994677AbeAJIKWObVTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=00HyE5fkLqbN2OfRQppfjCeGNVBTMhzaZ/BdNWAymcg=; b=g+yb8cMvJHmcx2c35sHn7DRVC
        lLHa/ZgNy8G/bVgKRimGar3YeUWKMSRguICmHj4P8nDbcElbaan91A9LNZQQtlLbp0QLGesUHUSro
        nY5RqjSZOzUCyJkRuYn7/2F5A7VUImV5OIuic2Sth5KbEt4m2BgL2/dZwIFeqzF5vjCMBCh/cqR0u
        I83M97r5KRHLd9t3il36mv3jLAlaN140PIgdEfwlJVsuv0ArySSKdCAcgEG7GlgpTySsgy46YlHbd
        f2sZFWrrLN5UWfLBPMHmCSchc9k4QHe+cPRd/lF36NQEFbGVHFUSUOsSdjg0ZbgFK/n7OYx+b7YQ5
        2HmRXAO0A==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSe-00006I-Hy; Wed, 10 Jan 2018 08:10:12 +0000
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
Subject: [PATCH 13/22] ia64: use generic swiotlb_ops
Date:   Wed, 10 Jan 2018 09:09:23 +0100
Message-Id: <20180110080932.14157-14-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62012
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

These are identical to the ia64 ops, and would also support CMA
if enabled on ia64.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/Kconfig                |  5 +++++
 arch/ia64/hp/common/hwsw_iommu.c |  4 ++--
 arch/ia64/hp/common/sba_iommu.c  |  6 +++---
 arch/ia64/kernel/pci-swiotlb.c   | 38 +++-----------------------------------
 4 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 888acdb163cb..29148fe4bf5a 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -146,6 +146,7 @@ config IA64_GENERIC
 	bool "generic"
 	select NUMA
 	select ACPI_NUMA
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	select PCI_MSI
 	help
@@ -166,6 +167,7 @@ config IA64_GENERIC
 
 config IA64_DIG
 	bool "DIG-compliant"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 
 config IA64_DIG_VTD
@@ -181,6 +183,7 @@ config IA64_HP_ZX1
 
 config IA64_HP_ZX1_SWIOTLB
 	bool "HP-zx1/sx1000 with software I/O TLB"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Build a kernel that runs on HP zx1 and sx1000 systems even when they
@@ -204,6 +207,7 @@ config IA64_SGI_UV
 	bool "SGI-UV"
 	select NUMA
 	select ACPI_NUMA
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Selecting this option will optimize the kernel for use on UV based
@@ -214,6 +218,7 @@ config IA64_SGI_UV
 
 config IA64_HP_SIM
 	bool "Ski-simulator"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	depends on !PM
 
diff --git a/arch/ia64/hp/common/hwsw_iommu.c b/arch/ia64/hp/common/hwsw_iommu.c
index 41279f0442bd..58969039bed2 100644
--- a/arch/ia64/hp/common/hwsw_iommu.c
+++ b/arch/ia64/hp/common/hwsw_iommu.c
@@ -19,7 +19,7 @@
 #include <linux/export.h>
 #include <asm/machvec.h>
 
-extern const struct dma_map_ops sba_dma_ops, ia64_swiotlb_dma_ops;
+extern const struct dma_map_ops sba_dma_ops;
 
 /* swiotlb declarations & definitions: */
 extern int swiotlb_late_init_with_default_size (size_t size);
@@ -38,7 +38,7 @@ static inline int use_swiotlb(struct device *dev)
 const struct dma_map_ops *hwsw_dma_get_ops(struct device *dev)
 {
 	if (use_swiotlb(dev))
-		return &ia64_swiotlb_dma_ops;
+		return &swiotlb_dma_ops;
 	return &sba_dma_ops;
 }
 EXPORT_SYMBOL(hwsw_dma_get_ops);
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 8c0a9ae6afec..aec4a3354abe 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2096,7 +2096,7 @@ static int __init acpi_sba_ioc_init_acpi(void)
 /* This has to run before acpi_scan_init(). */
 arch_initcall(acpi_sba_ioc_init_acpi);
 
-extern const struct dma_map_ops ia64_swiotlb_dma_ops;
+extern const struct dma_map_ops swiotlb_dma_ops;
 
 static int __init
 sba_init(void)
@@ -2111,7 +2111,7 @@ sba_init(void)
 	 * a successful kdump kernel boot is to use the swiotlb.
 	 */
 	if (is_kdump_kernel()) {
-		dma_ops = &ia64_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to initialize software I/O TLB:"
 				  " Try machvec=dig boot option");
@@ -2133,7 +2133,7 @@ sba_init(void)
 		 * If we didn't find something sba_iommu can claim, we
 		 * need to setup the swiotlb and switch to the dig machvec.
 		 */
-		dma_ops = &ia64_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to find SBA IOMMU or initialize "
 			      "software I/O TLB: Try machvec=dig boot option");
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 4a9a6e58ad6a..0f8d5fbd86bd 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -6,8 +6,7 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
-
-#include <asm/swiotlb.h>
+#include <linux/swiotlb.h>
 #include <asm/dma.h>
 #include <asm/iommu.h>
 #include <asm/machvec.h>
@@ -15,40 +14,9 @@
 int swiotlb __read_mostly;
 EXPORT_SYMBOL(swiotlb);
 
-static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
-					 dma_addr_t *dma_handle, gfp_t gfp,
-					 unsigned long attrs)
-{
-	if (dev->coherent_dma_mask != DMA_BIT_MASK(64))
-		gfp |= GFP_DMA32;
-	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
-}
-
-static void ia64_swiotlb_free_coherent(struct device *dev, size_t size,
-				       void *vaddr, dma_addr_t dma_addr,
-				       unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-}
-
-const struct dma_map_ops ia64_swiotlb_dma_ops = {
-	.alloc = ia64_swiotlb_alloc_coherent,
-	.free = ia64_swiotlb_free_coherent,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.dma_supported = swiotlb_dma_supported,
-	.mapping_error = swiotlb_dma_mapping_error,
-};
-
 void __init swiotlb_dma_init(void)
 {
-	dma_ops = &ia64_swiotlb_dma_ops;
+	dma_ops = &swiotlb_dma_ops;
 	swiotlb_init(1);
 }
 
@@ -60,7 +28,7 @@ void __init pci_swiotlb_init(void)
 		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
 		machvec_init("dig");
 		swiotlb_init(1);
-		dma_ops = &ia64_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 #else
 		panic("Unable to find Intel IOMMU");
 #endif
-- 
2.14.2
