Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 10:38:51 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:53506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992916AbeIFIirf6P0A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 10:38:47 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26C04AE39;
        Thu,  6 Sep 2018 08:38:42 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:38:41 +0200
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
Subject: Re: [RFC PATCH 16/29] memblock: replace __alloc_bootmem_node with
 appropriate memblock_ API
Message-ID: <20180906083841.GA14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-17-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-17-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66016
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

On Wed 05-09-18 18:59:31, Mike Rapoport wrote:
> Use memblock_alloc_try_nid whenever goal (i.e. mininal address is
> specified) and memblock_alloc_node otherwise.

I suspect you wanted to say (i.e. minimal address) is specified

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

One note below

> ---
>  arch/ia64/mm/discontig.c       |  6 ++++--
>  arch/ia64/mm/init.c            |  2 +-
>  arch/powerpc/kernel/setup_64.c |  6 ++++--
>  arch/sparc/kernel/setup_64.c   | 10 ++++------
>  arch/sparc/kernel/smp_64.c     |  4 ++--
>  5 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index 1928d57..918dda9 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -451,8 +451,10 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
>  	if (bestnode == -1)
>  		bestnode = anynode;
>  
> -	ptr = __alloc_bootmem_node(pgdat_list[bestnode], pernodesize,
> -		PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
> +	ptr = memblock_alloc_try_nid(pernodesize, PERCPU_PAGE_SIZE,
> +				     __pa(MAX_DMA_ADDRESS),
> +				     BOOTMEM_ALLOC_ACCESSIBLE,
> +				     bestnode);
>  
>  	return ptr;
>  }
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index ffcc358..2169ca5 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -459,7 +459,7 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
>  		pte = pte_offset_kernel(pmd, address);
>  
>  		if (pte_none(*pte))
> -			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node))) >> PAGE_SHIFT,
> +			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node)) >> PAGE_SHIFT,
>  					     PAGE_KERNEL));

This doesn't seem to belong to the patch, right?

>  	}
>  	return 0;
-- 
Michal Hocko
SUSE Labs
