Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 14:46:08 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:42906
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994611AbeBINpzcIylx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Feb 2018 14:45:55 +0100
Received: by mail-qt0-x243.google.com with SMTP id i8so10554014qtj.9;
        Fri, 09 Feb 2018 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qwckh3dbb9a1/rd2xXDDoEEq/XkcSQE0JtDkG0TlLDA=;
        b=USwR8wD3p1jsqAW6w0/iVHGcSj6RurlP/EYcvg9fD6J1HMY4Rt/XKmgnl0ZnYIj+1z
         IXOZPXoKDMOs4OvWZoMptyC+gmysJZHAqKQcCZLsmpnA5yM9Vt2hwt5o73WskqLtHAhi
         59on43Z52YcXN0TrzEMrF1TPtUHCyYGge2UAL1rUoSKBgBPDfNTErN+RRnIBSFvd2/s2
         c7S541xoB2paxra3g0k81PnGyiy/KGMxkyPYOOXVDGOwshjWMPPxJrpzgV3/YY1o/ZOf
         d6ZK3oLe4bMCvwOK4ePNRJOQfV5VoTGT7M2l1cAi1IQeCo66vdBOKdMbsyaad+Bs9KWB
         Lk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qwckh3dbb9a1/rd2xXDDoEEq/XkcSQE0JtDkG0TlLDA=;
        b=tHPIe1CoAE3hXHm5tiQr3rsmpDviuL1t079cuJXrO+fwZYdmMDf89XqUhY0NGhaFuF
         ZPMnF64fVjbzyUkQrsXqxbqROzkzvLDhJLIj21c/s6cdcGSQx7kqUdbNl7lRqtpOegwq
         NiyR8HQ3FPcoYvPhUsVqIVq9ed/EmHVHj+8/EVH3wmA60jaLJtYDtMP3hxR/KkxtDD3s
         co8mtSlu6RKYoOlLBejpkBPmzN9kmz2jPTjALNbTWUCbQEb99D7jr0LvMgD+iHiHx8qH
         MuTfFEOVP7ucNDL50uorV6ivljM25nRHNxFx/w7C2CPHV1TfxoBjS1QeE/aKwJTzn6/W
         KhhA==
X-Gm-Message-State: APf1xPAdJQFKDvOKXfzcCgwV9cgEwOm8jvDkyNq3qj4nmG91qoKwcqAb
        KEidtoIy2Xbqr5NowQoKGmLRjrZ4DkNapDH7Qnc=
X-Google-Smtp-Source: AH8x224mwAVz3fPB37XUrwMJFBtgq5KrLj4jxVDQ1EpdI+gGosBiHRGb/eK9R1KlFfDsOpWG2ZmSz7e0GYoG3K7Qn/s=
X-Received: by 10.237.32.9 with SMTP id 9mr4699673qta.340.1518183949378; Fri,
 09 Feb 2018 05:45:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.35 with HTTP; Fri, 9 Feb 2018 05:45:48 -0800 (PST)
In-Reply-To: <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
References: <mhng-f000d448-7ead-4cee-9e2f-5d58692c0922@palmer-si-x1c4> <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Feb 2018 15:45:48 +0200
Message-ID: <CAHp75VeiAUg1NCK59wZjZNnLZqEXDF5dpi8pmtTcP1WhX2wvVA@mail.gmail.com>
Subject: Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, antonynpavlov@gmail.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        jhogan@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Fri, Feb 9, 2018 at 3:22 PM, Matt Redfearn <matt.redfearn@mips.com> wrote:
> When these are included into arch Kconfig files, maintaining
> alphabetical ordering of the selects means these get split up. To allow
> for keeping things tidier and alphabetical, rename the selects to
> GENERIC_LIB_*
>

I don't remember who suggested that, if it wasn't you, please add
Suggested-by tag with appropriate name.

> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
>  arch/riscv/Kconfig |  6 +++---
>  lib/Kconfig        | 12 ++++++------
>  lib/Makefile       | 12 ++++++------
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2c6adf12713a..5f1e2188d029 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -99,9 +99,9 @@ config ARCH_RV32I
>         bool "RV32I"
>         select CPU_SUPPORTS_32BIT_KERNEL
>         select 32BIT
> -       select GENERIC_ASHLDI3
> -       select GENERIC_ASHRDI3
> -       select GENERIC_LSHRDI3
> +       select GENERIC_LIB_ASHLDI3
> +       select GENERIC_LIB_ASHRDI3
> +       select GENERIC_LIB_LSHRDI3
>
>  config ARCH_RV64I
>         bool "RV64I"
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c5e84fbcb30b..946d0890aad6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -584,20 +584,20 @@ config STRING_SELFTEST
>
>  endmenu
>
> -config GENERIC_ASHLDI3
> +config GENERIC_LIB_ASHLDI3
>         bool
>
> -config GENERIC_ASHRDI3
> +config GENERIC_LIB_ASHRDI3
>         bool
>
> -config GENERIC_LSHRDI3
> +config GENERIC_LIB_LSHRDI3
>         bool
>
> -config GENERIC_MULDI3
> +config GENERIC_LIB_MULDI3
>         bool
>
> -config GENERIC_CMPDI2
> +config GENERIC_LIB_CMPDI2
>         bool
>
> -config GENERIC_UCMPDI2
> +config GENERIC_LIB_UCMPDI2
>         bool
> diff --git a/lib/Makefile b/lib/Makefile
> index d11c48ec8ffd..7e1ef77e86a3 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>  obj-$(CONFIG_PARMAN) += parman.o
>
>  # GCC library routines
> -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
> -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
> -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
> -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
> -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
> -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
> +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
