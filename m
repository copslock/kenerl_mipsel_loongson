Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:49:13 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:35268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbdFHN25un9hT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:28:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WCFl8gyLH+Dtw1N5AT1LVFwtyWKYQDQAq3hDiEm/z10=; b=NfRvftwZfLNL/J/Wh5Uv+ge1o
        zD9qlb7mf9yIiA6ED1uahM10VNNQk+8kc5Uv6ZWi4QVx9iqBCOKSd3BZufJnb4BdP1WbY4MO2LUrg
        cu8llUtegkqDqtWiY7DgD5t1cIZDIfhU5gTODYCnvSyNCvsqH36Wfznfe/mbN2r9UDTk189e7mvJZ
        yYMiVxR7iin+jffGOoGmRfyARbNjwXZRvVN7m5I2fIoPVEVW5YkztYojmrHGhFxBJVpIjbmIU7D5O
        Okc98peBlMV7c0siGAyV/hBg/P/m7tyyrk5vls2ADi4M0bzt4jeEEvhOHaB+gfvkL1QaCIMPHP2x8
        f0oS+rW3g==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxUX-0008AI-Tm; Thu, 08 Jun 2017 13:28:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 40/44] tile: remove dma_supported and mapping_error methods
Date:   Thu,  8 Jun 2017 15:26:05 +0200
Message-Id: <20170608132609.32662-41-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58350
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

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/tile/kernel/pci-dma.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index 569bb6dd154a..f2abedc8a080 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -317,18 +317,6 @@ static void tile_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static inline int
-tile_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-tile_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static const struct dma_map_ops tile_default_dma_map_ops = {
 	.alloc = tile_dma_alloc_coherent,
 	.free = tile_dma_free_coherent,
@@ -340,8 +328,6 @@ static const struct dma_map_ops tile_default_dma_map_ops = {
 	.sync_single_for_device = tile_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_dma_sync_sg_for_device,
-	.mapping_error = tile_dma_mapping_error,
-	.dma_supported = tile_dma_supported
 };
 
 const struct dma_map_ops *tile_dma_map_ops = &tile_default_dma_map_ops;
@@ -504,18 +490,6 @@ static void tile_pci_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static inline int
-tile_pci_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-tile_pci_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static const struct dma_map_ops tile_pci_default_dma_map_ops = {
 	.alloc = tile_pci_dma_alloc_coherent,
 	.free = tile_pci_dma_free_coherent,
@@ -527,8 +501,6 @@ static const struct dma_map_ops tile_pci_default_dma_map_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
-	.mapping_error = tile_pci_dma_mapping_error,
-	.dma_supported = tile_pci_dma_supported
 };
 
 const struct dma_map_ops *gx_pci_dma_map_ops = &tile_pci_default_dma_map_ops;
@@ -578,8 +550,6 @@ static const struct dma_map_ops pci_hybrid_dma_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
-	.mapping_error = tile_pci_dma_mapping_error,
-	.dma_supported = tile_pci_dma_supported
 };
 
 const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &pci_swiotlb_dma_ops;
-- 
2.11.0
