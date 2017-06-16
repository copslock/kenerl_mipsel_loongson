Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:18:06 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:43435 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994826AbdFPSMGFOD4W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m3ERni24UyejO6NccGsSdbcISmLnYEvfLcY7padaEj4=; b=OMQF3kAWNISYQp7Fm+CI5HY/Q
        2AVVACTCQc4MoXaMHz8UjAdWBvtzYkAZKmTmeAzJJD4b+fXo9OeFnKSU1Hikke2QbKjVpSi0+XP25
        LM2/WFucfnFClUHQLuTmq/LMSdJ3zWqwhiSk33YPT3mttF/GuWTati8jztQTmaMup9+VUMysD/mix
        B2XwXHIhogZnHlOcB4Q+ZO49iNiaXmmYtv5DJFaXtBmOH24CV1VGlz6kSIMOdHaKX75r0ywGkZ7Ds
        biTCFijztiPbq2qbqLO/hBXP91QpdYiZ2h/rSqFNEghZshe1P4xi/rjEmpr0j/7hrrZJ572pMxlC2
        no0DDPy4w==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLviz-0005JJ-Bs; Fri, 16 Jun 2017 18:12:01 +0000
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
Subject: [PATCH 15/44] xtensa: remove DMA_ERROR_CODE
Date:   Fri, 16 Jun 2017 20:10:30 +0200
Message-Id: <20170616181059.19206-16-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58546
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

xtensa already implements the mapping_error method for its only
dma_map_ops instance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index c6140fa8c0be..269738dc9d1d 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -16,8 +16,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 
-#define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
-
 extern const struct dma_map_ops xtensa_dma_map_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-- 
2.11.0
