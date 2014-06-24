Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:08:27 +0200 (CEST)
Received: from mail-oa0-f48.google.com ([209.85.219.48]:40356 "EHLO
        mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854779AbaFXTIXRZlul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:08:23 +0200
Received: by mail-oa0-f48.google.com with SMTP id m1so850199oag.21
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MEFa9FqyVv/Lbj9F4ort24vZJFJS488HF8BbcREJKdo=;
        b=S8X8MQQYt/zm3E7UHHGS/a1iLdZR5e4eV1bICEVYCqPfqxf8zJtUB/oFg2IY10SSBx
         AMRkL5IBjvD4Nna66Fl69xPvYcLomD0J8ybbz2mxLp2sX2xWEJfrfyBveJriDDPgYwVM
         zFiKan7xVGvnuiepKPUGE1JO+OluN4QttW/UQ3eWdPRT43g/nVVZ+08Oc14pSvE+YZKf
         fzE61WDdmkKmGsJnhxZAnsm9IBZ4cFMi/wEEi3P8yGngTVsGWnwwB/UP/9sOXMn5q3D3
         nrCX80lnxY910Fd4zcMlmO7LWJU33G1Epw8nTbcUn2JgopIQXK9DJ8i7D0U6ytw4b3RM
         ZKHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MEFa9FqyVv/Lbj9F4ort24vZJFJS488HF8BbcREJKdo=;
        b=KB3W4l7vs4b3gR8Qm43wrZLnAIcWpSvSZXFKei9AiFwewbHzuuVIFbkS4fgp0bucr/
         ONZ/fi/MYXFg90nGkfcmOph0wcu6OuN9CbaRHXegzLtul6i6GAFK6A/OfH16WIxHErN8
         AesPGQIhOQnQCf0/KSv13bTK1r8srMb/T0Z0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MEFa9FqyVv/Lbj9F4ort24vZJFJS488HF8BbcREJKdo=;
        b=OMsM6eqaKS7hQjjKnJ7QEofvyhGidWF0BmkjEBixB+gpINIse3y/U20QTTLZIJxvya
         OAaVM7I/0M/dN6NmSMC1uwtExM6zcN3kN4uCyvW9IRt6tJAxLwrcVL9URQ1yH60e5yq0
         obyHygiv9bu8qJ4KF1crRB4k8DB/a0NAVfgp3uxw7okq8OQ4bmXg9cnCJJL4jzSmam7J
         IN3GPysVSrG60a8Tm0WzKeJk0o/n7V0HAPguXZB9nlArsEfuA+5AQ0af+S7U1dhC71Sl
         Jm5e7G3iR54dMvDR+7m18FGRXsNM84gm+wv7mpc46ufx/GEIDsluFzE80En/NhSZsr9g
         PSFA==
X-Gm-Message-State: ALoCoQmYjpaL7y0PvD8PU+uMS5PkXreSY+Ekx9ch05hmlQ1OH0Kl1bA06IxhMdNYiMaBifEtLL2x
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr2861765obx.79.1403636896839; Tue,
 24 Jun 2014 12:08:16 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 12:08:16 -0700 (PDT)
In-Reply-To: <20140624183749.GC1258@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <1403560693-21809-8-git-send-email-keescook@chromium.org>
        <20140624172753.GA31435@redhat.com>
        <CAGXu5jKoDEXffJqFSjhO+D=5toJOA=KAomi+LQOahPDYKFbEdg@mail.gmail.com>
        <20140624183749.GC1258@redhat.com>
Date:   Tue, 24 Jun 2014 12:08:16 -0700
X-Google-Sender-Auth: jtcyTBS-8hLg3tdrJqFc-3Cbong
Message-ID: <CAGXu5jKwF1cbc=4O5nXDKZT8HF7grCm+AaRz7v1VCdPVMRX-3A@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
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
X-archive-position: 40762
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

On Tue, Jun 24, 2014 at 11:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Kees Cook wrote:
>>
>> On Tue, Jun 24, 2014 at 10:27 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > On 06/23, Kees Cook wrote:
>> >>
>> >> +static pid_t seccomp_can_sync_threads(void)
>> >> +{
>> >> +     struct task_struct *thread, *caller;
>> >> +
>> >> +     BUG_ON(write_can_lock(&tasklist_lock));
>> >> +     BUG_ON(!spin_is_locked(&current->sighand->siglock));
>> >> +
>> >> +     if (current->seccomp.mode != SECCOMP_MODE_FILTER)
>> >> +             return -EACCES;
>> >> +
>> >> +     /* Validate all threads being eligible for synchronization. */
>> >> +     thread = caller = current;
>> >> +     for_each_thread(caller, thread) {
>> >> +             pid_t failed;
>> >> +
>> >> +             if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
>> >> +                 (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
>> >> +                  is_ancestor(thread->seccomp.filter,
>> >> +                              caller->seccomp.filter)))
>> >> +                     continue;
>> >> +
>> >> +             /* Return the first thread that cannot be synchronized. */
>> >> +             failed = task_pid_vnr(thread);
>> >> +             /* If the pid cannot be resolved, then return -ESRCH */
>> >> +             if (failed == 0)
>> >> +                     failed = -ESRCH;
>> >
>> > forgot to mention, task_pid_vnr() can't fail. sighand->siglock is held,
>> > for_each_thread() can't see a thread which has passed unhash_process().
>>
>> Certainly good to know, but I'd be much more comfortable leaving this
>> check as-is. Having "failed" return with "0" would be very very bad
>> (userspace would think the filter had been successfully applied, etc).
>> I'd rather stay highly defensive here.
>
> OK, agreed. Although in this case I'd suggest
>
>                 if (WARN_ON(failed == 0))
>                         failed = -ESRCH;
>
> but I won't insist.

Excellent idea, yes! I'll include this as well.

-Kees

-- 
Kees Cook
Chrome OS Security
