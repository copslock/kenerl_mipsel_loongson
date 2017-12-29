Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:38:06 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:59984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbdL2IWkkkQAC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:22:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1BBdoYoM/l6UKm5TJFRDYhOpw9JKiFvz2Ru2EyqoXcM=; b=RLBle+Rd62xCr23QDGYOwM0I/
        hyu5giqRxLqsVZhdmWKLd+VdJ3UGCSPwjCw5S3JgCmgqEiOSC00Y7B0xMLoMDJDATe3oeO3RIClVX
        U6AMnILaJqb4M4O87c6NKLXAZ/DWQfwlY1Q4HvuXdth+nWuz649zvbgF3zpXjSTb2/ntpUSY+i833
        ggPG79uJTA7J9iIcSiZBe14NkDC0wih6QR9eTA7S0X3zu7JFTyIvqg2Dgup2XvExXSwJ6+Iftl2lZ
        IIHUR7ahhsVOF/OWO0wlJzDBpVpmVn2IXGOGNV1hYhjCzlC40hEyH0kwvtW2eRYlN43FlaKU0Dt2M
        5MKH04Vjg==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpvn-0002uK-W4; Fri, 29 Dec 2017 08:22:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 42/67] arm64: rename swiotlb_dma_ops
Date:   Fri, 29 Dec 2017 09:18:46 +0100
Message-Id: <20171229081911.2802-43-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61739
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
