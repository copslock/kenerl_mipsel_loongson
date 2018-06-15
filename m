Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:16:26 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993256AbeFOLJx3u9FT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Edzd/q5P15Xy2oF/YT0KK0ObmxNgwtdq+CxU4a/d+Tw=; b=QCzVLDAr4wFPcW8Xan+TxRDXV
        LEi+XPgdtrGDbcUU92DTWUz3bZK3tGEYljtlIM/wadWfpVenTzxD/GBk+r3hihTt1zcNZn0uMpLZ0
        euWIjMf6pfqkqL9m5A9D9j7899vmGY67NCpENCAx3yfBWvTvkHswXlNMBAnfJmG3QflJlMaClvd3N
        +2wTbEfNk2asJaHtN7ad3CbswRFsFfIQEEVi1Kx35vhQNlgc/v52jo3QhQoeAzpMT+sIDTogom9lY
        ZsIq+ElhLluEennFVd9v0SmxZ8kt+jk3k5X0T8SN4K5EUGSLy0BW6ajrt9UBFsxYLCqdIbSZhoKDZ
        +Zi1wLa9w==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmc3-0005Di-FH; Fri, 15 Jun 2018 11:09:52 +0000
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
Subject: [PATCH 16/25] MIPS: move coherentio setup to setup.c
Date:   Fri, 15 Jun 2018 13:08:45 +0200
Message-Id: <20180615110854.19253-17-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64297
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

We want to be able to use it even when not building dma-default.c
in the near future.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/kernel/setup.c   | 24 ++++++++++++++++++++++++
 arch/mips/mm/dma-default.c | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2c96c0c68116..3d4524309b5c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/cdmm.h>
 #include <asm/cpu.h>
 #include <asm/debug.h>
+#include <asm/dma-coherence.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
@@ -1055,3 +1056,26 @@ static int __init debugfs_mips(void)
 }
 arch_initcall(debugfs_mips);
 #endif
+
+#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
+/* User defined DMA coherency from command line. */
+enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
+EXPORT_SYMBOL_GPL(coherentio);
+int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
+
+static int __init setcoherentio(char *str)
+{
+	coherentio = IO_COHERENCE_ENABLED;
+	pr_info("Hardware DMA cache coherency (command line)\n");
+	return 0;
+}
+early_param("coherentio", setcoherentio);
+
+static int __init setnocoherentio(char *str)
+{
+	coherentio = IO_COHERENCE_DISABLED;
+	pr_info("Software DMA cache coherency (command line)\n");
+	return 0;
+}
+early_param("nocoherentio", setnocoherentio);
+#endif
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 2db6c2a6f964..10b56e8a2076 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -24,29 +24,6 @@
 
 #include <dma-coherence.h>
 
-#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
-/* User defined DMA coherency from command line. */
-enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
-EXPORT_SYMBOL_GPL(coherentio);
-int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
-
-static int __init setcoherentio(char *str)
-{
-	coherentio = IO_COHERENCE_ENABLED;
-	pr_info("Hardware DMA cache coherency (command line)\n");
-	return 0;
-}
-early_param("coherentio", setcoherentio);
-
-static int __init setnocoherentio(char *str)
-{
-	coherentio = IO_COHERENCE_DISABLED;
-	pr_info("Software DMA cache coherency (command line)\n");
-	return 0;
-}
-early_param("nocoherentio", setnocoherentio);
-#endif
-
 static inline struct page *dma_addr_to_page(struct device *dev,
 	dma_addr_t dma_addr)
 {
-- 
2.17.1
