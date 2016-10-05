Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 19:23:10 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:28823 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992226AbcJERVcQNZFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 19:21:32 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 4CE4A688F0DE;
        Wed,  5 Oct 2016 18:21:24 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 18:21:25 +0100
Received: from localhost (10.100.200.82) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 18:21:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 10/18] MIPS: Support per-device DMA coherence
Date:   Wed, 5 Oct 2016 18:18:16 +0100
Message-ID: <20161005171824.18014-11-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161005171824.18014-1-paul.burton@imgtec.com>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.82]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On some MIPS systems, a subset of devices may have DMA coherent with CPU
caches. For example in systems including a MIPS I/O Coherence Unit
(IOCU), some devices may be connected to that IOCU whilst others are
not.

Prior to this patch, we have a plat_device_is_coherent() function but no
implementation which does anything besides return a global true or
false, optionally chosen at runtime. For devices such as those described
above this is insufficient.

Fix this by tracking DMA coherence on a per-device basis with a
dma_coherent field in struct dev_archdata. Setting this from
arch_setup_dma_ops() takes care of devices which set the dma-coherent
property via device tree, and any PCI devices beneath a bridge described
in DT, automatically.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/Kconfig                                  |  4 ++++
 arch/mips/include/asm/device.h                     |  5 +++++
 arch/mips/include/asm/dma-coherence.h              |  4 +++-
 arch/mips/include/asm/dma-mapping.h                | 10 ++++++++++
 arch/mips/include/asm/mach-generic/dma-coherence.h |  4 ++++
 arch/mips/mm/c-r4k.c                               |  4 ++++
 arch/mips/mm/dma-default.c                         |  2 +-
 7 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 86d5b39..2356439 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1099,6 +1099,10 @@ config DMA_MAYBE_COHERENT
 	select DMA_NONCOHERENT
 	bool
 
+config DMA_PERDEV_COHERENT
+	bool
+	select DMA_MAYBE_COHERENT
+
 config DMA_COHERENT
 	bool
 
diff --git a/arch/mips/include/asm/device.h b/arch/mips/include/asm/device.h
index c94fafb..21c2082 100644
--- a/arch/mips/include/asm/device.h
+++ b/arch/mips/include/asm/device.h
@@ -11,6 +11,11 @@ struct dma_map_ops;
 struct dev_archdata {
 	/* DMA operations on that device */
 	struct dma_map_ops *dma_ops;
+
+#ifdef CONFIG_DMA_PERDEV_COHERENT
+	/* Non-zero if DMA is coherent with CPU caches */
+	bool dma_coherent;
+#endif
 };
 
 struct pdev_archdata {
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index 4fbce79..72d0eab 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -15,7 +15,9 @@ enum coherent_io_user_state {
 	IO_COHERENCE_DISABLED,
 };
 
-#ifdef CONFIG_DMA_MAYBE_COHERENT
+#if defined(CONFIG_DMA_PERDEV_COHERENT)
+/* Don't provide (hw_)coherentio to avoid misuse */
+#elif defined(CONFIG_DMA_MAYBE_COHERENT)
 extern enum coherent_io_user_state coherentio;
 extern int hw_coherentio;
 #else
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 12fa79e..7aa71b9 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -32,4 +32,14 @@ static inline void dma_mark_clean(void *addr, size_t size) {}
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
+#define arch_setup_dma_ops arch_setup_dma_ops
+static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
+				      u64 size, const struct iommu_ops *iommu,
+				      bool coherent)
+{
+#ifdef CONFIG_DMA_PERDEV_COHERENT
+	dev->archdata.dma_coherent = coherent;
+#endif
+}
+
 #endif /* _ASM_DMA_MAPPING_H */
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 8484f82..61addb1 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -49,6 +49,9 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
+#ifdef CONFIG_DMA_PERDEV_COHERENT
+	return dev->archdata.dma_coherent;
+#else
 	switch (coherentio) {
 	default:
 	case IO_COHERENCE_DEFAULT:
@@ -58,6 +61,7 @@ static inline int plat_device_is_coherent(struct device *dev)
 	case IO_COHERENCE_DISABLED:
 		return 0;
 	}
+#endif
 }
 
 #ifndef plat_post_dma_flush
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 78ac033..88cfaf8 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1935,8 +1935,12 @@ void r4k_cache_init(void)
 	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
 #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+# if defined(CONFIG_DMA_PERDEV_COHERENT)
+	if (0) {
+# else
 	if ((coherentio == IO_COHERENCE_ENABLED) ||
 	    ((coherentio == IO_COHERENCE_DEFAULT) && hw_coherentio)) {
+# endif
 		_dma_cache_wback_inv	= (void *)cache_noop;
 		_dma_cache_wback	= (void *)cache_noop;
 		_dma_cache_inv		= (void *)cache_noop;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 7ae4c55..46d5696 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -24,7 +24,7 @@
 
 #include <dma-coherence.h>
 
-#ifdef CONFIG_DMA_MAYBE_COHERENT
+#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
 /* User defined DMA coherency from command line. */
 enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
 EXPORT_SYMBOL_GPL(coherentio);
-- 
2.10.0
