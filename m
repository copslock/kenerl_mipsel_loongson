Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:45:34 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:57881 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993955AbdFHN2eBoR-T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:28:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=06v7ciM0NGGCDXqarxHX/zRJ1KdayxLItOHrTFlo9Do=; b=Hj0uSDUFr4hFjBDtPl/jzoWQQ
        cMNpsB3dKWeSKmFc//I4gfv/ueWlDBm+ykPjyyudYQjR8g37QMIrc9XVL2b/xrtR/9AInJhSQ+3kv
        8SzqFB/dPSoc4gD4DmjThYhQievrMN2ZxU5ITNxg1FQQQOGa7HJWMIw5FJPe18+JiCFY7jmjWdabq
        GNS6DYvV5qE5H1t4riqN925i2cxQDZ7Htxq0OwEcGr/WooaTXr/WE67Fs6DV0INOw7ln3PCAaRqyh
        WG8OLbS/6M3WPLEhIPTlbm4dGp7TZ6QmA3vh1uBGrxvmLPD0u5eRQj0PKSAVEDW2lbuFgTKRrZm+E
        y0eeubjGg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxUA-0007g4-Vi; Thu, 08 Jun 2017 13:28:27 +0000
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
Subject: [PATCH 34/44] arm: remove arch specific dma_supported implementation
Date:   Thu,  8 Jun 2017 15:25:59 +0200
Message-Id: <20170608132609.32662-35-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58344
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

Note that the code seems a little fishy for dmabounce and iommu, but
for now I'd like to preserve the existing behavior 1:1.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/common/dmabounce.c        | 1 +
 arch/arm/include/asm/dma-iommu.h   | 2 ++
 arch/arm/include/asm/dma-mapping.h | 3 ---
 arch/arm/mm/dma-mapping.c          | 7 +++++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index bad457395ff1..4aabf117e136 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -476,6 +476,7 @@ static const struct dma_map_ops dmabounce_ops = {
 	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
 	.set_dma_mask		= dmabounce_set_mask,
 	.mapping_error		= dmabounce_mapping_error,
+	.dma_supported		= arm_dma_supported,
 };
 
 static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 389a26a10ea3..c090ec675eac 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -35,5 +35,7 @@ int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
 
+int arm_dma_supported(struct device *dev, u64 mask);
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 52a8fd5a8edb..8dabcfdf4505 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -20,9 +20,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &arm_dma_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-extern int dma_supported(struct device *dev, u64 mask);
-
 #ifdef __arch_page_to_dma
 #error Please update to __arch_pfn_to_dma
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 2dbc94b5fe5c..2938b724826e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -199,6 +199,7 @@ const struct dma_map_ops arm_dma_ops = {
 	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
 	.mapping_error		= arm_dma_mapping_error,
+	.dma_supported		= arm_dma_supported,
 };
 EXPORT_SYMBOL(arm_dma_ops);
 
@@ -218,6 +219,7 @@ const struct dma_map_ops arm_coherent_dma_ops = {
 	.map_page		= arm_coherent_dma_map_page,
 	.map_sg			= arm_dma_map_sg,
 	.mapping_error		= arm_dma_mapping_error,
+	.dma_supported		= arm_dma_supported,
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
 
@@ -1184,11 +1186,10 @@ void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
  * during bus mastering, then you would pass 0x00ffffff as the mask
  * to this function.
  */
-int dma_supported(struct device *dev, u64 mask)
+int arm_dma_supported(struct device *dev, u64 mask)
 {
 	return __dma_supported(dev, mask, false);
 }
-EXPORT_SYMBOL(dma_supported);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES	4096
 
@@ -2149,6 +2150,7 @@ const struct dma_map_ops iommu_ops = {
 	.unmap_resource		= arm_iommu_unmap_resource,
 
 	.mapping_error		= arm_dma_mapping_error,
+	.dma_supported		= arm_dma_supported,
 };
 
 const struct dma_map_ops iommu_coherent_ops = {
@@ -2167,6 +2169,7 @@ const struct dma_map_ops iommu_coherent_ops = {
 	.unmap_resource	= arm_iommu_unmap_resource,
 
 	.mapping_error		= arm_dma_mapping_error,
+	.dma_supported		= arm_dma_supported,
 };
 
 /**
-- 
2.11.0
