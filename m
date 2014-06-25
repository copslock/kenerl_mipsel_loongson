Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 17:08:19 +0200 (CEST)
Received: from mail-oa0-f48.google.com ([209.85.219.48]:58264 "EHLO
        mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859626AbaFYPIRc3EJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 17:08:17 +0200
Received: by mail-oa0-f48.google.com with SMTP id m1so2250210oag.35
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RPRkHElKoRY56C+gf2FLTCdORrBGECka4D3omf19jyI=;
        b=ZtGUOXe3i7YQNHgILzKlyepxwBESDp23bdFzVii6fj0bbiR8mVG/OoAcYFFRdlckb8
         Y/gMH3MdFoY+5qe3lGD4Bi6fr6Z5FEod4IFAufcRC0Lm/XXSEwyPj8/Uz2GCwBwp4THi
         zd6VzQyJf9z322c/Fht12U8WJ3+YGgLZoMIomR83WR1CPbgB4JG0htW+VbIT8pshDMIO
         GS/5ftAe+HbVomm9EbiAy3XPNSl4xt24N2YiHJyeOOTao7FjvoYYrukMrKFc3/n4N/G5
         Zw2yL8bVMFoj/GayB6TRO1EvkhF757POgDdyu4VJDaHxRbHJTzevhM3Jeb57W0qaeNHF
         Bcig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RPRkHElKoRY56C+gf2FLTCdORrBGECka4D3omf19jyI=;
        b=P3WAERfYnxvUz48q2W5hDz45iOLPGvKDmMyJZ7IzmD0SUCV8IO8YzOmGVsBXllgt4o
         aGdDSrJ3jb+DL44aUbfTlh6m/AhSj/p6QKzz1eq4rQ0bNGBenBCCqhWgvlEOei8W3PlO
         VRuqlLr3deHIdhbNDn95wDyh8guFNZfyzFCNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RPRkHElKoRY56C+gf2FLTCdORrBGECka4D3omf19jyI=;
        b=JW0oZ9YcDXhqAaPXeKOQFf/p+ONlt98Fw9TcJ2Fflcgq+YYEudv3hvEWxReGvw0hVy
         38XaI4lZzPxyVLcmvwolRXQf1GDTkgQ6DzJy6EjftP0Ugc4AzsmRCB4t/k/5QiYEum2M
         5LKO7Lbw2os63VDvCxnenhz9EbENKXCm2rKsyWCdyQY+6GXioO8JLRiTOee8P3Y2VYng
         CBaAVPWeqho/bZ0wcgiUmC+j1wNK9LyGD2kjYwcOm6lKI3gX7/+6tWDN5p/Zl8L5XDQD
         lCDLJAbzNO0RnIIlg3sz0X3O4a/OSsiI021sd9S2b/R+uiUCOzKCNxbyJhmh4qNrsO9p
         ruZg==
X-Gm-Message-State: ALoCoQn8pDzhudn+jKDT7SbWdJqB6LjoTmRG5glZrbQx6KRibxZD2b0CZo5B6XXwTwFm8/teFhM4
MIME-Version: 1.0
X-Received: by 10.60.175.34 with SMTP id bx2mr8630411oec.49.1403708891523;
 Wed, 25 Jun 2014 08:08:11 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 08:08:11 -0700 (PDT)
In-Reply-To: <20140625142121.GD7892@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-10-git-send-email-keescook@chromium.org>
        <20140625142121.GD7892@redhat.com>
Date:   Wed, 25 Jun 2014 08:08:11 -0700
X-Google-Sender-Auth: r_1Qo0KhVxpzl5aIumz0oJDUf2o
Message-ID: <CAGXu5jJtLrjbobZC1FD4WV-Jm2p7cRGa1aSPK-d_isnfCZAHdA@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
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
X-archive-position: 40813
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

On Wed, Jun 25, 2014 at 7:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Kees Cook wrote:
>>
>> +static void seccomp_sync_threads(void)
>> +{
>> +     struct task_struct *thread, *caller;
>> +
>> +     BUG_ON(!spin_is_locked(&current->sighand->siglock));
>> +
>> +     /* Synchronize all threads. */
>> +     caller = current;
>> +     for_each_thread(caller, thread) {
>> +             /* Get a task reference for the new leaf node. */
>> +             get_seccomp_filter(caller);
>> +             /*
>> +              * Drop the task reference to the shared ancestor since
>> +              * current's path will hold a reference.  (This also
>> +              * allows a put before the assignment.)
>> +              */
>> +             put_seccomp_filter(thread);
>> +             thread->seccomp.filter = caller->seccomp.filter;
>> +             /* Opt the other thread into seccomp if needed.
>> +              * As threads are considered to be trust-realm
>> +              * equivalent (see ptrace_may_access), it is safe to
>> +              * allow one thread to transition the other.
>> +              */
>> +             if (thread->seccomp.mode == SECCOMP_MODE_DISABLED) {
>> +                     /*
>> +                      * Don't let an unprivileged task work around
>> +                      * the no_new_privs restriction by creating
>> +                      * a thread that sets it up, enters seccomp,
>> +                      * then dies.
>> +                      */
>> +                     if (task_no_new_privs(caller))
>> +                             task_set_no_new_privs(thread);
>> +
>> +                     seccomp_assign_mode(thread, SECCOMP_MODE_FILTER);
>> +             }
>> +     }
>> +}
>
> OK, personally I think this all make sense. I even think that perhaps
> SECCOMP_FILTER_FLAG_TSYNC should allow filter == NULL, a thread might
> want to "sync" without adding the new filter, but this is minor/offtopic.
>
> But. Doesn't this change add a new security hole?
>
> Obviously, we should not allow to install a filter and then (say) exec
> a suid binary, that is why we have no_new_privs/LSM_UNSAFE_NO_NEW_PRIVS.
>
> But what if "thread->seccomp.filter = caller->seccomp.filter" races with
> any user of task_no_new_privs() ? Say, suppose this thread has already
> passed check_unsafe_exec/etc and it is going to exec the suid binary?

Oh, ew. Yeah. It looks like there's a cred lock to be held to combat this?

I wonder if changes to nnp need to "flushed" during syscall entry
instead of getting updated externally/asynchronously? That way it
won't be out of sync with the seccomp mode/filters.

Perhaps secure computing needs to check some (maybe seccomp-only)
atomic flags and flip on the "real" nnp if found?

-Kees

-- 
Kees Cook
Chrome OS Security
