Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:10:38 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:34804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011254AbbHLHJAGSatj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:09:00 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQ9c-0001VM-Gw; Wed, 12 Aug 2015 07:08:52 +0000
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
Subject: [PATCH 05/31] x86/pci-calgary: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:24 +0200
Message-Id: <1439363150-8661-6-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48781
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

For the iommu offset we just need and offset into the page.  Calculate
that using the physical address instead of using the virtual address
so that we don't require a virtual mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-calgary_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 0497f71..8f1581d 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -368,16 +368,14 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 {
 	struct iommu_table *tbl = find_iommu_table(dev);
 	struct scatterlist *s;
-	unsigned long vaddr;
+	unsigned long paddr;
 	unsigned int npages;
 	unsigned long entry;
 	int i;
 
 	for_each_sg(sg, s, nelems, i) {
-		BUG_ON(!sg_page(s));
-
-		vaddr = (unsigned long) sg_virt(s);
-		npages = iommu_num_pages(vaddr, s->length, PAGE_SIZE);
+		paddr = sg_phys(s);
+		npages = iommu_num_pages(paddr, s->length, PAGE_SIZE);
 
 		entry = iommu_range_alloc(dev, tbl, npages);
 		if (entry == DMA_ERROR_CODE) {
@@ -389,7 +387,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 		s->dma_address = (entry << PAGE_SHIFT) | s->offset;
 
 		/* insert into HW table */
-		tce_build(tbl, entry, npages, vaddr & PAGE_MASK, dir);
+		tce_build(tbl, entry, npages, paddr & PAGE_MASK, dir);
 
 		s->dma_length = s->length;
 	}
-- 
1.9.1
