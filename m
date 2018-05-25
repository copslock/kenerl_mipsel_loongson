Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:25:26 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993065AbeEYJWFXhS9A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MJlAC0itoeyEAL8mW9RX271rfhVuIHrEowJh2ms2Pew=; b=Ve0Pzp/K8ZKNCdUCzHBGrvLE0
        uliAAvNMsz0BQ3RCGhRMFoAUFSC547dZrpa+Yog4vzpuBUhJYT7qtyxYl7at4F7v9lZX82hUMwcCc
        8nq79tmr962ZSvoZKi4/7amhHPIk1CjNey3gl1QbHrS+Pl8A+/r7PnUKUS3VcMcNrit8+Z0YG4OFS
        /qjPmMRuJrBIGs6gCnOfFLDjYpTet2k2Fd5zCTcgGyFy/+67GbZ+cLNdWsKdwPtjcRN2l/r6nd2QN
        uBDTvPtRsQblmPkOZS+PIElxfNX5plh9SwR0QSgsT6S4+DjO0IAF4ub19g2+NLRqHqo4qM6rZTdPv
        ULSWXWRqA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vD-0001wq-Vs; Fri, 25 May 2018 09:22:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 15/25] MIPS: IP27: use dma_direct_ops
Date:   Fri, 25 May 2018 11:21:01 +0200
Message-Id: <20180525092111.18516-16-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64028
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

IP27 is coherent and has a reasonably direct mapping, just with a little
per-bus offset added into the dma address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                             |  2 +-
 .../include/asm/mach-ip27/dma-coherence.h     | 70 -------------------
 arch/mips/pci/pci-ip27.c                      | 14 ++++
 3 files changed, 15 insertions(+), 71 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ip27/dma-coherence.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 173e5714151c..934696595ad6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -677,11 +677,11 @@ config SGI_IP22
 
 config SGI_IP27
 	bool "SGI IP27 (Origin200/2000)"
+	select ARCH_HAS_PHYS_TO_DMA
 	select FW_ARC
 	select FW_ARC64
 	select BOOT_ELF64
 	select DEFAULT_SGI_PARTITION
-	select MIPS_DMA_DEFAULT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select NR_CPUS_DEFAULT_64
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
deleted file mode 100644
index 04d862020ac9..000000000000
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- *
- */
-#ifndef __ASM_MACH_IP27_DMA_COHERENCE_H
-#define __ASM_MACH_IP27_DMA_COHERENCE_H
-
-#include <asm/pci/bridge.h>
-
-#define pdev_to_baddr(pdev, addr) \
-	(BRIDGE_CONTROLLER(pdev->bus)->baddr + (addr))
-#define dev_to_baddr(dev, addr) \
-	pdev_to_baddr(to_pci_dev(dev), (addr))
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-	size_t size)
-{
-	dma_addr_t pa = dev_to_baddr(dev, virt_to_phys(addr));
-
-	return pa;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page));
-
-	return pa;
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	return dma_addr & ~(0xffUL << 56);
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 1;		/* IP27 non-coherent mode is unsupported */
-}
-
-#endif /* __ASM_MACH_IP27_DMA_COHERENCE_H */
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 0f09eafa5e3a..65b48d41a229 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
+#include <linux/dma-direct.h>
 #include <asm/sn/arch.h>
 #include <asm/pci/bridge.h>
 #include <asm/paccess.h>
@@ -182,6 +183,19 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
+
+	return bc->baddr + paddr;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr & ~(0xffUL << 56);
+}
+
 /*
  * Device might live on a subordinate PCI bus.	XXX Walk up the chain of buses
  * to find the slot number in sense of the bridge device register.
-- 
2.17.0
