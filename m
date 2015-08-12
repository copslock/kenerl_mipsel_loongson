Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:17:53 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:35252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011300AbbHLHKIGlXjj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:10:08 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQAi-0001v9-TQ; Wed, 12 Aug 2015 07:10:01 +0000
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
Subject: [PATCH 28/31] powerpc: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:47 +0200
Message-Id: <1439363150-8661-29-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48804
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

Make all cache invalidation conditional on sg_has_page().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 35e4dcc..cece40b 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -135,7 +135,10 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	for_each_sg(sgl, sg, nents, i) {
 		sg->dma_address = sg_phys(sg) + get_dma_offset(dev);
 		sg->dma_length = sg->length;
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		if (sg_has_page(sg)) {
+			__dma_sync_page(sg_page(sg), sg->offset, sg->length,
+					direction);
+		}
 	}
 
 	return nents;
@@ -200,7 +203,10 @@ static inline void dma_direct_sync_sg(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		if (sg_has_page(sg)) {
+			__dma_sync_page(sg_page(sg), sg->offset, sg->length,
+					direction);
+		}
 }
 
 static inline void dma_direct_sync_single(struct device *dev,
-- 
1.9.1
