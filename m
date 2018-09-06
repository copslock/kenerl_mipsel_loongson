Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 09:57:31 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:47602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994553AbeIFH51Bs9k0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 09:57:27 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADE25AC1F;
        Thu,  6 Sep 2018 07:57:21 +0000 (UTC)
Date:   Thu, 6 Sep 2018 09:57:21 +0200
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
Subject: Re: [RFC PATCH 13/29] memblock: replace __alloc_bootmem_nopanic with
 memblock_alloc_from_nopanic
Message-ID: <20180906075721.GV14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-14-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-14-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66012
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

On Wed 05-09-18 18:59:28, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

The translation is simpler here but still a word or two would be nice.
Empty changelogs suck.

To the change
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arc/kernel/unwind.c       | 4 ++--
>  arch/x86/kernel/setup_percpu.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 183391d..2a01dd1 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -181,8 +181,8 @@ static void init_unwind_hdr(struct unwind_table *table,
>   */
>  static void *__init unw_hdr_alloc_early(unsigned long sz)
>  {
> -	return __alloc_bootmem_nopanic(sz, sizeof(unsigned int),
> -				       MAX_DMA_ADDRESS);
> +	return memblock_alloc_from_nopanic(sz, sizeof(unsigned int),
> +					   MAX_DMA_ADDRESS);
>  }
>  
>  static void *unw_hdr_alloc(unsigned long sz)
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index 67d48e26..041663a 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -106,7 +106,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
>  	void *ptr;
>  
>  	if (!node_online(node) || !NODE_DATA(node)) {
> -		ptr = __alloc_bootmem_nopanic(size, align, goal);
> +		ptr = memblock_alloc_from_nopanic(size, align, goal);
>  		pr_info("cpu %d has no node %d or node-local memory\n",
>  			cpu, node);
>  		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
> @@ -121,7 +121,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
>  	}
>  	return ptr;
>  #else
> -	return __alloc_bootmem_nopanic(size, align, goal);
> +	return memblock_alloc_from_nopanic(size, align, goal);
>  #endif
>  }
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
