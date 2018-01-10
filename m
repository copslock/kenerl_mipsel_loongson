Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:03:41 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:60997 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993588AbeAJIBCZ7sTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:01:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=07RuFC1Zfs8Ezi8EsP/bxOpwvBBEoSJ4OYSPIkkVu+U=; b=fIAAaYfY+oJ8HMMK9HtxOZSV6
        RQwNu8F9URdFXtINNfmxXGknYHwczFDoFspzpqrbVqYb65OXRCgoC5yS/L9HTHI07rmnud5u+onnC
        daFo5fl8V6mKvgJ/NS6wGo9s+7EKzJVXP9nwxPY9HKLdtVGQmjZgH0RrBQ1fMof4/7cP+MBZxyi2o
        +iWup2tpyrxTK7YiINVkhJD+cdyYvgcnCCe8hNh6mOEqOKxdxR/5lT46i1fbN2+7F1FB+eY4msem3
        e6tfL9BzuR4kU+qyI9+UaPV6CQXoMdR1g4pxuuZTQnQT4MkgX2ZMsEsgr8WPuK1kjl7xJPNoyX8Ya
        2nkJFZpKQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBJb-0004C4-R5; Wed, 10 Jan 2018 08:00:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/33] riscv: remove the unused dma_capable helper
Date:   Wed, 10 Jan 2018 09:00:01 +0100
Message-Id: <20180110080027.13879-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61972
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
 arch/riscv/include/asm/dma-mapping.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/include/asm/dma-mapping.h b/arch/riscv/include/asm/dma-mapping.h
index 3eec1000196d..73849e2cc761 100644
--- a/arch/riscv/include/asm/dma-mapping.h
+++ b/arch/riscv/include/asm/dma-mapping.h
@@ -27,12 +27,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif	/* __ASM_RISCV_DMA_MAPPING_H */
-- 
2.14.2
