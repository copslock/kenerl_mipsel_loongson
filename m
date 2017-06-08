Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:49:39 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:53565 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993996AbdFHN3ACG00T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=saA26sPfICjyc+4T/0yC4vFagVwbOn+E7o2zrErGht4=; b=IttB9uqrO45fxNq0ZOnUV2XqV
        efiFT5/+Wbhav95e1HAb7u0uE1XOuCvAN9jG7Lu5upQi4fnF7qm+dpH3mkDB1fcjykBkEuesF05NI
        gVjf+hdse3xKnyRjmA/xkS5hP7XT3EXTIuEFSSyypJph2qXdG+Th/+wqYO9s5hKE/7vJ+gxwK3M7m
        wLFg+etpPncpqYfBRFyZ3g0xpseeOLSKRZdb5ZLXH5c7kvWD5qsuYfkZ8ckJGnKIgEE6OeWHaicbm
        MR34h5MxdDxg66nqLEU3GICCqDi7orXfKUAkqUETjjk0wiLol/kXA5S+1MoEdQgyrPc7wc7RlKx3O
        /Ru86tTVQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxUc-0008GF-DV; Thu, 08 Jun 2017 13:28:55 +0000
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
Subject: [PATCH 41/44] powerpc/cell: clean up fixed mapping dma_ops initialization
Date:   Thu,  8 Jun 2017 15:26:06 +0200
Message-Id: <20170608132609.32662-42-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58351
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

By the time cell_pci_dma_dev_setup calls cell_dma_dev_setup no device can
have the fixed map_ops set yet as it's only set by the set_dma_mask
method.  So move the setup for the fixed case to be only called in that
place instead of indirecting through cell_dma_dev_setup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/cell/iommu.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 948086e33a0c..497bfbdbd967 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -663,14 +663,9 @@ static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.mapping_error	= dma_iommu_mapping_error,
 };
 
-static void cell_dma_dev_setup_fixed(struct device *dev);
-
 static void cell_dma_dev_setup(struct device *dev)
 {
-	/* Order is important here, these are not mutually exclusive */
-	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
-		cell_dma_dev_setup_fixed(dev);
-	else if (get_pci_dma_ops() == &dma_iommu_ops)
+	if (get_pci_dma_ops() == &dma_iommu_ops)
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
 	else if (get_pci_dma_ops() == &dma_direct_ops)
 		set_dma_offset(dev, cell_dma_direct_offset);
@@ -963,32 +958,24 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
 		return -EIO;
 
 	if (dma_mask == DMA_BIT_MASK(64) &&
-		cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR)
-	{
+	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
+		u64 addr = cell_iommu_get_fixed_address(dev) +
+			dma_iommu_fixed_base;
 		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
+		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 		set_dma_ops(dev, &dma_iommu_fixed_ops);
+		set_dma_offset(dev, addr);
 	} else {
 		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
 		set_dma_ops(dev, get_pci_dma_ops());
+		cell_dma_dev_setup(dev);
 	}
 
-	cell_dma_dev_setup(dev);
-
 	*dev->dma_mask = dma_mask;
 
 	return 0;
 }
 
-static void cell_dma_dev_setup_fixed(struct device *dev)
-{
-	u64 addr;
-
-	addr = cell_iommu_get_fixed_address(dev) + dma_iommu_fixed_base;
-	set_dma_offset(dev, addr);
-
-	dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
-}
-
 static void insert_16M_pte(unsigned long addr, unsigned long *ptab,
 			   unsigned long base_pte)
 {
-- 
2.11.0
