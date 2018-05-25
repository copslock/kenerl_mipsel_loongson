Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:23:00 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbeEYJVfJ-e5A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aDKHxjHnbXKXgbAD5J3m1wBTukDs9KwmJnO9HYxIzWc=; b=pgZUZEkmJ/h0EMsVxPgPQxfqA
        FL6Ik1eKl6jYHuO9kmbHRbPKTuXqnuiyfccHv5T0vm4JF5NHHgMCQxzpNPTIccZsirLx0xh7++I0f
        2MhV4z56Z+fbg3L5/pyb4BmEOBpHhf+whin7zot8Nwtd0z/+6n+DRgchQSj1BCnYqlTcl3wj2/kLz
        Y2j7X4ySkBkLEZm1otta5kLcQ461NdHg+OWVtF8d8Lw0qoAyc15zweGxTeLslHpU4y0IvHyT31S12
        OKgWKrCE4760hPO1BRtxOogkG127sBwshtqcmpH9ZxQjksll9uPQyPgdhf09PPZ0ZbofLHByfoeCg
        9Rovb18DQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8uj-0001h2-F2; Fri, 25 May 2018 09:21:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 06/25] MIPS: loongson: remove loongson_dma_supported
Date:   Fri, 25 May 2018 11:20:52 +0200
Message-Id: <20180525092111.18516-7-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64019
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

swiotlb_dma_supported will always return true for the a mask
large enough to be covered by wired up physical address, so this
function is pointless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/loongson64/common/dma-swiotlb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 6a739f8ae110..a5e50f2ec301 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -56,13 +56,6 @@ static void loongson_dma_sync_sg_for_device(struct device *dev,
 	mb();
 }
 
-static int loongson_dma_supported(struct device *dev, u64 mask)
-{
-	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits))
-		return 0;
-	return swiotlb_dma_supported(dev, mask);
-}
-
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	long nid;
@@ -99,7 +92,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = loongson_dma_supported,
+	.dma_supported = swiotlb_dma_supported,
 };
 
 void __init plat_swiotlb_setup(void)
-- 
2.17.0
