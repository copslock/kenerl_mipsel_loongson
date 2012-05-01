Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 11:43:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50107 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903542Ab2EAJns (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 11:43:48 +0200
Date:   Tue, 1 May 2012 10:43:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/9] MIPS: Optimise core library functions for
 microMIPS.
In-Reply-To: <1333984923-445-3-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.00.1205010930260.19691@eddie.linux-mips.org>
References: <1333984923-445-1-git-send-email-sjhill@mips.com> <1333984923-445-3-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 9 Apr 2012, Steven J. Hill wrote:

> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 606c8a9..a0df003 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -26,23 +35,36 @@
>  	.previous
>  
>  	.macro	f_fill64 dst, offset, val, fixup
> -	EX(LONG_S, \val, (\offset +  0 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  1 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  2 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  3 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  4 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  5 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  6 * LONGSIZE)(\dst), \fixup)
> -	EX(LONG_S, \val, (\offset +  7 * LONGSIZE)(\dst), \fixup)
> +#ifdef CONFIG_CPU_MICROMIPS
> +	EX(swp, t8, (\offset + 0 * STORSIZE)(\dst), \fixup)
> +	EX(swp, t8, (\offset + 1 * STORSIZE)(\dst), \fixup)
> +	EX(swp, t8, (\offset + 2 * STORSIZE)(\dst), \fixup)
> +	EX(swp, t8, (\offset + 3 * STORSIZE)(\dst), \fixup)
> +#if LONGSIZE == 4
> +	EX(swp, t8, (\offset + 4 * STORSIZE)(\dst), \fixup)
> +	EX(swp, t8, (\offset + 5 * STORSIZE)(\dst), \fixup)
> +	EX(swp, t8, (\offset + 6 * STORSIZE)(\dst), \fixup)
> +	EX(swp, t8, (\offset + 7 * STORSIZE)(\dst), \fixup)
> +#endif

 This looks bogus to me, either define LONG_SP to SWP or SDP (in 
<asm/asm.h>) based on _MIPS_SZLONG or #error on LONGSIZE != 4.  Also it 
would make sense to make this macro respect val in the microMIPS mode too, 
then an appropriate #define to a1/t8 elsewhere in this file will do.  
Otherwise it's pure obfuscation.

> diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
> index fdbb970..60fa23b 100644
> --- a/arch/mips/lib/strlen_user.S
> +++ b/arch/mips/lib/strlen_user.S
> @@ -28,9 +29,13 @@ LEAF(__strlen_user_asm)
>  
>  FEXPORT(__strlen_user_nocheck_asm)
>  	move		v0, a0
> -1:	EX(lb, t0, (v0), .Lfault)
> +#ifdef CONFIG_CPU_MICROMIPS
> +1:	EX(lbu16, v1, (v0), .Lfault)
> +#else
> +1:	EX(lb, v1, (v0), .Lfault)
> +#endif
>  	PTR_ADDIU	v0, 1
> -	bnez		t0, 1b
> +	bnez		v1, 1b
>  	PTR_SUBU	v0, a0
>  	jr		ra
>  	END(__strlen_user_asm)

 Perhaps just LBU in all cases?  You'll avoid the ugly #ifdef.

> diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
> index 7201b2f..bcbb9a0 100644
> --- a/arch/mips/lib/strncpy_user.S
> +++ b/arch/mips/lib/strncpy_user.S
> @@ -30,30 +31,32 @@
>  LEAF(__strncpy_from_user_asm)
>  	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
>  	and		v0, a1
> +#ifdef CONFIG_CPU_MICROMIPS
> +	bnezc		v0, .Lfault
> +#else
>  	bnez		v0, .Lfault
> +#endif

 You don't need this, .Lfault is surely within 126 bytes from here so GAS 
will relax the branch to its 16-bit encoding which will give an equivalent 
result.  Relaxing to compact branches is not supported by GAS at the 
moment.

>  FEXPORT(__strncpy_from_user_nocheck_asm)
> -	move		v0, zero
> -	move		v1, a1
>  	.set		noreorder
> -1:	EX(lbu, t0, (v1), .Lfault)
> +	move		t0, zero
> +	move		v1, a1
> +1:	EX(lbu, v0, (v1), .Lfault)
>  	PTR_ADDIU	v1, 1
>  	R10KCBARRIER(0(ra))
> -	beqz		t0, 2f
> -	 sb		t0, (a0)
> -	PTR_ADDIU	v0, 1
> -	.set		reorder
> -	PTR_ADDIU	a0, 1
> -	bne		v0, a2, 1b
> -2:	PTR_ADDU	t0, a1, v0
> -	xor		t0, a1
> -	bltz		t0, .Lfault
> +	beqz		v0, 2f
> +	 sb		v0, (a0)
> +	PTR_ADDIU	t0, 1
> +	bne		t0, a2, 1b
> +	 PTR_ADDIU	a0, 1
> +2:	PTR_ADDU	v0, a1, t0
> +	xor		v0, a1
> +	bltz		v0, .Lfault
> +	 nop
>  	jr		ra			# return n
> +	move		v0, t0
>  	END(__strncpy_from_user_asm)

 You don't need all of this, GAS will schedule these delay slots just fine 
in the microMIPS mode.

> -.Lfault:	li		v0, -EFAULT
> +.Lfault:
>  	jr		ra
> -
> -	.section	__ex_table,"a"
> -	PTR		1b, .Lfault
> -	.previous
> +	 li		v0, -EFAULT

 It looks like an independent bug fix -- submit separately?

> diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
> index 6445716..9090ced 100644
> --- a/arch/mips/lib/strnlen_user.S
> +++ b/arch/mips/lib/strnlen_user.S
> @@ -26,21 +27,34 @@
>   *       the maximum is a tad hairier ...
>   */
>  LEAF(__strnlen_user_asm)
> +	.set	noreorder
>  	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
>  	and		v0, a0
> +#ifdef CONFIG_CPU_MICROMIPS
> +	bnezc		v0, .Lfault
> +#else
>  	bnez		v0, .Lfault
> +#endif

 Again you don't need this, see above.

>  FEXPORT(__strnlen_user_nocheck_asm)
> -	move		v0, a0
>  	PTR_ADDU	a1, a0			# stop pointer
> +	move		v0, a0
>  1:	beq		v0, a1, 1f		# limit reached?
> +	 nop
>  	EX(lb, t0, (v0), .Lfault)
> -	PTR_ADDU	v0, 1
> +#ifdef CONFIG_CPU_MICROMIPS
> +	addius5		v0, 1
> +	bnezc		t0, 1b
> +1:	jr		ra
> +	PTR_SUBU	v0, a0
> +#else
>  	bnez		t0, 1b
> -1:	PTR_SUBU	v0, a0
> -	jr		ra
> +	PTR_ADDU	v0, 1
> +1:      jr              ra
> +	PTR_SUBU        v0, a0
> +#endif
>  	END(__strnlen_user_asm)
>  
>  .Lfault:
> -	move		v0, zero
>  	jr		ra
> +	move		v0, zero

 You don't need all of this if you discard .set noreorder and let GAS 
schedule the instructions and pick their optimal encodings itself.

> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index cc0b626..be71d38 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -368,6 +360,12 @@ void __cpuinit build_clear_page(void)
>  	for (i = 0; i < (buf - clear_page_array); i++)
>  		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
>  	pr_debug("\t.set pop\n");
> +#ifdef CONFIG_CPU_MICROMIPS
> +	memcpy(((u8 *)clear_page) - 1, clear_page_array,
> +		ARRAY_SIZE(clear_page_array) * 4);
> +#else
> +	memcpy(clear_page, clear_page_array, ARRAY_SIZE(clear_page_array) * 4);
> +#endif
>  }
>  
>  static void __cpuinit build_copy_load(u32 **buf, int reg, int off)
> @@ -607,6 +605,12 @@ void __cpuinit build_copy_page(void)
>  	for (i = 0; i < (buf - copy_page_array); i++)
>  		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
>  	pr_debug("\t.set pop\n");
> +#ifdef CONFIG_CPU_MICROMIPS
> +	memcpy(((u8 *)copy_page) - 1, copy_page_array,
> +		ARRAY_SIZE(copy_page_array) * 4);
> +#else
> +	memcpy(copy_page, copy_page_array, ARRAY_SIZE(copy_page_array) * 4);
> +#endif
>  }
>  
>  #ifdef CONFIG_SIBYTE_DMA_PAGEOPS

 I suggest that instead of the hacks above you arrange for an alias to 
copy_page with the ISA bit clear.  You won't need these changes then (and 
will get slightly better machine code).

  Maciej
