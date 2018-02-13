Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 12:31:05 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:51080 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeBMLaR6n2vI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 12:30:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 13 Feb 2018 11:28:40 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 13 Feb
 2018 03:21:43 -0800
Subject: Re: [PATCH v2 01/15] MIPS: memblock: Add RESERVED_NOMAP memory flag
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>,
        <goran.ferenc@mips.com>, <david.daney@cavium.com>,
        <paul.gortmaker@windriver.com>, <paul.burton@mips.com>,
        <alex.belits@cavium.com>, <Steven.Hill@cavium.com>
CC:     <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
 <20180202035458.30456-2-fancer.lancer@gmail.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <f0ba061a-4bce-5471-8a15-da3f85093008@mips.com>
Date:   Tue, 13 Feb 2018 11:21:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-2-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518521318-452060-28484-38070-9
X-BESS-VER: 2018.1.1-r1801291958
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189977
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

On 02/02/18 03:54, Serge Semin wrote:
> Even if nomap flag is specified the reserved memory declared in dts
> isn't really discarded from the buddy allocator in the current code.
> We'll fix it by adding the no-map MIPS memory flag. Additionally
> lets add the RESERVED_NOMAP memory regions handling to the methods,
> which aren't going to be changed in the further patches.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/include/asm/bootinfo.h | 1 +
>   arch/mips/kernel/prom.c          | 8 ++++++--
>   arch/mips/kernel/setup.c         | 8 ++++++++
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
> index e26a093bb17a..276618b5319d 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -90,6 +90,7 @@ extern unsigned long mips_machtype;
>   #define BOOT_MEM_ROM_DATA	2
>   #define BOOT_MEM_RESERVED	3
>   #define BOOT_MEM_INIT_RAM	4
> +#define BOOT_MEM_RESERVED_NOMAP	5
>   
>   /*
>    * A memory map that's built upon what was determined
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 0dbcd152a1a9..b123eb8279cd 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -41,7 +41,7 @@ char *mips_get_machine_name(void)
>   #ifdef CONFIG_USE_OF
>   void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>   {
> -	return add_memory_region(base, size, BOOT_MEM_RAM);
> +	add_memory_region(base, size, BOOT_MEM_RAM);

This is an unrelated change.

>   }
>   
>   void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> @@ -52,7 +52,11 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>   int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
>   					phys_addr_t size, bool nomap)
>   {
> -	add_memory_region(base, size, BOOT_MEM_RESERVED);
> +	if (!nomap)
> +		add_memory_region(base, size, BOOT_MEM_RESERVED);
> +	else
> +		add_memory_region(base, size, BOOT_MEM_RESERVED_NOMAP);
> +
>   	return 0;
>   }
>   
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 702c678de116..1a4d64410303 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -172,6 +172,7 @@ bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
>   				in_ram = true;
>   			break;
>   		case BOOT_MEM_RESERVED:
> +		case BOOT_MEM_RESERVED_NOMAP:
>   			if ((start >= start_ && start < end_) ||
>   			    (start < start_ && start + size >= start_))
>   				free = false;
> @@ -207,6 +208,9 @@ static void __init print_memory_map(void)
>   		case BOOT_MEM_RESERVED:
>   			printk(KERN_CONT "(reserved)\n");
>   			break;
> +		case BOOT_MEM_RESERVED_NOMAP:
> +			printk(KERN_CONT "(reserved nomap)\n");
> +			break;
>   		default:
>   			printk(KERN_CONT "type %lu\n", boot_mem_map.map[i].type);
>   			break;
> @@ -955,9 +959,13 @@ static void __init resource_init(void)
>   			res->name = "System RAM";
>   			res->flags |= IORESOURCE_SYSRAM;
>   			break;
> +		case BOOT_MEM_RESERVED_NOMAP:
> +			res->name = "reserved nomap";
> +			break;
>   		case BOOT_MEM_RESERVED:
>   		default:
>   			res->name = "reserved";
> +			break;

This is an unrelated change.

With those 2 removed, I think this looks fine.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

>   		}
>   
>   		request_resource(&iomem_resource, res);
> 
