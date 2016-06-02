Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:51:33 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:16047 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041792AbcFBPmNP6Au2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:13 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500CB0IA6Z110@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:07 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-d4-575053cef269
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id EF.7A.05254.EC350575; Thu,
 2 Jun 2016 16:42:06 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:06 +0100 (BST)
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
Subject: [RFC v3 33/45] mn10300: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:35 +0200
Message-id: <1464881987-13203-34-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe5zXwqs8aaC3FRDYo3LNAEGmu24GSbJEp8vbIwtIWHJoOoN
        mAFiC2yaJavU4lBwVyoVoWsQqhQthYImQERGh0VF0MrSqbPTgIKI0kp8C1S0Bfftd/7/85aT
        I8MKH6OU7SosFjWF6nwVG0kPLQyOxo98m5758YWmtVDRPc/BYLuOhaqRKxSY2+wsvKl2c+Cs
        bWMgUGbAYC3LA89xAw3+05UImm1pcG/2XwQzZfM0LDx9guHvF34WjrYYMRx2jHFQbkoF8+Qw
        gok7vRRYp1Kg/9ZLDoakRgpMzlh4/UIfKrzqxNDQ9znMWB5huOc4w8Ckqw6D+XYyBE8EKKio
        b+dg+lESnG56iOChdJeFGd8Agro+Hw0d414GjvYNczBQL1FgO+vAcLLcSsPlIwEG/Ae6WAj8
        NsPAaI+ZheYHrRgq28+HQr0nvNVBGqSaag7qrb/TMHb1BgXDlkEWJlxVNMzef4tBOqnHUHv9
        YugewWMYDHdbKWgZbuXAVdOLYP7VArM1izzot1DE0CuxxG6xIzLq9WAyP1eNyD+OdDJtlELS
        kSqK9I+5WNI4paNJd52PI4FnP5CGjhJSX+NFpLL7GiKdtg3pn2RFbtkp5u8qFTWJKTmReU/v
        TKMin/znObuD0iFb1CEUIRP4TcKQYYBa4pXCjf/a2EMoUqbgTyGho/E5HTYU/H5KeBwsDTPL
        bxQ6m62LSdG8UxB04x4cNjD/izA1OIfCvIJPE/pPBRd1ml8nmILji43kPBH8l3q5pWlxwhW3
        kQlzREi3trW8H7ZN8Og7GQnJG9CyMyhGLNlRpN2eW5CUoFUXaEsKcxN27C7oQEtP97wLNbk/
        cyFehlQfyG3rv85UMOpS7d4CFxJkWBUtL85Iz1TId6r37hM1u7M1Jfmi1oVWyWhVrPyPHv93
        Cj5XXSz+KIpFouZ/l5JFKHVIfzZ1rX0q0aDQ+6TxzfGvnwhbLMrqm8f1eVu9F7K/8X4Rc1u+
        LdlI0m5NOP86WHHz8Z4vx1DGqpzlZv8lkqhcE3fOvT+nRtpOfZj8U3zPyOhXblNK7Uu9+vsV
        m88bY8rRp31DsRlxJ5Imu7isc9ejotZ9ZFBGK1+ZZtsTUldn//mritbmqZM2YI1W/Q62sYPT
        cAMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53757
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
 arch/mn10300/mm/dma-alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mn10300/mm/dma-alloc.c b/arch/mn10300/mm/dma-alloc.c
index 8842394cb49a..4f4b9029f0ea 100644
--- a/arch/mn10300/mm/dma-alloc.c
+++ b/arch/mn10300/mm/dma-alloc.c
@@ -21,7 +21,7 @@
 static unsigned long pci_sram_allocated = 0xbc000000;
 
 static void *mn10300_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	unsigned long addr;
 	void *ret;
@@ -63,7 +63,7 @@ done:
 }
 
 static void mn10300_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long addr = (unsigned long) vaddr & ~0x20000000;
 
@@ -75,7 +75,7 @@ static void mn10300_dma_free(struct device *dev, size_t size, void *vaddr,
 
 static int mn10300_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -92,7 +92,7 @@ static int mn10300_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static dma_addr_t mn10300_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	return page_to_bus(page) + offset;
 }
-- 
1.9.1
