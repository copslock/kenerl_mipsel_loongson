Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 19:22:07 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:11962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491094Ab1FGRWB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Jun 2011 19:22:01 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p57HLW5l005836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 7 Jun 2011 13:21:32 -0400
Received: from tranklukator.englab.brq.redhat.com (dhcp-1-166.brq.redhat.com [10.34.1.166])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id p57HLMQo021360;
        Tue, 7 Jun 2011 13:21:22 -0400
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue,  7 Jun 2011 19:20:02 +0200 (CEST)
Date:   Tue, 7 Jun 2011 19:19:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        richard@nod.at, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
        ptrace.h
Message-ID: <20110607171952.GA25729@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 30283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5940

On 06/03, Eric Paris wrote:
>
> The audit system previously expected arches calling to audit_syscall_exit to
> supply as arguments if the syscall was a success and what the return code was.
> Audit also provides a helper AUDITSC_RESULT which was supposed to simplify things
> by converting from negative retcodes to an audit internal magic value stating
> success or failure.  This helper was wrong and could indicate that a valid
> pointer returned to userspace was a failed syscall.  The fix is to fix the
> layering foolishness.  We now pass audit_syscall_exit a struct pt_reg and it
> in turns calls back into arch code to collect the return value and to
> determine if the syscall was a success or failure.  We also define a generic
> is_syscall_success() macro which determines success/failure based on if the
> value is < -MAX_ERRNO.  This works for arches like x86 which do not use a
> separate mechanism to indicate syscall failure.

I know nothing about audit, but the patch looks fine to me.


But I have a bit off-topic question,

> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
> index 8a445a0..b7b1f88 100644
> --- a/arch/x86/kernel/entry_64.S
> +++ b/arch/x86/kernel/entry_64.S
> @@ -53,6 +53,7 @@
>  #include <asm/paravirt.h>
>  #include <asm/ftrace.h>
>  #include <asm/percpu.h>
> +#include <linux/err.h>
>
>  /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
>  #include <linux/elf-em.h>
> @@ -564,17 +565,16 @@ auditsys:
>  	jmp system_call_fastpath
>
>  	/*
> -	 * Return fast path for syscall audit.  Call audit_syscall_exit()
> +	 * Return fast path for syscall audit.  Call __audit_syscall_exit()
>  	 * directly and then jump back to the fast path with TIF_SYSCALL_AUDIT
>  	 * masked off.
>  	 */
>  sysret_audit:
>  	movq RAX-ARGOFFSET(%rsp),%rsi	/* second arg, syscall return value */
> -	cmpq $0,%rsi		/* is it < 0? */
> -	setl %al		/* 1 if so, 0 if not */
> +	cmpq $-MAX_ERRNO,%rsi	/* is it < -MAX_ERRNO? */
> +	setbe %al		/* 1 if so, 0 if not */
>  	movzbl %al,%edi		/* zero-extend that into %edi */
> -	inc %edi /* first arg, 0->1(AUDITSC_SUCCESS), 1->2(AUDITSC_FAILURE) */
> -	call audit_syscall_exit
> +	call __audit_syscall_exit

With or without this patch, can't we call audit_syscall_exit() twice
if there is something else in _TIF_WORK_SYSCALL_EXIT mask apart from
SYSCALL_AUDIT ? First time it is called from asm, then from
syscall_trace_leave(), no?

For example. The task has TIF_SYSCALL_AUDIT and nothing else, it does
system_call->auditsys->system_call_fastpath. What if it gets, say,
TIF_SYSCALL_TRACE before ret_from_sys_call?

Oleg.
