Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 18:45:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16625 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225203AbTA0Spn>;
	Mon, 27 Jan 2003 18:45:43 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0RITTA24530;
	Mon, 27 Jan 2003 10:29:29 -0800
Date: Mon, 27 Jan 2003 10:29:29 -0800
From: Jun Sun <jsun@mvista.com>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH 2.5] FPU
Message-ID: <20030127102929.N11633@mvista.com>
References: <Pine.LNX.4.21.0301260251300.15950-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0301260251300.15950-100000@melkor>; from vivienc@nerim.net on Sun, Jan 26, 2003 at 02:58:09AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sun, Jan 26, 2003 at 02:58:09AM +0100, Vivien Chappelier wrote:
> Hi,
> 
> 	At various places in the 2.5 kernel, the fpu is accessed in
> kernel mode with CU1 not set, causing an unexpected exception. This patch
> makes sure FPU can be accessed by the kernel, though it may only
> be a workaround. Any comment from someone with a better understanding of
> the FPU access/context switching code?
> 
> Vivien.
> 
> --- include/asm-mips64/fpu.h	2002-12-11 20:44:20.000000000 +0100
> +++ include/asm-mips64/fpu.h	2002-12-11 21:51:44.000000000 +0100
> @@ -109,6 +109,7 @@
>  
>  static inline void save_fp(struct task_struct *tsk)
>  {
> +	enable_fpu();
>  	if (mips_cpu.options & MIPS_CPU_FPU) 
>  		_save_fp(tsk);
>  }
> --- include/asm-mips/fpu.h	2002-12-11 20:44:20.000000000 +0100
> +++ include/asm-mips/fpu.h	2002-12-11 21:51:44.000000000 +0100
> @@ -109,6 +109,7 @@
>  
>  static inline void save_fp(struct task_struct *tsk)
>  {
> +	enable_fpu();
>  	if (mips_cpu.options & MIPS_CPU_FPU) 
>  		_save_fp(tsk);
>  }

The above two hunks seem to be right.

The following hunks are not right.  The checking for is_fpu_owner()
is meaningful.  If current process is FPU owner, you *don't* want to
do a restore which essentially wipe away the current FPU regsiter values
with an old snapshot of them.

I got a report saying save_fp_context() causes panic when current process
is FPU owner.  That tells me something is wrong in 2.5 that violates
that assumption that FPU is always enabled when current process is the
FPU owner.  I have it in my note and will look into it once I get to 2.5
work.  You are more than to look into it as well.  Meanwhile, just adding
a enable_fpu() to save_fp_context() should let you get rid of the crash.
(although I am afraid there might be other related bugs as this should
not be needed).

Jun

> --- arch/mips64/kernel/signal.c	2002-11-09 16:10:14.000000000 +0100
> +++ arch/mips64/kernel/signal.c	2003-01-14 01:35:42.000000000 +0100
> @@ -162,20 +162,19 @@
>  
>  	err |= __put_user(current->used_math, &sc->sc_used_math);
>  
> -	if (!current->used_math)
> -		goto out;
> +	if (current->used_math) {
> +
> +		/*
> +		 * Save FPU state to signal context.
> +		 * Signal handler will "inherit" current FPU state.
> +		 */
>  
> -	/*
> -	 * Save FPU state to signal context.  Signal handler will "inherit"
> -	 * current FPU state.
> -	 */
> -	if (!is_fpu_owner()) {
>  		own_fpu();
>  		restore_fp(current);
> +
> +		err |= save_fp_context(sc);
>  	}
> -	err |= save_fp_context(sc);
>  
> -out:
>  	return err;
>  }
>  
> --- arch/mips/kernel/signal.c	2002-11-09 16:10:08.000000000 +0100
> +++ arch/mips/kernel/signal.c	2003-01-14 01:36:41.000000000 +0100
> @@ -313,20 +313,19 @@
>  
>  	err |= __put_user(current->used_math, &sc->sc_used_math);
>  
> -	if (!current->used_math)
> -		goto out;
> +	if (current->used_math) {
> +
> +		/* 
> +		 * Save FPU state to signal context.
> +		 * Signal handler will "inherit" current FPU state.
> +		 */
>  
> -	/* 
> -	 * Save FPU state to signal context.  Signal handler will "inherit"
> -	 * current FPU state.
> -	 */
> -	if (!is_fpu_owner()) {
>  		own_fpu();
>  		restore_fp(current);
> +
> +		err |= save_fp_context(sc);
>  	}
> -	err |= save_fp_context(sc);
>  
> -out:
>  	return err;
>  }
>  
> --- arch/mips64/kernel/signal32.c	2002-11-09 16:10:14.000000000 +0100
> +++ arch/mips64/kernel/signal32.c	2003-01-14 01:34:52.000000000 +0100
> @@ -457,20 +430,19 @@
>  
>  	err |= __put_user(current->used_math, &sc->sc_used_math);
>  
> -	if (!current->used_math)
> -		goto out;
> +	if (current->used_math) {
> +
> +		/* 
> +		 * Save FPU state to signal context.
> +		 * Signal handler will "inherit" current FPU state.
> +		 */
>  
> -	/* 
> -	 * Save FPU state to signal context.  Signal handler will "inherit"
> -	 * current FPU state.
> -	 */
> -	if (!is_fpu_owner()) {
>  		own_fpu();
>  		restore_fp(current);
> +
> +		err |= save_fp_context(sc);
>  	}
> -	err |= save_fp_context(sc);
>  
> -out:
>  	return err;
>  }
>  
> 
> 
