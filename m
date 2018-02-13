Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 15:24:30 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:60388 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994584AbeBMOYWrp3K0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 15:24:22 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 13 Feb 2018 14:22:49 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 13 Feb
 2018 06:17:26 -0800
Subject: Re: [PATCH v2 14/15] MIPS: memblock: Discard bootmem from SGI IP27
 code
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
 <20180202035458.30456-15-fancer.lancer@gmail.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <4de8dba6-64bb-599f-c67e-e6fb97db87de@mips.com>
Date:   Tue, 13 Feb 2018 14:17:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-15-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518531768-321458-10267-39691-6
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189978
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
X-archive-position: 62527
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
> SGI IP27 got its own code to set the early memory allocator up since it's
> NUMA-based system. So in order to be compatible with NO_BOOTMEM config
> we need to discard the bootmem allocator initialization and insert the
> memblock reservation method. Although in my opinion the code isn't
> working anyway since I couldn't find a place where prom_meminit() called
> and kernel memory isn't reserved. It must have been untested since the
> time the arch/mips/mips-boards/generic code was in the kernel.

I don't have access to an IP27, but the change looks sensible to me.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/sgi-ip27/ip27-memory.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index 59133d0abc83..c480ee3eca96 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -389,7 +389,6 @@ static void __init node_mem_init(cnodeid_t node)
>   {
>   	unsigned long slot_firstpfn = slot_getbasepfn(node, 0);
>   	unsigned long slot_freepfn = node_getfirstfree(node);
> -	unsigned long bootmap_size;
>   	unsigned long start_pfn, end_pfn;
>   
>   	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
> @@ -400,7 +399,6 @@ static void __init node_mem_init(cnodeid_t node)
>   	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
>   	memset(__node_data[node], 0, PAGE_SIZE);
>   
> -	NODE_DATA(node)->bdata = &bootmem_node_data[node];
>   	NODE_DATA(node)->node_start_pfn = start_pfn;
>   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
>   
> @@ -409,12 +407,9 @@ static void __init node_mem_init(cnodeid_t node)
>   	slot_freepfn += PFN_UP(sizeof(struct pglist_data) +
>   			       sizeof(struct hub_data));
>   
> -	bootmap_size = init_bootmem_node(NODE_DATA(node), slot_freepfn,
> -					start_pfn, end_pfn);
>   	free_bootmem_with_active_regions(node, end_pfn);
> -	reserve_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
> -		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT) + bootmap_size,
> -		BOOTMEM_DEFAULT);
> +	memblock_reserve(slot_firstpfn << PAGE_SHIFT,
> +		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT));

How about PFN_PHYS()? In fact, that could be used throughout the series 
to tidy up some of the shifting by PAGE_SIZE.

Thanks,
Matt

>   	sparse_memory_present_with_active_regions(node);
>   }
>   
> 
