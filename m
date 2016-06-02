Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:44:02 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15692 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041772AbcFBPlCZcL12 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:02 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008M2I87TS10@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:56 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-02-57505387562d
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 04.2A.05254.78350575; Thu,
 2 Jun 2016 16:40:55 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:55 +0100 (BST)
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
Subject: [RFC v3 10/45] cris: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:12 +0200
Message-id: <1464881987-13203-11-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTG9973frWhyV0BudHEP4qGaIKKk+1ENzMTzV6/IokkLM4wq16B
        SJG0gjJNVkBAJh9XENSCBLRKYVC+oqFEJHSGqgjYsLDpWlAEC3GUamRTULSF+N/veZ5zck5O
        Do/Vw8xSPinluKRP0SZrWCXdO+8YjMzbGxO3zjkTAfm2OQ4czUYWCvvvU1DZ1MDCh5IeDlou
        NTHgy8rBYM5KBOfFHBqmbxQgqLXshpHX/yDwZs3RMD/1L4Y/Z6ZZOF9XiuGcdZSD3PItUOnp
        Q/DiSScF5snN0P33fxz0ylcpKG8Jg7cz2f7GBy0Yqrs2gbdqAsOItZ4Bj92EofLxenh/2UdB
        fkUzBy8nouDGtXEE47KLBa/7LgJTl5uG1udDDJzv6uPgboVMgeV3K4aaXDMN94p8DEyfaWfB
        d9bLwGBHJQu1Y40YCppv+mW2M7BVHg1yWQkHFeZiGkYfPKKgr8rBwgt7IQ2vn37EINdkY7g0
        cMd/j/cXMOS4Gimo62vkwF7WiWDu/3nm+31krLuKIjmdMksaqhoQGRxyYjI3W4LIX9YY8rJU
        9ltFhRTpHrWz5OqkkSY2k5sjvlfxpLo1jVSUDSFSYHuISJtldczX+5TfHpaSk9Il/drNB5SJ
        ss1Np/YGnXSd8WAjalP+hhS8KGwQz5n62UVeIj4abvKzklcL15FoLc/CiyKTEkeK3uFAFSt8
        JbbVmheqQoQWUTQ+dy4EWDgtTjpmUYCDhR1i/mMHFWBaWCnedo0tsEogYv7Nfnpx3HLxfk8p
        E2CF3zc31S34auEH0ZndxshIVY2+qEehUtqhVMPBBF3UGoNWZ0hLSVhz6JiuFS1+3Zt2dK1n
        ox0JPNIEqSyr9sSpGW26IUNnRyKPNSGq3N0xcWrVYW3GL5L+2M/6tGTJYEfLeFoTprrSMR2r
        FhK0x6WjkpQq6T+nFK9YakTk15rtdyLaMwwDp7Zu+1FRbFGkB7u+Sxq/MKyM+qZ42f63mSE/
        5f2RvGdsZ1L4ge1T+yOjQ90d3PXZaE/QUYFXDHRHh5uiuRMlsW+swfVhug/xBacLYz1H6kKf
        3FLF347sj59YkUlsU74VEVO95V/Wh2Q2DtvW75p89ir81JFxx16vhjYkaqNWY71B+wl52ieR
        cQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53734
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
 arch/cris/arch-v32/drivers/pci/dma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/pci/dma.c b/arch/cris/arch-v32/drivers/pci/dma.c
index 8d5efa58cce1..1f0636793f0c 100644
--- a/arch/cris/arch-v32/drivers/pci/dma.c
+++ b/arch/cris/arch-v32/drivers/pci/dma.c
@@ -17,7 +17,7 @@
 #include <asm/io.h>
 
 static void *v32_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp,  struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -37,22 +37,21 @@ static void *v32_dma_alloc(struct device *dev, size_t size,
 }
 
 static void v32_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
 static inline dma_addr_t v32_dma_map_page(struct device *dev,
 		struct page *page, unsigned long offset, size_t size,
-		enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	return page_to_phys(page) + offset;
 }
 
 static inline int v32_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	printk("Map sg\n");
 	return nents;
-- 
1.9.1
