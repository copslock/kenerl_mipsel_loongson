Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 22:54:53 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:52704 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860076AbaG2Uyf7QBVP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 22:54:35 +0200
Received: by mail-lb0-f169.google.com with SMTP id s7so180306lbd.28
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2014 13:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zyyh5zEyWJyIBDUrHdZ7OARPEQKp1mHgryoWHUtrly0=;
        b=PrANX36HHsgLjbelW0mEGtzeJbQ56i0iglrAkkGjvG/M+aZdT14W1x3S0jc5/oPR8V
         8XVDFdrVYM+apulHSj62MzDlr4lr+nSbVPYw2tmFDhwIeag749dAZKRD9Jl8RYOO95E6
         f8kz97A81k4+AjAc5qgIJ3P/TilVRkdeTWaknt9g8xsyZN1DBg+jS32LjOWJdVNdY3D3
         KTqRQ7H6tvYdyGZxgqBTbZiJR3S81NSiSAkb/SF1cKo7+ESQRal3PwdrpRTkDdJjGn8q
         EEnxPR+K7Wzaqbm/vYVK83P7k9vHb579t/kpJL8RG5/FPehNRgMgwZlM4ytvIE6yVXms
         QJXg==
X-Gm-Message-State: ALoCoQmcEUB6rNtHaqslDPMFV6V+0aoQ3evpXE60rfyBHygDqPs1ZTiEYSqMlNcXgb+wDl6DsMS8
X-Received: by 10.112.2.167 with SMTP id 7mr4610836lbv.103.1406667270257; Tue,
 29 Jul 2014 13:54:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 29 Jul 2014 13:54:10 -0700 (PDT)
In-Reply-To: <20140729192056.GA6308@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <20140729192056.GA6308@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 29 Jul 2014 13:54:10 -0700
Message-ID: <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp fastpath
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Jul 29, 2014 12:22 PM, "Oleg Nesterov" <oleg@redhat.com> wrote:
>
> Andy, to avoid the confusion: I am not trying to review this changes.
> As you probably know my understanding of asm code in entry.S is very
> limited.
>
> Just a couple of questions to ensure I understand this correctly.
>
> On 07/28, Andy Lutomirski wrote:
> >
> > This is both a cleanup and a speedup.  It reduces overhead due to
> > installing a trivial seccomp filter by 87%.  The speedup comes from
> > avoiding the full syscall tracing mechanism for filters that don't
> > return SECCOMP_RET_TRACE.
>
> And only after I look at 5/5 I _seem_ to actually understand where
> this speedup comes from.
>
> So. Currently tracesys: path always lead to "iret" after syscall, with
> this change we can avoid it if phase_1() returns zero, correct?
>
> And, this also removes the special TIF_SYSCALL_AUDIT-only case in entry.S,
> cool.
>
> I am wondering if we can do something similar with do_notify_resume() ?
>
>
> Stupid question. To simplify, lets forget that syscall_trace_enter()
> already returns the value. Can't we simplify the asm code if we do
> not export 2 functions, but make syscall_trace_enter() return
> "bool slow_path_is_needed". So that "tracesys:" could do
>
>         // pseudo code
>
> tracesys:
>         SAVE_REST
>         FIXUP_TOP_OF_STACK
>
>         call syscall_trace_enter
>
>         if (!slow_path_is_needed) {
>                 addq REST_SKIP, %rsp
>                 jmp system_call_fastpath
>         }
>
>         ...
>
> ?
>
> Once again, I am just curious, it is not that I actually suggest to consider
> this option.

We could, but this would lose a decent amount of the speedup.  I could
try it and benchmark it, but I'm guessing that the save and restore is
kind of expensive.  This will make audit slower than it currently is,
which may also annoy some people.  (Not me.)

I'm also not convinced that it would be much simpler.  My code is currently:

tracesys:
    leaq -REST_SKIP(%rsp), %rdi
    movq $AUDIT_ARCH_X86_64, %rsi
    call syscall_trace_enter_phase1
    test %rax, %rax
    jnz tracesys_phase2        /* if needed, run the slow path */
    LOAD_ARGS 0            /* else restore clobbered regs */
    jmp system_call_fastpath    /*      and return to the fast path */

tracesys_phase2:
    SAVE_REST
    FIXUP_TOP_OF_STACK %rdi
    movq %rsp, %rdi
    movq $AUDIT_ARCH_X86_64, %rsi
    movq %rax,%rdx
    call syscall_trace_enter_phase2

    LOAD_ARGS ARGOFFSET, 1
    RESTORE_REST

    ... slow path here ...

It would end up looking more like (totally untested):

tracesys:
    SAVE_REST
    FIXUP_TOP_OF_STACK %rdi
    mov %rsp, %rdi
    movq $AUDIT_ARCH_X86_64, %rsi
    call syscall_trace_enter
    LOAD_ARGS
    RESTORE_REST
    test [whatever condition]
    j[cond] system_call_fastpath

    ... slow path here ...

So it's a bit simpler.  Oddly, the ia32entry code doesn't have this
multiple syscall path distinction.

SAVE_REST is 6 movq instructions and a subq.  FIXUP_TOP_OF_STACK is 7
movqs (and 8 if I ever get my way).  RESTORE_TOP_OF_STACK is 4.
RESTORE_REST is 6 movqs and an adsq.  So we're talking about avoiding
21 movqs, and addq, and a subq.  That may be significant.  (And I
suspect that the difference is much larger on platforms like arm64,
but that's a separate issue.)
