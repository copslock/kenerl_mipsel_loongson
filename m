Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 13:31:51 +0100 (BST)
Received: from mail-gx0-f10.google.com ([209.85.217.10]:26064 "EHLO
	mail-gx0-f10.google.com") by ftp.linux-mips.org with ESMTP
	id S22207696AbYJWMbp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 13:31:45 +0100
Received: by gxk3 with SMTP id 3so9788805gxk.0
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2008 05:31:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=djPNtrcKKc3FCGDVMUoArU2ZPvszN/X7VRjn2OezfwQ=;
        b=wEvCz2EI+FzyVMNn9/ZmwPxUGfd9MhO91+IpDb2befwuRLkJh9ZRqA7Q4rlqttanr+
         HtV//YA5S0/YRioo9+LiAzqO/ui0tXpR8SkuJEu3h36j6j4jGvMnMJOAYPyuNO+ahS/r
         mNABp99QbCqztJq6JoB+gryBSeMmRDhtBMN/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wKLn+o6Fnz7zC7/mWekvsGNDMjVSio8uk0+ApLwHyyMMkF57XjicnU70IW5XDxiCy0
         nHrGczPMurkckq1jHgtWFsjjCbY5NFWDOAqBSOfjHL0d6cYars9C5QZ7Xi8KPP2rCsgt
         2QYriPc42h2kJt4lSHw0S0aYj0QTzGKo2TuGE=
Received: by 10.86.76.20 with SMTP id y20mr2228308fga.3.1224765093629;
        Thu, 23 Oct 2008 05:31:33 -0700 (PDT)
Received: by 10.86.9.6 with HTTP; Thu, 23 Oct 2008 05:31:33 -0700 (PDT)
Message-ID: <c62985530810230531t2f850b7fsb7d2296813083107@mail.gmail.com>
Date:	Thu, 23 Oct 2008 14:31:33 +0200
From:	"=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Support for ftrace in MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20081023090746.GC10625@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c62985530810201800r3ddfbb99s1a0809f2eba45cdf@mail.gmail.com>
	 <20081023090746.GC10625@linux-mips.org>
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

2008/10/23 Ralf Baechle <ralf@linux-mips.org>:
> I do have an ftrace implementation in the queue.  Static ftrace works as
> far as I've tested but due to a restriction of the generic ftrace code the
> MIPS code for dynamic ftrace can't work on most SMP systems - basically
> only the R10000 and single core 34K SMP kernel variants have a chance to
> work.  For others cache flushing requires a call to smp_call_function but
> that can't work because other CPUs are stopped at the time of the flush.
> So that still needs some sorting.


Ok, I started something but your work is more advanced.
One idea for this smp cache flush. Perhaps we could sync these when we are
out of kstop_machine (just for mips).

> Patch below.
>
>  Ralf
>
> From: Ralf Baechle <ralf@linux-mips.org>
> Date: Wed, 10 Sep 2008 18:04:04 +0200
> Subject: [PATCH] [MIPS] Implement fcount support for MIPS.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/Kconfig             |    5 ++
>  arch/mips/Makefile            |    2 +
>  arch/mips/kernel/Makefile     |    2 +
>  arch/mips/kernel/ftrace.c     |  118 +++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/mips_ksyms.c |    6 ++
>  arch/mips/lib/Makefile        |    2 +
>  arch/mips/lib/mcount.S        |  128 +++++++++++++++++++++++++++++++++++++++++
>  include/asm-mips/ftrace.h     |   14 +++++
>  8 files changed, 277 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5f149b0..43202db 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1,6 +1,7 @@
>  config MIPS
>        bool
>        default y
> +       select HAVE_FTRACE
>        select HAVE_IDE
>        select HAVE_OPROFILE
>        select HAVE_ARCH_KGDB
> @@ -1503,6 +1504,10 @@ config MIPS_APSP_KSPD
>          "exit" syscall notifying other kernel modules the SP program is
>          exiting.  You probably want to say yes here.
>
> +config SYS_SUPPORTS_DYNAMIC_FTRACE
> +       def_bool y
> +       select HAVE_DYNAMIC_FTRACE if !SMP || CPU_R10000
> +
>  config MIPS_CMP
>        bool "MIPS CMP framework support"
>        depends on SYS_SUPPORTS_MIPS_CMP
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 7f39fd8..ae9099b 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -14,7 +14,9 @@
>
>  KBUILD_DEFCONFIG := ip22_defconfig
>
> +ifndef CONFIG_FTRACE
>  cflags-y := -ffunction-sections
> +endif
>
>  #
>  # Select the object file format to substitute into the linker script.
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index d9da711..ea730e0 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -43,6 +43,8 @@ obj-$(CONFIG_CPU_TX39XX)      += r2300_fpu.o r2300_switch.o
>  obj-$(CONFIG_CPU_TX49XX)       += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_VR41XX)       += r4k_fpu.o r4k_switch.o
>
> +obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o
> +
>  obj-$(CONFIG_SMP)              += smp.o
>  obj-$(CONFIG_SMP_UP)           += smp-up.o
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> new file mode 100644
> index 0000000..e24ae47
> --- /dev/null
> +++ b/arch/mips/kernel/ftrace.c
> @@ -0,0 +1,118 @@
> +#include <linux/ftrace.h>
> +#include <linux/init.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/sgidefs.h>
> +#include <asm/inst.h>
> +#include <asm/ftrace.h>
> +
> +/*
> + * On O32 the gcc generated code sequence to invoke _mcount looks like
> + *
> + *     move    $1, $31                 # save current return address
> + *     subu    $sp, $sp, 8             # _mcount pops 2 words from  stack
> + *     jal     _mcount
> + *      j      $31
> + *
> + * If the _mcount call is nop'ed out we still need to pop the stack frame.
> + * So we use an addiu $sp, $sp, 8 instead.  NABI doesn't allocate frames in
> + * such a nonsenical way so a normal nop does the magic.
> + */
> +static const union mips_instruction ftrace_nop = {
> +#if _MIPS_SIM == _MIPS_SIM_ABI32
> +       .i_format.opcode = addiu_op,            /* addiu $sp, $sp, 8 */
> +       .i_format.rs = 29,
> +       .i_format.rt = 29,
> +       .i_format.simmediate = 8
> +#else
> +       .word = 0                               /* normal nop */
> +#endif
> +};
> +
> +notrace unsigned char *ftrace_nop_replace(void)
> +{
> +       return (unsigned char *) ftrace_nop.byte;
> +}
> +
> +notrace unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
> +{
> +       static union mips_instruction inst;
> +
> +       if (unlikely(ip ^ addr) >> 26) {
> +               WARN_ON_ONCE(1);
> +               return NULL;
> +       }
> +
> +       inst.j_format.opcode = jal_op;
> +       inst.j_format.target = addr >> 2;
> +
> +       return (unsigned char *) &inst;
> +}
> +
> +notrace int
> +ftrace_modify_code(unsigned long ip, unsigned char *old_code,
> +                   unsigned char *new_code)
> +{
> +       unsigned int old = *(unsigned int *) old_code;
> +       unsigned int new = *(unsigned int *) new_code;
> +       unsigned int replaced;
> +       int err;
> +
> +       err = __get_user(replaced, (unsigned int *) ip);
> +       if (unlikely(err))
> +               return 1;
> +
> +       err = __put_user(new, (unsigned int *) ip);
> +       if (unlikely(err))
> +               return 1;
> +
> +       if (unlikely(replaced != old && replaced != new))
> +               return 2;
> +
> +       /*
> +        * This is broken.  We need to flush the icache on all processors
> +        * but can't because ftrace_modify_code is executed with interrupts
> +        * disabled ...
> +        */
> +       local_flush_icache_range(ip, ip + MCOUNT_INSN_SIZE);
> +
> +       return 0;
> +}
> +
> +notrace int ftrace_update_ftrace_func(ftrace_func_t func)
> +{
> +       unsigned long ip = (unsigned long) &ftrace_call;
> +       unsigned char old[MCOUNT_INSN_SIZE], *new;
> +       int ret;
> +
> +       memcpy(old, &ftrace_call, MCOUNT_INSN_SIZE);
> +       new = ftrace_call_replace(ip, (unsigned long)func);
> +       ret = ftrace_modify_code(ip, old, new);
> +
> +       return ret;
> +}
> +
> +notrace int ftrace_mcount_set(unsigned long *data)
> +{
> +       unsigned long ip = (unsigned long) &mcount_call;
> +       unsigned long *addr = data;
> +       unsigned char old[MCOUNT_INSN_SIZE], *new;
> +
> +       /*
> +        * Replace the mcount stub with a pointer to the
> +        * ip recorder function.
> +        */
> +       memcpy(old, &mcount_call, MCOUNT_INSN_SIZE);
> +       new = ftrace_call_replace(ip, *addr);
> +       *addr = ftrace_modify_code(ip, old, new);
> +
> +       return 0;
> +}
> +
> +int __init ftrace_dyn_arch_init(void *data)
> +{
> +       ftrace_mcount_set(data);
> +
> +       return 0;
> +}
> diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> index 225755d..18f5556 100644
> --- a/arch/mips/kernel/mips_ksyms.c
> +++ b/arch/mips/kernel/mips_ksyms.c
> @@ -11,6 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <asm/checksum.h>
> +#include <asm/ftrace.h>
>  #include <asm/pgtable.h>
>  #include <asm/uaccess.h>
>
> @@ -51,3 +52,8 @@ EXPORT_SYMBOL(csum_partial_copy_nocheck);
>  EXPORT_SYMBOL(__csum_partial_copy_user);
>
>  EXPORT_SYMBOL(invalid_pte_table);
> +
> +#ifdef CONFIG_FTRACE
> +/* _mcount is defined in assembly */
> +EXPORT_SYMBOL(_mcount);
> +#endif
> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index 8810dfb..c9ec0c3 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -27,5 +27,7 @@ obj-$(CONFIG_CPU_TX39XX)      += r3k_dump_tlb.o
>  obj-$(CONFIG_CPU_TX49XX)       += dump_tlb.o
>  obj-$(CONFIG_CPU_VR41XX)       += dump_tlb.o
>
> +obj-$(CONFIG_FTRACE)           += mcount.o
> +
>  # libgcc-style stuff needed in the kernel
>  obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
> diff --git a/arch/mips/lib/mcount.S b/arch/mips/lib/mcount.S
> new file mode 100644
> index 0000000..9817ce6
> --- /dev/null
> +++ b/arch/mips/lib/mcount.S
> @@ -0,0 +1,128 @@
> +#include <asm/regdef.h>
> +#include <asm/ftrace.h>
> +#include <asm/asm.h>
> +
> +/*
> + * The problem here is that _mcount() is not a normal function.  It does
> + * not obey the calling conventions of a normal function.  It takes its
> + * arguments in $at and $ra, and it is required to preserve $ra - and most
> + * other registers, in fact, if I remember correctly.  The arguments have
> + * not yet been saved.  You need to do this.  Another bizarreness is that
> + * the caller needs to pop an extra 8 bytes for the O32.
> + */

That's the information I missed. I actually had some trouble to find
the parent ip.
The only solution to find it for me was to walk through the stack with
the function
__kernel_text_address until it returns non-zero. That was ugly because fairly
bad for performances and a function pointer could have been put in the stack and
so been considered as a return address.
I should have a look at a disassembly dump after a building with -pg

> +#if _MIPS_SIM == _ABIO32
> +#define POP_EXTRA 8
> +#define ARG_SAVE 16
> +#define N_ARG_REGS 4
> +#else
> +#define POP_EXTRA 0
> +#define ARG_SAVE 0
> +#define N_ARG_REGS 8
> +#endif
> +
> +       .macro          save_mcount_frame
> +       PTR_SUBU        sp, sp, ARG_SAVE + (N_ARG_REGS + 4) * LONGSIZE
> +       LONG_S          AT, ARG_SAVE + 0 * LONGSIZE(sp)
> +       LONG_S          ra, ARG_SAVE + 1 * LONGSIZE(sp)
> +       LONG_S          a0, ARG_SAVE + 2 * LONGSIZE(sp)
> +       LONG_S          a1, ARG_SAVE + 3 * LONGSIZE(sp)
> +       LONG_S          a2, ARG_SAVE + 4 * LONGSIZE(sp)
> +       LONG_S          a3, ARG_SAVE + 5 * LONGSIZE(sp)
> +#if _MIPS_SIM == _ABI64
> +       LONG_S          a4, ARG_SAVE + 6 * LONGSIZE(sp)
> +       LONG_S          a5, ARG_SAVE + 7 * LONGSIZE(sp)
> +       LONG_S          a6, ARG_SAVE + 8 * LONGSIZE(sp)
> +       LONG_S          a7, ARG_SAVE + 9 * LONGSIZE(sp)
> +#endif
> +       LONG_S          v0, ARG_SAVE + (2 + N_ARG_REGS) * LONGSIZE(sp)
> +       .endm
> +
> +       .macro          restore_mcount_frame
> +       LONG_L          AT, ARG_SAVE + 0 * LONGSIZE(sp)
> +       LONG_L          ra, ARG_SAVE + 1 * LONGSIZE(sp)
> +       LONG_L          a0, ARG_SAVE + 2 * LONGSIZE(sp)
> +       LONG_L          a1, ARG_SAVE + 3 * LONGSIZE(sp)
> +       LONG_L          a2, ARG_SAVE + 4 * LONGSIZE(sp)
> +       LONG_L          a3, ARG_SAVE + 5 * LONGSIZE(sp)
> +#if _MIPS_SIM == _ABI64
> +       LONG_L          a4, ARG_SAVE + 6 * LONGSIZE(sp)
> +       LONG_L          a5, ARG_SAVE + 7 * LONGSIZE(sp)
> +       LONG_L          a6, ARG_SAVE + 8 * LONGSIZE(sp)
> +       LONG_L          a7, ARG_SAVE + 9 * LONGSIZE(sp)
> +#endif
> +       LONG_L          v0, ARG_SAVE + (2 + N_ARG_REGS) * LONGSIZE(sp)
> +       PTR_ADDU        sp, sp, ARG_SAVE + (N_ARG_REGS + 4) * LONGSIZE + POP_EXTRA
> +       .endm
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +
> +LEAF(_mcount)
> +       .set            push
> +       .set            noreorder
> +       .set            noat
> +       save_mcount_frame
> +       PTR_SUBU        a0, ra, 2 * MCOUNT_INSN_SIZE
> +
> +FEXPORT(mcount_call)
> +       jal             ftrace_stub
> +        nop
> +
> +       restore_mcount_frame
> +       jr              ra
> +        move           ra, AT
> +       .set            pop
> +       END(_mcount)
> +
> +LEAF(ftrace_caller)
> +       .set            push
> +       .set            noreorder
> +       .set            noat
> +       save_mcount_frame
> +       PTR_SUBU        a0, ra, 2 * MCOUNT_INSN_SIZE
> +       move            a1, AT
> +
> +FEXPORT(ftrace_call)
> +       jal             ftrace_stub
> +        nop
> +
> +       restore_mcount_frame
> +       jr              ra
> +        move           ra, AT
> +       .set            pop
> +       END(ftrace_caller)
> +
> +#else
> +
> +LEAF(_mcount)
> +       .set            push
> +       .set            noreorder
> +       .set            noat
> +       PTR_L           t0, ftrace_trace_function
> +       PTR_LA          t1, ftrace_stub
> +       bne             t0, t1, trace
> +        nop
> +
> +#if POP_EXTRA
> +       PTR_ADDIU       sp, sp, 8
> +#endif
> +       jr              ra
> +        move            ra, AT
> +
> +trace:
> +       save_mcount_frame
> +       PTR_SUBU        a0, ra, 2 * MCOUNT_INSN_SIZE
> +       move            a1, AT
> +       jalr            t0
> +        nop
> +       restore_mcount_frame
> +       jr              ra
> +        move           ra, AT
> +       .set            pop
> +       END(_mcount)
> +
> +#endif /* !CONFIG_DYNAMIC_FTRACE */
> +
> +LEAF(ftrace_stub)
> +       jr              ra
> +       END(ftrace_stub)
> diff --git a/include/asm-mips/ftrace.h b/include/asm-mips/ftrace.h
> new file mode 100644
> index 0000000..f0479ce
> --- /dev/null
> +++ b/include/asm-mips/ftrace.h
> @@ -0,0 +1,14 @@
> +#ifndef __ASM_FTRACE_H
> +#define __ASM_FTRACE_H
> +
> +#ifdef CONFIG_FTRACE
> +#define MCOUNT_ADDR             ((long)(_mcount))
> +#define MCOUNT_INSN_SIZE        4 /* sizeof mcount call */
> +
> +#ifndef __ASSEMBLY__
> +extern void _mcount(void);
> +#endif
> +
> +#endif /* CONFIG_FTRACE */
> +
> +#endif /* __ASM_FTRACE_H */
>

I can only test through qemu and I usually choose a malta emulation.
If you want some help
for testing or things like that. Don't hesitate.
