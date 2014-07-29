Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 01:31:32 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:63937 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859953AbaG2XbYA0gRB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 01:31:24 +0200
Received: by mail-la0-f53.google.com with SMTP id gl10so296239lab.12
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2014 16:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2GgWKiSN83gi/V87yHrTYBIWYUXjJMO5SNAug2opk0Q=;
        b=b2/7KvRVmRn6G/eUOtgS+4m16E8k9ecpYYj7wpcqrraxDGL5UAwCsM+lDSndTgsagF
         4U/IiXfLvPZYBlNz9zjW7F1t7/hxjvrnsL+XmnriMFx0tkF8bqw+V3gYysVHj4fgYenO
         45dNoFrfsz9Umy8aafRhWubSrYN9DTWFHHyJiZ5bPKCi6CjD1rBoXjldZDMuX+d3hqiU
         oisEmQ/Ut6bpCvt4PYigzMsbu2WvRsHVPITb5U4+aUyj7+lrVk7ClIeW2q5KlVV9KD92
         dwc3bUPO/wBF2pQvJT41HSsvFrDWMSEs2cuW9gP8tZXLE/fgrfBaOXPzBzDTbSXWrFHH
         EoWQ==
X-Gm-Message-State: ALoCoQms2TmI5QnjOFYfI4hCFa5P17rgZemzywx/x9erol9uuoKyi5/9pmLiI6ClX+nhBAMXgU4x
X-Received: by 10.152.179.137 with SMTP id dg9mr254202lac.11.1406676678327;
 Tue, 29 Jul 2014 16:31:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 29 Jul 2014 16:30:58 -0700 (PDT)
In-Reply-To: <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
References: <cover.1406604806.git.luto@amacapital.net> <20140729192056.GA6308@redhat.com>
 <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 29 Jul 2014 16:30:58 -0700
Message-ID: <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
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
X-archive-position: 41802
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

On Tue, Jul 29, 2014 at 1:54 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Jul 29, 2014 12:22 PM, "Oleg Nesterov" <oleg@redhat.com> wrote:
>>
>> Andy, to avoid the confusion: I am not trying to review this changes.
>> As you probably know my understanding of asm code in entry.S is very
>> limited.
>>
>> Just a couple of questions to ensure I understand this correctly.
>>
>> On 07/28, Andy Lutomirski wrote:
>> >
>> > This is both a cleanup and a speedup.  It reduces overhead due to
>> > installing a trivial seccomp filter by 87%.  The speedup comes from
>> > avoiding the full syscall tracing mechanism for filters that don't
>> > return SECCOMP_RET_TRACE.
>>
>> And only after I look at 5/5 I _seem_ to actually understand where
>> this speedup comes from.
>>
>> So. Currently tracesys: path always lead to "iret" after syscall, with
>> this change we can avoid it if phase_1() returns zero, correct?
>>
>> And, this also removes the special TIF_SYSCALL_AUDIT-only case in entry.S,
>> cool.
>>
>> I am wondering if we can do something similar with do_notify_resume() ?
>>
>>
>> Stupid question. To simplify, lets forget that syscall_trace_enter()
>> already returns the value. Can't we simplify the asm code if we do
>> not export 2 functions, but make syscall_trace_enter() return
>> "bool slow_path_is_needed". So that "tracesys:" could do
>>
>>         // pseudo code
>>
>> tracesys:
>>         SAVE_REST
>>         FIXUP_TOP_OF_STACK
>>
>>         call syscall_trace_enter
>>
>>         if (!slow_path_is_needed) {
>>                 addq REST_SKIP, %rsp
>>                 jmp system_call_fastpath
>>         }
>>
>>         ...
>>
>> ?
>>
>> Once again, I am just curious, it is not that I actually suggest to consider
>> this option.
>
> We could, but this would lose a decent amount of the speedup.  I could
> try it and benchmark it, but I'm guessing that the save and restore is
> kind of expensive.  This will make audit slower than it currently is,
> which may also annoy some people.  (Not me.)
>
> I'm also not convinced that it would be much simpler.  My code is currently:
>
> tracesys:
>     leaq -REST_SKIP(%rsp), %rdi
>     movq $AUDIT_ARCH_X86_64, %rsi
>     call syscall_trace_enter_phase1
>     test %rax, %rax
>     jnz tracesys_phase2        /* if needed, run the slow path */
>     LOAD_ARGS 0            /* else restore clobbered regs */
>     jmp system_call_fastpath    /*      and return to the fast path */
>
> tracesys_phase2:
>     SAVE_REST
>     FIXUP_TOP_OF_STACK %rdi
>     movq %rsp, %rdi
>     movq $AUDIT_ARCH_X86_64, %rsi
>     movq %rax,%rdx
>     call syscall_trace_enter_phase2
>
>     LOAD_ARGS ARGOFFSET, 1
>     RESTORE_REST
>
>     ... slow path here ...
>
> It would end up looking more like (totally untested):
>
> tracesys:
>     SAVE_REST
>     FIXUP_TOP_OF_STACK %rdi
>     mov %rsp, %rdi
>     movq $AUDIT_ARCH_X86_64, %rsi
>     call syscall_trace_enter
>     LOAD_ARGS
>     RESTORE_REST
>     test [whatever condition]
>     j[cond] system_call_fastpath
>
>     ... slow path here ...
>
> So it's a bit simpler.  Oddly, the ia32entry code doesn't have this
> multiple syscall path distinction.
>
> SAVE_REST is 6 movq instructions and a subq.  FIXUP_TOP_OF_STACK is 7
> movqs (and 8 if I ever get my way).  RESTORE_TOP_OF_STACK is 4.
> RESTORE_REST is 6 movqs and an adsq.  So we're talking about avoiding
> 21 movqs, and addq, and a subq.  That may be significant.  (And I
> suspect that the difference is much larger on platforms like arm64,
> but that's a separate issue.)

To put some more options on the table: there's an argument to be made
that the whole fast-path/slow-path split isn't worth it.  We could
unconditionally set up a full frame for all syscalls.  This means:

No FIXUP_TOP_OF_STACK.  Instead, the system_call entry sets up RSP,
SS, CS, RCX, and EFLAGS right away.  That's five stores for all
syscalls instead of two loads and five stores for syscalls that need
it.  But it also gets rid of RESTORE_TOP_OF_STACK completely.

No more bugs involving C code that assumes a full stack frame when no
such frame exists inside syscall code.

We could possibly remove a whole bunch of duplicated code.

The upshot would be simpler code, faster slow-path syscalls, and
slower fast-path syscalls (but probably not much slower).  On the
other hand, there's zero chance that this would be ready for 3.17.

I'd tend to advocate for keeping the approach in my patches for now.
It's probably a smaller assembly diff than any of the other options --
the split between fast-path, slower fast-path, and slow-path already
exists due to the audit crap.  If we end up making more radical
changes later, then at worst we end up reverting part of the change to
ptrace.c.

--Andy
