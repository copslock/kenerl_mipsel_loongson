Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 15:46:19 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:24066 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903668Ab2C0Nnj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 15:43:39 +0200
Received: from euspt2 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M1J00LLYQ48JZ@mailout2.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Mar 2012 14:43:24 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J0022WQ491V@spt2.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Mar 2012 14:43:22 +0100 (BST)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 9ACCD270051; Tue,
 27 Mar 2012 15:46:11 +0200 (CEST)
Date:   Tue, 27 Mar 2012 15:42:41 +0200
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 07/14] SH: adapt for dma_map_ops changes
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Message-id: <1332855768-32583-8-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.9.1
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

Adapt core SH architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/dma-mapping.h |   28 ++++++++++++++++++----------
 arch/sh/kernel/dma-nommu.c        |    4 ++--
 arch/sh/mm/consistent.c           |    6 ++++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 1a73c3e..8bd965e 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -52,25 +52,31 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return dma_addr == 0;
 }
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, dma_handle, &memory))
 		return memory;
-	if (!ops->alloc_coherent)
+	if (!ops->alloc)
 		return NULL;
 
-	memory = ops->alloc_coherent(dev, size, dma_handle, gfp);
+	memory = ops->alloc(dev, size, dma_handle, gfp, attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, memory);
 
 	return memory;
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -78,14 +84,16 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 		return;
 
 	debug_dma_free_coherent(dev, size, vaddr, dma_handle);
-	if (ops->free_coherent)
-		ops->free_coherent(dev, size, vaddr, dma_handle);
+	if (ops->free)
+		ops->free(dev, size, vaddr, dma_handle, attrs);
 }
 
 /* arch/sh/mm/consistent.c */
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_addr, gfp_t flag);
+					dma_addr_t *dma_addr, gfp_t flag,
+					struct dma_attrs *attrs);
 extern void dma_generic_free_coherent(struct device *dev, size_t size,
-				      void *vaddr, dma_addr_t dma_handle);
+				      void *vaddr, dma_addr_t dma_handle,
+				      struct dma_attrs *attrs);
 
 #endif /* __ASM_SH_DMA_MAPPING_H */
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 3c55b87..5b0bfcd 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -63,8 +63,8 @@ static void nommu_sync_sg(struct device *dev, struct scatterlist *sg,
 #endif
 
 struct dma_map_ops nommu_dma_ops = {
-	.alloc_coherent		= dma_generic_alloc_coherent,
-	.free_coherent		= dma_generic_free_coherent,
+	.alloc			= dma_generic_alloc_coherent,
+	.free			= dma_generic_free_coherent,
 	.map_page		= nommu_map_page,
 	.map_sg			= nommu_map_sg,
 #ifdef CONFIG_DMA_NONCOHERENT
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index f251b5f..b81d9db 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -33,7 +33,8 @@ static int __init dma_init(void)
 fs_initcall(dma_init);
 
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp)
+				 dma_addr_t *dma_handle, gfp_t gfp,
+				 struct dma_attrs *attrs)
 {
 	void *ret, *ret_nocache;
 	int order = get_order(size);
@@ -64,7 +65,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 }
 
 void dma_generic_free_coherent(struct device *dev, size_t size,
-			       void *vaddr, dma_addr_t dma_handle)
+			       void *vaddr, dma_addr_t dma_handle,
+			       struct dma_attrs *attrs)
 {
 	int order = get_order(size);
 	unsigned long pfn = dma_handle >> PAGE_SHIFT;
-- 
1.7.1.569.g6f426
