Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 23:03:26 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:39967 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008059AbcCQWDPpf4sM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 23:03:15 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9F985611DD;
        Thu, 17 Mar 2016 22:03:13 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FE1560F34; Thu, 17 Mar 2016 22:03:13 +0000 (UTC)
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E0DD60316;
        Thu, 17 Mar 2016 22:03:09 +0000 (UTC)
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, timur@codeaurora.org,
        cov@codeaurora.org, nwatters@codeaurora.org
Cc:     Sinan Kaya <okaya@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Geliang Tang <geliangtang@163.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org
Subject: [PATCH 3/3] dma-mapping: move swiotlb dma-phys functions to common header
Date:   Thu, 17 Mar 2016 18:02:17 -0400
Message-Id: <1458252137-24497-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

Moving the default implementation of swiotlb_dma_to_phys and
swiotlb_phys_to_dma functions to dma-mapping.h so that we can get
rid of the duplicate code in multiple ARCH.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/arm64/include/asm/dma-mapping.h               | 14 --------------
 arch/ia64/include/asm/dma-mapping.h                | 14 --------------
 arch/mips/include/asm/mach-generic/dma-coherence.h | 16 ----------------
 arch/tile/include/asm/dma-mapping.h                | 14 --------------
 arch/unicore32/include/asm/dma-mapping.h           | 14 --------------
 arch/x86/include/asm/dma-mapping.h                 | 13 -------------
 arch/xtensa/include/asm/dma-mapping.h              | 14 --------------
 include/linux/dma-mapping.h                        | 14 ++++++++++++++
 8 files changed, 14 insertions(+), 99 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 39f21e8..5654357 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -64,20 +64,6 @@ static inline bool is_device_dma_coherent(struct device *dev)
 	return dev->archdata.dma_coherent;
 }
 
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return (dma_addr_t)paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t dev_addr)
-{
-	return (phys_addr_t)dev_addr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index a8736b9..e6dd1f7 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -33,20 +33,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t daddr)
-{
-	return daddr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
-
 static inline void
 dma_cache_sync (struct device *dev, void *vaddr, size_t size,
 	enum dma_data_direction dir)
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 54fde22..7bb5de0 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -58,20 +58,4 @@ static inline void plat_post_dma_flush(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_SWIOTLB
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t daddr)
-{
-	return daddr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
-#endif
-
 #endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 87c205a..c9cc14e 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -47,20 +47,6 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 	dev->archdata.dma_offset = off;
 }
 
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t daddr)
-{
-	return daddr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
-
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
 static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 762cdd8..c629aa5 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -36,20 +36,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return 1;
 }
 
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t daddr)
-{
-	return daddr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
-
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
 static inline void dma_cache_sync(struct device *dev, void *vaddr,
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index be8b76e..fd5c7de 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -71,19 +71,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t daddr)
-{
-	return daddr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
 #endif /* CONFIG_X86_DMA_REMAP */
 
 static inline void
diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index b0d725d..4e6ff4d 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -31,18 +31,4 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction direction);
 
-static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev,
-					     phys_addr_t paddr)
-{
-	return (dma_addr_t)paddr;
-}
-#define swiotlb_phys_to_dma swiotlb_phys_to_dma
-
-static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev,
-					      dma_addr_t daddr)
-{
-	return (phys_addr_t)daddr;
-}
-#define swiotlb_dma_to_phys swiotlb_dma_to_phys
-
 #endif	/* _XTENSA_DMA_MAPPING_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 728ef07..871d620 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -683,4 +683,18 @@ static inline int dma_mmap_writecombine(struct device *dev,
 #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
 #endif
 
+#ifndef swiotlb_phys_to_dma
+static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+         return paddr;
+}
+#endif
+
+#ifndef swiotlb_dma_to_phys
+static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+        return daddr;
+}
+#endif
+
 #endif
-- 
1.8.2.1
