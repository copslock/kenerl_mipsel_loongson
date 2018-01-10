Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:15:40 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:51265 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994585AbeAJIJto8lKS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:09:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1BBdoYoM/l6UKm5TJFRDYhOpw9JKiFvz2Ru2EyqoXcM=; b=qjsZ8dmWYlMdKg7Sks1clhqzv
        vu2xGR3pF2mJyoH6DRlYHYRDtudeay6cp3MBwbROUx8bnDl2huANlXCyqjzH84430yzKoKAWdicm0
        6NVjXN8oJszvcfbIxdDLd22ObBmOpu5mvldj17L+bnfKwhyYMtda0jWd70GpDJHlj1U4VAUWEXDUw
        Aa6AyuLSel5B82VCyrsdzKoYgFCKJxHwh3DoEST2ivHmCgNkCS6/N4VF+2rCB4EBs0i8m4V/h0nm0
        p34gz+xKJsCbRr49EpysaPzSTFz9CPfYYljCxhyMBLFzOtGdLNO6A0Lj3zl4Y4S4oyTlnf1xLjRle
        J2mb3ACXw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBS8-0007kx-Oi; Wed, 10 Jan 2018 08:09:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/22] arm64: rename swiotlb_dma_ops
Date:   Wed, 10 Jan 2018 09:09:12 +0100
Message-Id: <20180110080932.14157-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62001
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

We'll need that name for a generic implementation soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index f3a637b98487..6840426bbe77 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -368,7 +368,7 @@ static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
 	return 0;
 }
 
-static const struct dma_map_ops swiotlb_dma_ops = {
+static const struct dma_map_ops arm64_swiotlb_dma_ops = {
 	.alloc = __dma_alloc,
 	.free = __dma_free,
 	.mmap = __swiotlb_mmap,
@@ -923,7 +923,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
 	if (!dev->dma_ops)
-		dev->dma_ops = &swiotlb_dma_ops;
+		dev->dma_ops = &arm64_swiotlb_dma_ops;
 
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
-- 
2.14.2
