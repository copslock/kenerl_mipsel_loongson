Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FB3C10F00
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE946207E0
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXgeu4SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfDBJCx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:02:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41435 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBJCh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 05:02:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so8392695lfr.8
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=qXgeu4SR3w2KMphxlxSdhsDiCsgDnxD8N7dEJRxNMY1KCEZn+a24Km51Chafa8rc7R
         8vt3OsZ/4crIpd2UGHpq58NfwB/PxwtFP+3IJHGIujh/L1CGpPsXHn98ReL+XQ4NEeIz
         Es+XSgHyBrjngfEn0ACxZn0xsKX88emKV0Th0Y+vkzHmg62cADRWnfM/gEwbvTv4MCB6
         vthcbaibDb5TEl4hMFskUhDykMfoV8nhuE7REH/+RlK/qsfyqxI+68wJmBLjFmiNp4TC
         3FHoB1nH+EpVgTAUaqygyH0RPgR+zUNrapJFt98kpcCbr26z0oLDm72eg8NWd+DU9M64
         PxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=eoPDSkvPhxztB5SeioSRdh5Lp2ZYg4xV3pEHBWTQpfLYVAL5EaDHke3lO6KxuIqjsd
         ZsPZzL9y4h0Bn9USqqNWfIcrF8D6T2De5Mb5Kn40WJkUGnZfnw2LV/yfcAwbyaR4mrDc
         WhjcnS1Ra1/Fa/nRtfrCIhz+07CeMWugbU6J6BDxtski4wdHxkR71/zKRI9/lZOvd27T
         o0EABzOl3bobmWZYqIavbQM/hzdRCOVJ3tLYuqkWZxIXcTigwki9EJZwqq3Xr/BlapUR
         EVZqJPv5959cBaXauOeaav+rIaXrFA9JJ6O47zONNrH5qF/udjMCgc+JNeUJMhYP7GEs
         n7zA==
X-Gm-Message-State: APjAAAXulIPwHB/TTsqdHq56qNTC2TZXgZhSn1XjvlBnwRFhbZlEfdom
        OsoX8NNQYj9mjwJW5e7AeUTzxBgeR11fyZWoxjKuzA==
X-Google-Smtp-Source: APXvYqwtPX7kghb/BJOztTD/T+gcYWOsWYox+xPddCaZVH9LpSnlDmMiE9i0MNpUxqOUmA7yqx/ajp/L79zQ54ZwX/I=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr20421940lfi.122.1554195755639;
 Tue, 02 Apr 2019 02:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-8-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-8-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:02:23 +0700
Message-ID: <CACRpkdbFdWXFShmiKgdaBdQTH+HY2RQuKXMR3UU3_gMYb1inPg@mail.gmail.com>
Subject: Re: [PATCH 08/42] drivers: gpio: dwap: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
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

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
