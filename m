Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 13:30:39 +0100 (CET)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53181 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903629Ab1LWM2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 13:28:07 +0100
Received: from euspt1 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LWN007OFPANV1@mailout2.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:28:00 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWN008E1PAMPZ@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:27:59 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id B14BB270058; Fri,
 23 Dec 2011 13:39:23 +0100 (CET)
Date:   Fri, 23 Dec 2011 13:27:26 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 07/14] Alpha: adapt for dma_map_ops changes
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <1324643253-3024-8-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.7.3
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18818

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

Adapt core Alpha architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/alpha/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/alpha/kernel/pci-noop.c         |   10 ++++++----
 arch/alpha/kernel/pci_iommu.c        |   10 ++++++----
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 4567aca..dfa32f0 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -12,16 +12,22 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    struct dma_attrs *attrs)
 {
-	return get_dma_ops(dev)->alloc_coherent(dev, size, dma_handle, gfp);
+	return get_dma_ops(dev)->alloc(dev, size, dma_handle, gfp, attrs);
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
-	get_dma_ops(dev)->free_coherent(dev, size, vaddr, dma_handle);
+	get_dma_ops(dev)->free(dev, size, vaddr, dma_handle, attrs);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index 246100e..c337fb8 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -108,7 +108,8 @@ sys_pciconfig_write(unsigned long bus, unsigned long dfn,
 }
 
 static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+				       dma_addr_t *dma_handle, gfp_t gfp,
+				       struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -123,7 +124,8 @@ static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void alpha_noop_free_coherent(struct device *dev, size_t size,
-				     void *cpu_addr, dma_addr_t dma_addr)
+				     void *cpu_addr, dma_addr_t dma_addr,
+				     struct dma_attrs *attrs)
 {
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
@@ -174,8 +176,8 @@ static int alpha_noop_set_mask(struct device *dev, u64 mask)
 }
 
 struct dma_map_ops alpha_noop_ops = {
-	.alloc_coherent		= alpha_noop_alloc_coherent,
-	.free_coherent		= alpha_noop_free_coherent,
+	.alloc			= alpha_noop_alloc_coherent,
+	.free			= alpha_noop_free_coherent,
 	.map_page		= alpha_noop_map_page,
 	.map_sg			= alpha_noop_map_sg,
 	.mapping_error		= alpha_noop_mapping_error,
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 4361080..cd63479 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -434,7 +434,8 @@ static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
    else DMA_ADDRP is undefined.  */
 
 static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
-				      dma_addr_t *dma_addrp, gfp_t gfp)
+				      dma_addr_t *dma_addrp, gfp_t gfp,
+				      struct dma_attrs *attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	void *cpu_addr;
@@ -478,7 +479,8 @@ try_again:
    DMA_ADDR past this call are illegal.  */
 
 static void alpha_pci_free_coherent(struct device *dev, size_t size,
-				    void *cpu_addr, dma_addr_t dma_addr)
+				    void *cpu_addr, dma_addr_t dma_addr,
+				    struct dma_attrs *attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
@@ -952,8 +954,8 @@ static int alpha_pci_set_mask(struct device *dev, u64 mask)
 }
 
 struct dma_map_ops alpha_pci_ops = {
-	.alloc_coherent		= alpha_pci_alloc_coherent,
-	.free_coherent		= alpha_pci_free_coherent,
+	.alloc			= alpha_pci_alloc_coherent,
+	.free			= alpha_pci_free_coherent,
 	.map_page		= alpha_pci_map_page,
 	.unmap_page		= alpha_pci_unmap_page,
 	.map_sg			= alpha_pci_map_sg,
-- 
1.7.1.569.g6f426
