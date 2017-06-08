Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:40:47 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:52074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993983AbdFHN2G7ceZT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:28:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Er/PBxW/tOtoCNR0FHj1VvmeiHjF/tVFU+Dqgf9uoBM=; b=DuQWAeDsdmuE2TG+u3hI7Bt0v
        NaPkHxkVot5MDGxHwXkca1kuAwmt/IiJzIhVcT+Iocc9fae9anvVEU4nitUGMUC6qDw8Cl3B5jxHs
        gdkt+0pFn7AgHV+r9SHnqmfG2MXWgEIS+tvaOB4EngemWtjYyX88hizeS/FF7AX0E9AymIqA/CiW4
        99Ozwe7xu65TRPfeeVYXYb8DbLQ1oK7gcXlOrsbv2F8+zGWr0LQ2UrilO8HFVOCpxSPIAKmkABv/L
        To43nH3uLe5rMQ4pRR6OV/SZJJpc4Yap1EBZKH+JOq7wZULj+/qF/CIvOCfzWidxiZ8ThubyqB32V
        N5tDkI4oA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTg-00070Z-Ve; Thu, 08 Jun 2017 13:27:57 +0000
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
Subject: [PATCH 26/44] dma-mapping: remove DMA_ERROR_CODE
Date:   Thu,  8 Jun 2017 15:25:51 +0200
Message-Id: <20170608132609.32662-27-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58336
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

And update the documentation - dma_mapping_error has been supported
everywhere for a long time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API-HOWTO.txt | 31 +++++--------------------------
 include/linux/dma-mapping.h     |  5 -----
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 979228bc9035..4ed388356898 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -550,32 +550,11 @@ and to unmap it:
 	dma_unmap_single(dev, dma_handle, size, direction);
 
 You should call dma_mapping_error() as dma_map_single() could fail and return
-error. Not all DMA implementations support the dma_mapping_error() interface.
-However, it is a good practice to call dma_mapping_error() interface, which
-will invoke the generic mapping error check interface. Doing so will ensure
-that the mapping code will work correctly on all DMA implementations without
-any dependency on the specifics of the underlying implementation. Using the
-returned address without checking for errors could result in failures ranging
-from panics to silent data corruption. A couple of examples of incorrect ways
-to check for errors that make assumptions about the underlying DMA
-implementation are as follows and these are applicable to dma_map_page() as
-well.
-
-Incorrect example 1:
-	dma_addr_t dma_handle;
-
-	dma_handle = dma_map_single(dev, addr, size, direction);
-	if ((dma_handle & 0xffff != 0) || (dma_handle >= 0x1000000)) {
-		goto map_error;
-	}
-
-Incorrect example 2:
-	dma_addr_t dma_handle;
-
-	dma_handle = dma_map_single(dev, addr, size, direction);
-	if (dma_handle == DMA_ERROR_CODE) {
-		goto map_error;
-	}
+error.  Doing so will ensure that the mapping code will work correctly on all
+DMA implementations without any dependency on the specifics of the underlying
+implementation. Using the returned address without checking for errors could
+result in failures ranging from panics to silent data corruption.  The same
+applies to dma_map_page() as well.
 
 You should call dma_unmap_single() when the DMA activity is finished, e.g.,
 from the interrupt which told you that the DMA transfer is done.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4f3eecedca2d..a57875309bfd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -546,12 +546,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 
 	if (get_dma_ops(dev)->mapping_error)
 		return get_dma_ops(dev)->mapping_error(dev, dma_addr);
-
-#ifdef DMA_ERROR_CODE
-	return dma_addr == DMA_ERROR_CODE;
-#else
 	return 0;
-#endif
 }
 
 #ifndef HAVE_ARCH_DMA_SUPPORTED
-- 
2.11.0
