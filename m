Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:18:43 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeFOLKOC0VvT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:10:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0LP+TMJx++BYqAJdKkIaElHeOXCQ+NqjRmroMmyr1f4=; b=DEry++dwTZtiP+2pOnr/D+Lbe
        3qGQXNro0WTFYq2eW5eoo3AVlw1xAqRaN52SyiP19Kl1tF5PnhxSqgsGb/fDAMFY+qjqYHvDsps/B
        k3HkAOJ5dLFrHeywb2aV4melHf/xsHVFw7TDT1iygEYoni7k9sr/F4VltZt00JAr61mfTQUe+a8RO
        fPzDGECQZJqoraogN8rSOwg9qGLg5zYNb5AJmLZ4aaCDCPrJb47Ejxi4MHd1sWRO0vRxbVOo8oq+O
        g7x9+01Dw3gzVr3LQODIRtbqk4Uhg9dVte5b5q9X7dWUcet/C19YPXPAhCS38zRpRD34waVub5gw9
        NvLiGCmMQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmcO-0005Zu-1l; Fri, 15 Jun 2018 11:10:12 +0000
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
Subject: [PATCH 22/25] dma-noncoherent: add a arch_sync_dma_for_cpu_all hook
Date:   Fri, 15 Jun 2018 13:08:51 +0200
Message-Id: <20180615110854.19253-23-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64303
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
2.17.1
