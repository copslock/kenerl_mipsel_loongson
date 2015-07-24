Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 17:16:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24612 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010479AbbGXPQdHPNLG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 17:16:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1ECC74643246D
        for <linux-mips@linux-mips.org>; Fri, 24 Jul 2015 16:16:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Jul 2015 16:16:27 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.115) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 24 Jul 2015 16:16:26 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 2/3] MIPS: Add implementation of dma_map_ops.mmap() that handles write combining
Date:   Fri, 24 Jul 2015 16:16:11 +0100
Message-ID: <1437750972-3659-2-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437750972-3659-1-git-send-email-alex.smith@imgtec.com>
References: <1437750972-3659-1-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.115]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

The generic implementation of dma_map_ops.mmap(), dma_common_mmap(),
does not handle the DMA_ATTR_WRITE_COMBINE attribute and therefore
dma_mmap_writecombine() will not actually set the appropriate pgprot_t
flags for write combining.

Add an implementation of dma_map_ops.mmap() that will enable write
combining when requested.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/mm/dma-default.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index eeaf0245c3b1..949794007ab7 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -194,6 +194,34 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 		__free_pages(page, get_order(size));
 }
 
+static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+	void *cpu_addr, dma_addr_t dma_addr, size_t size,
+	struct dma_attrs *attrs)
+{
+	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
+	unsigned long off = vma->vm_pgoff;
+	int ret = -ENXIO;
+
+	if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off < count && user_count <= (count - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      user_count << PAGE_SHIFT,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
 static inline void __dma_sync_virtual(void *addr, size_t size,
 	enum dma_data_direction direction)
 {
@@ -380,6 +408,7 @@ EXPORT_SYMBOL(dma_cache_sync);
 static struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc = mips_dma_alloc_coherent,
 	.free = mips_dma_free_coherent,
+	.mmap = mips_dma_mmap,
 	.map_page = mips_dma_map_page,
 	.unmap_page = mips_dma_unmap_page,
 	.map_sg = mips_dma_map_sg,
-- 
2.4.6
