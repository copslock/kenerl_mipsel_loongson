Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:24:39 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeEYJVzcZztA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KUNGPVMHNRkYQNkHs89q4gL5VyS3E5Xr+fh6iFYG7E0=; b=oUifcZCHlTT7V6p4suWNkCN7O
        0QRRSl2rnRi6mQ7holBbtekWYfsrXa0ZYfg4Kzh5gde5Az5rPVx/2qrz4uMBH/xLhrAsj04WfpZ9n
        P3YHXzyY3X+JfjLln0OzrZZADKyD2vUl1SqG8Q/o1hJMaKIaLmrdh5qdIrMd0+Zemy+OT+za45iqv
        0ETue3IbMKMqVlpamwXMIZvZEFiWOdWWS2rktzNe7dtqyAqxbI70ycnTsA5OIYAxHxtkGgUKcyQMl
        kNolmqimhBHepcv1DeMqv9+zOdxjNE0vi8GffKMYX3tejJ0ImaAm74aJiNC9sQnwmYDhWQG8faoSv
        bx54AJitA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8v3-0001px-Kh; Fri, 25 May 2018 09:21:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 12/25] MIPS: loongson: untangle dma implementations
Date:   Fri, 25 May 2018 11:20:58 +0200
Message-Id: <20180525092111.18516-13-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64025
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
index 92cc7943d940..24cc20ea60b9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -448,7 +448,6 @@ config MACH_LOONGSON32
 
 config MACH_LOONGSON64
 	bool "Loongson-2/3 family of machines"
-	select ARCH_HAS_PHYS_TO_DMA
 	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables the support of Loongson-2/3 family of machines.
@@ -1383,6 +1382,7 @@ choice
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
2.17.0
