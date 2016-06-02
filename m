Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:45:19 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45277 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041770AbcFBPlO363x2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:14 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500GH1I8KC540@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:08 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-64-575053938c59
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 6A.DB.04866.39350575; Thu,
 2 Jun 2016 16:41:07 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:07 +0100 (BST)
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
Subject: [RFC v3 14/45] drm/msm: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:16 +0200
Message-id: <1464881987-13203-15-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH/d3ffdHQ7K5z40YzE5vsj7Hp1C14Mo0REuM1ztixLWSaCFVv
        QAUkrXW6aFLLwImA5TkeDYGuPO2DQoxghoTG0Al00JQgbEAJjwpRaNXxCC9tIf73PZ/v9+Sc
        nBwWy0apbeyF1CuiKlWZLKclZPe607Or4AdF3J7F2f1wp3WFAWejloacf54SYLCZaVjL72TA
        XmKjIKDLwGDSJYH7jwwS/DXZCGrrToD39X8I5nQrJKzPvsTQP++nIa++AMNd6zgDmcXRYHju
        QuD7t40A08wh6BhcYKBbbySg2B4BS/PpwcYuO4bK9gMwVzGNwWttoOC5owyDYWgfrJYGCLhT
        3sjAi+m9UPPnFIIp/TANcyNPEJS1j5DQNDFAQV67i4En5XoC6u5bMVRlmkj4OzdAgf+3FhoC
        v89R4HlkoKF20oIhu/FBsEx3h7a6TYK+KJ+BctM9Esa7+ghwVThp8DlySHg99haDviodQ0nv
        4+A9VgsxZAxbCKh3WRhwFLUhWFlcpw6fEiY7Kggho01PC+YKMxI8A24srCznI+GZVSG8KNAH
        UW4OIXSMO2jBOKMlhdayEUYIvDojVDZphPKiASRkt/YgobkuUhF1SnLwvJh84aqo+upQgiTp
        /xIXlfZQes1eZae1yC/JQmEsz33D+61N9Kb+hO8btQW1hJVx1Yj3OQ14s7hF8Gu6xyiUormv
        +eZa00ZqK2fnee2EG4cMzN3gZ5zLG6GPuBP8kLGGCGmS+4yfKPRucCkn8EtZJeTmuB38084C
        KqTDgtxkq9/gMu4o705vpvRIWom2NKCPRc25NPXZxJR9u9XKFLUmNXH3ucspTWjz6+ZbUHXn
        tw7EsUgeLt3y5ck4GaW8qr6e4kA8i+VbpftjFXEy6Xnl9V9F1eV4lSZZVDvQdpaUR0hLH/l/
        lHGJyiviJVFME1XvXYIN26ZF3DHZRE6g+C/T0r3C1Ybtnc5fcj/NWozJrebPOEq/iLrJ/fTd
        8GC4782HtvjYNY9tdXBhMurZ8Z1xJ2Ms5os/Ew2m0z0J8Xn9SbSl32P5/vh0/0hEewyb1Rt9
        bc18JG1oYWzgc2+sz+gqimidOqDTGL19H0TXJrRU5SlQ5Wxy+B45qU5S7o3EKrXyHU1Rvdtx        AwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53738
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
 drivers/gpu/drm/msm/msm_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 1f7de47d817e..9b806e576d35 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -230,11 +230,10 @@ static int msm_drm_uninit(struct device *dev)
 	}
 
 	if (priv->vram.paddr) {
-		DEFINE_DMA_ATTRS(attrs);
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+		unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
 		drm_mm_takedown(&priv->vram.mm);
 		dma_free_attrs(dev, priv->vram.size, NULL,
-			       priv->vram.paddr, &attrs);
+			       priv->vram.paddr, attrs);
 	}
 
 	component_unbind_all(dev, ddev);
@@ -299,21 +298,21 @@ static int msm_init_vram(struct drm_device *dev)
 	}
 
 	if (size) {
-		DEFINE_DMA_ATTRS(attrs);
+		unsigned long attrs = 0;
 		void *p;
 
 		priv->vram.size = size;
 
 		drm_mm_init(&priv->vram.mm, 0, (size >> PAGE_SHIFT) - 1);
 
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
-		dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+		attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+		attrs |= DMA_ATTR_WRITE_COMBINE;
 
 		/* note that for no-kernel-mapping, the vaddr returned
 		 * is bogus, but non-null if allocation succeeded:
 		 */
 		p = dma_alloc_attrs(dev->dev, size,
-				&priv->vram.paddr, GFP_KERNEL, &attrs);
+				&priv->vram.paddr, GFP_KERNEL, attrs);
 		if (!p) {
 			dev_err(dev->dev, "failed to allocate VRAM\n");
 			priv->vram.paddr = 0;
-- 
1.9.1
