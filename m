Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 19:00:10 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35921 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860010AbaG3RAGmoziO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 19:00:06 +0200
Received: by mail-wi0-f171.google.com with SMTP id hi2so7846387wib.16
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9+NJ4tFP4lTzQAk0q4JyQ9WMUs0uXe79LjaNczDo8O8=;
        b=JPtuhV8oMpwO9E+KWNpOaVlzeSF6LFII46NoINVxEpmy7ApZE8sWa0vlnHJJWy0/qt
         /5qzvM+4rhvN+u/BDr1x4oSLSPm9agD/PGNaUi38Bksq3jpzx3kZO6qRH1Y4U8zA8IFk
         YB0lNjPC2NYmEdKpb6ylc+uVzfLiMLMbwvS2eMsT70s2e36YNFmhhGERuW5Qg7/xDYJw
         hfn36QdBU9GLEpYFpc2dvoYePrDjgRHEYrtYlFixUHghzZkK6tJ9ISnDYo3jJchNzEQd
         WF+py1hNJCctTp7u+sqv56oVPlbTh8eDwpHi2zPmBoAoxn0EfIDGemtbG5g4RONe4SsJ
         PgYg==
X-Received: by 10.194.63.37 with SMTP id d5mr8253290wjs.92.1406739600126;
        Wed, 30 Jul 2014 10:00:00 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id bp9sm57299806wib.7.2014.07.30.09.59.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jul 2014 09:59:59 -0700 (PDT)
Date:   Wed, 30 Jul 2014 18:59:56 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
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
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp
 fastpath
Message-ID: <20140730165940.GB27954@localhost.localdomain>
References: <cover.1406604806.git.luto@amacapital.net>
 <20140729192056.GA6308@redhat.com>
 <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
 <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
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

On Tue, Jul 29, 2014 at 04:30:58PM -0700, Andy Lutomirski wrote:
> On Tue, Jul 29, 2014 at 1:54 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Jul 29, 2014 12:22 PM, "Oleg Nesterov" <oleg@redhat.com> wrote:
> >>
> >> Andy, to avoid the confusion: I am not trying to review this changes.
> >> As you probably know my understanding of asm code in entry.S is very
> >> limited.
> >>
> >> Just a couple of questions to ensure I understand this correctly.
> >>
> >> On 07/28, Andy Lutomirski wrote:
> >> >
> >> > This is both a cleanup and a speedup.  It reduces overhead due to
> >> > installing a trivial seccomp filter by 87%.  The speedup comes from
> >> > avoiding the full syscall tracing mechanism for filters that don't
> >> > return SECCOMP_RET_TRACE.
> >>
> >> And only after I look at 5/5 I _seem_ to actually understand where
> >> this speedup comes from.
> >>
> >> So. Currently tracesys: path always lead to "iret" after syscall, with
> >> this change we can avoid it if phase_1() returns zero, correct?
> >>
> >> And, this also removes the special TIF_SYSCALL_AUDIT-only case in entry.S,
> >> cool.
> >>
> >> I am wondering if we can do something similar with do_notify_resume() ?
> >>
> >>
> >> Stupid question. To simplify, lets forget that syscall_trace_enter()
> >> already returns the value. Can't we simplify the asm code if we do
> >> not export 2 functions, but make syscall_trace_enter() return
> >> "bool slow_path_is_needed". So that "tracesys:" could do
> >>
> >>         // pseudo code
> >>
> >> tracesys:
> >>         SAVE_REST
> >>         FIXUP_TOP_OF_STACK
> >>
> >>         call syscall_trace_enter
> >>
> >>         if (!slow_path_is_needed) {
> >>                 addq REST_SKIP, %rsp
> >>                 jmp system_call_fastpath
> >>         }
> >>
> >>         ...
> >>
> >> ?
> >>
> >> Once again, I am just curious, it is not that I actually suggest to consider
> >> this option.
> >
> > We could, but this would lose a decent amount of the speedup.  I could
> > try it and benchmark it, but I'm guessing that the save and restore is
> > kind of expensive.  This will make audit slower than it currently is,
> > which may also annoy some people.  (Not me.)
> >
> > I'm also not convinced that it would be much simpler.  My code is currently:
> >
> > tracesys:
> >     leaq -REST_SKIP(%rsp), %rdi
> >     movq $AUDIT_ARCH_X86_64, %rsi
> >     call syscall_trace_enter_phase1
> >     test %rax, %rax
> >     jnz tracesys_phase2        /* if needed, run the slow path */
> >     LOAD_ARGS 0            /* else restore clobbered regs */
> >     jmp system_call_fastpath    /*      and return to the fast path */
> >
> > tracesys_phase2:
> >     SAVE_REST
> >     FIXUP_TOP_OF_STACK %rdi
> >     movq %rsp, %rdi
> >     movq $AUDIT_ARCH_X86_64, %rsi
> >     movq %rax,%rdx
> >     call syscall_trace_enter_phase2
> >
> >     LOAD_ARGS ARGOFFSET, 1
> >     RESTORE_REST
> >
> >     ... slow path here ...
> >
> > It would end up looking more like (totally untested):
> >
> > tracesys:
> >     SAVE_REST
> >     FIXUP_TOP_OF_STACK %rdi
> >     mov %rsp, %rdi
> >     movq $AUDIT_ARCH_X86_64, %rsi
> >     call syscall_trace_enter
> >     LOAD_ARGS
> >     RESTORE_REST
> >     test [whatever condition]
> >     j[cond] system_call_fastpath
> >
> >     ... slow path here ...
> >
> > So it's a bit simpler.  Oddly, the ia32entry code doesn't have this
> > multiple syscall path distinction.
> >
> > SAVE_REST is 6 movq instructions and a subq.  FIXUP_TOP_OF_STACK is 7
> > movqs (and 8 if I ever get my way).  RESTORE_TOP_OF_STACK is 4.
> > RESTORE_REST is 6 movqs and an adsq.  So we're talking about avoiding
> > 21 movqs, and addq, and a subq.  That may be significant.  (And I
> > suspect that the difference is much larger on platforms like arm64,
> > but that's a separate issue.)
> 
> To put some more options on the table: there's an argument to be made
> that the whole fast-path/slow-path split isn't worth it.  We could
> unconditionally set up a full frame for all syscalls.  This means:
> 
> No FIXUP_TOP_OF_STACK.  Instead, the system_call entry sets up RSP,
> SS, CS, RCX, and EFLAGS right away.  That's five stores for all
> syscalls instead of two loads and five stores for syscalls that need
> it.  But it also gets rid of RESTORE_TOP_OF_STACK completely.
> 
> No more bugs involving C code that assumes a full stack frame when no
> such frame exists inside syscall code.
> 
> We could possibly remove a whole bunch of duplicated code.
> 
> The upshot would be simpler code, faster slow-path syscalls, and
> slower fast-path syscalls (but probably not much slower).  On the
> other hand, there's zero chance that this would be ready for 3.17.

Indeed.

If we ever take that direction (ie: remove that partial frame optimization),
there is that common part that we can find in many archs when they return
from syscalls, exceptions or interrupts which could be more or less consolidated as:

void sysret_check(struct pt_regs *regs)
{
          while(test_thread_flag(TIF_ALLWORK_MASK)) {
              int resched = need_resched();

              local_irq_enable();
              if (resched)
                  schedule();
              else
                  do_notify_resume(regs);
              local_irq_disable()
           }
}

But well, probably the syscall fastpath is still worth it.              

> 
> I'd tend to advocate for keeping the approach in my patches for now.
> It's probably a smaller assembly diff than any of the other options --
> the split between fast-path, slower fast-path, and slow-path already
> exists due to the audit crap.  If we end up making more radical
> changes later, then at worst we end up reverting part of the change to
> ptrace.c.
> 
> --Andy
