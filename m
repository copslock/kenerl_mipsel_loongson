Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:44:40 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45149 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041773AbcFBPlGr6cT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:06 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500DRHI8G1J40@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:05 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-5e-5750539075fe
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 74.DB.04866.09350575; Thu,
 2 Jun 2016 16:41:04 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:04 +0100 (BST)
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
Subject: [RFC v3 13/45] drm/mediatek: dma-mapping: Use unsigned long for
 dma_attrs
Date:   Thu, 02 Jun 2016 17:39:15 +0200
Message-id: <1464881987-13203-14-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH/d3ffbS4ZteqeIPJTErmK+IDjTtxi7pE410isQEjUSNa9QaM
        vNaKmcZstVicSPEKQ4Q2BLDKG0pRAyS1tjFUQJSKwSmiDQIC1VKNiLGKthD/+5zz/Z6cb06O
        BMufUxGSI6nHBHWqKllBh5GdU66eKDFOGb86a3IVnGsJMOCyaGkw3G8nwNRQS8OXvDYGGi83
        UODX6TGYdUngLtSTMH4tB0FFZQy8eNeHwKcLkDD15jWGRxPjNFysysdwvn6AgaxLv4PpVReC
        4ac2AsyjG8Hx/wcGOsVyAi41LoCPE5nBwY5GDKX2X8FXMoLhRX01Ba+cxRhMT6Lhc5GfgHNG
        CwPekTVw7coQgiHxGQ2+/jsIiu39JFhf9lJw0d7FwB2jSEBlTT2GsiwzCXdz/RSMn2mmwf+v
        j4KeVhMNFYN1GHIsN4JlpjuU6iwJYkEeA0bzBRIGOroJ6Cpx0TDsNJDwzvMVg1iWieHyg1vB
        e3z+D4P+WR0BVV11DDgLbAgCk1PU5j38oKOE4PU2keZrS2oR39PrxnzgUx7iH9creW++GGzl
        GgjeMeCk+fJRLcm3FPczvP9tAl9qzeCNBb2Iz2m5h/imyuXK9XvCfjssJB85LqhXbTwQlvTw
        Zjad7pj/1+lbw0iL3s7JRlIJx67jLlgN5AyHc93PG+hsFCaRs1cRV1A0wMwUpwmuyfaYDrlo
        di3XVGGeds1jGzlO+9KNQwJmT3Gjrk8oxHPZndzgow4mxCT7M1fTbSBCLGN5TvfRRs2s+4lr
        b8ufZmmwb26omo4hZ7dx7swmSkSyUjSrGs0XMg6law4mpkSv1KhSNBmpiSsPpaVY0czXTTSj
        q20bnIiVIMUPslkrdsTLKdVxzYkUJ+IkWDFP9kusMl4uO6w6cVJQp+1XZyQLGidaKCEVC2RF
        reM75Wyi6phwVBDSBfV3lZBII7So7+ammq3lO86EezdZYwOwNCrqbLt3rHpk+2Rcfl52gqs3
        cqtp7N6Qx6ucvaVntFPZWrGlfUnCrvfLIm8UqsY+7L79MGJ1zL6A/dSip3N0f8dvb3aER/9B
        LjHe/ScmcoV04kef7M/bgTrcZim87nlvqfLk7l2f27dYLw33pMX2l1nsClKTpFqzHKs1qm8f
        LsGEcQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53736
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
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 13 ++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_gem.h |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index fa2ec0cd00e8..7abc550ebc00 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -54,15 +54,14 @@ struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_device *dev,
 
 	obj = &mtk_gem->base;
 
-	init_dma_attrs(&mtk_gem->dma_attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &mtk_gem->dma_attrs);
+	mtk_gem->dma_attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (!alloc_kmap)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &mtk_gem->dma_attrs);
+		mtk_gem->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	mtk_gem->cookie = dma_alloc_attrs(priv->dma_dev, obj->size,
 					  &mtk_gem->dma_addr, GFP_KERNEL,
-					  &mtk_gem->dma_attrs);
+					  mtk_gem->dma_attrs);
 	if (!mtk_gem->cookie) {
 		DRM_ERROR("failed to allocate %zx byte dma buffer", obj->size);
 		ret = -ENOMEM;
@@ -93,7 +92,7 @@ void mtk_drm_gem_free_object(struct drm_gem_object *obj)
 		drm_prime_gem_destroy(obj, mtk_gem->sg);
 	else
 		dma_free_attrs(priv->dma_dev, obj->size, mtk_gem->cookie,
-			       mtk_gem->dma_addr, &mtk_gem->dma_attrs);
+			       mtk_gem->dma_addr, mtk_gem->dma_attrs);
 
 	/* release file pointer to gem object. */
 	drm_gem_object_release(obj);
@@ -173,7 +172,7 @@ static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj,
 	vma->vm_pgoff = 0;
 
 	ret = dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
-			     mtk_gem->dma_addr, obj->size, &mtk_gem->dma_attrs);
+			     mtk_gem->dma_addr, obj->size, mtk_gem->dma_attrs);
 	if (ret)
 		drm_gem_vm_close(vma);
 
@@ -224,7 +223,7 @@ struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj)
 
 	ret = dma_get_sgtable_attrs(priv->dma_dev, sgt, mtk_gem->cookie,
 				    mtk_gem->dma_addr, obj->size,
-				    &mtk_gem->dma_attrs);
+				    mtk_gem->dma_attrs);
 	if (ret) {
 		DRM_ERROR("failed to allocate sgt, %d\n", ret);
 		kfree(sgt);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
index 3a2a5624a1cb..2752718fa5b2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
@@ -35,7 +35,7 @@ struct mtk_drm_gem_obj {
 	void			*cookie;
 	void			*kvaddr;
 	dma_addr_t		dma_addr;
-	struct dma_attrs	dma_attrs;
+	unsigned long		dma_attrs;
 	struct sg_table		*sg;
 };
 
-- 
1.9.1
