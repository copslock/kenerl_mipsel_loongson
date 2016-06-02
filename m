Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:47:20 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15798 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041758AbcFBPlcZf-g2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:32 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500CADI92Z110@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:27 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-ad-575053a646e9
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id D9.FB.04866.6A350575; Thu,
 2 Jun 2016 16:41:26 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:26 +0100 (BST)
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
Subject: [RFC v3 20/45] xen: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:22 +0200
Message-id: <1464881987-13203-21-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHec97bqCdJxX1hAUTmxET76iRJ24jM4vZa5ZtxKkYP6idHEHH
        La0YNX6o3BSkeITBkFaGeuQm0BbGAi6MUbGVS50Vw9wGXtAqlQ2KESeWoa1k3/7P7//c8uTh
        sXqQieAPpB6SdKnaZA0bRvfOOPtXVn0dF7/GWzgP8tr8HDitBhaMN7spMFvqWfivyMGBrczC
        gC8zB4OSmQTu73NoGK8qQFBd8wXcf/4XgrFMPw0z//yN4c7kOAtna4sxnG4c5iC3dBOYn7oQ
        PPmznQLFGwudd19y0CtfpKDUtgheTWYFCntsGCo7PoSxihEM9xvrGHhqL8dg/mMtTJ/zUZBn
        snIwOhINVZc8CDzyIAtjQ10IyjuGaGh6NMDA2Q4XB10mmYKaK40YLuQqNNwo9DEwnt3Kgu/U
        GAP9V80sVD9uwFBgbQmEWe7gVidpkEuKODApZ2gY7rlFgavCycITu5GG5w/eYJAvZGEo++2X
        wD2mv8OQM9hAQa2rgQN7STsC/78zzCe7yOPOCorktMssqa+oR6R/wI2J/3URIr83xpHRYjmA
        Co0U6Ry2s+Si10CTtvIhjvgmdpPKpgxiKhlApKCtD5HmmmVxG3aFfZQgJR84LOlWx+4NS+rO
        q2PSO5ccsU7dpg1oKCIfhfKisF6c8txGs3qheOuehc1HYbxauIzErtYHVNBQCycoUX64OahZ
        YZ3YXK28SwoXbKJoeOTGQQMLx0Wv83WgE8/PF7aI17P3BzEtRIk11mkmqFUCESd+LWBnhy0W
        ux3F73hogCuWWnp21meiO6uZkZGqEoXUoQVSxr50/TeJKWtX6bUp+ozUxFX70lKa0OzPTbai
        y46NdiTwSDNXFbLiq3g1oz2sP5piRyKPNeGqmK1x8WpVgvboMUmXtkeXkSzp7eh9ntYsUp27
        Or5NLSRqD0nfSlK6pPvfpfjQCANa51WeRc0pm3vs8xchwpU5kX3IHyt3nFF6PdicEGn+2EzV
        XYukL+2467q5YPtPJ6Z+3p9qOeJoyYxf3Of4cnn+QdXepFdLjcaJkR2nStM+ffbC9AGDY0iu
        f9R5vsdmehlzfGDyhn9nuDH7znrmvdM/MFJrvefHvGjNtZZ7ypvrVVEaWp+kjV6GdXrtW9xU
        YWJvAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53744
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
 drivers/xen/swiotlb-xen.c | 14 +++++++-------
 include/xen/swiotlb-xen.h | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 7399782c0998..87e6035c9e81 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -294,7 +294,7 @@ error:
 void *
 xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	void *ret;
 	int order = get_order(size);
@@ -346,7 +346,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_alloc_coherent);
 
 void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-			  dma_addr_t dev_addr, struct dma_attrs *attrs)
+			  dma_addr_t dev_addr, unsigned long attrs)
 {
 	int order = get_order(size);
 	phys_addr_t phys;
@@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_free_coherent);
 dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
 	dma_addr_t dev_addr = xen_phys_to_bus(phys);
@@ -434,7 +434,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_map_page);
  */
 static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
 
@@ -462,7 +462,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			    size_t size, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
 }
@@ -538,7 +538,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_device);
 int
 xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			 int nelems, enum dma_data_direction dir,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -599,7 +599,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_map_sg_attrs);
 void
 xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			   int nelems, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 8b2eb93ae8ba..7c35e279d1e3 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -9,30 +9,30 @@ extern int xen_swiotlb_init(int verbose, bool early);
 extern void
 *xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flags,
-			    struct dma_attrs *attrs);
+			    unsigned long attrs);
 
 extern void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size,
 			  void *vaddr, dma_addr_t dma_handle,
-			  struct dma_attrs *attrs);
+			  unsigned long attrs);
 
 extern dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				       unsigned long offset, size_t size,
 				       enum dma_data_direction dir,
-				       struct dma_attrs *attrs);
+				       unsigned long attrs);
 
 extern void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir,
-				   struct dma_attrs *attrs);
+				   unsigned long attrs);
 extern int
 xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			 int nelems, enum dma_data_direction dir,
-			 struct dma_attrs *attrs);
+			 unsigned long attrs);
 
 extern void
 xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			   int nelems, enum dma_data_direction dir,
-			   struct dma_attrs *attrs);
+			   unsigned long attrs);
 
 extern void
 xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-- 
1.9.1
