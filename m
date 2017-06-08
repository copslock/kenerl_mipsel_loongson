Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:48:13 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:34812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993989AbdFHN2ujqDpT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:28:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lwbn6f4QHb4uIuK5j7O2zH2GX5vKyW4uQvUxXNv1jCw=; b=NEyqKxWatZ0W16ZlxuMiUsLZP
        VflWTSZ5V3ene8o/qO7VQT1lD1NaX0ZizO6+zjANykgm2xrJO2rZw7xIvrG7BBQiphVE/798gLSfn
        ztijqe2XhobSI07W8UjkJwt3yCUspgi468BaILari6o12d1NdP4Tyq9wKlBmELsrBJUXnkoJnO3jS
        AYd30ZW0FyF/6J2nH52KCiZTOHozAZn5JBMTeMgVgy0hRxa3f5JGyI43Hw/VwqtrpR/HqWUvdP9wv
        sNGBhqfaAR+/r1ExIwJGEVMfT+CEmrsuFa8ES8nPFaixQsTHRDsIIIDxf+SIzxxj74uwlBrCp3hoI
        T0vVBm/NQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxUQ-000803-EX; Thu, 08 Jun 2017 13:28:43 +0000
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
Subject: [PATCH 38/44] arm: implement ->dma_supported instead of ->set_dma_mask
Date:   Thu,  8 Jun 2017 15:26:03 +0200
Message-Id: <20170608132609.32662-39-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58348
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

Same behavior, less code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/common/dmabounce.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 4aabf117e136..d89a0b56b245 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -445,12 +445,12 @@ static void dmabounce_sync_for_device(struct device *dev,
 	arm_dma_ops.sync_single_for_device(dev, handle, size, dir);
 }
 
-static int dmabounce_set_mask(struct device *dev, u64 dma_mask)
+static int dmabounce_dma_supported(struct device *dev, u64 dma_mask)
 {
 	if (dev->archdata.dmabounce)
 		return 0;
 
-	return arm_dma_ops.set_dma_mask(dev, dma_mask);
+	return arm_dma_ops.dma_supported(dev, dma_mask);
 }
 
 static int dmabounce_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -474,9 +474,8 @@ static const struct dma_map_ops dmabounce_ops = {
 	.unmap_sg		= arm_dma_unmap_sg,
 	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
-	.set_dma_mask		= dmabounce_set_mask,
+	.dma_supported		= dmabounce_dma_supported,
 	.mapping_error		= dmabounce_mapping_error,
-	.dma_supported		= arm_dma_supported,
 };
 
 static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
-- 
2.11.0
