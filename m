Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 15:17:49 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43765 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992363AbeHaNRo12YXV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 15:17:44 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4AEAA20797; Fri, 31 Aug 2018 15:17:39 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1617E206F6;
        Fri, 31 Aug 2018 15:17:29 +0200 (CEST)
Date:   Fri, 31 Aug 2018 15:17:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Rene Nielsen <rene.nielsen@microsemi.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Message-ID: <20180831131728.GO16561@piout.net>
References: <20180828160254.GC16561@piout.net>
 <20180830180121.25363-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830180121.25363-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 30/08/2018 11:01:21-0700, Paul Burton wrote:
> When a system suffers from dcache aliasing a user program may observe
> stale VDSO data from an aliased cache line. Notably this can break the
> expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
> suggests, monotonic.
> 
> In order to ensure that users observe updates to the VDSO data page as
> intended, align the user mappings of the VDSO data page such that their
> cache colouring matches that of the virtual address range which the
> kernel will use to update the data page - typically its unmapped address
> within kseg0.
> 
> This ensures that we don't introduce aliasing cache lines for the VDSO
> data page, and therefore that userland will observe updates without
> requiring cache invalidation.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org # v4.4+
> ---
> Hi Alexandre,
> 
> Could you try this out on your Ocelot system? Hopefully it'll solve the
> problem just as well as James' patch but doesn't need the questionable
> change to arch_get_unmapped_area_common().
> 
> Thanks,
>     Paul
> ---
>  arch/mips/kernel/vdso.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 019035d7225c..5fb617a42335 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -20,6 +21,7 @@
>  
>  #include <asm/abi.h>
>  #include <asm/mips-cps.h>
> +#include <asm/page.h>
>  #include <asm/vdso.h>
>  
>  /* Kernel-provided data used by the VDSO. */
> @@ -128,12 +130,30 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	vvar_size = gic_size + PAGE_SIZE;
>  	size = vvar_size + image->size;
>  
> +	/*
> +	 * Find a region that's large enough for us to perform the
> +	 * colour-matching alignment below.
> +	 */
> +	if (cpu_has_dc_aliases)
> +		size += shm_align_mask + 1;
> +
>  	base = get_unmapped_area(NULL, 0, size, 0, 0);
>  	if (IS_ERR_VALUE(base)) {
>  		ret = base;
>  		goto out;
>  	}
>  
> +	/*
> +	 * If we suffer from dcache aliasing, ensure that the VDSO data page is
> +	 * coloured the same as the kernel's mapping of that memory. This
> +	 * ensures that when the kernel updates the VDSO data userland will see
> +	 * it without requiring cache invalidations.
> +	 */
> +	if (cpu_has_dc_aliases) {
> +		base = __ALIGN_MASK(base, shm_align_mask);
> +		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
> +	}
> +
>  	data_addr = base + gic_size;
>  	vdso_addr = data_addr + PAGE_SIZE;
>  
> -- 
> 2.18.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
