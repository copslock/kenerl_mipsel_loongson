Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:16:28 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:56776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994845AbdFPSLwzhapW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:11:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+BimIphw+O/ZeWv5ilcXGOZNr0jC0FIS9166yVuBOCo=; b=aar/hGEgYNDN760LyRQGOkf/c
        muF7aFh0DgtllPrRo3c8wxtJxCfC6AqYgWxIk0PYRwz603D6psbrFTgHfcfmRH0ibidr7pujlTu34
        fV23h02D1Ktmi4xFT/ee4A7nL1dt+Xhuk0CJjXosgYfbcmiG5ZFGyIOmdopFiyx9AioD8NlANQV+G
        4bApgR0F/BP4Yreisd6zvQ+ByN5YNX3ffICBEDZWdSJ45Bo5QIi2ws6GGz6fQpmI7caiiDfGmN2dM
        ZIUhm9lG/76+KFCNx0yp+QwUQVlMsFmukfOKgbQ3upwhKdkhZfg3xbYGffum+a9HlYUAPm0gi91JJ
        ok2iqMXDQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvim-0004zm-1O; Fri, 16 Jun 2017 18:11:48 +0000
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
Subject: [PATCH 11/44] m32r: remove DMA_ERROR_CODE
Date:   Fri, 16 Jun 2017 20:10:26 +0200
Message-Id: <20170616181059.19206-12-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58542
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

dma-noop is the only dma_mapping_ops instance for m32r and does not return
errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m32r/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
index c01d9f52d228..aff3ae8b62f7 100644
--- a/arch/m32r/include/asm/dma-mapping.h
+++ b/arch/m32r/include/asm/dma-mapping.h
@@ -8,8 +8,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-#define DMA_ERROR_CODE (~(dma_addr_t)0x0)
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_noop_ops;
-- 
2.11.0
