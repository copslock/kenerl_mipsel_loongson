Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:16:10 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:58620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994626AbeAJIJwNaa6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:09:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ygsSuXxVWEdaHVvduoY+340YZAJ0fAUBceGNiG+cH9s=; b=gsEhGoVu5cdnrTKs3JM5UAJrv
        sezOw2TPOdi/MJvZMmfEX85RNWwOFq4MO5Ggv8/UcrC00pkR46GSbkOREkjyUxhwL9BospxS6nPLK
        C5SXNhZEn8c8AKS4KqJWOKvVPGIdsU6KXMrw1GOvsZwZXGPqZeOal/b/YmMvnrmfRywgICp/9cqgh
        4ZFCA8qw7Pb8Dmni/Ke/tjP6DebByO35OQkez3r7EGTeByuMYM7FVvIW10ezl+kGzML92f/RpH4zk
        PGbOccMn9OQM6iVr4h9Lxs4QCIRenMdHofknqQmDA2L5LXj1I6JWvDRGx7q4aHfAD0BOhjKNLU4c1
        bnbrxlkUg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSB-0007oq-Lb; Wed, 10 Jan 2018 08:09:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/22] ia64: rename swiotlb_dma_ops
Date:   Wed, 10 Jan 2018 09:09:13 +0100
Message-Id: <20180110080932.14157-4-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62002
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
 arch/ia64/hp/common/hwsw_iommu.c | 4 ++--
 arch/ia64/hp/common/sba_iommu.c  | 6 +++---
 arch/ia64/kernel/pci-swiotlb.c   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/hp/common/hwsw_iommu.c b/arch/ia64/hp/common/hwsw_iommu.c
index 63d8e1d2477f..41279f0442bd 100644
--- a/arch/ia64/hp/common/hwsw_iommu.c
+++ b/arch/ia64/hp/common/hwsw_iommu.c
@@ -19,7 +19,7 @@
 #include <linux/export.h>
 #include <asm/machvec.h>
 
-extern const struct dma_map_ops sba_dma_ops, swiotlb_dma_ops;
+extern const struct dma_map_ops sba_dma_ops, ia64_swiotlb_dma_ops;
 
 /* swiotlb declarations & definitions: */
 extern int swiotlb_late_init_with_default_size (size_t size);
@@ -38,7 +38,7 @@ static inline int use_swiotlb(struct device *dev)
 const struct dma_map_ops *hwsw_dma_get_ops(struct device *dev)
 {
 	if (use_swiotlb(dev))
-		return &swiotlb_dma_ops;
+		return &ia64_swiotlb_dma_ops;
 	return &sba_dma_ops;
 }
 EXPORT_SYMBOL(hwsw_dma_get_ops);
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index aec4a3354abe..8c0a9ae6afec 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2096,7 +2096,7 @@ static int __init acpi_sba_ioc_init_acpi(void)
 /* This has to run before acpi_scan_init(). */
 arch_initcall(acpi_sba_ioc_init_acpi);
 
-extern const struct dma_map_ops swiotlb_dma_ops;
+extern const struct dma_map_ops ia64_swiotlb_dma_ops;
 
 static int __init
 sba_init(void)
@@ -2111,7 +2111,7 @@ sba_init(void)
 	 * a successful kdump kernel boot is to use the swiotlb.
 	 */
 	if (is_kdump_kernel()) {
-		dma_ops = &swiotlb_dma_ops;
+		dma_ops = &ia64_swiotlb_dma_ops;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to initialize software I/O TLB:"
 				  " Try machvec=dig boot option");
@@ -2133,7 +2133,7 @@ sba_init(void)
 		 * If we didn't find something sba_iommu can claim, we
 		 * need to setup the swiotlb and switch to the dig machvec.
 		 */
-		dma_ops = &swiotlb_dma_ops;
+		dma_ops = &ia64_swiotlb_dma_ops;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to find SBA IOMMU or initialize "
 			      "software I/O TLB: Try machvec=dig boot option");
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 5e50939aa03e..f1ae873a8c35 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -31,7 +31,7 @@ static void ia64_swiotlb_free_coherent(struct device *dev, size_t size,
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
 
-const struct dma_map_ops swiotlb_dma_ops = {
+const struct dma_map_ops ia64_swiotlb_dma_ops = {
 	.alloc = ia64_swiotlb_alloc_coherent,
 	.free = ia64_swiotlb_free_coherent,
 	.map_page = swiotlb_map_page,
@@ -48,7 +48,7 @@ const struct dma_map_ops swiotlb_dma_ops = {
 
 void __init swiotlb_dma_init(void)
 {
-	dma_ops = &swiotlb_dma_ops;
+	dma_ops = &ia64_swiotlb_dma_ops;
 	swiotlb_init(1);
 }
 
@@ -60,7 +60,7 @@ void __init pci_swiotlb_init(void)
 		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
 		machvec_init("dig");
 		swiotlb_init(1);
-		dma_ops = &swiotlb_dma_ops;
+		dma_ops = &ia64_swiotlb_dma_ops;
 #else
 		panic("Unable to find Intel IOMMU");
 #endif
-- 
2.14.2
