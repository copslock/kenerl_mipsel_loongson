Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 20:06:50 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63270 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834666AbaFXSGqGDAla (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 20:06:46 +0200
Received: by mail-lb0-f174.google.com with SMTP id u10so990668lbd.33
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 11:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9CI2LojipRUWB1pUH9xYzCbc//QBCmGe3aKytkRhc6U=;
        b=CNIhqWvgwAmg8nbojneumkJiP4+jfYKuYxbeka6+F51Pqc/h7eFqf4QCQPYxGrqTz5
         42nDczIlPQg5OdydKXnCWBKIrfQc5ocLQ0xWgc/Dp0JoutttBwmaq15sE8bfec0LgEeU
         Xy9DYIkvqq/RRraGWuZ3d4mOWRMZwCLRGkOCUDjOrtGipwxVSXgyj1niJ7h2fc/JcWgr
         1uqPCdj3unvGTje5nbyg1BaXhEDhpbbt/i+9+J6HDTpC4yUOqxhRIICvUffGNo4AsWK8
         dMcVkfrUiCd+wOFWqvCR8QYvWCXc3N4xqZ981mjPLNigOCCJQiMYtS6fRKaIeWHr0fNG
         8pkg==
X-Gm-Message-State: ALoCoQlN0lgAMJg7j1Z8NigMiGZBFSbnJezv1+qvMrs9HivS4B0HBNg9a/yZgydzN8CYqAQ0zcjC
X-Received: by 10.152.115.134 with SMTP id jo6mr1830287lab.6.1403633200482;
 Tue, 24 Jun 2014 11:06:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Tue, 24 Jun 2014 11:06:20 -0700 (PDT)
In-Reply-To: <20140623220150.GM5412@outflux.net>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org> <20140623220150.GM5412@outflux.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 24 Jun 2014 11:06:20 -0700
Message-ID: <CALCETrV=nAuWi8_Xj6KnJ6P1Yiaw36+n50-gHKaTgea4yH85Eg@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] man-pages: seccomp.2: document syscall
To:     Kees Cook <keescook@chromium.org>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Mon, Jun 23, 2014 at 3:01 PM, Kees Cook <keescook@chromium.org> wrote:
> Combines documentation from prctl, and in-kernel seccomp_filter.txt,
> along with new details specific to the new syscall.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  man2/seccomp.2 |  333 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 333 insertions(+)
>  create mode 100644 man2/seccomp.2
>
> diff --git a/man2/seccomp.2 b/man2/seccomp.2
> new file mode 100644
> index 0000000..de7fbf7
> --- /dev/null
> +++ b/man2/seccomp.2
> @@ -0,0 +1,333 @@
> +.\" Copyright (C) 2014 Kees Cook <keescook@chromium.org>
> +.\" and Copyright (C) 2012 Will Drewry <wad@chromium.org>
> +.\" and Copyright (C) 2008 Michael Kerrisk <mtk.manpages@gmail.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH SECCOMP 2 2014-06-23 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +seccomp \-
> +operate on Secure Computing state of the process
> +.SH SYNOPSIS
> +.nf
> +.B #include <linux/seccomp.h>
> +.B #include <linux/filter.h>
> +.B #include <linux/audit.h>
> +.B #include <linux/signal.h>
> +.B #include <sys/ptrace.h>
> +
> +.BI "int seccomp(unsigned int " operation ", unsigned int " flags ,
> +.BI "            unsigned char *" args );

At the very least, shouldn't this be void *args?

--Andy
