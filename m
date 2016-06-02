Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:46:40 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49263 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041780AbcFBPlYEdZ72 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:24 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500MZ6I8W9W00@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:21 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-96-5750539fcf58
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 7E.EB.04866.F9350575; Thu,
 2 Jun 2016 16:41:20 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:19 +0100 (BST)
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
Subject: [RFC v3 18/45] iommu: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:20 +0200
Message-id: <1464881987-13203-19-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGee97P0pdk2tleoOJxhrMYjbnx6Inapybmb7RGBudYjTRdXoD
        ZBRIa4luLKsgqAX0CoJCGwLaAkWgtNVNzDpCQ0ALqA0LOgQ04EcZs3QalFlgtrD993ue55yc
        k5Mjw8pBJl6WknZM1KVpUlWsnO6c7uj5pHKPOnHlPyYWzjaHOehoMrJQePcOBRZHPQtTRe0c
        OC87GAhl52KwZieD/1IuDWPVBQhqanfC41ePEASzwzRMv/wLw+/jYyxcsBdjyG8c4iCv9Auw
        vOhG8LzPQ4F1ZBO0PnzDQad0hYJS5wKYGM+JNPqcGCpbNkCwIoDhcWMdAy+85Rgsf6yGybIQ
        BWfNTRyMBlZB9dVnCJ5J/SwEB9oQlLcM0OAa7mXgQks3B21miYLaa40YqvKsNNw+F2Jg7NRN
        FkJnggz03LKwUPO0AUNB042IzPFHtzpNg1RSxIHZep6GId99CrorOlh47i2k4dWTfzFIVTkY
        Lt/7LXKPyYsYcvsbKLB3N3DgLfEgCL+dZjYfIE9bKyiS65FYUl9Rj0hPrx+T8LsiRB40qslo
        sRSxzhVSpHXIy5IrI0aaNJcPcCT09yFS6TIQc0kvIgXNXYi4a5er1x6QbzwqpqZkirpPN30j
        T3ZIJpzR/9HxN2YbMiL7EhOKlQn8Z8LgVB2e5fnC/UEHa0JymZK3IaFv0opnxUlK8I27ZqpY
        fo3grrHOVMXxTkEwDvtnAsxnCSMd71CU5/E7hMn2VirKNJ8g3HVamCgreCIM543+N26RcKe9
        eMaPjfhWh52OspLfJvhz3IyEFJUopg59KBqOZOi/TdKuXqHXaPWGtKQVR9K1LjT7deM3ka19
        vRfxMqT6QBHz8a5EJaPJ1J/QepEgw6o4xbrd6kSl4qjmxPeiLv2wzpAq6r1ooYxWLVCU3Rr7
        WsknaY6J34lihqj7P6VksfFG9ONXwcK3DwJb05d2+p68NLDryhzpnoMJ1TGOua74we0bF/eU
        5r+WewK2iayw+XTWyqoCd9zUkj+buwJ7L9UsLc2a/2XRyX2Gnye42w9L9nd9rj0e41vGZjpE
        29yFal1b/g3iWj+nb850r+mXn4wJ19zbTWu2HLye8qu4yM4IP0ydP6Wi9cmaVcuxTq95D3b6
        dutxAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53742
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
 drivers/iommu/amd_iommu.c | 12 ++++++------
 drivers/iommu/dma-iommu.c |  6 +++---
 include/linux/dma-iommu.h |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 634f636393d5..afbb0de6a7f5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2716,7 +2716,7 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 static dma_addr_t map_page(struct device *dev, struct page *page,
 			   unsigned long offset, size_t size,
 			   enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct protection_domain *domain;
@@ -2738,7 +2738,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
  * The exported unmap_single function for dma_ops.
  */
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+		       enum dma_data_direction dir, unsigned long attrs)
 {
 	struct protection_domain *domain;
 
@@ -2755,7 +2755,7 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
  */
 static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  int nelems, enum dma_data_direction dir,
-		  struct dma_attrs *attrs)
+		  unsigned long attrs)
 {
 	struct protection_domain *domain;
 	int i;
@@ -2803,7 +2803,7 @@ unmap:
  */
 static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
-		     struct dma_attrs *attrs)
+		     unsigned long attrs)
 {
 	struct protection_domain *domain;
 	struct scatterlist *s;
@@ -2825,7 +2825,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
  */
 static void *alloc_coherent(struct device *dev, size_t size,
 			    dma_addr_t *dma_addr, gfp_t flag,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
 	struct protection_domain *domain;
@@ -2879,7 +2879,7 @@ out_free:
  */
 static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct protection_domain *domain;
 	struct page *page;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..6c1bda504fb1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -286,7 +286,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	   or NULL on failure.
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -400,7 +400,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
 }
@@ -560,7 +560,7 @@ out_restore_sg:
 }
 
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	/*
 	 * The scatterlist segments are mapped into a single
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 8443bbb5c071..81c5c8d167ad 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -39,7 +39,7 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * the arch code to take care of attributes and cache maintenance
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
@@ -56,9 +56,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
  * directly as DMA mapping callbacks for simplicity
  */
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, unsigned long attrs);
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
-- 
1.9.1
