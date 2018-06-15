Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:10:50 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992994AbeFOLJUMcoTT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q0K8i5iWtv6wQxiHSUrpzcCEzKn71GxPeh5pG93m2eI=; b=SkMGiaId3ujZR7fyIvAFhGk8W
        o4ZXajtkqMvs08Edbm0LzUiuGMtp8HHOnuCOjjZpjRLbckPGerf1ACGPx11OzFL65nMpg+mwoOHJg
        Vamj/F63WXgIkHZbVx9p5M3sZA/Be4GJKiS/CIOKCN1ORurUBvWnk7hHRtBGyHAO+Nk6CbTF/LSN+
        nfTwKa29woHNWcj/2cnxelutwA5Dj2dZryjxbcrHw61HI3ludDdIFgWvUD5VBUJ11ps8JSzfEkPMM
        4vny4f9e3kHCWKcIcVA4Q8h3unHjBz+ANZ3THcIIhKrTP0gtxPxBvvtvmxDrB5fbUPDpDrC2hKx+G
        VS7NG6vEw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbT-0004sJ-8y; Fri, 15 Jun 2018 11:09:15 +0000
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
Subject: [PATCH 05/25] MIPS: Octeon: refactor swiotlb code
Date:   Fri, 15 Jun 2018 13:08:34 +0200
Message-Id: <20180615110854.19253-6-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64286
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

Share a common set of swiotlb operations, and to instead branch out in
__phys_to_dma/__dma_to_phys for the PCI vs non-PCI case.  Also use const
structures for the PCI methods so that attackers can't use them as
exploit vectors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/dma-octeon.c          | 161 ++++++++----------
 .../asm/mach-cavium-octeon/dma-coherence.h    |   2 -
 arch/mips/pci/pci-octeon.c                    |   2 -
 3 files changed, 71 insertions(+), 94 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index e5d00c79bd26..7f0c9f926b6e 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -23,10 +23,16 @@
 #include <asm/octeon/octeon.h>
 
 #ifdef CONFIG_PCI
+#include <linux/pci.h>
 #include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-npi-defs.h>
 #include <asm/octeon/cvmx-pci-defs.h>
 
+struct octeon_dma_map_ops {
+	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
+	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
+};
+
 static dma_addr_t octeon_hole_phys_to_dma(phys_addr_t paddr)
 {
 	if (paddr >= CVMX_PCIE_BAR1_PHYS_BASE && paddr < (CVMX_PCIE_BAR1_PHYS_BASE + CVMX_PCIE_BAR1_PHYS_SIZE))
@@ -60,6 +66,11 @@ static phys_addr_t octeon_gen1_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
+static const struct octeon_dma_map_ops octeon_gen1_ops = {
+	.phys_to_dma	= octeon_gen1_phys_to_dma,
+	.dma_to_phys	= octeon_gen1_dma_to_phys,
+};
+
 static dma_addr_t octeon_gen2_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return octeon_hole_phys_to_dma(paddr);
@@ -70,6 +81,11 @@ static phys_addr_t octeon_gen2_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return octeon_hole_dma_to_phys(daddr);
 }
 
+static const struct octeon_dma_map_ops octeon_gen2_ops = {
+	.phys_to_dma	= octeon_gen2_phys_to_dma,
+	.dma_to_phys	= octeon_gen2_dma_to_phys,
+};
+
 static dma_addr_t octeon_big_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	if (paddr >= 0x410000000ull && paddr < 0x420000000ull)
@@ -92,6 +108,11 @@ static phys_addr_t octeon_big_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
+static const struct octeon_dma_map_ops octeon_big_ops = {
+	.phys_to_dma	= octeon_big_phys_to_dma,
+	.dma_to_phys	= octeon_big_dma_to_phys,
+};
+
 static dma_addr_t octeon_small_phys_to_dma(struct device *dev,
 					   phys_addr_t paddr)
 {
@@ -120,6 +141,32 @@ static phys_addr_t octeon_small_dma_to_phys(struct device *dev,
 	return daddr;
 }
 
+static const struct octeon_dma_map_ops octeon_small_ops = {
+	.phys_to_dma	= octeon_small_phys_to_dma,
+	.dma_to_phys	= octeon_small_dma_to_phys,
+};
+
+static const struct octeon_dma_map_ops *octeon_pci_dma_ops;
+
+void __init octeon_pci_dma_init(void)
+{
+	switch (octeon_dma_bar_type) {
+	case OCTEON_DMA_BAR_TYPE_PCIE:
+		octeon_pci_dma_ops = &octeon_gen1_ops;
+		break;
+	case OCTEON_DMA_BAR_TYPE_PCIE2:
+		octeon_pci_dma_ops = &octeon_gen2_ops;
+		break;
+	case OCTEON_DMA_BAR_TYPE_BIG:
+		octeon_pci_dma_ops = &octeon_big_ops;
+		break;
+	case OCTEON_DMA_BAR_TYPE_SMALL:
+		octeon_pci_dma_ops = &octeon_small_ops;
+		break;
+	default:
+		BUG();
+	}
+}
 #endif /* CONFIG_PCI */
 
 static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
@@ -165,57 +212,37 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-static dma_addr_t octeon_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	return paddr;
-}
-
-static phys_addr_t octeon_unity_dma_to_phys(struct device *dev, dma_addr_t daddr)
-{
-	return daddr;
-}
-
-struct octeon_dma_map_ops {
-	const struct dma_map_ops dma_map_ops;
-	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
-	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
-};
-
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
-						      struct octeon_dma_map_ops,
-						      dma_map_ops);
-
-	return ops->phys_to_dma(dev, paddr);
+#ifdef CONFIG_PCI
+	if (dev && dev_is_pci(dev))
+		return octeon_pci_dma_ops->phys_to_dma(dev, paddr);
+#endif
+	return paddr;
 }
 
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
-						      struct octeon_dma_map_ops,
-						      dma_map_ops);
-
-	return ops->dma_to_phys(dev, daddr);
+#ifdef CONFIG_PCI
+	if (dev && dev_is_pci(dev))
+		return octeon_pci_dma_ops->dma_to_phys(dev, daddr);
+#endif
+	return daddr;
 }
 
-static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
-	.dma_map_ops = {
-		.alloc = octeon_dma_alloc_coherent,
-		.free = swiotlb_free,
-		.map_page = octeon_dma_map_page,
-		.unmap_page = swiotlb_unmap_page,
-		.map_sg = octeon_dma_map_sg,
-		.unmap_sg = swiotlb_unmap_sg_attrs,
-		.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-		.sync_single_for_device = octeon_dma_sync_single_for_device,
-		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-		.sync_sg_for_device = octeon_dma_sync_sg_for_device,
-		.mapping_error = swiotlb_dma_mapping_error,
-		.dma_supported = swiotlb_dma_supported
-	},
-	.phys_to_dma = octeon_unity_phys_to_dma,
-	.dma_to_phys = octeon_unity_dma_to_phys
+static const struct dma_map_ops octeon_swiotlb_ops = {
+	.alloc			= octeon_dma_alloc_coherent,
+	.free			= swiotlb_free,
+	.map_page		= octeon_dma_map_page,
+	.unmap_page		= swiotlb_unmap_page,
+	.map_sg			= octeon_dma_map_sg,
+	.unmap_sg		= swiotlb_unmap_sg_attrs,
+	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
+	.sync_single_for_device	= octeon_dma_sync_single_for_device,
+	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device	= octeon_dma_sync_sg_for_device,
+	.mapping_error		= swiotlb_dma_mapping_error,
+	.dma_supported		= swiotlb_dma_supported
 };
 
 char *octeon_swiotlb;
@@ -281,51 +308,5 @@ void __init plat_swiotlb_setup(void)
 	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
 		panic("Cannot allocate SWIOTLB buffer");
 
-	mips_dma_map_ops = &octeon_linear_dma_map_ops.dma_map_ops;
+	mips_dma_map_ops = &octeon_swiotlb_ops;
 }
-
-#ifdef CONFIG_PCI
-static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
-	.dma_map_ops = {
-		.alloc = octeon_dma_alloc_coherent,
-		.free = swiotlb_free,
-		.map_page = octeon_dma_map_page,
-		.unmap_page = swiotlb_unmap_page,
-		.map_sg = octeon_dma_map_sg,
-		.unmap_sg = swiotlb_unmap_sg_attrs,
-		.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-		.sync_single_for_device = octeon_dma_sync_single_for_device,
-		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-		.sync_sg_for_device = octeon_dma_sync_sg_for_device,
-		.mapping_error = swiotlb_dma_mapping_error,
-		.dma_supported = swiotlb_dma_supported
-	},
-};
-
-const struct dma_map_ops *octeon_pci_dma_map_ops;
-
-void __init octeon_pci_dma_init(void)
-{
-	switch (octeon_dma_bar_type) {
-	case OCTEON_DMA_BAR_TYPE_PCIE2:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_gen2_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_gen2_dma_to_phys;
-		break;
-	case OCTEON_DMA_BAR_TYPE_PCIE:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_gen1_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_gen1_dma_to_phys;
-		break;
-	case OCTEON_DMA_BAR_TYPE_BIG:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_big_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_big_dma_to_phys;
-		break;
-	case OCTEON_DMA_BAR_TYPE_SMALL:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_small_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_small_dma_to_phys;
-		break;
-	default:
-		BUG();
-	}
-	octeon_pci_dma_map_ops = &_octeon_pci_dma_map_ops.dma_map_ops;
-}
-#endif /* CONFIG_PCI */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 6eb1ee548b11..c5cdeea495f8 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -72,8 +72,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 
-struct dma_map_ops;
-extern const struct dma_map_ops *octeon_pci_dma_map_ops;
 extern char *octeon_swiotlb;
 
 #endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 3e92a06fa772..a20697df3539 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -166,8 +166,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
 	}
 
-	dev->dev.dma_ops = octeon_pci_dma_map_ops;
-
 	return 0;
 }
 
-- 
2.17.1
