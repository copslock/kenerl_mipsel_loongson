Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2016 16:00:32 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:42122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007499AbcCRPAacbEgf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2016 16:00:30 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4B7CC611F6;
        Fri, 18 Mar 2016 15:00:28 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2951A60B00; Fri, 18 Mar 2016 15:00:27 +0000 (UTC)
Received: from [10.228.68.107] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2384760269;
        Fri, 18 Mar 2016 15:00:22 +0000 (UTC)
Subject: Re: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, timur@codeaurora.org,
        cov@codeaurora.org, nwatters@codeaurora.org
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <1458252137-24497-2-git-send-email-okaya@codeaurora.org>
 <56EBF09A.1060503@arm.com>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhc@lemote.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Dean Nelson <dnelson@redhat.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56EC1805.5060207@codeaurora.org>
Date:   Fri, 18 Mar 2016 11:00:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <56EBF09A.1060503@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 3/18/2016 8:12 AM, Robin Murphy wrote:
> Since we know for sure that swiotlb_to_phys is a no-op on arm64, it might be cleaner to simply not reference it at all. I suppose we could have some private local wrappers, e.g.:
> 
> #define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
> 
> to keep the intent of the code clear (and just in case anyone ever builds a system mad enough to warrant switching out that definition, but I'd hope that never happens).
> 
> Otherwise, looks good - thanks for doing this!

OK. I added this. Reviewed-by?

I'm not happy to submit such a big patch for all different ARCHs. I couldn't
find a cleaner solution. I'm willing to split this patch into multiple if there
is a better way.

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index ada00c3..8c0f66b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -29,6 +29,14 @@

 #include <asm/cacheflush.h>

+/*
+ * If you are building a system without IOMMU, then you are using SWIOTLB
+ * library. The ARM64 adaptation of this library does not support address
+ * translation and it assumes that physical address = dma address for such
+ * a use case. Please don't build a platform that violates this.
+ */
+#define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
+
 static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
                                 bool coherent)
 {
@@ -188,7 +196,7 @@ static void __dma_free(struct device *dev, size_t size,
                       void *vaddr, dma_addr_t dma_handle,
                       struct dma_attrs *attrs)
 {
-       void *swiotlb_addr = phys_to_virt(swiotlb_dma_to_phys(dev, dma_handle));
+       void *swiotlb_addr = swiotlb_to_virt(dma_handle);

        size = PAGE_ALIGN(size);

@@ -209,8 +217,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,

        dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
        if (!is_device_dma_coherent(dev))
-               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
-                              size, dir);
+               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);

        return dev_addr;
 }
@@ -283,8 +290,7 @@ static void __swiotlb_sync_single_for_device(struct device *dev,
 {
        swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
        if (!is_device_dma_coherent(dev))
-               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
-                              size, dir);
+               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);
 }




-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
