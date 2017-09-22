Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 11:47:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8364 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990392AbdIVJrXyQMFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 11:47:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1B7BDF1040276;
        Fri, 22 Sep 2017 10:47:15 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Sep
 2017 10:47:17 +0100
Subject: Re: [PATCH 09/11] MIPS: Add the concept of BOOT_MEM_KERNEL to
 boot_mem_map.
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
 <1505496613-27879-10-git-send-email-steven.hill@cavium.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <694923bf-d230-a1e2-9c81-fa2195a5abfa@imgtec.com>
Date:   Fri, 22 Sep 2017 10:47:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1505496613-27879-10-git-send-email-steven.hill@cavium.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60110
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

Hi Steven,


On 15/09/17 18:30, Steven J. Hill wrote:
> From: David Daney <david.daney@cavium.com>
>
> No change to memory initialization, but this gets us ready for the
> next patches adding hotplug CPU and NUMA support for Octeon.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
> ---
>   arch/mips/include/asm/bootinfo.h |  1 +
>   arch/mips/kernel/setup.c         | 18 ++++++++++++------
>   2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
> index e26a093..71dd16e 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -90,6 +90,7 @@ extern unsigned long mips_machtype;
>   #define BOOT_MEM_ROM_DATA	2
>   #define BOOT_MEM_RESERVED	3
>   #define BOOT_MEM_INIT_RAM	4
> +#define BOOT_MEM_KERNEL		5
>   
>   /*
>    * A memory map that's built upon what was determined
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index fe39397..3dd765a 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -200,6 +200,9 @@ static void __init print_memory_map(void)
>   		case BOOT_MEM_INIT_RAM:
>   			printk(KERN_CONT "(usable after init)\n");
>   			break;
> +		case BOOT_MEM_KERNEL:
> +			printk(KERN_CONT "(kernel data and code)\n");
> +			break;

When KASLR is active, that print leaks the kernels randomized base 
address to userspace and gives the game away. Please could you at least 
guard it with !IS_ENABLED(CONFIG_RANDOMIZE_BASE) ?

Thanks,
Matt

>   		case BOOT_MEM_ROM_DATA:
>   			printk(KERN_CONT "(ROM data)\n");
>   			break;
> @@ -824,6 +827,7 @@ static void __init arch_mem_init(char **cmdline_p)
>   {
>   	struct memblock_region *reg;
>   	extern void plat_mem_setup(void);
> +	phys_addr_t kernel_begin, init_begin, init_end, kernel_end;
>   
>   	/* call board setup routine */
>   	plat_mem_setup();
> @@ -834,12 +838,13 @@ static void __init arch_mem_init(char **cmdline_p)
>   	 * into another memory section you don't want that to be
>   	 * freed when the initdata is freed.
>   	 */
> -	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
> -			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
> -			 BOOT_MEM_RAM);
> -	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
> -			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
> -			 BOOT_MEM_INIT_RAM);
> +	kernel_begin = PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT;
> +	kernel_end = PFN_UP(__pa_symbol(&_end)) << PAGE_SHIFT;
> +	init_begin = PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT;
> +	init_end = PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT;
> +	arch_mem_addpart(kernel_begin, init_begin, BOOT_MEM_KERNEL);
> +	arch_mem_addpart(init_end, kernel_end, BOOT_MEM_KERNEL);
> +	arch_mem_addpart(init_begin, init_end, BOOT_MEM_INIT_RAM);
>   
>   	pr_info("Determined physical RAM map:\n");
>   	print_memory_map();
> @@ -949,6 +954,7 @@ static void __init resource_init(void)
>   		case BOOT_MEM_RAM:
>   		case BOOT_MEM_INIT_RAM:
>   		case BOOT_MEM_ROM_DATA:
> +		case BOOT_MEM_KERNEL:
>   			res->name = "System RAM";
>   			res->flags |= IORESOURCE_SYSRAM;
>   			break;
