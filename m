Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 07:52:35 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:7968 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012910AbbBQGweEBTNT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Feb 2015 07:52:34 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 16 Feb 2015 22:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,593,1418112000"; 
   d="scan'208";a="455570373"
Received: from wxmubuntu.sh.intel.com ([10.239.154.16])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2015 22:37:22 -0800
From:   Wang Xiaoming <xiaoming.wang@intel.com>
To:     ralf@linux-mips.org, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, david.vrabel@citrix.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, akpm@linux-foundation.org,
        linux@horizon.com, lauraa@codeaurora.org,
        heiko.carstens@de.ibm.com, d.kasatkin@samsung.com,
        takahiro.akashi@linaro.org, chris@chris-wilson.co.uk,
        pebolle@tiscali.nl
Cc:     Wang Xiaoming <xiaoming.wang@intel.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        Zhang Dongxing <dongxing.zhang@intel.com>
Subject: [PATCH v4] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-IOMMU.
Date:   Tue, 17 Feb 2015 14:51:43 +0800
Message-Id: <1424155903-4262-1-git-send-email-xiaoming.wang@intel.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <xiaoming.wang@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiaoming.wang@intel.com
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

The maximum of SW-IOMMU is limited to 2^11*128 = 256K.
And the size of IO_TLB_DEFAULT_SIZE is limited to (64UL<<20) 64M.
While in different platform and different requirement this seems improper.
So modifing the IO_TLB_SEGSIZE to io_tlb_segsize and IO_TLB_DEFAULT_SIZE
to io_tlb_default_size which can configure by kernel cmdline.
This can meet different requirement.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Zhang Dongxing <dongxing.zhang@intel.com>
Signed-off-by: Wang Xiaoming <xiaoming.wang@intel.com>
---
patch v1 make this change at Kconfig
which needs to edit the .config manually.
https://lkml.org/lkml/2015/1/25/571

patch v2 only change IO_TLB_SEGSIZE configurable
https://lkml.org/lkml/2015/2/5/812

patch v3 parsing io_tlb_segsize and 
io_tlb_default_size independently
https://lkml.org/lkml/2015/2/15/217

 Documentation/kernel-parameters.txt  |    4 ++-
 arch/mips/cavium-octeon/dma-octeon.c |    2 +-
 arch/mips/netlogic/common/nlm-dma.c  |    2 +-
 drivers/xen/swiotlb-xen.c            |    6 ++--
 include/linux/swiotlb.h              |    8 +----
 lib/swiotlb.c                        |   57 ++++++++++++++++++++++++----------
 6 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4df73da..dd03ff0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3438,10 +3438,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			it if 0 is given (See Documentation/cgroups/memory.txt)
 
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
-			Format: { <int> | force }
+			Format: { <int> | force | <int> | <int>}
 			<int> -- Number of I/O TLB slabs
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
+			<int> -- Maximum allowable number of contiguous slabs to map
+			<int> -- The size of SW-MMU mapped.
 
 	switches=	[HW,M68k]
 
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 3778655..a521af6 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -312,7 +312,7 @@ void __init plat_swiotlb_setup(void)
 		swiotlbsize = 64 * (1<<20);
 #endif
 	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
-	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
+	swiotlb_nslabs = ALIGN(swiotlb_nslabs, io_tlb_segsize);
 	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
 
 	octeon_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index f3d4ae8..eeffa8f 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -99,7 +99,7 @@ void __init plat_swiotlb_setup(void)
 
 	swiotlbsize = 1 << 20; /* 1 MB for now */
 	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
-	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
+	swiotlb_nslabs = ALIGN(swiotlb_nslabs, io_tlb_segsize);
 	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
 
 	nlm_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 810ad41..3b3e9fe 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -164,11 +164,11 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 	dma_addr_t dma_handle;
 	phys_addr_t p = virt_to_phys(buf);
 
-	dma_bits = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT) + PAGE_SHIFT;
+	dma_bits = get_order(io_tlb_segsize << IO_TLB_SHIFT) + PAGE_SHIFT;
 
 	i = 0;
 	do {
-		int slabs = min(nslabs - i, (unsigned long)IO_TLB_SEGSIZE);
+		int slabs = min(nslabs - i, (unsigned long)io_tlb_segsize);
 
 		do {
 			rc = xen_create_contiguous_region(
@@ -187,7 +187,7 @@ static unsigned long xen_set_nslabs(unsigned long nr_tbl)
 {
 	if (!nr_tbl) {
 		xen_io_tlb_nslabs = (64 * 1024 * 1024 >> IO_TLB_SHIFT);
-		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, IO_TLB_SEGSIZE);
+		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, io_tlb_segsize);
 	} else
 		xen_io_tlb_nslabs = nr_tbl;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index e7a018e..13506db 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -8,13 +8,7 @@ struct dma_attrs;
 struct scatterlist;
 
 extern int swiotlb_force;
-
-/*
- * Maximum allowable number of contiguous slabs to map,
- * must be a power of 2.  What is the appropriate value ?
- * The complexity of {map,unmap}_single is linearly dependent on this value.
- */
-#define IO_TLB_SEGSIZE	128
+extern int io_tlb_segsize;
 
 /*
  * log of the size of each IO TLB slab.  The number of slabs is command line
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 4abda07..999414c 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -56,6 +56,22 @@
 int swiotlb_force;
 
 /*
+ * default to 128
+ * Maximum allowable number of contiguous slabs to map,
+ * must be a power of 2.  What is the appropriate value ?
+ * define io_tlb_segsize as a parameter
+ * which can be changed dynamically in config file for special usage.
+ * The complexity of {map,unmap}_single is linearly dependent on this value.
+ */
+int io_tlb_segsize = 128;
+
+/* default to 64MB 
+ * define io_tlb_default_size as a parameter
+ * which can be changed dynamically in config file for special usage.
+ */
+static unsigned long io_tlb_default_size = (64UL<<20);
+
+/*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
  * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
  * API.
@@ -101,13 +117,23 @@ setup_io_tlb_npages(char *str)
 {
 	if (isdigit(*str)) {
 		io_tlb_nslabs = simple_strtoul(str, &str, 0);
-		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+		/* avoid tail segment of size < io_tlb_segsize */
+		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
 	}
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force"))
+	if (!strncmp(str, "force", 5)) {
 		swiotlb_force = 1;
+		str += 5;
+	}
+	if (*str == ',')
+		++str;
+	if (isdigit(*str))
+		io_tlb_segsize = simple_strtoul(str, &str, 0);
+	if (*str == ',')
+		++str;
+	if (isdigit(*str))
+		io_tlb_default_size = simple_strtoul(str, &str, 0);
 
 	return 0;
 }
@@ -120,15 +146,13 @@ unsigned long swiotlb_nr_tbl(void)
 }
 EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
 
-/* default to 64MB */
-#define IO_TLB_DEFAULT_SIZE (64UL<<20)
 unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
 
 	size = io_tlb_nslabs << IO_TLB_SHIFT;
 
-	return size ? size : (IO_TLB_DEFAULT_SIZE);
+	return size ? size : (io_tlb_default_size);
 }
 
 /* Note that this doesn't work with highmem page */
@@ -183,7 +207,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
-	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
+	 * to find contiguous free memory regions of size up to io_tlb_segsize
 	 * between io_tlb_start and io_tlb_end.
 	 */
 	io_tlb_list = memblock_virt_alloc(
@@ -193,7 +217,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
 				PAGE_SIZE);
 	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+		io_tlb_list[i] = io_tlb_segsize - OFFSET(i, io_tlb_segsize);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	io_tlb_index = 0;
@@ -211,13 +235,12 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 void  __init
 swiotlb_init(int verbose)
 {
-	size_t default_size = IO_TLB_DEFAULT_SIZE;
 	unsigned char *vstart;
 	unsigned long bytes;
 
 	if (!io_tlb_nslabs) {
-		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+		io_tlb_nslabs = (io_tlb_default_size >> IO_TLB_SHIFT);
+		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
 	}
 
 	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
@@ -249,7 +272,7 @@ swiotlb_late_init_with_default_size(size_t default_size)
 
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
 	}
 
 	/*
@@ -308,7 +331,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
-	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
+	 * to find contiguous free memory regions of size up to io_tlb_segsize
 	 * between io_tlb_start and io_tlb_end.
 	 */
 	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
@@ -324,7 +347,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		goto cleanup4;
 
 	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+		io_tlb_list[i] = io_tlb_segsize - OFFSET(i, io_tlb_segsize);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	io_tlb_index = 0;
@@ -493,7 +516,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 
 			for (i = index; i < (int) (index + nslots); i++)
 				io_tlb_list[i] = 0;
-			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
+			for (i = index - 1; (OFFSET(i, io_tlb_segsize) != io_tlb_segsize - 1) && io_tlb_list[i]; i--)
 				io_tlb_list[i] = ++count;
 			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
 
@@ -571,7 +594,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
 	{
-		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
+		count = ((index + nslots) < ALIGN(index + 1, io_tlb_segsize) ?
 			 io_tlb_list[index + nslots] : 0);
 		/*
 		 * Step 1: return the slots to the free list, merging the
@@ -585,7 +608,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		 * Step 2: merge the returned slots with the preceding slots,
 		 * if available (non zero)
 		 */
-		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
+		for (i = index - 1; (OFFSET(i, io_tlb_segsize) != io_tlb_segsize -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
-- 
1.7.9.5
