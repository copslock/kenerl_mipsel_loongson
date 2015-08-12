Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:14:55 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:35077 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012073AbbHLHJnwT1Vj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:09:43 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQAH-0001lK-5m; Wed, 12 Aug 2015 07:09:33 +0000
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
Subject: [PATCH 19/31] arc: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:38 +0200
Message-Id: <1439363150-8661-20-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48795
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
 arch/arc/include/asm/dma-mapping.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
index 2d28ba9..42eb526 100644
--- a/arch/arc/include/asm/dma-mapping.h
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -108,9 +108,13 @@ dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *s;
 	int i;
 
-	for_each_sg(sg, s, nents, i)
-		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir);
+	for_each_sg(sg, s, nents, i) {
+		if (sg_has_page(s)) {
+			_dma_cache_sync((unsigned long)sg_virt(s), s->length,
+					dir);
+		}
+		s->dma_address = sg_phys(s);
+	}
 
 	return nents;
 }
@@ -163,8 +167,12 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg)) {
+			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,
+					dir);
+		}
+	}
 }
 
 static inline void
@@ -174,8 +182,12 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg)) {
+			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,
+				dir);
+		}
+	}
 }
 
 static inline int dma_supported(struct device *dev, u64 dma_mask)
-- 
1.9.1
