Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 06:16:34 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:63523 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490967Ab1HSEQ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 06:16:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7J4Fcwp028542
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 18 Aug 2011 21:15:38 -0700 (PDT)
Received: from localhost (128.224.158.133) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Thu, 18 Aug
 2011 21:15:38 -0700
Date:   Fri, 19 Aug 2011 12:15:34 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Yong Zhang <yong.zhang0@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: How to trace compat syscalls? [Was Re: [PATCH] MIPS: use 32-bit
 wrapper for compat_sys_futex]
Message-ID: <20110819041534.GA4230@windriver.com>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1313546094-11882-1-git-send-email-yong.zhang@windriver.com>
 <4E4BF7C0.80703@cavium.com>
 <20110818201911.GF22920@linux-mips.org>
 <20110819034950.GA3350@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20110819034950.GA3350@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.158.133]
X-archive-position: 30914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13831

On Fri, Aug 19, 2011 at 11:49:50AM +0800, Yong Zhang wrote:
> Cc'ing more people.
> 
> On Thu, Aug 18, 2011 at 09:19:11PM +0100, Ralf Baechle wrote:
> > > But really I think this patch fixes things at the wrong level.  Each
> > > architecture potentially needs a similar patch.  What would happen if
> > > we did something like:
> > 
> > > +++ b/kernel/futex_compat.c
> > > @@ -180,9 +180,9 @@ err_unlock:
> > >  	return ret;
> > >  }
> > > 
> > > -asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
> > > -		struct compat_timespec __user *utime, u32 __user *uaddr2,
> > > -		u32 val3)
> > > +SYSCALL_DEFINE6(compat_sys_futex, u32 __user *, uaddr, int , op, u32, val,
> > > +		struct compat_timespec __user *, utime, u32 __user *, uaddr2,
> > > +		u32, val3)
> > >  {
> > >  	struct timespec ts;
> > >  	ktime_t t, *tp = NULL;
> > > 
> > > Obviously the function name is wrong, but a varient of
> > > SYSCALL_DEFINE*() could be created so the proper function names are
> > > produced.
> > 
> > Right now none of the the generic compat_ functions is wrapped in
> > SYSCALL_DEFINE* because for some architectures a further wrapper function
> > is needed.  It seems some architectures call compat_ calls directly
> > without SYSCALL_DEFINE* which with CONFIG_FTRACE_SYSCALLS is a bug ...
> 
> Just checked some archs which have HAVE_SYSCALL_TRACEPOINTS=y and could
> call compat_* syscalls when run 32bit process on 64bit kernel, I don't
> find any special code against FTRACE_SYSCALLS. So that means we could
> not trace compat syscalls even if we want to(Am I missing something?).
> So I think if we want to trace it, the easy way is just like what we have
> done on normal syscalls, IOW, we could SYSCALL_DEFINE all of the compat
> syscalls.

Except the ones which call sys_* finally, :)

> 
> Thought?
> 
> BTW, I have make a trival patch to introduce COMPAT_SYSCALL_DEFINE, it's just
> for calling of inspiration(no test no build, and I leave SYSCALL_METADATA
> etc untouched.)
> 
> Thanks,
> Yong
> 
> ---
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 8c03b98..e79027f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -221,26 +221,38 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>  		__SC_STR_ADECL##x(__VA_ARGS__)			\
>  	};							\
>  	SYSCALL_METADATA(sname, x);				\
> -	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> +	__SYSCALL_DEFINEx(, x, sname, __VA_ARGS__)
> +
> +#define COMPAT_SYSCALL_DEFINEx(x, sname, ...)			\
> +	static const char *types_compat_##sname[] = {		\
> +		__SC_STR_TDECL##x(__VA_ARGS__)			\
> +	};							\
> +	static const char *args_compat_##sname[] = {		\
> +		__SC_STR_ADECL##x(__VA_ARGS__)			\
> +	};							\
> +	SYSCALL_METADATA(compat, sname, x);			\
> +	__SYSCALL_DEFINEx(cmopat_, x, sname, __VA_ARGS__)
>  #else
>  #define SYSCALL_DEFINEx(x, sname, ...)				\
> -	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> +	__SYSCALL_DEFINEx(, x, sname, __VA_ARGS__)
> +#define COMPAT_SYSCALL_DEFINEx(x, sname, ...)			\
> +	__SYSCALL_DEFINEx(compat_, x, sname, __VA_ARGS__)
>  #endif
>  
>  #ifdef CONFIG_HAVE_SYSCALL_WRAPPERS
>  
> -#define SYSCALL_DEFINE(name) static inline long SYSC_##name
> +#define SYSCALL_DEFINE(compat, name) static inline long compat##SYSC_##name
>  
> -#define __SYSCALL_DEFINEx(x, name, ...)					\
> -	asmlinkage long sys##name(__SC_DECL##x(__VA_ARGS__));		\
> -	static inline long SYSC##name(__SC_DECL##x(__VA_ARGS__));	\
> -	asmlinkage long SyS##name(__SC_LONG##x(__VA_ARGS__))		\
> +#define __SYSCALL_DEFINEx(compat, x, name, ...)				\
> +	asmlinkage long compat##sys##name(__SC_DECL##x(__VA_ARGS__));	\
> +	static inline long compat##SYSC##name(__SC_DECL##x(__VA_ARGS__));\
> +	asmlinkage long compat##SyS##name(__SC_LONG##x(__VA_ARGS__))	\
>  	{								\
>  		__SC_TEST##x(__VA_ARGS__);				\
> -		return (long) SYSC##name(__SC_CAST##x(__VA_ARGS__));	\
> +		return (long) compat##SYSC##name(__SC_CAST##x(__VA_ARGS__));\
>  	}								\
> -	SYSCALL_ALIAS(sys##name, SyS##name);				\
> -	static inline long SYSC##name(__SC_DECL##x(__VA_ARGS__))
> +	SYSCALL_ALIAS(compat##sys##name, compat##SyS##name);		\
> +	static inline long compat##SYSC##name(__SC_DECL##x(__VA_ARGS__))
>  
>  #else /* CONFIG_HAVE_SYSCALL_WRAPPERS */
>  
