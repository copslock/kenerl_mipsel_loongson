Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:28:42 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:41758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994904AbdFPSNnk7EHW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XON3TUW36P2rkN5fIDq3P1sFNA/9AOY+WuuJ/+oqbms=; b=qZA7Yuj9VeeGUk9FtvLL0QsTy
        fQ/Yd0bYMgd3qGgG/qAge05mziWOSJhS519orDfn+rtI6esCr3rZiLJDTntLzk+Vl9z4Qe2iEsWy4
        IP3PQdUjFZ/YMuJFKJjtnXRofuVvSkpdhv+2XUmcG2T7/1Ogkb9FtFHXKGzKNlnQl3e0ZH363zQZ6
        Gmzy7/vt4dSgYEkIHg2UUghm29Q1rguReuDDAWoB80Okc2r7aStxI2sjEGHD78jLPPH/pmeH9hq4I
        2je8mRXsIb0XhUthmXgz1iemePDD4lB+bTSMZ7A1xSNMZx/SVuoE8zv7zq4bmJJyWQ5snr91OD04R
        wTcYt6sdA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvkW-0007Dq-8z; Fri, 16 Jun 2017 18:13:36 +0000
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
Subject: [PATCH 42/44] powerpc/cell: use the dma_supported method for ops switching
Date:   Fri, 16 Jun 2017 20:10:57 +0200
Message-Id: <20170616181059.19206-43-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58572
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

Besides removing the last instance of the set_dma_mask method this also
reduced the code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/cell/iommu.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 497bfbdbd967..29d4f96ed33e 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -644,20 +644,14 @@ static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
 				   direction, attrs);
 }
 
-static int dma_fixed_dma_supported(struct device *dev, u64 mask)
-{
-	return mask == DMA_BIT_MASK(64);
-}
-
-static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask);
+static int dma_suported_and_switch(struct device *dev, u64 dma_mask);
 
 static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.alloc          = dma_fixed_alloc_coherent,
 	.free           = dma_fixed_free_coherent,
 	.map_sg         = dma_fixed_map_sg,
 	.unmap_sg       = dma_fixed_unmap_sg,
-	.dma_supported  = dma_fixed_dma_supported,
-	.set_dma_mask   = dma_set_mask_and_switch,
+	.dma_supported  = dma_suported_and_switch,
 	.map_page       = dma_fixed_map_page,
 	.unmap_page     = dma_fixed_unmap_page,
 	.mapping_error	= dma_iommu_mapping_error,
@@ -952,11 +946,8 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 	return dev_addr;
 }
 
-static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
+static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
 	if (dma_mask == DMA_BIT_MASK(64) &&
 	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
 		u64 addr = cell_iommu_get_fixed_address(dev) +
@@ -965,14 +956,16 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
 		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 		set_dma_ops(dev, &dma_iommu_fixed_ops);
 		set_dma_offset(dev, addr);
-	} else {
+		return 1;
+	}
+
+	if (dma_iommu_dma_supported(dev, dma_mask)) {
 		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
 		set_dma_ops(dev, get_pci_dma_ops());
 		cell_dma_dev_setup(dev);
+		return 1;
 	}
 
-	*dev->dma_mask = dma_mask;
-
 	return 0;
 }
 
@@ -1127,7 +1120,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
 	}
 
-	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
+	dma_iommu_ops.dma_supported = dma_suported_and_switch;
 	set_pci_dma_ops(&dma_iommu_ops);
 
 	return 0;
-- 
2.11.0
