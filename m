Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:36:01 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:45278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993964AbdFHN1b3KywT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F+yt1HmxfX0oBhz7WNNwPtU3mk493hZ15FmCasYlOCo=; b=L9iDa/0G6S1uUmVVWw4P85gJA
        gWzelRN+H5d7FlHLrSw6sL6B6oCLh2mMoHQyuylOpLmScjNmJQ5T4hpyPpTyjpuC7mz5XyJyw9qFy
        gncdSz3mEQe2bZ9BB5BIns0yxH8Hzoim+7QXKuUrIwWAVg9SKvl+onfRbS78g3itjqyxVYTafwRXx
        eepAn9yhqRA85lz8MhaFNyDCfEDjQA5kEcKWtOvk8NNjvbHzIcFC00LF1yJqw8flMMSI8N+Da0kOL
        Vw3vaEEIO49nMgCu8iey7PMT1V6Hexfok7z9TYSXuZJRRXJqkhwQIr+sAfuzGMKRWuOEb23v1U68p
        9oOS186og==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTA-0006Fu-2j; Thu, 08 Jun 2017 13:27:25 +0000
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
Subject: [PATCH 17/44] hexagon: switch to use ->mapping_error for error reporting
Date:   Thu,  8 Jun 2017 15:25:42 +0200
Message-Id: <20170608132609.32662-18-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58327
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
 arch/hexagon/include/asm/dma-mapping.h |  2 --
 arch/hexagon/kernel/dma.c              | 12 +++++++++---
 arch/hexagon/kernel/hexagon_ksyms.c    |  1 -
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index d3a87bd9b686..00e3f10113b0 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -29,8 +29,6 @@
 #include <asm/io.h>
 
 struct device;
-extern int bad_dma_address;
-#define DMA_ERROR_CODE bad_dma_address
 
 extern const struct dma_map_ops *dma_ops;
 
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index e74b65009587..71269dc0f225 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -25,11 +25,11 @@
 #include <linux/module.h>
 #include <asm/page.h>
 
+#define HEXAGON_MAPPING_ERROR	0
+
 const struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-int bad_dma_address;  /*  globals are automatically initialized to zero  */
-
 static inline void *dma_addr_to_virt(dma_addr_t dma_addr)
 {
 	return phys_to_virt((unsigned long) dma_addr);
@@ -181,7 +181,7 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	WARN_ON(size == 0);
 
 	if (!check_addr("map_single", dev, bus, size))
-		return bad_dma_address;
+		return HEXAGON_MAPPING_ERROR;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_sync(dma_addr_to_virt(bus), size, dir);
@@ -203,6 +203,11 @@ static void hexagon_sync_single_for_device(struct device *dev,
 	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
 }
 
+static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == HEXAGON_MAPPING_ERROR;
+}
+
 const struct dma_map_ops hexagon_dma_ops = {
 	.alloc		= hexagon_dma_alloc_coherent,
 	.free		= hexagon_free_coherent,
@@ -210,6 +215,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_page	= hexagon_map_page,
 	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
+	.mapping_error	= hexagon_mapping_error;
 	.is_phys	= 1,
 };
 
diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index 00bcad9cbd8f..aa248f595431 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -40,7 +40,6 @@ EXPORT_SYMBOL(memset);
 /* Additional variables */
 EXPORT_SYMBOL(__phys_offset);
 EXPORT_SYMBOL(_dflt_cache_att);
-EXPORT_SYMBOL(bad_dma_address);
 
 #define DECLARE_EXPORT(name)     \
 	extern void name(void); EXPORT_SYMBOL(name)
-- 
2.11.0
