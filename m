Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:18:11 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:35283 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011462AbbHLHKL2dXOj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:10:11 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQAl-0001wn-QG; Wed, 12 Aug 2015 07:10:04 +0000
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
Subject: [PATCH 29/31] parisc: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:48 +0200
Message-Id: <1439363150-8661-30-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48805
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

Make all cache invalidation conditional on sg_has_page() and use
sg_phys to get the physical address directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/kernel/pci-dma.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index b9402c9..6cad0e0 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -483,11 +483,13 @@ static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist, int n
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sglist, sg, nents, i) {
-		unsigned long vaddr = (unsigned long)sg_virt(sg);
-
-		sg_dma_address(sg) = (dma_addr_t) virt_to_phys(vaddr);
+		sg_dma_address(sg) = sg_phys(sg);
 		sg_dma_len(sg) = sg->length;
-		flush_kernel_dcache_range(vaddr, sg->length);
+
+		if (sg_has_page(sg)) {
+			flush_kernel_dcache_range((unsigned long)sg_virt(sg),
+						  sg->length);
+		}
 	}
 	return nents;
 }
@@ -504,9 +506,10 @@ static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist, in
 
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
-	return;
+	for_each_sg(sglist, sg, nents, i) {
+		if (sg_has_page(sg))
+			flush_kernel_vmap_range(sg_virt(sg), sg->length);
+	}
 }
 
 static void pa11_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, unsigned long offset, size_t size, enum dma_data_direction direction)
@@ -530,8 +533,10 @@ static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl
 
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+	for_each_sg(sglist, sg, nents, i) {
+		if (sg_has_page(sg))
+			flush_kernel_vmap_range(sg_virt(sg), sg->length);
+	}
 }
 
 static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
@@ -541,8 +546,10 @@ static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *
 
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+	for_each_sg(sglist, sg, nents, i) {
+		if (sg_has_page(sg))
+			flush_kernel_vmap_range(sg_virt(sg), sg->length);
+	}
 }
 
 struct hppa_dma_ops pcxl_dma_ops = {
-- 
1.9.1
