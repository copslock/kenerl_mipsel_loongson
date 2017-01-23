Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 08:55:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4823 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991957AbdAWHzXfB5Li (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 08:55:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 00B66100E3C39;
        Mon, 23 Jan 2017 07:55:15 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 23 Jan
 2017 07:55:16 +0000
Subject: Re: [PATCH 04/21] MIPS memblock: Alter user-defined memory parameter
 parser
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <alexander.sverdlin@nokia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-5-git-send-email-fancer.lancer@gmail.com>
CC:     <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <756b9060-7a21-ad23-9e74-50670f42753e@imgtec.com>
Date:   Mon, 23 Jan 2017 08:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1482113266-13207-5-git-send-email-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56463
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
> Both new memblock and boot_mem_map subsystems need to be fully
> cleared before a new memory region is added. So the early parser is
> correspondingly modified.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  arch/mips/kernel/setup.c | 67 +++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 9da6f8a..789aafe 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -229,6 +229,43 @@ static void __init print_memory_map(void)
>  }
>
>  /*
> + * Parse "mem=size@start" parameter rewriting a defined memory map
> + * We look for mem=size@start, where start and size are "value[KkMm]"
> + */
> +static int __init early_parse_mem(char *p)
> +{
> +	static int usermem;

usermem variable seems unnecessary now and could easily be removed?

> +	phys_addr_t start, size;
> +
> +	start = PHYS_OFFSET;
> +	size = memparse(p, &p);
> +	if (*p == '@')
> +		start = memparse(p + 1, &p);
> +
> +	/*
> +	 * If a user specifies memory size, we blow away any automatically
> +	 * generated regions.
> +	 */
> +	if (usermem == 0) {
> +		phys_addr_t ram_start = memblock_start_of_DRAM();
> +		phys_addr_t ram_end = memblock_end_of_DRAM() - ram_start;
> +
> +		pr_notice("Discard memory layout %pa - %pa",
> +			  &ram_start, &ram_end);

missing \n in printk

> +		memblock_remove(ram_start, ram_end - ram_start);
> +		boot_mem_map.nr_map = 0;
> +		usermem = 1;
> +	}
> +	pr_notice("Add userdefined memory region %08zx @ %pa",
> +		  (size_t)size, &start);

ditto

> +	add_memory_region(start, size, BOOT_MEM_RAM);
> +	return 0;
> +}
> +early_param("mem", early_parse_mem);
> +
> +/*
>   * Manage initrd
>   */
>  #ifdef CONFIG_BLK_DEV_INITRD
> @@ -613,31 +650,6 @@ static void __init bootmem_init(void)
>   * initialization hook for anything else was introduced.
>   */
>
> -static int usermem __initdata;
> -
> -static int __init early_parse_mem(char *p)
> -{
> -	phys_addr_t start, size;
> -
> -	/*
> -	 * If a user specifies memory size, we
> -	 * blow away any automatically generated
> -	 * size.
> -	 */
> -	if (usermem == 0) {
> -		boot_mem_map.nr_map = 0;
> -		usermem = 1;
> -	}
> -	start = 0;
> -	size = memparse(p, &p);
> -	if (*p == '@')
> -		start = memparse(p + 1, &p);
> -
> -	add_memory_region(start, size, BOOT_MEM_RAM);
> -	return 0;
> -}
> -early_param("mem", early_parse_mem);
> -
>  #ifdef CONFIG_PROC_VMCORE
>  unsigned long setup_elfcorehdr, setup_elfcorehdr_size;
>  static int __init early_parse_elfcorehdr(char *p)
> @@ -797,11 +809,6 @@ static void __init arch_mem_init(char **cmdline_p)
>
>  	parse_early_param();
>
> -	if (usermem) {
> -		pr_info("User-defined physical RAM map:\n");
> -		print_memory_map();
> -	}
> -
>  	bootmem_init();
>  #ifdef CONFIG_PROC_VMCORE
>  	if (setup_elfcorehdr && setup_elfcorehdr_size) {
>


Regards,
Marcin
