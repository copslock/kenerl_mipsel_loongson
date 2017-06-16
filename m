Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:24:14 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:35122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994889AbdFPSM5QqTBW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pxy/uIMvbzQyNNMG1DfsDVw61eq9ByoiTaQKce46mwY=; b=gKYM4XWJAKAhzOp/S9Fp6yaoQ
        rcOOLSJv15t9YJ+MOyLwwcLQTt9iIgolCqhdQUVJ0YYwire6pzkWoTcvxmr8vLZgoLpObnEl8XA1f
        2ctnjBSnttAmbsBII55fXSwLy33nFfstAZwn9XlduDCH55s5cM9HQX0UIVpSXvbq2PNzCkSY2BR8k
        5oyjrRNCfFDPLIbkdV/fxzabkutr91GIx+5Cb/Ru3+TRh9xz/PFWIV+iNiXCveq7k9pa1VXIrk1IW
        fePjgleObPca6ZkmVBOwiga8vjPJr7sYs88aL/ojEyCaQJJV1tm1LfCzmv0kyMihGqC65FrXA3zz5
        0PCxRA/rQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvjn-0006Iu-3r; Fri, 16 Jun 2017 18:12:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 30/44] dma-virt: remove dma_supported and mapping_error methods
Date:   Fri, 16 Jun 2017 20:10:45 +0200
Message-Id: <20170616181059.19206-31-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58561
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

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/dma-virt.c b/lib/dma-virt.c
index dcd4df1f7174..5c4f11329721 100644
--- a/lib/dma-virt.c
+++ b/lib/dma-virt.c
@@ -51,22 +51,10 @@ static int dma_virt_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static int dma_virt_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return false;
-}
-
-static int dma_virt_supported(struct device *dev, u64 mask)
-{
-	return true;
-}
-
 const struct dma_map_ops dma_virt_ops = {
 	.alloc			= dma_virt_alloc,
 	.free			= dma_virt_free,
 	.map_page		= dma_virt_map_page,
 	.map_sg			= dma_virt_map_sg,
-	.mapping_error		= dma_virt_mapping_error,
-	.dma_supported		= dma_virt_supported,
 };
 EXPORT_SYMBOL(dma_virt_ops);
-- 
2.11.0
