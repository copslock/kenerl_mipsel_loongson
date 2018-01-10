Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:11:35 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:59040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeAJICA32wiS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:02:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XvO4LK7WFMilh/eZRq/xi/V4zyeVZJH/9zNVK0M2kCU=; b=W8LceMUzgjVKt2EtfqF9cga5g
        dSHJca2YCxmY0eQv43yAaimKzaAN6TdHmV6ldLQyoGDuRD+4Vnnsh3JPpgI8cRbBfD6kTfADisoz0
        dWtSJenAa32a9NQbW7fy5eFrBf/1sNdHeywrFEMpZxGtvD3KATmHoBeuV88BKsnhdqUJe1rxMxCnD
        TNgpZ2pwcDb53ZwsAiy4N4YKVx/2oWUzeAxfKKR8m1QR5qTzGRblgAq5O59E3u6qTXgzYPmPTgKMN
        Mv94YIsinyFdOwyQohdmP4ydthnHZW+39/ranixxCz2YF/rP8cPag436mVpFe2aXOwv8Ejc1L1tFq
        bTmMitRYA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBKT-0005OU-RH; Wed, 10 Jan 2018 08:01:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/33] dma-direct: add dma address sanity checks
Date:   Wed, 10 Jan 2018 09:00:19 +0100
Message-Id: <20180110080027.13879-26-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61991
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

Roughly based on the x86 pci-nommu implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 12ea9653781b..32fd4d9e4c47 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -9,6 +9,23 @@
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
 
+#define DIRECT_MAPPING_ERROR		0
+
+static bool
+check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
+		const char *caller)
+{
+	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
+		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
+			dev_err(dev,
+				"%s: overflow %pad+%zu of device mask %llx\n",
+				caller, &dma_addr, size, *dev->dma_mask);
+		}
+		return false;
+	}
+	return true;
+}
+
 static void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -31,7 +48,11 @@ static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	return phys_to_dma(dev, page_to_phys(page)) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, page_to_phys(page)) + offset;
+
+	if (!check_addr(dev, dma_addr, size, __func__))
+		return DIRECT_MAPPING_ERROR;
+	return dma_addr;
 }
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
@@ -44,16 +65,24 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 		BUG_ON(!sg_page(sg));
 
 		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
+		if (!check_addr(dev, sg_dma_address(sg), sg->length, __func__))
+			return 0;
 		sg_dma_len(sg) = sg->length;
 	}
 
 	return nents;
 }
 
+static int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == DIRECT_MAPPING_ERROR;
+}
+
 const struct dma_map_ops dma_direct_ops = {
 	.alloc			= dma_direct_alloc,
 	.free			= dma_direct_free,
 	.map_page		= dma_direct_map_page,
 	.map_sg			= dma_direct_map_sg,
+	.mapping_error		= dma_direct_mapping_error,
 };
 EXPORT_SYMBOL(dma_direct_ops);
-- 
2.14.2
