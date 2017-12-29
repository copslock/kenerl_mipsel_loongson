Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:26:55 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:58245 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992079AbdL2IUrFdZLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:20:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D5ENoKD4ESFqKEY5AeHSgC+CibA67cw4aIyBJaF+tuk=; b=PGmF2c8b9+86Jxim28yuPey0x
        u62npGsYHTWcws/zd34Yo3/EgyU5+sye/eZEfYWiX9gcyd0V7ag5Y2VQLpWl9E8LSAayyvo9Ywbze
        rZuClgJB+HUB9p7na3Mfys9ctthvvDtZULttEwKpbhUv2DuwTcE/ZEicy16w1irta1ZwA53KPmagI
        VK93NcE4x72/aP6jHKWOSFd3l8JRJ1Se1D2Z1EZu4917Svpe3Ug5hMI+0PiFzogPCM22k280yAjsR
        mgsl/hxyHuqg29mZlYg8LCY3CpOxHXVI1yKOS8iwHZNnP6BeH8pWGwkmlWb/St5tnWvlX+mLkgKNu
        bcC5kLEtA==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpu4-0000yZ-Nv; Fri, 29 Dec 2017 08:20:33 +0000
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
Subject: [PATCH 17/67] microblaze: rename dma_direct to dma_microblaze
Date:   Fri, 29 Dec 2017 09:18:21 +0100
Message-Id: <20171229081911.2802-18-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61714
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

This frees the dma_direct_* namespace for a generic implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/dma-mapping.h |  4 +--
 arch/microblaze/kernel/dma.c              | 50 +++++++++++++++----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index 6b9ea39405b8..add50c1373bf 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -18,11 +18,11 @@
 /*
  * Available generic sets of operations
  */
-extern const struct dma_map_ops dma_direct_ops;
+extern const struct dma_map_ops dma_nommu_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return &dma_direct_ops;
+	return &dma_nommu_ops;
 }
 
 #endif	/* _ASM_MICROBLAZE_DMA_MAPPING_H */
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 2a9a0ec14c46..364b0ac41452 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -17,7 +17,7 @@
 
 #define NOT_COHERENT_CACHE
 
-static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
+static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
 				       unsigned long attrs)
 {
@@ -42,7 +42,7 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 #endif
 }
 
-static void dma_direct_free_coherent(struct device *dev, size_t size,
+static void dma_nommu_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
@@ -69,7 +69,7 @@ static inline void __dma_sync(unsigned long paddr,
 	}
 }
 
-static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
+static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 			     int nents, enum dma_data_direction direction,
 			     unsigned long attrs)
 {
@@ -89,12 +89,12 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static int dma_direct_dma_supported(struct device *dev, u64 mask)
+static int dma_nommu_dma_supported(struct device *dev, u64 mask)
 {
 	return 1;
 }
 
-static inline dma_addr_t dma_direct_map_page(struct device *dev,
+static inline dma_addr_t dma_nommu_map_page(struct device *dev,
 					     struct page *page,
 					     unsigned long offset,
 					     size_t size,
@@ -106,7 +106,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	return page_to_phys(page) + offset;
 }
 
-static inline void dma_direct_unmap_page(struct device *dev,
+static inline void dma_nommu_unmap_page(struct device *dev,
 					 dma_addr_t dma_address,
 					 size_t size,
 					 enum dma_data_direction direction,
@@ -122,7 +122,7 @@ static inline void dma_direct_unmap_page(struct device *dev,
 }
 
 static inline void
-dma_direct_sync_single_for_cpu(struct device *dev,
+dma_nommu_sync_single_for_cpu(struct device *dev,
 			       dma_addr_t dma_handle, size_t size,
 			       enum dma_data_direction direction)
 {
@@ -136,7 +136,7 @@ dma_direct_sync_single_for_cpu(struct device *dev,
 }
 
 static inline void
-dma_direct_sync_single_for_device(struct device *dev,
+dma_nommu_sync_single_for_device(struct device *dev,
 				  dma_addr_t dma_handle, size_t size,
 				  enum dma_data_direction direction)
 {
@@ -150,7 +150,7 @@ dma_direct_sync_single_for_device(struct device *dev,
 }
 
 static inline void
-dma_direct_sync_sg_for_cpu(struct device *dev,
+dma_nommu_sync_sg_for_cpu(struct device *dev,
 			   struct scatterlist *sgl, int nents,
 			   enum dma_data_direction direction)
 {
@@ -164,7 +164,7 @@ dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 
 static inline void
-dma_direct_sync_sg_for_device(struct device *dev,
+dma_nommu_sync_sg_for_device(struct device *dev,
 			      struct scatterlist *sgl, int nents,
 			      enum dma_data_direction direction)
 {
@@ -178,7 +178,7 @@ dma_direct_sync_sg_for_device(struct device *dev,
 }
 
 static
-int dma_direct_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			     void *cpu_addr, dma_addr_t handle, size_t size,
 			     unsigned long attrs)
 {
@@ -204,21 +204,21 @@ int dma_direct_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 #endif
 }
 
-const struct dma_map_ops dma_direct_ops = {
-	.alloc		= dma_direct_alloc_coherent,
-	.free		= dma_direct_free_coherent,
-	.mmap		= dma_direct_mmap_coherent,
-	.map_sg		= dma_direct_map_sg,
-	.dma_supported	= dma_direct_dma_supported,
-	.map_page	= dma_direct_map_page,
-	.unmap_page	= dma_direct_unmap_page,
-	.sync_single_for_cpu		= dma_direct_sync_single_for_cpu,
-	.sync_single_for_device		= dma_direct_sync_single_for_device,
-	.sync_sg_for_cpu		= dma_direct_sync_sg_for_cpu,
-	.sync_sg_for_device		= dma_direct_sync_sg_for_device,
-	.is_phys	= true,
+const struct dma_map_ops dma_nommu_ops = {
+	.alloc			= dma_nommu_alloc_coherent,
+	.free			= dma_nommu_free_coherent,
+	.mmap			= dma_nommu_mmap_coherent,
+	.map_sg			= dma_nommu_map_sg,
+	.dma_supported		= dma_nommu_dma_supported,
+	.map_page		= dma_nommu_map_page,
+	.unmap_page		= dma_nommu_unmap_page,
+	.sync_single_for_cpu	= dma_nommu_sync_single_for_cpu,
+	.sync_single_for_device	= dma_nommu_sync_single_for_device,
+	.sync_sg_for_cpu	= dma_nommu_sync_sg_for_cpu,
+	.sync_sg_for_device	= dma_nommu_sync_sg_for_device,
+	.is_phys		= true,
 };
-EXPORT_SYMBOL(dma_direct_ops);
+EXPORT_SYMBOL(dma_nommu_ops);
 
 /* Number of entries preallocated for DMA-API debugging */
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-- 
2.14.2
