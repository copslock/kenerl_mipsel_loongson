Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2017 00:23:56 +0200 (CEST)
Received: from mail-io0-x22d.google.com ([IPv6:2607:f8b0:4001:c06::22d]:38013
        "EHLO mail-io0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994820AbdHKWXkz1OR4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2017 00:23:40 +0200
Received: by mail-io0-x22d.google.com with SMTP id g71so24593420ioe.5
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2017 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VHOkLRVTJu3kYC59wdwdFIQZJhtDgl4PmkfYFQSiHJI=;
        b=OuRlZyZeDxc4JBOFFmEB0bZJZDH6yMvaL64EXDV5rTI1PYxi7VA4hwBeZnVA8o9fTq
         bvacnriCW/07ReB6rMmj9VqvbmaxQBblbQ2lrK4ZThZUDgmpO/Jm8BEqmRppdJxiKdLP
         vzw3YgG2xdcR6Gv1lFqXLZi6UoS019CJXkHek143jff+Tdf/jYMSZkqbDgIaMVXcNwSj
         eMS/mwMY97TGDcWsuYnfM2/Wro+tzKg5+ybIMIvqw8PWUNPmQrt3IhlfIpi/TCOhropr
         jM2Uo0aK4tGcUv1kY+OSD8a2F9Wo6i9AjPqJaE3NycURHZOuonmnPLDLS/Dmmo26sJ/E
         ZeOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VHOkLRVTJu3kYC59wdwdFIQZJhtDgl4PmkfYFQSiHJI=;
        b=NAIuPHRIFGS3lJbOiClGR1OtU9rSpJixEE8lsibpuvn1Ad3LvxO00pUI2rsHNSZsiY
         C3expwbg3n0NdkI2wr6J8k3BlXhhdbgw++Pdbyke+z5YFQXxlqmsN50Pyyrqo56LDT1h
         u1VMhtK5i7IH6g/u0oFGk6kF8W34O70rFsxM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VHOkLRVTJu3kYC59wdwdFIQZJhtDgl4PmkfYFQSiHJI=;
        b=cwsJonq6rJGkzWwBdGz+TFQ+BW/gADjtHlCHmxxHVI7P1IUO4bIq/ZBMA0y7/gj4Ji
         jljVFNMdlChumEYdT02YYWZoJWfkRCURGzcna0ed1vrb7WDBCOfF4UAB4s014Nnfi4jL
         gajYEi77QRCUQsz5WFAoOEmqArdqlwFJ9mjPgVvB7BSHtIopPh1vktBYrvb1N6hrBIdT
         WJ3QHLDfRquIyP5ZqPJb4tAaSFiDHChjIzHJQLOaaK98O7RFsqTU9NrP7SEkToMXUfhc
         XtzwflC5Djw87lffH80wcQz/3DqqTsmPoLECA2n0H0QFJnHSNTRzJdxCQHGID+PELeEV
         /llg==
X-Gm-Message-State: AHYfb5h2Mq/zDNnKuKfy8a8oUWL6Ev40eG9qujvVQH2/AZ7IiQbi13bR
        uqf9vXi4hry5kEdadosgNLMwvn657Mrf
X-Received: by 10.107.168.165 with SMTP id e37mr15550138ioj.133.1502490215088;
 Fri, 11 Aug 2017 15:23:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.161 with HTTP; Fri, 11 Aug 2017 15:23:34 -0700 (PDT)
In-Reply-To: <20170811205653.21873-5-james.hogan@imgtec.com>
References: <20170811205653.21873-1-james.hogan@imgtec.com> <20170811205653.21873-5-james.hogan@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 11 Aug 2017 15:23:34 -0700
X-Google-Sender-Auth: mwWmddKMA09DQ5kwrYzVW0gwLSs
Message-ID: <CAGXu5j+Z_n1G9_q=FrOHVbz0axR8G6izB2Rvku1k6bRjJ6rMrA@mail.gmail.com>
Subject: Re: [PATCH 4/4] MIPS/ptrace: Add PTRACE_SET_SYSCALL operation
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59493
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
> Add a PTRACE_SET_SYSCALL ptrace operation to allow the system call to be
> cancelled independently to the value of the v0 system call number
> register.
>
> This is needed for SECCOMP_RET_TRACE when the tracer wants to cancel the
> system call, since it has to set both the system call number to -1 and
> the chosen return value, both of which reside in the same register (v0).
> The tracer should set the return value first, followed by
> PTRACE_SET_SYSCALL to set the system call number to -1.
>
> That is in contrast to the normal ptrace syscall hook which triggers the
> tracer on both entry and exit, allowing the system call to be cancelled
> during the entry hook (setting system call number register to -1, or
> optionally using PTRACE_SET_SYSCALL), separately to setting the return
> value during the exit hook.
>
> Positive values (to change the syscall that should be executed instead
> of cancelling it entirely) are explicitly disallowed at the moment. The
> same thing can be done safely already by writing the v0 system call
> number register and the argument registers, and allowing
> thread_info::syscall to be changed to a different value independently of
> the v0 register would potentially allow seccomp or the syscall trace
> events to be fooled into thinking a different system call was being
> executed.

Wouldn't the sycall be reloaded, so no spoofing could occur?

Regardless, can you update
tools/testing/selftests/seccomp/seccomp_bpf.c to update or eliminate
the MIPS-only SYSCALL_NUM_RET_SHARE_REG special-case? (Or maybe it
needs to be further special-cased to split syscall-changing from
syscall-cancelling?)

-Kees

>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/uapi/asm/ptrace.h |  1 +
>  arch/mips/kernel/ptrace.c           | 11 +++++++++++
>  arch/mips/kernel/ptrace32.c         | 11 +++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/uapi/asm/ptrace.h
> index 91a3d197ede3..23af103c4e8d 100644
> --- a/arch/mips/include/uapi/asm/ptrace.h
> +++ b/arch/mips/include/uapi/asm/ptrace.h
> @@ -58,6 +58,7 @@ struct pt_regs {
>
>  #define PTRACE_GET_THREAD_AREA 25
>  #define PTRACE_SET_THREAD_AREA 26
> +#define PTRACE_SET_SYSCALL     27
>
>  /* Calls to trace a 64bit program from a 32bit program.         */
>  #define PTRACE_PEEKTEXT_3264   0xc0
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 465fc5633e61..9bf31a990c6e 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -853,6 +853,17 @@ long arch_ptrace(struct task_struct *child, long request,
>                 ret = put_user(task_thread_info(child)->tp_value, datalp);
>                 break;
>
> +       case PTRACE_SET_SYSCALL:
> +               /*
> +                * This is currently only useful to cancel the syscall from a
> +                * seccomp RET_TRACE tracer.
> +                */
> +               if ((long)data >= 0)
> +                       return -EINVAL;
> +               task_thread_info(child)->syscall = -1;
> +               ret = 0;
> +               break;
> +
>         case PTRACE_GET_WATCH_REGS:
>                 ret = ptrace_get_watch_regs(child, addrp);
>                 break;
> diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
> index 2b9260f92ccd..cca76aec9c10 100644
> --- a/arch/mips/kernel/ptrace32.c
> +++ b/arch/mips/kernel/ptrace32.c
> @@ -287,6 +287,17 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>                                 (unsigned int __user *) (unsigned long) data);
>                 break;
>
> +       case PTRACE_SET_SYSCALL:
> +               /*
> +                * This is currently only useful to cancel the syscall from a
> +                * seccomp RET_TRACE tracer.
> +                */
> +               if ((long)data >= 0)
> +                       return -EINVAL;
> +               task_thread_info(child)->syscall = -1;
> +               ret = 0;
> +               break;
> +
>         case PTRACE_GET_THREAD_AREA_3264:
>                 ret = put_user(task_thread_info(child)->tp_value,
>                                 (unsigned long __user *) (unsigned long) data);
> --
> 2.13.2
>



-- 
Kees Cook
Pixel Security
