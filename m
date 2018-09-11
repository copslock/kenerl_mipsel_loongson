Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 11:01:06 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994658AbeIKJA66bdS1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2018 11:00:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zFJjatMqLsBLj+2I3RwKulh7mahvK4LzPodJJ5ggDjA=; b=TXq8Y9Ujk7hgj4w5C+eq1nLTw
        +OnDfhUUD3nMME+Ll0GzbjeedFPyB7ebWhWiIfHwHNHLBlvs7M/LvUfV1JucQMOqD7+dd3UnIT5R/
        //udUWFrqqNdFjjvFKJXiZboryY+n2uuLI3Wa0JiqpnJHj/IA0U6U48765aViYu035StNmIwDlP4T
        9SFI8TR9w5NYsU5+PL0SQf36WbVjFzpIjix/d+l+6WjcTXlqhAXX0WAIpsIpycL0k66VcqXB2Kvil
        TRcnn/NAbtsmlk18JwePq5dZ3/PGfHfmpg8YmeoFlz13IiDOySClhfF4co2OzLAlUvz3ryQ5aYFsK
        ROvYukbvA==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzeXV-0008RG-8q; Tue, 11 Sep 2018 09:00:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        paul.burton@mips.com, linux-mips@linux-mips.org
Subject: [PATCH, for-4.19] dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Date:   Tue, 11 Sep 2018 11:00:49 +0200
Message-Id: <20180911090049.10747-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+1ed8f79135c08d50bc84+5497+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66200
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
