Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:41:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17991 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992495AbcHZPj6n-KyI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:39:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 03ADC5349B047;
        Fri, 26 Aug 2016 16:39:38 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:39:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        James Hogan <james.hogan@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 07/26] MIPS: Sanitise coherentio semantics
Date:   Fri, 26 Aug 2016 16:37:06 +0100
Message-ID: <20160826153725.11629-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54791
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

The coherentio variable has previously been used as a boolean value,
indicating whether the user specified that coherent I/O should be
enabled or disabled. It failed to take into account the case where the
user does not specify any preference, in which case it makes sense that
we should default to coherent I/O if the hardware supports it
(hw_coherentio is non-zero).

Introduce an enum to clarify the 3 different values of coherentio & use
it throughout the code, modifying plat_device_is_coherent() &
r4k_cache_init() to take into account the default case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/alchemy/common/setup.c                   |  6 +++---
 arch/mips/include/asm/dma-coherence.h              | 12 +++++++++---
 arch/mips/include/asm/mach-generic/dma-coherence.h | 10 +++++++++-
 arch/mips/mm/c-r4k.c                               |  3 ++-
 arch/mips/mm/dma-default.c                         |  7 ++++---
 arch/mips/mti-malta/malta-setup.c                  |  4 ++--
 arch/mips/pci/pci-alchemy.c                        |  3 ++-
 7 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 2902138..7faaa6d 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -48,17 +48,17 @@ void __init plat_mem_setup(void)
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
 	hw_coherentio = 0;
-	coherentio = 1;
+	coherentio = IO_COHERENCE_ENABLED;
 	switch (alchemy_get_cputype()) {
 	case ALCHEMY_CPU_AU1000:
 	case ALCHEMY_CPU_AU1500:
 	case ALCHEMY_CPU_AU1100:
-		coherentio = 0;
+		coherentio = IO_COHERENCE_DISABLED;
 		break;
 	case ALCHEMY_CPU_AU1200:
 		/* Au1200 AB USB does not support coherent memory */
 		if (0 == (read_c0_prid() & PRID_REV_MASK))
-			coherentio = 0;
+			coherentio = IO_COHERENCE_DISABLED;
 		break;
 	}
 
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index bc5e85d..4fbce79 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -9,14 +9,20 @@
 #ifndef __ASM_DMA_COHERENCE_H
 #define __ASM_DMA_COHERENCE_H
 
+enum coherent_io_user_state {
+	IO_COHERENCE_DEFAULT,
+	IO_COHERENCE_ENABLED,
+	IO_COHERENCE_DISABLED,
+};
+
 #ifdef CONFIG_DMA_MAYBE_COHERENT
-extern int coherentio;
+extern enum coherent_io_user_state coherentio;
 extern int hw_coherentio;
 #else
 #ifdef CONFIG_DMA_COHERENT
-#define coherentio	1
+#define coherentio	IO_COHERENCE_ENABLED
 #else
-#define coherentio	0
+#define coherentio	IO_COHERENCE_DISABLED
 #endif
 #define hw_coherentio	0
 #endif /* CONFIG_DMA_MAYBE_COHERENT */
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 0f8a354..8484f82 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -49,7 +49,15 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-	return coherentio;
+	switch (coherentio) {
+	default:
+	case IO_COHERENCE_DEFAULT:
+		return hw_coherentio;
+	case IO_COHERENCE_ENABLED:
+		return 1;
+	case IO_COHERENCE_DISABLED:
+		return 0;
+	}
 }
 
 #ifndef plat_post_dma_flush
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cd72805..c48deab 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1917,7 +1917,8 @@ void r4k_cache_init(void)
 	local_flush_icache_range	= local_r4k_flush_icache_range;
 
 #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
-	if (coherentio) {
+	if ((coherentio == IO_COHERENCE_ENABLED) ||
+	    ((coherentio == IO_COHERENCE_DEFAULT) && hw_coherentio)) {
 		_dma_cache_wback_inv	= (void *)cache_noop;
 		_dma_cache_wback	= (void *)cache_noop;
 		_dma_cache_inv		= (void *)cache_noop;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index b2eadd6..a9c1e94 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -25,13 +25,14 @@
 #include <dma-coherence.h>
 
 #ifdef CONFIG_DMA_MAYBE_COHERENT
-int coherentio = 0;	/* User defined DMA coherency from command line. */
+/* User defined DMA coherency from command line. */
+enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
 EXPORT_SYMBOL_GPL(coherentio);
 int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
 
 static int __init setcoherentio(char *str)
 {
-	coherentio = 1;
+	coherentio = IO_COHERENCE_ENABLED;
 	pr_info("Hardware DMA cache coherency (command line)\n");
 	return 0;
 }
@@ -39,7 +40,7 @@ early_param("coherentio", setcoherentio);
 
 static int __init setnocoherentio(char *str)
 {
-	coherentio = 0;
+	coherentio = IO_COHERENCE_DISABLED;
 	pr_info("Software DMA cache coherency (command line)\n");
 	return 0;
 }
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index ec5b216..d7d151f 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -148,12 +148,12 @@ static void __init plat_setup_iocoherency(void)
 	 * coherency instead.
 	 */
 	if (plat_enable_iocoherency()) {
-		if (coherentio == 0)
+		if (coherentio == IO_COHERENCE_DISABLED)
 			pr_info("Hardware DMA cache coherency disabled\n");
 		else
 			pr_info("Hardware DMA cache coherency enabled\n");
 	} else {
-		if (coherentio == 1)
+		if (coherentio == IO_COHERENCE_ENABLED)
 			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
 		else
 			pr_info("Software DMA cache coherency enabled\n");
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index c8994c1..e99ca77 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -429,7 +429,8 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 
 	/* Au1500 revisions older than AD have borked coherent PCI */
 	if ((alchemy_get_cputype() == ALCHEMY_CPU_AU1500) &&
-	    (read_c0_prid() < 0x01030202) && !coherentio) {
+	    (read_c0_prid() < 0x01030202) &&
+	    (coherentio == IO_COHERENCE_DISABLED)) {
 		val = __raw_readl(ctx->regs + PCI_REG_CONFIG);
 		val |= PCI_CONFIG_NC;
 		__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
-- 
2.9.3
