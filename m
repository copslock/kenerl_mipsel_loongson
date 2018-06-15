Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:14:47 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeFOLJkYQMAT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8xOQQknr6BJ2mf5/SGnGX5FkOCpuUujDucGTFatdQHQ=; b=UymyY+6PF6fKYEpUJNAD84X3G
        8WPcCfASa8glUkIWQosW0zq8PI4/FfLdrvg63Cx7zzJAqxgm+MU5+N1wg8z2c0Pdxae0KXzXr5NGa
        vZa+FhMVyHefN2cn3h1KrzlerhBLVKg8a2D/LXc9c68W/rLe9yBuQmklAvw+mEeGtR3XkyA+09XT9
        GLVC7nOg9Ba2CTNamZZR1K7utAkvhgdcSmufOGmRynZ+QxQ5lieVc0JbPsdJMGrA2UAGE+aWrvXJV
        13cn0TZbq3Gu8PZ6os1Qq8pmtefA6WdPHep9Er9AT0VEjUCuZejnXKP/jQGB2spb/w5bzXHvV+eVr
        kTVEq2YlQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbp-00055G-M7; Fri, 15 Jun 2018 11:09:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: [PATCH 12/25] MIPS: loongson: untangle dma implementations
Date:   Fri, 15 Jun 2018 13:08:41 +0200
Message-Id: <20180615110854.19253-13-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64293
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

Only loongson-3 is DMA coherent and uses swiotlb.  So move the dma
address translations stubs directly to the loongson-3 code, and remove
a few Kconfig indirections.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                                |  2 +-
 arch/mips/loongson64/Kconfig                     |  5 -----
 arch/mips/loongson64/common/Makefile             |  5 -----
 arch/mips/loongson64/loongson-3/Makefile         |  2 +-
 .../{common/dma-swiotlb.c => loongson-3/dma.c}   | 16 ++++------------
 5 files changed, 6 insertions(+), 24 deletions(-)
 rename arch/mips/loongson64/{common/dma-swiotlb.c => loongson-3/dma.c} (68%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8893063609..aae92a7b6a9c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -453,7 +453,6 @@ config MACH_LOONGSON32
 
 config MACH_LOONGSON64
 	bool "Loongson-2/3 family of machines"
-	select ARCH_HAS_PHYS_TO_DMA
 	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables the support of Loongson-2/3 family of machines.
@@ -1388,6 +1387,7 @@ choice
 config CPU_LOONGSON3
 	bool "Loongson 3 CPU"
 	depends on SYS_HAS_CPU_LOONGSON3
+	select ARCH_HAS_PHYS_TO_DMA
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index dbd2a9f9f9a9..a785bf8da3f3 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -93,7 +93,6 @@ config LOONGSON_MACH3X
 	select LOONGSON_MC146818
 	select ZONE_DMA32
 	select LEFI_FIRMWARE_INTERFACE
-	select PHYS48_TO_HT40
 	help
 		Generic Loongson 3 family machines utilize the 3A/3B revision
 		of Loongson processor and RS780/SBX00 chipset.
@@ -132,10 +131,6 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
-config PHYS48_TO_HT40
-	bool
-	default y if CPU_LOONGSON3
-
 config LOONGSON_MC146818
 	bool
 	default n
diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index 8235ac7eac95..684624f61f5a 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -25,8 +25,3 @@ obj-$(CONFIG_CS5536) += cs5536/
 #
 
 obj-$(CONFIG_SUSPEND) += pm.o
-
-#
-# Big Memory (SWIOTLB) Support
-#
-obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
diff --git a/arch/mips/loongson64/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
index 44bc1482158b..b5a0c2fa5446 100644
--- a/arch/mips/loongson64/loongson-3/Makefile
+++ b/arch/mips/loongson64/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o
+obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o dma.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/loongson-3/dma.c
similarity index 68%
rename from arch/mips/loongson64/common/dma-swiotlb.c
rename to arch/mips/loongson64/loongson-3/dma.c
index a4f554bf1232..5e86635f71db 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/loongson-3/dma.c
@@ -5,26 +5,18 @@
 
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	long nid;
-#ifdef CONFIG_PHYS48_TO_HT40
 	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
 	 * Loongson-3's 48bit address space and embed it into 40bit */
-	nid = (paddr >> 44) & 0x3;
-	paddr = ((nid << 44) ^ paddr) | (nid << 37);
-#endif
-	return paddr;
+	long nid = (paddr >> 44) & 0x3;
+	return ((nid << 44) ^ paddr) | (nid << 37);
 }
 
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	long nid;
-#ifdef CONFIG_PHYS48_TO_HT40
 	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
 	 * Loongson-3's 48bit address space and embed it into 40bit */
-	nid = (daddr >> 37) & 0x3;
-	daddr = ((nid << 37) ^ daddr) | (nid << 44);
-#endif
-	return daddr;
+	long nid = (daddr >> 37) & 0x3;
+	return ((nid << 37) ^ daddr) | (nid << 44);
 }
 
 void __init plat_swiotlb_setup(void)
-- 
2.17.1
