Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:04:09 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:34263 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854767AbaFYREHzIhH7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 19:04:07 +0200
Received: by mail-la0-f51.google.com with SMTP id mc6so960171lab.24
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 10:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=stf7n+bLoPTTY1mHnpqgJoJgjsyJQR+lSrWf6i6y5zo=;
        b=P5YZqmkzEyHfrNz+do/Xn3NFklINfXk/AI9FVjvLFJadpLFmNPNPWE7sIfATgwsURP
         WLWKIjhUBw304bxrFJlkxW3uhO1EPzS7KGnm+9MYis1OQ/DhS3FXPfPC16iNm9xZVj6D
         CuGk5Cvt4wfKaNFSr9nxURZfnl6hXSiiu8CAZbz81m4Rpc49gzKATasxAQOpFN0SW75U
         PNUr4vWvTLLTzZf4Fv0sd1kayek0EuP1BrWkgyyFoJa+O7yUX41gNBmUw0gNyBC8CIzG
         X4mcMRWYQdE71PCYIO12MsxVnHudJ0qSp3U6CPrB7iq9oq8a+j+gN7XGX8+TIjty+Mq0
         tGwQ==
X-Gm-Message-State: ALoCoQkXeoJu3D5PXB9EXuHa3Ok8UsWLaIiPzxqPOSTe8S0QsHUde4XoeNGS0wadOlV7il7Pe2SP
X-Received: by 10.112.46.97 with SMTP id u1mr6467919lbm.50.1403715842426; Wed,
 25 Jun 2014 10:04:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 25 Jun 2014 10:03:42 -0700 (PDT)
In-Reply-To: <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com> <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 25 Jun 2014 10:03:42 -0700
Message-ID: <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
To:     Kees Cook <keescook@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40819
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

On Wed, Jun 25, 2014 at 9:54 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 25, 2014 at 9:10 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Wed, Jun 25, 2014 at 7:51 AM, Kees Cook <keescook@chromium.org> wrote:
>>> On Wed, Jun 25, 2014 at 6:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>> On 06/24, Kees Cook wrote:
>>>>>
>>>>> +static inline void seccomp_assign_mode(struct task_struct *task,
>>>>> +                                    unsigned long seccomp_mode)
>>>>> +{
>>>>> +     BUG_ON(!spin_is_locked(&task->sighand->siglock));
>>>>> +
>>>>> +     task->seccomp.mode = seccomp_mode;
>>>>> +     set_tsk_thread_flag(task, TIF_SECCOMP);
>>>>> +}
>>>>
>>>> OK, but unless task == current this can race with secure_computing().
>>>> I think this needs smp_mb__before_atomic() and secure_computing() needs
>>>> rmb() after test_bit(TIF_SECCOMP).
>>>>
>>>> Otherwise, can't __secure_computing() hit BUG() if it sees the old
>>>> mode == SECCOMP_MODE_DISABLED ?
>>>>
>>>> Or seccomp_run_filters() can see ->filters == NULL and WARN(),
>>>> smp_load_acquire() only serializes that LOAD with the subsequent memory
>>>> operations.
>>>
>>> Hm, actually, now I'm worried about smp_load_acquire() being too slow
>>> in run_filters().
>>>
>>> The ordering must be:
>>> - task->seccomp.filter must be valid before
>>> - task->seccomp.mode is set, which must be valid before
>>> - TIF_SECCOMP is set
>>>
>>> But I don't want to impact secure_computing(). What's the best way to
>>> make sure this ordering is respected?
>>
>> Remove the ordering requirement, perhaps?
>>
>> What if you moved mode into seccomp.filter?  Then there would be
>> little reason to check TIF_SECCOMP from secure_computing; instead, you
>> could smp_load_acquire (or read_barrier_depends, maybe) seccomp.filter
>> from secure_computing and pass the result as a parameter to
>> __secure_computing.  Or you could even remove the distinction between
>> secure_computing and __secure_computing -- it's essentially useless
>> anyway to split entry hook approaches like my x86 fastpath prototype.
>
> The TIF_SECCOMP is needed for the syscall entry path. The check in
> secure_computing() is just because the "I am being traced" trigger
> includes a call to secure_computing, which filters out tracing
> reasons.

Right.  I'm suggesting just checking a single indication that seccomp
is on from the process in the seccomp code so that the order doesn't
matter.

IOW, TIF_SECCOMP causes __secure_computing to be invoked, but the race
only seems to matter because of the warning and the BUG.  I think that
both can be fixed if you merge mode into filter so that
__secure_computing atomically checks one condition.

>
> Your fast path work would clean a lot of that up, as you say. But it
> still doesn't change the ordering check here. TIF_SECCOMP indicates
> seccomp.mode must be checked, so that ordering will remain, and if
> mode == FILTER, seccomp.filter must be valid.
>
> Isn't there a way we can force the assignment ordering in seccomp_assign_mode()?

Write the filter, then smp_mb (or maybe a weaker barrier is okay),
then set the bit.

--Andy

>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
