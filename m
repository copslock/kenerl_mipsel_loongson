Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 20:05:35 +0200 (CEST)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:47687 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822276AbaFXSF300l2s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 20:05:29 +0200
Received: by mail-ob0-f180.google.com with SMTP id vb8so767020obc.11
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FT4rUkLtMfwg/jZXudqKcL5MMBVZdM8howOmm9jToIw=;
        b=pa6rvOM7aoXUcbYgQshBcc7skZWPHBYd8mFdBm9F/NWfu+aoqgBtcxQlftlj42EPUP
         adSuoqtG+kvWNaK/wrDuUVtQyUIpXsTWXi7S4TZjDPNWNkyeJGtnokFH8VniXlYn7gs7
         htP/grnkBLCwwKSZcEfcziAk5YbbQ4c7qUbFUtZK/g89LNaLGvnv6LtyMs/836CeRzAp
         2Ei4N6Lzh0a1BEI76g5ACDu1z3Z9erJOVP/dpl2xYkdJcVZRzaQBdzHWFHvGXFh62g/x
         4G2ek3apnbKCuBeoDji2LgC2E7k+Wa48ScaMTte5aoyDM9HXYQLBgIkRjkEA9u4XPi2r
         YuJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FT4rUkLtMfwg/jZXudqKcL5MMBVZdM8howOmm9jToIw=;
        b=GkRZt0mEk6LXgj2ifXR+QD+TCboW3NYz1dohqdmLpt53vSvEDtuzBiRjT/7XjwhPs8
         t7hGPlmmvwNsnMX3+4NTjHXX177csKsceN7dIL1XyYcMVJ8ozkTj/5T7gYTgDzkvwV1/
         /9L4+d/5PFd0Yv8/7DYl8uImB8m+r/1u996Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FT4rUkLtMfwg/jZXudqKcL5MMBVZdM8howOmm9jToIw=;
        b=VBNQE28dVKkjfyEYn1eI6K9mQLUgjvES2sp1bFJN5rthOn83Tq1UKWZqfjWi9ZZED2
         0tuorrInx64iuTlskjJbYIi44TL7KyikzNKK9wjSgj7e/qd84fP7TR9fx9tRgU6qafhs
         55Ypv5PXub5vXhHtCj0bjWpqfDKZrUfhKaXHBFIyZF42JgmlT4kGIoyfpBjwR/m96wX/
         UTKcp7OETSubg0WwQIagwBaq6N5H+oitJxKlX6EdS9NsuxUQYrhR6yebGYGqPZGSlFBp
         FJIo7VnoISA/WVAnCJcXTxwOjxfGeSo+xaYo65pVIrPdeemGvCe+S7YqjWWaqkoY8NTt
         cuJw==
X-Gm-Message-State: ALoCoQk+tIqu6LnNpkDhbX0n2I58QslABXe5QHOollIvDWSKaa+FptPdzvfUGlm6JlIqry/IMwFU
MIME-Version: 1.0
X-Received: by 10.60.42.196 with SMTP id q4mr2564543oel.31.1403633123071; Tue,
 24 Jun 2014 11:05:23 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 11:05:22 -0700 (PDT)
In-Reply-To: <20140624172753.GA31435@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <1403560693-21809-8-git-send-email-keescook@chromium.org>
        <20140624172753.GA31435@redhat.com>
Date:   Tue, 24 Jun 2014 11:05:22 -0700
X-Google-Sender-Auth: 2Ce6EZN27Vjg_CpBPv3-BetKv9k
Message-ID: <CAGXu5jKoDEXffJqFSjhO+D=5toJOA=KAomi+LQOahPDYKFbEdg@mail.gmail.com>
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
X-archive-position: 40756
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

On Tue, Jun 24, 2014 at 10:27 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/23, Kees Cook wrote:
>>
>> +static pid_t seccomp_can_sync_threads(void)
>> +{
>> +     struct task_struct *thread, *caller;
>> +
>> +     BUG_ON(write_can_lock(&tasklist_lock));
>> +     BUG_ON(!spin_is_locked(&current->sighand->siglock));
>> +
>> +     if (current->seccomp.mode != SECCOMP_MODE_FILTER)
>> +             return -EACCES;
>> +
>> +     /* Validate all threads being eligible for synchronization. */
>> +     thread = caller = current;
>> +     for_each_thread(caller, thread) {
>> +             pid_t failed;
>> +
>> +             if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
>> +                 (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
>> +                  is_ancestor(thread->seccomp.filter,
>> +                              caller->seccomp.filter)))
>> +                     continue;
>> +
>> +             /* Return the first thread that cannot be synchronized. */
>> +             failed = task_pid_vnr(thread);
>> +             /* If the pid cannot be resolved, then return -ESRCH */
>> +             if (failed == 0)
>> +                     failed = -ESRCH;
>
> forgot to mention, task_pid_vnr() can't fail. sighand->siglock is held,
> for_each_thread() can't see a thread which has passed unhash_process().

Certainly good to know, but I'd be much more comfortable leaving this
check as-is. Having "failed" return with "0" would be very very bad
(userspace would think the filter had been successfully applied, etc).
I'd rather stay highly defensive here.

-Kees

-- 
Kees Cook
Chrome OS Security
