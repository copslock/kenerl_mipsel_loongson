Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 17:05:30 +0200 (CEST)
Received: from mail-vc0-f173.google.com ([209.85.220.173]:34011 "EHLO
        mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861326AbaGQPF0kYYvV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 17:05:26 +0200
Received: by mail-vc0-f173.google.com with SMTP id hy10so4842894vcb.18
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4hHvJEFCj1npgwe/zEiH0NA/ymJzWjzJW3EICmqlm2Y=;
        b=Mu6oru8r+/Lp0wGEmE0bmKe6k3SoUYOtmxxlcEvnnYqy29RWjTDEOQriUfIZFRxwAn
         tzAuulSSDvR1O3bzfg8I1wBbwqkpnoTpUs/S67gcOfTfkxVzRhPsBQXnz13Hom3NBL5b
         pi0+yZXn3kz5AAQj0UPeBnpWOGVCSCDm+7tylpatYTfEk1tBf30Mxh1xMCKh+fCRfzDe
         hB72VJNyA5jBoTOgTZghdJdSEGtR7S+x4XxyaIUuOEzUaMdcCixNBSDH4HhkyBZWYLQ+
         9eZdBbM9RgJdRacyXJJ0S3c7eHOpA+ViSqbcY3JQ9/rm+RQwLLAGUJOUiresClbyWx75
         PUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4hHvJEFCj1npgwe/zEiH0NA/ymJzWjzJW3EICmqlm2Y=;
        b=aw9aQWOmqDZph/dbL9kv73aXgSUzHMuQZ6kengrr6rLOamDYneGFxAgVBaNMK07vO8
         UNCgCHXGN7/3EMGpvKx35/8NzEQ4bXeKVZVxS+cGZmLILTlKh9sERC5s9Vz+/f2SkMIY
         n7wId6jLUVdAP/CXCRQkSsaXOPO7nvUwwFVb0JzgXrG7zUX1qs9yv8h1n6WHhuQ//LNV
         RUQPavx2dt2s9SXf/VYdD4Fhar6S6AIwrWFZNdVR/2EkOq9pMwH79AAurNQUnIVsUfIc
         19m/Ck2X9aZw3V+SwVPOgc/DGse9dptTHwbIsC3W9TUdubacSKw1X+oVvPHujuUzNzNS
         pMFg==
X-Gm-Message-State: ALoCoQmFSd/afvQxtsRKJ87Qm7WPITPPFx1KAA1yjEGqj2GbmfvGy1TM7O/jWl9VF+eC1SO2gsnw
X-Received: by 10.52.129.200 with SMTP id ny8mr6100016vdb.27.1405609516353;
 Thu, 17 Jul 2014 08:05:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.96.168 with HTTP; Thu, 17 Jul 2014 08:04:56 -0700 (PDT)
In-Reply-To: <1405547442-26641-12-git-send-email-keescook@chromium.org>
References: <1405547442-26641-1-git-send-email-keescook@chromium.org> <1405547442-26641-12-git-send-email-keescook@chromium.org>
From:   David Drysdale <drysdale@google.com>
Date:   Thu, 17 Jul 2014 16:04:56 +0100
Message-ID: <CAHse=S_32tmusk4ceY4U6GbNpX4PkX12iPPDZFVZ7qgv-RAooA@mail.gmail.com>
Subject: Re: [PATCH v11 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <drysdale@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drysdale@google.com
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

On Wed, Jul 16, 2014 at 10:50 PM, Kees Cook <keescook@chromium.org> wrote:
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 9065d2c79c56..2125b83ccfd4 100644
> +/**
> + * seccomp_can_sync_threads: checks if all threads can be synchronized
> + *
> + * Expects sighand and cred_guard_mutex locks to be held.
> + *
> + * Returns 0 on success, -ve on error, or the pid of a thread which was
> + * either not in the correct seccomp mode or it did not have an ancestral
> + * seccomp filter.
> + */
> +static inline pid_t seccomp_can_sync_threads(void)
> +{
> +       struct task_struct *thread, *caller;
> +
> +       BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
> +       BUG_ON(!spin_is_locked(&current->sighand->siglock));
> +
> +       if (current->seccomp.mode != SECCOMP_MODE_FILTER)
> +               return -EACCES;

Quick question -- is it possible to apply the first filter and also synchronize
it across threads in the same operation?  If so, does this arm also need to
cope with seccomp.mode being SECCOMP_MODE_DISABLED?

[seccomp_set_mode_filter() looks to call this via seccomp_attach_filter()
before it does seccomp_assign_mode()]

> +
> +       /* Validate all threads being eligible for synchronization. */
> +       caller = current;
> +       for_each_thread(caller, thread) {
> +               pid_t failed;
> +
> +               if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
> +                   (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
> +                    is_ancestor(thread->seccomp.filter,
> +                                caller->seccomp.filter)))
> +                       continue;
> +
> +               /* Return the first thread that cannot be synchronized. */
> +               failed = task_pid_vnr(thread);
> +               /* If the pid cannot be resolved, then return -ESRCH */
> +               if (unlikely(WARN_ON(failed == 0)))
> +                       failed = -ESRCH;
> +               return failed;
> +       }
> +
> +       return 0;
> +}
