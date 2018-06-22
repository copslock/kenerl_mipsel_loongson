Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 10:12:22 +0200 (CEST)
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37767 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeFVIMPV6vwD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 10:12:15 +0200
Received: by mail-ua0-f193.google.com with SMTP id c2-v6so3760944uae.4
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2018 01:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFvWEvBE+tER3NesNR5rnNKEpD8RVlHJ9UN8uppk4Pw=;
        b=oVPpXJ/t0kh45J6c/8Te6tzA0prdOPhE7ZY5gV2sakn5Zuo03B+exwJCp4hhQ2IcnP
         EqG2RdQECz5gW8ZQMAfSKWfZ1jeOfiThff9HCpuDaH+NUffzMZZDdVg2EplvVWazCnRM
         l+B7UM0U/phsI2UmrWTEYHxqyQ6urgwGmcOzGaSbhKEmzH54VqQM46pX0xVXvCVcG/WY
         fhUO3jRPI1aibEsv9KXnK5OaE4SV9m8SRwDekzqrmdAkfrA3IE4cFV8Rb88SxuesnpEs
         q8rVKE/SUFLXJMTEWzP3swN+13htAzopknBFF5kZmuGSqMIx4UOmt4qfgEDWFGOM4Dpb
         PmMg==
X-Gm-Message-State: APt69E04ERHJsC6YMa7QB71ex+Lb+GLeqYO6KbobzFibVL3phCYYssBt
        Q+neYyNeosu7KY4j2m0DoR7Jo2ZsC35kbn+tZMs=
X-Google-Smtp-Source: ADUXVKLXsF4H1J8j777N4NQqFQU9Z8FzUWj/b57ALmtinnRV5Q0T7z2kNaUqTsZTDVxCqqMuQbfq+yu6CiAz8aNrtrA=
X-Received: by 2002:ab0:5b18:: with SMTP id u24-v6mr396210uae.72.1529655129263;
 Fri, 22 Jun 2018 01:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180622075421.16001-1-geert@linux-m68k.org>
In-Reply-To: <20180622075421.16001-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 10:11:58 +0200
Message-ID: <CAMuHMdWhFyiAhA=bdjxSSmopJ=yJMXqMmOAD8hWUHWpiz0t4kA@mail.gmail.com>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

CC alpha, mips

On Fri, Jun 22, 2018 at 9:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> time period.
>
> However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> zero for small non-zero time periods.  This may break code that relies
> on receiving back a non-zero value.
>
> jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> not support values of HZ larger than 12287, thus rejecting any
> problematic huge values of HZ.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Add examples of affected systems,
>   - Use DIV_ROUND_UP().
> ---
>  kernel/time/time.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index 6fa99213fc720e4b..2b41e8e2d31db26f 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -28,6 +28,7 @@
>   */
>
>  #include <linux/export.h>
> +#include <linux/kernel.h>
>  #include <linux/timex.h>
>  #include <linux/capability.h>
>  #include <linux/timekeeper_internal.h>
> @@ -314,9 +315,10 @@ unsigned int jiffies_to_msecs(const unsigned long j)
>         return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
>  #else
>  # if BITS_PER_LONG == 32
> -       return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
> +       return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
> +              HZ_TO_MSEC_SHR32;
>  # else
> -       return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
> +       return DIV_ROUND_UP(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
>  # endif
>  #endif
>  }
> --
> 2.17.1
