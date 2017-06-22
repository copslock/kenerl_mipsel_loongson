Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 09:21:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43724 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990519AbdFVHVKIBAki (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2017 09:21:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F8F539930753;
        Thu, 22 Jun 2017 08:21:00 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 22 Jun
 2017 08:21:03 +0100
Subject: Re: [PATCH v2 15/17] MIPS: JZ4770: Workaround for corrupted DMA
 transfers
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170620151855.19399-1-paul@crapouillou.net>
 <20170620151855.19399-15-paul@crapouillou.net>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <ca37b50d-951c-2264-fa37-cca7149ed4ba@imgtec.com>
Date:   Thu, 22 Jun 2017 09:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170620151855.19399-15-paul@crapouillou.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58740
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

Hi Paul, Maarten,

On 20.06.2017 17:18, Paul Cercueil wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
> 
> We have seen MMC DMA transfers read corrupted data from SDRAM when
> a burst interval ends at physical address 0x10000000. To avoid this
> problem, we remove the final page of low memory from the memory map.
> 
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>   arch/mips/jz4740/setup.c | 24 ++++++++++++++++++++++++
>   arch/mips/kernel/setup.c |  8 ++++++++
>   2 files changed, 32 insertions(+)
> 
>   v2: No change
> 
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index afd84ee966e8..6948b133a15d 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -23,6 +23,7 @@
>   
>   #include <asm/bootinfo.h>
>   #include <asm/mips_machine.h>
> +#include <asm/page.h>
>   #include <asm/prom.h>
>   
>   #include <asm/mach-jz4740/base.h>
> @@ -102,6 +103,29 @@ void __init arch_init_irq(void)
>   	irqchip_init();
>   }
>   
> +/*
> + * We have seen MMC DMA transfers read corrupted data from SDRAM when a burst
> + * interval ends at physical address 0x10000000. To avoid this problem, we
> + * remove the final page of low memory from the memory map.
> + */
> +void __init jz4770_reserve_unsafe_for_dma(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> +		struct boot_mem_map_entry *entry = boot_mem_map.map + i;
> +
> +		if (entry->type != BOOT_MEM_RAM)
> +			continue;
> +
> +		if (entry->addr + entry->size != 0x10000000)
> +			continue;
> +
> +		entry->size -= PAGE_SIZE;
> +		break;
> +	}
> +}
> +
>   static int __init jz4740_machine_setup(void)
>   {
>   	mips_machine_setup();
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 89785600fde4..cccfd7ba89fe 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -838,6 +838,14 @@ static void __init arch_mem_init(char **cmdline_p)
>   
>   	parse_early_param();
>   
> +#ifdef CONFIG_MACH_JZ4770
> +	if (current_cpu_type() == CPU_JZRISC &&
> +				mips_machtype == MACH_INGENIC_JZ4770) {
> +		extern void __init jz4770_reserve_unsafe_for_dma(void);
> +		jz4770_reserve_unsafe_for_dma();
> +	}
> +#endif
> +

This part doesn't look good in the platform-agnostic code ... is there a 
reason why you wouldn't do that from within plat_mem_setup()?


>   	if (usermem) {
>   		pr_info("User-defined physical RAM map:\n");
>   		print_memory_map();
> 


Marcin
