Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:22:10 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeEYJVZBK0FA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bWXvPqE6H11XzpGaJnib6HtOow/mVqra8Ke59B6Nx/I=; b=PRstjgGSfTUdHtua6cb1Z1VhC
        +oFXs9koJhJQ1YknYnutkRD2O0RdRT4E/frdkTpB8in9ieue3wZmS7EWAkh7ELYcRTYYelgK4GHVq
        bT/mdE2ini4Qb6ycWyMI7uf9l6QleMvI7aIsDXEWbdQK5QKnTauNIxRa1qGVPt0HYzFU5hgxtvjQ9
        IKgtKxfU77eO5bs5XRtkPTGDYH308VEWvx69V5kf9mLy50aHggAUHdtTpE7GDeh6x7EJs/pc+C9Ps
        PL7QkUcJNJ243OtquB7k8dtQbw+IxCpwNcNTOZhcmcMWRIe/aNRyCBjsD34iEmYdMQpEjIakED1oC
        B7O92JkwQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8uZ-0001dQ-H9; Fri, 25 May 2018 09:21:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 03/25] MIPS: remove CONFIG_DMA_COHERENT
Date:   Fri, 25 May 2018 11:20:49 +0200
Message-Id: <20180525092111.18516-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64016
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

We can just check for !CONFIG_DMA_NONCOHERENT instead and simplify things
a lot.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                            | 16 ----------------
 arch/mips/include/asm/dma-coherence.h        |  6 +++---
 arch/mips/include/asm/mach-generic/kmalloc.h |  3 +--
 arch/mips/mti-malta/malta-setup.c            |  4 ++--
 arch/mips/sibyte/Kconfig                     |  1 -
 5 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2dcdc13cd65d..43bb037301f6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -660,7 +660,6 @@ config SGI_IP27
 	select FW_ARC64
 	select BOOT_ELF64
 	select DEFAULT_SGI_PARTITION
-	select DMA_COHERENT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select NR_CPUS_DEFAULT_64
@@ -737,7 +736,6 @@ config SGI_IP32
 config SIBYTE_CRHINE
 	bool "Sibyte BCM91120C-CRhine"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -747,7 +745,6 @@ config SIBYTE_CRHINE
 config SIBYTE_CARMEL
 	bool "Sibyte BCM91120x-Carmel"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -757,7 +754,6 @@ config SIBYTE_CARMEL
 config SIBYTE_CRHONE
 	bool "Sibyte BCM91125C-CRhone"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -768,7 +764,6 @@ config SIBYTE_CRHONE
 config SIBYTE_RHONE
 	bool "Sibyte BCM91125E-Rhone"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1125H
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -778,7 +773,6 @@ config SIBYTE_RHONE
 config SIBYTE_SWARM
 	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -791,7 +785,6 @@ config SIBYTE_SWARM
 config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -803,7 +796,6 @@ config SIBYTE_LITTLESUR
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -813,7 +805,6 @@ config SIBYTE_SENTOSA
 config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select NR_CPUS_DEFAULT_4
 	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
@@ -890,7 +881,6 @@ config CAVIUM_OCTEON_SOC
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
 	select PHYS_ADDR_T_64BIT
-	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select EDAC_SUPPORT
@@ -939,7 +929,6 @@ config NLM_XLR_BOARD
 	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
-	select DMA_COHERENT
 	select NR_CPUS_DEFAULT_32
 	select CEVT_R4K
 	select CSRC_R4K
@@ -967,7 +956,6 @@ config NLM_XLP_BOARD
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
-	select DMA_COHERENT
 	select NR_CPUS_DEFAULT_32
 	select CEVT_R4K
 	select CSRC_R4K
@@ -986,7 +974,6 @@ config MIPS_PARAVIRT
 	bool "Para-Virtualized guest system"
 	select CEVT_R4K
 	select CSRC_R4K
-	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -1112,9 +1099,6 @@ config DMA_PERDEV_COHERENT
 	bool
 	select DMA_MAYBE_COHERENT
 
-config DMA_COHERENT
-	bool
-
 config DMA_NONCOHERENT
 	bool
 	select NEED_DMA_MAP_STATE
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index 72d0eab02afc..8eda48748ed5 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -21,10 +21,10 @@ enum coherent_io_user_state {
 extern enum coherent_io_user_state coherentio;
 extern int hw_coherentio;
 #else
-#ifdef CONFIG_DMA_COHERENT
-#define coherentio	IO_COHERENCE_ENABLED
-#else
+#ifdef CONFIG_DMA_NONCOHERENT
 #define coherentio	IO_COHERENCE_DISABLED
+#else
+#define coherentio	IO_COHERENCE_ENABLED
 #endif
 #define hw_coherentio	0
 #endif /* CONFIG_DMA_MAYBE_COHERENT */
diff --git a/arch/mips/include/asm/mach-generic/kmalloc.h b/arch/mips/include/asm/mach-generic/kmalloc.h
index 74207c7bd00d..649a98338886 100644
--- a/arch/mips/include/asm/mach-generic/kmalloc.h
+++ b/arch/mips/include/asm/mach-generic/kmalloc.h
@@ -2,8 +2,7 @@
 #ifndef __ASM_MACH_GENERIC_KMALLOC_H
 #define __ASM_MACH_GENERIC_KMALLOC_H
 
-
-#ifndef CONFIG_DMA_COHERENT
+#ifdef CONFIG_DMA_NONCOHERENT
 /*
  * Total overkill for most systems but need as a safe default.
  * Set this one if any device in the system might do non-coherent DMA.
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 7b63914d2e58..4d5cdfeee3db 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -227,7 +227,7 @@ static void __init bonito_quirks_setup(void)
 	} else
 		BONITO_BONGENCFG &= ~BONITO_BONGENCFG_DEBUGMODE;
 
-#ifdef CONFIG_DMA_COHERENT
+#ifndef CONFIG_DMA_NONCOHERENT
 	if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
 		BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
 		pr_info("Enabled Bonito CPU coherency\n");
@@ -279,7 +279,7 @@ void __init plat_mem_setup(void)
 	 */
 	enable_dma(4);
 
-#ifdef CONFIG_DMA_COHERENT
+#ifndef CONFIG_DMA_NONCOHERENT
 	if (mips_revision_sconid != MIPS_REVISION_SCON_BONITO)
 		panic("Hardware DMA cache coherency not supported");
 #endif
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index f4dbce25bc6a..7ec278d72096 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -70,7 +70,6 @@ config SIBYTE_BCM1x55
 
 config SIBYTE_SB1xxx_SOC
 	bool
-	select DMA_COHERENT
 	select IRQ_MIPS_CPU
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
-- 
2.17.0
