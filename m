Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 22:08:59 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57489 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867263Ab3LRVI4QpFVl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Dec 2013 22:08:56 +0100
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3C812800;
        Wed, 18 Dec 2013 21:08:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        linux-mips@linux-mips.org, cernekee@gmail.com,
        Ralf Baechle <ralf@linux-mips.org>,
        John Ulvr <julvr@broadcom.com>
Subject: [PATCH 3.4 01/31] MIPS: DMA: For BMIPS5000 cores flush region just like non-coherent R10000
Date:   Wed, 18 Dec 2013 13:08:09 -0800
Message-Id: <20131218210522.833580254@linuxfoundation.org>
X-Mailer: git-send-email 1.8.5.1.163.gd7aced9
In-Reply-To: <20131218210522.790152625@linuxfoundation.org>
References: <20131218210522.790152625@linuxfoundation.org>
User-Agent: quilt/0.61-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Quinlan <jim2101024@gmail.com>

commit f86f55d3ad21b21b736bdeb29bee0f0937b77138 upstream.

The BMIPS5000 (Zephyr) processor utilizes instruction speculation. A
stale misprediction address in either the JTB or the CRS may trigger
a prefetch inside a region that is currently being used by a DMA engine,
which is not IO-coherent.  This prefetch will fetch a line into the
scache, and that line will soon become stale (ie wrong) during/after the
DMA.  Mayhem ensues.

In dma-default.c, the r10000 is handled as a special case in the same way
that we want to handle Zephyr.  So we generalize the exception cases into
a function, and include Zephyr as one of the processors that needs this
special care.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: cernekee@gmail.com
Patchwork: https://patchwork.linux-mips.org/patch/5776/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: John Ulvr <julvr@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/dma-default.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -30,16 +30,20 @@ static inline struct page *dma_addr_to_p
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
@@ -209,7 +213,7 @@ static inline void __dma_sync(struct pag
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
-	if (cpu_is_noncoherent_r10000(dev))
+	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
 			   dma_addr & ~PAGE_MASK, size, direction);
 
@@ -260,7 +264,7 @@ static void mips_dma_unmap_sg(struct dev
 static void mips_dma_sync_single_for_cpu(struct device *dev,
 	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	if (cpu_is_noncoherent_r10000(dev))
+	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
 			   dma_handle & ~PAGE_MASK, size, direction);
 }
@@ -281,7 +285,7 @@ static void mips_dma_sync_sg_for_cpu(str
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
-		if (cpu_is_noncoherent_r10000(dev))
+		if (cpu_needs_post_dma_flush(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
 	}
