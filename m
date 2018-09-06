Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 10:08:16 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:49100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992482AbeIFIIKl8E00 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 10:08:10 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F7B7AE0E;
        Thu,  6 Sep 2018 08:08:05 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:08:04 +0200
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
Subject: Re: [RFC PATCH 15/29] memblock: replace alloc_bootmem_pages_node
 with memblock_alloc_node
Message-ID: <20180906080804.GX14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-16-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-16-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66014
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

On Wed 05-09-18 18:59:30, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

again a short work of wisdom please.

The change itself looks good.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/ia64/mm/init.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 3b85c3e..ffcc358 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -447,19 +447,19 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
>  	for (address = start_page; address < end_page; address += PAGE_SIZE) {
>  		pgd = pgd_offset_k(address);
>  		if (pgd_none(*pgd))
> -			pgd_populate(&init_mm, pgd, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
> +			pgd_populate(&init_mm, pgd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
>  		pud = pud_offset(pgd, address);
>  
>  		if (pud_none(*pud))
> -			pud_populate(&init_mm, pud, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
> +			pud_populate(&init_mm, pud, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
>  		pmd = pmd_offset(pud, address);
>  
>  		if (pmd_none(*pmd))
> -			pmd_populate_kernel(&init_mm, pmd, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
> +			pmd_populate_kernel(&init_mm, pmd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
>  		pte = pte_offset_kernel(pmd, address);
>  
>  		if (pte_none(*pte))
> -			set_pte(pte, pfn_pte(__pa(alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE)) >> PAGE_SHIFT,
> +			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node))) >> PAGE_SHIFT,
>  					     PAGE_KERNEL));
>  	}
>  	return 0;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
