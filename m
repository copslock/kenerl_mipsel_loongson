Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 05:22:38 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:34012
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbdKPEW3ry5Db (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 05:22:29 +0100
Received: by mail-it0-x241.google.com with SMTP id m191so465597itg.1;
        Wed, 15 Nov 2017 20:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xKF45GAGyDGi64VULdsboy1oVhAyQIpA55hh/dEjhCI=;
        b=VY5y/3ZHGPx/ggo4Z+rveUqh0NQm+GVR1UvZyw1c26lkw7phzsyPSLSgSynLzf1/EX
         ZqyuPVkzOltnx/ZQjOyWTLUVIkrdfr0Ka5pCYEHlJigM/nvycTU0+ulcHWvSgj5VpFRe
         DGXv4jVLeVbmWDe6UcQ7FKaIBeqQIesIbSGUKnapdLOuh5JUsjIg6HoomBB5+Rq1uINa
         WiW9VNxFYj1uN6SC3bU1ecZEgTLaG2qnOvIUSl4PD4FGNDYwcQpT8icdsnyPxFm0hoeq
         djl4pzvzaAQK1Ut7Z6f/3tkVcFv9nCFRjxp22ZGF6l4PIzvxCENw7QpshtJPU5OIe5at
         BAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xKF45GAGyDGi64VULdsboy1oVhAyQIpA55hh/dEjhCI=;
        b=UcKfMEHYvHAFEDtjNDP1A1mCDtF+j9OPyLSr2xr6eO6gozbgB5pG75dQBfL8JFvFFL
         j8HRwBpcQCRYpKChMqHYy/zdqB7SqqLZc4jgvXePvb3nQtPEtxU66eAzC7Im0lYDbq9d
         +gk7x1VGmEBvo8YPsvoCvV/xUDCQmlL8OVcq6c5oC5hQVfu4idRvfaITAidXioSIYpL2
         3DnS8eBWKrr67gRD/lKjIgj2a1NW0N5TQZfU94Tl7cJfgAaOlRhlVNuCOd29x83ea5KN
         F9pyrewzRoBY/zYymoq6iRz8c83Ib0tHqC6WLqjlRrox1F/VCCfMRM/okPOx1ntvysWe
         gL0g==
X-Gm-Message-State: AJaThX4Kwk03ZV4XzxxZoF96WbdqOHYGzPf1ArYYc/DpP0EoqkKAOG8K
        g5u8ADbCNQa4CS3tBHKMic9/05ZQtlSQU9hLDd0=
X-Google-Smtp-Source: AGs4zMY7I9iOD1KMNy4EgFsobtW9UfOcHwAYaVJ20imA4vfYMKKqcLkJv1GoFbylmWyIOMr1Ke3FY6mMp+rWqrJSALE=
X-Received: by 10.36.184.134 with SMTP id m128mr808386ite.96.1510806142734;
 Wed, 15 Nov 2017 20:22:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.28.131 with HTTP; Wed, 15 Nov 2017 20:22:22 -0800 (PST)
In-Reply-To: <20171115031155.643-1-jiaxun.yang@flygoat.com>
References: <20171112063617.26546-1-jiaxun.yang@flygoat.com> <20171115031155.643-1-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 16 Nov 2017 12:22:22 +0800
Message-ID: <CAAhV-H70Np8ao5XbK1Y=-wqpO3tTSd5CDj8wmEKvkT6bPnLWgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Ralf and James,

Why xxx@lemote.com is always denied by mail.linux-mips.org?

Huacai

On Wed, Nov 15, 2017 at 11:11 AM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> Since lemote-2f/marchtype.c need to get cmdline from loongson.h
> this patch simply copy kernel command line from arcs_cmdline
> to fix that issue.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/mach-loongson64/loongson.h | 6 ++++++
>  arch/mips/loongson64/common/cmdline.c            | 7 +++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
> index c68c0cc879c6..1edf3a484e6a 100644
> --- a/arch/mips/include/asm/mach-loongson64/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson64/loongson.h
> @@ -45,6 +45,12 @@ static inline void prom_init_uart_base(void)
>  #endif
>  }
>
> +/*
> + * Copy kernel command line from arcs_cmdline
> + */
> +#include <asm/setup.h>
> +extern char loongson_cmdline[COMMAND_LINE_SIZE];
> +
>  /* irq operation functions */
>  extern void bonito_irqdispatch(void);
>  extern void __init bonito_irq_init(void);
> diff --git a/arch/mips/loongson64/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
> index 01fbed137028..49e172184e15 100644
> --- a/arch/mips/loongson64/common/cmdline.c
> +++ b/arch/mips/loongson64/common/cmdline.c
> @@ -21,6 +21,11 @@
>
>  #include <loongson.h>
>
> +/* the kernel command line copied from arcs_cmdline */
> +#include <linux/export.h>
> +char loongson_cmdline[COMMAND_LINE_SIZE];
> +EXPORT_SYMBOL(loongson_cmdline);
> +
>  void __init prom_init_cmdline(void)
>  {
>         int prom_argc;
> @@ -45,4 +50,6 @@ void __init prom_init_cmdline(void)
>         }
>
>         prom_init_machtype();
> +       /* copy arcs_cmdline into loongson_cmdline */
> +       strncpy(loongson_cmdline, arcs_cmdline, COMMAND_LINE_SIZE);
>  }
> --
> 2.14.1
>
>
