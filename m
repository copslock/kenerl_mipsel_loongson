Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:00:56 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:40498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994584AbeDOPAT5qwMu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 17:00:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yTD/jJtNCoxiUonI9FFN4dyN7eP+XcTFKgCQf+Fwo0I=; b=Su+VnF0Sf6PG1EGmJeWF+YgRW
        L7830TaNcx5yeAJ4L02AuM4fQ+XXugORJyciTvdRgHBRHHQ5Q0nSqnmVzujvzhvWkmSVoD47swm7j
        JVpJgjOJxuyzJolf2GoYd2HgfyYNhNXxQTgcugfM909lZzlYQ7gj+vFV/uURq58F9l2+9szDeQZ/a
        24GI0pKPb0eTxhDI1aMPH43X7ce616Yorio4CPpE3SXE0w/QqtVxo/OSnP602J0VEXQBccEstgX73
        xYtzxC31JpFmNSQloJ8t43kbBw/fQ+BKcJ95QnJphEcsWGMn2KtoVnYV0W9OSI2Duxp63hAeWmRmw
        ki4A/0TRQ==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j8M-0005fw-PC; Sun, 15 Apr 2018 15:00:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/12] iommu-helper: move the IOMMU_HELPER config symbol to lib/
Date:   Sun, 15 Apr 2018 16:59:39 +0200
Message-Id: <20180415145947.1248-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63540
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
---
 arch/powerpc/Kconfig | 4 +---
 arch/s390/Kconfig    | 5 ++---
 arch/sparc/Kconfig   | 5 +----
 arch/x86/Kconfig     | 6 ++----
 lib/Kconfig          | 3 +++
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index eb23f2949bf6..3ca617cd4807 100644
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
index 32a0d5b958bf..bfa449fdeb19 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -693,7 +693,9 @@ config QDIO
 menuconfig PCI
 	bool "PCI support"
 	select PCI_MSI
+	select IOMMU_HELPER
 	select IOMMU_SUPPORT
+
 	help
 	  Enable PCI support.
 
@@ -717,9 +719,6 @@ config PCI_DOMAINS
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
index 336b1378ee62..06ca29e70d6b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -870,6 +870,7 @@ config DMI
 
 config GART_IOMMU
 	bool "Old AMD GART IOMMU support"
+	select IOMMU_HELPER
 	select SWIOTLB
 	depends on X86_64 && PCI && AMD_NB
 	---help---
@@ -891,6 +892,7 @@ config GART_IOMMU
 
 config CALGARY_IOMMU
 	bool "IBM Calgary IOMMU support"
+	select IOMMU_HELPER
 	select SWIOTLB
 	depends on X86_64 && PCI
 	---help---
@@ -928,10 +930,6 @@ config SWIOTLB
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
