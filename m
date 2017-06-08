Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:39:02 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:36447 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993978AbdFHN16GKYeT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:27:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/hV/3mVXpVDCJ/R2hYg6OruqzMha5mJkHSK85bOIfwg=; b=mL91aWsEzI32++bfOJ+SJNumd
        ZWkAPuWR74D2pQNWWc5KuiphvcPBbjw+CDYWz2zOsKt62dVaxwOMEcQuOwWKnfmLyFFNczLJWEITb
        Pnc3pkEsTVSqNFfdDwz6W2HqlhWlz/UCTgAlRM0O4EZF8b3YTpqgxCYFEAQtfIVHMmv/crTqe/8Xd
        tYuirK2NIQg51FJZDj2nYx0b6V2tL8VW9iyk5UdQK5B/Csq8KZTtt8C/kwHLyTDInDg/drX6lv7eW
        gNoOAcYy4cPiMkMYvIrk3N3OQ6olH87w6snVvQs1MF2oUZLnLVxm3SLJD0N2pAkhE21gxYBsxJwxU
        EbXarVPrQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTZ-0006q8-Jb; Thu, 08 Jun 2017 13:27:50 +0000
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
Subject: [PATCH 24/44] x86: remove DMA_ERROR_CODE
Date:   Thu,  8 Jun 2017 15:25:49 +0200
Message-Id: <20170608132609.32662-25-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58333
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

All dma_map_ops instances now handle their errors through
->mapping_error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 08a0838b83fb..c35d228aa381 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -19,8 +19,6 @@
 # define ISA_DMA_BIT_MASK DMA_BIT_MASK(32)
 #endif
 
-#define DMA_ERROR_CODE	0
-
 extern int iommu_merge;
 extern struct device x86_dma_fallback_dev;
 extern int panic_on_overflow;
-- 
2.11.0
