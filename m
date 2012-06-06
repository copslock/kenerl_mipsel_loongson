Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 15:27:42 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35854 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2FFN1g convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 15:27:36 +0200
Received: by yhjj52 with SMTP id j52so5336359yhj.36
        for <multiple recipients>; Wed, 06 Jun 2012 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=474hVnNMj6QmIQKH9a/maAI24fzXcAeTTtuMI9498OE=;
        b=hyqzNgkOxwyLX/kAH9X5a8OPOst6Dfq+6F0Ylb/UVCGoQtgMtlUHmg622VwMoC8Mlv
         ULN78Qdp7B6fjkdBoq8aWltgKcbX/ocUqxOHDz2LUyViE0q/dlk7+2Be90lO6qqwVCfq
         Yc6x1StTncrR/gbHM74rDmREhzFsbvbgJPBH4sMqWVNrza61JeOgKCNLADwml9NADbws
         a/D3C8nM4M0WTjUZtvFg9HIbAE4PP+tT7baLOqoVs3imsAWf1jH/rVv6Wld76fSm4T86
         aeodJhOzCrF/SQ/MdOwXAnziiC8UwqEls1b7+xojFseSd1V5HxBW5/AB1mRAQqf1je4L
         kZQQ==
MIME-Version: 1.0
Received: by 10.50.100.169 with SMTP id ez9mr6438841igb.44.1338989249668; Wed,
 06 Jun 2012 06:27:29 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Wed, 6 Jun 2012 06:27:29 -0700 (PDT)
In-Reply-To: <1338931179-9611-33-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-33-git-send-email-sjhill@mips.com>
Date:   Wed, 6 Jun 2012 15:27:29 +0200
X-Google-Sender-Auth: S9DR8d6KEfEvYToEnNqw4Y_0s_I
Message-ID: <CAMuHMdUpDMDKLmyBX6y7odd4hpo+c+HVJaUk5Us1gsBnbD3Wag@mail.gmail.com>
Subject: Re: [PATCH 32/35] MIPS: txx9: Cleanup firmware support for txx9 platforms.
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 33574
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Steven,

On Tue, Jun 5, 2012 at 11:19 PM, Steven J. Hill <sjhill@mips.com> wrote:
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -25,11 +25,11 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/irq.h>
> -#include <asm/bootinfo.h>
>  #include <asm/time.h>
>  #include <asm/reboot.h>
>  #include <asm/r4kcache.h>
>  #include <asm/sections.h>
> +#include <asm/fw/fw.h>
>  #include <asm/txx9/generic.h>
>  #include <asm/txx9/pci.h>
>  #include <asm/txx9tmr.h>
> @@ -157,39 +157,6 @@ static struct txx9_board_vec *__init find_board_byname(const char *name)
>        return NULL;
>  }
>
> -static void __init prom_init_cmdline(void)
> -{
> -       int argc;
> -       int *argv32;
> -       int i;                  /* Always ignore the "-c" at argv[0] */
> -
> -       if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
> -               /*
> -                * argc is not a valid number, or argv32 is not a valid
> -                * pointer
> -                */
> -               argc = 0;
> -               argv32 = NULL;
> -       } else {
> -               argc = (int)fw_arg0;
> -               argv32 = (int *)fw_arg1;
> -       }
> -

> @@ -378,7 +345,7 @@ static void __init select_board(void)
>
>  void __init prom_init(void)
>  {
> -       prom_init_cmdline();
> +       fw_init_cmdline();

This basically reverts commit 97b0511ce125b0cb95d73b198c1bdbb3cebc4de2
("MIPS: TXx9: Make firmware parameter passing more robust"), so it's gonna
die horribly on RBTX4927 with VxWorks bootloader.

Can you add the checks to fw_init_cmdline()? I guess they don't harm on other
boards anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
