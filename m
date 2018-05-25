Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:27:25 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993256AbeEYJW0nfOEA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5c5kQxB0SRZJw+bVahpMDTF9o4aq0UUoFitYpMJT2TY=; b=kx3EkIZ69F7ecy4iq621+/reG
        OglQdzty3a1Ry/DeS+wHYTl+FX5qSYgjdheRlS5Q9Hb5R5W9Jnb/FrE2jPpoCAbyOTpYXK16N1qTo
        +//PpYhDC7ZCRPUokjBysw0t64tLE6wq/S29mFKstTqHNwRrsqdmgO3hl1IaYnzxVIzPaTO05HyxW
        0k46LS3gFV6ozUdlOX5hE+QT+1y5p7Ri2nyYaMpuiMfoMHLfp6TG1A0zLQUz6cyEIDimC+fUY367u
        NPBRyphZM69ASKDBYgZ/85l1PhZS9NSUlAgwLMzy19CLKlUpKL0/RH9vjeecL2gGxeNW5bnMHNIV5
        jDaSMt97w==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vZ-000200-95; Fri, 25 May 2018 09:22:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 22/25] dma-noncoherent: add a arch_sync_dma_for_cpu_all hook
Date:   Fri, 25 May 2018 11:21:08 +0200
Message-Id: <20180525092111.18516-23-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64035
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

The MIPS bmips platform needs a global flush when transferring ownership
back to the CPU.  Add a hook for that to the dma-noncoherent
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-noncoherent.h | 8 ++++++++
 lib/dma-noncoherent.c           | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 10b2654d549b..a0aa00cc909d 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -44,4 +44,12 @@ static inline void arch_sync_dma_for_cpu(struct device *dev,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+void arch_sync_dma_for_cpu_all(struct device *dev);
+#else
+static inline void arch_sync_dma_for_cpu_all(struct device *dev)
+{
+}
+#endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
+
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/lib/dma-noncoherent.c b/lib/dma-noncoherent.c
index 79e9a757387f..031fe235d958 100644
--- a/lib/dma-noncoherent.c
+++ b/lib/dma-noncoherent.c
@@ -49,11 +49,13 @@ static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 static void dma_noncoherent_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
 	arch_sync_dma_for_cpu(dev, dma_to_phys(dev, addr), size, dir);
+	arch_sync_dma_for_cpu_all(dev);
 }
 
 static void dma_noncoherent_sync_sg_for_cpu(struct device *dev,
@@ -64,6 +66,7 @@ static void dma_noncoherent_sync_sg_for_cpu(struct device *dev,
 
 	for_each_sg(sgl, sg, nents, i)
 		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+	arch_sync_dma_for_cpu_all(dev);
 }
 
 static void dma_noncoherent_unmap_page(struct device *dev, dma_addr_t addr,
@@ -89,7 +92,8 @@ const struct dma_map_ops dma_noncoherent_ops = {
 	.sync_sg_for_device	= dma_noncoherent_sync_sg_for_device,
 	.map_page		= dma_noncoherent_map_page,
 	.map_sg			= dma_noncoherent_map_sg,
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	.sync_single_for_cpu	= dma_noncoherent_sync_single_for_cpu,
 	.sync_sg_for_cpu	= dma_noncoherent_sync_sg_for_cpu,
 	.unmap_page		= dma_noncoherent_unmap_page,
-- 
2.17.0
