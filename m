Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:54:14 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45553 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041803AbcFBPmiI7oV2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:38 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500GIEIAVC540@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:32 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-78-575053e7f312
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 24.5C.04866.7E350575; Thu,
 2 Jun 2016 16:42:31 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:31 +0100 (BST)
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
Subject: [RFC v3 41/45] tile: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:43 +0200
Message-id: <1464881987-13203-42-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee5z32AruxYnN2oWU2NmiKLospw4o3Mf9AmLgWwmXTBVO7kD
        x2ta6kT5UCmgQItXEF9o06BUXhwUClkUMyA0DhTGsGJQB0wCKjCFVrfOhSraSvz2///+5+Sc
        nBweK0eZ5fyhzBxJl6lNV7ERdP9C79D6qW8T1RtnZz+A4vYAB70tRhYsf9yiwNbcyMLr8h4O
        XOebGfDlF2Jw5KeC51whDd5aM4K6+t3w8MUIgrn8AA0Ls88w3PV7WTjdUIGh1DnBQdHZHWCb
        GkDw5M8OChwz26D7/n8c9MuXKDjriob//aZgY58LQ3XXFzBnn8bw0HmFgSl3FQbbg03w6oKP
        gmJrCwdPp+OgtuYxgsfyKAtzYzcQVHWN0dA6OczA6a4BDm5YZQrqf3ZiuFjkoOFmmY8Bb8E1
        Fnwn5xgYum5joe5REwZzyy9Ba/KEtjpBg1xZzoHVcYqGib7bFAzYe1l44rbQ8GL8DQb5ognD
        +cHO4D1encFQONpEQcNAEwfuyg4EgZcLzJdJ5FG3nSKFHTJLGu2NiAwNezAJzJcjcs+ZSJ5W
        yEFUZqFI94SbJZdmjDRprxrjiO/5PlLdaiDWymFEzO2/I9JWH5P4eVLE1mQp/dBhSbdh24GI
        1MGbL1H232uPjJieUUZUuqoEhfOi8Jn471gHt6iXibf/amZLUASvFC4jcdxSwy2a45Rom7Wy
        oSpW2Cy21TneVS0VXKJonPTgUICFPHGmdx6VIJ6PEuLFwEhWCNPCGvHBtJ8LYYVAxG53+uKw
        T8RbPRVMSIcHsaO5gQ5ppbBL9JjaGBkpqlHYFfSxZDiYrf8+JWNTrF6boTdkpsQezMpoRYs/
        57+GLvdscSOBR6oPFWHrEtRKRntYn5vhRiKPVUsVOd8kqpWKZG3uUUmXtV9nSJf0brSCp1XR
        igvXvXuUQoo2R0qTpGxJ9z6l+PDlRrQ+ab5gzbHA3jy9vbg9YSo2t7QzsPqrDYa6rwc1pTLp
        97yJjPpxZY8m7HX0/VNp8cN5atOZ7d99tHFfnHmvxmuyuDoX5q/+cPW36iJPfEzTr1FlzoJI
        /6eB3cz2o/GaSEWbufYfzbold1Y7V6hHEzw/7d+5J7lmZHzZkhnV5MloRUu+itanauNisE6v
        fQvI9PU/bwMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53765
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
 arch/tile/kernel/pci-dma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index b6bc0547a4f6..09bb774b39cd 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -34,7 +34,7 @@
 
 static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
 				     dma_addr_t *dma_handle, gfp_t gfp,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	u64 dma_mask = (dev && dev->coherent_dma_mask) ?
 		dev->coherent_dma_mask : DMA_BIT_MASK(32);
@@ -78,7 +78,7 @@ static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
  */
 static void tile_dma_free_coherent(struct device *dev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	homecache_free_pages((unsigned long)vaddr, get_order(size));
 }
@@ -202,7 +202,7 @@ static void __dma_complete_pa_range(dma_addr_t dma_addr, size_t size,
 
 static int tile_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			   int nents, enum dma_data_direction direction,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -224,7 +224,7 @@ static int tile_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void tile_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			      int nents, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -240,7 +240,7 @@ static void tile_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 static dma_addr_t tile_dma_map_page(struct device *dev, struct page *page,
 				    unsigned long offset, size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -252,7 +252,7 @@ static dma_addr_t tile_dma_map_page(struct device *dev, struct page *page,
 
 static void tile_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				size_t size, enum dma_data_direction direction,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -343,7 +343,7 @@ EXPORT_SYMBOL(tile_dma_map_ops);
 
 static void *tile_pci_dma_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	int node = dev_to_node(dev);
 	int order = get_order(size);
@@ -368,14 +368,14 @@ static void *tile_pci_dma_alloc_coherent(struct device *dev, size_t size,
  */
 static void tile_pci_dma_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	homecache_free_pages((unsigned long)vaddr, get_order(size));
 }
 
 static int tile_pci_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction direction,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -400,7 +400,7 @@ static int tile_pci_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 static void tile_pci_dma_unmap_sg(struct device *dev,
 				  struct scatterlist *sglist, int nents,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -416,7 +416,7 @@ static void tile_pci_dma_unmap_sg(struct device *dev,
 static dma_addr_t tile_pci_dma_map_page(struct device *dev, struct page *page,
 					unsigned long offset, size_t size,
 					enum dma_data_direction direction,
-					struct dma_attrs *attrs)
+					unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -429,7 +429,7 @@ static dma_addr_t tile_pci_dma_map_page(struct device *dev, struct page *page,
 static void tile_pci_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				    size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -531,7 +531,7 @@ EXPORT_SYMBOL(gx_pci_dma_map_ops);
 #ifdef CONFIG_SWIOTLB
 static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	gfp |= GFP_DMA;
 	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
@@ -539,7 +539,7 @@ static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 static void tile_swiotlb_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_addr,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
-- 
1.9.1
