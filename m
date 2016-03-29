Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 14:57:57 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:48721 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007670AbcC2M54QBxMy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 14:57:56 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 27F5C6160C;
        Tue, 29 Mar 2016 12:57:53 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24315615FA; Tue, 29 Mar 2016 12:57:53 +0000 (UTC)
Received: from [10.228.68.88] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 249E060224;
        Tue, 29 Mar 2016 12:57:46 +0000 (UTC)
Subject: Re: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <1458252137-24497-2-git-send-email-okaya@codeaurora.org>
 <56EBF09A.1060503@arm.com> <56EC1805.5060207@codeaurora.org>
 <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
 <alpine.DEB.2.02.1603291329460.18380@kaball.uk.xensource.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, timur@codeaurora.org,
        cov@codeaurora.org, nwatters@codeaurora.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
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
        Michael Ellerman <mpe@ellerman.id.au>, X86 <x86@kernel.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56FA7BC9.2010903@codeaurora.org>
Date:   Tue, 29 Mar 2016 08:57:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1603291329460.18380@kaball.uk.xensource.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52728
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

On 3/29/2016 8:44 AM, Stefano Stabellini wrote:
> Could you please explain what is the problem that you are trying to
> solve? In other words, what is the issue with assuming that physical
> address = dma address (and the current dma_to_phys and phys_to_dma
> static inlines) if no arm64 platforms violate it? That's pretty much
> what is done on x86 too (without X86_DMA_REMAP).
> 
> If you want to make sure that the assumption is not violated, you can
> introduce a boot time check or a BUG_ON somewhere.
> 
> If there is an arm64 platform with phys_addr != dma_addr, we need proper
> support for it. In fact even if there is an IOMMU on that platform, when
> running Xen on it, the IOMMU would be used by the hypervisor and Linux
> would still end up without it, using the swiotlb.


The problem is that device drivers are trying to use dma_to_phys and phys_to_dma
APIs to do address translation even though these two API do not exist in DMA mapping
layer. (see patch #1 and I made the same mistake in my HIDMA code)

Especially, when a device is behind an IOMMU; the DMA addresses are not equal
to physical addresses. Usage of dma_to_phys causes a crash on the system.

I'm trying to prefix the dma_to_phys and phys_to_dma API with swiotlb so that
we know what it is intended for and usage of these API in drivers need to be
discouraged in the future during code reviews.

Since I renamed the API, Robin Murphy made a suggestion to convert this 

phys_to_virt(swiotlb_dma_to_phys(dev, dma_handle))

to this

#define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))

swiotlb_to_virt(dma_handle)

just to reduce code clutter since we know swiotlb_dma_to_phys returns phys already
for ARM64 architecture.

I think we can do this exercise later. I'll undo this change for the moment. 
Let's focus on the API rename. 

I don't want this general purpose dma_to_phys API returning phys=dma value. This is
not correct.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
