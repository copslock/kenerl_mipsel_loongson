Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:14:44 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49581 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011082AbaKDGOFCqVC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:05 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so13704472pab.19
        for <multiple recipients>; Mon, 03 Nov 2014 22:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GjaZKPvvZD0pWTbcRxuwt8l0w304enEF9Nq6P4K2Nk4=;
        b=A7xrUWj0gKgtHSY3iymPR2idAGsD+a4PBLftW8T7CJypp88sq08iTxnzqyHIx9OZ4C
         yuKSpATwlWJ7NqBbL0ZXw1sWnDykrgeSsnhkd4aECHDuFTIpAGGFQh0j1uFFPXdOYhJf
         zksMI29ycRkIW//l+GcLSvFthDX7GapzdiFYdS5wovRDf8dNdsQ82PC2Gmno+GFwjKd9
         wGbUB2N8OKeFxRPUfZlA4CkEUVtrqAUeF3NWo27w0MsAY2ddL5S1XIYCmU8mIVeYwhQq
         4CfiDCv8KFQpPqQLGvNkHhJ7uMfE5Ej1TdBv5dZgK+PluVxflJ6Fg/FWQ+wggL7A09mA
         sYJA==
X-Received: by 10.70.34.206 with SMTP id b14mr41857058pdj.10.1415081638964;
        Mon, 03 Nov 2014 22:13:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.13.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:13:58 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 03/12] MIPS: Loongson-3: Add PHYS48_TO_HT40 support
Date:   Tue,  4 Nov 2014 14:13:24 +0800
Message-Id: <1415081610-25639-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

The width of HT-bus is only 40-bit, but Loongson-3 has 48-bit physical
address. This implies only node-0's memory is DMAable because high bits
(Node ID) will lost. Fortunately, by configuring address windows in
firmware, we can extract 2bit Node ID (bit 44~47, only bit 44~45 used
now) from Loongson-3's 48-bit address space and embed it into 40-bit
(bit 37~38). Every NUMA node can do DMA now (however, maximum memory of
each node is reduced to 2^37 = 128GB).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 .../mips/include/asm/mach-loongson/dma-coherence.h |    6 +++---
 arch/mips/loongson/Kconfig                         |    5 +++++
 arch/mips/loongson/common/dma-swiotlb.c            |   14 ++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index 6a90275..a905341 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -23,7 +23,7 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 					  size_t size)
 {
 #ifdef CONFIG_CPU_LOONGSON3
-	return virt_to_phys(addr);
+	return phys_to_dma(dev, virt_to_phys(addr));
 #else
 	return virt_to_phys(addr) | 0x80000000;
 #endif
@@ -33,7 +33,7 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 					       struct page *page)
 {
 #ifdef CONFIG_CPU_LOONGSON3
-	return page_to_phys(page);
+	return phys_to_dma(dev, page_to_phys(page));
 #else
 	return page_to_phys(page) | 0x80000000;
 #endif
@@ -43,7 +43,7 @@ static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 #if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
-	return dma_addr;
+	return dma_to_phys(dev, dma_addr);
 #elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
 #else
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 1b91fc6..72f830ac 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -86,6 +86,7 @@ config LOONGSON_MACH3X
 	select LOONGSON_MC146818
 	select ZONE_DMA32
 	select LEFI_FIRMWARE_INTERFACE
+	select PHYS48_TO_HT40
 	help
 		Generic Loongson 3 family machines utilize the 3A/3B revision
 		of Loongson processor and RS780/SBX00 chipset.
@@ -131,6 +132,10 @@ config SWIOTLB
 	select NEED_SG_DMA_LENGTH
 	select NEED_DMA_MAP_STATE
 
+config PHYS48_TO_HT40
+	bool
+	default y if CPU_LOONGSON3
+
 config LOONGSON_MC146818
 	bool
 	default n
diff --git a/arch/mips/loongson/common/dma-swiotlb.c b/arch/mips/loongson/common/dma-swiotlb.c
index c2be01f..2c6b989 100644
--- a/arch/mips/loongson/common/dma-swiotlb.c
+++ b/arch/mips/loongson/common/dma-swiotlb.c
@@ -105,11 +105,25 @@ static int loongson_dma_set_mask(struct device *dev, u64 mask)
 
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
+	long nid;
+#ifdef CONFIG_PHYS48_TO_HT40
+	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
+	 * Loongson-3's 48bit address space and embed it into 40bit */
+	nid = (paddr >> 44) & 0x3;
+	paddr = ((nid << 44) ^ paddr) | (nid << 37);
+#endif
 	return paddr;
 }
 
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
+	long nid;
+#ifdef CONFIG_PHYS48_TO_HT40
+	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
+	 * Loongson-3's 48bit address space and embed it into 40bit */
+	nid = (daddr >> 37) & 0x3;
+	daddr = ((nid << 37) ^ daddr) | (nid << 44);
+#endif
 	return daddr;
 }
 
-- 
1.7.7.3
