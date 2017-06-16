Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:29:06 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:54773 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994905AbdFPSNsAR2NW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:13:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lR6x5uNOAP+GhigMbCiwoL6Qu+Q3Ix9NaMyJN6X36xY=; b=jtup0k+m1VsOa264Mk8Lrz2Sq
        h5Fy9v49r2kfCPC4uL2OIf/0/cAQ805LjUDXaKIamo9ZSDF8n0he5o+vxervF75DqtfVPxUYWMlpn
        F9KBFDFlITK7KJIwulQsXg7hhzxyINnuuCNaH1VnlZb4U29LyTKx3SnFwM4c09JW7jS2voAWT78xZ
        ChzUZdIrCH2DmF24wFlswWFmXebapcx9fOfRQCDkeHCrHOD5e8NSLuhLGdQCRKFhi+G1TDpCDquFM
        jwOzjHget5lSKHJB0TKJlXUJTE9Liy5qaOfrqD9UQb4rKXE1UVXLhq2putcDELO5kNo+mBNZ5Wsln
        zo2QHs7kg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvkZ-0007IX-Ar; Fri, 16 Jun 2017 18:13:40 +0000
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
Subject: [PATCH 43/44] dma-mapping: remove the set_dma_mask method
Date:   Fri, 16 Jun 2017 20:10:58 +0200
Message-Id: <20170616181059.19206-44-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58573
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma.c   | 4 ----
 include/linux/dma-mapping.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 41c749586bd2..466c9f07b288 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -316,10 +316,6 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
 
 int __dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	const struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if ((dma_ops != NULL) && (dma_ops->set_dma_mask != NULL))
-		return dma_ops->set_dma_mask(dev, dma_mask);
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 	*dev->dma_mask = dma_mask;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 3e5908656226..527f2ed8c645 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -127,7 +127,6 @@ struct dma_map_ops {
 				   enum dma_data_direction dir);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
-	int (*set_dma_mask)(struct device *dev, u64 mask);
 #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
 #endif
@@ -563,11 +562,6 @@ static inline int dma_supported(struct device *dev, u64 mask)
 #ifndef HAVE_ARCH_DMA_SET_MASK
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops->set_dma_mask)
-		return ops->set_dma_mask(dev, mask);
-
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
 	*dev->dma_mask = mask;
-- 
2.11.0
