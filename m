Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2002 10:34:20 +0100 (MET)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:8887 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S869488AbSLIJeI>;
	Mon, 9 Dec 2002 10:34:08 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB99U7Nf016686;
	Mon, 9 Dec 2002 01:30:07 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA00224;
	Mon, 9 Dec 2002 01:30:03 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB99U3b25354;
	Mon, 9 Dec 2002 10:30:03 +0100 (MET)
Message-ID: <3DF4629B.F377F711@mips.com>
Date: Mon, 09 Dec 2002 10:30:03 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Dominic Sweetman <dom@algor.co.uk>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
References: <3DEF7087.B6DEA7EC@mips.com> <20021209051845.A31939@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Thu, Dec 05, 2002 at 04:28:07PM +0100, Carsten Langgaard wrote:
>
> > I have addressed this issue before, and I do it again, because we have a
> > potential kernel crash situation, if this isn't fixed.
> >
> > The __access_ok macro in include/asm-mips64/uaccess.h and the check_axs
> > macro in arch/mips64/kernel/unaligned.c need to be changed in order to
> > work correctly, it's a copy from the 32-bit kernel. It's not good enough
> > to simply check for the "sign bit" of the address.
> > The area between USEG (XUSEG) and KSEG0 will in 64-bit addressing mode
> > generate an address error, if accessed.
> > The size of the area depend on the number of virtual addressing bits
> > implemented in the CPU.
> >
> > Please take a look at the patch below.
> > I think Ralf had some objection the last time I send it, about the fix,
> > not being efficient enough (performance vice), but I think we need to
> > consider stability and functionality over performance. So until someone
> > comes up with a better solution, I think we need this fix.
>
> Standard Linux approach - a bad solution is worse than no solution.
>
> Just to show the impact of your patch:

>    text    data     bss     dec     hex filename
> 1817824 1079664  173664 3071152  2edcb0 vmlinux-cvs
> 1870752 1079664  173664 3124080  2fab70 vmlinux-carsten
>
> So that's 52928 bytes of bloat.

>  __access_ok is one of those kernel
> functions that are inlined so often that each extra instruction needs a
> _very_ good justification.

I really disagree.
My solution may impact the size of the kernel (the increase is less than 2
percent), but it prevent kernel crashes.
Sure we may be able to find a better solution, but it has been almost 1/2 year ago,
the last time I addressed this problem.
I know at least one other on the list was hit by this problem.


>
> The patch below adds 32 bytes.  It's still not the right thing though.  It's
> not fixing all stuff in the assembler code.  I have a better patch but it
> results in odd userspace behaviour.  Smells like a compiler problem ...

I tried you patch below, but then nothing seems to work.


>
>   Ralf
>
> Index: arch/mips64/kernel/process.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/kernel/process.c,v
> retrieving revision 1.18.2.9
> diff -u -r1.18.2.9 process.c
> --- arch/mips64/kernel/process.c        2 Dec 2002 00:24:52 -0000       1.18.2.9
> +++ arch/mips64/kernel/process.c        7 Dec 2002 02:13:40 -0000
> @@ -52,17 +52,19 @@
>  void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
>  {
>         unsigned long status;
> +       int compat32 = current->thread.mflags & MF_32BIT;
>
>         /* New thread looses kernel privileges. */
>         status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);
>         status |= KSU_USER;
> -       status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;
> +       status |= compat32 ? 0 : ST0_FR;
>         regs->cp0_status = status;
>         current->used_math = 0;
>         loose_fpu();
>         regs->cp0_epc = pc;
>         regs->regs[29] = sp;
>         current->thread.current_ds = USER_DS;
> +       current->thread.user_ds.seg = - (compat32 ? 0x80000000UL : TASK_SIZE);
>  }
>
>  void exit_thread(void)
> Index: include/asm-mips64/processor.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips64/processor.h,v
> retrieving revision 1.32.2.9
> diff -u -r1.32.2.9 processor.h
> --- include/asm-mips64/processor.h      4 Nov 2002 19:39:56 -0000       1.32.2.9
> +++ include/asm-mips64/processor.h      7 Dec 2002 02:14:10 -0000
> @@ -180,7 +180,7 @@
>  #define MF_LOGADE 2                    /* Log address errors to syslog */
>  #define MF_32BIT  4                    /* Process is in 32-bit compat mode */
>         unsigned long mflags;
> -       mm_segment_t current_ds;
> +       mm_segment_t current_ds, user_ds;
>         unsigned long irix_trampoline;  /* Wheee... */
>         unsigned long irix_oldctx;
>  };
> @@ -208,7 +208,7 @@
>         /* \
>          * For now the default is to fix address errors \
>          */ \
> -       MF_FIXADE, { 0 }, 0, 0 \
> +       MF_FIXADE, KERNEL_DS, { -TASK_SIZE }, 0, 0 \
>  }
>
>  #ifdef __KERNEL__
> Index: include/asm-mips64/uaccess.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips64/uaccess.h,v
> retrieving revision 1.13.2.1
> diff -u -r1.13.2.1 uaccess.h
> --- include/asm-mips64/uaccess.h        1 Jul 2002 15:27:31 -0000       1.13.2.1
> +++ include/asm-mips64/uaccess.h        7 Dec 2002 02:14:10 -0000
> @@ -23,7 +23,7 @@
>   * For historical reasons, these macros are grossly misnamed.
>   */
>  #define KERNEL_DS      ((mm_segment_t) { (unsigned long) 0L })
> -#define USER_DS                ((mm_segment_t) { (unsigned long) -1L })
> +#define USER_DS                (current->thread.user_ds)
>
>  #define VERIFY_READ    0
>  #define VERIFY_WRITE   1
> @@ -49,7 +49,7 @@
>         (__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
>
>  #define __access_ok(addr,size,mask)                                    \
> -       (((signed long)((mask)&(addr | (addr + size) | __ua_size(size)))) >= 0)
> +       (((mask) & (addr | (addr + size) | __ua_size(size))) == 0)
>
>  #define __access_mask ((long)(get_fs().seg))
>

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
