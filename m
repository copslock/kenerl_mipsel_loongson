Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:47:59 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15875 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041785AbcFBPlkF0kC2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:40 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500C9VI99R710@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:33 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-c5-575053ac5271
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id A8.0C.04866.CA350575; Thu,
 2 Jun 2016 16:41:32 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:32 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Geoff Levand <geoff@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Muli Ben-Yehuda <muli@il.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@linux.ie>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        discuss@x86-64.org, linux-pci@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC v3 22/45] powerpc: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:24 +0200
Message-id: <1464881987-13203-23-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTZxT3u999FLTJXX1wxVdSnVmIuukWPTol+o/emBkbXYJiZOv0CgaK
        rAVf0Vl5qLy0wkBsSQOs8lppKegUTEeohk6wkwYsakEMIEIEWkhQ0yLaQvzv9zqPnBwRlvRS
        4aLjicmCMlGeIKVDybZpe8da435Z1He6+6sgs8HPgL1WTUPu/48IKDYbafiY18KApchMgTc1
        A4MhNQ6cNzJI8JTnIKio3AO9E24EY6l+EqZHRzB0TnpouF6VjyHb1MfApcIdUPzGgWDwhZUA
        w3AkND97x0CbpoyAQksYfJhMCxS2WjCUNP0IY/ohDL2magre2LQYip9vgKmbXgIydbUMvB1a
        D+V/vUbwWtNNw1jPQwTaph4S6vpdFFxvcjDwUKchoPJvE4bSSwYS/rvqpcCTfo8G75UxCjoa
        i2moGKjBkFN7J0DTnMGtLpOgKchjQGe4RkJfazsBDr2dhkFbLgkTrz5h0JSmYSh68m/gHlN/
        YsjoriGgylHDgK3AisD/fpraHs0PNOsJPsOqoXmj3oj4DpcT835fHuK7TDL+bb4mIF3NJfjm
        PhvNlw2rSb5B28Pw3vEYvqQuhdcVuBCf0/AY8fWVEbKN0aFbjwoJx08Kym8jfw2N83k2JqUP
        oNOO5ge0GvlvoywUIuLYH7jbnUXELF7Etb8001koVCRhbyHO9zifmCUXCa7a8mImRbPfc/UV
        hpnUAtbCcep+Jw4amD3HDdt9M23ns3u4lvL0GZ1kv+bePZ2ig1jM8txd1zg9O24596glnwri
        kIBuMFeRQSxhd3HOtHpKg8QlaE41WiikHElS/Rar2LBOJVeoUhJj1x05oahDs283eQ/datli
        Q6wISeeJ56zZGyWh5CdVZxQ2xImwdIE4eZ8sSiI+Kj9zVlCe+EWZkiCobGiJiJSGiW82en6W
        sLHyZCFeEJIE5ReXEIWEq5FRr102XLci8pt91kHF+cXO/ur7rVnduxhy23jX72ZpvdWfOTpa
        ODL69NjqrPgDiwYOHgpf8sdkp++r+KVPOiuP+Z3uC+Ht3TE1bZ4wYuWH+S9Pd8Vof3omd2/Z
        3BhduCnb5DpVe+jg8onsiFW73YeH7Nv/CSm5MXfn/hHd4enLblmrS0qq4uTrI7BSJf8Mn/6L
        NnIDAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/powerpc/include/asm/dma-mapping.h    |  7 +++----
 arch/powerpc/include/asm/iommu.h          | 10 +++++-----
 arch/powerpc/kernel/dma-iommu.c           | 12 ++++++------
 arch/powerpc/kernel/dma.c                 | 18 +++++++++---------
 arch/powerpc/kernel/ibmebus.c             | 12 ++++++------
 arch/powerpc/kernel/iommu.c               | 12 ++++++------
 arch/powerpc/kernel/vio.c                 | 12 ++++++------
 arch/powerpc/platforms/cell/iommu.c       | 14 +++++++-------
 arch/powerpc/platforms/pasemi/iommu.c     |  2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  |  8 ++++----
 arch/powerpc/platforms/powernv/pci-ioda.c |  4 ++--
 arch/powerpc/platforms/powernv/pci.c      |  2 +-
 arch/powerpc/platforms/powernv/pci.h      |  2 +-
 arch/powerpc/platforms/ps3/system-bus.c   | 18 +++++++++---------
 arch/powerpc/platforms/pseries/iommu.c    |  6 +++---
 arch/powerpc/sysdev/dart_iommu.c          |  2 +-
 16 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 77816acd4fd9..84e3f8dd5e4f 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -13,7 +13,6 @@
 /* need struct page definitions */
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
@@ -25,14 +24,14 @@
 /* Some dma direct funcs must be visible for use in other dma_ops */
 extern void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t flag,
-					 struct dma_attrs *attrs);
+					 unsigned long attrs);
 extern void __dma_direct_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
-				       struct dma_attrs *attrs);
+				       unsigned long attrs);
 extern int dma_direct_mmap_coherent(struct device *dev,
 				    struct vm_area_struct *vma,
 				    void *cpu_addr, dma_addr_t handle,
-				    size_t size, struct dma_attrs *attrs);
+				    size_t size, unsigned long attrs);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7b87bab09564..760915241ce2 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -53,7 +53,7 @@ struct iommu_table_ops {
 			long index, long npages,
 			unsigned long uaddr,
 			enum dma_data_direction direction,
-			struct dma_attrs *attrs);
+			unsigned long attrs);
 #ifdef CONFIG_IOMMU_API
 	/*
 	 * Exchanges existing TCE with new TCE plus direction bits;
@@ -248,12 +248,12 @@ extern int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			    struct scatterlist *sglist, int nelems,
 			    unsigned long mask,
 			    enum dma_data_direction direction,
-			    struct dma_attrs *attrs);
+			    unsigned long attrs);
 extern void ppc_iommu_unmap_sg(struct iommu_table *tbl,
 			       struct scatterlist *sglist,
 			       int nelems,
 			       enum dma_data_direction direction,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 
 extern void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 				  size_t size, dma_addr_t *dma_handle,
@@ -264,10 +264,10 @@ extern dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 				 struct page *page, unsigned long offset,
 				 size_t size, unsigned long mask,
 				 enum dma_data_direction direction,
-				 struct dma_attrs *attrs);
+				 unsigned long attrs);
 extern void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
 			     size_t size, enum dma_data_direction direction,
-			     struct dma_attrs *attrs);
+			     unsigned long attrs);
 
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_dart(struct pci_controller_ops *controller_ops);
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 41a7d9d49a5a..fb7cbaa37658 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -18,7 +18,7 @@
  */
 static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
 				    dma_handle, dev->coherent_dma_mask, flag,
@@ -27,7 +27,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_iommu_free_coherent(struct device *dev, size_t size,
 				    void *vaddr, dma_addr_t dma_handle,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
 }
@@ -40,7 +40,7 @@ static void dma_iommu_free_coherent(struct device *dev, size_t size,
 static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
 			      size, device_to_mask(dev), direction, attrs);
@@ -49,7 +49,7 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 
 static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				 size_t size, enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size, direction,
 			 attrs);
@@ -58,7 +58,7 @@ static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 
 static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 				device_to_mask(dev), direction, attrs);
@@ -66,7 +66,7 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
 			   direction, attrs);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 3f1472a78f39..e64a6016fba7 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -64,7 +64,7 @@ static int dma_direct_dma_supported(struct device *dev, u64 mask)
 
 void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flag,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	void *ret;
 #ifdef CONFIG_NOT_COHERENT_CACHE
@@ -121,7 +121,7 @@ void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
 
 void __dma_direct_free_coherent(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	__dma_free_coherent(size, vaddr);
@@ -132,7 +132,7 @@ void __dma_direct_free_coherent(struct device *dev, size_t size,
 
 static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	struct iommu_table *iommu;
 
@@ -156,7 +156,7 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_direct_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct iommu_table *iommu;
 
@@ -177,7 +177,7 @@ static void dma_direct_free_coherent(struct device *dev, size_t size,
 
 int dma_direct_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			     void *cpu_addr, dma_addr_t handle, size_t size,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	unsigned long pfn;
 
@@ -195,7 +195,7 @@ int dma_direct_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 			     int nents, enum dma_data_direction direction,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -211,7 +211,7 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 
 static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
 				int nents, enum dma_data_direction direction,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 }
 
@@ -232,7 +232,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 					     unsigned long offset,
 					     size_t size,
 					     enum dma_data_direction dir,
-					     struct dma_attrs *attrs)
+					     unsigned long attrs)
 {
 	BUG_ON(dir == DMA_NONE);
 	__dma_sync_page(page, offset, size, dir);
@@ -243,7 +243,7 @@ static inline void dma_direct_unmap_page(struct device *dev,
 					 dma_addr_t dma_address,
 					 size_t size,
 					 enum dma_data_direction direction,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 }
 
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index a89f4f7a66bd..c1ca9282f4a0 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -65,7 +65,7 @@ static void *ibmebus_alloc_coherent(struct device *dev,
 				    size_t size,
 				    dma_addr_t *dma_handle,
 				    gfp_t flag,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	void *mem;
 
@@ -78,7 +78,7 @@ static void *ibmebus_alloc_coherent(struct device *dev,
 static void ibmebus_free_coherent(struct device *dev,
 				  size_t size, void *vaddr,
 				  dma_addr_t dma_handle,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	kfree(vaddr);
 }
@@ -88,7 +88,7 @@ static dma_addr_t ibmebus_map_page(struct device *dev,
 				   unsigned long offset,
 				   size_t size,
 				   enum dma_data_direction direction,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	return (dma_addr_t)(page_address(page) + offset);
 }
@@ -97,7 +97,7 @@ static void ibmebus_unmap_page(struct device *dev,
 			       dma_addr_t dma_addr,
 			       size_t size,
 			       enum dma_data_direction direction,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	return;
 }
@@ -105,7 +105,7 @@ static void ibmebus_unmap_page(struct device *dev,
 static int ibmebus_map_sg(struct device *dev,
 			  struct scatterlist *sgl,
 			  int nents, enum dma_data_direction direction,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -121,7 +121,7 @@ static int ibmebus_map_sg(struct device *dev,
 static void ibmebus_unmap_sg(struct device *dev,
 			     struct scatterlist *sg,
 			     int nents, enum dma_data_direction direction,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	return;
 }
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490b54e3..37d6e741be82 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -307,7 +307,7 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 			      void *page, unsigned int npages,
 			      enum dma_data_direction direction,
 			      unsigned long mask, unsigned int align_order,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	unsigned long entry;
 	dma_addr_t ret = DMA_ERROR_CODE;
@@ -431,7 +431,7 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		     struct scatterlist *sglist, int nelems,
 		     unsigned long mask, enum dma_data_direction direction,
-		     struct dma_attrs *attrs)
+		     unsigned long attrs)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	struct scatterlist *s, *outs, *segstart;
@@ -574,7 +574,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 void ppc_iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 			int nelems, enum dma_data_direction direction,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *sg;
 
@@ -753,7 +753,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 			  struct page *page, unsigned long offset, size_t size,
 			  unsigned long mask, enum dma_data_direction direction,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	dma_addr_t dma_handle = DMA_ERROR_CODE;
 	void *vaddr;
@@ -790,7 +790,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 
 void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
 		      size_t size, enum dma_data_direction direction,
-		      struct dma_attrs *attrs)
+		      unsigned long attrs)
 {
 	unsigned int npages;
 
@@ -845,7 +845,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	nio_pages = size >> tbl->it_page_shift;
 	io_order = get_iommu_order(size, tbl);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
-			      mask >> tbl->it_page_shift, io_order, NULL);
+			      mask >> tbl->it_page_shift, io_order, 0);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 8d7358f3a273..b3813ddb2fb4 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -482,7 +482,7 @@ static void vio_cmo_balance(struct work_struct *work)
 
 static void *vio_dma_iommu_alloc_coherent(struct device *dev, size_t size,
 					  dma_addr_t *dma_handle, gfp_t flag,
-					  struct dma_attrs *attrs)
+					  unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	void *ret;
@@ -503,7 +503,7 @@ static void *vio_dma_iommu_alloc_coherent(struct device *dev, size_t size,
 
 static void vio_dma_iommu_free_coherent(struct device *dev, size_t size,
 					void *vaddr, dma_addr_t dma_handle,
-					struct dma_attrs *attrs)
+					unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 
@@ -515,7 +515,7 @@ static void vio_dma_iommu_free_coherent(struct device *dev, size_t size,
 static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
                                          unsigned long offset, size_t size,
                                          enum dma_data_direction direction,
-                                         struct dma_attrs *attrs)
+                                         unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct iommu_table *tbl;
@@ -539,7 +539,7 @@ static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
 static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				     size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct iommu_table *tbl;
@@ -552,7 +552,7 @@ static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 
 static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
                                 int nelems, enum dma_data_direction direction,
-                                struct dma_attrs *attrs)
+                                unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct iommu_table *tbl;
@@ -588,7 +588,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 static void vio_dma_iommu_unmap_sg(struct device *dev,
 		struct scatterlist *sglist, int nelems,
 		enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct iommu_table *tbl;
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 0c2794d2b6c0..5d1a7ef3fdee 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -166,7 +166,7 @@ static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
 
 static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int i;
 	unsigned long *io_pte, base_pte;
@@ -572,7 +572,7 @@ static struct iommu_table *cell_get_iommu_table(struct device *dev)
 
 static void *dma_fixed_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	if (iommu_fixed_is_weak)
 		return iommu_alloc_coherent(dev, cell_get_iommu_table(dev),
@@ -586,7 +586,7 @@ static void *dma_fixed_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_fixed_free_coherent(struct device *dev, size_t size,
 				    void *vaddr, dma_addr_t dma_handle,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	if (iommu_fixed_is_weak)
 		iommu_free_coherent(cell_get_iommu_table(dev), size, vaddr,
@@ -598,7 +598,7 @@ static void dma_fixed_free_coherent(struct device *dev, size_t size,
 static dma_addr_t dma_fixed_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
 		return dma_direct_ops.map_page(dev, page, offset, size,
@@ -611,7 +611,7 @@ static dma_addr_t dma_fixed_map_page(struct device *dev, struct page *page,
 
 static void dma_fixed_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
 		dma_direct_ops.unmap_page(dev, dma_addr, size, direction,
@@ -623,7 +623,7 @@ static void dma_fixed_unmap_page(struct device *dev, dma_addr_t dma_addr,
 
 static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
 			   int nents, enum dma_data_direction direction,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
 		return dma_direct_ops.map_sg(dev, sg, nents, direction, attrs);
@@ -635,7 +635,7 @@ static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
 
 static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nents, enum dma_data_direction direction,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
 		dma_direct_ops.unmap_sg(dev, sg, nents, direction, attrs);
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index c929644e74a6..efab5568cfef 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -88,7 +88,7 @@ static int iommu_table_iobmap_inited;
 static int iobmap_build(struct iommu_table *tbl, long index,
 			 long npages, unsigned long uaddr,
 			 enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	u32 *ip;
 	u32 rpn;
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 0459e100b4e7..bba4c53aaea7 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(pnv_pci_get_npu_dev);
 
 static void *dma_npu_alloc(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	NPU_DMA_OP_UNSUPPORTED();
 	return NULL;
@@ -81,7 +81,7 @@ static void *dma_npu_alloc(struct device *dev, size_t size,
 
 static void dma_npu_free(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	NPU_DMA_OP_UNSUPPORTED();
 }
@@ -89,7 +89,7 @@ static void dma_npu_free(struct device *dev, size_t size,
 static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction direction,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	NPU_DMA_OP_UNSUPPORTED();
 	return 0;
@@ -97,7 +97,7 @@ static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
 
 static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
 			  int nelems, enum dma_data_direction direction,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	NPU_DMA_OP_UNSUPPORTED();
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3a5ea8236db8..40ef7e21439d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1783,7 +1783,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 		long npages, unsigned long uaddr,
 		enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
 			attrs);
@@ -1912,7 +1912,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
 		long npages, unsigned long uaddr,
 		enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
 			attrs);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1d92bd93bcd9..bb16ebbfca77 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -587,7 +587,7 @@ static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
 
 int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	u64 proto_tce = iommu_direction_to_tce_perm(direction);
 	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 7dee25e304db..9db1d1ab2549 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -178,7 +178,7 @@ struct pnv_phb {
 extern struct pci_ops pnv_pci_ops;
 extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
-		struct dma_attrs *attrs);
+		unsigned long attrs);
 extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
 extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction);
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 5606fe36faf2..8af1c15aef85 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -516,7 +516,7 @@ core_initcall(ps3_system_bus_init);
  */
 static void * ps3_alloc_coherent(struct device *_dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t flag,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	int result;
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
@@ -553,7 +553,7 @@ clean_none:
 }
 
 static void ps3_free_coherent(struct device *_dev, size_t size, void *vaddr,
-			      dma_addr_t dma_handle, struct dma_attrs *attrs)
+			      dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 
@@ -569,7 +569,7 @@ static void ps3_free_coherent(struct device *_dev, size_t size, void *vaddr,
 
 static dma_addr_t ps3_sb_map_page(struct device *_dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -592,7 +592,7 @@ static dma_addr_t ps3_sb_map_page(struct device *_dev, struct page *page,
 static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 				    unsigned long offset, size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -626,7 +626,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 }
 
 static void ps3_unmap_page(struct device *_dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
+	size_t size, enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -640,7 +640,7 @@ static void ps3_unmap_page(struct device *_dev, dma_addr_t dma_addr,
 }
 
 static int ps3_sb_map_sg(struct device *_dev, struct scatterlist *sgl,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
+	int nents, enum dma_data_direction direction, unsigned long attrs)
 {
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
@@ -670,14 +670,14 @@ static int ps3_sb_map_sg(struct device *_dev, struct scatterlist *sgl,
 static int ps3_ioc0_map_sg(struct device *_dev, struct scatterlist *sg,
 			   int nents,
 			   enum dma_data_direction direction,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	BUG();
 	return 0;
 }
 
 static void ps3_sb_unmap_sg(struct device *_dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
+	int nents, enum dma_data_direction direction, unsigned long attrs)
 {
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
@@ -686,7 +686,7 @@ static void ps3_sb_unmap_sg(struct device *_dev, struct scatterlist *sg,
 
 static void ps3_ioc0_unmap_sg(struct device *_dev, struct scatterlist *sg,
 			    int nents, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	BUG();
 }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index b7dfc1359d01..b52e61b840a6 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -152,7 +152,7 @@ static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
 static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
 			      enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	u64 proto_tce;
 	__be64 *tcep, *tces;
@@ -208,7 +208,7 @@ static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
 static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
 				enum dma_data_direction direction,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	u64 rc = 0;
 	u64 proto_tce, tce;
@@ -251,7 +251,7 @@ static DEFINE_PER_CPU(__be64 *, tce_page);
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	u64 rc = 0;
 	u64 proto_tce;
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index b7348637eae0..9c24f8e6246e 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -163,7 +163,7 @@ static void dart_flush(struct iommu_table *tbl)
 static int dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
 		       enum dma_data_direction direction,
-		       struct dma_attrs *attrs)
+		       unsigned long attrs)
 {
 	unsigned int *dp;
 	unsigned int rpn;
-- 
1.9.1
