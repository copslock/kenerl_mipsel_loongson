Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 19:55:38 +0200 (CEST)
Received: from mail-io0-x22d.google.com ([IPv6:2607:f8b0:4001:c06::22d]:33515
        "EHLO mail-io0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993939AbdHNRz1CKOep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 19:55:27 +0200
Received: by mail-io0-x22d.google.com with SMTP id j32so40965548iod.0
        for <linux-mips@linux-mips.org>; Mon, 14 Aug 2017 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VOKY+d1PQAmSFyz3i40iOSinbwjpvotTOv/RjYqhIu4=;
        b=JSQKi3+bEd3uRIN4Mlakh4KoAjTxxX/L3TELLmn8ig3IRuWx3RmFLExfgnYVeuEwRU
         hAmrmWxySvTBA2omug4xkZvR1xQ8R8JnDsJ5m0xAbeC9Y7qWFZtjmvuuTcLfEUyTRAmu
         ns9MNXo3UY71hXr4ezyTFnckIPow+rWNAMU2BbV86BBPyRpi1nkRUt4fkmty79PStm/j
         b/IkUrvcLX5ztucMH7Rtev6gachIbWC+mZW7E9qiEMBnaz2cIfUPAbAKxWveA9MAtdiW
         3e5B9NguuW8qlH/SGAl6dWEH5BISke4fuO8EE24Y67eIG5gBdek7QNDWSNW2L2a26NVL
         LJMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VOKY+d1PQAmSFyz3i40iOSinbwjpvotTOv/RjYqhIu4=;
        b=oadbAtcKQARaS6AhqTVr4NuDu7Pr8PuWj+WW55s6UyEwaW8sJUGHiatMPYlHp6Pak/
         JwIkcOPv/MXa0VcQQf+iaadJitPvpGlBvCL54fRxz6SpU2UguKYQKZTEgkOmjRZy3Ahk
         nh4XVqq2/bEGyqQnntDyXCrDNJizC9EubOCso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VOKY+d1PQAmSFyz3i40iOSinbwjpvotTOv/RjYqhIu4=;
        b=p7HkLHmXBMurR7SsIKS+6LXa6r2pLQUKw9dwCO995ZquS7VxZb9Fo+KvV43kJchZex
         DfDr+jonKGsqnE4TUuuXNNR4ls/tly8KEmppRc4iRY4vSedvZVZk6/t1YuaxuIxIiY1J
         vRuybOczoWa70WzwBDwVk3lSpXhLsiNLdVelxiIToJszxc2RyqyhYj3HbvEDXwn30wh2
         xOYr5BxbYe7QQAAMN21u94wSQnhIhVc39IZOPvI1AMhRYFZQFWHP+Sp/e6ons+pevJSf
         u5wqzPMvGTzbUhkOe8hrAzQqYpPjcSHa9lkw4b4mjz4KUGsw+3OcICJ/qqp4vlhsdNzc
         xwuQ==
X-Gm-Message-State: AIVw113cVqviv2OoobtWGmMOx68Mkz4wrNy3VqQFgm15Qh3CuKMnk1YO
        4q/cjOeUJWIhvUdU69QZowWJFFPM1SXl
X-Received: by 10.107.6.86 with SMTP id 83mr19814379iog.190.1502733321064;
 Mon, 14 Aug 2017 10:55:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.161 with HTTP; Mon, 14 Aug 2017 10:55:20 -0700 (PDT)
In-Reply-To: <20170814094145.GP6973@jhogan-linux.le.imgtec.org>
References: <20170811205653.21873-1-james.hogan@imgtec.com>
 <20170811205653.21873-5-james.hogan@imgtec.com> <CAGXu5j+Z_n1G9_q=FrOHVbz0axR8G6izB2Rvku1k6bRjJ6rMrA@mail.gmail.com>
 <20170814094145.GP6973@jhogan-linux.le.imgtec.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Aug 2017 10:55:20 -0700
X-Google-Sender-Auth: gIPRY_M6f7q1AVPRBpdQfMCThdA
Message-ID: <CAGXu5j+s3bBGX51Ufo9rJZ2RVEPk90J1KEEF-hVmwzR=_tuccA@mail.gmail.com>
Subject: Re: [PATCH 4/4] MIPS/ptrace: Add PTRACE_SET_SYSCALL operation
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59569
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

On Mon, Aug 14, 2017 at 2:41 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Aug 11, 2017 at 03:23:34PM -0700, Kees Cook wrote:
>> On Fri, Aug 11, 2017 at 1:56 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> > Add a PTRACE_SET_SYSCALL ptrace operation to allow the system call to be
>> > cancelled independently to the value of the v0 system call number
>> > register.
>> >
>> > This is needed for SECCOMP_RET_TRACE when the tracer wants to cancel the
>> > system call, since it has to set both the system call number to -1 and
>> > the chosen return value, both of which reside in the same register (v0).
>> > The tracer should set the return value first, followed by
>> > PTRACE_SET_SYSCALL to set the system call number to -1.
>> >
>> > That is in contrast to the normal ptrace syscall hook which triggers the
>> > tracer on both entry and exit, allowing the system call to be cancelled
>> > during the entry hook (setting system call number register to -1, or
>> > optionally using PTRACE_SET_SYSCALL), separately to setting the return
>> > value during the exit hook.
>> >
>> > Positive values (to change the syscall that should be executed instead
>> > of cancelling it entirely) are explicitly disallowed at the moment. The
>> > same thing can be done safely already by writing the v0 system call
>> > number register and the argument registers, and allowing
>> > thread_info::syscall to be changed to a different value independently of
>> > the v0 register would potentially allow seccomp or the syscall trace
>> > events to be fooled into thinking a different system call was being
>> > executed.
>>
>> Wouldn't the sycall be reloaded, so no spoofing could occur?
>
> The case I was thinking of was:
> - PTRACE_POKEUSR v0 = __NR_some_disallowed_syscall
> - PTRACE_SET_SYSCALL __NR_some_allowed_syscall
>
> syscall_get_nr() will return __NR_some_allowed_syscall, so seccomp will
> allow, but when syscall_trace_enter() returns to syscall_trace_entry in
> arch/mips/kernel/scall32-o32.S, it will reload the syscall number from
> v0 (i.e. __NR_some_disallowed_syscall).

IIUC, the issue is that v0 holds syscall on entry and syscall return
on exit. Isn't it possible to rework all the entry logic to examine
only thread_info->syscall and ignore v0 during the ptrace and seccomp
events? i.e. SET_SYSCALL can modify ti->syscall, and only if it goes
to -1 only then will v0 be examined for a result? (If I'm reading
scall32-o32.S, I think this means loading the new syscall from
thread_info instead of registers after syscall_trace_enter.)

If that is possible, it doesn't have to happen in this patch,
obviously. Incremental is fine. :)

>> Regardless, can you update
>> tools/testing/selftests/seccomp/seccomp_bpf.c to update or eliminate
>> the MIPS-only SYSCALL_NUM_RET_SHARE_REG special-case? (Or maybe it
>> needs to be further special-cased to split syscall-changing from
>> syscall-cancelling?)
>
> Sure, i'll look into that,
>
> Thanks for reviewing,

Sure thing, thanks!

-Kees

-- 
Kees Cook
Pixel Security
