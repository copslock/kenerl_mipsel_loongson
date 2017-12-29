Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:27:22 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:60181 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990419AbdL2IUvHMNHC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:20:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TAWJDWl12CUmw3M57Gc/tzjmviVJ2G12h+r5PVnMQyI=; b=Rdks+64yQN1nHTniS/gshdFsX
        qy0LH4w4mqMXT3C4LpxJBGt5U59DFGeu82b7iqr0UM/o+p/JOUXIBYLcO3f1e4ClfL3mQ5P9nurTp
        PGV7FNeta0hQAieHxAeEdDmbwU3Nz2xosc2+JKxbI8IIcVoDNG5IBHtkIfv5N8gWIn8QmSMF4sptL
        vxdvcM9mg/yMCudcABMib3o5/Wu0bU/9166Uj5lzcI0+bqPsIsnyMgQszE4rP8geX3inPKrkWzEpu
        Xh3nc784hUJ34LyjbiBY+mmwKutSMbE8zGLoV1yHOkiAMRXAPlnZuy7rdewwTcaXcHlprLbhU9p4L
        08pmlVkqg==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpu9-000145-5A; Fri, 29 Dec 2017 08:20:37 +0000
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
Subject: [PATCH 18/67] microblaze: remove dma_nommu_dma_supported
Date:   Fri, 29 Dec 2017 09:18:22 +0100
Message-Id: <20171229081911.2802-19-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61715
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
index 364b0ac41452..49b09648679b 100644
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
index 6ad9aed3d025..2a05457f7aab 100644
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
@@ -617,7 +611,6 @@ static void pcx_dma_free(struct device *dev, size_t size, void *vaddr,
 }
 
 const struct dma_map_ops pcx_dma_ops = {
-	.dma_supported =	pa11_dma_supported,
 	.alloc =		pcx_dma_alloc,
 	.free =			pcx_dma_free,
 	.map_page =		pa11_dma_map_page,
-- 
2.14.2
