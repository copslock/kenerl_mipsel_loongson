Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 19:07:30 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993599AbeDWRFeOY18e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 19:05:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EPF7joiKf3SVVhsgMWBpgtKahxB5LZl+XciwaAqF3Hw=; b=kw6ABw2m0Sa5UMj/4z3Che1fq
        iplvABFghNJAedeyXiIuf7kv5ax+N7vxj6+kmcVXNk+yy+UpvBiEF0BeVhX3WjRS965p2wWcbij8z
        sjRBrwewc1oNonFp3sNMjlOeQn8u1FiCPhkN1E6XD9+oy1NQaFFtbm3/JSMm/DliA8hX0Syk7Hq0V
        wMC5lUyj4em96bx6RSTOVOzzU5gGmo8oshEye+Ittxb+agbMQqjTdJbQLuRRbU5ejIOlwrYJrgMYI
        82f//IeRRGc/4whj5sjl+TzvgtgHjFeaAYtXzFROStHYl2kNmQiYFHbhfRiGWy/nece/DAXhykQ7S
        lbXS7EEaw==;
Received: from 089144198044.atnat0007.highway.a1.net ([89.144.198.44] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAete-0000IB-To; Mon, 23 Apr 2018 17:04:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to lib/Kconfig
Date:   Mon, 23 Apr 2018 19:04:18 +0200
Message-Id: <20180423170419.20330-12-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423170419.20330-1-hch@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+de39c3f36ce265885e0e+5356+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63712
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
needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
indicate the architecture supports swiotlb at all, so that we can still
make the usage optional for a few architectures that want this feature
to be user selectable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig                |  4 +---
 arch/arm64/Kconfig              |  5 ++---
 arch/ia64/Kconfig               |  9 +--------
 arch/mips/Kconfig               |  3 +++
 arch/mips/cavium-octeon/Kconfig |  5 -----
 arch/mips/loongson64/Kconfig    |  8 --------
 arch/powerpc/Kconfig            |  9 ---------
 arch/unicore32/mm/Kconfig       |  5 -----
 arch/x86/Kconfig                | 14 +++-----------
 lib/Kconfig                     | 15 +++++++++++++++
 10 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90b81a3a28a7..f91f69174630 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -106,6 +106,7 @@ config ARM
 	select REFCOUNT_FULL
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select ARCH_HAS_SWIOTLB
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
@@ -1773,9 +1774,6 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
-config SWIOTLB
-	bool
-
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4d924eb32e7f..056bc7365adf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -21,6 +21,7 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SWIOTLB
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
@@ -144,6 +145,7 @@ config ARM64
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
 	select SPARSE_IRQ
+	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	help
@@ -239,9 +241,6 @@ config HAVE_GENERIC_GUP
 config SMP
 	def_bool y
 
-config SWIOTLB
-	def_bool y
-
 config KERNEL_MODE_NEON
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 685d557eea48..d396230913e6 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -56,6 +56,7 @@ config IA64
 	select HAVE_ARCH_AUDITSYSCALL
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
+	select ARCH_HAS_SWIOTLB
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
@@ -80,9 +81,6 @@ config MMU
 	bool
 	default y
 
-config SWIOTLB
-       bool
-
 config STACKTRACE_SUPPORT
 	def_bool y
 
@@ -139,7 +137,6 @@ config IA64_GENERIC
 	bool "generic"
 	select NUMA
 	select ACPI_NUMA
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	select PCI_MSI
 	help
@@ -160,7 +157,6 @@ config IA64_GENERIC
 
 config IA64_DIG
 	bool "DIG-compliant"
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 
 config IA64_DIG_VTD
@@ -176,7 +172,6 @@ config IA64_HP_ZX1
 
 config IA64_HP_ZX1_SWIOTLB
 	bool "HP-zx1/sx1000 with software I/O TLB"
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Build a kernel that runs on HP zx1 and sx1000 systems even when they
@@ -200,7 +195,6 @@ config IA64_SGI_UV
 	bool "SGI-UV"
 	select NUMA
 	select ACPI_NUMA
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	help
 	  Selecting this option will optimize the kernel for use on UV based
@@ -211,7 +205,6 @@ config IA64_SGI_UV
 
 config IA64_HP_SIM
 	bool "Ski-simulator"
-	select DMA_DIRECT_OPS
 	select SWIOTLB
 	depends on !PM
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e10cc5c7be69..b6b4c1e154f8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -912,6 +912,8 @@ config CAVIUM_OCTEON_SOC
 	select MIPS_NR_CPU_NR_MAP_1024
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
+	select ARCH_HAS_SWIOTLB
+	select SWIOTLB
 	select SYS_SUPPORTS_RELOCATABLE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
@@ -1367,6 +1369,7 @@ config CPU_LOONGSON3
 	select MIPS_PGD_C0_CONTEXT
 	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
+	select ARCH_HAS_SWIOTLB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 5d73041547a7..4984e462be30 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -67,11 +67,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config SWIOTLB
-	def_bool y
-	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
-
 config OCTEON_ILM
 	tristate "Module to measure interrupt latency using Octeon CIU Timer"
 	help
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 641a1477031e..c79e6a565572 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -130,14 +130,6 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
-config SWIOTLB
-	bool "Soft IOMMU Support for All-Memory DMA"
-	default y
-	depends on CPU_LOONGSON3
-	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
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
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index 1d9fed0ada71..82759b6aba67 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -39,8 +39,3 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 	default y
 	help
 	  Say Y here to disable the TLB single entry operations.
-
-config SWIOTLB
-	def_bool y
-	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 07b031f99eb1..7a5fec800992 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -24,6 +24,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select ARCH_HAS_SWIOTLB
 	select ARCH_SUPPORTS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
@@ -677,6 +678,7 @@ config STA2X11
 	bool "STA2X11 Companion Chip Support"
 	depends on X86_32_NON_STANDARD && PCI
 	select ARCH_HAS_PHYS_TO_DMA
+	select ARCH_HAS_SWIOTLB
 	select X86_DEV_DMA_OPS
 	select X86_DMA_REMAP
 	select SWIOTLB
@@ -916,17 +918,6 @@ config CALGARY_IOMMU_ENABLED_BY_DEFAULT
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
@@ -1448,6 +1439,7 @@ config HIGHMEM
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
 	depends on X86_32 && !HIGHMEM4G
+	select ARCH_HAS_SWIOTLB
 	select PHYS_ADDR_T_64BIT
 	select SWIOTLB
 	---help---
diff --git a/lib/Kconfig b/lib/Kconfig
index 1f12faf03819..01a37920949c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -451,6 +451,21 @@ config DMA_VIRT_OPS
 	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
 	default n
 
+config ARCH_HAS_SWIOTLB
+	bool
+
+config SWIOTLB
+	bool "SWIOTLB support"
+	default ARCH_HAS_SWIOTLB
+	select DMA_DIRECT_OPS
+	select NEED_DMA_MAP_STATE
+	select NEED_SG_DMA_LENGTH
+	---help---
+	  Support for IO bounce buffering for systems without an IOMMU.
+	  This allows us to DMA to the full physical address space on
+	  platforms where the size of a physical address is larger
+	  than the bus address.  If unsure, say Y.
+
 config CHECK_SIGNATURE
 	bool
 
-- 
2.17.0
