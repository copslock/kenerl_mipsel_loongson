Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 07:17:47 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:33716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeDYFQejf4Dp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 07:16:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Eke3IueSaiW2xfDeThUZRbHWQXDzq+LsXuxJhmtLqDI=; b=stDcw9rbB4RWsTaZsmwQpUAAg
        MphQRz4J9vuZtPjJ9j5TDXKZQtxPD1jOLIA7/j9O/2aHpsmY4rNF8x1g9X8L2P1QIo/Fj02KdNudD
        ik1udCO/wQIAABgzFLAsdN1tJcf2kZMIiHX9CuVWqxrw72afWjt/1ajKxLI1OvTHu9bv2utvm0dI/
        +6fd3EQQw690wBopwxkMm6JWJzx6XPKs5OHfI4e0t1Iovm/CDlBqsdj3sJqnOTvbt73uT8y8gg0tJ
        2fzukT1PTcdjaSBYH93vfj8RN+pq2GT2C6K4OT3e9lJsGIB40SgRfTSrQpiXcTMNzkj6vtujIN3cx
        JrAftXnKA==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fBCmj-0005B6-9u; Wed, 25 Apr 2018 05:16:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/13] arch: remove the ARCH_PHYS_ADDR_T_64BIT config symbol
Date:   Wed, 25 Apr 2018 07:15:33 +0200
Message-Id: <20180425051539.1989-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63748
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

Instead select the PHYS_ADDR_T_64BIT for 32-bit architectures that need a
64-bit phys_addr_t type directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig                       |  4 +---
 arch/arm/kernel/setup.c                |  2 +-
 arch/arm/mm/Kconfig                    |  4 +---
 arch/arm64/Kconfig                     |  3 ---
 arch/mips/Kconfig                      | 15 ++++++---------
 arch/powerpc/Kconfig                   |  5 +----
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 arch/riscv/Kconfig                     |  6 ++----
 arch/x86/Kconfig                       |  5 +----
 mm/Kconfig                             |  2 +-
 10 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d76bf4a83740..f94c61da682a 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -453,13 +453,11 @@ config ARC_HAS_PAE40
 	default n
 	depends on ISA_ARCV2
 	select HIGHMEM
+	select PHYS_ADDR_T_64BIT
 	help
 	  Enable access to physical memory beyond 4G, only supported on
 	  ARC cores with 40 bit Physical Addressing support
 
-config ARCH_PHYS_ADDR_T_64BIT
-	def_bool ARC_HAS_PAE40
-
 config ARCH_DMA_ADDR_T_64BIT
 	bool
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fc40a2b40595..35ca494c028c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -754,7 +754,7 @@ int __init arm_add_memory(u64 start, u64 size)
 	else
 		size -= aligned_start - start;
 
-#ifndef CONFIG_ARCH_PHYS_ADDR_T_64BIT
+#ifndef CONFIG_PHYS_ADDR_T_64BIT
 	if (aligned_start > ULONG_MAX) {
 		pr_crit("Ignoring memory at 0x%08llx outside 32-bit physical address space\n",
 			(long long)start);
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7f14acf67caf..2f77c6344ef1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -661,6 +661,7 @@ config ARM_LPAE
 	bool "Support for the Large Physical Address Extension"
 	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
 		!CPU_32v4 && !CPU_32v3
+	select PHYS_ADDR_T_64BIT
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
@@ -673,9 +674,6 @@ config ARM_PV_FIXUP
 	def_bool y
 	depends on ARM_LPAE && ARM_PATCH_PHYS_VIRT && ARCH_KEYSTONE
 
-config ARCH_PHYS_ADDR_T_64BIT
-	def_bool ARM_LPAE
-
 config ARCH_DMA_ADDR_T_64BIT
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940adfb9a2bc..b6aa33e642cc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -152,9 +152,6 @@ config ARM64
 config 64BIT
 	def_bool y
 
-config ARCH_PHYS_ADDR_T_64BIT
-	def_bool y
-
 config MMU
 	def_bool y
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 47d72c64d687..985388078872 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -132,7 +132,7 @@ config MIPS_GENERIC
 
 config MIPS_ALCHEMY
 	bool "Alchemy processor based machines"
-	select ARCH_PHYS_ADDR_T_64BIT
+	select PHYS_ADDR_T_64BIT
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
@@ -890,7 +890,7 @@ config CAVIUM_OCTEON_SOC
 	bool "Cavium Networks Octeon SoC based boards"
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
-	select ARCH_PHYS_ADDR_T_64BIT
+	select PHYS_ADDR_T_64BIT
 	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -936,7 +936,7 @@ config NLM_XLR_BOARD
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
-	select ARCH_PHYS_ADDR_T_64BIT
+	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select DMA_COHERENT
@@ -962,7 +962,7 @@ config NLM_XLP_BOARD
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
-	select ARCH_PHYS_ADDR_T_64BIT
+	select PHYS_ADDR_T_64BIT
 	select GPIOLIB
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -1102,7 +1102,7 @@ config FW_CFE
 	bool
 
 config ARCH_DMA_ADDR_T_64BIT
-	def_bool (HIGHMEM && ARCH_PHYS_ADDR_T_64BIT) || 64BIT
+	def_bool (HIGHMEM && PHYS_ADDR_T_64BIT) || 64BIT
 
 config ARCH_SUPPORTS_UPROBES
 	bool
@@ -1767,7 +1767,7 @@ config CPU_MIPS32_R5_XPA
 	depends on SYS_SUPPORTS_HIGHMEM
 	select XPA
 	select HIGHMEM
-	select ARCH_PHYS_ADDR_T_64BIT
+	select PHYS_ADDR_T_64BIT
 	default n
 	help
 	  Choose this option if you want to enable the Extended Physical
@@ -2399,9 +2399,6 @@ config SB1_PASS_2_1_WORKAROUNDS
 	default y
 
 
-config ARCH_PHYS_ADDR_T_64BIT
-       bool
-
 choice
 	prompt "SmartMIPS or microMIPS ASE support"
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cc9a616d8934..b3d091d65e05 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -13,11 +13,8 @@ config 64BIT
 	bool
 	default y if PPC64
 
-config ARCH_PHYS_ADDR_T_64BIT
-       def_bool PPC64 || PHYS_64BIT
-
 config ARCH_DMA_ADDR_T_64BIT
-	def_bool ARCH_PHYS_ADDR_T_64BIT
+	def_bool PHYS_ADDR_T_64BIT
 
 config MMU
 	bool
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 67d3125d0610..84b58abc08ee 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -222,6 +222,7 @@ config PTE_64BIT
 config PHYS_64BIT
 	bool 'Large physical address support' if E500 || PPC_86xx
 	depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx
+	select PHYS_ADDR_T_64BIT
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
 	  addresses.  This feature may not be available on all cores.
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 23d8acca5c90..f52f86f43a4b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -5,6 +5,8 @@
 
 config RISCV
 	def_bool y
+	# even on 32-bit, physical (and DMA) addresses are > 32-bits
+	select PHYS_ADDR_T_64BIT
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
@@ -38,10 +40,6 @@ config RISCV
 config MMU
 	def_bool y
 
-# even on 32-bit, physical (and DMA) addresses are > 32-bits
-config ARCH_PHYS_ADDR_T_64BIT
-	def_bool y
-
 config ZONE_DMA32
 	bool
 	default y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a98a9b14fda2..8fccdaf02bb0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1448,6 +1448,7 @@ config HIGHMEM
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
 	depends on X86_32 && !HIGHMEM4G
+	select PHYS_ADDR_T_64BIT
 	select SWIOTLB
 	---help---
 	  PAE is required for NX support, and furthermore enables
@@ -1475,10 +1476,6 @@ config X86_5LEVEL
 
 	  Say N if unsure.
 
-config ARCH_PHYS_ADDR_T_64BIT
-	def_bool y
-	depends on X86_64 || X86_PAE
-
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool y
 	depends on X86_64 || HIGHMEM64G
diff --git a/mm/Kconfig b/mm/Kconfig
index d5004d82a1d6..a3f0005ac212 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -266,7 +266,7 @@ config ARCH_ENABLE_THP_MIGRATION
 	bool
 
 config PHYS_ADDR_T_64BIT
-	def_bool 64BIT || ARCH_PHYS_ADDR_T_64BIT
+	def_bool 64BIT
 
 config BOUNCE
 	bool "Enable bounce buffers"
-- 
2.17.0
