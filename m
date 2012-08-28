Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2012 00:25:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40441 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903052Ab2H1WZq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Aug 2012 00:25:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7SMPh1r018321;
        Wed, 29 Aug 2012 00:25:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7SMPhpB018320;
        Wed, 29 Aug 2012 00:25:43 +0200
Date:   Wed, 29 Aug 2012 00:25:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] asm-offsets.c: adding #define to break circular
 dependency
Message-ID: <20120828222543.GC23288@linux-mips.org>
References: <1346029009-20199-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1346029009-20199-1-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Aug 26, 2012 at 05:56:49PM -0700, Jim Quinlan wrote:

> irqflags.h depends on asm-offsets.h, but asm-offsets.h depends
> on irqflags.h when generating asm-offsets.h.  Adding a definition
> to the top of asm-offsets.c allows us to break this circle.  There
> is a similar define in bounds.c
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/mips/kernel/asm-offsets.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
> index 6b30fb2..035f167 100644
> --- a/arch/mips/kernel/asm-offsets.c
> +++ b/arch/mips/kernel/asm-offsets.c
> @@ -8,6 +8,7 @@
>   * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
>   * Copyright (C) 2000 MIPS Technologies, Inc.
>   */
> +#define __GENERATING_OFFSETS_S
>  #include <linux/compat.h>
>  #include <linux/types.h>
>  #include <linux/sched.h>
> -- 
> 1.7.6
> 
> 
> >From ab76333c041140e4fc1835b581044ff42906881c Mon Sep 17 00:00:00 2001

Something went seriously, seriously wrong in submission of this patch.

First your two part series ended up in a single email.  I was able to
verify that it actually arrived as a single email on linux-mips.org from
your mailserver.

Next it at some point of processing got split into two emails at above
>From line resulting in the 2nd email being archived with improper headers
in linux-mips.org's email archive.  So there's at least one bug at each
end.

> From: Jim Quinlan <jim2101024@gmail.com>
> Date: Sun, 26 Aug 2012 18:08:43 -0400
> Subject: [PATCH 2/2] MIPS: irqflags.h: make funcs preempt-safe for non-mipsr2
> 
> For non MIPSr2 processors, such as the BMIPS 5000, calls to
> arch_local_irq_disable() and others may be preempted, and in doing
> so a stale value may be restored to c0_status.  This fix disables
> preemption for such processors prior to the call and enables it
> after the call.
> 
> This bug was observed in a BMIPS 5000, occuring once every few hours
> in a continuous reboot test.  It was traced to the write_lock_irq()
> function which was being invoked in release_task() in exit.c.
> By placing a number of "nops" inbetween the mfc0/mtc0 pair in
> arch_local_irq_disable(), which is called by write_lock_irq(), we
> were able to greatly increase the occurance of this bug.  Similarly,
> the application of this commit silenced the bug.
> 
> It is better to use the preemption functions declared in <linux/preempt.h>
> rather than defining new ones as is done in this commit.  However,
> including that file from irqflags effected many compiler errors.

This is the 2nd time non-atomic RMW operations on c0_status bite in the
kernel.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/mips/include/asm/irqflags.h |   81 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 81 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
> index 309cbcd..2732f5f 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -16,6 +16,71 @@
>  #include <linux/compiler.h>
>  #include <asm/hazards.h>
>  
> +#if defined(__GENERATING_BOUNDS_H) || defined(__GENERATING_OFFSETS_S)
> +#define __TI_PRE_COUNT (-1)
> +#else
> +#include <asm/asm-offsets.h>
> +#define __TI_PRE_COUNT TI_PRE_COUNT
> +#endif

This part is too ugly to live.  Yet it seems it needs to live.

> +
> +
> +/* 
> + * Non-mipsr2 processors executing functions such as arch_local_irq_disable()
> + * are not preempt-safe: if preemption occurs between the mfc0 and the mtc0,
> + * a stale status value may be stored.  To prevent this, we define 
> + * here arch_local_preempt_disable() and arch_local_preempt_enable(), which 
> + * are called before the mfc0 and after the mtc0, respectively.  A better 
> + * solution would "#include <linux/preempt.h> and use its declared routines, 
> + * but that is not viable due to numerous compile errors.
> + *
> + * MipsR2 processors with atomic interrupt enable/disable instructions 
> + * (ei/di) do not have this issue.
> + */
> +__asm__(
> +	"	.macro	arch_local_preempt_disable ti_pre_count		\n"
> +	"	.set	push						\n"
> +	"	.set	noat						\n"
> +	"	lw	$1, \\ti_pre_count($28)				\n"
> +	"	addi	$1, $1, 1					\n"
> +	"	sw	$1, \\ti_pre_count($28)				\n"
> +	"	.set	pop						\n"
> +	"	.endm");
> +static inline void arch_local_preempt_disable(void)
> +{
> +#if defined(CONFIG_PREEMPT) && !defined(CONFIG_CPU_MIPSR2)
> +	__asm__ __volatile__(
> +		"arch_local_preempt_disable\t%0"
> +		: /* no outputs */
> +		: "n" (__TI_PRE_COUNT)
> +		: "memory");
> +	barrier();
> +#endif
> +}
> +
> +
> +__asm__(
> +	"	.macro	arch_local_preempt_enable ti_pre_count		\n"
> +	"	.set	push						\n"
> +	"	.set	noat						\n"
> +	"	lw	$1, \\ti_pre_count($28)				\n"
> +	"	addi	$1, $1, -1					\n"
> +	"	sw	$1, \\ti_pre_count($28)				\n"
> +	"	.set	pop						\n"
> +	"	.endm");
> +
> +static inline void arch_local_preempt_enable(void)
> +{
> +#if defined(CONFIG_PREEMPT) && !defined(CONFIG_CPU_MIPSR2)
> +	__asm__ __volatile__(
> +		"arch_local_preempt_enable\t%0"
> +		: /* no outputs */
> +		: "n" (__TI_PRE_COUNT)
> +		: "memory");
> +	barrier();
> +#endif
> +}
> +
> +
>  __asm__(
>  	"	.macro	arch_local_irq_enable				\n"
>  	"	.set	push						\n"
> @@ -99,11 +164,15 @@ __asm__(
>  
>  static inline void arch_local_irq_disable(void)
>  {
> +	arch_local_preempt_disable();
> +
>  	__asm__ __volatile__(
>  		"arch_local_irq_disable"
>  		: /* no outputs */
>  		: /* no inputs */
>  		: "memory");
> +
> +	arch_local_preempt_enable();
>  }
>  
>  __asm__(
> @@ -153,10 +222,15 @@ __asm__(
>  static inline unsigned long arch_local_irq_save(void)
>  {
>  	unsigned long flags;
> +
> +	arch_local_preempt_disable();
> +
>  	asm volatile("arch_local_irq_save\t%0"
>  		     : "=r" (flags)
>  		     : /* no inputs */
>  		     : "memory");
> +
> +	arch_local_preempt_enable();
>  	return flags;
>  }
>  
> @@ -214,23 +288,30 @@ static inline void arch_local_irq_restore(unsigned long flags)
>  	if (unlikely(!(flags & 0x0400)))
>  		smtc_ipi_replay();
>  #endif
> +	arch_local_preempt_disable();
>  
>  	__asm__ __volatile__(
>  		"arch_local_irq_restore\t%0"
>  		: "=r" (__tmp1)
>  		: "0" (flags)
>  		: "memory");
> +
> +	arch_local_preempt_enable();
>  }
>  
>  static inline void __arch_local_irq_restore(unsigned long flags)
>  {
>  	unsigned long __tmp1;
>  
> +	arch_local_preempt_disable();
> +
>  	__asm__ __volatile__(
>  		"arch_local_irq_restore\t%0"
>  		: "=r" (__tmp1)
>  		: "0" (flags)
>  		: "memory");
> +
> +	arch_local_preempt_enable();
>  }
>  
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
> -- 
> 1.7.6
> 
> 

  Ralf
