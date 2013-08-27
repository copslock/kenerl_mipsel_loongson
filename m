Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Aug 2013 22:58:27 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1972 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865339Ab3H0U6XXadT0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Aug 2013 22:58:23 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 27 Aug 2013 13:47:54 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 27 Aug 2013 13:58:08 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 27 Aug 2013 13:58:09 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 13A78F2D7E; Tue, 27
 Aug 2013 13:58:06 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     cernekee@gmail.com, "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH] MIPS: dma: if BMIPS5000, flush region just like r10000
Date:   Tue, 27 Aug 2013 16:57:51 -0400
Message-ID: <1377637071-32740-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
X-WSS-ID: 7E03CFF02L878700700-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

The BMIPS5000 (Zephyr) processor utilizes instruction speculation. A
stale misprediction address in either the JTB or the CRS may trigger
a prefetch inside a region that is currently being used by a DMA
engine, which is not IO-coherent.  This prefetch will fetch a line
into the scache, and that line will soon become stale (ie wrong)
during/after the DMA.  Mayhem ensues.

In dma-default.c, the r10000 is handled as a special case in the
same way that we want to handle Zephyr.  So we generalize the
exception cases into a function, and include Zephyr as one
of the processors that needs this special care.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/mm/dma-default.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index aaccf1c..468f7f9 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -50,16 +50,20 @@ static inline struct page *dma_addr_to_page(struct device *dev,
 }
 
 /*
+ * The affected CPUs below in 'cpu_needs_post_dma_flush()' can
+ * speculatively fill random cachelines with stale data at any time,
+ * requiring an extra flush post-DMA.
+ *
  * Warning on the terminology - Linux calls an uncached area coherent;
  * MIPS terminology calls memory areas with hardware maintained coherency
  * coherent.
  */
-
-static inline int cpu_is_noncoherent_r10000(struct device *dev)
+static inline int cpu_needs_post_dma_flush(struct device *dev)
 {
 	return !plat_device_is_coherent(dev) &&
 	       (current_cpu_type() == CPU_R10000 ||
-	       current_cpu_type() == CPU_R12000);
+		current_cpu_type() == CPU_R12000 ||
+		current_cpu_type() == CPU_BMIPS5000);
 }
 
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
@@ -230,7 +234,7 @@ static inline void __dma_sync(struct page *page,
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
-	if (cpu_is_noncoherent_r10000(dev))
+	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
 			   dma_addr & ~PAGE_MASK, size, direction);
 
@@ -284,7 +288,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 static void mips_dma_sync_single_for_cpu(struct device *dev,
 	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	if (cpu_is_noncoherent_r10000(dev))
+	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
 			   dma_handle & ~PAGE_MASK, size, direction);
 }
@@ -305,7 +309,7 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
-		if (cpu_is_noncoherent_r10000(dev))
+		if (cpu_needs_post_dma_flush(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
 	}
-- 
1.7.6
