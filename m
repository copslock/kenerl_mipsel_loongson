Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 19:05:38 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993947AbeDWRE4Kvfce (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 19:04:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VfcP5zm97pEmg43rvyMX4uia/pGIwogHOyxkcDSIvSE=; b=IELQWnrUU7WyWGj1PkUiljlE3
        hHlHYYQ8DlLbVS2nHmf43hI08LJsR3eusuWXQb/pjQS+u1S0cGtKHxSRqau+KIl9z9dObBle7alGs
        JQ2DgxnNHNFGtlcC4IM/XOh9aDT/Q3ns4LiyLrW6uZ57iSvYKeJ/YjnF/c2FaVkfTYwGqszlq0UwJ
        6vx86S+GHYKf9zX4eRLCFCxErs5fd5SPNWt2vIjmZ1kDJxOrem+iFQQdSQd0mgZ4xNDhhikWYKbWU
        e+0MG3JwUJUc/BtZepZVIUPNiTNaQmMqPoVejAaukrdjvnNVjIeX1rCDI5StlAK6vII903vC64eJ3
        K8IMbUFRQ==;
Received: from 089144198044.atnat0007.highway.a1.net ([89.144.198.44] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAetH-00005U-Nc; Mon, 23 Apr 2018 17:04:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/12] iommu-helper: move the IOMMU_HELPER config symbol to lib/
Date:   Mon, 23 Apr 2018 19:04:11 +0200
Message-Id: <20180423170419.20330-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423170419.20330-1-hch@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+de39c3f36ce265885e0e+5356+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63705
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
 arch/powerpc/Kconfig | 4 +---
 arch/s390/Kconfig    | 5 ++---
 arch/sparc/Kconfig   | 5 +----
 arch/x86/Kconfig     | 6 ++----
 lib/Kconfig          | 3 +++
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 43e3c8e4e7f4..7698cf89af9c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,6 +223,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
@@ -478,9 +479,6 @@ config MPROFILE_KERNEL
 	depends on PPC64 && CPU_LITTLE_ENDIAN
 	def_bool !DISABLE_MPROFILE_KERNEL
 
-config IOMMU_HELPER
-	def_bool PPC64
-
 config SWIOTLB
 	bool "SWIOTLB support"
 	default n
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 199ac3e4da1d..60c4ab854182 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -709,7 +709,9 @@ config QDIO
 menuconfig PCI
 	bool "PCI support"
 	select PCI_MSI
+	select IOMMU_HELPER
 	select IOMMU_SUPPORT
+
 	help
 	  Enable PCI support.
 
@@ -733,9 +735,6 @@ config PCI_DOMAINS
 config HAS_IOMEM
 	def_bool PCI
 
-config IOMMU_HELPER
-	def_bool PCI
-
 config NEED_SG_DMA_LENGTH
 	def_bool PCI
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..44e0f3cd7988 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -67,6 +67,7 @@ config SPARC64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_DEBUG_KMEMLEAK
+	select IOMMU_HELPER
 	select SPARSE_IRQ
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
@@ -106,10 +107,6 @@ config ARCH_DMA_ADDR_T_64BIT
 	bool
 	default y if ARCH_ATU
 
-config IOMMU_HELPER
-	bool
-	default y if SPARC64
-
 config STACKTRACE_SUPPORT
 	bool
 	default y if SPARC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cb2c7ecc1fea..fe9713539166 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -871,6 +871,7 @@ config DMI
 
 config GART_IOMMU
 	bool "Old AMD GART IOMMU support"
+	select IOMMU_HELPER
 	select SWIOTLB
 	depends on X86_64 && PCI && AMD_NB
 	---help---
@@ -892,6 +893,7 @@ config GART_IOMMU
 
 config CALGARY_IOMMU
 	bool "IBM Calgary IOMMU support"
+	select IOMMU_HELPER
 	select SWIOTLB
 	depends on X86_64 && PCI
 	---help---
@@ -929,10 +931,6 @@ config SWIOTLB
 	  with more than 3 GB of memory.
 	  If unsure, say Y.
 
-config IOMMU_HELPER
-	def_bool y
-	depends on CALGARY_IOMMU || GART_IOMMU
-
 config MAXSMP
 	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
 	depends on X86_64 && SMP && DEBUG_KERNEL
diff --git a/lib/Kconfig b/lib/Kconfig
index 5fe577673b98..2f6908577534 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -429,6 +429,9 @@ config SGL_ALLOC
 	bool
 	default n
 
+config IOMMU_HELPER
+	bool
+
 config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
-- 
2.17.0
