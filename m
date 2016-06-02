Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:51:52 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45444 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041762AbcFBPmQyaHt2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:16 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500DSHIAA1J40@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:10 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-db-575053d1878a
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 86.8A.05254.1D350575; Thu,
 2 Jun 2016 16:42:09 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:09 +0100 (BST)
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
Subject: [RFC v3 34/45] nios2: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:36 +0200
Message-id: <1464881987-13203-35-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTdxT2d3/3BbN606H8oouPTpLBIoou88Sp0SWLNwGV+AiJLGwd3AAK
        SFpqBtuSDoaKgl5AFIE1oFUKK5RHnECGhPKooHU0LFUHqEFRHq7tmOgiFW0l/ved7/vO+U5O
        Do+VQ8wyPjktQ9KkqVNUbCB9c842uNaxLzpmvbsnBPJaZzmwNehZKLjdR0GFxczC66JeDhpL
        LQx4snMxGLOTwHE+lwb3lXwE1aZd8GB6CIEre5aGuX+eYfhrxs1CYU0xhlP1oxwcO7cDKp7a
        ETz5u50C48Q26Lz7goOb8kUKzjUGw/8zOb7G/kYMlR1fgMswjuFBfS0DT61lGCrubQDvBQ8F
        eeUNHEyNR8CVS2MIxuRhFlwj3QjKOkZoaHrkZKCww85Bd7lMgem3egxVx4w03DjtYcD9SwsL
        nhMuBgbbKlioflyHIb/hqq/Mcfi3Ok6DXFLEQbnxDA2j/QMU2A02Fp5YC2iYfvgGg1yVg6H0
        z+u+e3jPYsgdrqOgxl7HgbWkHcHsyzlm+0HxcaeBEnPbZVY0G8xIHHQ6sDj7qgiJd+qjxali
        2UedLqDEzlErK16c0NNia9kIJ3r+jRMrm3RieYkTifmtt5DYbAqL/vxg4JYEKSX5qKRZt+3b
        wKSpsjwmvVL5vdlwnNYj76KTKIAnwmfk9msZzeOlZOC+hT2JAnmlcBkRb0c25xeUws8UcV5d
        78essJE0VxvfmYKERkL0jxzYL2DhRzJhe+WbxPMfCpHEejfSD2khhHinN/sdCkEkDV16ej5r
        BenrLWb8OMDHGy019HzUTuLIaWZkpKhEC2rREkkXn679LjE1IlyrTtXq0hLD44+kNqH5l3ve
        gi71brYigUeqhQpT6J4YJaM+qs1MtSLCY1WQImNvdIxSkaDOzJI0R77R6FIkrRUt52lVsOLX
        Nvd+pZCozpAOS1K6pHmvUnzAMj36YYYMVq/r2lW0e2vUqZbrXeMDn9q2dgcvmeAn4aePlr60
        9VUpIrPi1iSt/ID8kfVsA/3JjM1pPrHisKm38KuHi/tj31y7/3vMqtVrt+RH9ajTDhV+vHxT
        lTPuRvymugOTcc91VOz+a2MZIXdK/0u48CLTFrnHUhLqmtRGfZ1nZ2qTvwxT0dokdUQY1mjV
        bwENz/t8bgMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53758
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
 arch/nios2/mm/dma-mapping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 90422c367ed3..d800fad87896 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -59,7 +59,7 @@ static inline void __dma_sync_for_cpu(void *vaddr, size_t size,
 }
 
 static void *nios2_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -84,7 +84,7 @@ static void *nios2_dma_alloc(struct device *dev, size_t size,
 }
 
 static void nios2_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long addr = (unsigned long) CAC_ADDR((unsigned long) vaddr);
 
@@ -93,7 +93,7 @@ static void nios2_dma_free(struct device *dev, size_t size, void *vaddr,
 
 static int nios2_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int i;
 
@@ -113,7 +113,7 @@ static int nios2_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static dma_addr_t nios2_dma_map_page(struct device *dev, struct page *page,
 			unsigned long offset, size_t size,
 			enum dma_data_direction direction,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	void *addr = page_address(page) + offset;
 
@@ -123,14 +123,14 @@ static dma_addr_t nios2_dma_map_page(struct device *dev, struct page *page,
 
 static void nios2_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 		size_t size, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	__dma_sync_for_cpu(phys_to_virt(dma_address), size, direction);
 }
 
 static void nios2_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nhwentries, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	void *addr;
 	int i;
-- 
1.9.1
