Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:16:06 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:57485 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994840AbdFPSLuFdIhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uy6H3+yx5EeAWQfHfPRvhVNeqQCPFpPHV5YVmwy+QSI=; b=fKAsHkfZmPCuHOxxoipJFT2FD
        Onp8qlpmfZTTHehcB6rvxwh/YXsWS7AHRBL4/Wt2jRP281raJQNFWhTs722VhGDkM7py5HfJrfBxy
        bzS1eMCgQa4ONj75QN7BmzLVw3BB8LN1t6q1tTMf2X1DIhWQ/29Eg/LEj7CmWnBPJ8QSv4BpXEfQp
        ZgS2MkLA4P8lqnD6Kygz4C8bjipiXHw9VxWP5w+9nxhY7OxbcAaao9TiUllsIr++d1mGa6tRN+uT+
        FIoQsG3D4k/LzQ8mNOCLLcys8ZunaEaGxv/J+8dh/q9el5GxerxBPp5SF1KzhYd6YodZn8rTTnjeI
        Ex8WHgE2A==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvii-0004wO-Hz; Fri, 16 Jun 2017 18:11:45 +0000
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
Subject: [PATCH 10/44] ia64: remove DMA_ERROR_CODE
Date:   Fri, 16 Jun 2017 20:10:25 +0200
Message-Id: <20170616181059.19206-11-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58541
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

All ia64 dma_mapping_ops instances already have a mapping_error member.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 73ec3c6f4cfe..3ce5ab4339f3 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -12,8 +12,6 @@
 
 #define ARCH_HAS_DMA_GET_REQUIRED_MASK
 
-#define DMA_ERROR_CODE 0
-
 extern const struct dma_map_ops *dma_ops;
 extern struct ia64_machine_vector ia64_mv;
 extern void set_iommu_machvec(void);
-- 
2.11.0
