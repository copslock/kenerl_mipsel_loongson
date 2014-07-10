Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 11:17:39 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35671 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822330AbaGJJRg59uNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2014 11:17:36 +0200
Received: by mail-ob0-f182.google.com with SMTP id wm4so3528803obc.27
        for <linux-mips@linux-mips.org>; Thu, 10 Jul 2014 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rfBw3SoL9WpMvskk2XAnqvY/FeFh/k6Vn1krk9lYOxg=;
        b=mMTLEYQAWWW9Hy12wj7imkeoCXa3yG7YgQ79J6Pi0UCY52wIt9ns9j4PN6cQ+qG89M
         i6G1EJHp2C0p7FPRUJj348utt7ee0ezL7yMcLTLQv+YLQWqiC4lCazMkiyAzEZkC/h/J
         Y8T+GuSpQR2yZBoLlZAWgRkaxJUEQnTpxOsrkSIvoFvvgoVsRNtQ0AvWiheJXISCjeVv
         iFYqJTn6NwQvWjAV+V/qSx9MMxyBLyPnudlfCUbEyZeLk3YfiJfYa3gTWsQIcAL47KAx
         KnfH7v7kJY9AUYnc6v1yJccSI8jlgfQsfMn4J0Qx2JC0b3xC0nZ3B/OWGmkYZjjtemPx
         /vYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rfBw3SoL9WpMvskk2XAnqvY/FeFh/k6Vn1krk9lYOxg=;
        b=jwaxiODiJ7WuzWMnFDO5fxa/9aKZ1GyMNzg304K+YTWJQaVhC/A3RB51ficT2o2oC3
         XssJJrGXT+vHKBsNEPxcWgYRcRVfbTnjPaD69nQjzpaXUwR+zdqw749YpHhaNwo0bFvW
         4nRBotTPUe7xJT7bSQVsNj/9cRQI1kExfLXJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rfBw3SoL9WpMvskk2XAnqvY/FeFh/k6Vn1krk9lYOxg=;
        b=XAXczwon6rfYsOYUj9LzTBASS5Sdu6C/SOgtev56KV7GzJvwQBZh09bGjkUz5+XAIl
         YzxZwk7xHPm4nAt34jx3y8eeWiHh7cOlVcI6YRBH6C2LzNat6RJ/AvlnQ91CzGFNIJ8K
         fT2ZLVAsVRcgqEv6X1qd58spZb6BIHJyDLgh0rgWOwV/nthHWKsbO4YZl2JLlXPx2P3c
         JqnZoNIImTLuIWb1ahYbCg0avVHUjEGV2nURfwL7DoLa1AOvonu6fu5MvJkWQGNuvedZ
         +fMclDGLEDZs4vcyl3gLcSJt885xVl+2iYgoKTx7T4JOQSat0kph4UL8+SSoCjLrP2zb
         /yvA==
X-Gm-Message-State: ALoCoQnyZBMz4CoMkPV6B+usrYyMGmJ62rKm7lHlLh6cpK+3CGz1spZNTilbvUpDBCVgxtUjt3OK
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr1497860obx.79.1404983850805; Thu,
 10 Jul 2014 02:17:30 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Thu, 10 Jul 2014 02:17:30 -0700 (PDT)
In-Reply-To: <20140709180520.GA2560@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
        <1403911380-27787-12-git-send-email-keescook@chromium.org>
        <20140709180520.GA2560@redhat.com>
Date:   Thu, 10 Jul 2014 02:17:30 -0700
X-Google-Sender-Auth: 7ZbNj-d5730bEsWUiJjhhcizYOc
Message-ID: <CAGXu5jLUqz-T1tRBCpPLkzWijyAF-Vjw_7PnQ1EvUh4urwyaUg@mail.gmail.com>
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
X-archive-position: 41108
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

On Wed, Jul 9, 2014 at 11:05 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> First of all, sorry for delay ;)
>
> So far I quickly glanced at this series and everything look fine, but
> I am confused by the signal_group_exit() check,
>
> On 06/27, Kees Cook wrote:
>>
>> To make sure that de_thread() is actually able
>> to kill other threads during an exec, any sighand holders need to check
>> if they've been scheduled to be killed, and to give up on their work.
>
> Probably this connects to that check below? I can't understand this...
>
>> +     /*
>> +      * Make sure we cannot change seccomp or nnp state via TSYNC
>> +      * while another thread is in the middle of calling exec.
>> +      */
>> +     if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
>> +         mutex_lock_killable(&current->signal->cred_guard_mutex))
>> +             goto out_free;
>
> -EINVAL looks a bit confusing in this case, but this is cosemtic because
> userspace won't see this error-code anyway.

Happy to use whatever since, as you say, it's cosmetic. Perhaps -EAGAIN?

>
>>       spin_lock_irq(&current->sighand->siglock);
>> +     if (unlikely(signal_group_exit(current->signal))) {
>> +             /* If thread is dying, return to process the signal. */
>
> OK, this doesn't hurt, but why?
>
> You could check __fatal_signal_pending() with the same effect. And since
> we hold this mutex, exec (de_thread) can be the source of that SIGKILL.
> We take this mutex specially to avoid the race with exec.
>
> So why do we need to abort if we race with kill() or exit_grouo() ?

In my initial code inspection that we could block waiting for the
cred_guard mutex, with exec holding it, exec would schedule death in
de_thread, and then once it released, the tsync thread would try to
keep running.

However, in looking at this again, now I'm concerned this produces a
dead-lock in de_thread, since it waits for all threads to actually
die, but tsync will be waiting with the killable mutex.

So I think I got too defensive when I read the top of de_thread where
it checks for pending signals itself.

It seems like I can just safely remove the singal_group_exit checks?
The other paths (non-tsync seccomp_set_mode_filter, and
seccomp_set_mode_strict) would just run until it finished the syscall,
and then died. I can't decide which feels cleaner: just letting stuff
clean up naturally on death or to short-circuit after taking
sighand->siglock.

What do you think?

-Kees

-- 
Kees Cook
Chrome OS Security
