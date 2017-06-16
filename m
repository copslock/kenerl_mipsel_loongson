Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:21:44 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:45410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994839AbdFPSMiLmDEW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/hV/3mVXpVDCJ/R2hYg6OruqzMha5mJkHSK85bOIfwg=; b=bZLvMsBZejX69gxMqQFxCipS7
        Yi1R4vp7e/3drnxZqOHRT3nYpP9cYPLvHx97vLvmiWi5i0Olz8xFCsqNRSQ4gs4dTZhFTD9aWxwoL
        /73dFJiO3PCvrbEtrr8G0NCXXkalCYDoqIysWHIpNz9N6CL2UwrjYJMRB4sZd3tEMI9Im7rSNCXjP
        d2SaDh2SgIHY1+gqPTJ4Yhij/aDsoNQvibFyKEQeXRAJV2WuluoEFduLGwACmMHcP1xuGLubSce0j
        7vBtaQ7gCRMZXK+xpN++Th8qtBcalVni0TA/gjQd6ByFuv6xrRy+dEArtx9o8CxY12C4l1k+wPFp+
        rHhD8UZHg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvjS-0005qg-Uk; Fri, 16 Jun 2017 18:12:31 +0000
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
Date:   Fri, 16 Jun 2017 20:10:39 +0200
Message-Id: <20170616181059.19206-25-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58555
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
