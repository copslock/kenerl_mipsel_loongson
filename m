Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 13:28:42 +0100 (CET)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42876 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab1LWM2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 13:28:07 +0100
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LWN006EMPAMQK@mailout1.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:27:58 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWN006YJPALCM@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:27:58 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 7190B270052; Fri,
 23 Dec 2011 13:39:23 +0100 (CET)
Date:   Fri, 23 Dec 2011 13:27:20 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <1324643253-3024-2-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.7.3
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18792

Introduce new generic alloc and free methods with attributes argument.

Existing alloc_coherent and free_coherent can be implemented on top of the
new calls with NULL attributes argument. Later also dma_alloc_non_coherent
can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.

This way the drivers will get more generic, platform independent way of
allocating dma buffers with specific parameters.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/dma-mapping.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e13117c..8cc7f95 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -13,6 +13,12 @@ struct dma_map_ops {
 				dma_addr_t *dma_handle, gfp_t gfp);
 	void (*free_coherent)(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle);
+	void* (*alloc)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t gfp,
+				struct dma_attrs *attrs);
+	void (*free)(struct device *dev, size_t size,
+			      void *vaddr, dma_addr_t dma_handle,
+			      struct dma_attrs *attrs);
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-- 
1.7.1.569.g6f426
