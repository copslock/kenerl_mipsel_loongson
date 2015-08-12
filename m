Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:12:27 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:34929 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010957AbbHLHJRqC4gj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:09:17 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQ9u-0001cf-2B; Wed, 12 Aug 2015 07:09:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org, axboe@kernel.dk
Cc:     dan.j.williams@intel.com, vgupta@synopsys.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        dhowells@redhat.com, monstr@monstr.eu, x86@kernel.org,
        dwmw2@infradead.org, alex.williamson@redhat.com,
        grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-nvdimm@ml01.01.org, linux-media@vger.kernel.org
Subject: [PATCH 11/31] sparc/iommu: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:30 +0200
Message-Id: <1439363150-8661-12-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48787
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

Use sg_phys() instead of __pa(sg_virt(sg)) so that we don't
require a kernel virtual address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c        | 2 +-
 arch/sparc/kernel/iommu_common.h | 4 +---
 arch/sparc/kernel/pci_sun4v.c    | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 5320689..2ad89d2 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -486,7 +486,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			continue;
 		}
 		/* Allocate iommu entries for that segment */
-		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
+		paddr = sg_phys(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
 		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
 					      &handle, (unsigned long)(-1), 0);
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index b40cec2..8e2c211 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -33,15 +33,13 @@
  */
 #define IOMMU_PAGE_SHIFT		13
 
-#define SG_ENT_PHYS_ADDRESS(SG)	(__pa(sg_virt((SG))))
-
 static inline int is_span_boundary(unsigned long entry,
 				   unsigned long shift,
 				   unsigned long boundary_size,
 				   struct scatterlist *outs,
 				   struct scatterlist *sg)
 {
-	unsigned long paddr = SG_ENT_PHYS_ADDRESS(outs);
+	unsigned long paddr = sg_phys(outs);
 	int nr = iommu_num_pages(paddr, outs->dma_length + sg->length,
 				 IO_PAGE_SIZE);
 
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index d2fe57d..a7a6e41 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -370,7 +370,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			continue;
 		}
 		/* Allocate iommu entries for that segment */
-		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
+		paddr = sg_phys(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
 		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
 					      &handle, (unsigned long)(-1), 0);
-- 
1.9.1
