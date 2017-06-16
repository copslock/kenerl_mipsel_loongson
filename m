Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:23:47 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:36971 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994848AbdFPSMzEUxtW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XSYdmvQJNFdXK+xuL8ZHUwT5syGePJpAphlsCPfTcOw=; b=A++apB/ptSeIu6Y0ek+tWmsKH
        lq6xJO0pacKwxe59hUokk8vkdQmNp5z/vd2bGak0Q44OGO78QlDkGBfqaiIKkMpatAYEk5AdLTZUB
        Vs5QJYwdnVaa23TWedL6XO/wSShWOcS/OurzE3WKbl+mSFLWwSc1t07ISUPO5Pp2XxoHND4cr0q39
        Xys4TshHy+jQ7qCGAsWyV6l/wwohm7rJi5v14xjEh9XyCeoMIz0RxdZ9uC9IRhqfCQHZi3WSKoxTf
        ZfjOtxiBk30s2OHVNluZ/SnkBouYXuFK5Xsw3VaOLWvNhpBWgnQXMy9KEwJe1hy6QTuIAuLL8cRO/
        fGm0gkreg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvjj-0006Ek-UW; Fri, 16 Jun 2017 18:12:48 +0000
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
Subject: [PATCH 29/44] dma-noop: remove dma_supported and mapping_error methods
Date:   Fri, 16 Jun 2017 20:10:44 +0200
Message-Id: <20170616181059.19206-30-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58560
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
 lib/dma-noop.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index de26c8b68f34..643a074f139d 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -54,23 +54,11 @@ static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nent
 	return nents;
 }
 
-static int dma_noop_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static int dma_noop_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 const struct dma_map_ops dma_noop_ops = {
 	.alloc			= dma_noop_alloc,
 	.free			= dma_noop_free,
 	.map_page		= dma_noop_map_page,
 	.map_sg			= dma_noop_map_sg,
-	.mapping_error		= dma_noop_mapping_error,
-	.dma_supported		= dma_noop_supported,
 };
 
 EXPORT_SYMBOL(dma_noop_ops);
-- 
2.11.0
