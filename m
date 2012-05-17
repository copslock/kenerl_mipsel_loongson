Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 08:37:44 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:38524 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab2EQGhR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2012 08:37:17 +0200
Received: by dadm1 with SMTP id m1so2283858dad.36
        for <multiple recipients>; Wed, 16 May 2012 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UjeRHxoKG6PFjhNigy/3Ahw2qHP7wvcBpTlbT4gzcjU=;
        b=rAStfzh5Ib3jYeAggSgfyFM6DQ66EpHBO3AYND1wNFDYZ/VqSzjaAPiVpFIoIkmiYD
         hEGB+6K2HUTosSdAjNSWhQxTQO7RTJ1GoWAPKYEdT1UO9FKzQQKppKWD80TFPSIM/CBz
         JLf9zq/1t1o9SBgg5IEbHqDdqzcaqapNuyVNl3JdJvITxHowTgMJNExqdKZgkVGxYoib
         Y5QixV2xLi3tHV/LiznpSOEwwgdvPJTAvOBAl+7WKJYWe+iTZBF5YIH0rTpnzm1JI8sZ
         QJrlRV9yafrbMXPeYDg7ZpXZysHE3Zaf4wXIllYpZYQGxtLduEMWcALt5h2EzwsilwXW
         g4Og==
MIME-Version: 1.0
Received: by 10.68.203.202 with SMTP id ks10mr24219293pbc.11.1337236630904;
 Wed, 16 May 2012 23:37:10 -0700 (PDT)
Received: by 10.68.72.165 with HTTP; Wed, 16 May 2012 23:37:10 -0700 (PDT)
In-Reply-To: <1333651054.3680.11.camel@dimm>
References: <1333651054.3680.11.camel@dimm>
Date:   Thu, 17 May 2012 08:37:10 +0200
Message-ID: <CAO6Zf6A22m8+5TcHr+opjJn0-DdDj2qF8xhBvSeDJ426B+kULg@mail.gmail.com>
Subject: Re: [PATCH] mips: fix endless loop when processing signals for kernel tasks
From:   Dmitry Adamushko <dmitry.adamushko@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.adamushko@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

So did I overlook something that makes it a non-issue on the recent mips?

On 5 April 2012 20:37, dimm <dmitry.adamushko@gmail.com> wrote:
> From: Dmitry Adamushko <dmitry.adamushka_ext@softathome.com>
>
> The problem occurs [1] when a kernel-mode task returns from a system
> call with a pending signal.
>
> A real-life scenario is a child of 'khelper' returning from a failed
> kernel_execve() in ____call_usermodehelper() [ kernel/kmod.c ].
> kernel_execve() fails due to a pending SIGKILL, which is the result of
> "kill -9 -1" (at least, busybox's init does it upon reboot).
>
> The loop is as follows:
>
> * syscall_exit_work:
>  - work_pending:            // start_of_the_loop
>  - work_notifysig:
>   - do_notify_resume()
>     - do_signal()
>       - if (!user_mode(regs)) return;
>  - resume_userspace         // TIF_SIGPENDING is still set
>  - work_pending             // so we call work_pending => goto
>                            // start_of_the_loop
>
> More information can be found in another LKML thread:
> http://www.serverphorums.com/read.php?12,457826
>
> [1] The problem was also reproduced on !CONFIG_VM86 x86, and the
> following fix was accepted.
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=29a2e2836ff9ea65a603c89df217f4198973a74f
>
> Signed-off-by: Dmitry Adamushko <dmitry.adamushko@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
>
> --- arch/mips/kernel/entry.S.old        2012-04-05 10:57:12.500976124 +0200
> +++ arch/mips/kernel/entry.S    2012-04-05 11:21:24.128174358 +0200
> @@ -36,6 +36,11 @@ FEXPORT(ret_from_exception)
>  FEXPORT(ret_from_irq)
>        LONG_S  s0, TI_REGS($28)
>  FEXPORT(__ret_from_irq)
> +/*
> + * We can be coming here from a syscall done in the kernel space,
> + * e.g. a failed kernel_execve().
> + */
> +resume_userspace_check:
>        LONG_L  t0, PT_STATUS(sp)               # returning to kernel mode?
>        andi    t0, t0, KU_USER
>        beqz    t0, resume_kernel
> @@ -162,7 +167,7 @@ work_notifysig:                             # deal with pending s
>        move    a0, sp
>        li      a1, 0
>        jal     do_notify_resume        # a2 already loaded
> -       j       resume_userspace
> +       j       resume_userspace_check
>
>  FEXPORT(syscall_exit_work_partial)
>        SAVE_STATIC
>
>



-- 

-- Dmitry
