Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2015 13:04:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46203 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010607AbbG3LEYxN7Af (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2015 13:04:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A0543FC34FB24
        for <linux-mips@linux-mips.org>; Thu, 30 Jul 2015 12:04:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 30 Jul 2015 12:04:18 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.115) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 30 Jul 2015 12:04:18 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>,
        Sadegh Abbasi <Sadegh.Abbasi@imgtec.com>
Subject: [PATCH v2 2/3] MIPS: Add implementation of dma_map_ops.mmap()
Date:   Thu, 30 Jul 2015 12:03:42 +0100
Message-ID: <1438254222-15803-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1437750972-3659-2-git-send-email-alex.smith@imgtec.com>
References: <1437750972-3659-2-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.115]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48501
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
is not correct for non-coherent devices. It expects to be passed a
virtual address previously returned by dma_alloc_coherent(), which for
a non-coherent device will return a KSEG1 address. It then attempts to
convert that virtual address to a physical address using virt_to_page()
which will yield an incorrect address.

Also, dma_common_mmap() does not handle the DMA_ATTR_WRITE_COMBINE
attribute, and therefore dma_mmap_writecombine() will not actually set
the appropriate pgprot_t flags for write combining.

This patch adds an implementation of dma_map_ops.mmap() that correctly
handles KSEG1 addresses, and enables write combining when requested.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Cc: Sadegh Abbasi <Sadegh.Abbasi@imgtec.com>
Cc: linux-mips@linux-mips.org
---
Ralf: Could you replace the old patch "MIPS: Add implementation of
dma_map_ops.mmap() that handles write combining" in mips-for-linux-next
with this patch, which fixes a problem pointed out to me that exists
in both dma_common_mmap() and the original version of the patch I sent.
---
 arch/mips/mm/dma-default.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index eeaf0245c3b1..8f23cf08f4ba 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -194,6 +194,40 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 		__free_pages(page, get_order(size));
 }
 
+static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+	void *cpu_addr, dma_addr_t dma_addr, size_t size,
+	struct dma_attrs *attrs)
+{
+	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long addr = (unsigned long)cpu_addr;
+	unsigned long off = vma->vm_pgoff;
+	unsigned long pfn;
+	int ret = -ENXIO;
+
+	if (!plat_device_is_coherent(dev) && !hw_coherentio)
+		addr = CAC_ADDR(addr);
+
+	pfn = page_to_pfn(virt_to_page((void *)addr));
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
@@ -380,6 +414,7 @@ EXPORT_SYMBOL(dma_cache_sync);
 static struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc = mips_dma_alloc_coherent,
 	.free = mips_dma_free_coherent,
+	.mmap = mips_dma_mmap,
 	.map_page = mips_dma_map_page,
 	.unmap_page = mips_dma_unmap_page,
 	.map_sg = mips_dma_map_sg,
-- 
2.5.0
