Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 21:42:33 +0100 (CET)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:36438
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeCLUmZqLkv9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 21:42:25 +0100
Received: by mail-oi0-x244.google.com with SMTP id u73so13476663oie.3;
        Mon, 12 Mar 2018 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wTSlUBJhs/qvu38DmR0+Po4umrlPHhRkuoDp2Z4kamE=;
        b=LibJlzBQoi4nX+j+DlpT4knePnlHTgwzffWqkj7y1bzt8Korxh/9Uw2L5/+eHaNcSt
         FVRUAXfyhI/uy9NZF1vRJM8/1D85n6cNDjaY7xlC/sbJQ3kb9KW/+q2H4kvA28/AE09m
         5JmuDxOyE69sxyP7DhJtleUve8l+Xxr6fo/ziqL69rx7OBj62ZCExy7gG9/eHa2MjqEc
         od6Eu9OmBGPYQVWSzxFxMU1FAtVwIYHrLnbYaArnr4F9DjuDOBxPTkk68lMR9SB4w5AA
         OhNGAjllomoTuBF2HzxSEZ1/JZCbhhtZ9NLFBTPraXjH8PBhPcNSyaID7T2wNK0geh41
         ujXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wTSlUBJhs/qvu38DmR0+Po4umrlPHhRkuoDp2Z4kamE=;
        b=eQC9fjlVtrmTpLStLHbj2FAi9gKn6yV+xuAFiMgBiBwhJp6LLCfwGvOlUJOR2yz6zf
         YF9rve/WUpeIyTGJ+rxwaCWU81QfGekA46a8qZOe4BNxbK3rVuExt9j2sRuXcSkwq5vU
         rvlZPLkrqmx85iIXU6it8bUZGHOh9vL6g7AaISqZ/qFNQdG2RrDf3c5oYskRI4OOkh94
         VFhzbJCDDsN4WcKa8djjuJdoJNTIZ/Z/cDVZjd3EcylXMsOeRpay8zK42Al6yaSLSnTl
         IrC95teH6GjsqP9fiOXNYSAYP74z6Fmqfi2mwK7eqDYdk6SYWwNA5rxLdzCpUU4bpPNS
         bT1A==
X-Gm-Message-State: AElRT7EvQcebpnK6uZtg1LQGZIJuCuFJxDuWfJyAHJyC5pLUc4IxTOMw
        ofGfuKl25tIUFQSYraIiEUv1pl799CdY6ZunUCw=
X-Google-Smtp-Source: AG47ELsccsx8uZ41I9ALvkelNgXVz/gkBoe6X45CEekVWRONzbJph3nejmYQsZfm4xlHwHew+7GSJjB18sLUxcb2O8E=
X-Received: by 10.202.68.193 with SMTP id r184mr5991176oia.276.1520887338128;
 Mon, 12 Mar 2018 13:42:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.64.3 with HTTP; Mon, 12 Mar 2018 13:41:57 -0700 (PDT)
In-Reply-To: <20180311174123.2578-2-hauke@hauke-m.de>
References: <20180311174123.2578-1-hauke@hauke-m.de> <20180311174123.2578-2-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Mar 2018 21:41:57 +0100
Message-ID: <CAFBinCC8rZgQ9Yo-U_0yYp6nm7CzZ9vtHzdJG6k015ObE7GRnA@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: lantiq: enable AHB Bus for USB
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, john@phrozen.org,
        dev@kresin.me, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Sun, Mar 11, 2018 at 6:41 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Mathias Kresin <dev@kresin.me>
>
> On Danube and AR9 the USB core is connected to the AHB bus, hence we need
> to enable the AHB Bus as well.
>
> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

I don't have a device to test this, but Mathias and Hauke did test
this on real hardware
however, it looks sane since the xRX200 ("vr9") code does the same thing

> ---
>  arch/mips/lantiq/xway/sysctrl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index f11f1dd10493..e0af39b33e28 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
>                 clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>                                 ltq_ar9_fpi_hz(), CLOCK_250M);
>                 clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
> -               clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +               clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
>                 clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
> -               clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
> +               clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
>                 clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
>                 clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>                 clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
> @@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
>         } else {
>                 clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
>                                 ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
> -               clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +               clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
>                 clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>                 clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>                 clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
> --
> 2.11.0
>
