Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:52:54 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18634 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041799AbcFBPmWhmYH2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:22 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008MUIAID710@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:19 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-54-575053daa83a
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 4F.3C.04866.AD350575; Thu,
 2 Jun 2016 16:42:18 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:18 +0100 (BST)
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
Subject: [RFC v3 37/45] misc: mic: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:39 +0200
Message-id: <1464881987-13203-38-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH/d3ffdFYc60PbsSgNrpE45igIcdpzIzG3WVRGx2B+MdmlRsg
        PNMCUaKx8lBU0CusiLRpUKs8hEIhRnFhhAapRVEqiKhFkZcQB60arAMBW4n/fc73m+85JyeH
        xYqX1DI2LilV1CSpE5S0jHwwY+/88cV+VeSGkuFQONMwxYC9VkdD/iMHAcaaKhqmC1oZsBbX
        UODJzMFgzowF56UcEtw38hCUle+G1x9eIhjPnCJhZuw/DF0TbhouVhRiOGfpZ+BU0XYwvm1H
        MPyikQDz6DZo7vnEwAPpKgFF1kD4PJHlC7ZZMZQ2bYFx0wiG15ZKCt7aSjAYn4fBl8seAs4Y
        ahl4NxIKN64NIRiSXDSM97YgKGnqJaFuoJuCi03tDLQYJALKb1owXDllJuH+eQ8F7uw7NHhy
        xynovGukoWywGkNe7S1fmeX0b3WaBElfwIDBfIGE/rYOAtpNdhqGbfkkfOibxSBdycJQ/Phf
        3z2+/I0hx1VNQEV7NQM2fSOCKe8M9csBYbDZRAg5jRItVJmqkNDZ7cTC1GQBEp5ZVMK7Qskn
        nc8nhOZ+Gy1cHdWRQkNJLyN43v8plNalCQZ9NxLyGh4iob58nSr8gGxrtJgQly5qftp2UBZ7
        rlFM8a46YunT0zr0T9BZFMDy3Cb+TfYYOcdL+Y5XNbSfFdx1xDvags8imY9PEvzsyHvCb9Dc
        Rr6+zEz7jcWcled1A07sNzB3jB+1TyI/L+L28lUu77euJLeGb75f6QuzrJwTeIs7fm5YMO9o
        LaT8HOCTzTUV5NzgX3lnVj0lIXkpmleJlohph1O0h2ISw0K06kRtWlJMyOHkxDo093ITd9D1
        1p9tiGORcr583vq9kQpKna49mmhDPIuVi+Wp+1SRCnm0+miGqEn+S5OWIGptKIgllYHyy3fd
        fyi4GHWqGC+KKaLmu0uwAct0qGhn/MfVPaNJ/2d4rqWXr1hu13Audq0no2H17a0Rrujc5OcL
        3NxK1b2DO6JL+/rK9k97rb+15EVkn1hZPODQ5C6ZEb3x4YquffeGputin+wK+t2oHAheGLch
        17RZJulD17tD0PwfDMfDbdkXJgPp+uOzjqjJPa1PxyIqowYDwhdEKUltrDp0HdZo1V8B5OSR
        hm4DAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53761
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
 drivers/misc/mic/host/mic_boot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index e047efd83f57..9599d732aff3 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -38,7 +38,7 @@ static inline struct mic_device *vpdev_to_mdev(struct device *dev)
 static dma_addr_t
 _mic_dma_map_page(struct device *dev, struct page *page,
 		  unsigned long offset, size_t size,
-		  enum dma_data_direction dir, struct dma_attrs *attrs)
+		  enum dma_data_direction dir, unsigned long attrs)
 {
 	void *va = phys_to_virt(page_to_phys(page)) + offset;
 	struct mic_device *mdev = vpdev_to_mdev(dev);
@@ -48,7 +48,7 @@ _mic_dma_map_page(struct device *dev, struct page *page,
 
 static void _mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				size_t size, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	struct mic_device *mdev = vpdev_to_mdev(dev);
 
@@ -144,7 +144,7 @@ static inline struct mic_device *scdev_to_mdev(struct scif_hw_dev *scdev)
 
 static void *__mic_dma_alloc(struct device *dev, size_t size,
 			     dma_addr_t *dma_handle, gfp_t gfp,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -164,7 +164,7 @@ static void *__mic_dma_alloc(struct device *dev, size_t size,
 }
 
 static void __mic_dma_free(struct device *dev, size_t size, void *vaddr,
-			   dma_addr_t dma_handle, struct dma_attrs *attrs)
+			   dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -176,7 +176,7 @@ static void __mic_dma_free(struct device *dev, size_t size, void *vaddr,
 static dma_addr_t
 __mic_dma_map_page(struct device *dev, struct page *page, unsigned long offset,
 		   size_t size, enum dma_data_direction dir,
-		   struct dma_attrs *attrs)
+		   unsigned long attrs)
 {
 	void *va = phys_to_virt(page_to_phys(page)) + offset;
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
@@ -188,7 +188,7 @@ __mic_dma_map_page(struct device *dev, struct page *page, unsigned long offset,
 static void
 __mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		     size_t size, enum dma_data_direction dir,
-		     struct dma_attrs *attrs)
+		     unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -198,7 +198,7 @@ __mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 
 static int __mic_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			    int nents, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -229,7 +229,7 @@ err:
 static void __mic_dma_unmap_sg(struct device *dev,
 			       struct scatterlist *sg, int nents,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -327,7 +327,7 @@ static inline struct mic_device *mbdev_to_mdev(struct mbus_device *mbdev)
 static dma_addr_t
 mic_dma_map_page(struct device *dev, struct page *page,
 		 unsigned long offset, size_t size, enum dma_data_direction dir,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	void *va = phys_to_virt(page_to_phys(page)) + offset;
 	struct mic_device *mdev = dev_get_drvdata(dev->parent);
@@ -338,7 +338,7 @@ mic_dma_map_page(struct device *dev, struct page *page,
 static void
 mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		   size_t size, enum dma_data_direction dir,
-		   struct dma_attrs *attrs)
+		   unsigned long attrs)
 {
 	struct mic_device *mdev = dev_get_drvdata(dev->parent);
 	mic_unmap_single(mdev, dma_addr, size);
-- 
1.9.1
