Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:25:11 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993041AbeEYJWCRJTtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aCcfSBfMf3NlKskqrCtQ3/wpr5W6TBS1v8aapJcdnQA=; b=kf4+JVQnEHNYfZIEy75z2j+qd
        cTTRC5N4I8hWbo+z5PWH9dFTVZ6zB4KC06qwC4gMIRrb8LlHFEsajbCZdeQWbMhJhhpL+iMEiM7VS
        CE88Akpn+RJlfTaT8A6iG17ea5wyheb7/giFvEOGGcqnLwMtTRF+qaUStxHG+froqyTf8zvQFiARt
        4uIdyyV1OP6IqbjwsAuDS1u5JRCOYIA4v/8/saPSX+2PlploaGFGvlwhC6naVPVaCuk5B3kWgFx2t
        h76cdjKzRaMwZ1pBuVMPWFkosHb4RXRjSTxmfCjWnqUW+JVGKpZ5e/xjXeX0ohKp49S2uuhE2N3So
        rKxHuDuEw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vA-0001wT-Mb; Fri, 25 May 2018 09:22:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 14/25] MIPS: use dma_direct_ops for coherent I/O
Date:   Fri, 25 May 2018 11:21:00 +0200
Message-Id: <20180525092111.18516-15-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64027
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

Switch the simple cache coherent architectures that don't require any
DMA address translation to dma_direct_ops.

We'll soon use at least parts of the direct DMA ops implementation for
all platforms, so select the symbol globally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                   | 15 +--------------
 arch/mips/include/asm/dma-mapping.h |  2 +-
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 24cc20ea60b9..173e5714151c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -16,6 +16,7 @@ config MIPS
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select CPU_PM if CPU_IDLE
+	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
@@ -563,7 +564,6 @@ config NEC_MARKEINS
 	bool "NEC EMMA2RH Mark-eins board"
 	select SOC_EMMA2RH
 	select HW_HAS_PCI
-	select MIPS_DMA_DEFAULT
 	help
 	  This enables support for the NEC Electronics Mark-eins boards.
 
@@ -577,14 +577,12 @@ config MACH_VR41XX
 
 config NXP_STB220
 	bool "NXP STB220 board"
-	select MIPS_DMA_DEFAULT
 	select SOC_PNX833X
 	help
 	 Support for NXP Semiconductors STB220 Development Board.
 
 config NXP_STB225
 	bool "NXP 225 board"
-	select MIPS_DMA_DEFAULT
 	select SOC_PNX833X
 	select SOC_PNX8335
 	help
@@ -762,7 +760,6 @@ config SGI_IP32
 config SIBYTE_CRHINE
 	bool "Sibyte BCM91120C-CRhine"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -772,7 +769,6 @@ config SIBYTE_CRHINE
 config SIBYTE_CARMEL
 	bool "Sibyte BCM91120x-Carmel"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -782,7 +778,6 @@ config SIBYTE_CARMEL
 config SIBYTE_CRHONE
 	bool "Sibyte BCM91125C-CRhone"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -793,7 +788,6 @@ config SIBYTE_CRHONE
 config SIBYTE_RHONE
 	bool "Sibyte BCM91125E-Rhone"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1125H
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -804,7 +798,6 @@ config SIBYTE_SWARM
 	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
 	select HAVE_PATA_PLATFORM
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -817,7 +810,6 @@ config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
 	select BOOT_ELF32
 	select HAVE_PATA_PLATFORM
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -828,7 +820,6 @@ config SIBYTE_LITTLESUR
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -838,7 +829,6 @@ config SIBYTE_SENTOSA
 config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select NR_CPUS_DEFAULT_4
 	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
@@ -959,7 +949,6 @@ config NLM_XLR_BOARD
 	select SYS_HAS_CPU_XLR
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
-	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
@@ -986,7 +975,6 @@ config NLM_XLP_BOARD
 	select SYS_HAS_CPU_XLP
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select PHYS_ADDR_T_64BIT
@@ -1012,7 +1000,6 @@ config MIPS_PARAVIRT
 	bool "Para-Virtualized guest system"
 	select CEVT_R4K
 	select CSRC_R4K
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index eaf3d9054104..7c0d4f0ccaa0 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -20,7 +20,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #elif defined(CONFIG_MIPS_DMA_DEFAULT)
 	return &mips_default_dma_map_ops;
 #else
-	return NULL;
+	return &dma_direct_ops;
 #endif
 }
 
-- 
2.17.0
