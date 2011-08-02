Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 17:58:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42777 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491177Ab1HBP6E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 17:58:04 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p72Fw0Jv023525;
        Tue, 2 Aug 2011 16:58:00 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p72FvxMB023522;
        Tue, 2 Aug 2011 16:57:59 +0100
Date:   Tue, 2 Aug 2011 16:57:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] Pendantic stack backtrace code
Message-ID: <20110802155759.GA891@linux-mips.org>
References: <20110706233614.GA19332@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110706233614.GA19332@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1531

On Wed, Jul 06, 2011 at 04:36:15PM -0700, David VomLehn wrote:

> This is the much updated version of the MIPS stack backtrace code submitted
> a few years ago. It has a few bugs fixed and should be easier to understand
> as a result of a signficant rewrite. There are some references to 64-bit
> support, but support is not complete. As a result, this is only enabled
> for 32-bit systems.
> 
> The code does code analysis according to the o32 backtracing rules, plus
> using information the kernel knows and a few simple heuristics. There are
> a few things no such backtracer can do, but it handles quite a large
> number of cases.
> 
> In addition to simple backtracing, the code also traces over exception
> frames.  So, if you have an exception handler that panics, you will be able
> to see how the code got to where the exception occurred.
> 
> This file contains one cleanpatch.pl false positive:
> arch/mips/kernel/backtrace/kernel-backtrace-symbols.c: A preprocessor macro
> used to create declarations has "extern" in the macro body.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/Kconfig.debug                          |   11 +
>  arch/mips/include/asm/base-backtrace.h           |  440 ++++++
>  arch/mips/include/asm/kernel-backtrace-symbols.h |  151 ++
>  arch/mips/include/asm/kernel-backtrace.h         |  101 ++
>  arch/mips/include/asm/sigframe.h                 |   39 +
>  arch/mips/include/asm/thread-backtrace.h         |   87 ++
>  arch/mips/kernel/entry.S                         |   17 +-
>  arch/mips/kernel/scall32-o32.S                   |   10 +-
>  arch/mips/kernel/signal.c                        |   15 +-
>  arch/mips/kernel/traps.c                         |   78 +-
>  arch/mips/kernel/vdso.c                          |    8 +-
>  arch/mips/lib/Makefile                           |    3 +
>  arch/mips/lib/base-backtrace.c                   | 1679 ++++++++++++++++++++++
>  arch/mips/lib/kernel-backtrace-symbols.c         |   41 +
>  arch/mips/lib/kernel-backtrace.c                 | 1080 ++++++++++++++
>  arch/mips/lib/thread-backtrace.c                 |  289 ++++
>  scripts/module-common.lds                        |   19 -
>  17 files changed, 4020 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 83ed00a..af3582c 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -121,6 +121,17 @@ config DEBUG_ZBOOT
>  	  to reduce the kernel image size and speed up the booting procedure a
>  	  little.
>  
> +config MIPS_PEDANTIC_BACKTRACE
> +	bool "More comprehensive backtrace code"
> +	default n
> +	depends on KALLSYMS && 32BIT
> +	help
> +	  Use backtrace code that more completely handles the various
> +	  complexities of the MIPS processors, including branch delay
> +	  slots. This is substantially larger than the standard backtrace
> +	  code. It also allows tracing over exception frames, which is
> +	  occasionally very useful.
> +
>  config SPINLOCK_TEST
>  	bool "Enable spinlock timing tests in debugfs"
>  	depends on DEBUG_FS
> diff --git a/arch/mips/include/asm/base-backtrace.h b/arch/mips/include/asm/base-backtrace.h
> new file mode 100644
> index 0000000..ddc61d1
> --- /dev/null
> +++ b/arch/mips/include/asm/base-backtrace.h
> @@ -0,0 +1,440 @@
> +/*
> + * Definitions handling one stack frame's worth of stack backtrace.
> + *
> + * Copyright(C) 2007  Scientific-Atlanta, Inc.

Shouldn't this now be changed to Cisco?

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#ifndef	_BASE_BACKTRACE_H_
> +#define	_BASE_BACKTRACE_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +
> +#include <asm/inst.h>
> +#include <asm/ptrace.h>
> +#include <asm/errno.h>
> +
> +#define	dbg_print	printk
> +
> +#define	PRIORITY	KERN_CRIT

Unused define.

> +
> +#undef DEBUG
> +
> +#ifdef	DEBUG
> +#define bt_dbg(fmt, ...)	do {					\
> +			dbg_print("%s: " fmt, __func__, ##__VA_ARGS__); \
> +		} while (0)

printk invocations should use a loglevel.  If you want output to depend
on DEBUG use pr_debug().

> +
> +static const char *const backtrace_rule[] = {
> +	"o32 ABI", "bounded"
> +};
> +#else
> +#define bt_dbg(fmt, ...)	do { } while (0)
> +#endif
> +
> +/*
> + * Value to be returned by functions that processes each frame to indicate
> + * a non-error termination of the backtrace. Errors cause a negative errno
> + * to be returned and a frame that does not terminate the back trace cause
> + * a zero to be returned.
> + */
> +define	BASE_BT_END_NULL_PC	1
        ^^^^^^^^^
Indent only by one space here.

> +#define BASE_BT_N_END		1
> +
> +/*
> + * Macros for loading addresses and storing registers:
> + * LOAD_ADDR    Load the address of the given object into the $at register
> + * STORE_REG    Store the given register. Assumes that $at points to the
> + *              location for the store.
> + */
> +#ifdef CONFIG_64BIT
> +#warning TODO: 64-bit code needs to be verified
> +#define LOAD_ADDR(obj)  "dla    $at," #obj "\n"
> +#define STORE_REG(reg)  "sd     " #reg ",0($at)\n"
> +#endif
> +
> +#ifdef CONFIG_32BIT
> +#define LOAD_ADDR(obj)  "la     $at," #obj "\n"
> +#define STORE_REG(reg)  "sw     " #reg ",0($at)\n"
> +#endif

LOAD_ADDR and STORE_REG appear to be unused.

> +
> +/*
> + * __base_backtrace_here - set the PC, SP, and return address for current func
> + * @bbt:	Pointer to the &struct base_bt to set
> + */
> +#define __base_backtrace_here(bbt)		do {			\
> +			register unsigned long s0 asm("s0");		\
> +			register unsigned long s1 asm("s1");		\
> +			register unsigned long s2 asm("s2");		\
> +			register unsigned long s3 asm("s3");		\
> +			register unsigned long s4 asm("s4");		\
> +			register unsigned long s5 asm("s5");		\
> +			register unsigned long s6 asm("s6");		\
> +			register unsigned long s7 asm("s7");		\
> +			register unsigned long fp asm("fp");		\
> +			register unsigned long gp asm("gp");		\
> +			(bbt)->pc = __base_backtrace_here_pc();		\
> +			(bbt)->sp = __builtin_frame_address(0);		\
> +			(bbt)->ra = __builtin_return_address(0);	\
> +			(bbt)->gprs[SREG_S0].value = s0;		\
> +			(bbt)->gprs[SREG_S1].value = s1;		\
> +			(bbt)->gprs[SREG_S2].value = s2;		\
> +			(bbt)->gprs[SREG_S3].value = s3;		\
> +			(bbt)->gprs[SREG_S4].value = s4;		\
> +			(bbt)->gprs[SREG_S5].value = s5;		\
> +			(bbt)->gprs[SREG_S6].value = s6;		\
> +			(bbt)->gprs[SREG_S7].value = s7;		\
> +			(bbt)->gprs[SREG_S8].value = fp;		\
> +			(bbt)->gprs[SREG_GP].value = gp;		\
> +			(bbt)->gprs[SREG_RA].value = (unsigned long)(bbt)->ra;\
> +			(bbt)->gprs[SREG_S0].read = true;		\
> +			(bbt)->gprs[SREG_S1].read = true;		\
> +			(bbt)->gprs[SREG_S2].read = true;		\
> +			(bbt)->gprs[SREG_S3].read = true;		\
> +			(bbt)->gprs[SREG_S4].read = true;		\
> +			(bbt)->gprs[SREG_S5].read = true;		\
> +			(bbt)->gprs[SREG_S6].read = true;		\
> +			(bbt)->gprs[SREG_S7].read = true;		\
> +			(bbt)->gprs[SREG_S8].read = true;		\
> +			(bbt)->gprs[SREG_GP].read = true;		\
> +			(bbt)->gprs[SREG_RA].read = true;		\
> +			(bbt)->next_pc = NULL;				\
> +		} while (0)
> +
> +/*
> + * base_backtrace_first - process the first stack frame.
> + * @bt:	Pointer to struct base_bt object.
> + * Returns:	Zero on success, otherwise a negative errno value.
> + *		A value of -ENOSYS indicates that the $pc and $sp are valid
> + *		but we can't continue the backtrace.
> + */
> +#define base_backtrace_first(bbt, rule)		({			\
> +			memset(bbt, 0, sizeof(*(bbt)));			\
> +			__base_backtrace_here(bbt);			\
> +			__base_backtrace_analyze_frame(bbt, rule);	\
> +		})
> +
> +/* General purpose register (GPR) numbers */
> +enum mips_reg_num {
> +	MREG_ZERO,	MREG_AT,	MREG_V0,	MREG_V1,
> +	MREG_A0,	MREG_A1,	MREG_A2,	MREG_A3,
> +	MREG_T0,	MREG_T1,	MREG_T2,	MREG_T3,
> +	MREG_T4,	MREG_T5,	MREG_T6,	MREG_T7,
> +	MREG_S0,	MREG_S1,	MREG_S2,	MREG_S3,
> +	MREG_S4,	MREG_S5,	MREG_S6,	MREG_S7,
> +	MREG_T8,	MREG_T9,	MREG_K0,	MREG_K1,
> +	MREG_GP,	MREG_SP,	MREG_S8,	MREG_RA,
> +	N_MREGS		/* This last one is the number of GPRs */
> +};
> +
> +/* Indices into list of GPRs that must be saved before use */
> +enum saved_gpr_num {
> +	SREG_S0,	SREG_S1,	SREG_S2,	SREG_S3,
> +	SREG_S4,	SREG_S5,	SREG_S6,	SREG_S7,
> +	SREG_GP,	SREG_S8,	SREG_RA,
> +	N_SREGS		/* Number of saved gprs */
> +};
> +
> +/* True if the corresponding MIPS register must be saved before use */

You mean a callee-saved register?

> +extern const bool save_before_use[N_MREGS];
> +
> +/* Convert saved_gpr_num to mips_reg_num */
> +extern const enum mips_reg_num sreg_to_mreg[N_SREGS];
> +
> +/* Convert mips_reg_num to saved_gpr_num */
> +extern const enum saved_gpr_num mreg_to_sreg[N_MREGS];
> +
> +/*
> + * Additional instruction formats that might be nice to define in
> + * asm/inst.h
> + * */
> +#ifdef	__MIPSEB__
> +	struct	any_format {		/* Generic format */
> +		unsigned int opcode:6;
> +		unsigned int remainder:26;
> +	};

This is the same as struct j_format but I don't mind if you want to call
it a 2nd time to inst.h. with a different name.

> +	struct syscall_format {
> +		unsigned int opcode:6;
> +		unsigned int code:20;
> +		unsigned int func:6;
> +	};

This format is called b_format in <asm/inst.h>

> +	struct	eret_format {
> +		unsigned int opcode:6;
> +		unsigned int co:1;
> +		unsigned int zero:19;
> +		unsigned int func:6;
> +	};
> +#else
> +	struct	any_format {		/* Generic format */
> +		unsigned int remainder:26;
> +		unsigned int opcode:6;
> +	};
> +
> +	struct syscall_format {
> +		unsigned int func:6;
> +		unsigned int code:20;
> +		unsigned int opcode:6;
> +	};
> +
> +	struct	eret_format {
> +		unsigned int func:6;
> +		unsigned int zero:19;
> +		unsigned int co:1;
> +		unsigned int opcode:6;
> +	};

Same comments as for he structs above apply here, too.

> +#endif

I think this may need a few additions to handle some processor specific
enhancements such as Cavium's BBIT0 etc. family of branches.

> +#ifdef	SPECIAL_SYMBOL
> +/* arch/mips/kernel/entry.S */
> +SPECIAL_SYMBOL(ret_from_exception, KERNEL_FRAME_GLUE)
> +SPECIAL_SYMBOL(ret_from_irq, KERNEL_FRAME_GLUE)
[...]

We could modify RESTORE_SOME etc. to automatically generate a table of
these SPECIAL_SYMBOLs instead of manually maintaining this table?

> +/*
> + * __thread_backtrace_here - gets the PC and SP register values for the invoker
> + * @tbt:	Pointer to the struct thread_bt structure to set
> + */
> +#define __thread_backtrace_here(tbt)	do {				\
> +			__base_backtrace_here(&(tbt)->bbt);		\
> +		} while (0)

Only used by thread_backtrace_first which itself is unused.

> +/*
> + * thread_backtrace_first - Get information for the first stack frame
> + * @tbt:	Pointer to trace_backtrace_t object initialized with
> + *		thread_backtrace_init.
> + * @rule:	Rules to use for analyzing the function
> + * Returns:	Zero on success, a negative errno otherwise.
> + */
> +#define thread_backtrace_first(tbt, rule)	({			\
> +			memset(tbt, 0, sizeof(*(tbt)));			\
> +			__thread_backtrace_here(tbt);			\
> +			__thread_backtrace_analyze_frame(tbt, rule);	\
> +		})

This macro is unused.

> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> index 37acfa0..6548ae3 100644
> --- a/arch/mips/kernel/entry.S
> +++ b/arch/mips/kernel/entry.S
> @@ -40,9 +40,10 @@ FEXPORT(__ret_from_irq)
>  	andi	t0, t0, KU_USER
>  	beqz	t0, resume_kernel
>  
> +	.globl	resume_userspace
>  resume_userspace:
>  	local_irq_disable		# make sure we dont miss an
> -					# interrupt setting need_resched
> +					# interrupt setting _need_resched

Huh?  The comment should say _TIF_NEED_RESCHED - but that's to long for
the 80 colums.

> index e9b3af2..dbf53b5 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -53,6 +53,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/types.h>
>  #include <asm/stacktrace.h>
> +#include <asm/kernel-backtrace.h>
>  #include <asm/uasm.h>
>  
>  extern void check_wait(void);
> @@ -86,6 +87,8 @@ extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>  				    struct mips_fpu_struct *ctx, int has_fpu,
>  				    void *__user *fault_addr);
>  
> +#define MAX_STACK_FRAMES_PRINTED	100

Is this needed?  The size of the stack should limit the dump naturally and
the code need some sort of safeguard to protect against running beyond the
end of the stack anyway.

> +	 * If we do not have a branch delay slot, we also know that the
> +	 * following instruction is not in a branch delay slot. If we are
> +	 * not at the branch delay slot, we also know that the next instruction
> +	 * can't be in a branch delay slot since that would have meant that
> +	 * the instruction in our branch delay slot had a branch delay slot.
> +	 * That's a no-no, so we don't worry about it.
> +	 */
> +#if 1

Ehhh  what?

> +	if (!vpc->have_bds)
> +		rc = __vpc_might_have_bds(vpc, vpc->pc + 1);
> +	else if (!vpc->in_bds)
> +		rc = __vpc_might_have_bds(vpc, vpc->pc + 2);
> +	else
> +		vpc->in_bds = false;
> +#else
> +	if (!vpc->have_bds)
> +		rc = __vpc_might_have_bds(vpc, vpc->pc + 1);
> +	else if (!vpc->in_bds)
> +		rc = __vpc_might_have_bds(vpc, vpc->pc + 2);
> +	else
> +		vpc->in_bds = false;
> +#endif

I may be blind but the #if and the #else branch look identical.

> + * match_short_get_got - checks for a match for short GOT recovery code
> + * @in_vpc:	Pointer to the &struct vpc for the instruction at which
> + *		the GOT recovery code may start.
> + *
> + * Returns:	true if it matches, zero if it does not.
> + *
> + * Matches the code fragment:
> + *	li	gp,<value>
> + *	addu	gp, gp, t9
> + * which is a short version of the code used to recover the GOT (global offset
> + * table) pointer from the address of the current function.

But there is no GOT in the kernel??

> +/*
> + * find_return_abi - Find the end of the function by o32 ABI rules.
> + * @bt:	Pointer to struct base_bt object.
> + * Returns:	Zero if we found the end of the function, a negative errno value
> + *		if we could not.
> + *
> + * If the function was found, ctx->fn_return will point to the "jr ra"
> + * instruction, otherwise it will be set to NULL.
> + * If the function was not found, ctx->fn_return will be set to NULL_REG.
> + */
> +static int find_return_abi(struct base_bt_ctx *ctx)
> +{
> +	int rc;
> +	struct vpc vpc;
> +	mips_instruction op;
> +
> +	ctx->fn_return = NULL;
> +
> +	/* Scan forward to find the "jr ra" that marks the end
> +	 * of the current function */

Not really; gcc may place move part of the code path behind the jr $ra
even though that violates the O32 ABI spec.  In the kernel this happens
for do_one_initcall(), mips_display_message() and more.

And that's generally my concern with this approach - GCC's optimizer is
becoming very good in the most recent versions.  In in the long run I see
us forced to go down the DWARF alley but of course the 10, 20% bloat won't
be popular.

But if users tell me they like this apprach and in practice it works well
enough then I'm all for it.

> +/*
> + * This handles getting the next kernel stackframe. It checks to see if we are
> + * in an exception or interrupt frame. If not, we just pass it along to the
> + * process backtracing.
> + * @kbt:	Pointer to the struct kernel_bt object
> + *
> + * Returns:	KERNEL_BT_END_IN_START_KERNEL The backtrace should stop
> + *					because the next frame is for
> + *					start_kernel(), whose memory has
> + *					probably been freed and overwritten.

Not sure if it's worth the pain but we could set a flag in free_init_mem so
kernel_backtrace_next would know if start_kernel is stil available.

> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
> deleted file mode 100644
> index 0865b3e..0000000
> --- a/scripts/module-common.lds
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*

Looks like an accidental deletion?

  Ralf
