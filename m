Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 00:43:52 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20733 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225203AbTBGAnv>;
	Fri, 7 Feb 2003 00:43:51 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h170hgF03759;
	Thu, 6 Feb 2003 16:43:42 -0800
Date: Thu, 6 Feb 2003 16:43:42 -0800
From: Jun Sun <jsun@mvista.com>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH 2.5] clear USEDFPU in copy_thread
Message-ID: <20030206164342.G13258@mvista.com>
References: <Pine.LNX.4.21.0302042349200.31806-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0302042349200.31806-100000@melkor>; from vivienc@nerim.net on Tue, Feb 04, 2003 at 11:54:38PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


You should *not* clear USEDFPU in copy_thread().  Imagine
you assign a floating point variable f=0.3, then do fork()
and then in the child process, alas, f is undefined (zero
most likely).

If you really want to do it, it should be in start_thread().

Even if you don't have it cleared in start_thread(), things
should be generally OK.  You will have some dirty FPU content
instead of a all-zero one when you start a new program.  But then
since all sane program should assign register values before they
first time use them, so this bug should be well hidden.

I am still curious whether this is a bug in i386 as well or they do
clear the flag in some non-obvious way.  Note that the unlazy_fpu()
in copy_thread won't do it.  It only clears the current process's
USEDFPU flag, while the child process's flag is set way back in
copy_flags() calls inside do_fork().


Jun


On Tue, Feb 04, 2003 at 11:54:38PM +0100, Vivien Chappelier wrote:
> Hi,
> 
> 	When copying a thread, access to the FPU is disabled by clearing
> the ST0_CU1 bit in the new thread saved CP0_STATUS register. However, the
> corresponding TIF_USEDFPU flag is not cleared at it should to indicate the
> FPU has not yet been used by the new process.
> 	This patch also clears user_tid in mips64 code, and moves it away
> from the FPU comment in the mips code.
> 
> Vivien.
> 
> Index: arch/mips64/kernel/process.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/kernel/process.c,v
> retrieving revision 1.36
> diff -u -r1.36 process.c
> --- arch/mips64/kernel/process.c	9 Jan 2003 19:16:50 -0000	1.36
> +++ arch/mips64/kernel/process.c	4 Feb 2003 22:47:00 -0000
> @@ -114,6 +114,8 @@
>  	p->thread.reg29 = (unsigned long) childregs;
>  	p->thread.reg31 = (unsigned long) ret_from_fork;
>  
> +	p->user_tid = NULL;
> +
>  	/*
>  	 * New tasks loose permission to use the fpu. This accelerates context
>  	 * switching for most programs since they don't use the fpu.
> @@ -121,6 +123,7 @@
>  	p->thread.cp0_status = read_c0_status() &
>                              ~(ST0_CU3|ST0_CU2|ST0_CU1|ST0_KSU);
>  	childregs->cp0_status &= ~(ST0_CU3|ST0_CU2|ST0_CU1);
> +	clear_ti_thread_flag(ti, TIF_USEDFPU);
>  
>  	return 0;
>  }
> Index: arch/mips/kernel/process.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/kernel/process.c,v
> retrieving revision 1.50
> diff -u -r1.50 process.c
> --- arch/mips/kernel/process.c	9 Jan 2003 19:16:50 -0000	1.50
> +++ arch/mips/kernel/process.c	4 Feb 2003 22:47:04 -0000
> @@ -117,6 +117,8 @@
>  	p->thread.reg29 = (unsigned long) childregs;
>  	p->thread.reg31 = (unsigned long) ret_from_fork;
>  
> +	p->user_tid = NULL;
> +
>  	/*
>  	 * New tasks loose permission to use the fpu. This accelerates context
>  	 * switching for most programs since they don't use the fpu.
> @@ -124,7 +126,7 @@
>  	p->thread.cp0_status = read_c0_status() &
>                              ~(ST0_CU2|ST0_CU1|KU_MASK);
>  	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
> -	p->user_tid = NULL;
> +	clear_ti_thread_flag(ti, TIF_USEDFPU);
>  
>  	return 0;
>  }
> 
