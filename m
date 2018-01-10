Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:19:58 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:40442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994586AbeAJIKSxlhoS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8KpO5Xt8AsLvC7+uYTdlCjY1ufli+t1solsOWE87rJk=; b=jSzzeoXNrd8sH7ECebpMuJOAU
        4+XXr+feC3QM0ZGkTOwQZ5VmO/4330f1wkomcdTkOCcYHhONf71Ar/Bo11rtyaCBz2PBnW8mFSJrX
        7+E+BFechmj68P1iPgLC/9Kc3yY2eQdHPvuJMY6jUsCeDHCUxcM7oOz+0eqE1J7E/RSSCwplYF/iJ
        x0xRBOn9fRxMlZJk9fu2zeQZ2chbyNoynFrI+hsacfsgriQNmePD7zdUxTTmBgGtg6wtTKp5LP1mA
        NQpOc/l9OQkGk4NXIV92dpmOmintjEF9YjA9qpFrffJZQoh4y3oHZM6bBSarFQqtbYW0rZXJI/E05
        A3YvD9ZCA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSb-0008SR-Mk; Wed, 10 Jan 2018 08:10:10 +0000
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
Subject: [PATCH 12/22] ia64: replace ZONE_DMA with ZONE_DMA32
Date:   Wed, 10 Jan 2018 09:09:22 +0100
Message-Id: <20180110080932.14157-13-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62011
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

ia64 uses ZONE_DMA for allocations below 32-bits.  These days we
name the zone for that ZONE_DMA32, which will allow to use the
dma-direct and generic swiotlb code as-is, so rename it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/Kconfig              | 2 +-
 arch/ia64/kernel/pci-swiotlb.c | 2 +-
 arch/ia64/mm/contig.c          | 4 ++--
 arch/ia64/mm/discontig.c       | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 4d18fca885ee..888acdb163cb 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -66,7 +66,7 @@ config 64BIT
 	select ATA_NONSTANDARD if ATA
 	default y
 
-config ZONE_DMA
+config ZONE_DMA32
 	def_bool y
 	depends on !IA64_SGI_SN2
 
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index f1ae873a8c35..4a9a6e58ad6a 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -20,7 +20,7 @@ static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 unsigned long attrs)
 {
 	if (dev->coherent_dma_mask != DMA_BIT_MASK(64))
-		gfp |= GFP_DMA;
+		gfp |= GFP_DMA32;
 	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
 }
 
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 52715a71aede..7d64b30913d1 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -237,9 +237,9 @@ paging_init (void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	max_zone_pfns[ZONE_DMA] = max_dma;
+	max_zone_pfns[ZONE_DMA32] = max_dma;
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 9b2d994cddf6..ac46f0d60b66 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -38,7 +38,7 @@ struct early_node_data {
 	struct ia64_node_data *node_data;
 	unsigned long pernode_addr;
 	unsigned long pernode_size;
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	unsigned long num_dma_physpages;
 #endif
 	unsigned long min_pfn;
@@ -669,7 +669,7 @@ static __init int count_node_pages(unsigned long start, unsigned long len, int n
 {
 	unsigned long end = start + len;
 
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	if (start <= __pa(MAX_DMA_ADDRESS))
 		mem_data[node].num_dma_physpages +=
 			(min(end, __pa(MAX_DMA_ADDRESS)) - start) >>PAGE_SHIFT;
@@ -724,8 +724,8 @@ void __init paging_init(void)
 	}
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-#ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA] = max_dma;
+#ifdef CONFIG_ZONE_DMA32
+	max_zone_pfns[ZONE_DMA32] = max_dma;
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 	free_area_init_nodes(max_zone_pfns);
-- 
2.14.2
