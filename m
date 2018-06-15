Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:11:16 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeFOLJUpLJXT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ppIZLEE00FrTyH+ESGTzwZE3vSCJnq2qUHGULF+YQxQ=; b=hUq+Iqyhw0liJ3pxr8GijLRot
        bES6Ie/1gXRqcpsIZM3iJPTPZjNaSqEcRt88fPZSiSNGm7fWgtefCsgC4gAtq32YjUK0pw+nbGsG8
        ljX00qF04q1RhOFRrok8bUgQzv7YkPANI8VxuK9Ubh9G6JT5qUITXcu4mXlUT+crvAZg718p2OhgW
        j/84RmPx4MOw0TIv+d8hzqGjbWeFXvJnHDnIomtcYFto1svLhPdNZL1OwSEcV3h4Mr0m6CXX6T+SS
        OFEuD8yynwstFPMFL4KB2PsTh26crsdDiKuqQmLILFKUkLiNKbVcmDRittzRqZWSQ+fxWOMEukylP
        y1POc6ojg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbW-0004v0-9l; Fri, 15 Jun 2018 11:09:18 +0000
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
Subject: [PATCH 06/25] MIPS: loongson: remove loongson_dma_supported
Date:   Fri, 15 Jun 2018 13:08:35 +0200
Message-Id: <20180615110854.19253-7-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64287
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

swiotlb_dma_supported will always return true for a mask large enough to
cover the DMA addresses for all physical memory, which is the right
thing to do for swiotlb based dma ops.  This function returned false
if the mask was bigger than a firmware set dma_mask_bits that apparently
can be either 32 or 64, and which seems completely buggys if it actually
is not 64, as the false return negates the whole point of swiotlb.

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
2.17.1
