Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:27:36 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4031 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818014Ab3FJH1Kb10vF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:27:10 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:23:20 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:26:58 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:26:59 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 41242F2D72; Mon, 10
 Jun 2013 00:26:56 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/2] MIPS: Netlogic: SWIOTLB dma ops for 32-bit DMA
Date:   Mon, 10 Jun 2013 12:58:09 +0530
Message-ID: <1370849289-4877-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849289-4877-1-git-send-email-jchandra@broadcom.com>
References: <1370849289-4877-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DABA16231W33899144-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Add SWIOTLB config option and related files to Netlogic platform.

Some XLP SoC components like the SD/MMC interface cannot do DMA beyond
32-bit physical address. The SD/MMC driver can use memory outside this
range for IO, to support this we have to add bounce buffers implemented
by SWIOTLB.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h |    3 +
 arch/mips/netlogic/Kconfig              |   11 ++++
 arch/mips/netlogic/common/Makefile      |    1 +
 arch/mips/netlogic/common/nlm-dma.c     |  107 +++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 arch/mips/netlogic/common/nlm-dma.c

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index aef560a..70351b9 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -76,6 +76,9 @@ void nlm_node_init(int node);
 extern struct plat_smp_ops nlm_smp_ops;
 extern char nlm_reset_entry[], nlm_reset_entry_end[];
 
+/* SWIOTLB */
+extern struct dma_map_ops nlm_swiotlb_dma_ops;
+
 extern unsigned int nlm_threads_per_core;
 extern cpumask_t nlm_cpumask;
 
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index e0873a3..2447bf9 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -51,4 +51,15 @@ endif
 config NLM_COMMON
 	bool
 
+config IOMMU_HELPER
+	bool
+
+config NEED_SG_DMA_LENGTH
+	bool
+
+config SWIOTLB
+	def_bool y
+	select NEED_SG_DMA_LENGTH
+	select IOMMU_HELPER
+
 endif
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index 291372a..b295497 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,3 +1,4 @@
 obj-y				+= irq.o time.o
+obj-y				+= nlm-dma.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
new file mode 100644
index 0000000..2e1d232
--- /dev/null
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -0,0 +1,107 @@
+/*
+*  Copyright (C) 2003-2013 Broadcom Corporation
+*  All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/bootmem.h>
+#include <linux/export.h>
+#include <linux/swiotlb.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+
+#include <asm/bootinfo.h>
+
+static char *nlm_swiotlb;
+
+static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
+	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	void *ret;
+
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+
+#ifdef CONFIG_ZONE_DMA32
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
+		gfp |= __GFP_DMA32;
+#endif
+
+	/* Don't invoke OOM killer */
+	gfp |= __GFP_NORETRY;
+
+	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+}
+
+static void nlm_dma_free_coherent(struct device *dev, size_t size,
+	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+{
+	int order = get_order(size);
+
+	if (dma_release_from_coherent(dev, order, vaddr))
+		return;
+
+	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+}
+
+struct dma_map_ops nlm_swiotlb_dma_ops = {
+	.alloc = nlm_dma_alloc_coherent,
+	.free = nlm_dma_free_coherent,
+	.map_page = swiotlb_map_page,
+	.unmap_page = swiotlb_unmap_page,
+	.map_sg = swiotlb_map_sg_attrs,
+	.unmap_sg = swiotlb_unmap_sg_attrs,
+	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
+	.sync_single_for_device = swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = swiotlb_sync_sg_for_device,
+	.mapping_error = swiotlb_dma_mapping_error,
+	.dma_supported = swiotlb_dma_supported
+};
+
+void __init plat_swiotlb_setup(void)
+{
+	size_t swiotlbsize;
+	unsigned long swiotlb_nslabs;
+
+	swiotlbsize = 1 << 20; /* 1 MB for now */
+	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
+	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
+	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
+
+	nlm_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
+	swiotlb_init_with_tbl(nlm_swiotlb, swiotlb_nslabs, 1);
+}
-- 
1.7.9.5
