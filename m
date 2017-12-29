Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:40:55 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:37479 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994660AbdL2IXEBdvsC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WZKbZA3eIEV5oOUX91JJ5Mb57W7gg00NIrYhXQ3cah0=; b=cNcclhc/cLfSyPGxneEr5nRE8
        bY8Jekv+nBNoehd9P7xSVWWDpnHKIjypIAZrFXmnTHfCYcGNq8fquzJ6cQVWjXW42pd0UxsmpFUSd
        fksaI4AbSyWKnq3n90NqTX5tSnw0p7wISsKon4qI38gnl5iOumx+7X1wTQj5mkGJ03Ju0Pnv59ld9
        1/W/1J2Kzg9hVkEqz68vZl3M2Co6zUuPZqujXfiowtjmNP7+B5NY2CDQTL6uYOc3pWGZlsIuBBRqR
        CV2nvEu0BrPQYX5cCY4gpppOuFPkGdYG0v+Ksv7YMS1R2fgK9ct09xHrabZVDnMCVzCTYAK70rUGC
        kD2JeVQEg==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpw9-00038o-ML; Fri, 29 Dec 2017 08:22:42 +0000
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
Subject: [PATCH 47/67] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Date:   Fri, 29 Dec 2017 09:18:51 +0100
Message-Id: <20171229081911.2802-48-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61745
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

To properly reject too small DMA masks based on the addressability of the
bounce buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 9c100f0173bf..e0b8980334c3 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1125,5 +1125,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
+	.dma_supported		= swiotlb_dma_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.14.2
