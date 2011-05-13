Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:52:00 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:51088 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491849Ab1EMPv4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 17:51:56 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id 7329A80C2A; Fri, 13 May 2011 16:51:55 +0100 (BST)
Date:   Fri, 13 May 2011 16:51:55 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, ddaney@caviumnetworks.com
Subject: Re: [RFC|PATCH] MIPS: tlbex.c: Fix GCC 4.6.0 build error.
Message-ID: <20110513155155.GP25017@chipmunk>
References: <20110513154941.GN25017@chipmunk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110513154941.GN25017@chipmunk>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Forget this, just seen it in upstream as 
4a9040f451c32cd62971ecda1cb5bc4aed444c78.

Cheers

* Alexander Clouter <alex@digriz.org.uk> [2011-05-13 16:49:41+0100]:
>
> For !HUGETLB_PAGE htlb_info barfs, and when !64BIT we get vmalloc_mode
> grumbling.
> 
>   CC      arch/mips/mm/tlbex.o
> arch/mips/mm/tlbex.c: In function 'build_r4000_tlb_refill_handler':
> arch/mips/mm/tlbex.c:1155:22: error: variable 'vmalloc_mode' set but not used [-Werror=unused-but-set-variable]
> arch/mips/mm/tlbex.c:1154:28: error: variable 'htlb_info' set but not used [-Werror=unused-but-set-variable]
> cc1: all warnings being treated as errors
> 
> Untested other than shovelling through a compiler, it really is turning 
> into an ifdef-fest though in there...
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/mips/mm/tlbex.c |   17 ++++++++++++++++-
>  1 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 04f9e17..814b3f4 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1151,8 +1151,12 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>  	struct uasm_reloc *r = relocs;
>  	u32 *f;
>  	unsigned int final_len;
> +#ifdef CONFIG_HUGETLB_PAGE
>  	struct mips_huge_tlb_info htlb_info;
> +#endif
> +#ifdef CONFIG_64BIT
>  	enum vmalloc64_mode vmalloc_mode;
> +#endif
>  
>  	memset(tlb_handler, 0, sizeof(tlb_handler));
>  	memset(labels, 0, sizeof(labels));
> @@ -1163,13 +1167,24 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>  		scratch_reg = allocate_kscratch();
>  
>  	if ((scratch_reg > 0 || scratchpad_available()) && use_bbit_insns()) {
> -		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
> +#ifdef CONFIG_HUGETLB_PAGE
> +		htlb_info = 
> +#else
> +		(void)
> +#endif
> +			build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
>  							  scratch_reg);
> +#ifdef CONFIG_64BIT
>  		vmalloc_mode = refill_scratch;
> +#endif
>  	} else {
> +#ifdef CONFIG_HUGETLB_PAGE
>  		htlb_info.huge_pte = K0;
>  		htlb_info.restore_scratch = 0;
> +#endif
> +#ifdef CONFIG_64BIT
>  		vmalloc_mode = refill_noscratch;
> +#endif
>  		/*
>  		 * create the plain linear handler
>  		 */
>

-- 
Alexander Clouter
.sigmonster says: Needs are a function of what other people have.
