Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2011 22:19:25 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49649 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492153Ab1HRUTW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Aug 2011 22:19:22 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7IKJDhe032357;
        Thu, 18 Aug 2011 21:19:13 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7IKJBR0032349;
        Thu, 18 Aug 2011 21:19:11 +0100
Date:   Thu, 18 Aug 2011 21:19:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     Yong Zhang <yong.zhang@windriver.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: use 32-bit wrapper for compat_sys_futex
Message-ID: <20110818201911.GF22920@linux-mips.org>
References: <1313546094-11882-1-git-send-email-yong.zhang@windriver.com>
 <4E4BF7C0.80703@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E4BF7C0.80703@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13647

On Wed, Aug 17, 2011 at 10:17:52AM -0700, David Daney wrote:

> >diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> >index 46c4763..f48b18e 100644
> >--- a/arch/mips/kernel/scall64-o32.S
> >+++ b/arch/mips/kernel/scall64-o32.S
> >@@ -441,7 +441,7 @@ sys_call_table:
> >  	PTR	sys_fremovexattr		/* 4235 */
> >  	PTR	sys_tkill
> >  	PTR	sys_sendfile64
> >-	PTR	compat_sys_futex
> >+	PTR	sys_32_futex
> 
> This change is redundant, scall64-o32.S already does the right thing
> so additional zero extending is not needed and is just extra
> instructions to execute for no reason.

Compat_sys_futex is a syscall entry point and for some configurations
such as CONFIG_FTRACE_SYSCALLS SYSCALL_DEFINE*() will do additional work
beyond cleaning up the arguments.  The 3 unnecessary shifts are the
overhead we just gotta live with.

> >  	PTR	compat_sys_sched_setaffinity
> >  	PTR	compat_sys_sched_getaffinity	/* 4240 */
> >  	PTR	compat_sys_io_setup
> 
> But really I think this patch fixes things at the wrong level.  Each
> architecture potentially needs a similar patch.  What would happen if
> we did something like:

> +++ b/kernel/futex_compat.c
> @@ -180,9 +180,9 @@ err_unlock:
>  	return ret;
>  }
> 
> -asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
> -		struct compat_timespec __user *utime, u32 __user *uaddr2,
> -		u32 val3)
> +SYSCALL_DEFINE6(compat_sys_futex, u32 __user *, uaddr, int , op, u32, val,
> +		struct compat_timespec __user *, utime, u32 __user *, uaddr2,
> +		u32, val3)
>  {
>  	struct timespec ts;
>  	ktime_t t, *tp = NULL;
> 
> Obviously the function name is wrong, but a varient of
> SYSCALL_DEFINE*() could be created so the proper function names are
> produced.

Right now none of the the generic compat_ functions is wrapped in
SYSCALL_DEFINE* because for some architectures a further wrapper function
is needed.  It seems some architectures call compat_ calls directly
without SYSCALL_DEFINE* which with CONFIG_FTRACE_SYSCALLS is a bug ...

  Ralf
