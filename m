Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2014 10:01:22 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61025 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008090AbaIMIAwdEPVS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2014 10:00:52 +0200
Received: by mail-pa0-f52.google.com with SMTP id kq14so2836197pab.25
        for <multiple recipients>; Sat, 13 Sep 2014 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xw0d7bCLn/1h8UCzjgdt/8/r9uJMwhyzFjiD7zYMqlA=;
        b=TqfCzqvJalOF4jiZ/tJeSjBROfFBCv8+5EYwDLMuXmrNuppNj9GP6LYSiMFGUmv6RU
         IxXZg22MlEr7hi7hODMR/0nV8IIXlw9b1CsdyL3KZVvt+bd6dd82n4OfWvYZSoHPrTRz
         tkcHFiVZuBaVPXDbAvWAnQr2QneHquXJFSWQqpvNdFKNMGNACgU+EhL3ZHdp+vdDwYNH
         XKTvnsJdJ4n/fYEzFWIDMCEiOS2+Ci+y1HMDeu6oFOEDVkZQEt/RUyWsv1g/nC1ECGuJ
         Vj+2QQ5E5P6PiLPexRjYe7xGSjvAvsTJAywYEVPb+wB1HVo7+sOSowl96hI0Okb23qr7
         lmmA==
X-Received: by 10.70.135.137 with SMTP id ps9mr22391405pdb.13.1410595245990;
        Sat, 13 Sep 2014 01:00:45 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id wh10sm6062397pac.20.2014.09.13.01.00.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 01:00:45 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 02/11] MIPS: Loongson-3: Add PHYS48_TO_HT40 support
Date:   Sat, 13 Sep 2014 16:00:00 +0800
Message-Id: <1410595207-10994-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
References: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42530
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
 .../mips/include/asm/mach-loongson/dma-coherence.h |   30 ++++++++++++++++++-
 arch/mips/loongson/Kconfig                         |    5 +++
 arch/mips/loongson/common/dma-swiotlb.c            |   10 ++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index 6a90275..aff3261 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -23,7 +23,17 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 					  size_t size)
 {
 #ifdef CONFIG_CPU_LOONGSON3
-	return virt_to_phys(addr);
+	long nid;
+	dma_addr_t daddr;
+
+	daddr = virt_to_phys(addr);
+#ifdef CONFIG_PHYS48_TO_HT40
+	 /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
+	  * Loongson-3's 48bit address space and embed it into 40bit */
+	nid = (daddr >> 44) & 0x3;
+	daddr = ((nid << 44) ^ daddr) | (nid << 37);
+#endif
+	return daddr;
 #else
 	return virt_to_phys(addr) | 0x80000000;
 #endif
@@ -33,7 +43,17 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 					       struct page *page)
 {
 #ifdef CONFIG_CPU_LOONGSON3
-	return page_to_phys(page);
+	long nid;
+	dma_addr_t daddr;
+
+	daddr = page_to_phys(page);
+#ifdef CONFIG_PHYS48_TO_HT40
+	 /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
+	  * Loongson-3's 48bit address space and embed it into 40bit */
+	nid = (daddr >> 44) & 0x3;
+	daddr = ((nid << 44) ^ daddr) | (nid << 37);
+#endif
+	return daddr;
 #else
 	return page_to_phys(page) | 0x80000000;
 #endif
@@ -43,6 +63,12 @@ static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 #if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
+	long nid;
+
+#ifdef CONFIG_PHYS48_TO_HT40
+	nid = (dma_addr >> 37) & 0x3;
+	dma_addr = ((nid << 37) ^ dma_addr) | (nid << 44);
+#endif
 	return dma_addr;
 #elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
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
index c2be01f..d0d43ad 100644
--- a/arch/mips/loongson/common/dma-swiotlb.c
+++ b/arch/mips/loongson/common/dma-swiotlb.c
@@ -105,11 +105,21 @@ static int loongson_dma_set_mask(struct device *dev, u64 mask)
 
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
+	long nid;
+#ifdef CONFIG_PHYS48_TO_HT40
+	nid = (paddr >> 44) & 0x3;
+	paddr = ((nid << 44) ^ paddr) | (nid << 37);
+#endif
 	return paddr;
 }
 
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
+	long nid;
+#ifdef CONFIG_PHYS48_TO_HT40
+	nid = (daddr >> 37) & 0x3;
+	daddr = ((nid << 37) ^ daddr) | (nid << 44);
+#endif
 	return daddr;
 }
 
-- 
1.7.7.3
