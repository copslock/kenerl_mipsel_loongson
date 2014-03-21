Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 20:13:21 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:35319 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826484AbaCUTNSXmrRM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Mar 2014 20:13:18 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2LJDAYv013805
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 21 Mar 2014 15:13:10 -0400
Received: from madcap2.tricolour.ca (vpn-59-180.rdu2.redhat.com [10.10.59.180])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s2LJD510013148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 21 Mar 2014 15:13:07 -0400
Date:   Fri, 21 Mar 2014 15:13:05 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux@openrisc.net,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] ARCH: AUDIT: implement syscall_get_arch for all
 arches
Message-ID: <20140321191305.GE16467@madcap2.tricolour.ca>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
 <1395266643-3139-3-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1395266643-3139-3-git-send-email-eparis@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <rgb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rgb@redhat.com
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

On 14/03/19, Eric Paris wrote:
> For all arches which support audit implement syscall_get_arch()
> They are all pretty easy and straight forward, stolen from how the call
> to audit_syscall_entry() determines the arch.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: microblaze-uclinux@itee.uq.edu.au
> Cc: linux-mips@linux-mips.org
> Cc: linux@lists.openrisc.net
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  arch/ia64/include/asm/syscall.h       |  6 ++++++
>  arch/microblaze/include/asm/syscall.h |  5 +++++
>  arch/mips/include/asm/syscall.h       |  2 +-
>  arch/openrisc/include/asm/syscall.h   |  5 +++++
>  arch/parisc/include/asm/syscall.h     | 11 +++++++++++
>  arch/powerpc/include/asm/syscall.h    | 12 ++++++++++++
>  arch/sparc/include/asm/syscall.h      |  8 ++++++++
>  include/uapi/linux/audit.h            |  1 +
>  8 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
> index a7ff1c6..1d0b875 100644
> --- a/arch/ia64/include/asm/syscall.h
> +++ b/arch/ia64/include/asm/syscall.h
> @@ -13,6 +13,7 @@
>  #ifndef _ASM_SYSCALL_H
>  #define _ASM_SYSCALL_H	1
>  
> +#include <uapi/linux/audit.h>
>  #include <linux/sched.h>
>  #include <linux/err.h>
>  
> @@ -79,4 +80,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  
>  	ia64_syscall_get_set_arguments(task, regs, i, n, args, 1);
>  }
> +
> +static inline int syscall_get_arch(void)
> +{
> +	return AUDIT_ARCH_IA64;
> +}
>  #endif	/* _ASM_SYSCALL_H */
> diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
> index 9bc4317..53cfaf3 100644
> --- a/arch/microblaze/include/asm/syscall.h
> +++ b/arch/microblaze/include/asm/syscall.h
> @@ -1,6 +1,7 @@
>  #ifndef __ASM_MICROBLAZE_SYSCALL_H
>  #define __ASM_MICROBLAZE_SYSCALL_H
>  
> +#include <uapi/linux/audit.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <asm/ptrace.h>
> @@ -99,4 +100,8 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  asmlinkage long do_syscall_trace_enter(struct pt_regs *regs);
>  asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
>  
> +static inline int syscall_get_arch(void)
> +{
> +	return AUDIT_ARCH_MICROBLAZE;
> +}
>  #endif /* __ASM_MICROBLAZE_SYSCALL_H */
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index fc556d8..992b6ab 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -103,7 +103,7 @@ extern const unsigned long sysn32_call_table[];
>  
>  static inline int syscall_get_arch(void)
>  {
> -	int arch = EM_MIPS;
> +	int arch = AUDIT_ARCH_MIPS;
>  #ifdef CONFIG_64BIT
>  	arch |=  __AUDIT_ARCH_64BIT;
>  #endif
> diff --git a/arch/openrisc/include/asm/syscall.h b/arch/openrisc/include/asm/syscall.h
> index b752bb6..2db9f1c 100644
> --- a/arch/openrisc/include/asm/syscall.h
> +++ b/arch/openrisc/include/asm/syscall.h
> @@ -19,6 +19,7 @@
>  #ifndef __ASM_OPENRISC_SYSCALL_H__
>  #define __ASM_OPENRISC_SYSCALL_H__
>  
> +#include <uapi/linux/audit.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  
> @@ -71,4 +72,8 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
>  	memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
>  }
>  
> +static inline int syscall_get_arch(void)
> +{
> +	return AUDIT_ARCH_OPENRISC;
> +}
>  #endif
> diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
> index 8bdfd2c..a5eba95 100644
> --- a/arch/parisc/include/asm/syscall.h
> +++ b/arch/parisc/include/asm/syscall.h
> @@ -3,6 +3,8 @@
>  #ifndef _ASM_PARISC_SYSCALL_H_
>  #define _ASM_PARISC_SYSCALL_H_
>  
> +#include <uapi/linux/audit.h>
> +#include <linux/compat.h>
>  #include <linux/err.h>
>  #include <asm/ptrace.h>
>  
> @@ -37,4 +39,13 @@ static inline void syscall_get_arguments(struct task_struct *tsk,
>  	}
>  }
>  
> +static inline int syscall_get_arch(void)
> +{
> +	int arch = AUDIT_ARCH_PARISC;
> +#ifdef CONFIG_64BIT
> +	if (!is_compat_task())
> +		arch = AUDIT_ARCH_PARISC64;
> +#endif
> +	return arch;
> +}
>  #endif /*_ASM_PARISC_SYSCALL_H_*/
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index b54b2ad..4271544 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -13,6 +13,8 @@
>  #ifndef _ASM_SYSCALL_H
>  #define _ASM_SYSCALL_H	1
>  
> +#include <uapi/linux/audit.h>
> +#include <linux/compat.h>
>  #include <linux/sched.h>
>  
>  /* ftrace syscalls requires exporting the sys_call_table */
> @@ -86,4 +88,14 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  	memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
>  }
>  
> +static inline int syscall_get_arch(void)
> +{
> +	int arch = AUDIT_ARCH_PPC;
> +
> +#ifdef CONFIG_PPC64
> +	if (!is_32bit_task())
> +		arch = AUDIT_ARCH_PPC64;
> +#endif
> +	return arch;
> +}
>  #endif	/* _ASM_SYSCALL_H */
> diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
> index 025a02a..fed3d51 100644
> --- a/arch/sparc/include/asm/syscall.h
> +++ b/arch/sparc/include/asm/syscall.h
> @@ -1,9 +1,11 @@
>  #ifndef __ASM_SPARC_SYSCALL_H
>  #define __ASM_SPARC_SYSCALL_H
>  
> +#include <uapi/linux/audit.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <asm/ptrace.h>
> +#include <asm/thread_info.h>
>  
>  /*
>   * The syscall table always contains 32 bit pointers since we know that the
> @@ -124,4 +126,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  		regs->u_regs[UREG_I0 + i + j] = args[j];
>  }
>  
> +static inline int syscall_get_arch(void)
> +{
> +	return test_thread_flag(TIF_32BIT) ? AUDIT_ARCH_SPARC
> +					   : AUDIT_ARCH_SPARC64;
> +}
> +
>  #endif /* __ASM_SPARC_SYSCALL_H */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 9af01d7..8496cfa 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -343,6 +343,7 @@ enum {
>  #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_M32R		(EM_M32R)
>  #define AUDIT_ARCH_M68K		(EM_68K)
> +#define AUDIT_ARCH_MICROBLAZE	(EM_MICROBLAZE)
>  #define AUDIT_ARCH_MIPS		(EM_MIPS)
>  #define AUDIT_ARCH_MIPSEL	(EM_MIPS|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_MIPS64	(EM_MIPS|__AUDIT_ARCH_64BIT)
> -- 
> 1.8.5.3
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
