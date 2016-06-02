Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:47:42 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49354 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041784AbcFBPlf7Dyi2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:35 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500MZAI959W00@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:30 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-b5-575053a92338
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 60.0C.04866.9A350575; Thu,
 2 Jun 2016 16:41:29 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:29 +0100 (BST)
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
Subject: [RFC v3 21/45] swiotlb: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:23 +0200
Message-id: <1464881987-13203-22-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTZxT3u999FGaXmyp6g8ElTTQZmfhgcSdqjMuScZPFrNlmWIjMdXpD
        jbxsBRX3R6UPEAELDLRAGpRCAYFSiBHU0lALDLAbDdrhAyU8CgxXOpfiAg7WQvzv9zr5nZwc
        EZa8pKJFp9PPCcp0eaqUjiSHVvpHdjV+K0vco/VGwZWuZQb629Q0FP02QEC1tZmG/0r7GLDd
        sFIQyNVhMOcqwHNdR8JCfSECS8NRePXmOQJ/7jIJK3+9xvA4uEBDSWMZhqutEwzoKz6H6hk3
        At8zOwHmucPQM7rIwJDhFgEVtq3wb1ATGhy0YahxHAS/aRbDq9YmCmaclRiqn+6Dd8YAAVeq
        2hiYn90L9bXTCKYNL2jwj7kQVDrGSGif9FJQ4nAz4KoyENBwuxXDTb2ZhF+LAxQsaDtpCOT7
        KRi5V02DZaoFQ2HbnRDVeMJb5ZFgKC9loMp8jYSJwWEC3KZ+GnzOIhLejK9iMNzUYLjxe3fo
        Hu9+waB70UJAo7uFAWe5HcHy2xXqSBI/1WMieJ3dQPPNpmbEj3g9mF9eKkX8H60yfr7MEJKK
        iwi+Z8JJ87fm1CTfVTnG8IG/f+Br2rP4qnIv4gu7HiG+oyFWtj8p8tApIfV0tqDcffjHSIV2
        3oEziz+60G20M2rk4wpQhIhjP+Wu1T2m1vEWbvillS5AkSIJW4e4cZ8Xr5PLBHd/rJgMp2g2
        nuuwmNdSm1kbx6knPThsYPZnbq5/CYXxJvYot3pdT4Qxye7gCrQVaxVilud6NFp6vW47N9BX
        tqZHhHSztXGtQMImcB5NB2VA4hq0oQlFCVknM1U/paTti1PJ01RZ6SlxJzPS2tH61wU7UV3f
        ASdiRUi6Ubzhk68TJZQ8W3UxzYk4EZZuFn/2jSxRIj4lv5gjKDNOKLNSBZUTbROR0q1i472F
        7yRsivyccEYQMgXle5cQRUSrUfLg1dG+Sxmo++6hqDt/6onR5JgB35G3VkWn/3jbk+CODy29
        yYtxizNBvyPBojAfq6/9/tFk7wV7U9EWfXL59ofxHz/IMQ4lZOdvO193IOVsIEY77tqZZCzR
        xeR7ak649/8TfT5PWzhvPZardO18/qX0i7ylD3Z95bINy0yrysp8i5RUKeR7Y7FSJf8fFpIK
        mXEDAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53745
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
 include/linux/swiotlb.h | 10 +++++-----
 lib/swiotlb.c           | 13 +++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 017fced60242..5f81f8a187f2 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 struct device;
-struct dma_attrs;
 struct page;
 struct scatterlist;
 
@@ -68,10 +67,10 @@ swiotlb_free_coherent(struct device *hwdev, size_t size,
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs);
+				   unsigned long attrs);
 extern void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 
 extern int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
@@ -83,12 +82,13 @@ swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
 
 extern int
 swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
-		     enum dma_data_direction dir, struct dma_attrs *attrs);
+		     enum dma_data_direction dir,
+		     unsigned long attrs);
 
 extern void
 swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 		       int nelems, enum dma_data_direction dir,
-		       struct dma_attrs *attrs);
+		       unsigned long attrs);
 
 extern void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 76f29ecba8f4..22e13a0e19d7 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -738,7 +738,7 @@ swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
 dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    unsigned long offset, size_t size,
 			    enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
 	dma_addr_t dev_addr = phys_to_dma(dev, phys);
@@ -807,7 +807,7 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			size_t size, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	unmap_single(hwdev, dev_addr, size, dir);
 }
@@ -877,7 +877,7 @@ EXPORT_SYMBOL(swiotlb_sync_single_for_device);
  */
 int
 swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
-		     enum dma_data_direction dir, struct dma_attrs *attrs)
+		     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -914,7 +914,7 @@ int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	       enum dma_data_direction dir)
 {
-	return swiotlb_map_sg_attrs(hwdev, sgl, nelems, dir, NULL);
+	return swiotlb_map_sg_attrs(hwdev, sgl, nelems, dir, 0);
 }
 EXPORT_SYMBOL(swiotlb_map_sg);
 
@@ -924,7 +924,8 @@ EXPORT_SYMBOL(swiotlb_map_sg);
  */
 void
 swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-		       int nelems, enum dma_data_direction dir, struct dma_attrs *attrs)
+		       int nelems, enum dma_data_direction dir,
+		       unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -941,7 +942,7 @@ void
 swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 		 enum dma_data_direction dir)
 {
-	return swiotlb_unmap_sg_attrs(hwdev, sgl, nelems, dir, NULL);
+	return swiotlb_unmap_sg_attrs(hwdev, sgl, nelems, dir, 0);
 }
 EXPORT_SYMBOL(swiotlb_unmap_sg);
 
-- 
1.9.1
