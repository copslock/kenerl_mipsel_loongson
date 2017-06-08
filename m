Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:38:31 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:57722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbdFHN1vdwZuT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:27:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0wrZqfiUxzIjsMIP+kvG0ZcUFokN2jOk2GMWGR62hvY=; b=Udfuh7CiLVwNIiC/Fgt2z9emo
        WzabRtEQULAaySpysY7GiMg2bBz03srRUIG5jlUSZOvdrl9bV7BwA5YXMQZUqdS8KeKd/m5BgIT9d
        T6/nQARzzq48PnEKtPRAACUplYHICmY51fC06ggLmspnviuQMBlySMRx0gg9g2u0OJDt26Hdh3yGO
        eEo6qHzMRQvwWt6xy4e7p+r2LE7xRO+znPrFOvm1RAx3aIT+gW487L8rKCp1i/88mUPp5GazjK2tG
        S2mEYE+a19mWRkDkdJ58hGY/SCm8QgtNsdLgO9lqj+rpgfyZ6m6sO83q3ufGjTJR6L9/G4ILM+G5o
        2Lzm5AhsQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTS-0006gb-4k; Thu, 08 Jun 2017 13:27:42 +0000
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
Subject: [PATCH 22/44] x86/pci-nommu: implement ->mapping_error
Date:   Thu,  8 Jun 2017 15:25:47 +0200
Message-Id: <20170608132609.32662-23-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58332
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

DMA_ERROR_CODE is going to go away, so don't rely on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-nommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index a88952ef371c..085fe6ce4049 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -11,6 +11,8 @@
 #include <asm/iommu.h>
 #include <asm/dma.h>
 
+#define NOMMU_MAPPING_ERROR		0
+
 static int
 check_addr(char *name, struct device *hwdev, dma_addr_t bus, size_t size)
 {
@@ -33,7 +35,7 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	dma_addr_t bus = page_to_phys(page) + offset;
 	WARN_ON(size == 0);
 	if (!check_addr("map_single", dev, bus, size))
-		return DMA_ERROR_CODE;
+		return NOMMU_MAPPING_ERROR;
 	flush_write_buffers();
 	return bus;
 }
@@ -88,6 +90,11 @@ static void nommu_sync_sg_for_device(struct device *dev,
 	flush_write_buffers();
 }
 
+static int nommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == NOMMU_MAPPING_ERROR;
+}
+
 const struct dma_map_ops nommu_dma_ops = {
 	.alloc			= dma_generic_alloc_coherent,
 	.free			= dma_generic_free_coherent,
@@ -96,4 +103,5 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
+	.mapping_error		= nommu_mapping_error,
 };
-- 
2.11.0
