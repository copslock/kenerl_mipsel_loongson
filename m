Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FI5x122674
	for linux-mips-outgoing; Wed, 15 Aug 2001 11:05:59 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FI5vj22662
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 11:05:57 -0700
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15X53q-0007UB-00; Wed, 15 Aug 2001 11:06:34 -0700
Date: Wed, 15 Aug 2001 11:06:34 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FP emulator patch
Message-ID: <20010815110634.A19305@nevyn.them.org>
References: <3B7A70B8.ED92FE4@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3B7A70B8.ED92FE4@mips.com>; from carstenl@mips.com on Wed, Aug 15, 2001 at 02:53:12PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 15, 2001 at 02:53:12PM +0200, Carsten Langgaard wrote:
> There has been some reports regarding FP emulator failures, which the
> attached patch should solve.
> The patch include a fix for emulation of instructions in a COP1
> delay-slot, a fix for FP context switching and some additional stuff ,
> which was needed to pass our torture test.
> 
> Ralf could you please apply this patch.

Two comments, especially since parts of this seem to be the patch I
posted here over a month ago.

> Index: linux/arch/mips/kernel/signal.c

> @@ -353,12 +355,11 @@
>  	owned_fp = (current == last_task_used_math);
>  	err |= __put_user(owned_fp, &sc->sc_ownedfp);
>  
> -	if (current->used_math) {	/* fp is active.  */
> +	if (owned_fp) { /* fp is active.  */
>  		set_cp0_status(ST0_CU1);
>  		err |= save_fp_context(sc);
>  		last_task_used_math = NULL;
>  		regs->cp0_status &= ~ST0_CU1;
> -		current->used_math = 0;
>  	}
>  
>  	return err;

This is absolutely not right.  It's righter than the status quo.  If we
don't own the FP, you don't save the FP.  Then we can use FP in the
signal handler, corrupting the process's original floating point
context.


> Index: linux/include/asm-mips/processor.h


> @@ -235,8 +215,8 @@
>   * Do necessary setup to start up a newly executed thread.
>   */
>  #define start_thread(regs, new_pc, new_sp) do {				\
> -	/* New thread looses kernel privileges. */			\
> -	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU)) | KU_USER;\
> +	/* New thread loses kernel and FPU privileges. */               \
> +        regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU|ST0_CU1)) | KU_USER;\
>  	regs->cp0_epc = new_pc;						\
>  	regs->regs[29] = new_sp;					\
>  	current->thread.current_ds = USER_DS;				\

I could be misremembering, but I believe that Ralf said this should be
unnecessary and the problem was somewhere else.  On the other hand, I
still think it's a good idea.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
