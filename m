Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3263C4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90DC20857
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hrg6MLVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfDBJUi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:20:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46823 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBJUi (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 05:20:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id x188so9836042oia.13
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFHv/1EKVVkwkcwhoWRyJ4Zel9NdPttTyMtQT6gPj3g=;
        b=Hrg6MLVcwbJ0LTdZkhwomYvYzkOmmb7FNht8zsOy0AcJY4Fo+QCLXgBTEGd4yZP8oU
         hLcs1WpUYCjWYyzcv2XS2VSH3L5KhNZ+kI8ADr6tig2uxKeJP+rBuJC+5IYqgCsrZCE7
         T/VBZlbubg/DIum6GWuCKLyaelKBseMSoZcO6CIvoefewDtKmBcdmuGK+MSW6PHhPsao
         ichZs+1XeSTaC1VOD1vFEbW/8tWE6D3jyz3yWtesmXVrht4bdZ5QDG9srEI/UeBJjRIn
         bP9YYonB++XsFUXdn1LZyPHlVyY2W5vxFOtO+0sxbsGcaaUTuz1iHnrYSQ9gg6OVI2ob
         FoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFHv/1EKVVkwkcwhoWRyJ4Zel9NdPttTyMtQT6gPj3g=;
        b=dYXwEqxVx98UR+vK0wCk3bCp/JE8mWc4REXNCUwp4AiWBRu4fO9md6hvzYqpxbdhli
         ZUM9C6IFvdNXvUUmVfEbH4XEkv/dqZz5sebRQvwCEnpJUME98FKSU6C/xPuSXVwZfIrS
         f8c+Uxi1pdm43o7gWy9bGY7iQQ0S4TujpBHOkLrT0/cWJD4g5Z4JEH2ravnKo7FTpSk/
         EkXhrVzgRpwhAhibwTzMVrUdlaCvqy3xoR7Ywz/7ZdS76VZNltG18vmIlXN1G+anqwdY
         FUNYGElMGYm/ndg/P8vIgGWwg3/tVhlnioCyygsCY0u7wkavpc0AfLQxKVzvYlWNz/qo
         idVw==
X-Gm-Message-State: APjAAAVJMpnUsoQef2TX5silqtm9OsdgnQL0JQnKV6/t3jEtGhA6Jabr
        fmP1s0BSINuRO1Ytg9FijJxQprRizLjkDTnFUSzk3A==
X-Google-Smtp-Source: APXvYqx3sDrhkRuXci7nGgx4ZYWTKZGoBocA79XRBfoCmRAhfnSwu1TaoANI5oGannRoGVGI2OIFocl7DXT56vyEEMI=
X-Received: by 2002:aca:b607:: with SMTP id g7mr15401415oif.6.1554196837307;
 Tue, 02 Apr 2019 02:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-29-git-send-email-info@metux.net> <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
 <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com> <CACRpkdZMpZMHR22USj_m+_j6=nKCsZbJ6FumSO0EtYvw0OsH3A@mail.gmail.com>
In-Reply-To: <CACRpkdZMpZMHR22USj_m+_j6=nKCsZbJ6FumSO0EtYvw0OsH3A@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 2 Apr 2019 17:20:25 +0800
Message-ID: <CAMz4ku+zfKUero=YiWsOFqt=qvf7GoO1Agk8OvDYpC=bHMnjjA@mail.gmail.com>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, 2 Apr 2019 at 17:19, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Apr 2, 2019 at 4:10 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Tue, 2 Apr 2019 at 17:04, Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
> > > <info@metux.net> wrote:
> > >
> > > > Use the new helper that wraps the calls to platform_get_resource()
> > > > and devm_ioremap_resource() together.
> > > >
> > > > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> > >
> > > Patch applied with Baolin's ACK.
> >
> > This patch had some problems which I've pointed out and I did not ack
> > this patch. Please do not apply it now until fixing the problem.
>
> Sorry, it's the gmail threading that confuse the different patches.
>
> The patch I actually applied is for gpio-sprd.c and looks like this:

Yes, this one is correct.  Thanks :)

>
> commit 851f66daeab961328507dcce0980cd7e4ff5f9ae (HEAD -> devel)
> Author: Enrico Weigelt, metux IT consult <info@metux.net>
> Date:   Mon Mar 11 19:55:08 2019 +0100
>
>     drivers: gpio: sprd: use devm_platform_ioremap_resource()
>
>     Use the new helper that wraps the calls to platform_get_resource()
>     and devm_ioremap_resource() together.
>
>     Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>     Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> index 55072d2b367f..f5c8b3a351d5 100644
> --- a/drivers/gpio/gpio-sprd.c
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -219,7 +219,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>  {
>         struct gpio_irq_chip *irq;
>         struct sprd_gpio *sprd_gpio;
> -       struct resource *res;
>         int ret;
>
>         sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
> @@ -232,8 +231,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>                 return sprd_gpio->irq;
>         }
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
> +       sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sprd_gpio->base))
>                 return PTR_ERR(sprd_gpio->base);
>
> Yours,
> Linus Walleij



-- 
Baolin Wang
Best Regards
