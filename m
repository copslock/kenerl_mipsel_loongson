Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:14:36 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:35061 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012049AbbHLHJiW6uAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:09:38 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQAE-0001kR-9A; Wed, 12 Aug 2015 07:09:30 +0000
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
Subject: [PATCH 18/31] nios2: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:37 +0200
Message-Id: <1439363150-8661-19-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48794
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
 arch/nios2/mm/dma-mapping.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index ac5da75..1a0a68d 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -64,13 +64,11 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	BUG_ON(!valid_dma_direction(direction));
 
 	for_each_sg(sg, sg, nents, i) {
-		void *addr;
-
-		addr = sg_virt(sg);
-		if (addr) {
-			__dma_sync_for_device(addr, sg->length, direction);
-			sg->dma_address = sg_phys(sg);
+		if (sg_has_page(sg)) {
+			__dma_sync_for_device(sg_virt(sg), sg->length,
+						direction);
 		}
+		sg->dma_address = sg_phys(sg);
 	}
 
 	return nents;
@@ -113,9 +111,8 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 		return;
 
 	for_each_sg(sg, sg, nhwentries, i) {
-		addr = sg_virt(sg);
-		if (addr)
-			__dma_sync_for_cpu(addr, sg->length, direction);
+		if (sg_has_page(sg))
+			__dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
 	}
 }
 EXPORT_SYMBOL(dma_unmap_sg);
@@ -166,8 +163,10 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 	BUG_ON(!valid_dma_direction(direction));
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for_each_sg(sg, sg, nelems, i)
-		__dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
+	for_each_sg(sg, sg, nelems, i) {
+		if (sg_has_page(sg))
+			__dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
+	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
 
@@ -179,8 +178,10 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	BUG_ON(!valid_dma_direction(direction));
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for_each_sg(sg, sg, nelems, i)
-		__dma_sync_for_device(sg_virt(sg), sg->length, direction);
-
+	for_each_sg(sg, sg, nelems, i) {
+		if (sg_has_page(sg))
+			__dma_sync_for_device(sg_virt(sg), sg->length,
+					direction);
+	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
-- 
1.9.1
