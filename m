Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:25:42 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:42029 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991258AbdL2IUdPHfwC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:20:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tzFVDkvEhJ6GFKEEmSa4/0NCd//iDA91jkWmMtMH0ps=; b=HipfZJNCs65i/tZxxKl2/+cMC
        k1dz89YolQRSvGlKEWqFH8yBWQ2NM1KPv6jF/qFAZxa7wTKW53JrVFmPsAjoaMZLk5Q6yzGnJIlOb
        EbrJ7bTT/X5Kajn0/x/4suSAPnn5NaVFHo79qirLhfTgA+m7SfJTN+D5ffXYmYkNSdmT2njIbNCNh
        qqOoVZDJozduH7A/mCtJvqVpnoVBQ3VSHbRMiu48j8xHVwVnLtiBiTxlK/JmIUXTbWWXAWB/m+OPy
        7BnjH3R1TkKOWftinyaNDIwvL6DmTDoHBKBkBMQaSJ1mhaKTAX+vjAp4ugNIo3cY9oTnX5rfRPz4T
        xiP7k/V9A==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUptr-0000gR-AN; Fri, 29 Dec 2017 08:20:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/67] dma-mapping: move dma_mark_clean to dma-direct.h
Date:   Fri, 29 Dec 2017 09:18:18 +0100
Message-Id: <20171229081911.2802-15-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61711
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

And unlike the other helpers we don't require a <asm/dma-direct.h> as
this helper is a special case for ia64 only, and this keeps it as
simple as possible.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h       | 2 --
 arch/arm64/include/asm/dma-mapping.h     | 4 ----
 arch/ia64/Kconfig                        | 1 +
 arch/ia64/include/asm/dma.h              | 2 --
 arch/mips/include/asm/dma-mapping.h      | 2 --
 arch/powerpc/include/asm/swiotlb.h       | 2 --
 arch/tile/include/asm/dma-mapping.h      | 2 --
 arch/unicore32/include/asm/dma-mapping.h | 2 --
 arch/x86/include/asm/swiotlb.h           | 2 --
 include/linux/dma-direct.h               | 9 +++++++++
 10 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 5fb1b7fbdfbe..e5d9020c9ee1 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -109,8 +109,6 @@ static inline bool is_device_dma_coherent(struct device *dev)
 	return dev->archdata.dma_coherent;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size) { }
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 400fa67d3b5a..b7847eb8a7bb 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -50,9 +50,5 @@ static inline bool is_device_dma_coherent(struct device *dev)
 	return dev->archdata.dma_coherent;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size)
-{
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 49583c5a5d44..4d18fca885ee 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -33,6 +33,7 @@ config IA64
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_SG_CHAIN
 	select VIRT_TO_BUS
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/ia64/include/asm/dma.h b/arch/ia64/include/asm/dma.h
index 186850eec934..23604d6a2cb2 100644
--- a/arch/ia64/include/asm/dma.h
+++ b/arch/ia64/include/asm/dma.h
@@ -20,6 +20,4 @@ extern unsigned long MAX_DMA_ADDRESS;
 
 #define free_dma(x)
 
-void dma_mark_clean(void *addr, size_t size);
-
 #endif /* _ASM_IA64_DMA_H */
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 676c14cfc580..886e75a383f2 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -17,8 +17,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return mips_dma_map_ops;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size) {}
-
 #define arch_setup_dma_ops arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      u64 size, const struct iommu_ops *iommu,
diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index 01d45a5fd00b..9341ee804d19 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -15,8 +15,6 @@
 
 extern const struct dma_map_ops swiotlb_dma_ops;
 
-static inline void dma_mark_clean(void *addr, size_t size) {}
-
 extern unsigned int ppc_swiotlb_enable;
 int __init swiotlb_setup_bus_notifier(void);
 
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 75b8aaa4e70b..d25fce101fc0 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -44,8 +44,6 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 	dev->archdata.dma_offset = off;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size) {}
-
 #define HAVE_ARCH_DMA_SET_MASK 1
 int dma_set_mask(struct device *dev, u64 mask);
 
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 5cb250bf2d8c..f2bfec273aa7 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -25,7 +25,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &swiotlb_dma_map_ops;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size) {}
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
index bdf9aed40403..1c6a6cb230ff 100644
--- a/arch/x86/include/asm/swiotlb.h
+++ b/arch/x86/include/asm/swiotlb.h
@@ -28,8 +28,6 @@ static inline void pci_swiotlb_late_init(void)
 }
 #endif
 
-static inline void dma_mark_clean(void *addr, size_t size) {}
-
 extern void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags,
 					unsigned long attrs);
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 2cc1b6558944..10e924b7cba7 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -29,4 +29,13 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
+
+#ifdef CONFIG_ARCH_HAS_DMA_MARK_CLEAN
+void dma_mark_clean(void *addr, size_t size);
+#else
+static inline void dma_mark_clean(void *addr, size_t size)
+{
+}
+#endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
+
 #endif /* _LINUX_DMA_DIRECT_H */
-- 
2.14.2
