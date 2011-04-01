Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2011 18:57:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9011 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491154Ab1DAQ5L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2011 18:57:11 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d9604180000>; Fri, 01 Apr 2011 09:58:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Apr 2011 09:57:03 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Apr 2011 09:57:03 -0700
Message-ID: <4D9603D8.2010709@caviumnetworks.com>
Date:   Fri, 01 Apr 2011 09:56:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Sundius <msundius@cisco.com>,
        David VomLehn <dvomlehn@cisco.com>,
        Dave Hansen <dave@linux.vnet.ibm.com>,
        Andy Whitcroft <apw@shadowen.org>,
        Jon Fraser <jfraser@broadcom.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v2] MIPS: Kernel crashes on boot with SPARSEMEM + HIGHMEM
 enabled
References: <c300b67a7a723369872c0b9a023d0b2e@localhost>
In-Reply-To: <c300b67a7a723369872c0b9a023d0b2e@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2011 16:57:03.0017 (UTC) FILETIME=[D2EFB190:01CBF08D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/31/2011 05:27 PM, Kevin Cernekee wrote:
> From: Michael Sundius<msundius@cisco.com>
>
> Fix 3 problems in the MIPS SPARSEMEM implementation:
>
> 1) mem_init() sets/clears PG_reserved on all pages in the HIGHMEM range
> without checking to see whether the page descriptor actually exists.
>
> 2) bootmem_init() never calls memory_present() on HIGHMEM pages, so
> page descriptors are never created for them if SPARSEMEM is enabled.
>
> 3) bootmem_init() calls memory_present() on lowmem pages before bootmem
> is fully set up.  This is bad because memory_present() can allocate
> bootmem in some circumstances (e.g. if SPARSEMEM_EXTREME ever got
> enabled).
>


I think this may do the same thing as my patch:

http://patchwork.linux-mips.org/patch/1988/

Although my patch had different motivations, and changes some other 
things around too.

David Daney


> Signed-off-by: Michael Sundius<msundius@cisco.com>
> Signed-off-by: Kevin Cernekee<cernekee@gmail.com>
> Cc: stable@kernel.org
> ---
>   arch/mips/kernel/setup.c |   18 +++++++++++++++++-
>   arch/mips/mm/init.c      |    3 +++
>   2 files changed, 20 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 8ad1d56..1f9f902 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -390,7 +390,6 @@ static void __init bootmem_init(void)
>
>   		/* Register lowmem ranges */
>   		free_bootmem(PFN_PHYS(start), size<<  PAGE_SHIFT);
> -		memory_present(0, start, end);
>   	}
>
>   	/*
> @@ -402,6 +401,23 @@ static void __init bootmem_init(void)
>   	 * Reserve initrd memory if needed.
>   	 */
>   	finalize_initrd();
> +
> +	/*
> +	 * Call memory_present() on all valid ranges, for SPARSEMEM.
> +	 * This must be done after setting up bootmem, since memory_present()
> +	 * may allocate bootmem.
> +	 */
> +	for (i = 0; i<  boot_mem_map.nr_map; i++) {
> +		unsigned long start, end;
> +
> +		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
> +			continue;
> +
> +		start = PFN_UP(boot_mem_map.map[i].addr);
> +		end   = PFN_DOWN(boot_mem_map.map[i].addr
> +				    + boot_mem_map.map[i].size);
> +		memory_present(0, start, end);
> +	}
>   }
>
>   #endif	/* CONFIG_SGI_IP27 */
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 279599e..78a4cf2 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -392,6 +392,9 @@ void __init mem_init(void)
>   	for (tmp = highstart_pfn; tmp<  highend_pfn; tmp++) {
>   		struct page *page = pfn_to_page(tmp);
>
> +		if (!pfn_valid(tmp))
> +			continue;
> +
>   		if (!page_is_ram(tmp)) {
>   			SetPageReserved(page);
>   			continue;
