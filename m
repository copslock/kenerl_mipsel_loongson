Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 09:58:56 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:45905 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeALIoJITCBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:44:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=daXQo6Y99hwpSpRDFBCb2+LAWBz1XhosisIRKsz/OLU=; b=cXXon/DSrsFaQMuqMZ3Ylv5OE
        OzvJL0X/Y+fqcgnelwYtGPYiGxBeWNczHty1nmepn/VG4J8cDFm5JbANFafpa/t5f8Es24QdQVljN
        ZBfULscNYmWXV314WJRoms4hB4bsan4XklBkay2eHlAF955IcXMPz4BSSzZtftTdOnXI+Qo3vi33k
        uI8BxqaWhzvmDkYbpLJ08tCUVOEK/edEtZgeLJTICakI6CO8nXh3RBRYrcpYTbsAmLPEQd5U/xKI4
        ptSjjvAG88UF6H3GDhwRelC/XpXp+3Gr3CqZCNK2pSXbnRgTWrkGEst5dApDoZUX+XSZVm/QWLeaA
        Blo/YsRQA==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuvz-00083a-Rm; Fri, 12 Jan 2018 08:43:32 +0000
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
Subject: [PATCH 17/34] microblaze: remove dma_nommu_dma_supported
Date:   Fri, 12 Jan 2018 09:42:15 +0100
Message-Id: <20180112084232.2857-18-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62079
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

Always returning 1 is the same behavior as not supplying a method at all.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/kernel/dma.c | 6 ------
 arch/parisc/kernel/pci-dma.c | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 450803e5731a..b45d8f8967af 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -89,11 +89,6 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static int dma_nommu_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static inline dma_addr_t dma_nommu_map_page(struct device *dev,
 					     struct page *page,
 					     unsigned long offset,
@@ -209,7 +204,6 @@ const struct dma_map_ops dma_nommu_ops = {
 	.free			= dma_nommu_free_coherent,
 	.mmap			= dma_nommu_mmap_coherent,
 	.map_sg			= dma_nommu_map_sg,
-	.dma_supported		= dma_nommu_dma_supported,
 	.map_page		= dma_nommu_map_page,
 	.unmap_page		= dma_nommu_unmap_page,
 	.sync_single_for_cpu	= dma_nommu_sync_single_for_cpu,
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index c0dfd892f70c..91bc0cac03a1 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -75,11 +75,6 @@ void dump_resmap(void)
 static inline void dump_resmap(void) {;}
 #endif
 
-static int pa11_dma_supported( struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static inline int map_pte_uncached(pte_t * pte,
 		unsigned long vaddr,
 		unsigned long size, unsigned long *paddr_ptr)
@@ -579,7 +574,6 @@ static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 }
 
 const struct dma_map_ops pcxl_dma_ops = {
-	.dma_supported =	pa11_dma_supported,
 	.alloc =		pa11_dma_alloc,
 	.free =			pa11_dma_free,
 	.map_page =		pa11_dma_map_page,
@@ -616,7 +610,6 @@ static void pcx_dma_free(struct device *dev, size_t size, void *vaddr,
 }
 
 const struct dma_map_ops pcx_dma_ops = {
-	.dma_supported =	pa11_dma_supported,
 	.alloc =		pcx_dma_alloc,
 	.free =			pcx_dma_free,
 	.map_page =		pa11_dma_map_page,
-- 
2.14.2
