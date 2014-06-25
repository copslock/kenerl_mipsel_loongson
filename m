Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 18:54:12 +0200 (CEST)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:41332 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859928AbaFYQyIXdqVv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 18:54:08 +0200
Received: by mail-ob0-f170.google.com with SMTP id uz6so2425325obc.15
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4sCV+YHmOBm1mKPxFZyEVaE3vdJtTI/7qrUHp5SwZQQ=;
        b=QHBMgGUSPOW7GhHCogJUDB1v3pw1ajFX5NeT6LEXxZ0Oa/R9wC+6buYKlk4U7W+hgC
         l30qwnDPw/6UHwZllNcFhK89vTi9b4agy3ypotB18jCGB9+loUUjSEpPysdp7XseQYq0
         Ah8r7UuNFdJgDSxPmaKXn8Oo98BrA3s8qqkwlARFQxFcibULgSwvK9IV4tUCqCzgEsAq
         VmCaLVy0HzX/XhqJQRuFWVI+YBldd9Ay3OOofY1H1BvFRdq0QSrG06fhT+rMCQPpMvS2
         msQZH7MIUC/rpwvS2owESZTKcuZj0q7h6URNkgrKWctR97qXlBMxeZFob/Kw2lpT5tkp
         QTEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4sCV+YHmOBm1mKPxFZyEVaE3vdJtTI/7qrUHp5SwZQQ=;
        b=OSdgx4yTVSviBVQOart1SprFt8omtio1cNeiUXgrlidnj9TBJjXMaN/9iQEKfN7ZXG
         ZDYPAm0pRa0xgflEqsir4NSUmJz5JSlv3qL9QUhxMepFxPmBA/iw2S4G9+jYVKPaVQRB
         VQYQ7/rD++tkQ/gcNr7EiCDXiBWa7UrZhTDN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4sCV+YHmOBm1mKPxFZyEVaE3vdJtTI/7qrUHp5SwZQQ=;
        b=H8u8s1k8+u132JTFJZzGfqKJ/GZk3+Vrtx49QdYboCLJ+60x6qE6kozmnF2oVvCLzo
         e9VtuaqGTG+88IOPdfDNaZflAGKX0KqDCOJDeqM6exncdyojX1ppKrQLbjf8/3mgOvyC
         DVXTmlJs8OjaJjMZ/EruC7uEgiwGMgWSUD+1gJPPS4rtJWp6s5OsLw3/1X7/70g0ds7l
         /GeqAsVhHTNjWVW42zWFzCW8Flr9D+4qZi1Yhv/unsdCQwkPl1XnegO0KwRl8wb+5qbp
         aSC3VtmrIJeNdSy1Ro4zVIiIYCy5/JH8NMCSR8x95Rci5I/JHBWyzNxGZul3U2mnYsk6
         raGQ==
X-Gm-Message-State: ALoCoQkhDu9AR4g3+ojtSv/GMhxjkKx1oXra67a5h0Fu//FcOXW358BSUdMLeL7YpO3LYjk7uXRx
MIME-Version: 1.0
X-Received: by 10.60.56.98 with SMTP id z2mr9200319oep.62.1403715241926; Wed,
 25 Jun 2014 09:54:01 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 09:54:01 -0700 (PDT)
In-Reply-To: <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-6-git-send-email-keescook@chromium.org>
        <20140625135121.GB7892@redhat.com>
        <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
        <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
Date:   Wed, 25 Jun 2014 09:54:01 -0700
X-Google-Sender-Auth: C4SwRTLOti7eX0n26vQa2PKUUj8
Message-ID: <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
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
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40817
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

On Wed, Jun 25, 2014 at 9:10 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jun 25, 2014 at 7:51 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Jun 25, 2014 at 6:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 06/24, Kees Cook wrote:
>>>>
>>>> +static inline void seccomp_assign_mode(struct task_struct *task,
>>>> +                                    unsigned long seccomp_mode)
>>>> +{
>>>> +     BUG_ON(!spin_is_locked(&task->sighand->siglock));
>>>> +
>>>> +     task->seccomp.mode = seccomp_mode;
>>>> +     set_tsk_thread_flag(task, TIF_SECCOMP);
>>>> +}
>>>
>>> OK, but unless task == current this can race with secure_computing().
>>> I think this needs smp_mb__before_atomic() and secure_computing() needs
>>> rmb() after test_bit(TIF_SECCOMP).
>>>
>>> Otherwise, can't __secure_computing() hit BUG() if it sees the old
>>> mode == SECCOMP_MODE_DISABLED ?
>>>
>>> Or seccomp_run_filters() can see ->filters == NULL and WARN(),
>>> smp_load_acquire() only serializes that LOAD with the subsequent memory
>>> operations.
>>
>> Hm, actually, now I'm worried about smp_load_acquire() being too slow
>> in run_filters().
>>
>> The ordering must be:
>> - task->seccomp.filter must be valid before
>> - task->seccomp.mode is set, which must be valid before
>> - TIF_SECCOMP is set
>>
>> But I don't want to impact secure_computing(). What's the best way to
>> make sure this ordering is respected?
>
> Remove the ordering requirement, perhaps?
>
> What if you moved mode into seccomp.filter?  Then there would be
> little reason to check TIF_SECCOMP from secure_computing; instead, you
> could smp_load_acquire (or read_barrier_depends, maybe) seccomp.filter
> from secure_computing and pass the result as a parameter to
> __secure_computing.  Or you could even remove the distinction between
> secure_computing and __secure_computing -- it's essentially useless
> anyway to split entry hook approaches like my x86 fastpath prototype.

The TIF_SECCOMP is needed for the syscall entry path. The check in
secure_computing() is just because the "I am being traced" trigger
includes a call to secure_computing, which filters out tracing
reasons.

Your fast path work would clean a lot of that up, as you say. But it
still doesn't change the ordering check here. TIF_SECCOMP indicates
seccomp.mode must be checked, so that ordering will remain, and if
mode == FILTER, seccomp.filter must be valid.

Isn't there a way we can force the assignment ordering in seccomp_assign_mode()?

-Kees

-- 
Kees Cook
Chrome OS Security
