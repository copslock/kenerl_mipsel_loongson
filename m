Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:41:57 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15502 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041763AbcFBPknMRUN2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:43 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500C9MI7PZ110@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:37 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-d3-575053754b03
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id E1.0A.05254.57350575; Thu,
 2 Jun 2016 16:40:37 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:36 +0100 (BST)
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
Subject: [RFC v3 04/45] arc: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:06 +0200
Message-id: <1464881987-13203-5-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTG9973flFXc1NRryzOpYkxsoyJGnPwK9tfvFs0krkMY6Kug5tC
        pEhaa3AaU2HAUMBLGcgKa1A6KAiUj/gBhJFWBQFRGxxT5MMBoojQYoYSYGUtZP/9zvM8J+fk
        5PBY1c+E8PGJJyV9oiZBzSroLl97z2fGg1HRWy5d5iGzcZ6D9loTC9kPOigodlSx8K+5jYO6
        QgcD3pQ0DLaUOHBfTqPBU5aFoNy+H4bePkMwlTJPg2/yDYbHMx4WcivyMFysGeYgveBLKH7Z
        jWCsr4UC2/hecD55x0GXfJWCgrq1MDuT6m/srMNQ0roLpqyvMAzVVDLw0mXBUPx0Kyz86qUg
        s6iWg4lX4VBW+gLBC7mfhamBOwgsrQM01I/0MpDb2s3BnSKZAvu1GgxX0m003MvxMuD56RYL
        3p+nGOhpKmahfLQaQ1btdX+Z6g5slUGDnG/moMh2iYbhzkcUdFvbWRhzZdPw9vkiBvlKKobC
        h3/477HwC4a0/moKKrqrOXDltyCYf+9jvjhMRp1WiqS1yCypslYh0tPrxmR+zozIXzVRZCJP
        9ks52RRxDrtYcnXcRJNGywBHvNNHSUm9kRTl9yKS1XgfkQZ7aNSOw4rdsVJC/ClJ//ne7xVx
        mfdnqaQnyuQbt+2sCRWuuICCeFHYLnrsrewyrxEfDTr8rOBVwu9ItJhnccBQCecp0VdGAswK
        28SGcttSKFioE0XTiHsphIWz4nj7HLqAeH6V8JVov7k9INPCRvHPHN9SRClEiiWFPfTysI/F
        jrY8JsBBAhFtjgp6eVak6E5tYGSkLEEfVKLVkjEmyfCDVhceZtDoDMZEbVjMCV09Wv65f26h
        0radLiTwSP2h0r75QLSK0ZwynNa5kMhjdbAyfX9UtEoZqzn9o6Q/cUxvTJAMLvQRT6vXKn9r
        8nyrErSak9JxSUqS9P+7FB8UYkIrTfoF+e/J2EWn+9OBzNj06VE6ZM3MusWxvsrI63t0d8/p
        u2JyQ/PWR6wMfr0xYkOYNjm4aVfz174byd/si1CUxvdZY6YPTRzxah2jgxkdHu6g5bvH58BV
        PXSGfT02uGeD3Zi8O+OT5unJA843cZP7zkYWmOuzVjSPHJ3rnFvYpKtU04Y4TXgo1hs0/wGN
        R3eybwMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53728
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
 arch/arc/mm/dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 73d7e4c75b7d..3d1f467d1792 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -22,7 +22,7 @@
 
 
 static void *arc_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	unsigned long order = get_order(size);
 	struct page *page;
@@ -90,7 +90,7 @@ static void *arc_dma_alloc(struct device *dev, size_t size,
 }
 
 static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct page *page = virt_to_page(dma_handle);
 	int is_non_coh = 1;
@@ -129,7 +129,7 @@ static void _dma_cache_sync(phys_addr_t paddr, size_t size,
 
 static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	_dma_cache_sync(paddr, size, dir);
@@ -137,7 +137,7 @@ static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
 }
 
 static int arc_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	   int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+	   int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
-- 
1.9.1
