Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:18:15 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:50510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994671AbeAJIKGbeVdS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GEJmsKDoliSpskGzm7fia1a+9IRh9+3TRMtrfGeRq8Y=; b=rfV8vIw9lRHLmHm+MY8dmXL0K
        WAuBmraw+QEOVm7Q+/2t7VvxwJEE8/tczP5fGD0YZtq6OSJjRKIxM1XQgNLregh49EJWv914PPEhn
        TWmX6aSrhQk2+II7+43zAf8rEY+Q8/5j7F5Hgqz9aHL/lTu4snB+qVkVkfS3C0YLJtFAyiUs3Jhl+
        xpeXPvrlJOpfIei37XROFFgsopATsgrL728YJ3Tu4bBbzHLWAqMuQgP7l3HLnJCQItGFBGh8pztPY
        Ztfjng2AjAwq4/O5HLtLiRkFycSgexcSjGqOvVy6l72dAXTzAB+Js14P+qPFxlTBY4VFRZ4yJmrmh
        PzsV9tNdA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSQ-00087P-6H; Wed, 10 Jan 2018 08:09:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Date:   Wed, 10 Jan 2018 09:09:18 +0100
Message-Id: <20180110080932.14157-9-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62007
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

To properly reject too small DMA masks based on the addressability of the
bounce buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 0fae2f45c3c0..539fd1099ba9 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1128,5 +1128,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
+	.dma_supported		= swiotlb_dma_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.14.2
