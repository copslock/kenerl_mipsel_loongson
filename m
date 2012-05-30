Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 19:50:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9885 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2E3Ruf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 19:50:35 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fc65a660000>; Wed, 30 May 2012 10:35:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 10:33:31 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 10:33:30 -0700
Message-ID: <4FC659EA.8090903@cavium.com>
Date:   Wed, 30 May 2012 10:33:30 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/9] MIPS: Add support for microMIPS exception handling.
References: <1337892366-24210-1-git-send-email-sjhill@mips.com> <1337892366-24210-4-git-send-email-sjhill@mips.com>
In-Reply-To: <1337892366-24210-4-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2012 17:33:30.0994 (UTC) FILETIME=[54A23D20:01CD3E8A]
X-archive-position: 33487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/24/2012 01:46 PM, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> All exceptions must be taken in microMIPS mode, never in MIPS32R2
> mode or the kernel falls apart. A few 'nop' instructions are used
> to maintain the correct alignment of microMIPS versions of the
> exception vectors.
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/include/asm/stackframe.h |   12 +-
>   arch/mips/kernel/cpu-probe.c       |    3 +
>   arch/mips/kernel/genex.S           |   82 +++++---
>   arch/mips/kernel/scall32-o32.S     |   18 +-
>   arch/mips/kernel/smtc-asm.S        |    3 +
>   arch/mips/kernel/traps.c           |  375 +++++++++++++++++++++++++-----------
>   arch/mips/mm/tlbex.c               |   21 ++
>   arch/mips/mti-sead3/sead3-init.c   |   48 +++++
>   8 files changed, 416 insertions(+), 146 deletions(-)
>
> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index cb41af5..335ce06 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -139,7 +139,7 @@
>   1:		move	ra, k0
>   		li	k0, 3
>   		mtc0	k0, $22
> -#endif /* CONFIG_CPU_LOONGSON2F */
> +#endif /* CONFIG_CPU_JUMP_WORKAROUNDS */
>   #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
>   		lui	k1, %hi(kernelsp)
>   #else
> @@ -189,6 +189,7 @@
>   		LONG_S	$0, PT_R0(sp)
>   		mfc0	v1, CP0_STATUS
>   		LONG_S	$2, PT_R2(sp)
> +		LONG_S	v1, PT_STATUS(sp)
>   #ifdef CONFIG_MIPS_MT_SMTC
>   		/*
>   		 * Ideally, these instructions would be shuffled in
> @@ -200,21 +201,20 @@
>   		LONG_S	k0, PT_TCSTATUS(sp)
>   #endif /* CONFIG_MIPS_MT_SMTC */
>   		LONG_S	$4, PT_R4(sp)
> -		LONG_S	$5, PT_R5(sp)
> -		LONG_S	v1, PT_STATUS(sp)
>   		mfc0	v1, CP0_CAUSE
> -		LONG_S	$6, PT_R6(sp)
> -		LONG_S	$7, PT_R7(sp)
> +		LONG_S	$5, PT_R5(sp)
>   		LONG_S	v1, PT_CAUSE(sp)
> +		LONG_S	$6, PT_R6(sp)
>   		MFC0	v1, CP0_EPC
> +		LONG_S	$7, PT_R7(sp)
>   #ifdef CONFIG_64BIT
>   		LONG_S	$8, PT_R8(sp)
>   		LONG_S	$9, PT_R9(sp)
>   #endif
> +		LONG_S	v1, PT_EPC(sp)
>   		LONG_S	$25, PT_R25(sp)
>   		LONG_S	$28, PT_R28(sp)
>   		LONG_S	$31, PT_R31(sp)
> -		LONG_S	v1, PT_EPC(sp)

What is the purpose of reordering all these stores?


>   		ori	$28, sp, _THREAD_MASK
>   		xori	$28, _THREAD_MASK
>   #ifdef CONFIG_CPU_CAVIUM_OCTEON
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 1382885..fe76d60 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -746,6 +746,9 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
>   		c->options |= MIPS_CPU_ULRI;
>   	if (config3&  MIPS_CONF3_ISA)
>   		c->options |= MIPS_CPU_MICROMIPS;
> +#ifdef CONFIG_CPU_MICROMIPS
> +	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
> +#endif

This is not a probing operation, perhaps it should be moved adjacent to 
the setting of EBase.  A comment as to what it does would be nice too.


>
>   	return config3&  MIPS_CONF_M;
>   }
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 8882e57..f094c82 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -3,9 +3,9 @@
>    * License.  See the file "COPYING" in the main directory of this archive
>    * for more details.
>    *
> - * Copyright (C) 1994 - 2000, 2001, 2003 Ralf Baechle
> - * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> - * Copyright (C) 2001 MIPS Technologies, Inc.
> + * Copyright (C) 1994 - 2001, 2003  Ralf Baechle
> + * Copyright (C) 1999, 2000  Silicon Graphics, Inc.

??

> + * Copyright (C) 2001, 2011  MIPS Technologies, Inc.
>    * Copyright (C) 2002, 2007  Maciej W. Rozycki
>    */
>   #include<linux/init.h>
> @@ -22,8 +22,10 @@
>   #include<asm/page.h>
>   #include<asm/thread_info.h>
>
> +#ifdef CONFIG_MIPS_MT_SMTC
>   #define PANIC_PIC(msg)					\
> -		.set push;				\
> +		.set	push;				\
> +		.set	nomicromips;			\
>   		.set	reorder;			\
>   		PTR_LA	a0,8f;				\
>   		.set	noat;				\
> @@ -32,17 +34,10 @@
>   9:		b	9b;				\
>   		.set	pop;				\
>   		TEXT(msg)
> +#endif
>
>   	__INIT
>
> -NESTED(except_vec0_generic, 0, sp)
> -	PANIC_PIC("Exception vector 0 called")
> -	END(except_vec0_generic)
> -
> -NESTED(except_vec1_generic, 0, sp)
> -	PANIC_PIC("Exception vector 1 called")
> -	END(except_vec1_generic)
> -
>   /*
>    * General exception vector for all other CPUs.
>    *
> @@ -65,6 +60,7 @@ NESTED(except_vec3_generic, 0, sp)
>   	.set	pop
>   	END(except_vec3_generic)
>
> +#if (cpu_has_vce != 0)
>   /*
>    * General exception handler for CPUs with virtual coherency exception.
>    *
> @@ -124,6 +120,7 @@ handle_vcei:
>   	eret
>   	.set	pop
>   	END(except_vec3_r4000)
> +#endif /* (cpu_has_vce == 0) */
>
>   	__FINIT
>
> @@ -139,12 +136,19 @@ LEAF(r4k_wait)
>   	 nop
>   	nop
>   	nop
> +#ifdef CONFIG_CPU_MICROMIPS
> +	nop
> +	nop
> +	nop
> +	nop
> +#endif
>   	.set	mips3
>   	wait
>   	/* end of rollback region (the region size must be power of two) */
> -	.set	pop
>   1:
>   	jr	ra
> +	nop
> +	.set	pop
>   	END(r4k_wait)
>
>   	.macro	BUILD_ROLLBACK_PROLOGUE handler
> @@ -202,7 +206,11 @@ NESTED(handle_int, PT_SIZE, sp)
>   	LONG_L	s0, TI_REGS($28)
>   	LONG_S	sp, TI_REGS($28)
>   	PTR_LA	ra, ret_from_irq
> -	j	plat_irq_dispatch
> +	PTR_LA  v0, plat_irq_dispatch
> +	jr	v0
> +#ifdef CONFIG_CPU_MICROMIPS
> +	nop
> +#endif
>   	END(handle_int)
>
>   	__INIT
> @@ -223,11 +231,14 @@ NESTED(except_vec4, 0, sp)
>   /*
>    * EJTAG debug exception handler.
>    * The EJTAG debug exception entry point is 0xbfc00480, which
> - * normally is in the boot PROM, so the boot PROM must do a
> + * normally is in the boot PROM, so the boot PROM must do an
>    * unconditional jump to this vector.
>    */
>   NESTED(except_vec_ejtag_debug, 0, sp)
>   	j	ejtag_debug_handler
> +#ifdef CONFIG_CPU_MICROMIPS
> +	 nop
> +#endif
>   	END(except_vec_ejtag_debug)
>
>   	__FINIT
> @@ -252,9 +263,10 @@ NESTED(except_vec_vi, 0, sp)
>   FEXPORT(except_vec_vi_mori)
>   	ori	a0, $0, 0
>   #endif /* CONFIG_MIPS_MT_SMTC */
> +	PTR_LA	v1, except_vec_vi_handler
>   FEXPORT(except_vec_vi_lui)
>   	lui	v0, 0		/* Patched */
> -	j	except_vec_vi_handler
> +	jr	v1

What is this change about?  It looks like it adds code to non-microMIPS 
paths.  Am I mistaken?

[...]
