Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Jul 2015 23:06:46 +0200 (CEST)
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34072 "EHLO
        mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011262AbbGSVGnpYk14 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Jul 2015 23:06:43 +0200
Received: by ykax123 with SMTP id x123so126539643yka.1;
        Sun, 19 Jul 2015 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AA3N9EfCQmzdDoiiyDDrhgRMUjntYqIdwOJnHCK/JPw=;
        b=lsApmUbj4BnLeeeJQzsRnP6/oUfqj1WLpEPMt0M2cMbyfge5AxOiJ1Zxj6XKgXm/SD
         wVxEZ6igYhjUf80iV/S+XwZVk1pHE9FIs83sWk2xaR+3hPExqNUrSjFfJ0mI2KCjUZXC
         Hv+qTBMIflEdAhTfJQ0TGxU8cCbJ6TctB57mwGAuI4Ayqpdp9rjX23Mj6O9RT8grlryV
         Ds0eCuAgm7jfWTdpZAENeJhZ9atO+kwMg1rMgKcKTBFUwhJjP3iGgDtjWNW4oXrCaWGl
         y7LRCwKvK/bJfaNV/SbUO/rK9DTwbZerYzxLpTgsGZiTc3230oqNhBYA3f07UKJhmoU3
         0z0g==
X-Received: by 10.170.100.67 with SMTP id r64mr25416497yka.9.1437339997848;
 Sun, 19 Jul 2015 14:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.76.207 with HTTP; Sun, 19 Jul 2015 14:06:18 -0700 (PDT)
In-Reply-To: <1437309769-8382-1-git-send-email-jogo@openwrt.org>
References: <1437309769-8382-1-git-send-email-jogo@openwrt.org>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 19 Jul 2015 16:06:18 -0500
X-Google-Sender-Auth: 8UiFtiKQIv2OJZbVyx0THL8-cEI
Message-ID: <CAL_JsqKwQHqUauyOxYg2PF4rBy1DC_UC9s8orWuXUsxMf66bMA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix build with CONFIG_OF=y for non OF-enabled targets
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sun, Jul 19, 2015 at 7:42 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> Commit 01306aeadd75 ("MIPS: prepare for user enabling of CONFIG_OF")
> changed the guards in asm/prom.h from CONFIG_OF to CONFIG_USE_OF, but
> missed the actual function declarations in kernel/prom.c, which have
> additional dependencies.

Just curious, what machine do you hit this on?

> Fixes the following build error:
>
>   CC      arch/mips/kernel/prom.o
> arch/mips/kernel/prom.c: In function '__dt_setup_arch':
> arch/mips/kernel/prom.c:54:2: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
>   if (!early_init_dt_scan(bph))
>   ^
>
> Fixes: 01306aeadd75 ("MIPS: prepare for user enabling of CONFIG_OF")
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>

Acked-by: Rob Herring <robh@kernel.org>

Rob

> ---
>  arch/mips/kernel/prom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index b130033..5fcec30 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -38,7 +38,7 @@ char *mips_get_machine_name(void)
>         return mips_machine_name;
>  }
>
> -#ifdef CONFIG_OF
> +#ifdef CONFIG_USE_OF
>  void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
>         return add_memory_region(base, size, BOOT_MEM_RAM);
> --
> 2.1.4
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
