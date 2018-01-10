Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:03:19 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:57429 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeAJIA7uyTFS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:00:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5m3sWHu0i/1ncT32uHmlD/yLwHLhNTmcfacRCc4qzec=; b=ohqEQAUxjiZ0O5Tez1M1ePR+u
        ENKjSnfmoYpmSmUcDupqSMMCSUUqyHh7dgxMbUAeenHSKaSVY1Ehf7v16Guak+6vnLr+FRXy9dchk
        j3cT5UIl1b9Rj1EKm5BZnmYmI3mxUbUCC22LmafBhP20RFuEizqtxwviUkTjbMI6TZO/var14jzr4
        BdnYyRSPl+UnQQMJJ05SUpeOsfZOeKuxUJfZ7MWCX//8Gi7Tlz89nEhKYNCUSpaWOuLf7YXl5Igbo
        WPO3OfGOEmK+/hsN0FE/sk6hlp8GOhOGeOQZGf/3Muhc6ZLm3yKweKKrQAayS6oEXl+qHTHPMqowK
        q9v17j6RA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBJY-00048A-Oh; Wed, 10 Jan 2018 08:00:49 +0000
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
Subject: [PATCH 06/33] m32r: remove the unused dma_capable helper
Date:   Wed, 10 Jan 2018 09:00:00 +0100
Message-Id: <20180110080027.13879-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61971
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
 arch/m32r/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
index 336ffe60814b..8967fb659691 100644
--- a/arch/m32r/include/asm/dma-mapping.h
+++ b/arch/m32r/include/asm/dma-mapping.h
@@ -14,11 +14,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif /* _ASM_M32R_DMA_MAPPING_H */
-- 
2.14.2
