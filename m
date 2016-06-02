Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:40:56 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18252 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041759AbcFBPkfwzH02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:35 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85005W8I7F2K10@mailout3.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:28 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-b8-5750536bd9e9
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 63.F9.05254.B6350575; Thu,
 2 Jun 2016 16:40:27 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:27 +0100 (BST)
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
Subject: [RFC v3 01/45] powerpc: dma-mapping: Don't hard-code the value of
 DMA_ATTR_WEAK_ORDERING
Date:   Thu, 02 Jun 2016 17:39:03 +0200
Message-id: <1464881987-13203-2-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0xTZxT3u999FLLGm/q6cQZNM+MjikMdOSox+s+8iVFRVBISH7VeQaFA
        WlDZ5tZRC1OBtSA+KCLSyktoKcSEkiDrjaFYrdJgypyiCyJI2KAQUVOkrpT53+91cn45ORIs
        e0ktlpxMzxLU6Yo0OR1JPgy6etamJsQnflt35zu44JhiwNWkpaHw8QMCym0NNEwXdzJgv2aj
        wJ+rx2DJTQHvVT0JY9UFCGpqd8GriecIRnOnSAj++w+Gp5NjNBjrSjBcsvYzkHdlO5QPeRAM
        /tVOgGV4Kzj/fM/AQ0MVAVfsi+DjpC406LZjqOzYAqMVbzG8stZTMCSWYSh/th4+XfcTcMHU
        xMDI2xioNr9B8MbwgobRvvsIyjr6SGh+7aPA2OFh4L7JQEDtHSuGW3kWErqK/BSMnW+lwf/b
        KAU9beU01Aw0YihouhuiOu9Mq3wSDKXFDJgsv5PQ7+4mwFPhomFQLCRh4u/PGAy3dBiuPbkX
        usenyxj0LxoJqPM0MiCWtiOY+hCktiXxA84Kgte3G2i+oaIB8T0+L+anAsWI77XG8yMlhpBU
        VEjwzn6R5quGtSTvKOtjeP/4Yb6yOZs3lfoQX+B4hPiW2tXxsUmRcceFtJOnBfW6rUcjU6ye
        ApQ5TZ8tszuwFr2jLqIICcdu5IIfuplZvJDrfmmjL6JIiYy9jbh84zgxS34luAlLL5pJ0ewG
        rqXGEk7NZ+0cp33txTMGZn/ihl2BcGgeq+SeFlaFdZJdzpnrnWFdyu7gHF2T/6+L4h50loRr
        RLA8Z7HVkTNYFsp4dS2UAUkr0Zx6tEDIVmZqjiWrYqI1CpUmOz05WpmhakazX/euFZk7N4uI
        lSD5V9LaVXsSZZTitCZHJSJOguXzpXm74hNl0uOKnB8EdcYRdXaaoBHR1xJSvkh6o21sv4xN
        VmQJqYKQKai/uIQkYrEWfXPdzbl1rc+r1WDMSJobTXafyPJOxGzrZS7ZVjxz7PyxSN2Hvzed
        aYqK1o+nTF8+FetbM+gKlIq7d0dt7jIeam4biHMuSfj5Zo7mjwNLPVansvFjqtu3snrTPjir
        DMoyYl02lZgwEli2J/D+lxsH8w+sWrp3Sdy57WYcN3TTTMlJTYoiZjVWaxT/AUptZkBxAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53725
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

Hard-coded value of DMA_ATTR_WEAK_ORDERING is then compared with the
symbol.  This will stop matching if the value of symbol is changed (when
switching DMA attributes to unsigned long).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/powerpc/platforms/cell/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 14a582b21274..0c2794d2b6c0 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -1162,7 +1162,7 @@ static int __init setup_iommu_fixed(char *str)
 	pciep = of_find_node_by_type(NULL, "pcie-endpoint");
 
 	if (strcmp(str, "weak") == 0 || (pciep && strcmp(str, "strong") != 0))
-		iommu_fixed_is_weak = 1;
+		iommu_fixed_is_weak = DMA_ATTR_WEAK_ORDERING;
 
 	of_node_put(pciep);
 
-- 
1.9.1
