Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:09:09 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:46155 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994032AbeAJIBpELY0S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:01:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kiASGmiZul3LCTd2K8tf5F/JD5bt6pkN7jIkWZdtXIE=; b=aNitzHsftIuMr3C6QYkgheKJ7
        FSPi3FosxKbhRTUaoqI2+OU2L8bn1dXjsXydD63Y2QQUOm/Il72+IN8bVMAZJGTeKxq/2jRGOGYDJ
        ka1aL/+Lc/hvf2poRaFtbji9eXOWTPijATwg3IGdq+NF5lfor9gcGiroWLpUSFiKuFZ266pKcnyy+
        bH7KY0SzUh+bX7vwBfs60PD4TjEuaRNZKc1rJJY1jbnk5EV3Sx4RYnKTfKwXnPn5nw5nZ7NxMY8cI
        UPXkLG6BjQ/zE+6mRwdC/GnSOfVt1kBelNmnS+ewwS+hWFhMrmOahZ5o62KooFx1izLAQsC3d1Znz
        EJzFsMKfQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBKF-000542-8S; Wed, 10 Jan 2018 08:01:31 +0000
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
Subject: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common code
Date:   Wed, 10 Jan 2018 09:00:14 +0100
Message-Id: <20180110080027.13879-21-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61985
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

Lift the code from x86 so that we behave consistently.  In the future we
should probably warn if any of these is set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]
---
 arch/cris/arch-v32/drivers/pci/dma.c      | 3 ---
 arch/h8300/kernel/dma.c                   | 3 ---
 arch/m68k/kernel/dma.c                    | 2 --
 arch/mips/cavium-octeon/dma-octeon.c      | 3 ---
 arch/mips/loongson64/common/dma-swiotlb.c | 3 ---
 arch/mips/mm/dma-default.c                | 3 ---
 arch/mips/netlogic/common/nlm-dma.c       | 3 ---
 arch/mn10300/mm/dma-alloc.c               | 3 ---
 arch/nios2/mm/dma-mapping.c               | 3 ---
 arch/powerpc/kernel/dma.c                 | 3 ---
 arch/x86/kernel/pci-dma.c                 | 2 --
 include/linux/dma-mapping.h               | 7 +++++++
 12 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/pci/dma.c b/arch/cris/arch-v32/drivers/pci/dma.c
index dbbd3816cc0b..8c3802244ef3 100644
--- a/arch/cris/arch-v32/drivers/pci/dma.c
+++ b/arch/cris/arch-v32/drivers/pci/dma.c
@@ -22,9 +22,6 @@ static void *v32_dma_alloc(struct device *dev, size_t size,
 {
 	void *ret;
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
 	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 
diff --git a/arch/h8300/kernel/dma.c b/arch/h8300/kernel/dma.c
index 225dd0a188dc..d44ba5db4ac3 100644
--- a/arch/h8300/kernel/dma.c
+++ b/arch/h8300/kernel/dma.c
@@ -16,9 +16,6 @@ static void *dma_alloc(struct device *dev, size_t size,
 {
 	void *ret;
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
 	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 87ef73a93856..c01b9b8f97bf 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -76,8 +76,6 @@ static void *m68k_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
 	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index c64bd87f0b6e..5baf79fce643 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -161,9 +161,6 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 {
 	void *ret;
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
-
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && dev == NULL)
 		gfp |= __GFP_DMA;
 	else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index ef07740cee61..15388c24a504 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -15,9 +15,6 @@ static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
 {
 	void *ret;
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
-
 	if ((IS_ENABLED(CONFIG_ISA) && dev == NULL) ||
 	    (IS_ENABLED(CONFIG_ZONE_DMA) &&
 	     dev->coherent_dma_mask < DMA_BIT_MASK(32)))
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e3e94d05f0fd..237532e89919 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -93,9 +93,6 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 {
 	gfp_t dma_flag;
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
-
 #ifdef CONFIG_ISA
 	if (dev == NULL)
 		dma_flag = __GFP_DMA;
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index 0ec9d9da6d51..49c975b6aa28 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -47,9 +47,6 @@ static char *nlm_swiotlb;
 static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
-
 #ifdef CONFIG_ZONE_DMA32
 	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
diff --git a/arch/mn10300/mm/dma-alloc.c b/arch/mn10300/mm/dma-alloc.c
index 86108d2496b3..e3910d4db102 100644
--- a/arch/mn10300/mm/dma-alloc.c
+++ b/arch/mn10300/mm/dma-alloc.c
@@ -37,9 +37,6 @@ static void *mn10300_dma_alloc(struct device *dev, size_t size,
 		goto done;
 	}
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
 	if (dev == NULL || dev->coherent_dma_mask < 0xffffffff)
 		gfp |= GFP_DMA;
 
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 7040c1adbb5e..4be815519dd4 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -63,9 +63,6 @@ static void *nios2_dma_alloc(struct device *dev, size_t size,
 {
 	void *ret;
 
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
 	/* optimized page clearing */
 	gfp |= __GFP_ZERO;
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 6d5d04ccf3b4..76079841d3d0 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -105,9 +105,6 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 	};
 #endif /* CONFIG_FSL_SOC */
 
-	/* ignore region specifiers */
-	flag  &= ~(__GFP_HIGHMEM);
-
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
 		return NULL;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 8439e6de6156..61a8f1cb3829 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -87,7 +87,6 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 
 	dma_mask = dma_alloc_coherent_mask(dev, flag);
 
-	flag &= ~__GFP_ZERO;
 again:
 	page = NULL;
 	/* CMA can be used only in the context which permits sleeping */
@@ -139,7 +138,6 @@ bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp)
 	if (!*dev)
 		*dev = &x86_dma_fallback_dev;
 
-	*gfp &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
 	*gfp = dma_alloc_coherent_gfp_flags(*dev, *gfp);
 
 	if (!is_device_dma_capable(*dev))
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9f28b2fa329e..88bcb1a8211d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -518,6 +518,13 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
+	/*
+	 * Let the implementation decide on the zone to allocate from, and
+	 * decide on the way of zeroing the memory given that the memory
+	 * returned should always be zeroed.
+	 */
+	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
+
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
 	if (!ops->alloc)
-- 
2.14.2
