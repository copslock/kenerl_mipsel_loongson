Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:54:52 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49699 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041805AbcFBPmppOx02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:45 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500NZMIB10I00@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:37 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-2c-575053edd99d
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id A5.AA.05254.DE350575; Thu,
 2 Jun 2016 16:42:37 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:37 +0100 (BST)
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
Subject: [RFC v3 43/45] xtensa: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:45 +0200
Message-id: <1464881987-13203-44-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTZxTfd7/7olnnTZHxxSVL7B7JTIZjY+7ojNlCsl03lhE1lhCz2ckN
        GAFZCyjL/qgwQBHYla7gALuilYcCpZAlYtY13LHWx3A2mDKZHaa8ZGBbCe5BAVcg++/8Xvmd
        nBweawLMJv5wfqFkyNfnalkVfXPFO/zqw73putdGZ+LhVH+UA2+PiYWaW9cpaHZ0srBc5+HA
        edbBQKS0HIO9NAd8DeU0hFurEbS1fwRj878jCJVGaVh5OIfhzuMwC2c6zBhOdwc5qKh/F5qn
        hxBMjboosM/sgoHf/uLgpnyegnpnIvzzuCwWvOHEYHO/DSHrAwxj3ZcYmFYaMTTffR2Wvo1Q
        cKqph4PZB8nQemESwaR8j4VQYBBBoztAQ++4n4Ez7iEOBptkCtovd2NoqbDTcK02wkD4qyss
        RE6GGBi+2sxC20QXhuqe72OwzLe6VSUNsqWOgyb71zQEb9ymYMjqZWFKqaFh/v4TDHJLGYaz
        v/4Yu8fSNxjK73VR0DHUxYFicSGI/r3CvJMpTgxYKbHcJbNip7UTicN+Hxaji3VIHOlOF2fN
        coyqraHEgaDCiudnTLTY3xjgxMijT0Rbb5HYZPEjsbr/FyT2tW9J35ap2pkl5R4ulgxbdx1U
        5ThbZLrAEn/ca16gTKh2QxWK44mQQhZ9U8z6/Cy5/YeDrUIqXiNcROTid4NoHZygyN3lSmrV
        xQpvkL42+5pro+AkxDTuw6sCFr4kM97FWILn44U04hzRr9K08BKR/1TWsmpBJEuPbtHrbc+T
        6x7zWnNcjLc7OtZ4jfA+8ZX1MTJS29BTl1CCVHSowPhZdl5yklGfZyzKz046dDSvF60/3cIV
        dMGzQ0ECj7RPq9tf+VinYfTFxpI8BREeazeqC/ek6zTqLH3JF5Lh6KeGolzJqKDneFqbqD53
        NbxPI2TrC6UjklQgGf5XKT5ukwm16ho3jDNzKV3PZLxn/oHUn5g+nrY57cNROvPJi8SvSQhV
        Lft3vzkZzPp8InX7ZZtO3k9n/3zy9HTSywdU++b2Hmnz/JuAzwXvKFNywwcNKbbOA86SFxId
        4YyVSuvObWPHMlKLZyddWZbNP817AspbiftTr7ncu6WRioU9oSgLbi1tzNEnb8EGo/4/i3zJ
        FXADAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53767
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
 arch/xtensa/kernel/pci-dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index cd66698348ca..1e68806d6695 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -142,7 +142,7 @@ static void xtensa_sync_sg_for_device(struct device *dev,
 
 static void *xtensa_dma_alloc(struct device *dev, size_t size,
 			      dma_addr_t *handle, gfp_t flag,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	unsigned long ret;
 	unsigned long uncached = 0;
@@ -171,7 +171,7 @@ static void *xtensa_dma_alloc(struct device *dev, size_t size,
 }
 
 static void xtensa_dma_free(struct device *hwdev, size_t size, void *vaddr,
-			    dma_addr_t dma_handle, struct dma_attrs *attrs)
+			    dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long addr = (unsigned long)vaddr +
 		XCHAL_KSEG_CACHED_VADDR - XCHAL_KSEG_BYPASS_VADDR;
@@ -185,7 +185,7 @@ static void xtensa_dma_free(struct device *hwdev, size_t size, void *vaddr,
 static dma_addr_t xtensa_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t size,
 				  enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	dma_addr_t dma_handle = page_to_phys(page) + offset;
 
@@ -195,14 +195,14 @@ static dma_addr_t xtensa_map_page(struct device *dev, struct page *page,
 
 static void xtensa_unmap_page(struct device *dev, dma_addr_t dma_handle,
 			      size_t size, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	xtensa_sync_single_for_cpu(dev, dma_handle, size, dir);
 }
 
 static int xtensa_map_sg(struct device *dev, struct scatterlist *sg,
 			 int nents, enum dma_data_direction dir,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -217,7 +217,7 @@ static int xtensa_map_sg(struct device *dev, struct scatterlist *sg,
 static void xtensa_unmap_sg(struct device *dev,
 			    struct scatterlist *sg, int nents,
 			    enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
-- 
1.9.1
