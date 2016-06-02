Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:42:37 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15604 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041765AbcFBPkxgtKA2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:53 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500AJ6I7YB610@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:47 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-ec-5750537e2c53
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 70.1A.05254.E7350575; Thu,
 2 Jun 2016 16:40:46 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:46 +0100 (BST)
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
Subject: [RFC v3 07/45] avr32: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:09 +0200
Message-id: <1464881987-13203-8-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSbUxTZxTee9/7BazJtXPzosl+dGERo2zoMo9CnMgyr9nISDQhQbOtkzsw
        QiEtGCWLqZSyVfkoIBVo1yBUWrS0FEYGZKyjcXTAUDsmm9qKIqIoox0ZzlhFW8n+nefjPOfk
        5LBY6qfWsocUxaJSIc+X0bHk2LJ3YtPxvZlZ71rPxYOuP8yAt0tNQ9WlEQJMTjsNz+qGGXA1
        OikIlWkxWMrywHdGS0KwvRKB1ZYBU4s3ECyUhUlY/nsewx9LQRpqO+oxnHJMM1BhSAPTvXEE
        s9cHCbDM7YChvx4xMKZvJcDgWgOPlzSRxlEXhhZ3CiyY72OYcpyn4J6nGYPp2mZ42hQiQGfs
        YuDh/WRob7uL4K7eT8NC4CKCZneAhO47kxTUuscZuGjUE2C74MBwtsJCwq/VIQqC5X00hL5d
        oGBiwESDdaYTQ2VXbwRqfNGtviFB31DHgNFSQ8L06BUCxs1eGmY9VSQs3nqOQX9Wg6Hx8k+R
        ezw9jUHr7ySgY7yTAU/DIILwf8vUzmxhZshMCNpBPS3YzXYkTEz6sBB+UoeEPx2ZwsN6fYSq
        riKEoWkPLbTOqUmhvznACKF/PhNauksEY8MkEir7f0NCj21D5vvZsak5Yv6hI6LynR1fxOYt
        NfnJokeSo7pTNlqNBuNOohiW597jL10bQyv1G/yVm076JIplpdw5xNtuu6kVcILg50YnyaiL
        5rbwPVbLS9dqzsXz6js+HBUw9zU/530SiWLZ17iP+e9/kURpkkvgmwKLZJSWcLv5xb4PV4a9
        yY8M11PROoYTeIuz42W8NGLxaXooPZK0oFfOo9fFkoNFqi9zC5KTVPICVYkiN+lgYUE3Wvm5
        f/tQ2/B2D+JYJHtVYkv8NEtKyY+ojhV4EM9i2WpJRUZmllSSIz9WKioLP1eW5IsqD1rHkrI1
        ku8GgvukXK68WDwsikWi8n+VYGPWqpGj/O23fsirNtq16Zvdt06PqE940WO7JiXHBNQnjfyD
        rQmbllJ9rrRea8r88fi2lLSjZt1M9hTeVXrZH26trTKsKnQeSN2omJonDQm69Pbe9HgKfjT2
        DsQ1t3Yl/ry7u9yQUXw1ruaj0URXzSxwv3+VVPrBtvWBB6qgQrlnf7qMVOXJkzdgpUr+AuyJ
        jadvAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53730
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
 arch/avr32/mm/dma-coherent.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/avr32/mm/dma-coherent.c b/arch/avr32/mm/dma-coherent.c
index 92cf1fb2b3e6..fc51f4421933 100644
--- a/arch/avr32/mm/dma-coherent.c
+++ b/arch/avr32/mm/dma-coherent.c
@@ -99,7 +99,7 @@ static void __dma_free(struct device *dev, size_t size,
 }
 
 static void *avr32_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	struct page *page;
 	dma_addr_t phys;
@@ -119,7 +119,7 @@ static void *avr32_dma_alloc(struct device *dev, size_t size,
 }
 
 static void avr32_dma_free(struct device *dev, size_t size,
-		void *cpu_addr, dma_addr_t handle, struct dma_attrs *attrs)
+		void *cpu_addr, dma_addr_t handle, unsigned long attrs)
 {
 	struct page *page;
 
@@ -142,7 +142,7 @@ static void avr32_dma_free(struct device *dev, size_t size,
 
 static dma_addr_t avr32_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	void *cpu_addr = page_address(page) + offset;
 
@@ -152,7 +152,7 @@ static dma_addr_t avr32_dma_map_page(struct device *dev, struct page *page,
 
 static int avr32_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
-- 
1.9.1
