Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 22:35:13 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:39062 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025187AbZEMVfH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 May 2009 22:35:07 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n4DLYxvw026735;
	Wed, 13 May 2009 14:34:59 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 May 2009 14:34:58 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 May 2009 14:34:58 -0700
Received: from paul by yow-pgortmak-d1.corp.ad.wrs.com with local (Exim 4.69)
	(envelope-from <paul.gortmaker@windriver.com>)
	id 1M4M6J-0003ts-Bc; Wed, 13 May 2009 17:34:55 -0400
Date:	Wed, 13 May 2009 17:34:55 -0400
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	David VomLehn <dvomlehn@cisco.com>
Subject: Re: [PATCH 1/2] MIPS: Replace some magic numbers with symbolic
	values in tlbex.c
Message-ID: <20090513213455.GB14421@windriver.com>
References: <4A0B31C6.9050804@caviumnetworks.com> <1242247717-21324-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242247717-21324-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 13 May 2009 21:34:58.0947 (UTC) FILETIME=[AA5CAD30:01C9D412]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

[[PATCH 1/2] MIPS: Replace some magic numbers with symbolic values in tlbex.c] On 13/05/2009 (Wed 13:48) David Daney wrote:

> The logic used to split the r4000 refill handler is liberally
> sprinkled with magic numbers.  We attempt to explain what they are and
> normalize them against a new symbolic value (MIPS64_REFILL_INSNS).
> 
> CC: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: David VomLehn <dvomlehn@cisco.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/mm/tlbex.c |   34 ++++++++++++++++++++++++++--------
>  1 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 4dc4f3e..d99ed78 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -649,6 +649,14 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
>  #endif
>  }
>  
> +/*
> + * For a 64-bit kernel, we are using the 64-bit XTLB refill execption

                                              "exception"

 -- aside from that, I've double checked that the changes should be inert
(excluding the improved readability).   You can add a:

Reviewed-by: Paul Gortmaker <paul.gortmaker@windriver.com>

if you want, or given that it really isn't a complex patch, feel free
to reduce the clutter and no need to mention me at all.  Your choice.

Thanks for the cleanup,
Paul.

> + * because EXL == 0.  If we wrap, we can also use the 32 instruction
> + * slots before the XTLB refill exception handler which belong to the
> + * unused TLB refill exception.
> + */
> +#define MIPS64_REFILL_INSNS 32
> +
>  static void __cpuinit build_r4000_tlb_refill_handler(void)
>  {
>  	u32 *p = tlb_handler;
> @@ -702,9 +710,10 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>  	if ((p - tlb_handler) > 64)
>  		panic("TLB refill handler space exceeded");
>  #else
> -	if (((p - tlb_handler) > 63)
> -	    || (((p - tlb_handler) > 61)
> -		&& uasm_insn_has_bdelay(relocs, tlb_handler + 29)))
> +	if (((p - tlb_handler) > (MIPS64_REFILL_INSNS * 2) - 1)
> +	    || (((p - tlb_handler) > (MIPS64_REFILL_INSNS * 2) - 3)
> +		&& uasm_insn_has_bdelay(relocs,
> +					tlb_handler + MIPS64_REFILL_INSNS - 3)))
>  		panic("TLB refill handler space exceeded");
>  #endif
>  
> @@ -717,16 +726,24 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>  	uasm_copy_handler(relocs, labels, tlb_handler, p, f);
>  	final_len = p - tlb_handler;
>  #else /* CONFIG_64BIT */
> -	f = final_handler + 32;
> -	if ((p - tlb_handler) <= 32) {
> +	f = final_handler + MIPS64_REFILL_INSNS;
> +	if ((p - tlb_handler) <= MIPS64_REFILL_INSNS) {
>  		/* Just copy the handler. */
>  		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
>  		final_len = p - tlb_handler;
>  	} else {
> -		u32 *split = tlb_handler + 30;
> +		/*
> +		 * Split two instructions before the end.  One for the
> +		 * branch and one for the instruction in the delay
> +		 * slot.
> +		 */
> +		u32 *split = tlb_handler + MIPS64_REFILL_INSNS - 2;
>  
>  		/*
> -		 * Find the split point.
> +		 * Find the split point.  If the branch would fall in
> +		 * a delay slot, we must back up an additional
> +		 * instruction so that it is no longer in a delay
> +		 * slot.
>  		 */
>  		if (uasm_insn_has_bdelay(relocs, split - 1))
>  			split--;
> @@ -749,7 +766,8 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>  
>  		/* Copy the rest of the handler. */
>  		uasm_copy_handler(relocs, labels, split, p, final_handler);
> -		final_len = (f - (final_handler + 32)) + (p - split);
> +		final_len = (f - (final_handler + MIPS64_REFILL_INSNS)) +
> +			    (p - split);
>  	}
>  #endif /* CONFIG_64BIT */
>  
> -- 
> 1.6.0.6
> 
