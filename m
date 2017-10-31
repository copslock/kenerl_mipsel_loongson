Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 12:37:11 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:34807 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990488AbdJaLhCZUyYY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 12:37:02 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7dfd9117
        for <linux-mips@linux-mips.org>;
        Tue, 31 Oct 2017 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to
        :content-type:content-transfer-encoding; s=mail; bh=aZ99RrIn2GqL
        ZY8u4w9SmjAKy50=; b=NG2aIrXt/1UykON3HMHQroI+N5QN75aKDFUy7FUk0vEX
        bPswnvcfr3WmxCure6Cwyaaq7shiNtJfuYpNjfzNOGED4grew7gekG0XSFpAgDnz
        eOJW4ryomHwRXcJwgtJAleCeN2eIwyVl6TCoL4EhhNadvi6zaihWzAiwR9Lp7ufk
        4CE33x9k8PQcba3hKPhPs89YaZ4xZebZPoHpppOW8BUhCorBW146pA+sKCZ2/w9F
        eOUz8/W47zW3pnoSKBLvZtMwvqP0KgWHzk+NBac+o+Egnvt7UMhn+IVzv4tLVe3k
        Kn9bja7gRnWOirr34qYYLhCyrHoTMIg5KfLiq2dX/Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 307eec1f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Tue, 31 Oct 2017 11:27:48 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id f66so26159467oib.2
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 04:30:08 -0700 (PDT)
X-Gm-Message-State: AMCzsaU5x0vJqWcryCRPRfBhaHoPcKbaSJsE8aa+HE8cPfiRET7j8E3R
        2+WO9+FWoCu0qGc+yNX0/aysJRMG2JUdwhCWE+E=
X-Google-Smtp-Source: ABhQp+RiQLkW43XOINwLKqXhmgEbRSLbksWHIdl194Zw2CGUYcz6KGUMN/qRAAhpN1xyf9RyjUQB+tOjXLSBMHvbnzg=
X-Received: by 10.157.1.164 with SMTP id e33mr871784ote.469.1509449408060;
 Tue, 31 Oct 2017 04:30:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.41.205 with HTTP; Tue, 31 Oct 2017 04:30:07 -0700 (PDT)
In-Reply-To: <20171023172056.12265-1-Jason@zx2c4.com>
References: <20171023172056.12265-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 31 Oct 2017 12:30:07 +0100
X-Gmail-Original-Message-ID: <CAHmME9rNWD+BhVTZdTCEsnjOyudk-bxwhmNjRHjwYO3o2rrqig@mail.gmail.com>
Message-ID: <CAHmME9rNWD+BhVTZdTCEsnjOyudk-bxwhmNjRHjwYO3o2rrqig@mail.gmail.com>
Subject: Re: [PATCH] mips/smp-cmp: use right include for task_struct
To:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hi Paul,

I think you're likely the person to review this patch?

Jason

On Mon, Oct 23, 2017 at 7:20 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> When task_struct was moved, this MIPS code was neglected. Evidently
> nobody is using it anymore. This fixes this build error:
>
> In file included from ./arch/mips/include/asm/thread_info.h:15:0,
>                  from ./include/linux/thread_info.h:37,
>                  from ./include/asm-generic/current.h:4,
>                  from ./arch/mips/include/generated/asm/current.h:1,
>                  from ./include/linux/sched.h:11,
>                  from arch/mips/kernel/smp-cmp.c:22:
> arch/mips/kernel/smp-cmp.c: In function ‘cmp_boot_secondary’:
> ./arch/mips/include/asm/processor.h:384:41: error: implicit declaration
> of function ‘task_stack_page’ [-Werror=implicit-function-declaration]
>  #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
>                                          ^
> arch/mips/kernel/smp-cmp.c:84:21: note: in expansion of macro ‘__KSTK_TOS’
>   unsigned long sp = __KSTK_TOS(idle);
>                      ^~~~~~~~~~
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/kernel/smp-cmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
> index 05295a4909f1..415e4d19f897 100644
> --- a/arch/mips/kernel/smp-cmp.c
> +++ b/arch/mips/kernel/smp-cmp.c
> @@ -19,7 +19,7 @@
>  #undef DEBUG
>
>  #include <linux/kernel.h>
> -#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
>  #include <linux/smp.h>
>  #include <linux/cpumask.h>
>  #include <linux/interrupt.h>
> --
> 2.14.2
>
