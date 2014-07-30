Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 19:25:41 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34108 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856015AbaG3RZgDO5-n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 19:25:36 +0200
Received: by mail-lb0-f176.google.com with SMTP id u10so1151209lbd.35
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 10:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aUAkS+ypbiaGpRat+aMOrmSSjOt7CZlAAo93wztTZDI=;
        b=Pxv2GaiDCzqs3iSPyASxkAwaAXjVI3HVMGRrTySwVQ+2/3fPgk7DCn+mvfS2zSe4EX
         nU69ws5TRf3emxv1hl3fBug1pXJDeoQkeXl2R9xC0aL6xXbkT9ZGH7rQEuacEhJV/AGs
         65UA0z0UsCh0omo6PYzPEHfQ4dT5wsKfh4ZkcljkiY7oGeyzJQtK2QmxOifvt7UHu9qF
         +ve3yE5DrzJAstf1uhR1rSKN/3jqv/Sjfo/6pC/G28yU5qF/QILiHFYPucghV5BjUjqN
         9souhklukO+wSVeLJXTm7fWLElKHRh8IAAYfbkc0FuY090nMyKytHTvrrfplyewZWZPE
         P5Yw==
X-Gm-Message-State: ALoCoQnHs8HwlwPT4l8kIMM1sPMmtQTKVV4/Gw7hDAcInCdkoagzv9eWktyHpeub1/lkPmvtxua8
X-Received: by 10.152.5.133 with SMTP id s5mr5291211las.78.1406741130389; Wed,
 30 Jul 2014 10:25:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Wed, 30 Jul 2014 10:25:10 -0700 (PDT)
In-Reply-To: <20140730165940.GB27954@localhost.localdomain>
References: <cover.1406604806.git.luto@amacapital.net> <20140729192056.GA6308@redhat.com>
 <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
 <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com> <20140730165940.GB27954@localhost.localdomain>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 30 Jul 2014 10:25:10 -0700
Message-ID: <CALCETrUafpWfnbfZzgu3qSGqyxcG0+6A=A1RE8g++=GrQKD93Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp fastpath
To:     Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
X-archive-position: 41816
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

On Wed, Jul 30, 2014 at 9:59 AM, Frederic Weisbecker <fweisbec@gmail.com> wrote:
> On Tue, Jul 29, 2014 at 04:30:58PM -0700, Andy Lutomirski wrote:
>> On Tue, Jul 29, 2014 at 1:54 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Jul 29, 2014 12:22 PM, "Oleg Nesterov" <oleg@redhat.com> wrote:
>> >>
>> >> Andy, to avoid the confusion: I am not trying to review this changes.
>> >> As you probably know my understanding of asm code in entry.S is very
>> >> limited.
>> >>
>> >> Just a couple of questions to ensure I understand this correctly.
>> >>
>> >> On 07/28, Andy Lutomirski wrote:
>> >> >
>> >> > This is both a cleanup and a speedup.  It reduces overhead due to
>> >> > installing a trivial seccomp filter by 87%.  The speedup comes from
>> >> > avoiding the full syscall tracing mechanism for filters that don't
>> >> > return SECCOMP_RET_TRACE.
>> >>
>> >> And only after I look at 5/5 I _seem_ to actually understand where
>> >> this speedup comes from.
>> >>
>> >> So. Currently tracesys: path always lead to "iret" after syscall, with
>> >> this change we can avoid it if phase_1() returns zero, correct?
>> >>
>> >> And, this also removes the special TIF_SYSCALL_AUDIT-only case in entry.S,
>> >> cool.
>> >>
>> >> I am wondering if we can do something similar with do_notify_resume() ?
>> >>
>> >>
>> >> Stupid question. To simplify, lets forget that syscall_trace_enter()
>> >> already returns the value. Can't we simplify the asm code if we do
>> >> not export 2 functions, but make syscall_trace_enter() return
>> >> "bool slow_path_is_needed". So that "tracesys:" could do
>> >>
>> >>         // pseudo code
>> >>
>> >> tracesys:
>> >>         SAVE_REST
>> >>         FIXUP_TOP_OF_STACK
>> >>
>> >>         call syscall_trace_enter
>> >>
>> >>         if (!slow_path_is_needed) {
>> >>                 addq REST_SKIP, %rsp
>> >>                 jmp system_call_fastpath
>> >>         }
>> >>
>> >>         ...
>> >>
>> >> ?
>> >>
>> >> Once again, I am just curious, it is not that I actually suggest to consider
>> >> this option.
>> >
>> > We could, but this would lose a decent amount of the speedup.  I could
>> > try it and benchmark it, but I'm guessing that the save and restore is
>> > kind of expensive.  This will make audit slower than it currently is,
>> > which may also annoy some people.  (Not me.)
>> >
>> > I'm also not convinced that it would be much simpler.  My code is currently:
>> >
>> > tracesys:
>> >     leaq -REST_SKIP(%rsp), %rdi
>> >     movq $AUDIT_ARCH_X86_64, %rsi
>> >     call syscall_trace_enter_phase1
>> >     test %rax, %rax
>> >     jnz tracesys_phase2        /* if needed, run the slow path */
>> >     LOAD_ARGS 0            /* else restore clobbered regs */
>> >     jmp system_call_fastpath    /*      and return to the fast path */
>> >
>> > tracesys_phase2:
>> >     SAVE_REST
>> >     FIXUP_TOP_OF_STACK %rdi
>> >     movq %rsp, %rdi
>> >     movq $AUDIT_ARCH_X86_64, %rsi
>> >     movq %rax,%rdx
>> >     call syscall_trace_enter_phase2
>> >
>> >     LOAD_ARGS ARGOFFSET, 1
>> >     RESTORE_REST
>> >
>> >     ... slow path here ...
>> >
>> > It would end up looking more like (totally untested):
>> >
>> > tracesys:
>> >     SAVE_REST
>> >     FIXUP_TOP_OF_STACK %rdi
>> >     mov %rsp, %rdi
>> >     movq $AUDIT_ARCH_X86_64, %rsi
>> >     call syscall_trace_enter
>> >     LOAD_ARGS
>> >     RESTORE_REST
>> >     test [whatever condition]
>> >     j[cond] system_call_fastpath
>> >
>> >     ... slow path here ...
>> >
>> > So it's a bit simpler.  Oddly, the ia32entry code doesn't have this
>> > multiple syscall path distinction.
>> >
>> > SAVE_REST is 6 movq instructions and a subq.  FIXUP_TOP_OF_STACK is 7
>> > movqs (and 8 if I ever get my way).  RESTORE_TOP_OF_STACK is 4.
>> > RESTORE_REST is 6 movqs and an adsq.  So we're talking about avoiding
>> > 21 movqs, and addq, and a subq.  That may be significant.  (And I
>> > suspect that the difference is much larger on platforms like arm64,
>> > but that's a separate issue.)
>>
>> To put some more options on the table: there's an argument to be made
>> that the whole fast-path/slow-path split isn't worth it.  We could
>> unconditionally set up a full frame for all syscalls.  This means:
>>
>> No FIXUP_TOP_OF_STACK.  Instead, the system_call entry sets up RSP,
>> SS, CS, RCX, and EFLAGS right away.  That's five stores for all
>> syscalls instead of two loads and five stores for syscalls that need
>> it.  But it also gets rid of RESTORE_TOP_OF_STACK completely.
>>
>> No more bugs involving C code that assumes a full stack frame when no
>> such frame exists inside syscall code.
>>
>> We could possibly remove a whole bunch of duplicated code.
>>
>> The upshot would be simpler code, faster slow-path syscalls, and
>> slower fast-path syscalls (but probably not much slower).  On the
>> other hand, there's zero chance that this would be ready for 3.17.
>
> Indeed.
>
> If we ever take that direction (ie: remove that partial frame optimization),
> there is that common part that we can find in many archs when they return
> from syscalls, exceptions or interrupts which could be more or less consolidated as:
>
> void sysret_check(struct pt_regs *regs)
> {
>           while(test_thread_flag(TIF_ALLWORK_MASK)) {
>               int resched = need_resched();
>
>               local_irq_enable();
>               if (resched)
>                   schedule();
>               else
>                   do_notify_resume(regs);
>               local_irq_disable()
>            }
> }
>
> But well, probably the syscall fastpath is still worth it.

And yet x86_64 has this code implemented in assembly even in the
slowpath.  Go figure.

--Andy
