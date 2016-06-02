Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:53:34 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45493 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041801AbcFBPmb5R0Y2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:31 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500FITIAPT440@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:26 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-69-575053e09a35
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 2D.4C.04866.0E350575; Thu,
 2 Jun 2016 16:42:25 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:24 +0100 (BST)
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
Subject: [RFC v3 39/45] sh: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:41 +0200
Message-id: <1464881987-13203-40-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH/d3ffVFtvKmoV5eQpZEsIYqIj5zofCzR7C5xGXGbKCZuFa5g
        LEhawEfcUqn4QNArCGqLpNbyUqBQNCloRaqhKqLUGhS16qqIjEmrETcp4FqI/33P55yT7zcn
        h8UKLzWb3ZaRJWoyVGolLSM7xlyeeX/9nJAY5/ARcLg5yICrQUdD4d1bBJRZa2kYLWpnoPGU
        lYJAbh4GS24auE/mkeCvLEBQVf0jPH//BMFgbpCEsbf/YHgw5KfheE0xhiP1PgYOlH4HZX2d
        CF4/dhBg6V8BbY8+MtAhmQkobZwJ/w3pQ4u3GzGYWpfBYPkbDM/rz1PQ5zRgKOuJh5HTgVAw
        YwMDA28WQOW5XgS90lMaBr03EBhavSTYXnZTcLy1k4EbRomA6gv1GM4esJBw82iAAv9+Ow2B
        Q4MUeFrKaKh6VYehoOFSqNS7w6kOkiCVFDFgtBwjwXe7i4DOchcNr52FJLx/8RmDdFaP4dS9
        q6F7jJzAkPe0joCazjoGnCUOBMF/x6hVScKrtnJCyHNItFBbXosET7cbC8HhIiQ8rE8QBoql
        EDpaSAhtPictmPt1pNBs8DJC4N1mwWTLFowl3UgoaL6DhKbqmIQlSbJvU0T1thxRM3/F77K0
        OmMzkfkpclf3yWFGh95y+YhleW4Rb/oA+SgiJGfwXc+sdD6SsQquAvEPgleoiWIfwffYe8jw
        FM0t5JuqLONTkVwjz+teunG4gbm9fL9rGIX1NE7gP3muj3OSi+Z9LwzjXB7i90er0YRdFH+r
        vZgK64gQt1hrxg0U3Pe8W99ESUhuQpPOo+lidnKmdktqenysVpWuzc5IjU3ekW5DE083ZEcV
        7UudiGORcop80tyfEhWUKke7O92JeBYrI+VZ6xISFfIU1e49ombHb5pstah1oq9YUjlTfrrF
        /4uCS1VlidtFMVPUfOkSbMRsHYqaHqRiY2bQSVt3RUz+e1ZN7w9qg73SYVdv+HVl9GXPmQFy
        JJ5oibq850xwZcvFjgrp3uE1USc07uVdOcXX9LI+39f9tlFPiXlR/M7SwDVkXzvV+ufadv/i
        VnOcuXC9QTsHaFWyyflHtC0yZWNi3Oolx2yT97oqvdz1tnOb5nxzU0lq01QLYrBGq/ofvy08
        7HADAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53763
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
 arch/sh/include/asm/dma-mapping.h | 4 ++--
 arch/sh/kernel/dma-nommu.c        | 4 ++--
 arch/sh/mm/consistent.c           | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index e11cf0c8206b..0052ad40e86d 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -17,9 +17,9 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 /* arch/sh/mm/consistent.c */
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_addr, gfp_t flag,
-					struct dma_attrs *attrs);
+					unsigned long attrs);
 extern void dma_generic_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_handle,
-				      struct dma_attrs *attrs);
+				      unsigned long attrs);
 
 #endif /* __ASM_SH_DMA_MAPPING_H */
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 5b0bfcda6d0b..eadb669a7329 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -13,7 +13,7 @@
 static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	dma_addr_t addr = page_to_phys(page) + offset;
 
@@ -25,7 +25,7 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 
 static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index b81d9dbf9fef..92b6976fde59 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -34,7 +34,7 @@ fs_initcall(dma_init);
 
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	void *ret, *ret_nocache;
 	int order = get_order(size);
@@ -66,7 +66,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 
 void dma_generic_free_coherent(struct device *dev, size_t size,
 			       void *vaddr, dma_addr_t dma_handle,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	int order = get_order(size);
 	unsigned long pfn = dma_handle >> PAGE_SHIFT;
-- 
1.9.1
