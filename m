Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 21:07:11 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:64627 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012783AbbBFUHJxJ0KO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 21:07:09 +0100
Received: by mail-oi0-f52.google.com with SMTP id h136so13729989oig.11
        for <linux-mips@linux-mips.org>; Fri, 06 Feb 2015 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gV8Hoc3EcQZAlb9OE3xSd5WGje4FIQh4Eu4tAuhdk9Q=;
        b=PtCzJINMaJ9QBgTiaYxxz1FuX9p0yVWqrD8HBI9yqEM+g0bxPqa/j5N+0X8X0887vB
         60ysPz/yQGrm/uKBJDMXja14jjx1nnxHWbyhW/xiBKY87X9PvLZKPHUqrFtrhkHmmOJB
         s40eoQbFF8BLEOKQBJH1uA5V+gQi+ZqhEZyJZFEP8Z53WCXMU9rq5SAI8j+wRAmbfG/P
         GINV/qMS2bpyP6rj+hjRyWCQKK9FqbQsF2aycWtHG1veL8jSQ6HwjDjC5DNOUkZXb2gX
         fMr0b1FvDUa4ea7gM6C5yERIXvfjv5Yww7N7MmsVLHIHt9jpbznAm2vF2YUff9N2WeBO
         UeVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gV8Hoc3EcQZAlb9OE3xSd5WGje4FIQh4Eu4tAuhdk9Q=;
        b=glopajJDJRkXHoFgkn3holMN3pb+CEpFamuYwp323Q8VHzBtv+K8ARWwc0KbdYHcYe
         NCsmE8IPctgmKva8SbM3419Pzf/7TyLG9XzCmSMTL0xaJyxTYdEK6/o3dn4oC80UV8px
         /6svuP9WgZ4T6Lrar79/0BOpWz/8Ogl0axg48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gV8Hoc3EcQZAlb9OE3xSd5WGje4FIQh4Eu4tAuhdk9Q=;
        b=Ba8wBEfEU1LcKo+fR4Nf+4BbGm4P/cSpeH1D725nnsDJH/iw7uSiOfPfeu5WXNDrh4
         SF//mrSuB0DAIHTaP82PG3+mzc0Kt1RA7aaOL+32v2cy1lCsMvadlkr+45seffJyLNhM
         P6vHiaesU+h5PspfuIC28ylLDS0mYBNktS+wdo8vFun9GAGjPd5hZ6XGu+jyJiW3ZjD4
         M5iXbdJhE6lvuRRAKhil5jU3hmSJkxC2QoUfB/GmZJj4K90uiOth0dE3gOJnBiun+6Hq
         EXVG3sdFbqancff1BWSH/xI6M/V1D/NlqJL5RrWe3mApiQ9F9+qfC456ILvn5duYv2N9
         vIwQ==
X-Gm-Message-State: ALoCoQmfLJXh/+58Nqf0n3CaBuujUzRkciC43OM/zCxMkRTiOdLgs/9poTr8l48rXGfpcvreWnFa
MIME-Version: 1.0
X-Received: by 10.182.58.20 with SMTP id m20mr3729898obq.32.1423253223777;
 Fri, 06 Feb 2015 12:07:03 -0800 (PST)
Received: by 10.182.87.201 with HTTP; Fri, 6 Feb 2015 12:07:03 -0800 (PST)
In-Reply-To: <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com>
References: <cover.1409954077.git.luto@amacapital.net>
        <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
        <20150205211916.GA31367@altlinux.org>
        <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
        <20150205214027.GB31367@altlinux.org>
        <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
        <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
        <20150205233945.GA31540@altlinux.org>
        <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
        <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
        <20150206023249.GB31540@altlinux.org>
        <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com>
        <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
        <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com>
Date:   Fri, 6 Feb 2015 12:07:03 -0800
X-Google-Sender-Auth: mcd0CLd8As_Uq9Z-4iinBfvxjHM
Message-ID: <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
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
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45755
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

On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Feb 5, 2015 at 6:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Thu, Feb 5, 2015 at 6:32 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>>> On Thu, Feb 05, 2015 at 04:09:06PM -0800, Andy Lutomirski wrote:
>>>>> On Thu, Feb 5, 2015 at 3:49 PM, Kees Cook <keescook@chromium.org> wrote:
>>>>> > On Thu, Feb 5, 2015 at 3:39 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>>> [...]
>>>>> >> There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
>>>>> >> to keep the syscall number unchanged and suppress syscall-exit-stop event,
>>>>> >> which was awful because userspace cannot distinguish syscall-enter-stop
>>>>> >> from syscall-exit-stop and therefore relies on the kernel that
>>>>> >> syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).
>>>>> >>
>>>>> >> After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
>>>>> >> events to be suppressed, but now the syscall number is lost.
>>>>> >
>>>>> > Ah-ha! Okay, thanks, I understand now. I think this means seccomp
>>>>> > phase1 should not treat RET_ERRNO as a "skip" event. Andy, what do you
>>>>> > think here?
>>>>>
>>>>> I still don't quite see how this change caused this.
>>>>
>>>> I have a test for this at
>>>> http://sourceforge.net/p/strace/code/ci/HEAD/~/tree/test/seccomp.c
>>>>
>>>>> I can play with
>>>>> it a bit more.  But RET_ERRNO *has* to be some kind of skip event,
>>>>> because it needs to skip the syscall.
>>>>>
>>>>> We could change this by treating RET_ERRNO as an instruction to enter
>>>>> phase 2 and then asking for a skip in phase 2 without changing
>>>>> orig_ax, but IMO this is pretty ugly.
>>>>>
>>>>> I think this all kind of sucks.  We're trying to run ptrace after
>>>>> seccomp, so ptrace is seeing the syscalls as transformed by seccomp.
>>>>> That means that if we use RET_TRAP, then ptrace will see the
>>>>> possibly-modified syscall, if we use RET_ERRNO, then ptrace is (IMO
>>>>> correctly given the current design) showing syscall -1, and if we use
>>>>> RET_KILL, then ptrace just sees the process mysteriously die.
>>>>
>>>> Userspace is usually not prepared to see syscall -1.
>>>> For example, strace had to be patched, otherwise it just skipped such
>>>> syscalls as "not a syscall" events or did other improper things:
>>>> http://sourceforge.net/p/strace/code/ci/c3948327717c29b10b5e00a436dc138b4ab1a486
>>>> http://sourceforge.net/p/strace/code/ci/8e398b6c4020fb2d33a5b3e40271ebf63199b891
>>>>
>>>
>>> The x32 thing is a legit ABI bug, I'd argue.  I'd be happy to submit a
>>> patch to fix that (clear the x32 bit if we're not x32).
>>>
>>>> A slightly different but related story: userspace is also not prepared
>>>> to handle large errno values produced by seccomp filters like this:
>>>> BPF_STMT(BPF_RET, SECCOMP_RET_ERRNO | SECCOMP_RET_DATA)
>>>>
>>>> For example, glibc assumes that syscalls do not return errno values greater than 0xfff:
>>>> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/sysdep.h#l55
>>>> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/syscall.S#l20
>>
>> To save others the link reading: "Linus said he will make sure the no
>> syscall returns a value in -1 .. -4095 as a valid result so we can
>> savely test with -4095."
>>
>> Strictly speaking (ISO C, "man 3 errno"), errno is supposed to be a
>> full int, though digging around I find this in include/linux/err.h:
>>
>> /*
>>  * Kernel pointers have redundant information, so we can use a
>>  * scheme where we can return either an error code or a normal
>>  * pointer with the same return value.
>>  *
>>  * This should be a per-architecture thing, to allow different
>>  * error and pointer decisions.
>>  */
>> #define MAX_ERRNO       4095
>>
>> #ifndef __ASSEMBLY__
>>
>> #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
>>
>> But no architecture overrides this.
>>
>>>> If it isn't too late, I'd recommend changing SECCOMP_RET_DATA mask
>>>> applied in SECCOMP_RET_ERRNO case from current 0xffff to 0xfff.
>>
>> I'm not opposed to this. I would want to more explicitly document the
>> 4095 max value in man pages, though.
>>
>>> I think this is solidly in the "don't do that" category.  Seccomp lets
>>> you tamper with syscalls.  If you tamper wrong, then you lose.
>>>
>>> Kees, what do you think about reversing the whole thing so that
>>> ptracers always see the original syscall?
>>
>> What do you mean by "reversing"? The interactions I see here are:
>>
>> PTRACE_SYSCALL
>> SECCOMP_RET_ERRNO
>> SECCOMP_RET_TRACE
>> SECCOMP_RET_TRAP
>>
>> Both ptrace and seccomp will trigger via _TIF_WORK_SYSCALL_ENTRY. Only
>> ptrace will trigger via _TIF_WORK_SYSCALL_EXIT.
>>
>> For SECCOMP_RET_ERRNO to work, we must skip the syscall, as mentioned earlier:
>>
>> arch/x86/kernel/entry_32.S ...
>> syscall_trace_entry:
>>         movl $-ENOSYS,PT_EAX(%esp)
>>         movl %esp, %eax
>>         call syscall_trace_enter
>>         /* What it returned is what we'll actually use.  */
>>         cmpl $(NR_syscalls), %eax
>>         jnae syscall_call
>>         jmp syscall_exit
>> END(syscall_trace_entry)
>>
>> Both before and after the 2-phase change, syscall_trace_enter would
>> return -1 if it hit SECCOMP_RET_ERRNO, before calling
>> tracehook_report_syscall_entry. On exit, if PTRACE_SYSCALL, we'd hit
>> tracehook_report_syscall_exit during syscall_trace_leave, which means
>> a ptracer will see a syscall-exit-stop without a matching
>> syscall-enter-stop.
>>
>> Using SECCOMP_RET_TRACE with PTRACE_SYSCALL in place seems totally
>> crazy, as the ptracer would need to be the same program, and if it
>> chose to skip a syscall, it would be in the same place: it would see
>> PTRACE_EVENT_SECCOMP, then no syscall-enter-stop, then a
>> syscall-exit-stop. I think we can ignore this pathological case.
>>
>> Using SECCOMP_RET_TRAP with PTRACE_SYSCALL also results in a skip,
>> which produces the same "only syscall-exit-stop seen" problem.
>>
>> In the SECCOMP_RET_ERRNO case, the syscall nr doesn't change (and
>> isn't executed). In the SECCOMP_RET_TRAP case, the syscall nr doesn't
>> change (and isn't executed). In the SECCOMP_RET_TRACE, the syscall nr
>> _could_ change, but the ptracer would be doing it, so the crazy
>> situation around PTRACE_SYSCALL is probably safe to ignore (as long as
>> we document what is expected to happen).
>>
>> So, the question is: should PTRACE_SYSCALL see a syscall that is _not_
>> being executed (due to seccomp)? Audit doesn't see it currently, and
>> neither does ptrace. I would argue that it should continue to not see
>> the syscall. That said, if it shouldn't be shown, we also shouldn't
>> trigger syscall-exit-stop. If you can convince me it should see
>> syscall-enter-stop, then I have two questions:
>
> I think PTRACE_SYSCALL should see syscalls that are skipped due to
> seccomp.  I think that the exit event should see the modified errno,
> if any, so that strace will show whatever the traced process thinks is
> happening.
>
>>
>> 1) Do we accept that a ptracer can interfere with SECCOMP_RET_ERRNO? I
>> think we probably must, since it can already interfere via
>> syscall-exit-stop and change the errno.
>
> I think this is fine.
>
>> And especially since a ptracer
>> can change syscalls during syscall-enter-stop to any syscall it wants,
>> bypassing seccomp. This condition is already documented.
>
> If a ptracer (using PTRACE_SYSCALL) were to get the entry callback
> before seccomp, then this oddity would go away, which might be a good
> thing.  A ptracer could change the syscall, but seccomp would based on
> what the ptracer changed the syscall to.

I want kill events to trigger immediately. I don't want to leave the
ptrace surface available on a SECCOMP_RET_KILL. So maybe it can be
seccomp phase 1, then ptrace, then seccomp phase 2? And pass more
information between phases to determine how things should behave
beyond just "skip"?

>> 2) What do we do with audit? Suddenly we have ptrace seeing a syscall
>> that audit doesn't?
>
> Is this a problem?  I'd be amazed if program uses both ptrace and
> audit -- after all, audit is a global thing, and it only has one
> implementation (AFAIK): auditd.  auditd doesn't ptrace the world.
>
>>
>> And an unrelated thought:
>>
>> 3) Can't we find some way to fix the inability of a ptracer to
>> distinguish between syscall-enter-stop and syscall-exit-stop?
>>
>
> Couldn't we add PTRACE_O_TRACESYSENTRY and PTRACE_O_TRACESYSEXIT along
> the lines of PTRACE_O_TRACESYSGOOD?

That might be a nice idea. I haven't written a test to see, but what
does PTRACE_GETEVENTMSG return on syscall-enter/exit-stop? If we can't
add something there, then yeah, adding PTRACE_O_TRACESYSENTRY and
PTRACE_O_TRACESYSEXIT with their own event msgs would be nice. Could
even add the syscall nr to the event msg so ptracers don't have to dig
around in per-arch registers, too.

-Kees

-- 
Kees Cook
Chrome OS Security
