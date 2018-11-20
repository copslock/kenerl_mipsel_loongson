Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 10:32:07 +0100 (CET)
Received: from mail-it1-x143.google.com ([IPv6:2607:f8b0:4864:20::143]:39157
        "EHLO mail-it1-x143.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeKTJapPYoz3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 10:30:45 +0100
Received: by mail-it1-x143.google.com with SMTP id m15so2476225itl.4
        for <linux-mips@linux-mips.org>; Tue, 20 Nov 2018 01:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EiCfvnw1+dcUx/GLyJKPlb6HAVNRc+Hia63A1ARspyw=;
        b=JAwRppYkp3Kwfc2CdYF7ci9CDuECWXqCf7UzglUwSezKbVD9Wc1KU4gCjR7H3RgEqz
         XpYcX3ebAE25TADMKSxaJ/EB6LkBRwNskFjL2KbJz3IiHv9sod447DjYYLyk4d+ywYwP
         Ed9vtYs+En+99TwaLHH6qQz6t/cqMCz96w+n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EiCfvnw1+dcUx/GLyJKPlb6HAVNRc+Hia63A1ARspyw=;
        b=nGH77ImSOPLzuEkkFuKRx8d0+l9Lh5hIm22lOodk9lIz57a2pRx/TgSmwALq0vWgvF
         EKM8Zq17gGHyWnur/Cwn6Fe2YHOojQDfvyhiPX1l1gxvbIqeO9EMCLXvJO6ua+4KyWs0
         PC21VF2CUwvsUk5lLdUaZ5W2finAvE5/X+VUDaXtFrV0YRhxIugpf8POaUeSaLSQ1ra3
         BpocFP6A9k56xNPshwjqkvTqPL4y83KLoX6k9/zgTrJY2Nk4c9+KOoXvCwR/lnLqhhe+
         n0GcMbTsJvsqOR7iLs0+Lkp7vVsor7wEO1EjUelUzDnhuGuR47oP7RDzJLOneP5uG8mO
         3DwA==
X-Gm-Message-State: AGRZ1gJbZyGZcKeIz3YXb8R7+mnxNj7gMFc+RO49+PhXnp0iB+D2s1Jh
        XIv2h2RJq7VP75oA6HoZywhrKWT4V7uty0FBscVwSg==
X-Google-Smtp-Source: AFSGD/XNjva8YnIJyP7n9n5GR5ivcoLVsGa7afIIzuYw4fmL6ei6RAF+V0zV6S7uUDH/d6Xc5SouwQ8OzOCpT+ijoPg=
X-Received: by 2002:a05:660c:206:: with SMTP id y6mr1447412itj.157.1542706243743;
 Tue, 20 Nov 2018 01:30:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 01:30:03
 -0800 (PST)
In-Reply-To: <20181112141239.19646-3-linus.walleij@linaro.org>
References: <20181112141239.19646-1-linus.walleij@linaro.org> <20181112141239.19646-3-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 10:30:03 +0100
Message-ID: <CAPDyKFpHPXtaNtAxfXi3nS33bpXvcWeuaDdFtamA4Bs99hZPGg@mail.gmail.com>
Subject: Re: [PATCH 02/10] mmc: jz4740: Get CD/WP GPIOs from descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 12 November 2018 at 15:12, Linus Walleij <linus.walleij@linaro.org> wrote:
> Modifty the JZ4740 driver to retrieve card detect and write
> protect GPIO pins from GPIO descriptors instead of hard-coded
> global numbers. Augment the only board file using this in the
> process and cut down on passed in platform data.
>
> Preserve the code setting the caps2 flags for CD and WP
> as active low or high since the slot GPIO code currently
> ignores the gpiolib polarity inversion semantice and uses
> the raw accessors to read the GPIO lines, but set the right
> polarity flags in the descriptor table for jz4740.
>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 --
>  arch/mips/jz4740/board-qi_lb60.c              | 12 ++++++++---
>  drivers/mmc/host/jz4740_mmc.c                 | 20 +++++++++----------
>  3 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
> index e9cc62cfac99..ff50aeb1a933 100644
> --- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
> +++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
> @@ -4,8 +4,6 @@
>
>  struct jz4740_mmc_platform_data {
>         int gpio_power;
> -       int gpio_card_detect;
> -       int gpio_read_only;
>         unsigned card_detect_active_low:1;
>         unsigned read_only_active_low:1;
>         unsigned power_active_low:1;
> diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
> index af0c8ace0141..705593d40d12 100644
> --- a/arch/mips/jz4740/board-qi_lb60.c
> +++ b/arch/mips/jz4740/board-qi_lb60.c
> @@ -43,7 +43,6 @@
>  #include "clock.h"
>
>  /* GPIOs */
> -#define QI_LB60_GPIO_SD_CD             JZ_GPIO_PORTD(0)
>  #define QI_LB60_GPIO_SD_VCC_EN_N       JZ_GPIO_PORTD(2)
>
>  #define QI_LB60_GPIO_KEYOUT(x)         (JZ_GPIO_PORTC(10) + (x))
> @@ -386,12 +385,18 @@ static struct platform_device qi_lb60_gpio_keys = {
>  };
>
>  static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
> -       .gpio_card_detect       = QI_LB60_GPIO_SD_CD,
> -       .gpio_read_only         = -1,
>         .gpio_power             = QI_LB60_GPIO_SD_VCC_EN_N,
>         .power_active_low       = 1,
>  };
>
> +static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
> +       .dev_id = "jz4740-mmc.0",
> +       .table = {
> +               GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
> +               { },
> +       },
> +};
> +
>  /* beeper */
>  static struct pwm_lookup qi_lb60_pwm_lookup[] = {
>         PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
> @@ -500,6 +505,7 @@ static int __init qi_lb60_init_platform_devices(void)
>         gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
>         gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
>         gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
> +       gpiod_add_lookup_table(&qi_lb60_mmc_gpio_table);
>
>         spi_register_board_info(qi_lb60_spi_board_info,
>                                 ARRAY_SIZE(qi_lb60_spi_board_info));
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 0c1efd5100b7..44ea452add8e 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -983,17 +983,17 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
>         if (!pdata->read_only_active_low)
>                 mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>
> -       if (gpio_is_valid(pdata->gpio_card_detect)) {
> -               ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect, 0);
> -               if (ret)
> -                       return ret;
> -       }
> +       /*
> +        * Get optional card detect and write protect GPIOs,
> +        * only back out on probe deferral.
> +        */
> +       ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
> +       if (ret == -EPROBE_DEFER)
> +               return ret;
>
> -       if (gpio_is_valid(pdata->gpio_read_only)) {
> -               ret = mmc_gpio_request_ro(mmc, pdata->gpio_read_only);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
> +       if (ret == -EPROBE_DEFER)
> +               return ret;
>
>         return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
>                         "MMC read only", true, pdata->power_active_low);
> --
> 2.17.2
>
