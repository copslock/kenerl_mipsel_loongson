Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:43:44 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18338 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041756AbcFBPk4E4St2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:56 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008LJI81D710@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:50 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-f2-575053810226
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id F6.1A.05254.18350575; Thu,
 2 Jun 2016 16:40:49 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:49 +0100 (BST)
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
Subject: [RFC v3 08/45] blackfin: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:10 +0200
Message-id: <1464881987-13203-9-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH/d3ffVGtu6moN2jmUmOiJOpQY466kM24cbPESYIZisuw4hXU
        8kgLBo1LCrUoHdUCAkqxIlRpFcprTiEyQkWqINqKARXxgQ+KKHTd0AUQbSH773PO95zzPTk5
        LJb1UiHs3qRUUZWkUMppCdkx6exanhEVGf31Pc1XkN0wzoCzRkOD4c4tAkqqK2n4mNfGQO2p
        agq8mToMlswEcBfpSBi5kIOgwroZnvp6EQxnjpMw+e4thvujIzTk2vIx/G7vZyCr8DsoGehE
        8PpREwGWwXBoefCegQ5jGQGFtfPhv1Gtv7G9FkNp8wYYNnswPLVfpGDAUYyh5OEqmDjtJSDb
        VMPAkCcMLpS/QvDK+JiG4b5WBMXNfSTUveimILe5k4FWk5EA6yU7hnNZFhJuHvdSMHLkKg3e
        Y8MUdDWW0FDxsgpDTs1lf6h1B7Y6SoKxII8Bk+UECf3tLgI6zU4aXjsMJPiefcJgPKfFcOru
        X/57TJzEoHtcRYCts4oBR0ETgvEPk9S3McLLFjMh6JqMtFBprkRCV7cbC+NjeUjosUcKQ/lG
        f+q4gRBa+h20UDaoIYWG4j5G8P79q1BalyaYCrqRkNNwGwn11tDItTGSb3aLyr0HRNXK8J2S
        hD79GJPyXJpe1PGjBv0xU49YlufW8B+s+/UoyI/zeNeTalqPJKyMO4/4t0NDTECQcRkEf+Yo
        FWCaW83XV1imioK5Wp7XvHDjgIC5w/ygcwwFeA73E68b8Ew1k9wS3vfnwBRLuQg+P9dGT7t9
        yd9qy58aGsQJvKXaRk6bRfBubT1lRNJSNOMimiumxaWod8Unhq1QKxLVaUnxK+KSE+vQ9Mv9
        exWVt613II5F8llS67It0TJKcUB9MNGBeBbLg6VZmyOjZdLdioOHRFVyrCpNKaodaAFLyudL
        zzSObJVx8YpUcb8opoiq/1WCDQrRIPtd0yJv8JLgTTGlkp2tCzJsJzpCTIaN36saf0k/cuhN
        uVK/3qNel/5swn2j+9gGqzZ+YWhmmSnjfnvEtihP46ghNvaL+maCaR/s2fFw9vZ/9sQtXTRn
        okj5c6Fvn+833eqera6z8xZvDH8SdPlkQ9IV17VL73pTr8+gf3ifnWxe41rulJPqBEVYKFap
        FZ8BEK1Wa24DAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53733
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
 arch/blackfin/kernel/dma-mapping.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/blackfin/kernel/dma-mapping.c b/arch/blackfin/kernel/dma-mapping.c
index 771afe6e4264..53fbbb61aa86 100644
--- a/arch/blackfin/kernel/dma-mapping.c
+++ b/arch/blackfin/kernel/dma-mapping.c
@@ -79,7 +79,7 @@ static void __free_dma_pages(unsigned long addr, unsigned int pages)
 }
 
 static void *bfin_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -94,7 +94,7 @@ static void *bfin_dma_alloc(struct device *dev, size_t size,
 }
 
 static void bfin_dma_free(struct device *dev, size_t size, void *vaddr,
-		  dma_addr_t dma_handle, struct dma_attrs *attrs)
+		  dma_addr_t dma_handle, unsigned long attrs)
 {
 	__free_dma_pages((unsigned long)vaddr, get_pages(size));
 }
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(__dma_sync);
 
 static int bfin_dma_map_sg(struct device *dev, struct scatterlist *sg_list,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -139,7 +139,7 @@ static void bfin_dma_sync_sg_for_device(struct device *dev,
 
 static dma_addr_t bfin_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	dma_addr_t handle = (dma_addr_t)(page_address(page) + offset);
 
-- 
1.9.1
