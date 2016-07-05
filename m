Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 11:36:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1954 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991859AbcGEJfvqFeJx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 11:35:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 92E1179F868EC;
        Tue,  5 Jul 2016 10:35:41 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.81) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 5 Jul
 2016 10:35:41 +0100
Subject: Re: [RFC] mips: Add MXU context switching support
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <adobriyan@gmail.com>, <john.stultz@linaro.org>,
        <mguzik@redhat.com>, <athorlton@sgi.com>, <mhocko@suse.com>,
        <ebiederm@xmission.com>, <gorcunov@openvz.org>, <luto@kernel.org>,
        <cl@linux.com>, <serge.hallyn@ubuntu.com>, <keescook@chromium.org>,
        <jslaby@suse.cz>, <akpm@linux-foundation.org>, <macro@imgtec.com>,
        <f.fainelli@gmail.com>, <mingo@kernel.org>,
        <alex.smith@imgtec.com>, <markos.chandras@imgtec.com>,
        <Leonid.Yegoshin@imgtec.com>, <david.daney@cavium.com>,
        <zhaoxiu.zeng@gmail.com>, <chenhc@lemote.com>,
        <Zubair.Kakakhel@imgtec.com>, <james.hogan@imgtec.com>,
        <ralf@linux-mips.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <943222fa-1355-14cc-5d03-16873283420f@imgtec.com>
Date:   Tue, 5 Jul 2016 10:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.81]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Hi PrasannaKumar,

On 25/06/16 13:14, PrasannaKumar Muralidharan wrote:
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>
> This patch adds support for context switching Xburst MXU registers. The
> registers are named xr0 to xr16. xr16 is the control register that can
> be used to enable and disable MXU instruction set. Read and write to
> these registers can be done without enabling MXU instruction set by user
> space. Only when MXU instruction set is enabled any MXU instruction
> (other than read or write to xr registers) can be done. xr0 is always 0.

Do you have any examples of userland programs making use of MXU? They 
would be useful in allowing people to test this patch.

How have you tested this?

> Kernel does not know when MXU instruction is enabled or disabled. So
> during context switch if MXU is enabled in xr16 register then MXU
> registers are saved, restored when the task is run.

I'm not convinced this is the right way to go. It seems complex & 
fragile vs the alternatives, the simplest of which could be to just 
always save & restore MXU context in kernels with MXU support. Is there 
a significant performance cost to just unconditionally saving & 
restoring the MXU context? That is after all what Ingenic's vendor 
kernel, which it looks like large parts of your patch are taken from, does.

> When user space
> application enables MXU, it is not reflected in other threads
> immediately. So for convenience the applications can use prctl syscall
> to let the MXU state propagate across threads running in different CPUs.

Surely it wouldn't be reflected at all, since each thread has its own 
MXU context? Would you expect applications to actually want to enable 
MXU on one thread & make use of it from other already running threads? 
Off the top of my head I can't think of why that would be useful, so I'm 
wondering whether it would be better to just let each thread handle 
enabling MXU if it wants & leave the kernel out of it. If we just save & 
restore unconditionally then this becomes a non-issue anyway.

> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>optimise out
> ---
>  arch/mips/include/asm/cpu-features.h |   4 +
>  arch/mips/include/asm/cpu.h          |   1 +
>  arch/mips/include/asm/mxu.h          | 157 +++++++++++++++++++++++++++++++++++
>  arch/mips/include/asm/processor.h    |  19 +++++
>  arch/mips/include/asm/switch_to.h    |  40 +++++++++
>  arch/mips/kernel/cpu-probe.c         |   1 +
>  arch/mips/kernel/process.c           |  48 +++++++++++
>  include/uapi/linux/prctl.h           |   3 +
>  kernel/sys.c                         |   6 ++
>  9 files changed, 279 insertions(+)
>  create mode 100644 arch/mips/include/asm/mxu.h
>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index e961c8a..c6270b0 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -345,6 +345,10 @@
>  #define cpu_has_dsp3		(cpu_data[0].ases & MIPS_ASE_DSP3)
>  #endif
>
> +#ifndef cpu_has_mxu
> +#define cpu_has_mxu		(cpu_data[0].ases & MIPS_ASE_MXU)

This really ought to be defined as a constant 0 for non-Ingenic kernels, 
so that the compiler can discard the MXU code for other systems.

I'm not sure there's actually any point using one of the ASE flags for 
it, since we know it's always present on the Ingenic CPUs we support & 
always not present on non-Ingenic CPUs. That is, "#define cpu_has_mxu 
IS_ENABLED(CONFIG_MACH_INGENIC)" would work just as well & be compile 
time constant, allowing the compiler to optimise better.

> +#endif
> +
>  #ifndef cpu_has_mipsmt
>  #define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
>  #endif
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index f672df8..77ab797 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -428,5 +428,6 @@ enum cpu_type_enum {
>  #define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
>  #define MIPS_ASE_MSA		0x00000100 /* MIPS SIMD Architecture */
>  #define MIPS_ASE_DSP3		0x00000200 /* Signal Processing ASE Rev 3*/
> +#define MIPS_ASE_MXU		0x00000400 /* Xburst MXU instruction set */
>
>  #endif /* _ASM_CPU_H */
> diff --git a/arch/mips/include/asm/mxu.h b/arch/mips/include/asm/mxu.h
> new file mode 100644
> index 0000000..cf77cbd
> --- /dev/null
> +++ b/arch/mips/include/asm/mxu.h
> @@ -0,0 +1,157 @@
> +/*
> + * Copyright (C) Ingenic Semiconductor
> + * File taken from Ingenic Semiconductor's linux repo available in github
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifndef _ASM_MXU_H
> +#define _ASM_MXU_H
> +
> +#include <asm/cpu.h>
> +#include <asm/cpu-features.h>
> +#include <asm/hazards.h>
> +#include <asm/mipsregs.h>
> +
> +static inline void __enable_mxu(void)
> +{
> +	unsigned int register val asm("t0");
> +	val = 3;

Why 3? Please document the magic number. Judging from below bit 0 is 
enable, but what's bit 1? If you #define names for the bits then use 
those that would be great.

> +	asm volatile(".word	0x7008042f\n\t"::"r"(val));
> +}
> +
> +static inline void enable_mxu(void)
> +{
> +	if (cpu_has_mxu)
> +		__enable_mxu();
> +}
> +
> +static inline void disable_mxu(void)
> +{
> +	unsigned int register val asm("t0");
> +	val = 0;
> +	asm volatile(".word	0x7008042f\n\t"::"r"(val));
> +	asm("nop\n\t");
> +	asm("nop\n\t");
> +	asm("nop\n\t");

Why the nops? Does something go wrong without them? Can you explain in a 
comment?

On Sat, 25 Jun 2016, PrasannaK
> +}
> +
> +static inline int mxu_used(void)
> +{
> +	unsigned int register reg_val asm("t0");
> +	asm volatile(".word	0x7008042f\n\t"::"r"(reg_val));

This doesn't seem right at all - the instruction you used is the same as 
in enable_mxu() & disable_mxu(), but in those you'd want to write to 
xr16 and here you'd want to read it.

As Maciej asked, if you documented the instruction encodings this would 
be easier to read. Even better if you were to #define some meaningful 
names then use the names rather than raw encodings it would make it 
clearer what's going on.

> +	return reg_val &0x01;

Also this magix 0x1 should be #define'd to something useful, perhaps 
something like "#define MXU_XR16_ENABLE BIT(0)".

> +}
> +
> +static inline void __save_mxu(void *tsk_void)
> +{
> +	struct task_struct *tsk = tsk_void;
> +
> +	register unsigned int reg_val asm("t0");
> +
> +	asm volatile(".word	0x7008042e\n\t");
> +	tsk->thread.mxu.xr[0] = reg_val;

Although it's likely to work, as far as I understand there's nothing 
preventing GCC from clobbering t0 between the asm statement & the write 
to the context struct.

To quote 
https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Local-Register-Variables

   "Defining a register variable does not reserve the register. Other 
than when invoking the Extended asm, the contents of the specified 
register are not guaranteed."

To avoid this I think it may be best to implement the save & restore 
routines in asm just like we already do for FP & MSA contexts.

> +	asm volatile(".word	0x7008006e\n\t");
> +	tsk->thread.mxu.xr[1] = reg_val;
> +	asm volatile(".word	0x700800ae\n\t");
> +	tsk->thread.mxu.xr[2] = reg_val;
> +	asm volatile(".word	0x700800ee\n\t");
> +	tsk->thread.mxu.xr[3] = reg_val;
> +	asm volatile(".word	0x7008012e\n\t");
> +	tsk->thread.mxu.xr[4] = reg_val;
> +	asm volatile(".word	0x7008016e\n\t");
> +	tsk->thread.mxu.xr[5] = reg_val;
> +	asm volatile(".word	0x700801ae\n\t");
> +	tsk->thread.mxu.xr[6] = reg_val;
> +	asm volatile(".word	0x700801ee\n\t");
> +	tsk->thread.mxu.xr[7] = reg_val;
> +	asm volatile(".word	0x7008022e\n\t");
> +	tsk->thread.mxu.xr[8] = reg_val;
> +	asm volatile(".word	0x7008026e\n\t");
> +	tsk->thread.mxu.xr[9] = reg_val;
> +	asm volatile(".word	0x700802ae\n\t");
> +	tsk->thread.mxu.xr[10] = reg_val;
> +	asm volatile(".word	0x700802ee\n\t");
> +	tsk->thread.mxu.xr[11] = reg_val;
> +	asm volatile(".word	0x7008032e\n\t");
> +	tsk->thread.mxu.xr[12] = reg_val;
> +	asm volatile(".word	0x7008036e\n\t");
> +	tsk->thread.mxu.xr[13] = reg_val;
> +	asm volatile(".word	0x700803ae\n\t");
> +	tsk->thread.mxu.xr[14] = reg_val;
> +	asm volatile(".word	0x700803ee\n\t");
> +	tsk->thread.mxu.xr[15] = reg_val;
> +}
> +
> +static inline void __restore_mxu(void *tsk_void)
> +{
> +	struct task_struct *tsk = tsk_void;
> +
> +	register unsigned int reg_val asm("t0");
> +
> +	reg_val = tsk->thread.mxu.xr[0];
> +	asm volatile(".word	0x7008042f\n\t"::"r"(reg_val));

Same comment as for saving context - I don't think this is guaranteed to 
work.

> +	reg_val = tsk->thread.mxu.xr[1];
> +	asm volatile(".word	0x7008006f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[2];
> +	asm volatile(".word	0x700800af\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[3];
> +	asm volatile(".word	0x700800ef\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[4];
> +	asm volatile(".word	0x7008012f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[5];
> +	asm volatile(".word	0x7008016f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[6];
> +	asm volatile(".word	0x700801af\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[7];
> +	asm volatile(".word	0x700801ef\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[8];
> +	asm volatile(".word	0x7008022f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[9];
> +	asm volatile(".word	0x7008026f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[10];
> +	asm volatile(".word	0x700802af\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[11];
> +	asm volatile(".word	0x700802ef\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[12];
> +	asm volatile(".word	0x7008032f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[13];
> +	asm volatile(".word	0x7008036f\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[14];
> +	asm volatile(".word	0x700803af\n\t"::"r"(reg_val));
> +	reg_val = tsk->thread.mxu.xr[15];
> +	asm volatile(".word	0x700803ef\n\t"::"r"(reg_val));
> +}
> +
> +#define save_mxu(tsk)						\
> +	do {							\
> +		if (cpu_has_mxu)				\
> +			__save_mxu(tsk);			\
> +	} while (0)
> +
> +#define restore_mxu(tsk)					\
> +	do {							\
> +		if (cpu_has_mxu)				\
> +			__restore_mxu(tsk);			\
> +	} while (0)
> +
> +#define __get_mxu_regs(tsk)					\
> +	({							\
> +		if (tsk == current)				\
> +			__save_mxu(current);			\
> +								\
> +		tsk->thread.mxu.xr;				\
> +	})
> +
> +#define __let_mxu_regs(tsk, regs)				\
> +	do {							\
> +		int i;						\
> +		for (i = 0; i < NUM_MXU_REGS; i++)		\
> +			tsk->thread.mxu.xr[i] = regs[i];	\
> +		if (tsk == current)				\
> +			__save_mxu(current);			\
> +	} while (0)
> +
> +#endif /* _ASM_MXU_H */
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 7e78b62..a4def30 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -142,6 +142,11 @@ struct mips_dsp_state {
>  	unsigned int	dspcontrol;
>  };
>
> +#define NUM_MXU_REGS 16
> +struct xburst_mxu_state {
> +	unsigned int xr[NUM_MXU_REGS];
> +};
> +
>  #define INIT_CPUMASK { \
>  	{0,} \
>  }
> @@ -266,6 +271,10 @@ struct thread_struct {
>  	/* Saved state of the DSP ASE, if available. */
>  	struct mips_dsp_state dsp;
>
> +	unsigned int mxu_used;

Why not a thread info flag (ie. 1 bit) rather than 4 bytes?

> +	/* Saved registers of Xburst MXU, if available. */
> +	struct xburst_mxu_state mxu;
> +
>  	/* Saved watch register state, if available. */
>  	union mips_watch_reg_state watch;
>
> @@ -330,6 +339,10 @@ struct thread_struct {
>  		.dspr		= {0, },			\
>  		.dspcontrol	= 0,				\
>  	},							\
> +	.mxu_used		= 0,				\
> +	.mxu			= {				\
> +		.xr		= {0, },			\
> +	},							\
>  	/*							\
>  	 * saved watch register stuff				\
>  	 */							\
> @@ -410,4 +423,10 @@ extern int mips_set_process_fp_mode(struct task_struct *task,
>  #define GET_FP_MODE(task)		mips_get_process_fp_mode(task)
>  #define SET_FP_MODE(task,value)		mips_set_process_fp_mode(task, value)
>
> +extern int mips_enable_mxu_other_cpus(void);
> +extern int mips_disable_mxu_other_cpus(void);
> +
> +#define ENABLE_MXU_OTHER_CPUS()         mips_enable_mxu_other_cpus()
> +#define DISABLE_MXU_OTHER_CPUS()        mips_disable_mxu_other_cpus()
> +
>  #endif /* _ASM_PROCESSOR_H */
> diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
> index ebb5c0f..112aff5 100644
> --- a/arch/mips/include/asm/switch_to.h
> +++ b/arch/mips/include/asm/switch_to.h
> @@ -75,6 +75,43 @@ do {	if (cpu_has_rw_llb) {						\
>  	}								\
>  } while (0)
>
> +static inline void handle_mxu_state(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +	struct task_struct *thread = NULL;
> +
> +	if (prev->thread.mxu_used) {
> +		if (mxu_used() == 1) {
> +			__save_mxu(prev);
> +		} else {
> +			prev->thread.mxu_used = 0;

This seems weird. If I understand correctly then if a thread uses MXU in 
one timeslice then runs some non-MXU code in its next timeslice its MXU 
context may be lost before any third timeslice. That sounds bad. Think 
about if you had a program that was in the middle of running some 
MXU-using algorithm when it happens to receive a signal, and the MXU 
code is interrupted by some non-MXU code for a while long enough for 
this path to be hit, then the signal handler returns to the MXU-using 
code & its context is corrupt. Or without signals the same thing could 
happen if you just happened to call some complex/long running non-MXU 
code in the middle of your MXU-using code. That sounds bad!

> +			thread = prev;
> +			rcu_read_lock();
> +			while_each_thread(prev, thread) {
> +				thread->thread.mxu_used = 0;
> +			};
> +			rcu_read_unlock();

I think this would need some commenting to explain what's going on & I'm 
not concinved it's correct, but also as mentioned earlier I'm not sure 
the kernel should be taking responsibility for synchronising MXU state 
across threads so this could possibly be removed.

> +		}
> +	} else {
> +		if (mxu_used() == 1) {
> +			__save_mxu(prev);
> +			prev->thread.mxu_used = 1;
> +			thread = prev;
> +			rcu_read_lock();
> +			while_each_thread(prev, thread) {
> +				thread->thread.mxu_used = 1;
> +			};
> +			rcu_read_unlock();

Likewise.

> +		}
> +	}
> +	disable_mxu();
> +
> +	if (next->thread.mxu_used) {
> +		__restore_mxu(next);
> +		enable_mxu();
> +	}
> +}
> +

Another issue would be - should MXU be usable in signal handlers? If so 
then it needs to have context saved & restored around signals, as part 
of an extended context structure much like that used for MSA. If not 
then we probably need to document that restriction somewhere and check 
that anyone interested is OK with it. Ultimately that probably depends 
upon the goals here - if MXU were ever to be used for auto-vectorisation 
for example then it should probably gain that sigcontext save/restore code.

Thanks,
     Paul
