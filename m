Return-Path: <SRS0=h4L/=RP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFF9C43381
	for <linux-mips@archiver.kernel.org>; Tue, 12 Mar 2019 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74CE214AE
	for <linux-mips@archiver.kernel.org>; Tue, 12 Mar 2019 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2gPjsM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfCLCi5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:38:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36646 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfCLCi4 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 11 Mar 2019 22:38:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id v10so914359lji.3
        for <linux-mips@vger.kernel.org>; Mon, 11 Mar 2019 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5U9bUNAqij3VG7YLuZ3Gl5U8RjZnG9CeEaaenO2RaR0=;
        b=r2gPjsM8mvyT/fDHMyPEcAkEBC1H4/+GdOE+0omVaDRVBaqjR1vvwxKH+bWW1cUbdU
         gZs4o1zIW3hLD/7WaXSX2x/zDfVEPEoyhpQUoBLpTDcsusDCB1z2pse3jnZWlseBs3+C
         xztHfNJexMNjhDe14W4UQtFK8Emx/BVseUv7VOe5kpNL5u3muNKvDSQ68xYObjCZDFX0
         aeXPBGN0nQxRCS5l+OmvIqJK1AxlE0tZF1fPQ/AwNe2YsVK3sXaFXLc61IPsuSbnE+dh
         fWOcLTokjwPNWz/iAOiieqjkD0TmFPbLqUMpVQwvHQDCIQYMTeE60dyliLq/hTsW7/Wd
         cZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5U9bUNAqij3VG7YLuZ3Gl5U8RjZnG9CeEaaenO2RaR0=;
        b=q5ftlznMltv5dFOEgZaHBHG19tmV2JRREgIne+Y5e4BwVoea2K6ER1YLCAo9J/FJqo
         WqEAH3k/gSlZ9jHw7VSKWGHczgreREDD42k1wXqREQzxWIFhahQcd3O+5VVw6GDTfXCc
         vSiNVG9i7uArrANvSqcIshzkmCO/Nmc7C3YoZuvhRE4LoX99SU1prb8Ice6ex1bnxA7b
         R/T3Y1hOw8LKxQqm75JGNwCZYYORcmN5GzZ5g/wUFBXozS5EMT8x5u6EpUa83x7YpkyZ
         h4kr9FjWK3aigGNawHq9J4diwOy4HB37IxM+YTXhNDC+8Pas0B7UuR6Cm8diVbTT+6N8
         bKUg==
X-Gm-Message-State: APjAAAXLD2dWMLdiC4CBT7wp/jr8HlgNYZHEd6xHqmXI3gCOUQ59X6cH
        xxqPAfZLUPq/8eQuysF26bpLeBVlqWHgZl7BGmpT2A==
X-Google-Smtp-Source: APXvYqxkAx87Dn3f1WaNYwv1DfReo6GgOrEGMmRjGCpnuqvlrNQLeTRGyz69xF8zgLXlvor8ek0Bu/hzP/94vfywRfU=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr17929912ljg.44.1552358334339;
 Mon, 11 Mar 2019 19:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-9-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-9-git-send-email-info@metux.net>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 12 Mar 2019 10:38:43 +0800
Message-ID: <CAMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
Subject: Re: [PATCH 09/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com,
        vz@mleia.com, matthias.bgg@gmail.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        ssantosh@kernel.org, khilman@kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        jun.nie@linaro.org, shawnguo@kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, 12 Mar 2019 at 02:55, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index f0223ce..c12de87 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -567,7 +567,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
>         const struct sprd_eic_variant_data *pdata;
>         struct gpio_irq_chip *irq;
>         struct sprd_eic *sprd_eic;
> -       struct resource *res;
>         int ret, i;
>
>         pdata = of_device_get_match_data(&pdev->dev);
> @@ -596,13 +595,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>                  * have one bank EIC, thus base[1] and base[2] can be
>                  * optional.
>                  */
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -               if (!res)
> -                       continue;
> -
> -               sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +               sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, 0);

This is incorrect, since we can have multiple IO resources, but you
only get index 0.

>                 if (IS_ERR(sprd_eic->base[i]))
> -                       return PTR_ERR(sprd_eic->base[i]);
> +                       continue;
>         }
>
>         sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> --
> 1.9.1
>
-- 
Baolin Wang
Best Regards
