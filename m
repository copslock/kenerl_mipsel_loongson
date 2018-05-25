Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:26:51 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993104AbeEYJWYgRw6A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OZUmK61Bq3TCM16TsnPVAUs6tFjc+KXb4Y+NnJf+Q6c=; b=Gu+6cs96B/yNy0zR0Gtmj3D9O
        CdhHcSYgMW97ANkfQIljCjWM+n6ln46SuQTe4Y6YhC2cC5TjrqibRTy9pb5s0pj0uH6o2+MQIB5Tq
        2U/TdBEtZNBGYKUlqlUcHLVngTtf5JZiEURW5p1KtodDG9m0Rm8LVI3HNyB7Eu4Viq6AUEDT2uBVs
        jmu27k82OHBAokSUUvUXQ2bImruwEYLHsj+Q14OYx0irFH7ShYuSyYV6U77TArPS5Qc3JbulfNyOf
        v3gLhodHLRiXlY+468/B/aTlEwr/dKNJEaaTJ1qE/QaI+1aOLwgQONevTCszOCV2FQeL2uIArG9xK
        6nHwsOuzg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vT-0001yz-7F; Fri, 25 May 2018 09:22:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 20/25] MIPS: ath25: use generic dma noncoherent ops
Date:   Fri, 25 May 2018 11:21:06 +0200
Message-Id: <20180525092111.18516-21-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64033
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

Provide phys_to_dma/dma_to_phys helpers only if PCI support is
enabled, everything else is generic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                             |  1 -
 arch/mips/ath25/Kconfig                       |  1 +
 .../include/asm/mach-ath25/dma-coherence.h    | 71 -------------------
 arch/mips/pci/pci-ar2315.c                    | 24 +++++++
 4 files changed, 25 insertions(+), 72 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bde16399a8fe..25a3c3262554 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -176,7 +176,6 @@ config ATH25
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
 	select IRQ_DOMAIN
-	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/ath25/Kconfig b/arch/mips/ath25/Kconfig
index 7070b4bcd01d..2c1dfd06c366 100644
--- a/arch/mips/ath25/Kconfig
+++ b/arch/mips/ath25/Kconfig
@@ -12,6 +12,7 @@ config SOC_AR2315
 config PCI_AR2315
 	bool "Atheros AR2315 PCI controller support"
 	depends on SOC_AR2315
+	select ARCH_HAS_PHYS_TO_DMA
 	select HW_HAS_PCI
 	select PCI
 	default y
diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
deleted file mode 100644
index 124755d4f079..000000000000
--- a/arch/mips/include/asm/mach-ath25/dma-coherence.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2007  Felix Fietkau <nbd@openwrt.org>
- *
- */
-#ifndef __ASM_MACH_ATH25_DMA_COHERENCE_H
-#define __ASM_MACH_ATH25_DMA_COHERENCE_H
-
-#include <linux/device.h>
-
-/*
- * We need some arbitrary non-zero value to be programmed to the BAR1 register
- * of PCI host controller to enable DMA. The same value should be used as the
- * offset to calculate the physical address of DMA buffer for PCI devices.
- */
-#define AR2315_PCI_HOST_SDRAM_BASEADDR	0x20000000
-
-static inline dma_addr_t ath25_dev_offset(struct device *dev)
-{
-#ifdef CONFIG_PCI
-	extern struct bus_type pci_bus_type;
-
-	if (dev && dev->bus == &pci_bus_type)
-		return AR2315_PCI_HOST_SDRAM_BASEADDR;
-#endif
-	return 0;
-}
-
-static inline dma_addr_t
-plat_map_dma_mem(struct device *dev, void *addr, size_t size)
-{
-	return virt_to_phys(addr) + ath25_dev_offset(dev);
-}
-
-static inline dma_addr_t
-plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	return page_to_phys(page) + ath25_dev_offset(dev);
-}
-
-static inline unsigned long
-plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr - ath25_dev_offset(dev);
-}
-
-static inline void
-plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr, size_t size,
-		   enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-#endif /* __ASM_MACH_ATH25_DMA_COHERENCE_H */
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index b4fa6413c4e5..c539d0d2b0cf 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -149,6 +149,13 @@
 #define AR2315_PCI_HOST_SLOT	3
 #define AR2315_PCI_HOST_DEVID	((0xff18 << 16) | PCI_VENDOR_ID_ATHEROS)
 
+/*
+ * We need some arbitrary non-zero value to be programmed to the BAR1 register
+ * of PCI host controller to enable DMA. The same value should be used as the
+ * offset to calculate the physical address of DMA buffer for PCI devices.
+ */
+#define AR2315_PCI_HOST_SDRAM_BASEADDR	0x20000000
+
 /* ??? access BAR */
 #define AR2315_PCI_HOST_MBAR0		0x10000000
 /* RAM access BAR */
@@ -167,6 +174,23 @@ struct ar2315_pci_ctrl {
 	struct resource io_res;
 };
 
+static inline dma_addr_t ar2315_dev_offset(struct device *dev)
+{
+	if (dev && dev_is_pci(dev))
+		return AR2315_PCI_HOST_SDRAM_BASEADDR;
+	return 0;
+}
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr + ar2315_dev_offset(dev);
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr - ar2315_dev_offset(dev);
+}
+
 static inline struct ar2315_pci_ctrl *ar2315_pci_bus_to_apc(struct pci_bus *bus)
 {
 	struct pci_controller *hose = bus->sysdata;
-- 
2.17.0
