Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 07:19:10 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:34176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994686AbeDYFQs4IXJp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 07:16:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QYnFOUUtkI3ikpG3kg/iIm88uv9/vLdOSZkF4qdow94=; b=Kx71IITBgCk1iC+JXYowmkiH8
        vrWdbktVkJqMZxI7GB4FhP4+ux2cV3aooZXN/Y37V1yNL9fsVXBq/Rl0jqxu8aBhG/xMb5eLxitzL
        AT5wvdu/J2aCJeCz5oqsDfhm8PhnNmcrAl1HyeD7r0WbAhdaQb96by6RjTLydseeE7uJ7JA6I3wkd
        tSPmWxQA7UeKLd5BDLDZ3C4W/YauIt81WWAEdj9TnWqtyx3Y1T5Q5ImfCA5NaqUVxIdDUGLKcWE5Y
        84Kd85C5lte/AkPj3sbU2gpi+qfhGL/74HC7MjOxKK7hMCIyhvnD9W3mzyiSbahxBbwTwdpIAqaiD
        JEeb50oTg==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fBCn1-0005Kk-Gv; Wed, 25 Apr 2018 05:16:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/13] swiotlb: move the SWIOTLB config symbol to lib/Kconfig
Date:   Wed, 25 Apr 2018 07:15:38 +0200
Message-Id: <20180425051539.1989-13-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63754
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

This way we have one central definition of it, and user can select it as
needed.  The new option is not user visible, which is the behavior
it had in most architectures, with a few notable exceptions:

 - On x86_64 and mips/loongson3 it used to be user selectable, but
   defaulted to y.  It now is unconditional, which seems like the right
   thing for 64-bit architectures without guaranteed availablity of
   IOMMUs.
 - on powerpc the symbol is user selectable and defaults to n, but
   many boards select it.  This change assumes no working setup
   required a manual selection, but if that turned out to be wrong
   we'll have to add another select statement or two for the respective
   boards.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig                |  3 ---
 arch/arm64/Kconfig              |  4 +---
 arch/ia64/Kconfig               |  8 --------
 arch/mips/Kconfig               |  2 ++
 arch/mips/cavium-octeon/Kconfig |  4 ----
 arch/mips/loongson64/Kconfig    |  7 -------
 arch/powerpc/Kconfig            |  9 ---------
 arch/unicore32/Kconfig          |  1 +
 arch/unicore32/mm/Kconfig       |  4 ----
 arch/x86/Kconfig                | 12 +-----------
 lib/Kconfig                     |  5 +++++
 11 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90b81a3a28a7..676977bdfe33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1773,9 +1773,6 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
-config SWIOTLB
-	bool
-
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4d924eb32e7f..db51b6445744 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,7 @@ config ARM64
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
 	select SPARSE_IRQ
+	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	help
@@ -239,9 +240,6 @@ config HAVE_GENERIC_GUP
 config SMP
 	def_bool y
 
-config SWIOTLB
-	def_bool y
-
 config KERNEL_MODE_NEON
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 685d557eea48..9485b5490eca 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -80,9 +80,6 @@ config MMU
 	bool
 	default y
 
-config SWIOTLB
-       bool
-
 config STACKTRACE_SUPPORT
 	def_bool y
 
@@ -139,7 +136,6 @@ config IA64_GENERIC
 	bool "generic"
 	select NUMA
 	select ACPI_NUMA
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	select PCI_MSI
 	help
@@ -160,7 +156,6 @@ config IA64_GENERIC
 
 config IA64_DIG
 	bool "DIG-compliant"
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 
 config IA64_DIG_VTD
@@ -176,7 +171,6 @@ config IA64_HP_ZX1
 
 config IA64_HP_ZX1_SWIOTLB
 	bool "HP-zx1/sx1000 with software I/O TLB"
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Build a kernel that runs on HP zx1 and sx1000 systems even when they
@@ -200,7 +194,6 @@ config IA64_SGI_UV
 	bool "SGI-UV"
 	select NUMA
 	select ACPI_NUMA
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Selecting this option will optimize the kernel for use on UV based
@@ -211,7 +204,6 @@ config IA64_SGI_UV
 
 config IA64_HP_SIM
 	bool "Ski-simulator"
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	depends on !PM
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e10cc5c7be69..0f619b8c0e9e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -912,6 +912,7 @@ config CAVIUM_OCTEON_SOC
 	select MIPS_NR_CPU_NR_MAP_1024
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
+	select SWIOTLB
 	select SYS_SUPPORTS_RELOCATABLE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
@@ -1367,6 +1368,7 @@ config CPU_LOONGSON3
 	select MIPS_PGD_C0_CONTEXT
 	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
+	select SWIOTLB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index eb5faeed4f66..4984e462be30 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -67,10 +67,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config SWIOTLB
-	def_bool y
-	select DMA_DIRECT_OPS
-
 config OCTEON_ILM
 	tristate "Module to measure interrupt latency using Octeon CIU Timer"
 	help
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 2a4fb91adbb6..c79e6a565572 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -130,13 +130,6 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
-config SWIOTLB
-	bool "Soft IOMMU Support for All-Memory DMA"
-	default y
-	depends on CPU_LOONGSON3
-	select DMA_DIRECT_OPS
-	select NEED_DMA_MAP_STATE
-
 config PHYS48_TO_HT40
 	bool
 	default y if CPU_LOONGSON3
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a4b2ac7c3d2e..1887f8f86a77 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -474,15 +474,6 @@ config MPROFILE_KERNEL
 	depends on PPC64 && CPU_LITTLE_ENDIAN
 	def_bool !DISABLE_MPROFILE_KERNEL
 
-config SWIOTLB
-	bool "SWIOTLB support"
-	default n
-	---help---
-	  Support for IO bounce buffering for systems without an IOMMU.
-	  This allows us to DMA to the full physical address space on
-	  platforms where the size of a physical address is larger
-	  than the bus address.  Not all platforms support this.
-
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && (PPC_PSERIES || \
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 82195714d20b..03f991e44288 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -20,6 +20,7 @@ config UNICORE32
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
+	select SWIOTLB
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index 45b7f769375e..82759b6aba67 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -39,7 +39,3 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 	default y
 	help
 	  Say Y here to disable the TLB single entry operations.
-
-config SWIOTLB
-	def_bool y
-	select DMA_DIRECT_OPS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 07b031f99eb1..aad35c568681 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -29,6 +29,7 @@ config X86_64
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
+	select SWIOTLB
 	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
 
@@ -916,17 +917,6 @@ config CALGARY_IOMMU_ENABLED_BY_DEFAULT
 	  Calgary anyway, pass 'iommu=calgary' on the kernel command line.
 	  If unsure, say Y.
 
-# need this always selected by IOMMU for the VIA workaround
-config SWIOTLB
-	def_bool y if X86_64
-	select NEED_DMA_MAP_STATE
-	---help---
-	  Support for software bounce buffers used on x86-64 systems
-	  which don't have a hardware IOMMU. Using this PCI devices
-	  which can only access 32-bits of memory can be used on systems
-	  with more than 3 GB of memory.
-	  If unsure, say Y.
-
 config MAXSMP
 	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
 	depends on X86_64 && SMP && DEBUG_KERNEL
diff --git a/lib/Kconfig b/lib/Kconfig
index 1f12faf03819..1d84e61cccfe 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -451,6 +451,11 @@ config DMA_VIRT_OPS
 	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
 	default n
 
+config SWIOTLB
+	bool
+	select DMA_DIRECT_OPS
+	select NEED_DMA_MAP_STATE
+
 config CHECK_SIGNATURE
 	bool
 
-- 
2.17.0
