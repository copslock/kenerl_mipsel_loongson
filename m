Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:52:16 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:16090 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041783AbcFBPmTZ0of2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:19 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500AKJIADB610@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:13 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-43-575053d4ea48
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 87.3C.04866.4D350575; Thu,
 2 Jun 2016 16:42:12 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:12 +0100 (BST)
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
Subject: [RFC v3 35/45] openrisc: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:37 +0200
Message-id: <1464881987-13203-36-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0xTZxjmO993zindao4F9QyzLTZTE0TnLeaNLjizHzv7sUl0SuK9w0Mh
        ApKWMl2M6ehgQ7kUEOUWUrEI1FIK1QXQyqgEpoxJV4OogMhNEYHOpMIswijEf8/tzfvkzSvB
        8j46RBKbkCSqE5RxCkZK2mfb3Osf7I2I3Pjm97WQ3uBjoc2mYyDz77sUlNRYGHiX28pCbUEN
        DZ6UVAymlBhwXUolMHk1A0FF5bfw9PUTBBMpPgKz468wPPBOMpBTlYfhvHWAhbSLu6DkeQeC
        kccOCkyj4dDc/YaFdkMZBRdrV8C0Vz8/eK8Wg7FpB0yUvsDw1Gqm4bmzCEPJo80wU+ihIL3Y
        xsLYi01w9cowgmFDDwMTvS0Iipp6CdQNdtGQ09TBQkuxgYLKa1YMl9NMBP7M8tAw+Us9A57f
        JmhwN5YwUDFUjSHDdmOe6l3+Vr8SMOTnslBsyiYwcK+Tgo7SNgZGnJkEXvfPYTBc1mMouH97
        /h4zFzCk9lRTUNVRzYIz34HANzVLf3lAGGoupYRUh4ERLKUWJLi7XFjwvc1FwkNrhDCWZ5iX
        sjIpoXnAyQhlozoiNBT1soLn3yOCsU4rFOd3ISGj4S8k2CtDI7YdkH5xXIyLTRbVn4cfk8Z4
        +v+jE1uXn5q6ZSQ61L30HAqU8NxWvjOvhyzi5XxnXw1zDkklcq4c8VVZfWSR/EzxZuN15E8x
        3BbeXmFaSAVztTyvG3Rhv4G5M/xo29uFUBD3HZ9W4GD8mHCr+ezK9AVdxgm8yTnOLK77hL/b
        mkf7caBfr6laqCHnvuZdejttQDIjCjCjZaI2KlHzgyp+8waNMl6jTVBtiDoZX4cWv85bj8pb
        tzsRJ0GKD2UBYbsj5bQyWXM63ol4CVYEy5L2RETKZceVp38S1SePqrVxosaJVkqIYoWssHHy
        ezmnUiaJJ0QxUVS/dylJYIgO3XnX7bN/qvvHmIiJ+uzh+h/Hppftj378DfEcWqMq25/ymWuu
        vOiPKfLScmLVzo9zuK+WPFn7LOiDkL6gkTMbzw/qLxRqpWEH263u9HUy1UfTySuHsy22m7Kl
        3tm5IHezOdfM3t/XOG7zXr8TsGbIfio81NHSnxPbObPTGr16e9PQIQXRxCg3hWK1Rvk/RQLY
        hnEDAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53759
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
 arch/openrisc/kernel/dma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 0b77ddb1ee07..50eb1f26c540 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dma-debug.h>
 #include <linux/export.h>
-#include <linux/dma-attrs.h>
 
 #include <asm/cpuinfo.h>
 #include <asm/spr_defs.h>
@@ -83,7 +82,7 @@ page_clear_nocache(pte_t *pte, unsigned long addr,
 static void *
 or1k_dma_alloc(struct device *dev, size_t size,
 	       dma_addr_t *dma_handle, gfp_t gfp,
-	       struct dma_attrs *attrs)
+	       unsigned long attrs)
 {
 	unsigned long va;
 	void *page;
@@ -117,7 +116,7 @@ or1k_dma_alloc(struct device *dev, size_t size,
 
 static void
 or1k_dma_free(struct device *dev, size_t size, void *vaddr,
-	      dma_addr_t dma_handle, struct dma_attrs *attrs)
+	      dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long va = (unsigned long)vaddr;
 	struct mm_walk walk = {
@@ -137,7 +136,7 @@ static dma_addr_t
 or1k_map_page(struct device *dev, struct page *page,
 	      unsigned long offset, size_t size,
 	      enum dma_data_direction dir,
-	      struct dma_attrs *attrs)
+	      unsigned long attrs)
 {
 	unsigned long cl;
 	dma_addr_t addr = page_to_phys(page) + offset;
@@ -170,7 +169,7 @@ or1k_map_page(struct device *dev, struct page *page,
 static void
 or1k_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	/* Nothing special to do here... */
 }
@@ -178,14 +177,14 @@ or1k_unmap_page(struct device *dev, dma_addr_t dma_handle,
 static int
 or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	    int nents, enum dma_data_direction dir,
-	    struct dma_attrs *attrs)
+	    unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
 		s->dma_address = or1k_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir, NULL);
+					       s->length, dir, 0);
 	}
 
 	return nents;
@@ -194,13 +193,13 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 static void
 or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
 	      int nents, enum dma_data_direction dir,
-	      struct dma_attrs *attrs)
+	      unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		or1k_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, NULL);
+		or1k_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, 0);
 	}
 }
 
-- 
1.9.1
