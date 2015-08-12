Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:09:56 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:34775 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011012AbbHLHI5uwDwj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:08:57 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQ9W-0001Sv-PX; Wed, 12 Aug 2015 07:08:47 +0000
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
Subject: [PATCH 03/31] dma-debug: handle page-less SG entries
Date:   Wed, 12 Aug 2015 09:05:22 +0200
Message-Id: <1439363150-8661-4-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48779
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

Use sg_pfn to get a the PFN and skip checks that require a kernel
virtual address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index dace71f..a215a80 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -1368,7 +1368,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		entry->type           = dma_debug_sg;
 		entry->dev            = dev;
-		entry->pfn	      = page_to_pfn(sg_page(s));
+		entry->pfn	      = sg_pfn(s);
 		entry->offset	      = s->offset,
 		entry->size           = sg_dma_len(s);
 		entry->dev_addr       = sg_dma_address(s);
@@ -1376,7 +1376,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		entry->sg_call_ents   = nents;
 		entry->sg_mapped_ents = mapped_ents;
 
-		if (!PageHighMem(sg_page(s))) {
+		if (sg_has_page(s) && !PageHighMem(sg_page(s))) {
 			check_for_stack(dev, sg_virt(s));
 			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
 		}
@@ -1419,7 +1419,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
+			.pfn		= sg_pfn(s),
 			.offset		= s->offset,
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
@@ -1580,7 +1580,7 @@ void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
+			.pfn		= sg_pfn(s),
 			.offset		= s->offset,
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
@@ -1613,7 +1613,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
+			.pfn		= sg_pfn(s),
 			.offset		= s->offset,
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
-- 
1.9.1
