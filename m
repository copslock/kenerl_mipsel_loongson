Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 11:40:26 +0100 (CET)
Received: from mail-wm0-x234.google.com ([IPv6:2a00:1450:400c:c09::234]:35692
        "EHLO mail-wm0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991867AbdAWKkTRGRpn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 11:40:19 +0100
Received: by mail-wm0-x234.google.com with SMTP id r126so125956524wmr.0
        for <linux-mips@linux-mips.org>; Mon, 23 Jan 2017 02:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2eAOLxqToya/OnJ8p3jPgtUoynuv7urkZydLTvNuS8I=;
        b=dERBgR9XGWl39pq5cQQXnhOYeI8DjT/WSyO2yS1OYmrHcNaNXcZ8P6ftjoXdSEK/tS
         cT9l+gTf+P7Uh4iue4my94bIkGoxfDDIho9qQaaD+Rx/iC47GHGoV4UqhcVmL1Zn0Chf
         6nOUxgJ4nek+eYKM2QFmFjC2Z2XtPdBlz5YDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2eAOLxqToya/OnJ8p3jPgtUoynuv7urkZydLTvNuS8I=;
        b=nojkyVrLlgXxTI9mdJgHBKfeSQ7NzdNnpVN89yMfzL+W76d3jUBwjAwRuXGgK5otRK
         0TtVn4kx7Wie+oo60TFHtBm1bYGAJ5hpp+x4zqRyH4//8mAII2ElPygTH+nWaUL1vKHn
         nm0oI/5t3DtidzodkwlQNlG9GbutfeOjAdlq/7L6CfcZl8u3aOdv0CgoAiuwT5y9zsnr
         qRSnctfJQX/vTe3IxYkkIPFF0b3XS05IlOREg2hAWiWLT0K8mKzp0abyxFSwe29Gh/0n
         m1Q8+fCvJagxXjYA0KmPI3loWEKouJXYC4xpN29xLFI9lCiNM7NPnVuv3M9ZTF/C9kWQ
         jbpQ==
X-Gm-Message-State: AIkVDXJ+zyffMdz9lO9S0nPQPcKus1TTO0uE8Ms+wNbq4xsPuae5A4ygJA5xFLXjPQGbj+J+ec2g4ZSXbJlrlhiK
X-Received: by 10.28.126.11 with SMTP id z11mr13696106wmc.13.1485168013761;
 Mon, 23 Jan 2017 02:40:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.185.107 with HTTP; Mon, 23 Jan 2017 02:40:12 -0800 (PST)
In-Reply-To: <20170122144947.16158-11-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net> <20170122144947.16158-11-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Jan 2017 11:40:12 +0100
Message-ID: <CAPDyKFpqs+w4jsYNBeH3VuB08Yp72JPh7wcYZZHJKSKeuAGE2A@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] mmc: jz4740: Let the pinctrl driver configure
 the pins
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56468
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

On 22 January 2017 at 15:49, Paul Cercueil <paul@crapouillou.net> wrote:
> Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
> the pins being properly configured before the driver probes.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/jz4740_mmc.c | 45 +++++--------------------------------------
>  1 file changed, 5 insertions(+), 40 deletions(-)
>
> v2: Set pin sleep/default state in suspend/resume callbacks
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 819ad32964fc..b5fec5b7ee7b 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -20,14 +20,13 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/scatterlist.h>
>  #include <linux/clk.h>
>
>  #include <linux/bitops.h>
> -#include <linux/gpio.h>
> -#include <asm/mach-jz4740/gpio.h>
>  #include <asm/cacheflush.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> @@ -906,15 +905,6 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
>         .enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
>  };
>
> -static const struct jz_gpio_bulk_request jz4740_mmc_pins[] = {
> -       JZ_GPIO_BULK_PIN(MSC_CMD),
> -       JZ_GPIO_BULK_PIN(MSC_CLK),
> -       JZ_GPIO_BULK_PIN(MSC_DATA0),
> -       JZ_GPIO_BULK_PIN(MSC_DATA1),
> -       JZ_GPIO_BULK_PIN(MSC_DATA2),
> -       JZ_GPIO_BULK_PIN(MSC_DATA3),
> -};
> -
>  static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
>         const char *name, bool output, int value)
>  {
> @@ -978,15 +968,6 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
>                 gpio_free(pdata->gpio_power);
>  }
>
> -static inline size_t jz4740_mmc_num_pins(struct jz4740_mmc_host *host)
> -{
> -       size_t num_pins = ARRAY_SIZE(jz4740_mmc_pins);
> -       if (host->pdata && host->pdata->data_1bit)
> -               num_pins -= 3;
> -
> -       return num_pins;
> -}
> -
>  static int jz4740_mmc_probe(struct platform_device* pdev)
>  {
>         int ret;
> @@ -1027,15 +1008,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>                 goto err_free_host;
>         }
>
> -       ret = jz_gpio_bulk_request(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
> -       if (ret) {
> -               dev_err(&pdev->dev, "Failed to request mmc pins: %d\n", ret);
> -               goto err_free_host;
> -       }
> -
>         ret = jz4740_mmc_request_gpios(mmc, pdev);
>         if (ret)
> -               goto err_gpio_bulk_free;
> +               goto err_release_dma;
>
>         mmc->ops = &jz4740_mmc_ops;
>         mmc->f_min = JZ_MMC_CLK_RATE / 128;
> @@ -1091,10 +1066,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>         free_irq(host->irq, host);
>  err_free_gpios:
>         jz4740_mmc_free_gpios(pdev);
> -err_gpio_bulk_free:
> +err_release_dma:
>         if (host->use_dma)
>                 jz4740_mmc_release_dma_channels(host);
> -       jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
>  err_free_host:
>         mmc_free_host(mmc);
>
> @@ -1114,7 +1088,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
>         free_irq(host->irq, host);
>
>         jz4740_mmc_free_gpios(pdev);
> -       jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
>
>         if (host->use_dma)
>                 jz4740_mmc_release_dma_channels(host);
> @@ -1128,20 +1101,12 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
>
>  static int jz4740_mmc_suspend(struct device *dev)
>  {
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
> -
> -       return 0;
> +       return pinctrl_pm_select_sleep_state(dev);
>  }
>
>  static int jz4740_mmc_resume(struct device *dev)
>  {
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
> -
> -       return 0;
> +       return pinctrl_pm_select_default_state(dev);
>  }
>
>  static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> --
> 2.11.0
>
