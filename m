Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 20:02:12 +0200 (CEST)
Received: from mail-oa0-f42.google.com ([209.85.219.42]:33003 "EHLO
        mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822276AbaFXSCK4PLJF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 20:02:10 +0200
Received: by mail-oa0-f42.google.com with SMTP id eb12so773128oac.29
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4LK+gUFJix3bLooJLo0ia10gBQGT/wCnvVBkpd6BABg=;
        b=jxui4TVScstiIKSwsW+vvbuifbOLaTHqpyrCMudr9it/wJL5O9rPqHKzOUcGXNq4BA
         hKt/Z1OIT3YXeX0kib3yW1qCCedttCG1EY2kkYpNdWDKs1jkW+/vYmBK4Kg0mm9iFwWd
         rLpwwii6ENSz4i6Vv4HXxjErRfkUX5P/wsZ/qUr/S6Yjyxg+4jXtBu5NCrByas32z060
         l1RNHoC9H03fJrkWk2RYXO8jgQFqpHc9b33Sss35Wj7FCwi0z4/v4HoAgFCHPL/Mg9dH
         nJzHgLqWkN6kyvfY4BfjUvTsL0q17GsxU1l8u9IR3ZwbcishjiSAMda0sqSI7dyTMar0
         /15A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4LK+gUFJix3bLooJLo0ia10gBQGT/wCnvVBkpd6BABg=;
        b=mpz3/Qp91Nzayy3H20khtmqDzr1AAcwisnCV5x1v97FlISPRZNcn1/Nko3hU8yK+0z
         BhO3KO97zmL5Mbc2Sk6SPKotRLsnudEXaLCqnm7TvZVSuWIIPOx1ZqMBOMaCPv/EZnjy
         Zpj/U7dxY5eyn/sMTNlqqSojWXSvXvb7Xu3EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4LK+gUFJix3bLooJLo0ia10gBQGT/wCnvVBkpd6BABg=;
        b=en4JlxnqueOdIAQHcHSOWmlh+qJHrHL39cdu4yRMySf3qAhV2Wt65DftGr+47O0D0k
         0tIuAp9VIthGxz645u2vDdHu25oxk/jScE4A93xBuEQWGbusGEtT4j1fzK84YDTOuEz4
         mQf4XF7SAl/AsJkGsu15A+8EG+onu7cO5Lt4Z3jsQvDcm8TfY4Er/Qvls3uAYjfGwsYq
         GK+1QjlIjVH9pcgZ9oDf4pk1hUyv7anI4obqbsuph7kYQXqjRLBDCXZLrl/aolZOOJaf
         wQQrw764f5QvUadNf4Ss3Rc2pa0xKSzeECEWHeAwWDlk9R1EuFHGeM8Fx6jzRYGCgqLm
         zfsA==
X-Gm-Message-State: ALoCoQml9t17qq/basAJRDG2oZ7HmAoAy9JzuLUJObk/W6e2p3y+/gUXRbWndQzyKXq5vsDnkYZF
MIME-Version: 1.0
X-Received: by 10.182.65.167 with SMTP id y7mr2592761obs.29.1403632924456;
 Tue, 24 Jun 2014 11:02:04 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 11:02:04 -0700 (PDT)
In-Reply-To: <20140624165216.GA29272@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <1403560693-21809-4-git-send-email-keescook@chromium.org>
        <20140624165216.GA29272@redhat.com>
Date:   Tue, 24 Jun 2014 11:02:04 -0700
X-Google-Sender-Auth: VjwTwMiWAlt1LW-P62uIPo62kpo
Message-ID: <CAGXu5j+G8qAkGD7H=3R2iw2ZTqZSrMPa2f=czoEjwSW5wKqUWQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] seccomp: introduce writer locking
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
X-archive-position: 40755
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

On Tue, Jun 24, 2014 at 9:52 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> Kees,
>
> I am still trying to force myself to read and try to understand what
> this series does ;) Just a minor nit so far.

The use-case this solves is when a userspace process does not control
(or know) when a thread is spawned (e.g. via shared library init, or
LD_PRELOAD) but wants to make sure seccomp filters have been applied
to it. Specifically, Chrome, when loading some proprietary graphics
drivers, will have those drivers spawning threads before there has
been an ability to call seccomp. While some games can be played to get
ahead of it, it's not always possible, or racey, depending on the
drivers. With seccomp thread-sync, we can be certain that all threads
have had the filter applied.

>
> On 06/23, Kees Cook wrote:
>>
>> @@ -1142,6 +1168,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>>  {
>>       int retval;
>>       struct task_struct *p;
>> +     unsigned long irqflags;
>>
>>       if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
>>               return ERR_PTR(-EINVAL);
>> @@ -1196,7 +1223,6 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>>               goto fork_out;
>>
>>       ftrace_graph_init_task(p);
>> -     get_seccomp_filter(p);
>>
>>       rt_mutex_init_task(p);
>>
>> @@ -1434,7 +1460,13 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>>               p->parent_exec_id = current->self_exec_id;
>>       }
>>
>> -     spin_lock(&current->sighand->siglock);
>> +     spin_lock_irqsave(&current->sighand->siglock, irqflags);
>> +
>> +     /*
>> +      * Copy seccomp details explicitly here, in case they were changed
>> +      * before holding tasklist_lock.
>> +      */
>> +     copy_seccomp(p);
>>
>>       /*
>>        * Process group and session signals need to be delivered to just the
>> @@ -1446,7 +1478,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>>       */
>>       recalc_sigpending();
>>       if (signal_pending(current)) {
>> -             spin_unlock(&current->sighand->siglock);
>> +             spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>>               write_unlock_irq(&tasklist_lock);
>>               retval = -ERESTARTNOINTR;
>>               goto bad_fork_free_pid;
>> @@ -1486,7 +1518,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>>       }
>>
>>       total_forks++;
>> -     spin_unlock(&current->sighand->siglock);
>> +     spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>>       write_unlock_irq(&tasklist_lock);
>>       proc_fork_connector(p);
>>       cgroup_post_fork(p);
>
> It seems that the only change copy_process() needs is copy_seccomp() under the locks.
> Everythinh else (irqflags games) looks obviously unneeded?

I got irq lock dep warnings without these changes. If they're
unneeded, that's totally fine by me, but some change (either this or
markings to keep lockdep happy) is needed.

>> @@ -524,6 +528,9 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>>       }
>>  #endif
>>
>> +     if (unlikely(!lock_task_sighand(current, &irqflags)))
>> +             goto out_free;
>> +
>
> Unless this task is exiting (namely, it has already called exit_notify()),
> lock_task_sighand(current) must not fail. Looks like you can simply do
> spin_lock_irq(->siglock).

Okay. I wasn't sure if I needed to be extra careful here or not. I
opted for just using lock_task_sighand since that seemed to be the
most used. :)

-Kees

-- 
Kees Cook
Chrome OS Security
