Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 09:56:10 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:50476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992243AbeALInVE5iAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:43:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5S/szAHTUmmJn1Co90q5LcSgooOG8CSifcz4IuEw/Nc=; b=ekCljsUy7bO+hS42MoLrZuEey
        nBM9CxMp9/HtPKpJDWHogMWriuehafZU8An6JZUGGQPsFJj50c07QnUA59Tx3BxnkJKS8TvAE/Le/
        elXUFzUsOO43O2qvLFqnCgaumSNMaj62ly+vgRnDO56TkVysqB7NTKKXvmEHco8SArhiEsdQnjRMT
        COQOBmE0bOunxquDrtH/jqyTA+miahf4cNl+Wm1JG0kybtxU/Z4Si0Q/ajvVga0TxcBIgAgq+yxW3
        jiwFbl6qpZZpRO9DntsI5GOxyUGqb/PnthzYAZ93kE3yQx6mZVz6DbwoagUl6OWN/N31o0QccYBWp
        FGNLinpdA==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuvf-0007eh-MD; Fri, 12 Jan 2018 08:43:12 +0000
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
Subject: [PATCH 11/34] mips: fix an off-by-one in dma_capable
Date:   Fri, 12 Jan 2018 09:42:09 +0100
Message-Id: <20180112084232.2857-12-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62073
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

This makes it match the generic version.

Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 0d9418d264f9..5c334ac15945 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -22,7 +22,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size <= *dev->dma_mask;
+	return addr + size - 1 <= *dev->dma_mask;
 }
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
-- 
2.14.2
