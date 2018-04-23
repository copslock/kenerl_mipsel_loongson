Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 19:06:38 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993588AbeDWRFVlQzXe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 19:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7bwMd6XxxNxvB79znb0iT2xyqPaVLSy/ffgHqULgFl4=; b=SsM1GG5WSEsTBMMkYkGdf5xF8
        Hp9bgcVCbwMFKwesbOUxWr50y6HaTYB4e7uGhi9A3kRQKrb0KNJvucbZbkoL8Xs6tCb7j9v+5I2OG
        rT6e+e+FR0Cj2bFBBOsWL7OPgZ+FRHT8IcTjC5xflHQwKJ2R6QvsjTHORAq8xpsN2m85rqZ8F6pDu
        Em1f5HXmD39/hVbNbNXYVFROvhoPwE3F0qYY4Cqgu5U72G9AhETlCNqc6KnmarTHbwuK6880mHt6a
        80okzyP0P9jCwwllEjkxsUdzAk3H0JNm34hc2E6M6sBoD0et5thD6J+CerpuzYWqv/ZjH/NOktYQR
        Sw4zOZFQg==;
Received: from 089144198044.atnat0007.highway.a1.net ([89.144.198.44] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAetU-0000Bm-Uy; Mon, 23 Apr 2018 17:04:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/12] arch: define the ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig
Date:   Mon, 23 Apr 2018 19:04:15 +0200
Message-Id: <20180423170419.20330-9-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423170419.20330-1-hch@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+de39c3f36ce265885e0e+5356+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63709
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

Define this symbol if the architecture either uses 64-bit pointers or the
PHYS_ADDR_T_64BIT is set.  This covers 95% of the old arch magic.  We only
need an additional select for Xen on ARM (why anyway?), and we now always
set ARCH_DMA_ADDR_T_64BIT on mips boards with 64-bit physical addressing
instead of only doing it when highmem is set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig             | 3 ---
 arch/arc/Kconfig               | 3 ---
 arch/arm/mach-axxia/Kconfig    | 1 -
 arch/arm/mach-bcm/Kconfig      | 1 -
 arch/arm/mach-exynos/Kconfig   | 1 -
 arch/arm/mach-highbank/Kconfig | 1 -
 arch/arm/mach-rockchip/Kconfig | 1 -
 arch/arm/mach-shmobile/Kconfig | 1 -
 arch/arm/mach-tegra/Kconfig    | 1 -
 arch/arm/mm/Kconfig            | 3 ---
 arch/arm64/Kconfig             | 3 ---
 arch/ia64/Kconfig              | 3 ---
 arch/mips/Kconfig              | 3 ---
 arch/powerpc/Kconfig           | 3 ---
 arch/riscv/Kconfig             | 3 ---
 arch/s390/Kconfig              | 3 ---
 arch/sparc/Kconfig             | 4 ----
 arch/x86/Kconfig               | 4 ----
 lib/Kconfig                    | 3 +++
 19 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 1fd9645b0c67..aa7df1a36fd0 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -66,9 +66,6 @@ config ZONE_DMA
 	bool
 	default y
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool y
-
 config GENERIC_ISA_DMA
 	bool
 	default y
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index f94c61da682a..7498aca4b887 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -458,9 +458,6 @@ config ARC_HAS_PAE40
 	  Enable access to physical memory beyond 4G, only supported on
 	  ARC cores with 40 bit Physical Addressing support
 
-config ARCH_DMA_ADDR_T_64BIT
-	bool
-
 config ARC_KVADDR_SIZE
 	int "Kernel Virtual Address Space size (MB)"
 	range 0 512
diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
index bb2ce1c63fd9..d3eae6037913 100644
--- a/arch/arm/mach-axxia/Kconfig
+++ b/arch/arm/mach-axxia/Kconfig
@@ -2,7 +2,6 @@
 config ARCH_AXXIA
 	bool "LSI Axxia platforms"
 	depends on ARCH_MULTI_V7 && ARM_LPAE
-	select ARCH_DMA_ADDR_T_64BIT
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index c2f3b0d216a4..c46a728df44e 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -211,7 +211,6 @@ config ARCH_BRCMSTB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
 	select SOC_BUS
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 647c319f9f5f..2ca405816846 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -112,7 +112,6 @@ config SOC_EXYNOS5440
 	bool "SAMSUNG EXYNOS5440"
 	default y
 	depends on ARCH_EXYNOS5
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
 	select PINCTRL_EXYNOS5440
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 81110ec34226..5552968f07f8 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -1,7 +1,6 @@
 config ARCH_HIGHBANK
 	bool "Calxeda ECX-1000/2000 (Highbank/Midway)"
 	depends on ARCH_MULTI_V7
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a4065966881a..fafd3d7f9f8c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -3,7 +3,6 @@ config ARCH_ROCKCHIP
 	depends on ARCH_MULTI_V7
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_AMBA
 	select ARM_GIC
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 280e7312a9e1..fe60cd09a5ca 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -29,7 +29,6 @@ config ARCH_RMOBILE
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_SHMOBILE
 	select ARM_GIC
 	select GPIOLIB
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 1e0aeb47bac6..7f3b83e0d324 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -15,6 +15,5 @@ menuconfig ARCH_TEGRA
 	select RESET_CONTROLLER
 	select SOC_BUS
 	select ZONE_DMA if ARM_LPAE
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	help
 	  This enables support for NVIDIA Tegra based systems.
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2f77c6344ef1..5a016bc80e26 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -674,9 +674,6 @@ config ARM_PV_FIXUP
 	def_bool y
 	depends on ARM_LPAE && ARM_PATCH_PHYS_VIRT && ARCH_KEYSTONE
 
-config ARCH_DMA_ADDR_T_64BIT
-	bool
-
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY && EXPERT
 	depends on CPU_THUMB_CAPABLE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b6aa33e642cc..4d924eb32e7f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -236,9 +236,6 @@ config ZONE_DMA32
 config HAVE_GENERIC_GUP
 	def_bool y
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool y
-
 config SMP
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0e42731adaf1..685d557eea48 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -80,9 +80,6 @@ config MMU
 	bool
 	default y
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool y
-
 config SWIOTLB
        bool
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 985388078872..e10cc5c7be69 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1101,9 +1101,6 @@ config GPIO_TXX9
 config FW_CFE
 	bool
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool (HIGHMEM && PHYS_ADDR_T_64BIT) || 64BIT
-
 config ARCH_SUPPORTS_UPROBES
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b3d091d65e05..a4b2ac7c3d2e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -13,9 +13,6 @@ config 64BIT
 	bool
 	default y if PPC64
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool PHYS_ADDR_T_64BIT
-
 config MMU
 	bool
 	default y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f52f86f43a4b..17212ba54ee3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -44,9 +44,6 @@ config ZONE_DMA32
 	bool
 	default y
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool y
-
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 89a007672f70..b794a2ab6d15 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -35,9 +35,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool y
-
 config GENERIC_LOCKBREAK
 	def_bool y if SMP && PREEMPT
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index be770b511ddd..c1cfc17eb504 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -105,10 +105,6 @@ config ARCH_ATU
 	bool
 	default y if SPARC64
 
-config ARCH_DMA_ADDR_T_64BIT
-	bool
-	default y if ARCH_ATU
-
 config STACKTRACE_SUPPORT
 	bool
 	default y if SPARC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8fccdaf02bb0..07b031f99eb1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1476,10 +1476,6 @@ config X86_5LEVEL
 
 	  Say N if unsure.
 
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool y
-	depends on X86_64 || HIGHMEM64G
-
 config X86_DIRECT_GBPAGES
 	def_bool y
 	depends on X86_64 && !DEBUG_PAGEALLOC
diff --git a/lib/Kconfig b/lib/Kconfig
index ce9fa962d59b..1f12faf03819 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -435,6 +435,9 @@ config NEED_SG_DMA_LENGTH
 config NEED_DMA_MAP_STATE
 	bool
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool 64BIT || PHYS_ADDR_T_64BIT
+
 config IOMMU_HELPER
 	bool
 
-- 
2.17.0
