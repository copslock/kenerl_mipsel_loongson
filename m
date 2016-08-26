Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:41:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50895 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992536AbcHZPkOOepYI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:40:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E80F012C297FD;
        Fri, 26 Aug 2016 16:39:53 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:39:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 08/26] MIPS: dma-default: Don't check hw_coherentio if device is non-coherent
Date:   Fri, 26 Aug 2016 16:37:07 +0100
Message-ID: <20160826153725.11629-9-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

There are no cases where plat_device_is_coherent() will return zero
whilst hw_coherentio is non-zero, and acting any differently in such a
case doesn't make much sense - if a device is non-coherent with the CPU
caches then access to memory "coherent" with DMA must be uncached. Clean
up the nonsensical case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mm/dma-default.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index a9c1e94..6540355 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -161,8 +161,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	*dma_handle = plat_map_dma_mem(dev, ret, size);
 	if (!plat_device_is_coherent(dev)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
-		if (!hw_coherentio)
-			ret = UNCAC_ADDR(ret);
+		ret = UNCAC_ADDR(ret);
 	}
 
 	return ret;
@@ -190,7 +189,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
-	if (!plat_device_is_coherent(dev) && !hw_coherentio)
+	if (!plat_device_is_coherent(dev))
 		addr = CAC_ADDR(addr);
 
 	page = virt_to_page((void *) addr);
@@ -210,7 +209,7 @@ static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn;
 	int ret = -ENXIO;
 
-	if (!plat_device_is_coherent(dev) && !hw_coherentio)
+	if (!plat_device_is_coherent(dev))
 		addr = CAC_ADDR(addr);
 
 	pfn = page_to_pfn(virt_to_page((void *)addr));
-- 
2.9.3
