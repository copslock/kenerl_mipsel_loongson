Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 18:10:57 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:42584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994877AbdH0QKtxslLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 18:10:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nufn+M7g9f/SclKMtM/dKuZNRXT1sUMnL9Iic9J1/sA=; b=Y/KacImR9nJLifA7GnGcKDD2j
        0rQWkRuN5yN6orhi0nLilCL7PsZhFJfOCk/DicmMJbSrH3pMHh9Sjc2TaWFUCqI7hgY6hQCsEV0Ap
        JVrDRwBQ+2HBeTp61vBqX1hhIE9VxTYl54FiDmXzEtOc+6pCnJB+uMt4cjCkXtMb8IkpX8PDE9dWh
        2qd5W5ZkRkwghAWzyLN+JmXL4voHJ1YAwORbhRkqLn/m5n2L9zdgIq9aKXkwTq06ln0PoiLT2EJuN
        alQq1pHkTymp/2L6aqsFLj4YnI3M4pfo6K4+9oc34HNmcT+iRKy2UyQpOOMjmUDk8SkCCRGRoR6cq
        jlDaw1F3Q==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dm092-0006r9-K3; Sun, 27 Aug 2017 16:10:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] mips: don't use dma_cache_sync to implement fd_cacheflush
Date:   Sun, 27 Aug 2017 18:10:22 +0200
Message-Id: <20170827161032.22772-3-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59815
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

The floppy drivers doesn't otherwise use the DMA API, so indirecting
through it just for cache flushing in MIPS-specific code just call
dma_cache_wback_inv directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/floppy.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/floppy.h b/arch/mips/include/asm/floppy.h
index d75aed36480a..021d09ae5670 100644
--- a/arch/mips/include/asm/floppy.h
+++ b/arch/mips/include/asm/floppy.h
@@ -10,11 +10,11 @@
 #ifndef _ASM_FLOPPY_H
 #define _ASM_FLOPPY_H
 
-#include <linux/dma-mapping.h>
+#include <asm/io.h>
 
 static inline void fd_cacheflush(char * addr, long size)
 {
-	dma_cache_sync(NULL, addr, size, DMA_BIDIRECTIONAL);
+	dma_cache_wback_inv((unsigned long)addr, size);
 }
 
 #define MAX_BUFFER_SECTORS 24
-- 
2.11.0
