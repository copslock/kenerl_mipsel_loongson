Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2012 11:40:24 +0100 (CET)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:30830 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904308Ab2BMKkT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2012 11:40:19 +0100
Received: from euspt2 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LZB002B3UZ1IE@mailout1.w1.samsung.com> for
 linux-mips@linux-mips.org; Mon, 13 Feb 2012 10:40:13 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LZB005GLUZ1Y4@spt2.w1.samsung.com> for
 linux-mips@linux-mips.org; Mon, 13 Feb 2012 10:40:13 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id C2C7327004F; Mon,
 13 Feb 2012 11:57:47 +0100 (CET)
Date:   Mon, 13 Feb 2012 11:40:05 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] Hexagon: adapt for dma_map_ops changes
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
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
        linux-hexagon@vger.kernel.org
Message-id: <1329129605-27355-1-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.8.3
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Adapt core Hexagon architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

Hello,

This patch adds Hexagon architecture to the DMA-mapping framework
redesign preparation patches. For more information please refer to the
following thread:
https://lkml.org/lkml/2011/12/23/97

Best regards
Marek Szyprowski
Samsung Poland R&D Center
---
 arch/hexagon/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/hexagon/kernel/dma.c              |    9 +++++----
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 448b224..233ed3d 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -71,29 +71,35 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return (dma_addr == bad_dma_address);
 }
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t flag,
+				    struct dma_attrs *attrs)
 {
 	void *ret;
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
 
-	ret = ops->alloc_coherent(dev, size, dma_handle, flag);
+	ret = ops->alloc(dev, size, dma_handle, flag, attrs);
 
 	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
 
 	return ret;
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *cpu_addr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *cpu_addr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
 
-	dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
+	dma_ops->free(dev, size, cpu_addr, dma_handle, attrs);
 
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
 }
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index e711ace..3730221 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -54,7 +54,8 @@ static struct gen_pool *coherent_pool;
 /* Allocates from a pool of uncached memory that was reserved at boot time */
 
 void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_addr, gfp_t flag)
+				 dma_addr_t *dma_addr, gfp_t flag,
+				 struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -81,7 +82,7 @@ void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void hexagon_free_coherent(struct device *dev, size_t size, void *vaddr,
-				  dma_addr_t dma_addr)
+				  dma_addr_t dma_addr, struct dma_attrs *attrs)
 {
 	gen_pool_free(coherent_pool, (unsigned long) vaddr, size);
 }
@@ -202,8 +203,8 @@ static void hexagon_sync_single_for_device(struct device *dev,
 }
 
 struct dma_map_ops hexagon_dma_ops = {
-	.alloc_coherent	= hexagon_dma_alloc_coherent,
-	.free_coherent	= hexagon_free_coherent,
+	.alloc		= hexagon_dma_alloc_coherent,
+	.free		= hexagon_free_coherent,
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
 	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
-- 
1.7.1.569.g6f426
