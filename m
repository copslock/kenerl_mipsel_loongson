Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 23:29:28 +0200 (CEST)
Received: from mail-qc0-f175.google.com ([209.85.216.175]:35313 "EHLO
        mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843059AbaFKV30dppGB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 23:29:26 +0200
Received: by mail-qc0-f175.google.com with SMTP id i8so597642qcq.20
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7kthtXtFvf9ErELEW2yMVdCJLXwAmtgf+56ZlX2+AGM=;
        b=r2J3zAAUHqUOzotMhREwOC1moVogRvwED6oDjDdSXSNu7nwVkrwAz/pXV/PW/S1nXu
         3RbbRuBGf/Iw5tJBeu2fP8iA0sSlPYZ9BlYLHFtXrLj9zWUiDnXpYYeKpuu0yGtIZ3Iu
         ALJCnQNYqCsb4XZwTqtQXQuB6GAt9LNLTWkUMSl9krewXeflGYrOj6IbSOYily2kZlcM
         d3+X9f1YAiG8Myxn/jHoHz/1PEf7YI8J3M/cCJLf135uaJTyqHoGjLPoTrCN/tH3Vx6L
         7WtXiSStfjsBdYpD/Qr74+uIG73u1o8xYv1is7zQFIyA5YXAQWVNQ735UkFiXKacxNY3
         86GQ==
MIME-Version: 1.0
X-Received: by 10.140.94.39 with SMTP id f36mr53913401qge.64.1402522160227;
 Wed, 11 Jun 2014 14:29:20 -0700 (PDT)
Received: by 10.96.134.74 with HTTP; Wed, 11 Jun 2014 14:29:20 -0700 (PDT)
In-Reply-To: <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
        <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
Date:   Wed, 11 Jun 2014 14:29:20 -0700
Message-ID: <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Wed, Jun 11, 2014 at 1:23 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On my VM, getpid takes about 70ns.  Before this patch, adding a
> single-instruction always-accept seccomp filter added about 134ns of
> overhead to getpid.  With this patch, the overhead is down to about
> 13ns.

interesting.
Is this the gain from patch 4 into patch 5 or from patch 0 to patch 5?
13ns is still with seccomp enabled, but without filters?

> I'm not really thrilled by this patch.  It has two main issues:
>
> 1. Calling into code in kernel/seccomp.c from assembly feels ugly.
>
> 2. The x86 64-bit syscall entry now has four separate code paths:
> fast, seccomp only, audit only, and slow.  This kind of sucks.
> Would it be worth trying to rewrite the whole thing in C with a
> two-phase slow path approach like I'm using here for seccomp?
>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---
>  arch/x86/kernel/entry_64.S | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/seccomp.h    |  4 ++--
>  2 files changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
> index f9e713a..feb32b2 100644
> --- a/arch/x86/kernel/entry_64.S
> +++ b/arch/x86/kernel/entry_64.S
> @@ -683,6 +683,45 @@ sysret_signal:
>         FIXUP_TOP_OF_STACK %r11, -ARGOFFSET
>         jmp int_check_syscall_exit_work
>
> +#ifdef CONFIG_SECCOMP
> +       /*
> +        * Fast path for seccomp without any other slow path triggers.
> +        */
> +seccomp_fastpath:
> +       /* Build seccomp_data */
> +       pushq %r9                               /* args[5] */
> +       pushq %r8                               /* args[4] */
> +       pushq %r10                              /* args[3] */
> +       pushq %rdx                              /* args[2] */
> +       pushq %rsi                              /* args[1] */
> +       pushq %rdi                              /* args[0] */
> +       pushq RIP-ARGOFFSET+6*8(%rsp)           /* rip */
> +       pushq %rax                              /* nr and junk */
> +       movl $AUDIT_ARCH_X86_64, 4(%rsp)        /* arch */
> +       movq %rsp, %rdi
> +       call seccomp_phase1

the assembler code is pretty much repeating what C does in
populate_seccomp_data(). Assuming the whole gain came from
patch 5 why asm version is so much faster than C?
it skips SAVE/RESTORE_REST... what else?
If the most of the gain is from all patches combined (mainly from
2 phase approach) then why bother with asm?

Somehow it feels that the gain is due to better branch prediction
in asm version. If you change few 'unlikely' in C to 'likely', it may
get to the same performance...

btw patches #1-3 look good to me. especially #1 is nice.

> +       addq $8*8, %rsp
> +       cmpq $1, %rax
> +       ja seccomp_invoke_phase2
> +       LOAD_ARGS 0  /* restore clobbered regs */
> +       jb system_call_fastpath
> +       jmp ret_from_sys_call
> +
> +seccomp_invoke_phase2:
> +       SAVE_REST
> +       FIXUP_TOP_OF_STACK %rdi
> +       movq %rax,%rdi
> +       call seccomp_phase2
> +
> +       /* if seccomp says to skip, then set orig_ax to -1 and skip */
> +       test %eax,%eax
> +       jz 1f
> +       movq $-1, ORIG_RAX(%rsp)
> +1:
> +       mov ORIG_RAX(%rsp), %rax                /* reload rax */
> +       jmp system_call_post_trace              /* and maybe do the syscall */
> +#endif
> +
>  #ifdef CONFIG_AUDITSYSCALL
>         /*
>          * Fast path for syscall audit without full syscall trace.
> @@ -717,6 +756,10 @@ sysret_audit:
>
>         /* Do syscall tracing */
>  tracesys:
> +#ifdef CONFIG_SECCOMP
> +       testl $(_TIF_WORK_SYSCALL_ENTRY & ~_TIF_SECCOMP),TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
> +       jz seccomp_fastpath
> +#endif
>  #ifdef CONFIG_AUDITSYSCALL
>         testl $(_TIF_WORK_SYSCALL_ENTRY & ~_TIF_SYSCALL_AUDIT),TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
>         jz auditsys
> @@ -725,6 +768,8 @@ tracesys:
>         FIXUP_TOP_OF_STACK %rdi
>         movq %rsp,%rdi
>         call syscall_trace_enter
> +
> +system_call_post_trace:
>         /*
>          * Reload arg registers from stack in case ptrace changed them.
>          * We don't reload %rax because syscall_trace_enter() returned
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 4fc7a84..d3d4c52 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -37,8 +37,8 @@ static inline int secure_computing(void)
>  #define SECCOMP_PHASE1_OK      0
>  #define SECCOMP_PHASE1_SKIP    1
>
> -extern u32 seccomp_phase1(struct seccomp_data *sd);
> -int seccomp_phase2(u32 phase1_result);
> +asmlinkage __visible extern u32 seccomp_phase1(struct seccomp_data *sd);
> +asmlinkage __visible int seccomp_phase2(u32 phase1_result);
>  #else
>  extern void secure_computing_strict(int this_syscall);
>  #endif
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
