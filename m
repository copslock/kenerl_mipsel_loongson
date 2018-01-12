Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 09:49:15 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:34970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993588AbeALIm4x9FrJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:42:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lioZeBjyjc+4CAz8dtiEETXglDGPc45H4sAX28X9kuQ=; b=XJ78cOakk2xZzntizcQJcNsyu
        Pgzv3sf5o12L4+HVSTCvOMq6kkIuKGbjPFqULhe8fVKO7Tq3YsVnYRd4v6l+jVC5D7tZo3McVW/j6
        K7rayrbKCjMBwqctsK2LwlHM7m2mKakEAhF30TooqhumdUXavAaPa1W4Ju5f0DAptiFKujbg493Yi
        PPvCyzfDFZ1KMgST61lm1YA5/1b/yvdu4y5dGoNvPbgOgbyMxTLuGbj/MnmPL1ftXxCIVMZEVCh2O
        /2GaYwCE8Q9NYa66z9YNi2Qv1XfToyZijAvIh740EEUL4fwqzEMxjG2FxX6DQAhGoQQZPIj3bgRhb
        JQiXRbdNA==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuvI-000777-4O; Fri, 12 Jan 2018 08:42:48 +0000
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
Subject: [PATCH 04/34] powerpc: remove unused flush_write_buffers definition
Date:   Fri, 12 Jan 2018 09:42:02 +0100
Message-Id: <20180112084232.2857-5-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62066
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
 arch/powerpc/include/asm/dma-mapping.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 5a6cbe11db6f..592c7f418aa0 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -107,9 +107,6 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 		dev->archdata.dma_offset = off;
 }
 
-/* this will be removed soon */
-#define flush_write_buffers()
-
 #define HAVE_ARCH_DMA_SET_MASK 1
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
-- 
2.14.2
