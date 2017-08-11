Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2017 00:17:37 +0200 (CEST)
Received: from mail-it0-x22c.google.com ([IPv6:2607:f8b0:4001:c0b::22c]:37915
        "EHLO mail-it0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994814AbdHKWRUIinMG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2017 00:17:20 +0200
Received: by mail-it0-x22c.google.com with SMTP id m34so1118008iti.1
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2017 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I3eEuqRqlP1sYvOkMAs+8DIvemOAKLMgPi2QLgNJsCA=;
        b=q2F6maB5I9/mOwLYpZqEkUQ2zt0ztCBOcMhFzQJ6xj3u5KltlXMR5xG4sxG5Md5jj2
         3ethidZGTRbClWOWj5s9IrcKYDvvvImdFmEVOFkECz7FBQ9l2f5zZGKK0s81NrOLbaEc
         lRPfASpSHM7hH/e7Qwca5z4V10fS9DbY1h5aMKAhmfHRDUpmshL4/TL1ff8XUyUJ6Imz
         kznlk9qkI7ra7PEMlD53WmXr6bt0POl+9TpGnNlQcv2z6myHUaQWIMig6fIxbGpKeVlA
         7oA7I84IFMC1yUwE2ai6qhYU1MzwTkjxhnkDFDEk9lka+pM4cq9LYbZuEytm6QF9an4d
         tV0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I3eEuqRqlP1sYvOkMAs+8DIvemOAKLMgPi2QLgNJsCA=;
        b=DqmNbIWHcBJ5o0EkBcsSsWDbyHoRHMNxbuGL3gR9zVTv5nfH9zkAv98bL+HrlcLZHN
         fL0BoEhk1U7muoZO9h7EFvfoI2z0H9D4pt+aigtFCqvO2mxsNnx00qsBe4Iga/mXsKiv
         6EnnmhdTTYoGkY0CPVvpypRbcmd1dSxKoZz3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I3eEuqRqlP1sYvOkMAs+8DIvemOAKLMgPi2QLgNJsCA=;
        b=DaQW1x/Of0xLsUgal53wzj4CJ9TnB738JRd+0qyawr7/yTd4ouY8LzXyyuYomrUgnm
         NwNwF8LP3QMqXwW+1I84/UC5wiTbYjif5Zbp7vcK7xslUngP4TNTCLidIiE7YbNA0Nvi
         8ACgfErVE8gx8BsMkanmfdI6qYQI/LdAYkQO7QvFVIf9otVlFsHj2BVpu6EDFTHRvsWi
         pNN7oKy2cFmts5U3FqngbL92S3085CwHWsDzOsBKcRg6loK3GouRJx03XGJm93ZQJjm0
         nhqSJemRk5mZdcuspR230VnyQMZW5VlzlARMYftHF7vrS4sTSL2f4GRaNXd2rwxG7S3z
         nRRA==
X-Gm-Message-State: AHYfb5jeRvd5wX8m3bD2N9TdAiGzkXkp+BSmDWCDN99IsCycWINHJXQ3
        f7vHA0j8mFCLUQ14NKojgLIw0IColHZG
X-Received: by 10.36.101.2 with SMTP id u2mr153724itb.38.1502489832722; Fri,
 11 Aug 2017 15:17:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.161 with HTTP; Fri, 11 Aug 2017 15:17:11 -0700 (PDT)
In-Reply-To: <20170811205653.21873-2-james.hogan@imgtec.com>
References: <20170811205653.21873-1-james.hogan@imgtec.com> <20170811205653.21873-2-james.hogan@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 11 Aug 2017 15:17:11 -0700
X-Google-Sender-Auth: Gr9W9oY4MINFvGN-fqMbNgtMMTw
Message-ID: <CAGXu5jKmDKZ5DPDC87ZqHtmRVac7t3kQ3nqY4YzargZZPQmW6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS/seccomp: Fix indirect syscall args
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59491
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

On Fri, Aug 11, 2017 at 1:56 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Since commit 669c4092225f ("MIPS: Give __secure_computing() access to
> syscall arguments."), upon syscall entry when seccomp is enabled,
> syscall_trace_enter() passes a carefully prepared struct seccomp_data
> containing syscall arguments to __secure_computing(). Unfortunately it
> directly uses mips_get_syscall_arg() and fails to take into account the
> indirect O32 system calls (i.e. syscall(2)) which put the system call
> number in a0 and have the arguments shifted up by one entry.
>
> We can't just revert that commit as samples/bpf/tracex5 would break
> again, so use syscall_get_arguments() which already takes indirect
> syscalls into account instead of directly using mips_get_syscall_arg(),
> similar to what populate_seccomp_data() does.
>
> This also removes the redundant error checking of the
> mips_get_syscall_arg() return value (get_user() already zeroes the
> result if an argument from the stack can't be loaded).
>
> Reported-by: James Cowgill <James.Cowgill@imgtec.com>
> Fixes: 669c4092225f ("MIPS: Give __secure_computing() access to syscall arguments.")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> It would have been much simpler for MIPS arch code to just pass a NULL
> seccomp_data to secure_computing() so populate_seccomp_data() would take
> care of fetching arguments, as it did for MIPS prior to commit
> 669c4092225f ("MIPS: Give __secure_computing() access to syscall
> arguments."), but as that commit mentions it breaks samples/bpf/tracex5,
> which relies on sd being non-NULL at entry to __seccomp_filter().
>
> Arguably the samples/bpf/tracex5 test is flawed, at least for every arch
> except x86 (and now MIPS).

Weird. Yeah, that sample is broken. Allowing NULL sd is totally fine.
The point is that seccomp will use syscall_get_arguments() when it's
NULL (which is effectively what this is doing...)

The reason sd can be _non_-NULL is when an architecture has access to
the args in some way that might be faster than calling
syscall_get_arguments().

Regardless, I'm fine with this change. It should either be this or
reverting 669c4092225f, but it looks like kprobes of
__seccomp_filter() is desired on MIPS...

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/kernel/ptrace.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 6dd13641a418..1395654cfc8d 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -872,15 +872,13 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
>         if (unlikely(test_thread_flag(TIF_SECCOMP))) {
>                 int ret, i;
>                 struct seccomp_data sd;
> +               unsigned long args[6];
>
>                 sd.nr = syscall;
>                 sd.arch = syscall_get_arch();
> -               for (i = 0; i < 6; i++) {
> -                       unsigned long v, r;
> -
> -                       r = mips_get_syscall_arg(&v, current, regs, i);
> -                       sd.args[i] = r ? 0 : v;
> -               }
> +               syscall_get_arguments(current, regs, 0, 6, args);
> +               for (i = 0; i < 6; i++)
> +                       sd.args[i] = args[i];
>                 sd.instruction_pointer = KSTK_EIP(current);
>
>                 ret = __secure_computing(&sd);
> --
> 2.13.2
>



-- 
Kees Cook
Pixel Security
