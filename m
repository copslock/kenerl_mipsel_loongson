Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:42:53 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:49238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993924AbdFHN2TeWrDT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:28:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pxy/uIMvbzQyNNMG1DfsDVw61eq9ByoiTaQKce46mwY=; b=qmcXXA3Se1jQ/3DvTVShpdCFK
        zpY4wi5BOrw1JhQzcchDDqBkKzZFGmLnjTwqyfkj/Ewa/L3VXqDP/G7SK9jk1q6v+TlIrn7ycJw4h
        S8CjYiHVkQ4jp0hYQrrKYRAVIPcjz1LCzoBbAOrkz9p8cL3fCjioJk8D8IpUzTQiikJCR01cRuEyp
        jAs64BPONNPPWbxnnWidGjsoeY+0vNNnFjhgIjpUOXMdgEDWZ8zlIvLiIvzA7QAa4Buk49s/nCdLz
        NYXNXNid1wbbCmhImk4SgXk6oJoQyFuoUDkQwXBXfoGGngCDSAMIMgN2eaVmkNRWCtlGk66sDVRgn
        yRzLh0P9A==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTu-0007Ke-Q8; Thu, 08 Jun 2017 13:28:11 +0000
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
Subject: [PATCH 30/44] dma-virt: remove dma_supported and mapping_error methods
Date:   Thu,  8 Jun 2017 15:25:55 +0200
Message-Id: <20170608132609.32662-31-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58340
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

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/dma-virt.c b/lib/dma-virt.c
index dcd4df1f7174..5c4f11329721 100644
--- a/lib/dma-virt.c
+++ b/lib/dma-virt.c
@@ -51,22 +51,10 @@ static int dma_virt_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static int dma_virt_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return false;
-}
-
-static int dma_virt_supported(struct device *dev, u64 mask)
-{
-	return true;
-}
-
 const struct dma_map_ops dma_virt_ops = {
 	.alloc			= dma_virt_alloc,
 	.free			= dma_virt_free,
 	.map_page		= dma_virt_map_page,
 	.map_sg			= dma_virt_map_sg,
-	.mapping_error		= dma_virt_mapping_error,
-	.dma_supported		= dma_virt_supported,
 };
 EXPORT_SYMBOL(dma_virt_ops);
-- 
2.11.0
