Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 03:59:59 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:40228
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeCAC7vDxGH8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 03:59:51 +0100
Received: by mail-it0-x244.google.com with SMTP id v186so6078334itc.5;
        Wed, 28 Feb 2018 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IRIHxwUgusxkW20thGxQFO5BfniRtkrh1zozrrO6ANs=;
        b=FrgUd45mofIBezbf9ChhDS7uX0IS0QMHRX1TzvdcWNEez5cJmm0UoigFnITtmmH1vk
         1MuyyCRB3y10HljZ/nj2tiiKV2NWnVBZYX07a5nY4IU+BxAn7nInc3Wtr+nXTEIhnSrF
         Cs+G3XrD4G8YxLZqQZlzEXG+LltAREE8OXVBPi0/5pUH9IntXPC4YSNMnE63FdkVXke5
         oXv3EMrpP/zDcRZpCCbDbQ9OianIMU4weayuiU/yOLGqP+Ri3oC713Jp5ME/vVsd+6NA
         XFCRfzJjNW5PmX4UF69w+eXiDjquGoJWmvWZHLcL+093yKATkdvH9oAx0mxZqUr+eYg5
         puSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IRIHxwUgusxkW20thGxQFO5BfniRtkrh1zozrrO6ANs=;
        b=t1atWvOjvS6U0ceeZ9Mmf+hbEaERqvsxxw+auqZwaxYoYNv7ZbohvcPiyAoZiHFkHx
         nNChptcAovoCHgz8m8B38BweHSR2zyOOmp3FWDPXw+zr+/dABtgPYbUhsqeDe+pgO7Pv
         /nJ5vFTrJ2sHePxHk8ydBdsCDq9mwFH3PRh3DbFKX14a+TEUnrEqZPBnbRu77jkZaFWE
         gSMF+hnoXfahOvKXv7VuL61belOl83D/ltPmyOf4JbT6OUsvwizK862BP94EIlvlMLDE
         thjtcq8uG1ZV/YibKAOQ7w9cJihaj4g97zoxzs2KeVbH17STrYUsWz1reQd3DIMFJ0wh
         pDUg==
X-Gm-Message-State: APf1xPDP+AtpWtKZYSVaRN97tTjfLtDhGxbGklrChVISS+6bGrFAOS4z
        oxeaJTswltIAw/72BXUM4vL6rc5wrNl1DmAM5gw=
X-Google-Smtp-Source: AG47ELskvLi/z3Kyy/8MS12zxaaNnwChQehNYfDdcpPeZdKBCpd2w+t6qKvmnfMUsZSjR89vCkGh0f8tQtQVg+RN5b8=
X-Received: by 10.36.92.205 with SMTP id q196mr903308itb.135.1519873184408;
 Wed, 28 Feb 2018 18:59:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.187.1 with HTTP; Wed, 28 Feb 2018 18:59:43 -0800 (PST)
In-Reply-To: <1519872791-19076-1-git-send-email-chenhc@lemote.com>
References: <1519872791-19076-1-git-send-email-chenhc@lemote.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 1 Mar 2018 10:59:43 +0800
X-Google-Sender-Auth: WEFrPJPX4C8Jc4mdWvYUNz0HuQE
Message-ID: <CAAhV-H6f4szrbEKyuEgp-Zs6jFTRi_ekUpsrQwtSBcp7gbAUuA@mail.gmail.com>
Subject: Re: [PATCH 01/99] ZBOOT: fix stack protector in compressed boot phase
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This is a single patch, please ignore 1/99 in the title...

Huacai

On Thu, Mar 1, 2018 at 10:53 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard at where we
> define it.
>
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/arm/boot/compressed/misc.c        | 9 +--------
>  arch/mips/boot/compressed/decompress.c | 9 +--------
>  arch/sh/boot/compressed/misc.c         | 9 +--------
>  3 files changed, 3 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 16a8a80..43aca75 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -128,12 +128,7 @@ asmlinkage void __div0(void)
>         error("Attempting division by 0!");
>  }
>
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -       __stack_chk_guard = 0x000a0dff;
> -}
> +unsigned long __stack_chk_guard = 0x000a0dff;
>
>  void __stack_chk_fail(void)
>  {
> @@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>  {
>         int ret;
>
> -       __stack_chk_guard_setup();
> -
>         output_data             = (unsigned char *)output_start;
>         free_mem_ptr            = free_mem_ptr_p;
>         free_mem_end_ptr        = free_mem_ptr_end_p;
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..0694b3f 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -76,12 +76,7 @@ void error(char *x)
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
>
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -       __stack_chk_guard = 0x000a0dff;
> -}
> +unsigned long __stack_chk_guard = 0x000a0dff;
>
>  void __stack_chk_fail(void)
>  {
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>         unsigned long zimage_start, zimage_size;
>
> -       __stack_chk_guard_setup();
> -
>         zimage_start = (unsigned long)(&__image_begin);
>         zimage_size = (unsigned long)(&__image_end) -
>             (unsigned long)(&__image_begin);
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
> index 627ce8e..2c564c2 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -104,12 +104,7 @@ static void error(char *x)
>         while(1);       /* Halt */
>  }
>
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -       __stack_chk_guard = 0x000a0dff;
> -}
> +unsigned long __stack_chk_guard = 0x000a0dff;
>
>  void __stack_chk_fail(void)
>  {
> @@ -130,8 +125,6 @@ void decompress_kernel(void)
>  {
>         unsigned long output_addr;
>
> -       __stack_chk_guard_setup();
> -
>  #ifdef CONFIG_SUPERH64
>         output_addr = (CONFIG_MEMORY_START + 0x2000);
>  #else
> --
> 2.7.0
>
