Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 12:14:36 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:12805 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27035601AbcFJKOcweRbZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 12:14:32 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8J006BIWG08750@mailout4.w1.samsung.com>; Fri,
 10 Jun 2016 11:14:25 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-56-575a9300b16f
Received: from eusync4.samsung.com ( [203.254.199.214])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id C9.B3.04866.0039A575; Fri,
 10 Jun 2016 11:14:24 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O8J00MI3WC5KUB0@eusync4.samsung.com>; Fri,
 10 Jun 2016 11:14:24 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Yao <mark.yao@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <joro@8bytes.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Rabin Vincent <rabin@rab.in>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Smith <alex.smith@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Subject: [PATCH v4 43/44] dma-mapping: Remove dma_get_attr
Date:   Fri, 10 Jun 2016 12:12:00 +0200
Message-id: <1465553521-27303-44-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG/Z/zP+e0ZM3OCttOXLYlzS6JN+ZueeOGkezD/h8W54dlKDNz
        BzgrZtzSA4iLJgVFC3QMUMaopqEIE2uFDmFgrRSaDkVgYWV00a06aqdysbRsXCbDrpXs2y/P
        ++R53jd5FbTaz6xX7M8rlHR5Yo6GTcDDj676Nq87kZ722lDzK3Bk4k8OliavM/DVT0MUTPcb
        EJzusLHgNDSw0GUIs7DkMjGwWjfIwfffdjAQLiunoaGtB8Pcd0YEwf7jCG7P/4bgl4U5Fqra
        Axwc+yYVhmuaKYgGZhhYXjiCocn1DoTM92lYnLTE/O1WBv5tDFNQccrOQejqZQwz97fCaNks
        B513fAxYjrVgCBtCDIw7TrNgtHczcPfmcQw19XUcBK6PUTD/R5SG8t8vUOCuvxJbxDJCwcrS
        IwYuePwc9J7sp+D2ci0H94au0HD+bgn0tvbFpOod0KV3s2DznOHg5IN/OIh4Q7Fj6qMYvM6X
        YCAcZOB8+z6oXW6KpT6cZ2F27BaGU6XVCNzdAQxTkWt4RyoJDpgpUu5dZYnNbENk3PczTVYe
        1iEyEHCzpHlKj8mPrixyyeTnSDjyKTnqecAQ46URRC62bSBnnFMUMc4eZUintYLdtSk94d0s
        KWd/saRL3v5ZQrar5xwqmDyLSlx+pR6NVKBKpFAI/JtCl12uRMoYPiOM3epg46zmW5EQ8n5Y
        iRJiXEoJE5EIjg9Y/g3h4tmWx6YkfrNgveeg40zzlkQhelmMcyK/Tfg78NfjfMy/LPxwLiUu
        q3giBLpd1FrXC8LQ4AkmzsqYXuVvxGu97ws9wWmqBqma0DoreloqyiyQM7S5r2+RxVy5KE+7
        JTM/txOtPd1CL2od3OZGvAJpnlDtduxJUzNisXww140EBa1JUkF1eppalSUe/FLS5e/TFeVI
        shs9p8CaZ1WNjrmP1LxWLJS+kKQCSff/lFIo1+tRQ+cnykKPyXH48/TD+iRc64zuXN1u2JT1
        4vMH3kpOSbX2PGW+sWTeKWr3/rrHbpp47+PUxZmqvFc3elLuLBYn7+0rknXDT2qzM1actl0F
        G8tKzJnO5QbjyKG2sql8S2l18MZ0ccahlmbhg/GvfYZR+80DXmRQOt9OHO0r9F0bTTJpsJwt
        bt1A62TxP6vv7wZwAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54014
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

After switching DMA attributes to unsigned long it is easier to just
compare the bits.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[for avr32]
Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
---
 Documentation/DMA-API.txt                      |  4 +--
 arch/arc/mm/dma.c                              |  4 +--
 arch/arm/mm/dma-mapping.c                      | 36 ++++++++++++--------------
 arch/arm/xen/mm.c                              |  4 +--
 arch/arm64/mm/dma-mapping.c                    | 10 +++----
 arch/avr32/mm/dma-coherent.c                   |  4 +--
 arch/ia64/sn/pci/pci_dma.c                     | 10 ++-----
 arch/metag/kernel/dma.c                        |  2 +-
 arch/mips/mm/dma-default.c                     |  6 ++---
 arch/openrisc/kernel/dma.c                     |  4 +--
 arch/parisc/kernel/pci-dma.c                   |  2 +-
 arch/powerpc/platforms/cell/iommu.c            | 12 ++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c    |  2 +-
 drivers/iommu/dma-iommu.c                      |  2 +-
 drivers/media/v4l2-core/videobuf2-dma-contig.c |  2 +-
 include/linux/dma-mapping.h                    | 10 -------
 16 files changed, 47 insertions(+), 67 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 24f9688bb98a..1d26eeb6b5f6 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -422,9 +422,7 @@ void whizco_dma_map_sg_attrs(struct device *dev, dma_addr_t dma_addr,
 			     unsigned long attrs)
 {
 	....
-	int foo =  dma_get_attr(DMA_ATTR_FOO, attrs);
-	....
-	if (foo)
+	if (attrs & DMA_ATTR_FOO)
 		/* twizzle the frobnozzle */
 	....
 
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 3d1f467d1792..74bbe68dce9d 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -46,7 +46,7 @@ static void *arc_dma_alloc(struct device *dev, size_t size,
 	 *   (vs. always going to memory - thus are faster)
 	 */
 	if ((is_isa_arcv2() && ioc_exists) ||
-	    dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs))
+	    (attrs & DMA_ATTR_NON_CONSISTENT))
 		need_coh = 0;
 
 	/*
@@ -95,7 +95,7 @@ static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
 	struct page *page = virt_to_page(dma_handle);
 	int is_non_coh = 1;
 
-	is_non_coh = dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs) ||
+	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT) ||
 			(is_isa_arcv2() && ioc_exists);
 
 	if (PageHighMem(page) || !is_non_coh)
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ebb3fde99043..43e03b5293d0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -126,7 +126,7 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     unsigned long attrs)
 {
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_cpu_to_dev(page, offset, size, dir);
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
@@ -155,7 +155,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
 static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
 				      handle & ~PAGE_MASK, size, dir);
 }
@@ -622,9 +622,9 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 
 static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
 {
-	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
-			    pgprot_writecombine(prot) :
-			    pgprot_dmacoherent(prot);
+	prot = (attrs & DMA_ATTR_WRITE_COMBINE) ?
+			pgprot_writecombine(prot) :
+			pgprot_dmacoherent(prot);
 	return prot;
 }
 
@@ -744,7 +744,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		.gfp = gfp,
 		.prot = prot,
 		.caller = caller,
-		.want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs),
+		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0),
 	};
 
 #ifdef CONFIG_DMA_API_DEBUG
@@ -887,7 +887,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		.size = PAGE_ALIGN(size),
 		.cpu_addr = cpu_addr,
 		.page = page,
-		.want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs),
+		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0),
 	};
 
 	buf = arm_dma_buffer_find(cpu_addr);
@@ -1267,7 +1267,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	if (!pages)
 		return NULL;
 
-	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs))
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
 	{
 		unsigned long order = get_order(size);
 		struct page *page;
@@ -1285,7 +1285,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	}
 
 	/* Go straight to 4K chunks if caller says it's OK. */
-	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
+	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
 		order_idx = ARRAY_SIZE(iommu_order_array) - 1;
 
 	/*
@@ -1346,7 +1346,7 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
 	int count = size >> PAGE_SHIFT;
 	int i;
 
-	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		dma_release_from_contiguous(dev, pages[0], count);
 	} else {
 		for (i = 0; i < count; i++)
@@ -1445,7 +1445,7 @@ static struct page **__iommu_get_pages(void *cpu_addr, unsigned long attrs)
 	if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
 		return __atomic_get_pages(cpu_addr);
 
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return cpu_addr;
 
 	area = find_vm_area(cpu_addr);
@@ -1512,7 +1512,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (*handle == DMA_ERROR_CODE)
 		goto err_buffer;
 
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return pages;
 
 	addr = __iommu_alloc_remap(pages, size, gfp, prot,
@@ -1583,7 +1583,7 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0) {
 		dma_common_free_remap(cpu_addr, size,
 			VM_ARM_DMA_CONSISTENT | VM_USERMAP);
 	}
@@ -1653,8 +1653,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		phys_addr_t phys = page_to_phys(sg_page(s));
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
-		if (!is_coherent &&
-			!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 
 		prot = __dma_direction_to_prot(dir);
@@ -1767,8 +1766,7 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
 		if (sg_dma_len(s))
 			__iommu_remove_mapping(dev, sg_dma_address(s),
 					       sg_dma_len(s));
-		if (!is_coherent &&
-		    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 			__dma_page_dev_to_cpu(sg_page(s), s->offset,
 					      s->length, dir);
 	}
@@ -1892,7 +1890,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     unsigned long attrs)
 {
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_cpu_to_dev(page, offset, size, dir);
 
 	return arm_coherent_iommu_map_page(dev, page, offset, size, dir, attrs);
@@ -1943,7 +1941,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_dev_to_cpu(page, offset, size, dir);
 
 	iommu_unmap(mapping->domain, iova, len);
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index fc67ed236a10..d062f08f5020 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -102,7 +102,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
 {
 	if (is_device_dma_coherent(hwdev))
 		return;
-	if (dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return;
 
 	__xen_dma_page_cpu_to_dev(hwdev, dev_addr, size, dir);
@@ -115,7 +115,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 {
 	if (is_device_dma_coherent(hwdev))
 		return;
-	if (dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return;
 
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a7686028dfeb..06c068ca3541 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -32,7 +32,7 @@
 static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
 {
-	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
+	if (!coherent || (attrs & DMA_ATTR_WRITE_COMBINE))
 		return pgprot_writecombine(prot);
 	return prot;
 }
@@ -702,7 +702,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
 	if (!iommu_dma_mapping_error(dev, dev_addr) &&
-	    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
 
 	return dev_addr;
@@ -712,7 +712,7 @@ static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
 			       unsigned long attrs)
 {
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
 
 	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
@@ -752,7 +752,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 {
 	bool coherent = is_device_dma_coherent(dev);
 
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
 
 	return iommu_dma_map_sg(dev, sgl, nelems,
@@ -764,7 +764,7 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
 
 	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
diff --git a/arch/avr32/mm/dma-coherent.c b/arch/avr32/mm/dma-coherent.c
index fc51f4421933..58610d0df7ed 100644
--- a/arch/avr32/mm/dma-coherent.c
+++ b/arch/avr32/mm/dma-coherent.c
@@ -109,7 +109,7 @@ static void *avr32_dma_alloc(struct device *dev, size_t size,
 		return NULL;
 	phys = page_to_phys(page);
 
-	if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs)) {
+	if (attrs & DMA_ATTR_WRITE_COMBINE) {
 		/* Now, map the page into P3 with write-combining turned on */
 		*handle = phys;
 		return __ioremap(phys, size, _PAGE_BUFFER);
@@ -123,7 +123,7 @@ static void avr32_dma_free(struct device *dev, size_t size,
 {
 	struct page *page;
 
-	if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs)) {
+	if (attrs & DMA_ATTR_WRITE_COMBINE) {
 		iounmap(cpu_addr);
 
 		page = phys_to_page(handle);
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 6b78fc953c4b..74c934a997bb 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -183,14 +183,11 @@ static dma_addr_t sn_dma_map_page(struct device *dev, struct page *page,
 	unsigned long phys_addr;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
-	int dmabarr;
-
-	dmabarr = dma_get_attr(DMA_ATTR_WRITE_BARRIER, attrs);
 
 	BUG_ON(!dev_is_pci(dev));
 
 	phys_addr = __pa(cpu_addr);
-	if (dmabarr)
+	if (attrs & DMA_ATTR_WRITE_BARRIER)
 		dma_addr = provider->dma_map_consistent(pdev, phys_addr,
 							size, SN_DMA_ADDR_PHYS);
 	else
@@ -280,9 +277,6 @@ static int sn_dma_map_sg(struct device *dev, struct scatterlist *sgl,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
 	int i;
-	int dmabarr;
-
-	dmabarr = dma_get_attr(DMA_ATTR_WRITE_BARRIER, attrs);
 
 	BUG_ON(!dev_is_pci(dev));
 
@@ -292,7 +286,7 @@ static int sn_dma_map_sg(struct device *dev, struct scatterlist *sgl,
 	for_each_sg(sgl, sg, nhwentries, i) {
 		dma_addr_t dma_addr;
 		phys_addr = SG_ENT_PHYS_ADDRESS(sg);
-		if (dmabarr)
+		if (attrs & DMA_ATTR_WRITE_BARRIER)
 			dma_addr = provider->dma_map_consistent(pdev,
 								phys_addr,
 								sg->length,
diff --git a/arch/metag/kernel/dma.c b/arch/metag/kernel/dma.c
index d68f498e82a1..0db31e24c541 100644
--- a/arch/metag/kernel/dma.c
+++ b/arch/metag/kernel/dma.c
@@ -337,7 +337,7 @@ static int metag_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	struct metag_vm_region *c;
 	int ret = -ENXIO;
 
-	if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
+	if (attrs & DMA_ATTR_WRITE_COMBINE)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 0ed9000dc1ff..b2eadd6fa9a1 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -141,7 +141,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	 * XXX: seems like the coherent and non-coherent implementations could
 	 * be consolidated.
 	 */
-	if (dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs))
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
 		return mips_dma_alloc_noncoherent(dev, size, dma_handle, gfp);
 
 	gfp = massage_gfp_flags(dev, gfp);
@@ -182,7 +182,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page *page = NULL;
 
-	if (dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs)) {
+	if (attrs & DMA_ATTR_NON_CONSISTENT) {
 		mips_dma_free_noncoherent(dev, size, vaddr, dma_handle);
 		return;
 	}
@@ -214,7 +214,7 @@ static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	pfn = page_to_pfn(virt_to_page((void *)addr));
 
-	if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
+	if (attrs & DMA_ATTR_WRITE_COMBINE)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 50eb1f26c540..140c99140649 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -100,7 +100,7 @@ or1k_dma_alloc(struct device *dev, size_t size,
 
 	va = (unsigned long)page;
 
-	if (!dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs)) {
+	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
 		/*
 		 * We need to iterate through the pages, clearing the dcache for
 		 * them and setting the cache-inhibit bit.
@@ -124,7 +124,7 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 		.mm = &init_mm
 	};
 
-	if (!dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs)) {
+	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
 		/* walk_page_range shouldn't be able to fail here */
 		WARN_ON(walk_page_range(va, va + size, &walk));
 	}
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 845fdd52e4c5..02d9ed0f3949 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -581,7 +581,7 @@ static void *pcx_dma_alloc(struct device *dev, size_t size,
 {
 	void *addr;
 
-	if (!dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs))
+	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0)
 		return NULL;
 
 	addr = (void *)__get_free_pages(flag, get_order(size));
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index c8e11e020335..6128bdb428b2 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -193,7 +193,7 @@ static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 	base_pte = CBE_IOPTE_PP_W | CBE_IOPTE_PP_R | CBE_IOPTE_M |
 		CBE_IOPTE_SO_RW | (window->ioid & CBE_IOPTE_IOID_Mask);
 #endif
-	if (unlikely(dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs)))
+	if (unlikely(attrs & DMA_ATTR_WEAK_ORDERING))
 		base_pte &= ~CBE_IOPTE_SO_RW;
 
 	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
@@ -600,7 +600,7 @@ static dma_addr_t dma_fixed_map_page(struct device *dev, struct page *page,
 				     enum dma_data_direction direction,
 				     unsigned long attrs)
 {
-	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
 		return dma_direct_ops.map_page(dev, page, offset, size,
 					       direction, attrs);
 	else
@@ -613,7 +613,7 @@ static void dma_fixed_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
 				 unsigned long attrs)
 {
-	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
 		dma_direct_ops.unmap_page(dev, dma_addr, size, direction,
 					  attrs);
 	else
@@ -625,7 +625,7 @@ static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
 			   int nents, enum dma_data_direction direction,
 			   unsigned long attrs)
 {
-	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
 		return dma_direct_ops.map_sg(dev, sg, nents, direction, attrs);
 	else
 		return ppc_iommu_map_sg(dev, cell_get_iommu_table(dev), sg,
@@ -637,7 +637,7 @@ static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nents, enum dma_data_direction direction,
 			       unsigned long attrs)
 {
-	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
 		dma_direct_ops.unmap_sg(dev, sg, nents, direction, attrs);
 	else
 		ppc_iommu_unmap_sg(cell_get_iommu_table(dev), sg, nents,
@@ -1162,7 +1162,7 @@ static int __init setup_iommu_fixed(char *str)
 	pciep = of_find_node_by_type(NULL, "pcie-endpoint");
 
 	if (strcmp(str, "weak") == 0 || (pciep && strcmp(str, "strong") != 0))
-		iommu_fixed_is_weak = 1;
+		iommu_fixed_is_weak = DMA_ATTR_WEAK_ORDERING;
 
 	of_node_put(pciep);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 7b1788e2a808..4a28d6348c76 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -273,7 +273,7 @@ void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, rk_obj->dma_attrs))
+	if (rk_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return NULL;
 
 	return rk_obj->kvaddr;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6c1bda504fb1..08a1e2f3690f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -306,7 +306,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	} else {
 		size = ALIGN(size, min_size);
 	}
-	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
+	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
 		alloc_sizes = min_size;
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
index 36cb488dc737..7073e7ee9296 100644
--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
@@ -160,7 +160,7 @@ static void *vb2_dc_alloc(void *alloc_ctx, unsigned long size,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, buf->attrs))
+	if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
 		buf->vaddr = buf->cookie;
 
 	/* Prevent the device from being released while the buffer is used */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1fd9860487b1..d8fb67783cb7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -101,16 +101,6 @@ static inline int is_device_dma_capable(struct device *dev)
 	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
 }
 
-/**
- * dma_get_attr - check for a specific attribute
- * @attr: attribute to look for
- * @attrs: attributes to check within
- */
-static inline bool dma_get_attr(unsigned long attr, unsigned long attrs)
-{
-	return !!(attr & attrs);
-}
-
 #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 /*
  * These three functions are only for dma allocator.
-- 
1.9.1
