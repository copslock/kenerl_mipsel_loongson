Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:58:41 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:47620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeINJ6ZpUDkI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 11:58:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zFJjatMqLsBLj+2I3RwKulh7mahvK4LzPodJJ5ggDjA=; b=JdreEapjn+o10u1aQ6hIw9nJl
        a1+ij2xxTtfym4b23cSVhjKb9OYX8u8m40kb4HDm+4JRXepNDo+I6HOj9H4H8o+OKRUq+AtoEy1IZ
        n3WqtJwWHe/f4Gxd6vpU+9YNsnlEID7/QFHKAtO8q1YbMo+zVgWkJcBErqVYz8aWeyd7SuL66Ui+w
        HNIkycvyk6vbwpevjtLrAPGn8UeogRkhiLM7CDYFKt8Nut0zmRUkzL+NGCZyQtdCC0S3jro/kuY88
        CGVHqQtmQ5mq+DvNQS4AXzWt9TVMDekCirDEh20fqdCH2P/0G7yp+l9B7Uw45GrKoHuBSaXHxit/J
        Nkqhp3lPg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0krf-0000Qg-KS; Fri, 14 Sep 2018 09:58:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Date:   Fri, 14 Sep 2018 11:58:03 +0200
Message-Id: <20180914095808.22202-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914095808.22202-1-hch@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+df237881911bfff71047+5500+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66250
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

The patch adding the infrastructure failed to actually add the symbol
declaration, oops..

Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..1b1d63b3634b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 	bool
 	select NEED_DMA_MAP_STATE
 
+config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+	bool
+
 config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA
-- 
2.18.0
