Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:49:37 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18491 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041789AbcFBPlzHcI92 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:41:55 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008MEI9OD710@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:41:49 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-f3-575053bc4eea
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id DF.1C.04866.CB350575; Thu,
 2 Jun 2016 16:41:48 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:41:47 +0100 (BST)
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
Subject: [RFC v3 27/45] hexagon: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:29 +0200
Message-id: <1464881987-13203-28-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee5z3yAWr1XnVRM/NDNLdOOlLuZsEOOWGB8/GLtpQqLo7PQG
        iLylpaiLHwoMV+XFK1im0DTAKhQs7yOAo2MU0qqA2qE4N9GBghAGrUScgrC1Er/9/uf/Pzkn
        J4fHymFmA5+UmiHpUrXJKjaM7lvyDH7SuV8TF9UzwsG5jgUOPI1GFgpu36TA0uBgYbHIzUHT
        5QYG/Nm5GGzZieD9MZcGX1U+gmr7Xngy+xeCmewFGpam/8Fwb87HwsWaYgx59aMcnC35AizP
        BxCM/+mkwDa5A7r/eMVBn1xJQUnTOng9lxNovNWEobwrBmasExie1Ncy8NxVisHyUA1vr/gp
        OFfWyMHURDRU/TSGYEx+xMLMcC+C0q5hGpqfDjFwsWuAg94ymQL7tXoMFWdtNNwo9DPg+76d
        Bb9phoHB6xYWqp/VYchvbA3IHG9wqx9okM1FHJTZLtAweusuBQNWDwvjrgIaZv/+D4NckYPh
        8p1fA/d4ewlD7qM6CmoG6jhwmZ0IFv5dYnYeJM+6rRTJdcoscVgdiAwOeTFZmC9C5EG9hkwV
        y4FSYQFFukddLKmcNNKko3SYI/4XR0h5s4GUmYcQye/oR6TFvkWz/WBY7HEpOSlT0kXuOBqW
        OG9f5NIrV5160Z/FGVF2+HkUyovCp+JiWye1zB+Idx83sOdRGK8UriKx900WtSyyKLF2egQH
        U6ywTWyptr1LrRGaRNH41PvOwMIZcdIzj4K8Wtgrlro72SDTwmax3fFLIMPzCoGIvvLI5Wmb
        xJvuYibIoYGyraGGDrJS2C16c1oYGSnKUUgtWisZjqXrv01IUUfotSl6Q2pCxLG0lGa0/HRz
        7eiq+3MXEnikWqEI+XhfnJLRZupPp7iQyGPVGkXG15o4peK49vR3ki7tG50hWdK70EaeVq1T
        XLnuO6AUErQZ0glJSpd0712KD91gRGpT/KH7E69vt9aOzIVe8H5IVob3tDvb5nd1/4ZO2aej
        1YXM7s1ihoPsqUjLilFt+yqS3KlMP2EiUU5PEvryZdVHdf6HVoPpTF+aSv3GHW+dUMZuXf9K
        ejmp6S+RdpkLeg5HmWyHQj7rjZUpkvdznuWeVmdekfl78snZKYXgVNH6RG30FqzTa/8HH08E
        6HADAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53751
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
 arch/hexagon/include/asm/dma-mapping.h | 1 -
 arch/hexagon/kernel/dma.c              | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index aa6203464520..7ef58df909fc 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -26,7 +26,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
-#include <linux/dma-attrs.h>
 #include <asm/io.h>
 
 struct device;
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 9e3ddf792bd3..b9017785fb71 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -51,7 +51,7 @@ static struct gen_pool *coherent_pool;
 
 static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t flag,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	void *ret;
 
@@ -84,7 +84,7 @@ static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void hexagon_free_coherent(struct device *dev, size_t size, void *vaddr,
-				  dma_addr_t dma_addr, struct dma_attrs *attrs)
+				  dma_addr_t dma_addr, unsigned long attrs)
 {
 	gen_pool_free(coherent_pool, (unsigned long) vaddr, size);
 }
@@ -105,7 +105,7 @@ static int check_addr(const char *name, struct device *hwdev,
 
 static int hexagon_map_sg(struct device *hwdev, struct scatterlist *sg,
 			  int nents, enum dma_data_direction dir,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -172,7 +172,7 @@ static inline void dma_sync(void *addr, size_t size,
 static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	dma_addr_t bus = page_to_phys(page) + offset;
 	WARN_ON(size == 0);
-- 
1.9.1
