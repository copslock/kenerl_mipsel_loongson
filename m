Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 19:05:54 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993488AbeDWRFDucJKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 19:05:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FBhwNml0cm9eEWYfWBaE3JHEcGMV0EDCn8zLTOEvfUc=; b=ib54EGCpyoJcvMTsOerpO6xoF
        e8ZvoCQt6QnJDKttx0MVLXDWssVCWrTR9HSYy3hLHPVd+6k+xjlC0tVM6Oi/X3X6Y6Ahe9Bs5PQrg
        GjoqWLmrNJ5HeYxuHQqwCin3RwA2NHEQpn75hxmjiSMpPY9iI7gq3qv0IaY0Yq6cb4/XRoosoOK5R
        1T85TZoRVZPbgg1BXgv3w7EYHFdXB0DvlVosXZkBum9jrauymTk4/eA8k3nBedMk4Hc7xQlaH27aK
        9K9NotP2MPV2WZq8hifapDkJ8i4Fzt1lUWDpoBcRIdFyR6qGar9oXliZyBCFvxrrIyQhBwPZPOe94
        g9ba2lbVQ==;
Received: from 089144198044.atnat0007.highway.a1.net ([89.144.198.44] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAetK-00006y-Pi; Mon, 23 Apr 2018 17:04:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/12] scatterlist: move the NEED_SG_DMA_LENGTH config symbol to lib/Kconfig
Date:   Mon, 23 Apr 2018 19:04:12 +0200
Message-Id: <20180423170419.20330-6-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423170419.20330-1-hch@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+de39c3f36ce265885e0e+5356+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63706
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
needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/alpha/Kconfig              | 4 +---
 arch/arm/Kconfig                | 3 ---
 arch/arm64/Kconfig              | 4 +---
 arch/hexagon/Kconfig            | 4 +---
 arch/ia64/Kconfig               | 4 +---
 arch/mips/cavium-octeon/Kconfig | 3 ---
 arch/mips/loongson64/Kconfig    | 3 ---
 arch/mips/netlogic/Kconfig      | 3 ---
 arch/parisc/Kconfig             | 4 +---
 arch/powerpc/Kconfig            | 4 +---
 arch/s390/Kconfig               | 4 +---
 arch/sh/Kconfig                 | 5 ++---
 arch/sparc/Kconfig              | 4 +---
 arch/unicore32/mm/Kconfig       | 5 +----
 arch/x86/Kconfig                | 4 +---
 lib/Kconfig                     | 3 +++
 16 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 3ff735a722af..8e6a67ecf069 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -10,6 +10,7 @@ config ALPHA
 	select HAVE_OPROFILE
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
+	select NEED_SG_DMA_LENGTH
 	select VIRT_TO_BUS
 	select GENERIC_IRQ_PROBE
 	select AUTO_IRQ_AFFINITY if SMP
@@ -70,9 +71,6 @@ config ARCH_DMA_ADDR_T_64BIT
 config NEED_DMA_MAP_STATE
        def_bool y
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config GENERIC_ISA_DMA
 	bool
 	default y
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f79222c5c02..602c8320282f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -119,9 +119,6 @@ config ARM_HAS_SG_CHAIN
 	select ARCH_HAS_SG_CHAIN
 	bool
 
-config NEED_SG_DMA_LENGTH
-	bool
-
 config ARM_DMA_USE_IOMMU
 	bool
 	select ARM_HAS_SG_CHAIN
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fbef5d3de83f..3b441c5587f1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -133,6 +133,7 @@ config ARM64
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
 	select MULTI_IRQ_HANDLER
+	select NEED_SG_DMA_LENGTH
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
@@ -243,9 +244,6 @@ config ARCH_DMA_ADDR_T_64BIT
 config NEED_DMA_MAP_STATE
 	def_bool y
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config SMP
 	def_bool y
 
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 76d2f20d525e..37adb2003033 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -19,6 +19,7 @@ config HEXAGON
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
+	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD
@@ -63,9 +64,6 @@ config GENERIC_CSUM
 config GENERIC_IRQ_PROBE
 	def_bool y
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool n
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 862c5160c09d..333917676f7f 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -54,6 +54,7 @@ config IA64
 	select MODULES_USE_ELF_RELA
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_AUDITSYSCALL
+	select NEED_SG_DMA_LENGTH
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
@@ -84,9 +85,6 @@ config ARCH_DMA_ADDR_T_64BIT
 config NEED_DMA_MAP_STATE
 	def_bool y
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config SWIOTLB
        bool
 
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 647ed158ac98..5d73041547a7 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -67,9 +67,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config NEED_SG_DMA_LENGTH
-	bool
-
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 5efb2e63878e..641a1477031e 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -130,9 +130,6 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
-config NEED_SG_DMA_LENGTH
-	bool
-
 config SWIOTLB
 	bool "Soft IOMMU Support for All-Memory DMA"
 	default y
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 5c5ee0e05a17..412351c5acc6 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -83,7 +83,4 @@ endif
 config NLM_COMMON
 	bool
 
-config NEED_SG_DMA_LENGTH
-	bool
-
 endif
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fc5a574c3482..89caea87556e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -51,6 +51,7 @@ config PARISC
 	select GENERIC_CLOCKEVENTS
 	select ARCH_NO_COHERENT_DMA_MMAP
 	select CPU_NO_EFFICIENT_FFS
+	select NEED_SG_DMA_LENGTH
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
@@ -114,9 +115,6 @@ config STACKTRACE_SUPPORT
 config NEED_DMA_MAP_STATE
 	def_bool y
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config ISA_DMA_API
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7698cf89af9c..cc9a616d8934 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -227,6 +227,7 @@ config PPC
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
+	select NEED_SG_DMA_LENGTH
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
@@ -910,9 +911,6 @@ config ZONE_DMA
 config NEED_DMA_MAP_STATE
 	def_bool (PPC64 || NOT_COHERENT_CACHE)
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config GENERIC_ISA_DMA
 	bool
 	depends on ISA_DMA_API
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 60c4ab854182..f80c6b983159 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -711,6 +711,7 @@ menuconfig PCI
 	select PCI_MSI
 	select IOMMU_HELPER
 	select IOMMU_SUPPORT
+	select NEED_SG_DMA_LENGTH
 
 	help
 	  Enable PCI support.
@@ -735,9 +736,6 @@ config PCI_DOMAINS
 config HAS_IOMEM
 	def_bool PCI
 
-config NEED_SG_DMA_LENGTH
-	def_bool PCI
-
 config NEED_DMA_MAP_STATE
 	def_bool PCI
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..e127e0cbe30f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,6 +50,8 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select NEED_SG_DMA_LENGTH
+
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
@@ -163,9 +165,6 @@ config DMA_NONCOHERENT
 config NEED_DMA_MAP_STATE
 	def_bool DMA_NONCOHERENT
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config PGTABLE_LEVELS
 	default 3 if X2TLB
 	default 2
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 44e0f3cd7988..e79badc8a682 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -44,6 +44,7 @@ config SPARC
 	select ARCH_HAS_SG_CHAIN
 	select CPU_NO_EFFICIENT_FFS
 	select LOCKDEP_SMALL if LOCKDEP
+	select NEED_SG_DMA_LENGTH
 
 config SPARC32
 	def_bool !64BIT
@@ -146,9 +147,6 @@ config ZONE_DMA
 config NEED_DMA_MAP_STATE
 	def_bool y
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config GENERIC_ISA_DMA
 	bool
 	default y if SPARC32
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index 3f105e00c432..1d9fed0ada71 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -43,7 +43,4 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
-
-config NEED_SG_DMA_LENGTH
-	def_bool SWIOTLB
-
+	select NEED_SG_DMA_LENGTH
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fe9713539166..ead3babe4e79 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -183,6 +183,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select IRQ_FORCED_THREADING
+	select NEED_SG_DMA_LENGTH
 	select PCI_LOCKLESS_CONFIG
 	select PERF_EVENTS
 	select RTC_LIB
@@ -239,9 +240,6 @@ config NEED_DMA_MAP_STATE
 	def_bool y
 	depends on X86_64 || INTEL_IOMMU || DMA_API_DEBUG || SWIOTLB
 
-config NEED_SG_DMA_LENGTH
-	def_bool y
-
 config GENERIC_ISA_DMA
 	def_bool y
 	depends on ISA_DMA_API
diff --git a/lib/Kconfig b/lib/Kconfig
index 2f6908577534..aeb7fae16bc2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -429,6 +429,9 @@ config SGL_ALLOC
 	bool
 	default n
 
+config NEED_SG_DMA_LENGTH
+	bool
+
 config IOMMU_HELPER
 	bool
 
-- 
2.17.0
