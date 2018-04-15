Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:00:43 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:40354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeDOPAQy3A3u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 17:00:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9U+/DiDM9JYoJOZecUE/frkWJlv0cLOmxSgvmMo9mgk=; b=kqoAS5o7xf4d57x0zLE8stF5H
        9o9+8Klp2U4D6l/Hhu300FDfnkDfTvHaV73Fi0PE0+zTX9Qnp/PUw2N37E6WEc7kLf128vgtwkO3v
        5Ljimc7VbzEGseqpKBNGIB8wO+h+Kcmb9uEufrGKokktyDwGmY7sJmoZhlL/hpz+0dUEnfpblZcsR
        4QyeI690WaUBO28x9KpQxe5MNQqisnIfvF9+ezqNg2OTCjxRmF9zmzNyp8PAXa5IfteiHtHC87URG
        XkAh1pNYCqC+2OcUQbMGGlY4KXXfah3XwkqdlnniAEobEIbB0nBOqqDO6Fv0DhV/uDqTNh/9Vw+9k
        wE2UF4Unw==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j8J-0005dS-C8; Sun, 15 Apr 2018 14:59:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/12] iommu-helper: mark iommu_is_span_boundary as inline
Date:   Sun, 15 Apr 2018 16:59:38 +0200
Message-Id: <20180415145947.1248-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63539
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

This avoids selecting IOMMU_HELPER just for this function.  And we only
use it once or twice in normal builds so this often even is a size
reduction.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig              |  3 ---
 arch/arm/Kconfig                |  3 ---
 arch/arm64/Kconfig              |  3 ---
 arch/ia64/Kconfig               |  3 ---
 arch/mips/cavium-octeon/Kconfig |  4 ----
 arch/mips/loongson64/Kconfig    |  4 ----
 arch/mips/netlogic/Kconfig      |  3 ---
 arch/powerpc/Kconfig            |  1 -
 arch/unicore32/mm/Kconfig       |  3 ---
 arch/x86/Kconfig                |  2 +-
 drivers/parisc/Kconfig          |  5 -----
 include/linux/iommu-helper.h    | 13 ++++++++++---
 lib/iommu-helper.c              | 12 +-----------
 13 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2022885ced8..3ff735a722af 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -345,9 +345,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
-config IOMMU_HELPER
-	def_bool PCI
-
 config ALPHA_NONAME
 	bool
 	depends on ALPHA_BOOK1 || ALPHA_NONAME_CH
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..2f79222c5c02 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1781,9 +1781,6 @@ config SECCOMP
 config SWIOTLB
 	def_bool y
 
-config IOMMU_HELPER
-	def_bool SWIOTLB
-
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..fbef5d3de83f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -252,9 +252,6 @@ config SMP
 config SWIOTLB
 	def_bool y
 
-config IOMMU_HELPER
-	def_bool SWIOTLB
-
 config KERNEL_MODE_NEON
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bbe12a038d21..862c5160c09d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -613,6 +613,3 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
-
-config IOMMU_HELPER
-	def_bool (IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB || IA64_GENERIC || SWIOTLB)
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index b5eee1a57d6c..647ed158ac98 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -67,16 +67,12 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config IOMMU_HELPER
-	bool
-
 config NEED_SG_DMA_LENGTH
 	bool
 
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
-	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 
 config OCTEON_ILM
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 72af0c183969..5efb2e63878e 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -130,9 +130,6 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
-config IOMMU_HELPER
-	bool
-
 config NEED_SG_DMA_LENGTH
 	bool
 
@@ -141,7 +138,6 @@ config SWIOTLB
 	default y
 	depends on CPU_LOONGSON3
 	select DMA_DIRECT_OPS
-	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 	select NEED_DMA_MAP_STATE
 
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 7fcfc7fe9f14..5c5ee0e05a17 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -83,9 +83,6 @@ endif
 config NLM_COMMON
 	bool
 
-config IOMMU_HELPER
-	bool
-
 config NEED_SG_DMA_LENGTH
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..eb23f2949bf6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -484,7 +484,6 @@ config IOMMU_HELPER
 config SWIOTLB
 	bool "SWIOTLB support"
 	default n
-	select IOMMU_HELPER
 	---help---
 	  Support for IO bounce buffering for systems without an IOMMU.
 	  This allows us to DMA to the full physical address space on
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index e9154a59d561..3f105e00c432 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -44,9 +44,6 @@ config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
 
-config IOMMU_HELPER
-	def_bool SWIOTLB
-
 config NEED_SG_DMA_LENGTH
 	def_bool SWIOTLB
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d234cca296db..336b1378ee62 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -930,7 +930,7 @@ config SWIOTLB
 
 config IOMMU_HELPER
 	def_bool y
-	depends on CALGARY_IOMMU || GART_IOMMU || SWIOTLB || AMD_IOMMU
+	depends on CALGARY_IOMMU || GART_IOMMU
 
 config MAXSMP
 	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
index 3a102a84d637..5a48b5606110 100644
--- a/drivers/parisc/Kconfig
+++ b/drivers/parisc/Kconfig
@@ -103,11 +103,6 @@ config IOMMU_SBA
 	depends on PCI_LBA
 	default PCI_LBA
 
-config IOMMU_HELPER
-	bool
-	depends on IOMMU_SBA || IOMMU_CCIO
-	default y
-
 source "drivers/pcmcia/Kconfig"
 
 endmenu
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index cb9a9248c8c0..70d01edcbf8b 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_IOMMU_HELPER_H
 #define _LINUX_IOMMU_HELPER_H
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 
 static inline unsigned long iommu_device_max_index(unsigned long size,
@@ -14,9 +15,15 @@ static inline unsigned long iommu_device_max_index(unsigned long size,
 		return size;
 }
 
-extern int iommu_is_span_boundary(unsigned int index, unsigned int nr,
-				  unsigned long shift,
-				  unsigned long boundary_size);
+static inline int iommu_is_span_boundary(unsigned int index, unsigned int nr,
+		unsigned long shift, unsigned long boundary_size)
+{
+	BUG_ON(!is_power_of_2(boundary_size));
+
+	shift = (shift + index) & (boundary_size - 1);
+	return shift + nr > boundary_size;
+}
+
 extern unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
 				      unsigned long start, unsigned int nr,
 				      unsigned long shift,
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index ded1703e7e64..92a9f243c0e2 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -4,17 +4,7 @@
  */
 
 #include <linux/bitmap.h>
-#include <linux/bug.h>
-
-int iommu_is_span_boundary(unsigned int index, unsigned int nr,
-			   unsigned long shift,
-			   unsigned long boundary_size)
-{
-	BUG_ON(!is_power_of_2(boundary_size));
-
-	shift = (shift + index) & (boundary_size - 1);
-	return shift + nr > boundary_size;
-}
+#include <linux/iommu-helper.h>
 
 unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
 			       unsigned long start, unsigned int nr,
-- 
2.17.0
