Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:50:33 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45362 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041791AbcFBPmGNV0r2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:06 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500FIHI9XT440@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:58 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-b9-575053c5ab87
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 50.7A.05254.5C350575; Thu,
 2 Jun 2016 16:41:57 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:57 +0100 (BST)
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
Subject: [RFC v3 30/45] metag: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:32 +0200
Message-id: <1464881987-13203-31-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH/d3ffZRuTa4d6A3GJTaZRuMDlJgTJWYPF69ZNomSkLDo7PQG
        dBRIC2YYYzo63FBgFxjqaEXAroBAS0vIgMjrRukK8qhVVOQ1FBUftCBMBcG1kP33Od/zPY+c
        HBlWDlGhsmOJKYI2UZ2gouVk54LTs+nGgaiYMEuPEjIb5hhw1uhpyO52EWCyVdEwn9fOgP2i
        jQJfegYGc3o8uC9kkOC1ZCEoK/8ahqceIJhInyNh4eULDLdnvDTkVuRjOGcdZeDM+c/A9KQL
        weP+JgLM47ug7d6/DHSKpQSct6+ENzMGf2GHHUNxy06YKHqKYdh6lYInUiEG0/2t8O4PHwGZ
        xhoGnj8NB8uVMQRj4gANE4PXERS2DJLgeNhHQW5LFwPXjSIB5ZVWDCVnzCT8neOjwPtzPQ2+
        Xyco8DSaaCh7VI0hq6bOHxrcga1+IUEsyGPAaP6NhNGOXgK6ipw0PJaySZgaeY9BLDFguNjT
        7L/Hu98xZAxUE1DRVc2AVNCEYO71AvVpLP+orYjgM5pEmq8qqkK8p8+N+bnZPMTftUbxz/NF
        v5STTfBtoxLNl47rSb6hcJDhfZOH+GJHKm8s6EN8VsNNxNeWb4jaHiuPPCokHDshaLfsOiyP
        73ilJ5IrQ37M+esOo0fXlp9FQTKOjeAaXJX0Eq/geodsfpbLlOyfiGueeYmWgp8Izp5bRwRc
        NLuNqy0zL7qCWTvH6R+6cSCB2VPcuHMWBfgj9ivu1ry02JZkP+HE1+5FVrA8113xllga9zHn
        as+nAhzk1822CjLASnYP5zbUUiJSFKNlV1GIkHokWfd9nCZ8s06t0aUmxm0+kqRxoKWvm65H
        V9p3SIiVIdWHivL1+2KUlPqELk0jIU6GVcGKlP1RMUrFUXXaSUGb9J02NUHQSWiVjFStVFxq
        9EYr2Th1ivCDICQL2v+zhCwoVI/Ovur+YvrS9JcHIh0hO4ExuRwGzYvVrQc7LdCyOnLy2/sX
        +uNMvZ2tYUPy6BGtfcYYGlu1/HZP8dpT5z7YvSbm8PF538bghVHrMzF7LP/92qnx6JFVcmx7
        1uvdvsfUf3nvjtOzmXWNiaY3k57I+jvfhB0McTk3jVnWDUT8Mx/vkT5Xkbp4dfgGrNWp/wM3
        CnnacQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53754
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
 arch/metag/kernel/dma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/metag/kernel/dma.c b/arch/metag/kernel/dma.c
index e12368d02155..d68f498e82a1 100644
--- a/arch/metag/kernel/dma.c
+++ b/arch/metag/kernel/dma.c
@@ -172,7 +172,7 @@ out:
  * virtual and bus address for that space.
  */
 static void *metag_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	struct page *page;
 	struct metag_vm_region *c;
@@ -268,7 +268,7 @@ no_page:
  * free a page as defined by the above mapping.
  */
 static void metag_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct metag_vm_region *c;
 	unsigned long flags, addr;
@@ -331,7 +331,7 @@ no_area:
 
 static int metag_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	unsigned long flags, user_size, kern_size;
 	struct metag_vm_region *c;
@@ -482,7 +482,7 @@ static void dma_sync_for_cpu(void *vaddr, size_t size, int dma_direction)
 
 static dma_addr_t metag_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	dma_sync_for_device((void *)(page_to_phys(page) + offset), size,
 			    direction);
@@ -491,14 +491,14 @@ static dma_addr_t metag_dma_map_page(struct device *dev, struct page *page,
 
 static void metag_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 		size_t size, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	dma_sync_for_cpu(phys_to_virt(dma_address), size, direction);
 }
 
 static int metag_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -516,7 +516,7 @@ static int metag_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void metag_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nhwentries, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
-- 
1.9.1
