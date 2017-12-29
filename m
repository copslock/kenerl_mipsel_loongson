Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:39:58 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:34978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994657AbdL2IW5T0N8C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:22:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d+vcST1VW+GVyRR4eQmhY8SFmGkMbG5rojSvVCXYM6g=; b=cE+dv7lqO03lLqb/qVH6OrTHL
        oE61S9MIGC4GA7CLnpOBAvFzOTyFGRP3MSm/NT0aeycH5ad2xHIJEN/F/HMZBiPTLB253n544HsH7
        S1PWUybtq2QUTAtVeeRwXemOy33d2U1dhZEYfDmVSzld0WFqUS7vtUbvc6fzUQbM28zJLhmYa0hHR
        NcLeUyH05AimllEgZpWOw0KU9hE1rsJn/5KLW4JNRYvqZIPk9Sia44p8BHUdxSecs+uCLXdpVEIIZ
        fKonNWp/MxAW1y7Ytwi8tX6AHxhgY0S2uxxOWCnInYEVhJU54mnT5aLbwQDEPzaKGbnCpRZj1DgcD
        7frGGwnUg==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpw0-00032Z-ED; Fri, 29 Dec 2017 08:22:33 +0000
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
Subject: [PATCH 45/67] swiotlb: rename swiotlb_free to swiotlb_exit
Date:   Fri, 29 Dec 2017 09:18:49 +0100
Message-Id: <20171229081911.2802-46-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61743
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma-swiotlb.c | 2 +-
 arch/x86/kernel/pci-swiotlb.c     | 2 +-
 include/linux/swiotlb.h           | 4 ++--
 lib/swiotlb.c                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 506ac4fafac5..88f3963ca30f 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -121,7 +121,7 @@ static int __init check_swiotlb_enabled(void)
 	if (ppc_swiotlb_enable)
 		swiotlb_print_info();
 	else
-		swiotlb_free();
+		swiotlb_exit();
 
 	return 0;
 }
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 7a11a3e4f697..57dea60c2473 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -119,7 +119,7 @@ void __init pci_swiotlb_late_init(void)
 {
 	/* An IOMMU turned us off. */
 	if (!swiotlb)
-		swiotlb_free();
+		swiotlb_exit();
 	else {
 		printk(KERN_INFO "PCI-DMA: "
 		       "Using software bounce buffering for IO (SWIOTLB)\n");
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 24ed817082ee..606375e35d87 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -115,10 +115,10 @@ extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
 
 #ifdef CONFIG_SWIOTLB
-extern void __init swiotlb_free(void);
+extern void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 #else
-static inline void swiotlb_free(void) { }
+static inline void swiotlb_exit(void) { }
 static inline unsigned int swiotlb_max_segment(void) { return 0; }
 #endif
 
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 6583f3512386..c1fcd3a32d07 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -417,7 +417,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
-void __init swiotlb_free(void)
+void __init swiotlb_exit(void)
 {
 	if (!io_tlb_orig_addr)
 		return;
-- 
2.14.2
