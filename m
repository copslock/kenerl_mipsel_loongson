Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:50:16 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49478 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041760AbcFBPmAWo4w2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:00 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500NZ0I9U0I00@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:54 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-ab-575053c2f3a6
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 49.6A.05254.2C350575; Thu,
 2 Jun 2016 16:41:54 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:54 +0100 (BST)
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
Subject: [RFC v3 29/45] m68k: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:31 +0200
Message-id: <1464881987-13203-30-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSW0xTdxjf//zPjc7CSUU96sJDMx9w3tiM+abGjGSJxyVmzTQhUbNZ4aQY
        KZIWjJo91GLxBnik4LScMcRqi4MCJRpQEVsJVWonHYpuCCqCWMS24tgFHLOF7O13+y758rFY
        1U8tYnfn5ouGXG2OmlaQ/mlfz3LvFk3GKmtdIhxrnWLA12iioeSXOwTIDXU0/FvWyUDTmQYK
        omYLBrs5G4I/WEiIXCxG4HBuhifjfQjC5ikSpl+PYbg/EaHhVK0VwwnXIANFp9NBHgkgePF7
        GwH20AbwPPqTAb9UQ8DppgXw90RhrLCrCUN1+zoIV73E8MR1iYIRrw2D/Nun8O5slIBjlY0M
        vHqZBhfPDyMYlh7TEO7vQGBr7yfB/byXglPtAQY6KiUCnD+7MJwrspNwuzRKQeRwCw3Ro2EK
        eq7KNDiG6jEUN16O0cJgfKsjJEgVZQxU2k+SMNjVTUCgykfDC28JCeNP/8MgnSvEcObejdg9
        3pVjsDyuJ6A2UM+At6INwdRf09QX24QhTxUhWNokWqirqkNCT28QC1OTZUh46NIIr6xSTCot
        IQTPoJcWakImUmi19TNC9M23QrW7QKis6EVCcetdJDQ7l2rWbFOszxJzdu8TDSs37FRk3yoK
        kHk/zd0fiLRhEwonHUcJLM+t5iVrLZrF8/nugQb6OFKwKu4C4o86QsQsOUTwLf5hHE/R3Gd8
        s8M+k0rmmnje9Dw4Y2Duez7km5xpNZf7irf0SjHMsiS3hPdc3x+XlZzAD10bJ2anpfB3Oq1U
        HCfEdHtDLRnHKm4jHyxspiSkrEYfXELzxILMPOMunT5thVGrNxbk6lZk7tW70ezT/dGCzneu
        9SKOReo5Smfq1xkqSrvPeEDvRTyL1cnK/G80GSpllvbAQdGw9ztDQY5o9KLFLKleoPzxamSr
        itNp88U9opgnGv53CTZhkQmp5aJwRGv+0ploetv5ifxMEZZHduLE8qDsKc3M2p7+a/GSktGP
        l9mSLgzIffp1C8c897u2TLp9rqePNH53B7EpXHMvdYzXDSxrTFKNXh4e0aWaAykHr9j6uieu
        QYrlmT50qFR2nnDocxz/lPvG0ze+fTD6edImf/LNj3YkHv5QTRqztWlLscGofQ9t6rnWcAMA        AA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53753
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
 arch/m68k/kernel/dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index cbc78b4117b5..8cf97cbadc91 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -19,7 +19,7 @@
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
 
 static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t flag, struct dma_attrs *attrs)
+		gfp_t flag, unsigned long attrs)
 {
 	struct page *page, **map;
 	pgprot_t pgprot;
@@ -62,7 +62,7 @@ static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 }
 
 static void m68k_dma_free(struct device *dev, size_t size, void *addr,
-		dma_addr_t handle, struct dma_attrs *attrs)
+		dma_addr_t handle, unsigned long attrs)
 {
 	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
 	vfree(addr);
@@ -73,7 +73,7 @@ static void m68k_dma_free(struct device *dev, size_t size, void *addr,
 #include <asm/cacheflush.h>
 
 static void *m68k_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 	/* ignore region specifiers */
@@ -91,7 +91,7 @@ static void *m68k_dma_alloc(struct device *dev, size_t size,
 }
 
 static void m68k_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 }
@@ -130,7 +130,7 @@ static void m68k_dma_sync_sg_for_device(struct device *dev,
 
 static dma_addr_t m68k_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	dma_addr_t handle = page_to_phys(page) + offset;
 
@@ -139,7 +139,7 @@ static dma_addr_t m68k_dma_map_page(struct device *dev, struct page *page,
 }
 
 static int m68k_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
-- 
1.9.1
