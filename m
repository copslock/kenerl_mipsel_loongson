Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:46:02 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15745 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041778AbcFBPlUw20-2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:20 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500AJLI8QB610@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:14 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-82-5750539947b0
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id F5.EB.04866.99350575; Thu,
 2 Jun 2016 16:41:13 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:13 +0100 (BST)
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
Subject: [RFC v3 16/45] drm/rockship: dma-mapping: Use unsigned long for
 dma_attrs
Date:   Thu, 02 Jun 2016 17:39:18 +0200
Message-id: <1464881987-13203-17-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH+d3ffUFoctOh3GFiTNVkcY5NRXem85XF+NNksRETMnxsnd6B
        EZC0gI9MV+mqAwpewQq0HatanvIq6FKIjNAoiIjS4JCJTAOoELRUJ+qo4lrJ/vuc7ycn5+Tk
        8Fg5wETxe1PSJG2KJknFhtFd0x29n1hi1XGfXcyArCY/Bx31ehZyb3ZSYKurZuFtfjsHzqI6
        BnyZRgyOzETwFBppmCgzISiv+BruPx9A4M300zD99AmG25MTLJyqLMCQUzvEwfEz68H2uBvB
        o7stFDjG1kBb/0sOuuRzFJxxRsLrSUOg8boTg711FXhLRjHcr61i4LHbgsH211J4U+yjIMta
        z8H46BIoO/8QwUP5HgvewSsILK2DNDQM9zFwqrWbgytWmYKKC7UYzh530HAtz8fAxM8uFny/
        eBnobbaxUD5Sg8FUfylQGjzBrU7QIJvzObA6TtIwdL2Hgu6SDhYeuXNpeP7gHQb5rAFD0a0/
        Avd4cxqD8V4NBZXdNRy4zS0I/K+mmXXxZKSthCLGFpkl1SXViPT2eTDxT+UjcqdWTcYL5ECU
        l0uRtiE3S86N6WnSZBnkiO/ZLmJvSCdWcx8ipqYbiDRWLFKviA/7co+UtDdD0n665ruwxLtN
        LjZVjjp4OasH69H0rGzE86IQI5b2b8hGoQGcLfb8XccGWSmUInG0/+NsFBbgY5R4x9/6XrDC
        MrGx3MEGRYTgFEX9sAcHBRZ+FMc6plCQPxC2ibn/tL3PaWGh2Dx1kgqyQiBicb0Tz0ybK3a2
        FzBBDg3kjrpKembyRtFjaGRkpLCjkCo0S0rfnar7PiF5abROk6xLT0mI3r0/uQHNvNykC5W2
        r3QjgUeqcEXI4i1xSkaToTuU7EYij1URis+3quOUij2aQ4cl7f5vtelJks6N5vC0KlJR3Dyx
        TSkkaNKkfZKUKmn/txQfGqVHq190mr/pPR9f1bfAvj0nPC/jqw9jyi6F5Fx8Wt28xaiMXTuw
        Q8pU206/Xm5qjDiimF952/WF+adNXRZ0cKHVl/bDNRKy/RlbnJTtKPrVHnk1fKvHVRj928j4
        1K3YnZvhox3DeX+aDo9lsTH6+UffruINyn+P/M7P27TzamfpYu+BxFgVrUvULFmEtTrNf7aj
        x5huAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53740
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
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 +++++++----------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |  2 +-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 9c2d8a894093..7b1788e2a808 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -17,8 +17,6 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_vma_manager.h>
 
-#include <linux/dma-attrs.h>
-
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 
@@ -28,15 +26,14 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
 	struct drm_gem_object *obj = &rk_obj->base;
 	struct drm_device *drm = obj->dev;
 
-	init_dma_attrs(&rk_obj->dma_attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &rk_obj->dma_attrs);
+	rk_obj->dma_attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (!alloc_kmap)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &rk_obj->dma_attrs);
+		rk_obj->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	rk_obj->kvaddr = dma_alloc_attrs(drm->dev, obj->size,
 					 &rk_obj->dma_addr, GFP_KERNEL,
-					 &rk_obj->dma_attrs);
+					 rk_obj->dma_attrs);
 	if (!rk_obj->kvaddr) {
 		DRM_ERROR("failed to allocate %#x byte dma buffer", obj->size);
 		return -ENOMEM;
@@ -51,7 +48,7 @@ static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
 	struct drm_device *drm = obj->dev;
 
 	dma_free_attrs(drm->dev, obj->size, rk_obj->kvaddr, rk_obj->dma_addr,
-		       &rk_obj->dma_attrs);
+		       rk_obj->dma_attrs);
 }
 
 static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
@@ -70,7 +67,7 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	vma->vm_pgoff = 0;
 
 	ret = dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
-			     obj->size, &rk_obj->dma_attrs);
+			     obj->size, rk_obj->dma_attrs);
 	if (ret)
 		drm_gem_vm_close(vma);
 
@@ -262,7 +259,7 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 
 	ret = dma_get_sgtable_attrs(drm->dev, sgt, rk_obj->kvaddr,
 				    rk_obj->dma_addr, obj->size,
-				    &rk_obj->dma_attrs);
+				    rk_obj->dma_attrs);
 	if (ret) {
 		DRM_ERROR("failed to allocate sgt, %d\n", ret);
 		kfree(sgt);
@@ -276,7 +273,7 @@ void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, &rk_obj->dma_attrs))
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, rk_obj->dma_attrs))
 		return NULL;
 
 	return rk_obj->kvaddr;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index ad22618473a4..18b3488db4ec 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -23,7 +23,7 @@ struct rockchip_gem_object {
 
 	void *kvaddr;
 	dma_addr_t dma_addr;
-	struct dma_attrs dma_attrs;
+	unsigned long dma_attrs;
 };
 
 struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj);
-- 
1.9.1
