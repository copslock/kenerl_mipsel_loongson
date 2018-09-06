Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 11:02:52 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:57410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994630AbeIFJCsQTNpA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 11:02:48 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9395AF6A;
        Thu,  6 Sep 2018 09:02:42 +0000 (UTC)
Date:   Thu, 6 Sep 2018 11:02:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 24/29] memblock: replace free_bootmem_late with
 memblock_free_late
Message-ID: <20180906090242.GI14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-25-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-25-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Wed 05-09-18 18:59:39, Mike Rapoport wrote:
> The free_bootmem_late and memblock_free_late do exactly the same thing:
> they iterate over a range and give pages to the page allocator.
> 
> Replace calls to free_bootmem_late with calls to memblock_free_late and
> remove the bootmem variant.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/sparc/kernel/mdesc.c               |  3 ++-
>  arch/x86/platform/efi/quirks.c          |  6 +++---
>  drivers/firmware/efi/apple-properties.c |  2 +-
>  include/linux/bootmem.h                 |  2 --
>  mm/nobootmem.c                          | 24 ------------------------
>  5 files changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 59131e7..a41526b 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/miscdevice.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/export.h>
>  #include <linux/refcount.h>
>  
> @@ -190,7 +191,7 @@ static void __init mdesc_memblock_free(struct mdesc_handle *hp)
>  
>  	alloc_size = PAGE_ALIGN(hp->handle_size);
>  	start = __pa(hp);
> -	free_bootmem_late(start, alloc_size);
> +	memblock_free_late(start, alloc_size);
>  }
>  
>  static struct mdesc_mem_ops memblock_mdesc_ops = {
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 844d31c..7b4854c 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -332,7 +332,7 @@ void __init efi_reserve_boot_services(void)
>  
>  		/*
>  		 * Because the following memblock_reserve() is paired
> -		 * with free_bootmem_late() for this region in
> +		 * with memblock_free_late() for this region in
>  		 * efi_free_boot_services(), we must be extremely
>  		 * careful not to reserve, and subsequently free,
>  		 * critical regions of memory (like the kernel image) or
> @@ -363,7 +363,7 @@ void __init efi_reserve_boot_services(void)
>  		 * doesn't make sense as far as the firmware is
>  		 * concerned, but it does provide us with a way to tag
>  		 * those regions that must not be paired with
> -		 * free_bootmem_late().
> +		 * memblock_free_late().
>  		 */
>  		md->attribute |= EFI_MEMORY_RUNTIME;
>  	}
> @@ -413,7 +413,7 @@ void __init efi_free_boot_services(void)
>  			size -= rm_size;
>  		}
>  
> -		free_bootmem_late(start, size);
> +		memblock_free_late(start, size);
>  	}
>  
>  	if (!num_entries)
> diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
> index 60a9571..2b675f7 100644
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -235,7 +235,7 @@ static int __init map_properties(void)
>  		 */
>  		data->len = 0;
>  		memunmap(data);
> -		free_bootmem_late(pa_data + sizeof(*data), data_len);
> +		memblock_free_late(pa_data + sizeof(*data), data_len);
>  
>  		return ret;
>  	}
> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index 706cf8e..bcc7e2f 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -30,8 +30,6 @@ extern unsigned long free_all_bootmem(void);
>  extern void reset_node_managed_pages(pg_data_t *pgdat);
>  extern void reset_all_zones_managed_pages(void);
>  
> -extern void free_bootmem_late(unsigned long physaddr, unsigned long size);
> -
>  /* We are using top down, so it is safe to use 0 here */
>  #define BOOTMEM_LOW_LIMIT 0
>  
> diff --git a/mm/nobootmem.c b/mm/nobootmem.c
> index 85e1822..ee0f7fc 100644
> --- a/mm/nobootmem.c
> +++ b/mm/nobootmem.c
> @@ -33,30 +33,6 @@ unsigned long min_low_pfn;
>  unsigned long max_pfn;
>  unsigned long long max_possible_pfn;
>  
> -/**
> - * free_bootmem_late - free bootmem pages directly to page allocator
> - * @addr: starting address of the range
> - * @size: size of the range in bytes
> - *
> - * This is only useful when the bootmem allocator has already been torn
> - * down, but we are still initializing the system.  Pages are given directly
> - * to the page allocator, no bootmem metadata is updated because it is gone.
> - */
> -void __init free_bootmem_late(unsigned long addr, unsigned long size)
> -{
> -	unsigned long cursor, end;
> -
> -	kmemleak_free_part_phys(addr, size);
> -
> -	cursor = PFN_UP(addr);
> -	end = PFN_DOWN(addr + size);
> -
> -	for (; cursor < end; cursor++) {
> -		__free_pages_bootmem(pfn_to_page(cursor), cursor, 0);
> -		totalram_pages++;
> -	}
> -}
> -
>  static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  {
>  	int order;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
