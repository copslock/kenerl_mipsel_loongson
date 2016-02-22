Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 00:39:49 +0100 (CET)
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:46709 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012297AbcBVXjruGnYt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 00:39:47 +0100
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-05v.sys.comcast.net with comcast
        id MbfS1s004516pyw01bfgsL; Mon, 22 Feb 2016 23:39:40 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-08v.sys.comcast.net with comcast
        id Mbfd1s00N0w5D3801bfetK; Mon, 22 Feb 2016 23:39:40 +0000
Subject: Re: [PATCH 1/2] MIPS: Add barriers between dcache & icache flushes
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <56CB9C32.2010308@gentoo.org>
Date:   Mon, 22 Feb 2016 18:39:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1456184380;
        bh=xTEYt4FXJt/p8nHcdAtPEVgQ78pFpiqhdr+P4wsWcPw=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=wI33wM/+YY/05+QHOzG24iDASGCr8Ted+wzvgy3Rh2IBidnTYZJz0yenaMxQFWONL
         oOXG6F67mxv/RadN9x+5tu/XKM9LFmfO6DkomUt1cuvF+FhqlCHUoOsCVN+QQ30rZY
         EPGHRunpjFLN+qc3vyar6BnQvzaukjYrl0jebd1qLkgOMR7S7jkUm7Lof2mK1d1kOg
         egu7P0NNs8361qjFMyEoXAvCV8cyWUakznsmyNRsjzAYX45hD/ZLLqt8FVFN5gGogs
         YU55b5CvYKASaJjMhj91cefDw2ar4iDVmzzLM4LmNxbBiXYuwgyLtWcu2zp0ZhTYG+
         a8iafl6FdE8WA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 02/22/2016 13:09, Paul Burton wrote:
> Index-based cache operations may be arbitrarily reordered by out of
> order CPUs. Thus code which writes back the dcache & then invalidates
> the icache using indexed cache ops must include a barrier between
> operating on the 2 caches in order to prevent the scenario in which:
> 
>   - icache invalidation occurs.
> 
>   - icache fetch occurs, due to speculation.
> 
>   - dcache writeback occurs.
> 
> If the above were allowed to happen then the icache would contain stale
> data. Forcing the dcache writeback to complete before the icache
> invalidation avoids this.

Is there a particular symptom one should look for to check for this issue
occurring?  I haven't seen any odd effects on my SGI systems that appear to
relate to this.  I believe the R1x000 family resolves all hazards in hardware,
so maybe this issue doesn't affect that CPU family?

If not, let me know what to look or test for so I can check the patch out on my
systems.

Thanks!

--J


> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> ---
> 
>  arch/mips/mm/c-r4k.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index caac3d7..a49010c 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -449,6 +449,7 @@ static inline void local_r4k___flush_cache_all(void * args)
>  
>  	default:
>  		r4k_blast_dcache();
> +		mb(); /* cache instructions may be reordered */
>  		r4k_blast_icache();
>  		break;
>  	}
> @@ -493,8 +494,10 @@ static inline void local_r4k_flush_cache_range(void * args)
>  		return;
>  
>  	r4k_blast_dcache();
> -	if (exec)
> +	if (exec) {
> +		mb(); /* cache instructions may be reordered */
>  		r4k_blast_icache();
> +	}
>  }
>  
>  static void r4k_flush_cache_range(struct vm_area_struct *vma,
> @@ -599,8 +602,13 @@ static inline void local_r4k_flush_cache_page(void *args)
>  	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
>  		vaddr ? r4k_blast_dcache_page(addr) :
>  			r4k_blast_dcache_user_page(addr);
> -		if (exec && !cpu_icache_snoops_remote_store)
> +		if (exec)
> +			mb(); /* cache instructions may be reordered */
> +
> +		if (exec && !cpu_icache_snoops_remote_store) {
>  			r4k_blast_scache_page(addr);
> +			mb(); /* cache instructions may be reordered */
> +		}
>  	}
>  	if (exec) {
>  		if (vaddr && cpu_has_vtag_icache && mm == current->active_mm) {
> @@ -660,6 +668,7 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
>  			R4600_HIT_CACHEOP_WAR_IMPL;
>  			protected_blast_dcache_range(start, end);
>  		}
> +		mb(); /* cache instructions may be reordered */
>  	}
>  
>  	if (end - start > icache_size)
> @@ -798,6 +807,8 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>  		protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
>  	if (!cpu_icache_snoops_remote_store && scache_size)
>  		protected_writeback_scache_line(addr & ~(sc_lsize - 1));
> +	if ((dc_lsize || scache_size) && ic_lsize)
> +		mb(); /* cache instructions may be reordered */
>  	if (ic_lsize)
>  		protected_flush_icache_line(addr & ~(ic_lsize - 1));
>  	if (MIPS4K_ICACHE_REFILL_WAR) {
> 
