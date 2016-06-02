Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:44:21 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45149 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041769AbcFBPlGij0X2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:06 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500GGWI8BC540@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:59 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-4b-5750538ac7f1
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 4C.CB.04866.A8350575; Thu,
 2 Jun 2016 16:40:58 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:58 +0100 (BST)
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
Subject: [RFC v3 11/45] frv: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:13 +0200
Message-id: <1464881987-13203-12-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUxTaRSG/e53l0Js5qaCXlEmpokmGhXF7QRnXJjJzOWHStQEQ+JS8aao
        FGpLcYk/KoiIA05Z6hRoCEKlgCwtaAIGRCqCilWbGlwRZVEI2talLqDVFjL/nnPe8+Y9OTki
        LOmjwkT7k1MFVbIsSUoHkz2+bueSM9ti45a9NSyE7JYJBrotWhpy794iwNhQS8P3/C4GrIYG
        CjzpmRhM6Yng+C+TBHdlDgJz1Sbof/8UgSt9ggTf2zcYHnjdNORVF2D4p36AgVPnNoLxtR3B
        qydtBJhG10HHo08M9OjKCThnnQVfvBl+420rhrL2teAqHcHQX19DwWtbMQbj40j4VuQhILvE
        wsDYyHKorBhGMKx7RoOrrxNBcXsfCY2DvRTktdsZ6CzREVB1sR7D+VMmEm6e9VDgPtlMg+e0
        iwLnFSMN5qE6DDmWy/4ywxHYKosEnT6fgRLTvyQM3L5PgL20m4ZXtlwS3r/4gUF3PgOD4d5V
        /z2+FWLIfFZHQLW9jgGbvg3BxGcftSGeH+ooJfjMNh3N15bWIt7Z68D8xHg+4h/Wx/JjBTp/
        62wuwXcM2Gi+fFRL8i3FfQzvebeLL2vU8CX6XsTntNxBfFPVotjV8cG/7ROS9qcJqoh1e4IT
        r13voJWWsCO1NwqRFo2HnkFBIo5dybleXqKneCZ3/3mDn4NFEvYC4myfvCggSNgTBHfydHiA
        aXYF12Q2TQ6FsFaO0w46cEDA7HFutHt80jCDjeHymq9PMsnO5762Dk+ymOW50awcYirtV+5W
        VwEV4CB/39RQTU6F/c05MpooHRKXoWk1KFTQJCjVe+WKyKVqmUKtSZYvTUhRNKKpp/M2owtd
        UTbEipB0unja4i1xEkqWpj6qsCFOhKUh4jVbY+Mk4n2yo8cEVcpulSZJUNvQHBEpnSUuuuLe
        LmHlslThoCAoBdX/KiEKCtMixY0YrzlI4ZNcVmhq5sqHDNrNUcprkFyX9t2tlPvW7/jjjiHl
        UIV5/uHf7YuF1QvurnJxvi1/HTleoCk2koNU/1iEPrJ1JKb3z9TZO8uzK4u8euZQRd7H3ITo
        6E1v4qNMql3zLNE9hR/QyqYDhx8ZrUvCneGEc94vSZ0z3z3Jei4l1Ymy5YuwSi37Cak6qqdw        AwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53735
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
 arch/frv/mb93090-mb00/pci-dma-nommu.c | 8 ++++----
 arch/frv/mb93090-mb00/pci-dma.c       | 9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-dma-nommu.c b/arch/frv/mb93090-mb00/pci-dma-nommu.c
index 082be49b5df0..90f2e4cb33d6 100644
--- a/arch/frv/mb93090-mb00/pci-dma-nommu.c
+++ b/arch/frv/mb93090-mb00/pci-dma-nommu.c
@@ -35,7 +35,7 @@ static DEFINE_SPINLOCK(dma_alloc_lock);
 static LIST_HEAD(dma_alloc_list);
 
 static void *frv_dma_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, struct dma_attrs *attrs)
+		gfp_t gfp, unsigned long attrs)
 {
 	struct dma_alloc_record *new;
 	struct list_head *this = &dma_alloc_list;
@@ -86,7 +86,7 @@ static void *frv_dma_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_ha
 }
 
 static void frv_dma_free(struct device *hwdev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct dma_alloc_record *rec;
 	unsigned long flags;
@@ -107,7 +107,7 @@ static void frv_dma_free(struct device *hwdev, size_t size, void *vaddr,
 
 static int frv_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -124,7 +124,7 @@ static int frv_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static dma_addr_t frv_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	BUG_ON(direction == DMA_NONE);
 	flush_dcache_page(page);
diff --git a/arch/frv/mb93090-mb00/pci-dma.c b/arch/frv/mb93090-mb00/pci-dma.c
index 316b7b65348d..f585745b1abc 100644
--- a/arch/frv/mb93090-mb00/pci-dma.c
+++ b/arch/frv/mb93090-mb00/pci-dma.c
@@ -19,8 +19,7 @@
 #include <asm/io.h>
 
 static void *frv_dma_alloc(struct device *hwdev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp,
-		struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -32,14 +31,14 @@ static void *frv_dma_alloc(struct device *hwdev, size_t size,
 }
 
 static void frv_dma_free(struct device *hwdev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	consistent_free(vaddr);
 }
 
 static int frv_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	unsigned long dampr2;
 	void *vaddr;
@@ -69,7 +68,7 @@ static int frv_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static dma_addr_t frv_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	flush_dcache_page(page);
 	return (dma_addr_t) page_to_phys(page) + offset;
-- 
1.9.1
