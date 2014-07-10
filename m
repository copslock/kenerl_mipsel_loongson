Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 18:04:00 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:62853 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860072AbaGJQD5PfOrW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2014 18:03:57 +0200
Received: by mail-ob0-f178.google.com with SMTP id nu7so2314040obb.9
        for <linux-mips@linux-mips.org>; Thu, 10 Jul 2014 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ihySoauN2te6beIA1tYs/mthI5wQER7tuZlAALBB1nQ=;
        b=FQMoeO0L2ExlmH6OHW6ydp/mpq3EFK/DZm5LPLNQ8G+0MTvilDQJjEaGEj7y69GZAw
         rge5vMSjSy9GXtJL48cwIC9v8T0tWjVT+HfMeBxzSLUTRvHarGyhOlXisWb0bmLFcIb3
         irKl2QS3HiH78ePtP23ARJl9l1jyUFlHISs38mFZsMmD7QL7e04vBbvHFZt8hytzUY1s
         4d9b0AGllT4910VaYYHQ75QO2v7ShkPpl2996qMQyi4mbZpGENFjAk2bqBYR7MDnafKi
         u2vfxtcvM4hECDrkBO51EF7PzH8T186jufkbyHGuQ1jpx5mCr2Gzpxf6sFQJrdK2rBOT
         ktTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ihySoauN2te6beIA1tYs/mthI5wQER7tuZlAALBB1nQ=;
        b=WREY6kq4mgP+Er4yucUI6vhnoGU77Z9e6DxP3i7tyUH4+qKHt8P7hN006WlkBr9hWu
         F16g5n1pqxcqLFNWJpW/W7QaAQkUH3X9ouwNU2GxU0SbBTJtoYndkAuNjmnYsNjtej7Z
         B7XdP/S19Zghz7RSh/LaDf/mDThFRigujjVDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ihySoauN2te6beIA1tYs/mthI5wQER7tuZlAALBB1nQ=;
        b=Mx+PfKbVxY6ljtm6/hYVuja4tYMrKBy72kG1Td2MUXTXgy3zBmnCby1MSSgVaPa6q7
         XbgJSF0e6RbD1EbQ0pPO2qrcHd0OgfuaeSIqZ6f2y9ssxp/hbazH3hsWB0AAPjdcDXYL
         k3ZJVtrapB0ZtCUqcwSsHL7Agvfms+1RGzV2P4YsBS6ygNauIQHQEoJuK/KnxHV5BO37
         8Uy1dfuA4KSXlZITDYCwQiVAFHFrSF/+yppar7z0n4f7ZgEg4Zx6pOsfSZjciLRtl2+6
         28o0d9NuRQzo5VAGfwsQdLE0yl3AFaK+7oJ3mspfH/r6PajyXXVGsXuyj56mgE36c9jg
         JEbA==
X-Gm-Message-State: ALoCoQmWFxNveogapnigczmQGWQMpOojSgDAHrVPro3K3aTWio3CPK/1PwX8MCuNglZiyU0sZIYP
MIME-Version: 1.0
X-Received: by 10.182.181.42 with SMTP id dt10mr11574313obc.69.1405008230305;
 Thu, 10 Jul 2014 09:03:50 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Thu, 10 Jul 2014 09:03:50 -0700 (PDT)
In-Reply-To: <20140710150832.GA20861@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
        <1403911380-27787-12-git-send-email-keescook@chromium.org>
        <20140709180520.GA2560@redhat.com>
        <CAGXu5jLUqz-T1tRBCpPLkzWijyAF-Vjw_7PnQ1EvUh4urwyaUg@mail.gmail.com>
        <20140710150832.GA20861@redhat.com>
Date:   Thu, 10 Jul 2014 09:03:50 -0700
X-Google-Sender-Auth: nVp9CbmgbGU1uPKFt_FQNOnvRqs
Message-ID: <CAGXu5jK_BBAexok1G1vbxL6764n+7h1kLRSu074MMFzF0QrafQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
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
X-archive-position: 41116
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

On Thu, Jul 10, 2014 at 8:08 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/10, Kees Cook wrote:
>>
>> On Wed, Jul 9, 2014 at 11:05 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> >> +     /*
>> >> +      * Make sure we cannot change seccomp or nnp state via TSYNC
>> >> +      * while another thread is in the middle of calling exec.
>> >> +      */
>> >> +     if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
>> >> +         mutex_lock_killable(&current->signal->cred_guard_mutex))
>> >> +             goto out_free;
>> >
>> > -EINVAL looks a bit confusing in this case, but this is cosemtic because
>> > userspace won't see this error-code anyway.
>>
>> Happy to use whatever since, as you say, it's cosmetic. Perhaps -EAGAIN?
>
> Or -EINTR. I do not really mind, I only mentioned this because I had another
> nit.
>
>> >>       spin_lock_irq(&current->sighand->siglock);
>> >> +     if (unlikely(signal_group_exit(current->signal))) {
>> >> +             /* If thread is dying, return to process the signal. */
>> >
>> > OK, this doesn't hurt, but why?
>> >
>> > You could check __fatal_signal_pending() with the same effect. And since
>> > we hold this mutex, exec (de_thread) can be the source of that SIGKILL.
>> > We take this mutex specially to avoid the race with exec.
>> >
>> > So why do we need to abort if we race with kill() or exit_grouo() ?
>>
>> In my initial code inspection that we could block waiting for the
>> cred_guard mutex, with exec holding it, exec would schedule death in
>> de_thread, and then once it released, the tsync thread would try to
>> keep running.
>>
>> However, in looking at this again, now I'm concerned this produces a
>> dead-lock in de_thread, since it waits for all threads to actually
>> die, but tsync will be waiting with the killable mutex.
>
> That is why you should always use _killable (or _interruptible) if you
> want to take ->cred_guard_mutex.
>
> If this thread races with de_thread() which holds this mutex, it will
> be killed and mutex_lock_killable() will fail.
>
> (to clarify; this deadlock is not "fatal", de_thread() can be killed too,
>  but this doesn't really matter).
>
>> So I think I got too defensive when I read the top of de_thread where
>> it checks for pending signals itself.
>>
>> It seems like I can just safely remove the singal_group_exit checks?
>> The other paths (non-tsync seccomp_set_mode_filter, and
>> seccomp_set_mode_strict)
>
> Yes, I missed another signal_group_exit() in seccomp_set_mode_strict().
> It looks equally unneeded.
>
>> I can't decide which feels cleaner: just letting stuff
>> clean up naturally on death or to short-circuit after taking
>> sighand->siglock.
>
> I'd prefer to simply remove the singal_group_exit checks.
>
> I won't argue if you prefer to keep them, but then please add a comment
> to explain that this is not needed for correctness.
>
> Because otherwise the code looks confusing, as if there is a subtle reason
> why we must not do this if killed.

Sounds good! I'll clean it all up for v10.

-Kees

-- 
Kees Cook
Chrome OS Security
