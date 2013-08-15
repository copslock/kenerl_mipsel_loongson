Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Aug 2013 11:28:39 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56688 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865278Ab3HOJ2dpypWi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Aug 2013 11:28:33 +0200
Received: by nf.lan (Postfix, from userid 501)
        id 7C8494FF4DFE; Thu, 15 Aug 2013 11:28:32 +0200 (CEST)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH v3 2/3] MIPS: improve checks for noncoherent DMA
Date:   Thu, 15 Aug 2013 11:28:31 +0200
Message-Id: <1376558912-41050-2-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 1.8.0.2
In-Reply-To: <1376558912-41050-1-git-send-email-nbd@openwrt.org>
References: <1376558912-41050-1-git-send-email-nbd@openwrt.org>
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

Only one MIPS development board actually supports enabling/disabling DMA
coherency at runtime, so it's not a good idea to push the overhead of
checking that configuration setting onto every other supported target as
well.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/mips/Kconfig                                  | 6 +++++-
 arch/mips/include/asm/dma-coherence.h              | 9 +++++++++
 arch/mips/include/asm/mach-generic/dma-coherence.h | 4 ----
 arch/mips/mm/dma-default.c                         | 2 ++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e12764c..9b258f5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -300,7 +300,7 @@ config MIPS_MALTA
 	select CEVT_R4K
 	select CSRC_R4K
 	select CSRC_GIC
-	select DMA_NONCOHERENT
+	select DMA_MAYBE_COHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
 	select IRQ_CPU
@@ -915,6 +915,10 @@ config FW_CFE
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
 
+config DMA_MAYBE_COHERENT
+	select DMA_NONCOHERENT
+	bool
+
 config DMA_COHERENT
 	bool
 
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index 242cbb3..bc5e85d 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -9,7 +9,16 @@
 #ifndef __ASM_DMA_COHERENCE_H
 #define __ASM_DMA_COHERENCE_H
 
+#ifdef CONFIG_DMA_MAYBE_COHERENT
 extern int coherentio;
 extern int hw_coherentio;
+#else
+#ifdef CONFIG_DMA_COHERENT
+#define coherentio	1
+#else
+#define coherentio	0
+#endif
+#define hw_coherentio	0
+#endif /* CONFIG_DMA_MAYBE_COHERENT */
 
 #endif
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index a9e8f6b..7629c35 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -49,11 +49,7 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-#ifdef CONFIG_DMA_COHERENT
-	return 1;
-#else
 	return coherentio;
-#endif
 }
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 63e45d6..87a98d5 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -22,6 +22,7 @@
 
 #include <dma-coherence.h>
 
+#ifdef CONFIG_DMA_MAYBE_COHERENT
 int coherentio = 0;	/* User defined DMA coherency from command line. */
 EXPORT_SYMBOL_GPL(coherentio);
 int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
@@ -41,6 +42,7 @@ static int __init setnocoherentio(char *str)
 	return 0;
 }
 early_param("nocoherentio", setnocoherentio);
+#endif
 
 static inline struct page *dma_addr_to_page(struct device *dev,
 	dma_addr_t dma_addr)
-- 
1.8.0.2
