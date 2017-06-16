Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:24:42 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:38439 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994892AbdFPSNGA24kW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:13:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VeOMicTSvxAgv16/nCIiw6ll9uhyDqYFc+zamxoD4nc=; b=nzYiiEqNvajW6fOb+vF0OrROD
        SHXV1QGvNm+nvvnL3Pn38j1BVt6ZUsEcTZOu1Hl/xGZH8ahQp95U7iuVdL4XUJAkMZUgTUpO3IDJr
        8y/T7JUN0snzkZFFH5yCGXk9MB2jAsrb+h+vyRRVRWQTvdQzpyNZkl12yvM/SBpQQvszcedN4PGYO
        +USqnYfOBq0JMo7Q1KK4Kj4CGM9moUl73+hbliNskkFJ/kbxy/k7fO9QfEIWGV2sX33+bj96ZRQWj
        EzLxr8ZffP9aLiBferL4Ant5+OgfWX7qC0CARlspn1Sl3xkpdHC/EwFlGWbtvBS7IQWlid2Vfxj2F
        fl7Ozztsw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvjv-0006TZ-BK; Fri, 16 Jun 2017 18:13:00 +0000
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
Subject: [PATCH 31/44] hexagon: remove arch-specific dma_supported implementation
Date:   Fri, 16 Jun 2017 20:10:46 +0200
Message-Id: <20170616181059.19206-32-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58562
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

This implementation is simply bogus - hexagon only has a simple
direct mapped DMA implementation and thus doesn't care about the
address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/include/asm/dma-mapping.h | 2 --
 arch/hexagon/kernel/dma.c              | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 00e3f10113b0..9c15cb5271a6 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -37,8 +37,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-extern int dma_supported(struct device *dev, u64 mask);
 extern int dma_is_consistent(struct device *dev, dma_addr_t dma_handle);
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			   enum dma_data_direction direction);
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 71269dc0f225..9ff1b2041f85 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -35,15 +35,6 @@ static inline void *dma_addr_to_virt(dma_addr_t dma_addr)
 	return phys_to_virt((unsigned long) dma_addr);
 }
 
-int dma_supported(struct device *dev, u64 mask)
-{
-	if (mask == DMA_BIT_MASK(32))
-		return 1;
-	else
-		return 0;
-}
-EXPORT_SYMBOL(dma_supported);
-
 static struct gen_pool *coherent_pool;
 
 
-- 
2.11.0
