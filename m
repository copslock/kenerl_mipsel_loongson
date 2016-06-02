Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:54:30 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18707 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041804AbcFBPmkfsTj2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:40 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008N2IAYD710@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:35 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-21-575053ea74b5
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 9E.9A.05254.AE350575; Thu,
 2 Jun 2016 16:42:34 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:34 +0100 (BST)
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
Subject: [RFC v3 42/45] unicore32: dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:44 +0200
Message-id: <1464881987-13203-43-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGee/73g+IxZvq8AYTkzVOoxkqui0nujQzLvHOj9lMEhL/2Fbq
        TUsGSHrBzX2lgjBFYBcqirQjiFWKg/I1M3AyQm0AxToaFuamFYOgMBW6ToG0wNbC9t/vPM9z
        ck5ODofVD+hELj0rRzJn6TM0TBzpX+gdTPrzoC51S6FnOZzqCLPQ22xhoOTOTQrsTQ0MzJf3
        sNBS2URDIK8AgyPPBL5zBQSmLhcjqHPuh+HgPQSTeWECC8+fYfj15RQDZfVWDKddIywUnt0J
        9ideBI//6KTAMaGF7rvTLPQrtRScbVkFsy/zI423WjDUdO2AyepxDMOuKzQ8cVdhsP++FebO
        Byg4ZWtm4el4Mly+OIZgTLnPwKTfg6Cqy0+g9dEQDWVdXhY8NoUC5/cuDBcKHQT6SgM0TJ1o
        ZyBwcpKGwWt2BupGGzEUN1+NlPm+6FbfEFAqylmwOb4lMHJrgAJvdS8Dj90lBIIP/8GgXMjH
        UPnLz5F7zJ3BUHC/kYJ6byML7opOBOGZBfqdQ+JodzUlFnQqjNhQ3YDEwSEfFsOhciT+5tKJ
        T61KRCotocTuETcj1k5YiNhR5WfFwF8fijWtuaKtYgiJxR23kdjm3Kh761Dc24eljPSjknmz
        9uM4kzPYR7Jn2c+mfwiwFtTGFKFYTuDfELpDVf9xgjDwoCnCcZyav4SEjmkvWSqOU0Lx3z/i
        aIrhtwltdY7F1Eq+RRAsj3yLBua/FCZ6QyjKK/gDwtU8P4ky4V8T/KdHFzMqXhSstXayNG6N
        cLPHSkc5NqI7muoXdTW/W/Dlt9EKUtWgmCvoFSnXkC2nGTOTN8n6TDk3y7jJcCSzFS193Yt2
        dLFnuxvxHNIsUzk3HEhV0/qj8rFMNxI4rFmpyvlAl6pWHdYf+1wyH/nInJshyW60miOaVarv
        rk2lqHmjPkf6RJKyJfP/LsXFJlqQbViu9BjjB7RJ6764Hf9eyvOde8pTXD2O2VCwj5v1mO6G
        J+6N7y9Vlq8pSoh/eKPelTOqizeEjI4ZazpHvR84EXNDSxL3fbpjd9FX7XdiktYlydtHVrxe
        lrbr+vxYdnDbpZl31zrnv1alvbnZNNcf+Gn8VdPeEvuGhPMNhhdbDdr1GiKb9MkbsVnW/wuE
        XvAtcQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53766
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
 arch/unicore32/mm/dma-swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
index 16c08b2143a7..3e9f6489ba38 100644
--- a/arch/unicore32/mm/dma-swiotlb.c
+++ b/arch/unicore32/mm/dma-swiotlb.c
@@ -19,14 +19,14 @@
 
 static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					    dma_addr_t *dma_handle, gfp_t flags,
-					    struct dma_attrs *attrs)
+					    unsigned long attrs)
 {
 	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
 }
 
 static void unicore_swiotlb_free_coherent(struct device *dev, size_t size,
 					  void *vaddr, dma_addr_t dma_addr,
-					  struct dma_attrs *attrs)
+					  unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
-- 
1.9.1
