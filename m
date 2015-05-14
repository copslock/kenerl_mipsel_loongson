Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 03:49:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18120 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026740AbbENBtbGOHtQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 03:49:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C386A353AB0D8;
        Thu, 14 May 2015 02:49:26 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 14 May
 2015 02:49:27 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 14 May
 2015 02:49:26 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 13 May
 2015 18:49:24 -0700
Subject: [PATCH] MIPS: Flush cache after DMA_FROM_DEVICE for agressively
 speculative CPUs
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <mina86@mina86.com>, <linux-mips@linux-mips.org>,
        <Zubair.Kakakhel@imgtec.com>, <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 13 May 2015 18:49:24 -0700
Message-ID: <20150514014924.36593.68642.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Some MIPS CPUs have an aggressive speculative load and may erroneuosly load
some cache line in the middle of DMA transaction. CPU discards result but cache
doesn't. If DMA happens from device then additional cache invalidation is needed
on that CPU's after DMA.

Found in test.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/mm/dma-default.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 609d1241b0c4..ccf49ecfbf8c 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -67,11 +67,13 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  * systems and only the R10000 and R12000 are used in such systems, the
  * SGI IP28 Indigo² rsp. SGI IP32 aka O2.
  */
-static inline int cpu_needs_post_dma_flush(struct device *dev)
+static inline int cpu_needs_post_dma_flush(struct device *dev,
+					   enum dma_data_direction direction)
 {
 	return !plat_device_is_coherent(dev) &&
 	       (boot_cpu_type() == CPU_R10000 ||
 		boot_cpu_type() == CPU_R12000 ||
+		(cpu_has_maar && (direction != DMA_TO_DEVICE)) ||
 		boot_cpu_type() == CPU_BMIPS5000);
 }
 
@@ -255,7 +257,7 @@ static inline void __dma_sync(struct page *page,
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
-	if (cpu_needs_post_dma_flush(dev))
+	if (cpu_needs_post_dma_flush(dev, direction))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
 			   dma_addr & ~PAGE_MASK, size, direction);
 	plat_post_dma_flush(dev);
@@ -309,7 +311,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 static void mips_dma_sync_single_for_cpu(struct device *dev,
 	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	if (cpu_needs_post_dma_flush(dev))
+	if (cpu_needs_post_dma_flush(dev, direction))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
 			   dma_handle & ~PAGE_MASK, size, direction);
 	plat_post_dma_flush(dev);
@@ -328,7 +330,7 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
 {
 	int i;
 
-	if (cpu_needs_post_dma_flush(dev))
+	if (cpu_needs_post_dma_flush(dev, direction))
 		for (i = 0; i < nelems; i++, sg++)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
