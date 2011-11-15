Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 00:46:56 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:64988 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903742Ab1KOXq1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 00:46:27 +0100
Received: by ywp31 with SMTP id 31so7230857ywp.36
        for <multiple recipients>; Tue, 15 Nov 2011 15:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jBgS9n7/hw2yBzKQtoDlaUiCMcRzZ7/I1tA1vIef6vs=;
        b=fuCNniibt4xpBu9miUQy+iDmfgu+j+6AaW4OX6p2UX7SITuvVQFvdyAGZ/ZfUqAyp+
         lf6pM2D4mTf7Tbrpbobk24KGHXR8ZV3/FlO0a8zFWkvIflfKjqWtT3zX6BjKGrjLGhmA
         ejEN64+Q/fJ9kZYQuSgmm0ZSY/m/IpLghudBY=
Received: by 10.101.57.14 with SMTP id j14mr8686928ank.112.1321400781191;
        Tue, 15 Nov 2011 15:46:21 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l18sm49913648anb.22.2011.11.15.15.46.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 15:46:20 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAFNkIca032402;
        Tue, 15 Nov 2011 15:46:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAFNkINa032401;
        Tue, 15 Nov 2011 15:46:18 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/5] MIPS: Octeon: Update DMA mapping operations for OCTEON II processors.
Date:   Tue, 15 Nov 2011 15:46:13 -0800
Message-Id: <1321400775-32353-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12942

From: David Daney <david.daney@cavium.com>

OCTEON II has a new dma to phys mapping method for PCIe.  Define
OCTEON_DMA_BAR_TYPE_PCIE2 to denote this case, and handle it.

OCTEON II also needs a swiotlb if the OHCI USB driver is enabled, so
allocate this too.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/dma-octeon.c      |   23 +++++++++++++++++++++--
 arch/mips/include/asm/octeon/pci-octeon.h |    3 ++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index ea4feba..b6bb92c 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -61,6 +61,16 @@ static phys_addr_t octeon_gen1_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
+static dma_addr_t octeon_gen2_phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return octeon_hole_phys_to_dma(paddr);
+}
+
+static phys_addr_t octeon_gen2_dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return octeon_hole_dma_to_phys(daddr);
+}
+
 static dma_addr_t octeon_big_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	if (paddr >= 0x410000000ull && paddr < 0x420000000ull)
@@ -262,11 +272,11 @@ void __init plat_swiotlb_setup(void)
 
 	for (i = 0 ; i < boot_mem_map.nr_map; i++) {
 		struct boot_mem_map_entry *e = &boot_mem_map.map[i];
-		if (e->type != BOOT_MEM_RAM)
+		if (e->type != BOOT_MEM_RAM && e->type != BOOT_MEM_INIT_RAM)
 			continue;
 
 		/* These addresses map low for PCI. */
-		if (e->addr > 0x410000000ull)
+		if (e->addr > 0x410000000ull && !OCTEON_IS_MODEL(OCTEON_CN6XXX))
 			continue;
 
 		addr_size += e->size;
@@ -296,6 +306,11 @@ void __init plat_swiotlb_setup(void)
 		swiotlbsize = 64 * (1<<20);
 	}
 #endif
+#ifdef CONFIG_USB_OCTEON_OHCI
+	/* OCTEON II ohci is only 32-bit. */
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX) && max_addr >= 0x100000000ul)
+		swiotlbsize = 64 * (1<<20);
+#endif
 	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
 	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
 	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
@@ -330,6 +345,10 @@ struct dma_map_ops *octeon_pci_dma_map_ops;
 void __init octeon_pci_dma_init(void)
 {
 	switch (octeon_dma_bar_type) {
+	case OCTEON_DMA_BAR_TYPE_PCIE2:
+		_octeon_pci_dma_map_ops.phys_to_dma = octeon_gen2_phys_to_dma;
+		_octeon_pci_dma_map_ops.dma_to_phys = octeon_gen2_dma_to_phys;
+		break;
 	case OCTEON_DMA_BAR_TYPE_PCIE:
 		_octeon_pci_dma_map_ops.phys_to_dma = octeon_gen1_phys_to_dma;
 		_octeon_pci_dma_map_ops.dma_to_phys = octeon_gen1_dma_to_phys;
diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
index fba2ba2..c66734b 100644
--- a/arch/mips/include/asm/octeon/pci-octeon.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -56,7 +56,8 @@ enum octeon_dma_bar_type {
 	OCTEON_DMA_BAR_TYPE_INVALID,
 	OCTEON_DMA_BAR_TYPE_SMALL,
 	OCTEON_DMA_BAR_TYPE_BIG,
-	OCTEON_DMA_BAR_TYPE_PCIE
+	OCTEON_DMA_BAR_TYPE_PCIE,
+	OCTEON_DMA_BAR_TYPE_PCIE2
 };
 
 /*
-- 
1.7.2.3
