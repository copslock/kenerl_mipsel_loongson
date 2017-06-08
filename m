Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:45:04 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:36441 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993987AbdFHN2bD06ET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:28:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q6rrVBavW/g1iseNgi9YxHn0z+ZU/4+zYJi0PfQojcs=; b=dMuhDr7qyOcpaOo1aFdtPegSp
        BGuUJCKJ+94CQkuxu+ulN3p4dXFwSydTQBF3wq9PtQX4TO3JbyoltlpGAJiFzl81L4lLc+dHd6hB7
        /7n/hQbi1sBUODoJ12clAbvp6Ia34XBKPpv3EbkUmFpArHa5CG3yGu0ZceNeQKkVM324+9TzU8hYo
        1UuMigRxI8bPC2d30X9gIgR07lhtL2OnKAas0+cCHeQLyPFMaPBxd5hxaIO/jOhtM/Exi7fR8kr+g
        o4Q5T2GFLQszL/1SbIh6qOWvvYcPArzFjpZZkZYoItKu0nFfPFNlc21LpafszsKG1nbVG+rK9ehW+
        mL/Y38EBw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxU6-0007aB-No; Thu, 08 Jun 2017 13:28:24 +0000
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
Subject: [PATCH 33/44] openrisc: remove arch-specific dma_supported implementation
Date:   Thu,  8 Jun 2017 15:25:58 +0200
Message-Id: <20170608132609.32662-34-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58343
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
---
 arch/openrisc/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index a4ea139c2ef9..f41bd3cb76d9 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -33,11 +33,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &or1k_dma_map_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-static inline int dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask == DMA_BIT_MASK(32);
-}
-
 #endif	/* __ASM_OPENRISC_DMA_MAPPING_H */
-- 
2.11.0
