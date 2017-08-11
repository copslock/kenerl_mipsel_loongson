Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2017 00:18:23 +0200 (CEST)
Received: from mail-it0-x236.google.com ([IPv6:2607:f8b0:4001:c0b::236]:35963
        "EHLO mail-it0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994814AbdHKWSLDiPYG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2017 00:18:11 +0200
Received: by mail-it0-x236.google.com with SMTP id 77so1151473itj.1
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2017 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tNomcGA/1vP97/bo19N4UfkDC26A/JGnTHKJITApoVA=;
        b=A/t+oX2J7gRHONHcSAI51bD1sXPU8LmSFWhBwvW5397jRe6XRjFHZWRuokKIwIdZ++
         xwh/qWUqqO49sPB2WT5kFdmGXkBGFB8cnnTvdjPP4IUXn21YTn3d02kQH1X06y8NcB7p
         w6FZE4KXfkpUudE0D9aSMulwUDyogWvF7DFbDfFTXaWm4Yy5vM5RHyvfEnstuwhkycNA
         PdT9uIpAiqn9TRlisa3dIEpsAOx55hF9r+U/jfWE6L6CfLTP57Xl3HHt73j9fc8LXn6h
         j3gDbp5upZIyT+zF5EAF/5OnLh3c/cIQaa6EUanw10Jnh94VzJafXnNuKDX7PglexSh1
         Qv+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tNomcGA/1vP97/bo19N4UfkDC26A/JGnTHKJITApoVA=;
        b=WcT1Ddan5w4MGkWTx/xNGmITsj21KNV8Hz7g/pzeZetdRPOPk6s+RyMk+964nCq86i
         lRdpatit2QgipbxTpGZgTA0ZJTmxOumTyBwR5Ok1tSsaKHbTxow7jtwMj60ndpsFtSgc
         QOf3EovaCrw/iznZ+6CBpOvbPxncXcJnCOl0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tNomcGA/1vP97/bo19N4UfkDC26A/JGnTHKJITApoVA=;
        b=XnMdyce7zTEqGH5YOL3ef9MMxtXuwfGZXXfK2Cy8z9VdTFxc+IogaRNK974jSfrInn
         TsY9hPhQk/u4NhczVflajG7zkZxpAn0vCVEX5ssMOHYrJokSlJsZEn+2Rz7CoRE5lRPm
         YeM8QglYgul2F+n5h/T1ieRxBVJipR87XBUrxJASlGvQCdiLdum7NxY2jcKEI50WRXKO
         0QqFfwENhHqybpVS5vI0I39jUj/eKUv0XaOwGkivJwcEpuWU0xOIK6T4dyyyF3jv/Mh8
         Ozm15cUBHxohqK9yLRrMQpbo0qGBp6VJDELVDFQrKDJZ/ZDUyXRldTAH2/E+Mvvjq/pd
         yJrw==
X-Gm-Message-State: AHYfb5jygV0qZ8mL+q4e5OFyod3VO9Q6BLicCXUVTt/koEsPywtKo39W
        wv16ks/h8pP/FMkNFBYOLQI/O0TdAf+J
X-Received: by 10.36.140.131 with SMTP id j125mr122631itd.43.1502489885172;
 Fri, 11 Aug 2017 15:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.161 with HTTP; Fri, 11 Aug 2017 15:18:04 -0700 (PDT)
In-Reply-To: <20170811205653.21873-3-james.hogan@imgtec.com>
References: <20170811205653.21873-1-james.hogan@imgtec.com> <20170811205653.21873-3-james.hogan@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 11 Aug 2017 15:18:04 -0700
X-Google-Sender-Auth: Pus43Qo0QRC83g578CRJBOp5i4k
Message-ID: <CAGXu5jLEvfOWGv+BNWCddMmtGumB_cpGOX6GCCm8Usz6=m=mPw@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS/ptrace: Pick up ptrace/seccomp changed syscalls
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lars Persson <lars.persson@axis.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59492
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
> The MIPS syscall_trace_enter() allows the system call number to be
> altered or cancelled by a ptrace tracer, via the normal ptrace hook
> (PTRACE_SYSCALL) and changing the system call number register on entry,
> and similarly via seccomp (PTRACE_EVENT_SECCOMP when a seccomp filter
> returns SECCOMP_RET_TRACE).
>
> Be sure to update the syscall local variable if this happens, so that
> seccomp will filter the correct system call number if the normal ptrace
> hook changes it first, and so that if either the normal ptrace hook or
> seccomp change it the correct system call number is passed to the trace
> event.
>
> This won't have any effect until the next commit, which fixes ptrace to
> update thread_info::syscall.
>
> Fixes: c2d9f1775731 ("MIPS: Fix syscall_get_nr for the syscall exit tracing.")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lars Persson <lars.persson@axis.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: linux-mips@linux-mips.org

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/kernel/ptrace.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 1395654cfc8d..be5d5fefcc7c 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -864,9 +864,11 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
>
>         current_thread_info()->syscall = syscall;
>
> -       if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -           tracehook_report_syscall_entry(regs))
> -               return -1;
> +       if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> +               if (tracehook_report_syscall_entry(regs))
> +                       return -1;
> +               syscall = current_thread_info()->syscall;
> +       }
>
>  #ifdef CONFIG_SECCOMP
>         if (unlikely(test_thread_flag(TIF_SECCOMP))) {
> @@ -884,6 +886,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
>                 ret = __secure_computing(&sd);
>                 if (ret == -1)
>                         return ret;
> +               syscall = current_thread_info()->syscall;
>         }
>  #endif
>
> --
> 2.13.2
>



-- 
Kees Cook
Pixel Security
