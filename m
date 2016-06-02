Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:45:40 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18403 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041776AbcFBPlRqqNb2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:17 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008LTI8ND710@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:11 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-2c-5750539638d8
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id C4.3A.05254.69350575; Thu,
 2 Jun 2016 16:41:10 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:10 +0100 (BST)
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
Subject: [RFC v3 15/45] drm/nouveau: dma-mapping: Use unsigned long for
 dma_attrs
Date:   Thu, 02 Jun 2016 17:39:17 +0200
Message-id: <1464881987-13203-16-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGfe9773tLQ+dN5+TGfZjUuGUuc+KW5bgPM5ctvtEgTTRhIUYt
        egNmFEkr3Vj2R1egCqPuCoMBhYpaLGA/KGSZmDFC58APutlgcB90LAhI5yyVISOWlbWS/fc7
        z/OcnJOTo8DqMW6d4mjRcclQpCvUECV7IzE08nL9Xm3OFnlkG1T2xnkY6jITsP14jYFmn5vA
        vzWDPPgbfBzELBUYnJYCCH1VwcLshWoErvYsGJ/7DUHUEmchcf8vDLcezhI43VGL4XPvBA/W
        +h3QfDeIYPrXPgacke0w8PMCDzfkcwzU+zNg8WFZsvG6H0Nr/5sQdcxgGPd2cnA30ISh+Zet
        sNQYY6DS3sXDvZlMuHB+CsGUPEYgGr6CoKk/zEL3nVEOTvcHebhilxlov+jFcNbqZOHqqRgH
        s+WXCMRORjkYudxMwDXpwVDd9XWyLAultjrBglxXw4Pd+QULE9dvMhB0DBGYDthYmPtjGYN8
        tgxDw0/fJe+x9CWGijEPAx1BDw+Buj4E8X8S3Du5dHLAwdCKPplQt8ON6MhoCNP4oxpEb3u1
        9F6tnJRO2Rg6MBEg9FzEzNLepjBPYw8O0NbuEmqvG0W0uncY0Z72TdrXc5VvHZEKj5okwyvb
        DykL5rzfs8Wdqz9u+CZEzOhWehVSKEThNdE79UwVSkviWvHm7z6SYrXQhsSW2PtVSJnkzxhx
        sTyMUgYRXhV7XE6SMtYIflE03wnhlIGFT8XI0KPHoSeFvaK7MsKlmBU2ij/YFvgUqwQq1gan
        +ZVpz4nXBmsfZ9KSutPXwa5M3imGyno4Gala0apO9JRUcrjYmJevz9xs1OmNJUX5mw8f03ej
        lZ+bv4TOD74RQIICadJV7S9m56g5nclYqg8gUYE1a1TWLG2OWnVEV/qJZDh20FBSKBkD6GkF
        q8lQtVye3acW8nXHpQ8lqVgy/O8yirR1ZpSNM/6O3/aRk+k7HYvk4q6Plq1vL+mXbcHuxvV7
        7O8pxz9I7Na0DQ9Wjz2Yd/H8eNjS9u27Jse+57VX54Z3zGhK/ffzPC+tP7MtLfvPgkaPOK2s
        cetf2Giy5JHdT+xfdhSZTgS2up5dGyUJLXdg3lo+uajJitgWtuS62w52baAa1ligy9yEDUbd
        f+3GYO1vAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53739
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
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
index 6b8f2a19b2d9..a6a7fa0d7679 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
@@ -109,7 +109,7 @@ struct gk20a_instmem {
 	u16 iommu_bit;
 
 	/* Only used by DMA API */
-	struct dma_attrs attrs;
+	unsigned long attrs;
 };
 #define gk20a_instmem(p) container_of((p), struct gk20a_instmem, base)
 
@@ -293,7 +293,7 @@ gk20a_instobj_dtor_dma(struct nvkm_memory *memory)
 		goto out;
 
 	dma_free_attrs(dev, node->base.mem.size << PAGE_SHIFT, node->base.vaddr,
-		       node->handle, &imem->attrs);
+		       node->handle, imem->attrs);
 
 out:
 	return node;
@@ -386,7 +386,7 @@ gk20a_instobj_ctor_dma(struct gk20a_instmem *imem, u32 npages, u32 align,
 
 	node->base.vaddr = dma_alloc_attrs(dev, npages << PAGE_SHIFT,
 					   &node->handle, GFP_KERNEL,
-					   &imem->attrs);
+					   imem->attrs);
 	if (!node->base.vaddr) {
 		nvkm_error(subdev, "cannot allocate DMA memory\n");
 		return -ENOMEM;
@@ -597,10 +597,9 @@ gk20a_instmem_new(struct nvkm_device *device, int index,
 
 		nvkm_info(&imem->base.subdev, "using IOMMU\n");
 	} else {
-		init_dma_attrs(&imem->attrs);
-		dma_set_attr(DMA_ATTR_NON_CONSISTENT, &imem->attrs);
-		dma_set_attr(DMA_ATTR_WEAK_ORDERING, &imem->attrs);
-		dma_set_attr(DMA_ATTR_WRITE_COMBINE, &imem->attrs);
+		imem->attrs = DMA_ATTR_NON_CONSISTENT |
+			      DMA_ATTR_WEAK_ORDERING |
+			      DMA_ATTR_WRITE_COMBINE;
 
 		nvkm_info(&imem->base.subdev, "using DMA API\n");
 	}
-- 
1.9.1
