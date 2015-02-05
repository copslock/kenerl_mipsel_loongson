Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 00:12:48 +0100 (CET)
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58981 "EHLO
        mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012109AbbBEXMpnAwoc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 00:12:45 +0100
Received: by mail-qa0-f46.google.com with SMTP id j7so8273352qaq.5
        for <linux-mips@linux-mips.org>; Thu, 05 Feb 2015 15:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BiKMOUP/LEEUFvVlMeHcdOymts6Q+l6uqMYHQ3ginUw=;
        b=JcgqbPXwngaVcklIfxx1CdnvrzLhmuklsRKHED6px2uvqqHXx3mtSgY4bTiGqhK9dA
         lvotbfi7hmjugfRLZIcNJANVWjMxxeeiqQzMzb8geJZDVYzQM9ZwmWjOAU/Abygn9ZDz
         AMrQ64ipTZe9uWMlrJHeS3NpqbvdMVLIP3ZHtiF9ainMKPVisBCCf+TB4EHJxYBMtexo
         B5XoJG3r00yVLcCP5xuSSon7ULPsQyw6V0JgYObOYNZphP9tIKGJeDEdTxUPD1NofjRw
         OzdhRDCBFEfVjgl1TJCRlJgsEYlJuIBKLhTbNoUqRCWwZ1baVrXZlq4K9Vi6/bXe1a0s
         1YAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BiKMOUP/LEEUFvVlMeHcdOymts6Q+l6uqMYHQ3ginUw=;
        b=b1fcccghxy/HQ2WD68imYGA2WeE/olK+bT/kHaoFYpMMzqU8hBtWS/fyR3tgQZjEZR
         lPQMX2895jEJmMrbAAhFpU8DGiDhRJp1Ss38pFuIpe0nrmOEWX8yAmcszrrrtMr1YIXc
         pzg/u/jOrmKgn6fFPiFubfkUsEth2TxGOJgyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BiKMOUP/LEEUFvVlMeHcdOymts6Q+l6uqMYHQ3ginUw=;
        b=OfWmazaT61h+2D9lIt95rTHo6Ckdt3KONzXmjijSiQTQcxZPqYQcm0V/UK4SkGRAoz
         lvyQV4kpiNb4myvoBjzGZkr36l9BD/cPl3cO5yM31me46TiM+gMduy7U1UCHFzzs9vC6
         zaK4CaSggHO5Rzklcb5oxglLZIAyaA8gLwstfbNl3Catjb1FI168gziEynNWspl/ziiB
         DKBy/5Tj4fEK9nk15L4UoKL/+MFKRDiskfpSMbbMRLhyG5if4B9UdRNqWNap0m/b39L4
         aUA5J73rc+lQ8sKDZwAOM/Hk9ziQ98B8UCjacx7fOHQrtH7TyfnYR6U5h3BOXqWqZR7H
         oJgg==
X-Gm-Message-State: ALoCoQm4PPjaQmE+9W9ZzltpXuyZJOTV7oDTBxu49W66dt6X0xq4egses/0e/475Vjp4eDJJ7CVO
MIME-Version: 1.0
X-Received: by 10.224.151.140 with SMTP id c12mr1417489qaw.80.1423177959998;
 Thu, 05 Feb 2015 15:12:39 -0800 (PST)
Received: by 10.229.171.68 with HTTP; Thu, 5 Feb 2015 15:12:39 -0800 (PST)
In-Reply-To: <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
References: <cover.1409954077.git.luto@amacapital.net>
        <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
        <20150205211916.GA31367@altlinux.org>
        <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
        <20150205214027.GB31367@altlinux.org>
        <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
Date:   Thu, 5 Feb 2015 15:12:39 -0800
X-Google-Sender-Auth: JVffSCnszz84HpEMfO7YboO19Es
Message-ID: <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Thu, Feb 5, 2015 at 1:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Feb 5, 2015 at 1:40 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> On Thu, Feb 05, 2015 at 01:27:16PM -0800, Kees Cook wrote:
>>> On Thu, Feb 5, 2015 at 1:19 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>> > Hi,
>>> >
>>> > On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
>>> >> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
>>> >> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
>>> >> phase 2 is permitted to modify any of pt_regs except for orig_ax.
>>> >
>>> > This breaks ptrace, see below.
>>> >
>>> >> The intent is that phase 1 can be called from the syscall fast path.
>>> >>
>>> >> In this implementation, phase1 can handle any combination of
>>> >> TIF_NOHZ (RCU context tracking), TIF_SECCOMP, and TIF_SYSCALL_AUDIT,
>>> >> unless seccomp requests a ptrace event, in which case phase2 is
>>> >> forced.
>>> >>
>>> >> In principle, this could yield a big speedup for TIF_NOHZ as well as
>>> >> for TIF_SECCOMP if syscall exit work were similarly split up.
>>> >>
>>> >> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>>> >> ---
>>> >>  arch/x86/include/asm/ptrace.h |   5 ++
>>> >>  arch/x86/kernel/ptrace.c      | 157 +++++++++++++++++++++++++++++++++++-------
>>> >>  2 files changed, 138 insertions(+), 24 deletions(-)
>>> >>
>>> >> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
>>> >> index 6205f0c434db..86fc2bb82287 100644
>>> >> --- a/arch/x86/include/asm/ptrace.h
>>> >> +++ b/arch/x86/include/asm/ptrace.h
>>> >> @@ -75,6 +75,11 @@ convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
>>> >>  extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>>> >>                        int error_code, int si_code);
>>> >>
>>> >> +
>>> >> +extern unsigned long syscall_trace_enter_phase1(struct pt_regs *, u32 arch);
>>> >> +extern long syscall_trace_enter_phase2(struct pt_regs *, u32 arch,
>>> >> +                                    unsigned long phase1_result);
>>> >> +
>>> >>  extern long syscall_trace_enter(struct pt_regs *);
>>> >>  extern void syscall_trace_leave(struct pt_regs *);
>>> >>
>>> >> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
>>> >> index bbf338a04a5d..29576c244699 100644
>>> >> --- a/arch/x86/kernel/ptrace.c
>>> >> +++ b/arch/x86/kernel/ptrace.c
>>> >> @@ -1441,20 +1441,126 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>>> >>       force_sig_info(SIGTRAP, &info, tsk);
>>> >>  }
>>> >>
>>> >> +static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
>>> >> +{
>>> >> +#ifdef CONFIG_X86_64
>>> >> +     if (arch == AUDIT_ARCH_X86_64) {
>>> >> +             audit_syscall_entry(arch, regs->orig_ax, regs->di,
>>> >> +                                 regs->si, regs->dx, regs->r10);
>>> >> +     } else
>>> >> +#endif
>>> >> +     {
>>> >> +             audit_syscall_entry(arch, regs->orig_ax, regs->bx,
>>> >> +                                 regs->cx, regs->dx, regs->si);
>>> >> +     }
>>> >> +}
>>> >> +
>>> >>  /*
>>> >> - * We must return the syscall number to actually look up in the table.
>>> >> - * This can be -1L to skip running any syscall at all.
>>> >> + * We can return 0 to resume the syscall or anything else to go to phase
>>> >> + * 2.  If we resume the syscall, we need to put something appropriate in
>>> >> + * regs->orig_ax.
>>> >> + *
>>> >> + * NB: We don't have full pt_regs here, but regs->orig_ax and regs->ax
>>> >> + * are fully functional.
>>> >> + *
>>> >> + * For phase 2's benefit, our return value is:
>>> >> + * 0:                        resume the syscall
>>> >> + * 1:                        go to phase 2; no seccomp phase 2 needed
>>> >> + * anything else:    go to phase 2; pass return value to seccomp
>>> >>   */
>>> >> -long syscall_trace_enter(struct pt_regs *regs)
>>> >> +unsigned long syscall_trace_enter_phase1(struct pt_regs *regs, u32 arch)
>>> >>  {
>>> >> -     long ret = 0;
>>> >> +     unsigned long ret = 0;
>>> >> +     u32 work;
>>> >> +
>>> >> +     BUG_ON(regs != task_pt_regs(current));
>>> >> +
>>> >> +     work = ACCESS_ONCE(current_thread_info()->flags) &
>>> >> +             _TIF_WORK_SYSCALL_ENTRY;
>>> >>
>>> >>       /*
>>> >>        * If TIF_NOHZ is set, we are required to call user_exit() before
>>> >>        * doing anything that could touch RCU.
>>> >>        */
>>> >> -     if (test_thread_flag(TIF_NOHZ))
>>> >> +     if (work & _TIF_NOHZ) {
>>> >>               user_exit();
>>> >> +             work &= ~TIF_NOHZ;
>>> >> +     }
>>> >> +
>>> >> +#ifdef CONFIG_SECCOMP
>>> >> +     /*
>>> >> +      * Do seccomp first -- it should minimize exposure of other
>>> >> +      * code, and keeping seccomp fast is probably more valuable
>>> >> +      * than the rest of this.
>>> >> +      */
>>> >> +     if (work & _TIF_SECCOMP) {
>>> >> +             struct seccomp_data sd;
>>> >> +
>>> >> +             sd.arch = arch;
>>> >> +             sd.nr = regs->orig_ax;
>>> >> +             sd.instruction_pointer = regs->ip;
>>> >> +#ifdef CONFIG_X86_64
>>> >> +             if (arch == AUDIT_ARCH_X86_64) {
>>> >> +                     sd.args[0] = regs->di;
>>> >> +                     sd.args[1] = regs->si;
>>> >> +                     sd.args[2] = regs->dx;
>>> >> +                     sd.args[3] = regs->r10;
>>> >> +                     sd.args[4] = regs->r8;
>>> >> +                     sd.args[5] = regs->r9;
>>> >> +             } else
>>> >> +#endif
>>> >> +             {
>>> >> +                     sd.args[0] = regs->bx;
>>> >> +                     sd.args[1] = regs->cx;
>>> >> +                     sd.args[2] = regs->dx;
>>> >> +                     sd.args[3] = regs->si;
>>> >> +                     sd.args[4] = regs->di;
>>> >> +                     sd.args[5] = regs->bp;
>>> >> +             }
>>> >> +
>>> >> +             BUILD_BUG_ON(SECCOMP_PHASE1_OK != 0);
>>> >> +             BUILD_BUG_ON(SECCOMP_PHASE1_SKIP != 1);
>>> >> +
>>> >> +             ret = seccomp_phase1(&sd);
>>> >> +             if (ret == SECCOMP_PHASE1_SKIP) {
>>> >> +                     regs->orig_ax = -1;
>>> >
>>> > How the tracer is expected to get the correct syscall number after that?
>>>
>>> There shouldn't be a tracer if a skip is encountered. (A seccomp skip
>>> would skip ptrace.) This behavior hasn't changed, but maybe I don't
>>> see what you mean? (I haven't encountered any problems with syscall
>>> tracing as a result of these changes.)
>>
>> SECCOMP_RET_ERRNO leads to SECCOMP_PHASE1_SKIP, and if there is a tracer,
>> it will get -1 as a syscall number.
>>
>> I've found this while testing a strace parser for
>> SECCOMP_MODE_FILTER/SECCOMP_SET_MODE_FILTER, so the problem is quite real.
>>
>>
>
> Hasn't it always been this way?

As far as I know, yes, it's always been this way. The point is to the
skip the syscall, which is what the -1 signals. Userspace then reads
back the errno.

> I admit that I kind of wish this worked the other way -- that is, I
> think it would be nice to have a mode in which ptrace runs before
> seccomp, which would close the ptrace hole (where ptrace can do things
> that seccomp would disallow) and maybe have more comprehensible
> results.

I prefer keeping the seccomp attack surface as tiny as possible. I
would not like to ptrace happening before seccomp.

-Kees

-- 
Kees Cook
Chrome OS Security
