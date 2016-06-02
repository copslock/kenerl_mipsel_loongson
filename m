Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:53:11 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49606 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041800AbcFBPm22eqi2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:28 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500M04IAM9W10@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:22 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-5d-575053dd8c52
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id C5.4C.04866.DD350575; Thu,
 2 Jun 2016 16:42:21 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:21 +0100 (BST)
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
Subject: [RFC v3 38/45] s390: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:40 +0200
Message-id: <1464881987-13203-39-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGfe97v6g2u1YnV01c0sSA34rLcrIZU7PE3ZE4O6Yh4Q+l6hWI
        fKUFN3VLKrUwWcErDBFoCGIREGgpxAiNSGiQClqlY0M3qG4oKAFpJdavarWF7L/fc87z5Jyc
        HBYrHlAr2LTMHFGbqUlX0jLyVsg1tMH7gzpx80sHwOnOIAOuVj0NRXf6CTDbmml4X9LHgP28
        jQJ/nhGDJS8VPOVGEnyXTAjqG3bBw9kRBDN5QRJCz6Yx/Bnw0XC2sRTDb9YxBvLP7QDzEzeC
        iX+6CLBMboee+y8ZuCXVEnDOHg2vA4ZwcMCOoab7K5ipforhofUyBU+clRjMf8fBuwo/Aaer
        WhmYeroFLl0cRzAujdIw4+1FUNntJaHt0TAFZ7vdDPRWSQQ0NFkxXMi3kHCz2E+B71QHDf5f
        ZygYcphpqH/cgsHUeiUsDZ7IVgUkSGUlDFRZzpAwNjBIgLvaRcOEs4iE2X8/YJAuGDCcv3s9
        fI93v2MwjrYQ0OhuYcBZ1oUg+CpEqZKExz3VhGDskmihuboZCUPDHiwE35Yg4Z5VLUyVSuFS
        cREh9Iw5aaF2Uk8KnZVeRvA/3yfUtOUKVWXDSDB13kZCe8Na9RdJsm2HxPS0o6J20/ZkWerI
        fxNk9oDyp7pXAaRHt1cWoiiW5z7n3f0hPM/L+MEHNroQyVgFV4f4kP0NOS9OEvz0yRAZcdHc
        Vr693jLnWsrZeV7/yDMXx9zP/KTrLYrwEi6eDxqamAiT3Gp+5H7dXFjOCbzZ5SDmx63i+/tK
        qQhHhesWW+OcR8F9w3sM7ZSE5DVowWX0qZh7MFt3ICUjbqNOk6HLzUzZeDArow3Nf12gA9X1
        felEHIuUi+QL1u9OVFCao7pjGU7Es1i5VJ6ToE5UyA9pjh0XtVn7tbnpos6JVrKkMlpe4fDt
        UXApmhzxiChmi9r/uwQbtUKP1qlG9t79LimhQJtu7H1Wc6opLuoIet6xLXBj+uKJwTd/xRSY
        Cm8kW67Gqr+3LY/ZmZS2hC03fP3trvHrXlW5KpnOr1WrTPU9aNniCs4n7dRTC4vj1yBHSqd1
        8+GFVOKGT170rzmQ8KNh6MS1P4D02KOVs8dlenfsZ1NZ8bG/OEeVpC5Vs2Ut1uo0HwG5PNVH
        cQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53762
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
 arch/s390/include/asm/dma-mapping.h |  1 -
 arch/s390/pci/pci_dma.c             | 23 ++++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 3249b7464889..ffaba07f50ab 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 1ea8c07eab84..159f767f9011 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -285,7 +285,7 @@ static inline void zpci_err_dma(unsigned long rc, unsigned long addr)
 static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long nr_pages, iommu_page_index;
@@ -331,7 +331,7 @@ out_err:
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long iommu_page_index;
@@ -354,7 +354,7 @@ static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 
 static void *s390_dma_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flag,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	struct page *page;
@@ -369,7 +369,7 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 	pa = page_to_phys(page);
 	memset((void *) pa, 0, size);
 
-	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, NULL);
+	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, 0);
 	if (dma_mapping_error(dev, map)) {
 		free_pages(pa, get_order(size));
 		return NULL;
@@ -383,19 +383,19 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 
 static void s390_dma_free(struct device *dev, size_t size,
 			  void *pa, dma_addr_t dma_handle,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 
 	size = PAGE_ALIGN(size);
 	atomic64_sub(size / PAGE_SIZE, &zdev->allocated_pages);
-	s390_dma_unmap_pages(dev, dma_handle, size, DMA_BIDIRECTIONAL, NULL);
+	s390_dma_unmap_pages(dev, dma_handle, size, DMA_BIDIRECTIONAL, 0);
 	free_pages((unsigned long) pa, get_order(size));
 }
 
 static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			   int nr_elements, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	int mapped_elements = 0;
 	struct scatterlist *s;
@@ -404,7 +404,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nr_elements, i) {
 		struct page *page = sg_page(s);
 		s->dma_address = s390_dma_map_pages(dev, page, s->offset,
-						    s->length, dir, NULL);
+						    s->length, dir, 0);
 		if (!dma_mapping_error(dev, s->dma_address)) {
 			s->dma_length = s->length;
 			mapped_elements++;
@@ -418,7 +418,7 @@ unmap:
 	for_each_sg(sg, s, mapped_elements, i) {
 		if (s->dma_address)
 			s390_dma_unmap_pages(dev, s->dma_address, s->dma_length,
-					     dir, NULL);
+					     dir, 0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
@@ -428,13 +428,14 @@ unmap:
 
 static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			      int nr_elements, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nr_elements, i) {
-		s390_dma_unmap_pages(dev, s->dma_address, s->dma_length, dir, NULL);
+		s390_dma_unmap_pages(dev, s->dma_address, s->dma_length, dir,
+				     0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
-- 
1.9.1
