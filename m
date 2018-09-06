Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 09:55:56 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:47344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994553AbeIFHzwt2qI0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 09:55:52 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55AB0AC1F;
        Thu,  6 Sep 2018 07:55:47 +0000 (UTC)
Date:   Thu, 6 Sep 2018 09:55:46 +0200
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
Subject: Re: [RFC PATCH 12/29] memblock: replace alloc_bootmem_low with
 memblock_alloc_low
Message-ID: <20180906075546.GU14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-13-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-13-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66011
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

On Wed 05-09-18 18:59:27, Mike Rapoport wrote:
> The alloc_bootmem_low(size) allocates low memory with default alignement
> and can be replcaed by memblock_alloc_low(size, 0)
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Again _virt renaming thing...
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm64/kernel/setup.c     | 2 +-
>  arch/unicore32/kernel/setup.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 5b4fac4..cf7a7b7 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -213,7 +213,7 @@ static void __init request_standard_resources(void)
>  	kernel_data.end     = __pa_symbol(_end - 1);
>  
>  	for_each_memblock(memory, region) {
> -		res = alloc_bootmem_low(sizeof(*res));
> +		res = memblock_alloc_low(sizeof(*res), 0);
>  		if (memblock_is_nomap(region)) {
>  			res->name  = "reserved";
>  			res->flags = IORESOURCE_MEM;
> diff --git a/arch/unicore32/kernel/setup.c b/arch/unicore32/kernel/setup.c
> index c2bffa5..9f163f9 100644
> --- a/arch/unicore32/kernel/setup.c
> +++ b/arch/unicore32/kernel/setup.c
> @@ -207,7 +207,7 @@ request_standard_resources(struct meminfo *mi)
>  		if (mi->bank[i].size == 0)
>  			continue;
>  
> -		res = alloc_bootmem_low(sizeof(*res));
> +		res = memblock_alloc_low(sizeof(*res), 0);
>  		res->name  = "System RAM";
>  		res->start = mi->bank[i].start;
>  		res->end   = mi->bank[i].start + mi->bank[i].size - 1;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
