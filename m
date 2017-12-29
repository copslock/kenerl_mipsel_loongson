Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:39:09 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:52903 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994626AbdL2IWs5yolC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:22:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xm1rsNgLlwhJkWbN6vSEJ6mxQ5QWhxwQ55E9ismDAEc=; b=ABV+c04IHWGjV13r+EulaBUCU
        04kvTMGjpcpCrMyktaPk/8BZF999XwAG6shsuzOwVVMJI75j3y/d2Tmjt2tuoQiWMGmTqa2awNdD3
        30+3oTmOxWRuU5Rkd2RSFZLKpgtQ8t/E4OVL3CLsdlC8tl0ida1JTmK42d71j5qO3d3XJRzaRRVDx
        4ESZWxnkCSBMe+TQjrWcbI1qTNV90164MbgVAs+5xlrnDdThfI3Hmq2hgmy6CNcEKjxlU4hlGsvbc
        KFlSQqBEYbQXVCzQ1r9tm5hKaVZA8bpG3Uv2fIiJg2tr3BhHlYFY0K1HqXsDW+U9nnk0SB1oMuxia
        w125M3N+w==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpvw-0002zc-10; Fri, 29 Dec 2017 08:22:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 44/67] powerpc: rename swiotlb_dma_ops
Date:   Fri, 29 Dec 2017 09:18:48 +0100
Message-Id: <20171229081911.2802-45-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61741
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

We'll need that name for a generic implementation soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/swiotlb.h | 2 +-
 arch/powerpc/kernel/dma-swiotlb.c  | 4 ++--
 arch/powerpc/kernel/dma.c          | 2 +-
 arch/powerpc/sysdev/fsl_pci.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index 9341ee804d19..f65ecf57b66c 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -13,7 +13,7 @@
 
 #include <linux/swiotlb.h>
 
-extern const struct dma_map_ops swiotlb_dma_ops;
+extern const struct dma_map_ops powerpc_swiotlb_dma_ops;
 
 extern unsigned int ppc_swiotlb_enable;
 int __init swiotlb_setup_bus_notifier(void);
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index f1e99b9cee97..506ac4fafac5 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -46,7 +46,7 @@ static u64 swiotlb_powerpc_get_required(struct device *dev)
  * map_page, and unmap_page on highmem, use normal dma_ops
  * for everything else.
  */
-const struct dma_map_ops swiotlb_dma_ops = {
+const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.alloc = __dma_nommu_alloc_coherent,
 	.free = __dma_nommu_free_coherent,
 	.mmap = dma_nommu_mmap_coherent,
@@ -89,7 +89,7 @@ static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 
 	/* May need to bounce if the device can't address all of DRAM */
 	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
-		set_dma_ops(dev, &swiotlb_dma_ops);
+		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
 
 	return NOTIFY_DONE;
 }
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 1723001d5de1..b787692b91ee 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -33,7 +33,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	struct dev_archdata __maybe_unused *sd = &dev->archdata;
 
 #ifdef CONFIG_SWIOTLB
-	if (sd->max_direct_dma_addr && dev->dma_ops == &swiotlb_dma_ops)
+	if (sd->max_direct_dma_addr && dev->dma_ops == &powerpc_swiotlb_dma_ops)
 		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
 #endif
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index e4d0133bbeeb..61e07c78d64f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -118,7 +118,7 @@ static void setup_swiotlb_ops(struct pci_controller *hose)
 {
 	if (ppc_swiotlb_enable) {
 		hose->controller_ops.dma_dev_setup = pci_dma_dev_setup_swiotlb;
-		set_pci_dma_ops(&swiotlb_dma_ops);
+		set_pci_dma_ops(&powerpc_swiotlb_dma_ops);
 	}
 }
 #else
-- 
2.14.2
