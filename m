Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2011 04:44:40 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:53492 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490968Ab1HRCof (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2011 04:44:35 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7I2iQxJ000765
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 17 Aug 2011 19:44:26 -0700 (PDT)
Received: from localhost (128.224.158.133) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 17 Aug
 2011 19:44:26 -0700
Date:   Thu, 18 Aug 2011 10:44:22 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     David Daney <david.daney@cavium.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: use 32-bit wrapper for compat_sys_futex
Message-ID: <20110818024422.GB3750@windriver.com>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1313546094-11882-1-git-send-email-yong.zhang@windriver.com>
 <4E4BF7C0.80703@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4E4BF7C0.80703@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.158.133]
X-archive-position: 30891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12930

On Wed, Aug 17, 2011 at 10:17:52AM -0700, David Daney wrote:
> >  	PTR	compat_sys_sched_setaffinity
> >  	PTR	compat_sys_sched_getaffinity	/* 4240 */
> >  	PTR	compat_sys_io_setup
> 
> But really I think this patch fixes things at the wrong level.  Each
> architecture potentially needs a similar patch.  What would happen if
> we did something like:

I have thought about it but finally I decide to keep it under arch code;
because sparc64 and s390 have the same issue and they all smooth the
concern by themselves.

For sparc64:
arch/sparc/kernel/sys32.S:
91: SIGN3(sys32_futex, compat_sys_futex, %o1, %o2, %o5)

For s390:
arch/s390/kernel/compat_wrapper.S
ENTRY(compat_sys_futex_wrapper)
        llgtr   %r2,%r2                 # u32 *
	lgfr    %r3,%r3                 # int
	lgfr    %r4,%r4                 # int
	llgtr   %r5,%r5                 # struct compat_timespec *
	llgtr   %r6,%r6                 # u32 *
	lgf     %r0,164(%r15)           # int
	stg     %r0,160(%r15)
	jg	compat_sys_futex	# branch to system call

Maybe we can consolidate all of this like your patch in the future,
but it's a different issue.

Thanks,
Yong

> 
> 
> diff --git a/kernel/futex_compat.c b/kernel/futex_compat.c
> index 5f9e689..74ada65 100644
> --- a/kernel/futex_compat.c
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
> 
> David Daney
