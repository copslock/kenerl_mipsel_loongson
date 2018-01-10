Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:17:27 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:39052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994668AbeAJIKAJidtS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6vkRRgORy0vPtJ1cH6DSIzixDt+/vRPSHAexgo3+7/k=; b=Srw9mqvya3OgG7WpJ86lTvtqG
        nBm90k0tH/HZCpXNDAyUiTIb9SvIK5hdVZ8vqzFw+hlzLhLj4YRdf0dVhcuVFKdP9wEaTrAfEonev
        ca6J+a69hsODE/HvXnnJD2DFap3M5lPUeBIQez+wmCN5Nutv6B1PW/1rdBGqeRxJQnDZ4nbxsO0Kj
        ExPRFOHZWhGqLpqrB3xBTIFgurkiMe4OCKfKfQlBt+0qUCMWP9po8YfGA4npzEfKJmUfIbbrCcG9X
        bDZCd3Y1AXwqk9uHLOsTt9LEzQiFxV5kL2HxpYtpSMfQUcIl7NAlV8G8UeCYe2uXNHXE4HWvxkMqj
        XfJG6kbzQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSK-0007zw-BS; Wed, 10 Jan 2018 08:09:52 +0000
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
Subject: [PATCH 06/22] swiotlb: rename swiotlb_free to swiotlb_exit
Date:   Wed, 10 Jan 2018 09:09:16 +0100
Message-Id: <20180110080932.14157-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62005
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
index 0d77603c2f50..0ee0f8f34251 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -120,7 +120,7 @@ void __init pci_swiotlb_late_init(void)
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
index 125c1062119f..cf5311908fa9 100644
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
