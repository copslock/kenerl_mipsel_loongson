Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 13:05:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13234 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992147AbcLSMFBc88WY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 13:05:01 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D6EB629A764E4;
        Mon, 19 Dec 2016 12:04:51 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Dec
 2016 12:04:54 +0000
Subject: Re: [PATCH 19/21] MIPS memblock: Add print out method of kernel
 virtual memory layout
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <james.hogan@imgtec.com>, <alexander.sverdlin@nokia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-20-git-send-email-fancer.lancer@gmail.com>
CC:     <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <db27f41e-4121-bb83-6533-6727c26b9c5b@imgtec.com>
Date:   Mon, 19 Dec 2016 12:04:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1482113266-13207-20-git-send-email-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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


On 19/12/16 02:07, Serge Semin wrote:
> It's useful to have some printed map of the kernel virtual memory,
> at least for debugging purpose.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/mm/init.c | 47 +++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 13a032f..35e7ba8 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -32,6 +32,7 @@
>   #include <linux/hardirq.h>
>   #include <linux/gfp.h>
>   #include <linux/kcore.h>
> +#include <linux/sizes.h>
>   
>   #include <asm/asm-offsets.h>
>   #include <asm/bootinfo.h>
> @@ -106,6 +107,49 @@ static void __init zone_sizes_init(void)
>   }
>   
>   /*
> + * Print out kernel memory layout
> + */
> +#define MLK(b, t) b, t, ((t) - (b)) >> 10
> +#define MLM(b, t) b, t, ((t) - (b)) >> 20
> +#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> +static void __init mem_print_kmap_info(void)
> +{
> +	pr_notice("Virtual kernel memory layout:\n"
> +		  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +		  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +#ifdef CONFIG_HIGHMEM
> +		  "    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +#endif
> +		  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> +		  "      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
> +		  "      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
> +		  "      .init : 0x%p" " - 0x%p" "   (%4td kB)\n",
> +		MLM(PAGE_OFFSET, (unsigned long)high_memory),
> +		MLM(VMALLOC_START, VMALLOC_END),
> +#ifdef CONFIG_HIGHMEM
> +		MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
> +#endif
> +		MLK(FIXADDR_START, FIXADDR_TOP),
> +		MLK_ROUNDUP(_text, _etext),
> +		MLK_ROUNDUP(_sdata, _edata),
> +		MLK_ROUNDUP(__init_begin, __init_end));

Please drop printing the kernel addresses, or at least only do it if 
KASLR is not turned on, otherwise you're removing the advantage of 
KASLR, that critical kernel addresses cannot be determined easily from 
userspace.

It may be better to merge the functionality of show_kernel_relocation
http://lxr.free-electrons.com/source/arch/mips/kernel/relocate.c#L354
into this function, but only print it under the same conditions as 
currently, i.e.
#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
http://lxr.free-electrons.com/source/arch/mips/kernel/setup.c#L530

Thanks,
Matt

> +
> +	/* Check some fundamental inconsistencies. May add something else? */
> +#ifdef CONFIG_HIGHMEM
> +	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
> +	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
> +#endif
> +	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
> +	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
> +					(unsigned long)high_memory);
> +	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
> +	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
> +}
> +#undef MLK
> +#undef MLM
> +#undef MLK_ROUNDUP
> +
> +/*
>    * Not static inline because used by IP27 special magic initialization code
>    */
>   void setup_zero_pages(void)
> @@ -492,6 +536,9 @@ void __init mem_init(void)
>   	/* Free highmemory registered in memblocks */
>   	mem_init_free_highmem();
>   
> +	/* Print out kernel memory layout */
> +	mem_print_kmap_info();
> +
>   	/* Print out memory areas statistics */
>   	mem_init_print_info(NULL);
>   
