Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:48:36 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15875 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041787AbcFBPlnDkLw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:43 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500CA2I9IR710@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:42 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-de-575053b544b9
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 67.1C.04866.5B350575; Thu,
 2 Jun 2016 16:41:41 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:41 +0100 (BST)
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
Subject: [RFC v3 25/45] iommu: intel: dma-mapping: Use unsigned long for
 dma_attrs
Date:   Thu, 02 Jun 2016 17:39:27 +0200
Message-id: <1464881987-13203-26-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee5z3yBrvKlsPMHFkBo/yKZM2ZYTp07dh90sMxI1aWIWteod
        GKCSlprpNKl0RcUClzdFWhteqqWsvBQ0EwwjNA1MBKVh6cYGw4CADKWVyVQQthb12+///5+T
        c3JyeKwcYuL5Y9psSafVZKjYGPruUvfA+pt7U9QfjTzdDBdaFzjobjKykH/vDgW2RjcLi8Vd
        HHjKGxkI5ZgxOHLSwH/ZTEPwugWBs3YXjMz+iWAmZ4GGpSePMfw6F2ShyFWC4WLDKAe5l3aA
        bbIPwcQf7RQ4prZB5+//cnBXrqbgkicOXsyZwo09HgyVHZ/BjP0RhpGGOgYmvRUYbIOb4NWV
        EAUXrE0cTD/aCNdrxhGMy0MszAz7EFR0DNPQPBZgoKijjwOfVaag9scGDFW5Dhp+KQgxEPzh
        Fguh8zMMDLTZWHA+rMdgaboZliZ/ZKtzNMhlxRxYHYU0jPb0U9Bn72ZhwptPw+yD/zDIVSYM
        5fd/Dt/jVSkG81A9Ba6+eg68Ze0IFp4vMdv3iw877ZRobpdZ0W13I3Eg4MfiwnwxEn9rSBGn
        S+SwVZBPiZ2jXlasnjLSYmvFMCeGnh4QK5sNorUsgERLay8SW2oTUz7dH7PlqJRx7ISkS9p2
        KCZtcbAXZeWt/M5unmCMqGZFHormifAxqZr34df8Hun/q5HNQzG8UriGyL3il2/EWYrcH3Qt
        V7FCMmlxOpaDWMFDiHHMvxxg4TSZ6p5HEV4p7COdhS/DPs/TwlriG9odQYUgkun2N8NWkztd
        JUyEo8O2o9FFR1gpfEn8phZGRopKFFWH3pUMR7L0h1MzN23QazL1Bm3qhiPHM5vR65+bu4Wu
        dW32IoFHqncUUR/uVisZzQn9yUwvIjxWxSqy96SolYqjmpOnJN3xgzpDhqT3olU8rYpTXGkL
        7lMKqZpsKV2SsiTd25Tio+ONSIjrZ+L+iS3dc873Uy6fxCV/k7d9Z+GzIu0LJzEkhHbUfSHf
        eN9xGn2yymKdxQWJvX8fsNWsseSgZFyjru5hJ8+gsSj3onNrW+D70vXxVbc96gRddvrtYJb5
        q3XfUof4QMKD81+bSJL28OCznebLp8ZdRgF/PlyWftVd7vwgSkXr0zQbE7FOr/kfD1asim8D        AAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53748
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
 drivers/iommu/intel-iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a644d0cec2d8..ba9d28acbf3a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3545,7 +3545,7 @@ error:
 static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	return __intel_map_single(dev, page_to_phys(page) + offset, size,
 				  dir, *dev->dma_mask);
@@ -3704,14 +3704,14 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 
 static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct page *page = NULL;
 	int order;
@@ -3757,7 +3757,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
-				dma_addr_t dma_handle, struct dma_attrs *attrs)
+				dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order;
 	struct page *page = virt_to_page(vaddr);
@@ -3772,7 +3772,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	dma_addr_t startaddr = sg_dma_address(sglist) & PAGE_MASK;
 	unsigned long nrpages = 0;
@@ -3801,7 +3801,7 @@ static int intel_nontranslate_map_sg(struct device *hddev,
 }
 
 static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
+			enum dma_data_direction dir, unsigned long attrs)
 {
 	int i;
 	struct dmar_domain *domain;
-- 
1.9.1
