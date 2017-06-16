Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:29:54 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:52285 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994907AbdFPSNuBZ64W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:13:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eZHE6yUSAfMLSefbu18rbdpTGXQMlt8s3PB24r4P6cc=; b=JZoNONjpQ2Ds2v9rfZzYVfYuO
        +z6UHFCnaQMmtWOC0qXuglDEcIpuDvYO2PoRcJUQfw2YwoncyaP3UdtJRHliGSe6q0dnBoyJlVnQf
        p/K9Eb5i+H8ePY2+REFkworj2km4DW2FKAzU7aYS3+NEL2wJeRJZOVn/PsIOJVqIkJUdN8R7ua+T3
        D0ytt191cZxz5rpJmuuy7ZUoG3aLZ+fGyhUL8LvmPdQpR0ivDcml9qNKvWZ2TKUbKQqp0Dm0flxiN
        yTqyRzDqZg+UPGvn5POkplGvzsWdAtaX1RiD8nskOY8nyWbiXE7srYD5ImHpoBhxXw1Lq6ldYKChP
        GLHaKb6Fw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvkc-0007Mv-Ii; Fri, 16 Jun 2017 18:13:43 +0000
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
Subject: [PATCH 44/44] powerpc: merge __dma_set_mask into dma_set_mask
Date:   Fri, 16 Jun 2017 20:10:59 +0200
Message-Id: <20170616181059.19206-45-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58575
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
 arch/powerpc/include/asm/dma-mapping.h |  1 -
 arch/powerpc/kernel/dma.c              | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 73aedbe6c977..eaece3d3e225 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,6 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 #define HAVE_ARCH_DMA_SET_MASK 1
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
-extern int __dma_set_mask(struct device *dev, u64 dma_mask);
 extern u64 __dma_get_required_mask(struct device *dev);
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 466c9f07b288..4194bbbbdb10 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -314,14 +314,6 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
-int __dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-	*dev->dma_mask = dma_mask;
-	return 0;
-}
-
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (ppc_md.dma_set_mask)
@@ -334,7 +326,10 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 			return phb->controller_ops.dma_set_mask(pdev, dma_mask);
 	}
 
-	return __dma_set_mask(dev, dma_mask);
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+	*dev->dma_mask = dma_mask;
+	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-- 
2.11.0
