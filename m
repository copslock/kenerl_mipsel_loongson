Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:53:51 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49650 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041802AbcFBPmegtKA2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:34 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500NZIIAS0I00@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:28 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-12-575053e4fe76
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 77.9A.05254.4E350575; Thu,
 2 Jun 2016 16:42:28 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:27 +0100 (BST)
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
Subject: [RFC v3 40/45] sparc: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:42 +0200
Message-id: <1464881987-13203-41-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTGfb/3u4E2fladXzRT02RRzHTiLSdeyMz+8A1GJboEo0at8A2I
        FEkLTNQsFQTnBvoJogiFVK20IJdehhESJK1KFSxSUcacTAKIEl1biHgBxbWS/fc7z3NOnpOT
        w2NlDzOXT0pJk7Qp6mQVG063Tbg7lw7siIld/trIw6mGcQ7cVj0L+e33KDDUVbPwqaCFA1tx
        HQOBrBwMpqxE8F7IocFfkYfAbNkCz0b+RuDLGqdh4t/XGB6N+lk4W1mI4ffaPg5yz28EwwsP
        gsEnTRSYhqLA2f2Wgzb5MgXnbXPg/Wh2cLDVhsHYvA585S8xPKutYuCFqwSD4a8V8PFigIJT
        pVYOXr2MhIorzxE8l5+y4Ou5jaCkuYcGe38XA2ebPRzcLpUpsFyrxXAp10TD3dMBBvwnbrAQ
        +NXHQGejgQXzQA2GPGt9sMz2hrY6SYNcVMBBqekMDX2tHRR4yt0sDLryaRjp/YxBvpSNofjB
        zeA9Pp7DkPO0hoJKTw0HrqImBOPvJpjvd5EBZzlFcppkllSXVyPS2eXFZHysAJE/a2PIq0I5
        KJ3Op4izz8WSy0N6mjSU9HAkMLyXGO3ppLSoC5G8hvuIOCxLYtbsCl8fLyUnZUja76L2hyda
        ypw4tf2Hw32eQaRHttW/oTBeFFaJAbOdneSvxI5/6oIcziuFq0gszj1JhQylcJwS2z5HhZgV
        VooOs+lL0yzBJor6fi8OGVg4Jg65x1CIZwqbxY7GYS7EtPCN6HMe/6IrBCI+NFzEk2nzxXst
        hUyIw4K6qa6SngzbJHqzHYyMFEY0pQrNltLjUnUHEjSRy3RqjS49JWFZ3CGNHU0+3Zsb6ErL
        WhcSeKSaprBEbItVMuoMXabGhUQeq2Yp0rbHxCoV8erMI5L20D5terKkc6F5PK2aoyhr9P+o
        FBLUadJBSUqVtP+7FB82V48ipmXc7R2bHn2rTDhMO9ZH/CzvMKyqzz16/ac1yrixkQXXV1q2
        LXZHb3Ae+FC8zvT4vnXjjO5Hyf3u/sVfb+r4lPTHzvr3u2eOBob3OO70ynGpZv+3lJgZFTDi
        qni93eXfH91wYkNT+5lfRltXZJHCgu75NZrVETMWVSycGr91wZMEq4rWJaojl2CtTv0fvZhn
        LHADAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53764
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
 arch/sparc/kernel/iommu.c     | 12 ++++++------
 arch/sparc/kernel/ioport.c    | 24 ++++++++++++------------
 arch/sparc/kernel/pci_sun4v.c | 12 ++++++------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 37686828c3d9..5c615abff030 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -196,7 +196,7 @@ static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
 
 static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	unsigned long order, first_page;
 	struct iommu *iommu;
@@ -245,7 +245,7 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_4u_free_coherent(struct device *dev, size_t size,
 				 void *cpu, dma_addr_t dvma,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct iommu *iommu;
 	unsigned long order, npages;
@@ -263,7 +263,7 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct iommu *iommu;
 	struct strbuf *strbuf;
@@ -385,7 +385,7 @@ do_flush_sync:
 
 static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      size_t sz, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct iommu *iommu;
 	struct strbuf *strbuf;
@@ -431,7 +431,7 @@ static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			 int nelems, enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s, *outs, *segstart;
 	unsigned long flags, handle, prot, ctx;
@@ -607,7 +607,7 @@ static unsigned long fetch_sg_ctx(struct iommu *iommu, struct scatterlist *sg)
 
 static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	unsigned long flags, ctx;
 	struct scatterlist *sg;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index ffd5ff4678cf..2344103414d1 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -260,7 +260,7 @@ EXPORT_SYMBOL(sbus_set_sbus64);
  */
 static void *sbus_alloc_coherent(struct device *dev, size_t len,
 				 dma_addr_t *dma_addrp, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct platform_device *op = to_platform_device(dev);
 	unsigned long len_total = PAGE_ALIGN(len);
@@ -315,7 +315,7 @@ err_nopages:
 }
 
 static void sbus_free_coherent(struct device *dev, size_t n, void *p,
-			       dma_addr_t ba, struct dma_attrs *attrs)
+			       dma_addr_t ba, unsigned long attrs)
 {
 	struct resource *res;
 	struct page *pgv;
@@ -355,7 +355,7 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 static dma_addr_t sbus_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t len,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	void *va = page_address(page) + offset;
 
@@ -371,20 +371,20 @@ static dma_addr_t sbus_map_page(struct device *dev, struct page *page,
 }
 
 static void sbus_unmap_page(struct device *dev, dma_addr_t ba, size_t n,
-			    enum dma_data_direction dir, struct dma_attrs *attrs)
+			    enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_release_scsi_one(dev, ba, n);
 }
 
 static int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+		       enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_get_scsi_sgl(dev, sg, n);
 	return n;
 }
 
 static void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n,
-			  enum dma_data_direction dir, struct dma_attrs *attrs)
+			  enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_release_scsi_sgl(dev, sg, n);
 }
@@ -429,7 +429,7 @@ arch_initcall(sparc_register_ioport);
  */
 static void *pci32_alloc_coherent(struct device *dev, size_t len,
 				  dma_addr_t *pba, gfp_t gfp,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
 	void *va;
@@ -482,7 +482,7 @@ err_nopages:
  * past this call are illegal.
  */
 static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba, struct dma_attrs *attrs)
+				dma_addr_t ba, unsigned long attrs)
 {
 	struct resource *res;
 
@@ -518,14 +518,14 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	/* IIep is write-through, not flushing. */
 	return page_to_phys(page) + offset;
 }
 
 static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
+			     enum dma_data_direction dir, unsigned long attrs)
 {
 	if (dir != PCI_DMA_TODEVICE)
 		dma_make_coherent(ba, PAGE_ALIGN(size));
@@ -548,7 +548,7 @@ static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
  */
 static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
 			int nents, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int n;
@@ -567,7 +567,7 @@ static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
  */
 static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
 			   int nents, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int n;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 836e8cef47e2..61c6f935accc 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -130,7 +130,7 @@ static inline long iommu_batch_end(void)
 
 static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
 	struct iommu *iommu;
@@ -213,7 +213,7 @@ static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
 }
 
 static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
-				 dma_addr_t dvma, struct dma_attrs *attrs)
+				 dma_addr_t dvma, unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -235,7 +235,7 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct iommu *iommu;
 	unsigned long flags, npages, oaddr;
@@ -294,7 +294,7 @@ iommu_map_fail:
 
 static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      size_t sz, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -322,7 +322,7 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			 int nelems, enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s, *outs, *segstart;
 	unsigned long flags, handle, prot;
@@ -466,7 +466,7 @@ iommu_map_failed:
 
 static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
-- 
1.9.1
