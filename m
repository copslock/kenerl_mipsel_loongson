Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:12:00 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:53767 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994634AbeAJICDN5L5S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:02:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Kcd6zEJ+cb8K9CZttcDgrWlPGUBFBciZ5nxkoKIodA=; b=d8K/c3sUhW6492LRVanRGX29P
        jD/NjpsxHojH+RC2xkLlcOKi2xUGk1kTbpb9MxYTWF4bO61bt/MV9a+yy5JQ3UQ/siA+tsqwVBGbj
        2CdyHtl4YDYDNik1XS4m7p3brZGK7a9y9S802xK/AuiP5lbvvkehQ6pEXRy3IqUV+1JgqtXwmO6m8
        PwrbiUs8VNSgiO/h0QIDW202xf/8lKct0GlPBG6eAJxK3nQ9OnkzjyRHpHW3cngpgvysLOygySS+F
        vW7UNaXxJMt6pC0ZVFKb8osdyGo71Tcrh+YVfod+DXbnahaoNaCmbPmeZchRrEZdaF1/iOQLSu24d
        NEyZxmJ0w==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBKZ-0005XQ-Nk; Wed, 10 Jan 2018 08:01:52 +0000
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
Subject: [PATCH 27/33] dma-direct: use node local allocations for coherent memory
Date:   Wed, 10 Jan 2018 09:00:21 +0100
Message-Id: <20180110080027.13879-28-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61992
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

To preserve the x86 behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index a9ae98be7af3..f04a424f91fa 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -38,7 +38,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 	if (!page)
-		page = alloc_pages(gfp, page_order);
+		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
 	if (!page)
 		return NULL;
 
-- 
2.14.2
