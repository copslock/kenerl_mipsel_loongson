Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 08:56:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7597 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991232AbdAWHze0kBWi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 08:55:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 039F27B425174;
        Mon, 23 Jan 2017 07:55:26 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 23 Jan
 2017 07:55:27 +0000
Subject: Re: [PATCH 10/21] MIPS memblock: Discard bootmem allocator
 initialization
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <alexander.sverdlin@nokia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-11-git-send-email-fancer.lancer@gmail.com>
CC:     <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <780ca27f-d582-4911-a1a6-bd5c8792c587@imgtec.com>
Date:   Mon, 23 Jan 2017 08:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1482113266-13207-11-git-send-email-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Serge,

On 19.12.2016 03:07, Serge Semin wrote:
> Bootmem allocator initialization needs to be discarded.
> PFN limit constants are still in use by some subsystems, so they
> need to be properly initialized. The initialization is moved into
> a separate method and performed with help of commonly used
> platform-specific constants. It might me too simplified, but most
> of the kernel platforms do it the same way. Moreover it's much
> easier to debug it, when it's not that complicated.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  arch/mips/kernel/setup.c | 193 ++++-------------------------
>  1 file changed, 21 insertions(+), 172 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index e746793..6562f55 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -626,6 +626,25 @@ static void __init request_crashkernel(struct resource *res) { }
>  #endif /* !CONFIG_KEXEC */
>
>  /*
> + * Calcualte PFN limits with respect to the defined memory layout
> + */
> +static void __init find_pfn_limits(void)
> +{
> +	phys_addr_t ram_end = memblock_end_of_DRAM();
> +
> +	min_low_pfn = ARCH_PFN_OFFSET;
> +	max_low_pfn = PFN_UP(HIGHMEM_START);

This doesn't look right - as this may set max_low_pfn to more than the 
actual physical memory size. In some cases this might be a serious 
problem and it doesn't look like any other platform does that.
Even in MIPS code you can find uses of max_low_pfn that would be 
seriously affected by this change (vpe loader with 
CONFIG_MIPS_VPE_LOADER_TOM).

> +	max_pfn = PFN_UP(ram_end);
> +#ifdef CONFIG_HIGHMEM
> +	highstart_pfn = max_low_pfn;
> +	highend_pfn = max_pfn <= highstart_pfn ? highstart_pfn : max_pfn;
> +#endif
> +	pr_info("PFNs: low min %lu, low max %lu, high start %lu, high end %lu,"
> +		"max %lu\n",
> +		min_low_pfn, max_low_pfn, highstart_pfn, highend_pfn, max_pfn);
> +}
> +
> +/*
>   * Initialize the bootmem allocator. It also setup initrd related data
>   * if needed.
>   */



I fully agree with you that the current initialisation code is really 
complex and difficult to debug, but the modified one seems a bit too 
simplified.

Regards,
Marcin
