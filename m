Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBK8xkD23335
	for linux-mips-outgoing; Thu, 20 Dec 2001 00:59:46 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBK8xUX23332
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 00:59:30 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA29298;
	Wed, 19 Dec 2001 23:58:50 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA22582;
	Wed, 19 Dec 2001 23:58:49 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fBK7wfA05517;
	Thu, 20 Dec 2001 08:58:41 +0100 (MET)
Message-ID: <3C219A3B.6DA93A75@mips.com>
Date: Thu, 20 Dec 2001 08:58:51 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: an old FPU context corruption problem when signal happens
References: <3C21390A.FA23978D@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Are you sure this hasn't been fix in the latest sources (2.4.16) ?
I have send a patch to Ralf, which I believe solves a similar problem as you describe below.

Ralf have you applied the patch ?

/Carsten

Jun Sun wrote:

> This is an incomplete patch, attempting to fix an old fix FPU context
> corruption problem with signal happens.
>
> The following scenario would cause many problems with current code:
>
> 1. process A runs and uses FPU
> 2. Process A is switched out; Process B runs and uses FPU
> 3. Process A runs again, but have not used FPU this time around
> 4. Process A receives a signal.
> 5. Process A's signal handler runs and uses FPU
> 6. Process B runs again and uses FPU.
>
> At step 4, we have last_task_used_fpu being B, current->used_math being 1.
> The current code would save B's FPU context to A's sc structure, but
> does not mark owned_fp bits.
>
> At step 5, when A's sig handler first time uses FPU, FPU is enabled again.
>
> At step 6, when B tries to use FPU again, a lazy fpu switch happens.  The
> current FPU regs are stored into A's thread strucutre, effectively eraseing
> previously stored A's FPU context before the sig handler starts.
>
> In addition, B finds its FPU reg values totally bogus when they are loaded
> from B's thread structure, because the FPU regs were saved there.  (See
> step 4).
>
> This patch is meant for concept debugging.  But it should be easy
> to complete it:
>
> 1. support the two copy_fpu_context function.  (note, need to differentiate
> between CPU_HAS_FPU and !CPU_HAS_FPU cases)
> 2. perhaps change ->sc_ownedfp to ->sc_used_fpu, which is really what
> this flag means now.
>
> Any comments?
>
> Jun
>
>   ------------------------------------------------------------------------
>
> This is an incomplete patch, attempting to fix an old fix FPU context
> corruption problem with signal happens.
>
> The following scenario would cause many problems with current code:
>
> 1. process A runs and uses FPU
> 2. Process A is switched out; Process B runs and uses FPU
> 3. Process A runs again, but have not used FPU this time around
> 4. Process A receives a signal.
> 5. Process A's signal handler runs and uses FPU
> 6. Process B runs again and uses FPU.
>
> At step 4, we have last_task_used_fpu being B, current->used_math being 1.
> The current code would save B's FPU context to A's sc structure, but
> does not mark owned_fp bits.
>
> At step 5, when A's sig handler first time uses FPU, FPU is enabled again.
>
> At step 6, when B tries to use FPU again, a lazy fpu switch happens.  The
> current FPU regs are stored into A's thread strucutre, effectively eraseing
> previously stored A's FPU context before the sig handler starts.
>
> In addition, B finds its FPU reg values totally bogus when they are loaded
> from B's thread structure, because the FPU regs were saved there.  (See
> step 4).
>
> This patch is meant for concept debugging.  But it should be easy
> to complete it:
>
> 1. support the two copy_fpu_context function.  (note, need to differentiate
> between CPU_HAS_FPU and !CPU_HAS_FPU cases)
> 2. perhaps change ->sc_ownedfp to ->sc_used_fpu, which is really what
> this flag means now.
>
> Any comments?
>
> Jun
>
> diff -Nru linux.link/arch/mips/kernel/signal.c.orig linux.link/arch/mips/kernel/signal.c
> --- linux.link/arch/mips/kernel/signal.c.orig   Tue Nov 27 11:03:02 2001
> +++ linux.link/arch/mips/kernel/signal.c        Wed Dec 19 16:28:08 2001
> @@ -222,8 +222,20 @@
>
>         err |= __get_user(owned_fp, &sc->sc_ownedfp);
>         if (owned_fp) {
> -               err |= restore_fp_context(sc);
> -               last_task_used_math = current;
> +               if ((last_task_used_match == NULL) || (last_task_used_math == current)) {
> +                       /* if nobody owns FPU, or sig handler owns it,
> +                        * we just restore FPU regs from sc to hardware */
> +                       err |= restore_fp_context(sc);
> +                       last_task_used_math = current;
> +                       enable_fpu();
> +               } else {
> +                       /* we copy FPU values from sc to task structure */
> +                       err |= copy_fpu_context_from_sigcontext(current, sc);
> +                       disable_fpu();
> +               }
> +
> +               /* in either case, we need to set the used flag */
> +               current->used_math = 1;
>         }
>
>         return err;
> @@ -352,13 +364,25 @@
>         err |= __put_user(regs->cp0_cause, &sc->sc_cause);
>         err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
>
> -       owned_fp = (current == last_task_used_math);
> -       err |= __put_user(owned_fp, &sc->sc_ownedfp);
> +       /* if we ever used FPU, we need to get FPU regs to sc */
> +       if (current->used_math) {
> +
> +               if (current == last_task_used_math) {
> +                       /* if we own FPU now, just save fpu to sc directly */
> +                       enable_fpu();
> +                       err |= save_fp_context(sc);
> +               } else {
> +                       /* otherwise, we need copy fpu regs from current task
> +                        * structure to sc structre.
> +                        */
> +                       err |= copy_fpu_context_to_sigcontext(current, sc);
> +               }
> +
> +               /* put remember that we have valid FPU regs in sc */
> +               err |= __put_user(current->used_math, &sc->sc_ownedfp);
>
> -       if (current->used_math) {       /* fp is active.  */
> -               enable_fpu();
> -               err |= save_fp_context(sc);
> -               last_task_used_math = NULL;
> +               /* we now pretend we have never used FPU before we start sig
> +                * handler */
>                 regs->cp0_status &= ~ST0_CU1;
>                 current->used_math = 0;
>         }

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
