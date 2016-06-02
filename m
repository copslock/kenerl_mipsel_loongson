Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:43:22 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15604 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041767AbcFBPkxrbvU2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:53 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008M0I84TS10@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:53 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-f8-575053843878
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 3D.1A.05254.48350575; Thu,
 2 Jun 2016 16:40:52 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:52 +0100 (BST)
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
Subject: [RFC v3 09/45] c6x: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:11 +0200
Message-id: <1464881987-13203-10-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0xTZxjed75zKY1NTirqZ0380TmnGC+oc+8cYbhl8ywLimGTxcRLlSM4
        AUlrjZr9qJTCuHoEEYGKKFWKoxRKVFCRUIF6q9ixMJ0UZ0WQKVCNygRlayH799zeS968Mqz0
        MirZrpS9ojZFk6Rm5fStCVfX4vTYmLhlpuIPIatpnANXnYGFvDs3KDDba1h4X9DBQf1xOwP+
        NBMGS1oieIpNNIyczUVQZY2Ghy8fIBhOG6dhYug5ht9fj7BwpLoQQ06tj4OMY2vAPOBG0P9n
        MwWWwUhovfeGg1vSaQqO1c+Cf14bA4U36zFUtHwOw+VPMTysPcfAgLMUg/n+cnhX4qcgq6yO
        g2dPw+Fs5RMET6QeFoa9bQhKW7w0OB53M3Ckxc1BW5lEgfXXWgynMiw0XM/3MzCS3siC/5dh
        BroumVmo6rNhyK07H6BGT3CrTBqkogIOyiyHafDdvEuBu9zFQr8zj4aXf/2LQTplxHC882rg
        Hu+OYjD12Ciodts4cBY1IxgfnWCiNgl9reWUYGqWWKGmvAYJXd0eLIyPFSDhj9oY4VmhFJDy
        8yih1edkhdODBlpoKvVygv/FFqHCoRfKirqRkNt0GwkN1rCYVZvkEfFi0q59onZp5DZ54qPL
        qtQ7qv2dmZXYgN7PyEYhMsKvJPaSHG4KzyR3e+1sNpLLlPwZRNpLRukpcogit89YUTDF8itI
        Q5VlMhXK1xNieOzBQQPzP5NB19hkaDr/LXl00jPZluY/IhXXsqggVvACceS3oalxc8mNjkIm
        iEMCusVeTQexkl9LPMYGRkKKCvTBOTRD1O9I1W1PSA5fotMk6/QpCUt27El2oKmne9WIKjtW
        OxEvQ+ppCuvC9XFKRrNPdyDZiYgMq0MVGdExcUpFvObAQVG7Z6tWnyTqnGiOjFbPUpy4NPK9
        kk/Q7BV3i2KqqP3fpWQhKgPaHdb89/zVb0n0lwXZn8z7wtbucEd9vS7h4E7us8icoQuR37jZ
        weV2c43c1yD/IV0eq2c3/Ibvf7Worzdq4F7ngufmxtnxtm2+CN1+ZmNE6Lzoj3uHUtrn7Lwo
        tcZGvfo0M2S06033T5UqZMQ9W/jMsQVL+6/4cl0PNjI/biXezd91qmldoiY8DGt1mv8AHr70
        a3ADAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53732
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
 arch/c6x/include/asm/dma-mapping.h | 4 ++--
 arch/c6x/kernel/dma.c              | 9 ++++-----
 arch/c6x/mm/dma-coherent.c         | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/dma-mapping.h
index 6b5cd7b0cf32..5717b1e52d96 100644
--- a/arch/c6x/include/asm/dma-mapping.h
+++ b/arch/c6x/include/asm/dma-mapping.h
@@ -26,8 +26,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 
 extern void coherent_mem_init(u32 start, u32 size);
 void *c6x_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t gfp, struct dma_attrs *attrs);
+		gfp_t gfp, unsigned long attrs);
 void c6x_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs);
+		dma_addr_t dma_handle, unsigned long attrs);
 
 #endif	/* _ASM_C6X_DMA_MAPPING_H */
diff --git a/arch/c6x/kernel/dma.c b/arch/c6x/kernel/dma.c
index 8a80f3a250c0..db4a6a301f5e 100644
--- a/arch/c6x/kernel/dma.c
+++ b/arch/c6x/kernel/dma.c
@@ -38,7 +38,7 @@ static void c6x_dma_sync(dma_addr_t handle, size_t size,
 
 static dma_addr_t c6x_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	dma_addr_t handle = virt_to_phys(page_address(page) + offset);
 
@@ -47,13 +47,13 @@ static dma_addr_t c6x_dma_map_page(struct device *dev, struct page *page,
 }
 
 static void c6x_dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	c6x_dma_sync(handle, size, dir);
 }
 
 static int c6x_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -67,8 +67,7 @@ static int c6x_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 }
 
 static void c6x_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		  int nents, enum dma_data_direction dir,
-		  struct dma_attrs *attrs)
+		  int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
index f7ee63af2541..95e38ad27c69 100644
--- a/arch/c6x/mm/dma-coherent.c
+++ b/arch/c6x/mm/dma-coherent.c
@@ -74,7 +74,7 @@ static void __free_dma_pages(u32 addr, int order)
  * virtual and DMA address for that space.
  */
 void *c6x_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t gfp, struct dma_attrs *attrs)
+		gfp_t gfp, unsigned long attrs)
 {
 	u32 paddr;
 	int order;
@@ -99,7 +99,7 @@ void *c6x_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * Free DMA coherent memory as defined by the above mapping.
  */
 void c6x_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order;
 
-- 
1.9.1
