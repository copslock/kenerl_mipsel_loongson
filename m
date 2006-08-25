Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 16:22:52 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:58311 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038801AbWHYPWu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 16:22:50 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 492B5468E1; Fri, 25 Aug 2006 17:22:56 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GGdUn-0008GN-T6; Fri, 25 Aug 2006 16:21:21 +0100
Date:	Fri, 25 Aug 2006 16:21:21 +0100
To:	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH 2] 64K page size
Message-ID: <20060825152121.GF2887@networkno.de>
References: <44EF0C61.7090008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EF0C61.7090008@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Peter Watkins wrote:
> Hello,
> 
> Attached is the rest of the 64K page patch. It's been tested 
> uniprocessor on Malta 20KC and 25KF. It also runs on a 6-way SMP 
> functional simulator containing 5KF's. Ran tests with 16K and 64K page 
> size.
> 
> Question: Is there an SMP malta board?

You mean a SMP core card? None I heard of.

> There are 2 areas which could use improvement:
> 
> (1) Because 64K is larger than a 15 bit immediate operand, I could not 
> get the asm-offsets mechanism to produce the correct constants. So I 
> enlisted a fairly gruesome hack of using #define's for _PAGE_SIZE and 
> _THREAD_SIZE, for that page size. Hopefully someone has a better idea.
> 
> (2) In tlbex.c:build_adjust_context(), I suspect the change for shift = 
> PAGE_SHIFT - 12 should be more generally true, rather than just for the 
> CPU's mentioned in the case statement.

It should be added to the initial shift calculation instead, i suspect
it will break 32bit kernels elsewise. It should be generally the same
for all CPUs with r4k-style TLBs.

> I was conservative there because 
> I'm not familiar with the CPU_VR41* machines. Hopefully someone more 
> intimate with that code can comment.

The vr41xx has a different/broken page mask in order to support 1k pages
(which aren't used by linux). The shift += 2 fixes this up.

[snip]
> index c06f63e..c9de17c 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -190,7 +190,12 @@ #endif /* CONFIG_MIPS_MT_SMTC */
>  
>  	MTC0		zero, CP0_CONTEXT	# clear context register
>  	PTR_LA		$28, init_thread_union
> +#ifdef CONFIG_PAGE_SIZE_64KB
> +	PTR_ADDIU	sp, $28, (_THREAD_SIZE - 32)/2
> +	PTR_ADDIU	sp,  sp, (_THREAD_SIZE - 32)/2
> +#else
>  	PTR_ADDIU	sp, $28, _THREAD_SIZE - 32
> +#endif

A PTR_LI ... ; PTR_ADDU sequence would be better, without an #ifdef.
This isn't a critical path of execution, and one day we might go for
even bigger pagesizes. Likewise for the other doubled addiu in this
patch.

[snip]
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 375e099..bf093aa 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -97,6 +97,8 @@ #define FUNC_SH		0
>  #define SET_MASK	0x7
>  #define SET_SH		0
>  
> +#define OP_ERET		0x42000018
> +
>  enum opcode {
>  	insn_invalid,
>  	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
> @@ -631,6 +633,9 @@ static __init void copy_handler(struct r
>  static __init int __attribute__((unused)) insn_has_bdelay(struct reloc *rel,
>  							  u32 *addr)
>  {
> +	if (*addr == OP_ERET)
> +		return 1;
> +

Why? Eret has no BD slot.

>  	for (; rel->lab != label_invalid; rel++) {
>  		if (rel->addr == addr
>  		    && (rel->type == R_MIPS_PC16
> @@ -996,7 +1001,12 @@ #else
>  #endif
>  
>  	l_vmalloc_done(l, *p);
> -	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3); /* get pgd offset in bytes */
> +
> +	/* Want PGDIR_SHIFT-3 here, but break it into two ops so we don't
> +	 * exceed the max shift amount of 31 with large page sizes. */
> +	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-16);   	/* get pgd offset in bytes */
> +	i_dsrl(p, tmp, tmp, 16-3); 		/* get pgd offset in bytes */

This cries for a single i_dsrl32 for the large page case.

> +
>  	i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
>  	i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
>  	i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
> @@ -1087,6 +1097,11 @@ static __init void build_adjust_context(
>  	case CPU_VR4133:
>  		shift += 2;
>  		break;
> +	case CPU_20KC:
> +	case CPU_25KF:
> +	case CPU_5KC:
> +		shift  = PAGE_SHIFT - 12;
> +		break;

As said, should be done for all CPUs. (This will also fix the vr41xx
case, just in case somebody is crazy enough to go for large pages
on his PDA. :-)


Thiemo
