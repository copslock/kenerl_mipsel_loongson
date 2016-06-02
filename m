Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:41:34 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45077 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041757AbcFBPklqPoX2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:41 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500EOEI7MAW40@mailout2.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:34 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-06-57505371e303
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 37.BB.04866.17350575; Thu,
 2 Jun 2016 16:40:34 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:33 +0100 (BST)
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
Subject: [RFC v3 03/45] alpha: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:05 +0200
Message-id: <1464881987-13203-4-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTZxT3u9990djkWtm40WhMEw0xk6kseuIWN+cf3sTH6iskzugq3AGR
        ImmtmcYshVo3KLBLeUwoISCFFnmUlhAtGQIdgoCgHYyhwnAIKkOhNmE4cGgr7r/f6zxyclis
        GKZWsYnJZ0VtsjpJScvInsXO/k3aw6qYzc4ADemeBQY66w00ZPV1EVDsrKHhP0sHA64rTgr8
        aSYMtrQE8P1sImGmMhOB3bEfRgMPEUynLZCw+OI5hoHZGRpyqnIxmOvGGLhcsAuKn/YiePKg
        mQDb5E5oG/qHgR7pKgEFrgh4NWsMFna7MJS2fArTJc8wjNZdo+CptwhD8f2t8LrQT0C6tZ6B
        qWdboLJ8AsGENEzD9Eg7gqKWERLcjwcpyGnpZaDdKhHgqK7DUHbZRsLtbD8FM5du0OD/cZqC
        /qZiGuzjtRgy6xuD1OgLbfUDCVK+hQGr7ScSxrrvEdBb0knDE28WCYFHbzBIZUYMV+7eDN7j
        dR4G03AtAVW9tQx485sRLMwtUl8cE8bbSgjB1CzRQk1JDRL6B31YWJi3IOGPOpUwlSsFpews
        Qmgb89LC1UkDKXiKRhjB//KEUOrWC9b8QSRkeu4gocGxUbXtmOyzODEp8Zyo/XjnN7KEX3Pu
        oxTLmu/6qg8bkCsiA4WxPPcJXz6QSizhD/l7fzrpDCRjFVwF4scHJt6TVII32t1UKEVz0XyD
        3fbOCOdcPG947MMhA3MX+cnOeZSBWHYlt5d3efaFZJJbz5fVF9AhLOf28G/mrPTStLV8V0fu
        u55hnMDbnFVkCCuCGZ+xgZKQvBQtu4Y+EPWxKbpT8ZqtUTq1RqdPjo+KPaNxo6Wfm72BKjp2
        eBHHIuVy+bKPvopRUOpzuvMaL+JZrAyXbz+kilHI49TnL4jaMye1+iRR50WrWVIZIS9smjmi
        4OLVZ8XTopgiav93CTZslQHtm7+YWk1Mxpq6ElNjXhzs/mVIDH8+37Ui+8s5x3XzweR1qpTj
        j9rXxg5I5TvMlDu67NuJ3df3WtssPbd+K3dssFf81eqo0DQemP23qHCIPFqZF/l1c/TU978/
        6OMC6ZEtka8u7G79XHZzz2irOeuhh7TqEwnj+kO7Vv8dWJl3C68zK0ldgnrLRqzVqd8C+vvc
        cm8DAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53727
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
 arch/alpha/include/asm/dma-mapping.h |  2 --
 arch/alpha/kernel/pci-noop.c         |  2 +-
 arch/alpha/kernel/pci_iommu.c        | 12 ++++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 3c3451f58ff4..c63b6ac19ee5 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -1,8 +1,6 @@
 #ifndef _ALPHA_DMA_MAPPING_H
 #define _ALPHA_DMA_MAPPING_H
 
-#include <linux/dma-attrs.h>
-
 extern struct dma_map_ops *dma_ops;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index 8e735b5e56bd..bb152e21e5ae 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -109,7 +109,7 @@ sys_pciconfig_write(unsigned long bus, unsigned long dfn,
 
 static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t gfp,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	void *ret;
 
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 8969bf2dfe3a..451fc9cdd323 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -349,7 +349,7 @@ static struct pci_dev *alpha_gendev_to_pci(struct device *dev)
 static dma_addr_t alpha_pci_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	int dac_allowed;
@@ -369,7 +369,7 @@ static dma_addr_t alpha_pci_map_page(struct device *dev, struct page *page,
 
 static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	unsigned long flags;
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
@@ -433,7 +433,7 @@ static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
 
 static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_addrp, gfp_t gfp,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	void *cpu_addr;
@@ -478,7 +478,7 @@ try_again:
 
 static void alpha_pci_free_coherent(struct device *dev, size_t size,
 				    void *cpu_addr, dma_addr_t dma_addr,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
@@ -651,7 +651,7 @@ sg_fill(struct device *dev, struct scatterlist *leader, struct scatterlist *end,
 
 static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 			    int nents, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	struct scatterlist *start, *end, *out;
@@ -729,7 +729,7 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 
 static void alpha_pci_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nents, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	unsigned long flags;
-- 
1.9.1
