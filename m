Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:49:53 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18491 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041757AbcFBPlzSSi02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:55 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500AFFI9RVM10@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:52 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-9e-575053bf0956
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id B1.6A.05254.FB350575; Thu,
 2 Jun 2016 16:41:51 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:51 +0100 (BST)
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
Subject: [RFC v3 28/45] ia64: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:30 +0200
Message-id: <1464881987-13203-29-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTZxT3u999gety06F+U2dM4xZnMhQ05sQZ3Cvxbslm45aQEIPr9IYS
        oWJLiY/9UWDgRMBLGaIUEaEICLQUMgWXrnIxdOpQmm4gCmJAVKYrhQxGANla2P77vc4jJ4fH
        6kfMaj7ZkC4ZDboUDRtJ31nw+t/zfKmN39Jn4+FU+xwH3mYLCwV3b1FQ7mxk4ZW1iwPXOScD
        wawcDPYsPfhKc2gYv5yPoLbucxiafIggkDVHw8KfLzH8NjXOQlF9MYbTjmEOcs9+COXPuhE8
        feCmwD4WBx33pzm4I1dRcNa1CmamskOFt10YKj3vQ6DiOYYhxxUGnillGMr7Y2H+fJCCU7Zm
        Dl48j4HL1aMIRuUBFgKDNxGUeQZpaBnpZaDI083BTZtMQV2DA8OlXDsNvxQGGRj/ro2F4PcB
        BvzXy1mofdKEIb/5xxDN9oW3OkmDXGLlwGY/Q8Pw7R4Kuiu8LDxVCmiYfPwPBvlSNoZz934O
        3WP+Bww5A00U1Hc3caCUuBHM/b3AfJAgPumooMQct8yKjRWNSPT3+rA4N2tFYp9DK74olkNS
        YQEldgwrrFg1ZqHF9rJBTgxOJIqVLWbRVtKLxPz2X5HYWrdJuz0hcudBKSU5QzJujvs6Uv9H
        n8KmVe86etUfoCyoKzYPRfBE2EbOX+3nlvBK0vPIyeahSF4t1CBSs1DwH8mkyEzbT0w4xQpb
        SWutfdGIElyEWEZ8OGxg4Vsy5p1FYfyG8Blp67ewYUwLbxOrO28xoxJE4sntxEvj1pFbXcWL
        TSNCut1ZT4exWthNfNmtjIxUlWjZFbRCMh9IM32TlBoTbdKlmsyGpOgDh1Nb0NLX/dWGqrt2
        KEjgkeY1Vd27e+LVjC7DdCxVQYTHmihV+l5tvFp1UHfsuGQ8vN9oTpFMClrD05pVqgvXx79S
        C0m6dOmQJKVJxv9dio9YbUGl7tl9WRu++LjPulbx9y4rTq9Jcn1yZM2bhoYTUWeIsXSo9dpb
        K6Mn9id+dHGnzFzcy01l5mlGE47k35jcve71WKzXN1id6x9c6/Fu3PUycQuZX6t9p6WKnByJ
        E4JFCa7l3OnOVw706fKmE9MZyb9PHtrWMbB5+l5m58yEGRWu32HQ0Ca9LmYTNpp0/wLBhlF4
        cQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53752
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
 arch/ia64/hp/common/sba_iommu.c | 22 +++++++++++-----------
 arch/ia64/include/asm/machvec.h |  1 -
 arch/ia64/kernel/pci-swiotlb.c  |  4 ++--
 arch/ia64/sn/pci/pci_dma.c      | 12 ++++++------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index a6d6190c9d24..630ee8073899 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -919,7 +919,7 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 			       unsigned long poff, size_t size,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct ioc *ioc;
 	void *addr = page_address(page) + poff;
@@ -1005,7 +1005,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 
 static dma_addr_t sba_map_single_attrs(struct device *dev, void *addr,
 				       size_t size, enum dma_data_direction dir,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	return sba_map_page(dev, virt_to_page(addr),
 			    (unsigned long)addr & ~PAGE_MASK, size, dir, attrs);
@@ -1046,7 +1046,7 @@ sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
  * See Documentation/DMA-API-HOWTO.txt
  */
 static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
-			   enum dma_data_direction dir, struct dma_attrs *attrs)
+			   enum dma_data_direction dir, unsigned long attrs)
 {
 	struct ioc *ioc;
 #if DELAYED_RESOURCE_CNT > 0
@@ -1115,7 +1115,7 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 }
 
 void sba_unmap_single_attrs(struct device *dev, dma_addr_t iova, size_t size,
-			    enum dma_data_direction dir, struct dma_attrs *attrs)
+			    enum dma_data_direction dir, unsigned long attrs)
 {
 	sba_unmap_page(dev, iova, size, dir, attrs);
 }
@@ -1130,7 +1130,7 @@ void sba_unmap_single_attrs(struct device *dev, dma_addr_t iova, size_t size,
  */
 static void *
 sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		   gfp_t flags, struct dma_attrs *attrs)
+		   gfp_t flags, unsigned long attrs)
 {
 	struct ioc *ioc;
 	void *addr;
@@ -1175,7 +1175,7 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * device to map single to get an iova mapping.
 	 */
 	*dma_handle = sba_map_single_attrs(&ioc->sac_only_dev->dev, addr,
-					   size, 0, NULL);
+					   size, 0, 0);
 
 	return addr;
 }
@@ -1191,9 +1191,9 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
  * See Documentation/DMA-API-HOWTO.txt
  */
 static void sba_free_coherent(struct device *dev, size_t size, void *vaddr,
-			      dma_addr_t dma_handle, struct dma_attrs *attrs)
+			      dma_addr_t dma_handle, unsigned long attrs)
 {
-	sba_unmap_single_attrs(dev, dma_handle, size, 0, NULL);
+	sba_unmap_single_attrs(dev, dma_handle, size, 0, 0);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -1442,7 +1442,7 @@ sba_coalesce_chunks(struct ioc *ioc, struct device *dev,
 
 static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 /**
  * sba_map_sg - map Scatter/Gather list
  * @dev: instance of PCI owned by the driver that's asking.
@@ -1455,7 +1455,7 @@ static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
  */
 static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			    int nents, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -1551,7 +1551,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
  */
 static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 #ifdef ASSERT_PDIR_SANITY
 	struct ioc *ioc;
diff --git a/arch/ia64/include/asm/machvec.h b/arch/ia64/include/asm/machvec.h
index 9c39bdfc2da8..ed7f09089f12 100644
--- a/arch/ia64/include/asm/machvec.h
+++ b/arch/ia64/include/asm/machvec.h
@@ -22,7 +22,6 @@ struct pci_bus;
 struct task_struct;
 struct pci_dev;
 struct msi_desc;
-struct dma_attrs;
 
 typedef void ia64_mv_setup_t (char **);
 typedef void ia64_mv_cpu_init_t (void);
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 939260aeac98..2933208c0285 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -16,7 +16,7 @@ EXPORT_SYMBOL(swiotlb);
 
 static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	if (dev->coherent_dma_mask != DMA_BIT_MASK(64))
 		gfp |= GFP_DMA;
@@ -25,7 +25,7 @@ static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 static void ia64_swiotlb_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_addr,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 8f59907007cb..6b78fc953c4b 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -77,7 +77,7 @@ EXPORT_SYMBOL(sn_dma_set_mask);
  */
 static void *sn_dma_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t * dma_handle, gfp_t flags,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	void *cpuaddr;
 	unsigned long phys_addr;
@@ -138,7 +138,7 @@ static void *sn_dma_alloc_coherent(struct device *dev, size_t size,
  * any associated IOMMU mappings.
  */
 static void sn_dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-				 dma_addr_t dma_handle, struct dma_attrs *attrs)
+				 dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -176,7 +176,7 @@ static void sn_dma_free_coherent(struct device *dev, size_t size, void *cpu_addr
 static dma_addr_t sn_dma_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t size,
 				  enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	void *cpu_addr = page_address(page) + offset;
 	dma_addr_t dma_addr;
@@ -218,7 +218,7 @@ static dma_addr_t sn_dma_map_page(struct device *dev, struct page *page,
  */
 static void sn_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 			      size_t size, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -240,7 +240,7 @@ static void sn_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
  */
 static void sn_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
 			    int nhwentries, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	int i;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -273,7 +273,7 @@ static void sn_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
  */
 static int sn_dma_map_sg(struct device *dev, struct scatterlist *sgl,
 			 int nhwentries, enum dma_data_direction dir,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	unsigned long phys_addr;
 	struct scatterlist *saved_sg = sgl, *sg;
-- 
1.9.1
