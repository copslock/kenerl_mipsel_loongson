Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:27:51 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:46729 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993924AbdFHN0cjXKzT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:26:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KhhfE6zM0wEbq3HwvYbrXjnP/zu6HhUjXjxagmuTuqY=; b=RV79hcq5u+RDDQG6oB6MND5rH
        BhKbPO8iRp///WkHJ0EDolk3Ln6ftiAVL0br++oc84ujsTvmcp4VuX1Yun5Cdhgo/jlF6TCtNrOsl
        fhtsW49Qq6LIK3gJb1r/NFNpazYBTS3T3D0Qdb71qJ8VF593oksB0HspZuTwR0ALRuP2wnNABi2I/
        L/CesRtdVjpJALL8kEw6Gce03ogbz+aNO6IUM9KuoHa5fTDceiKU7Nca6PZzJyMNNbjOSBsU+PY6r
        ItrbwOqab3aK2/LeXJOSjLLatyBiIuHMAgg3QzW92YKcaqYxCI7vYCPsUBu3fhxL7pCnC6E2mYhP/
        8dy2DdPkA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxSF-0004xV-FU; Thu, 08 Jun 2017 13:26:28 +0000
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
Subject: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
Date:   Thu,  8 Jun 2017 15:25:28 +0200
Message-Id: <20170608132609.32662-4-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58312
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

DMA_ERROR_CODE is not a public API and will go away.  Instead properly
unwind based on the loop counter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dma/ioat/init.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 6ad4384b3fa8..ed8ed1192775 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -839,8 +839,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 		goto free_resources;
 	}
 
-	for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
-		dma_srcs[i] = DMA_ERROR_CODE;
 	for (i = 0; i < IOAT_NUM_SRC_TEST; i++) {
 		dma_srcs[i] = dma_map_page(dev, xor_srcs[i], 0, PAGE_SIZE,
 					   DMA_TO_DEVICE);
@@ -910,8 +908,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 
 	xor_val_result = 1;
 
-	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
-		dma_srcs[i] = DMA_ERROR_CODE;
 	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
 		dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
 					   DMA_TO_DEVICE);
@@ -965,8 +961,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 	op = IOAT_OP_XOR_VAL;
 
 	xor_val_result = 0;
-	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
-		dma_srcs[i] = DMA_ERROR_CODE;
 	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
 		dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
 					   DMA_TO_DEVICE);
@@ -1017,18 +1011,14 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 	goto free_resources;
 dma_unmap:
 	if (op == IOAT_OP_XOR) {
-		if (dest_dma != DMA_ERROR_CODE)
-			dma_unmap_page(dev, dest_dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-		for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
-			if (dma_srcs[i] != DMA_ERROR_CODE)
-				dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
-					       DMA_TO_DEVICE);
+		while (--i >= 0)
+			dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
+				       DMA_TO_DEVICE);
+		dma_unmap_page(dev, dest_dma, PAGE_SIZE, DMA_FROM_DEVICE);
 	} else if (op == IOAT_OP_XOR_VAL) {
-		for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
-			if (dma_srcs[i] != DMA_ERROR_CODE)
-				dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
-					       DMA_TO_DEVICE);
+		while (--i >= 0)
+			dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
+				       DMA_TO_DEVICE);
 	}
 free_resources:
 	dma->device_free_chan_resources(dma_chan);
-- 
2.11.0
