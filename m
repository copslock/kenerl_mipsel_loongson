Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:13:59 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:35022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012011AbbHLHJb1B-pj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:09:31 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQA8-0001hl-Ek; Wed, 12 Aug 2015 07:09:24 +0000
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
Subject: [PATCH 16/31] s390: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:35 +0200
Message-Id: <1439363150-8661-17-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48792
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

Use sg_phys() instead of page_to_phys(sg_page(sg)) so that we don't
require a page structure for all DMA memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/pci/pci_dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 6fd8d58..aae5a47 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -272,14 +272,13 @@ int dma_set_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL_GPL(dma_set_mask);
 
-static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
-				     unsigned long offset, size_t size,
+static dma_addr_t s390_dma_map_phys(struct device *dev, unsigned long pa,
+				     size_t size,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs)
 {
 	struct zpci_dev *zdev = get_zdev(to_pci_dev(dev));
 	unsigned long nr_pages, iommu_page_index;
-	unsigned long pa = page_to_phys(page) + offset;
 	int flags = ZPCI_PTE_VALID;
 	dma_addr_t dma_addr;
 
@@ -301,7 +300,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 
 	if (!dma_update_trans(zdev, pa, dma_addr, size, flags)) {
 		atomic64_add(nr_pages, &zdev->mapped_pages);
-		return dma_addr + (offset & ~PAGE_MASK);
+		return dma_addr + (pa & ~PAGE_MASK);
 	}
 
 out_free:
@@ -312,6 +311,16 @@ out_err:
 	return DMA_ERROR_CODE;
 }
 
+static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
+{
+	unsigned long pa = page_to_phys(page) + offset;
+
+	return s390_dma_map_phys(dev, pa, size, direction, attrs);
+}
+
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
 				 struct dma_attrs *attrs)
@@ -384,8 +393,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nr_elements, i) {
-		struct page *page = sg_page(s);
-		s->dma_address = s390_dma_map_pages(dev, page, s->offset,
+		s->dma_address = s390_dma_map_phys(dev, sg_phys(s),
 						    s->length, dir, NULL);
 		if (!dma_mapping_error(dev, s->dma_address)) {
 			s->dma_length = s->length;
-- 
1.9.1
