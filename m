Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4086C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C406520830
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPBaWlji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfDCDe3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:34:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43311 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCDe3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:34:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so13461009lja.10
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iv8hveVdaKhWTZi7OqWKG7t/pu0bv/9a9sJfy/+lthE=;
        b=IPBaWljiZ4duIiE6sx7gWLsn3wstriahCMym1YpXLNeSXxpfLdiF4MbQye0rIawv2X
         wfV95RT8oOr76F2tSIJMXNAC/AQm3F7ssFCf7PH/c8eygnQ3hp2U3XJHwT6yoy3WxUaC
         RSr3u8LuI4SFzAXay5zwpe7in+4oSYPwdOS/cA7u9ViyPX/kvmmHNbTGOUcrW2N/NN9Q
         VserX5DtHIMM8/hdp3L98I2hAXB6tocawxJUHlh0NFiMRnfhmwfOIXuuQVFPi9+EotJ9
         4FsQU4yfe+6iRidseoAUGOWMEThLzrOBQGquh+lyLq4l71c3nbLe5C3wGrVdN8z/MhvA
         kKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iv8hveVdaKhWTZi7OqWKG7t/pu0bv/9a9sJfy/+lthE=;
        b=oHPrSLjt0frfktLiPe3RJHlYE7i4aocc17P/1NavoHpiIWWOWrPuMZRvZ8tyFh4o2d
         +cC3+346ymLivjiyQkbhUCm8vMPInHtn9rdYppgKndYFTktc0d10rLm5Yg9m84X7a+zG
         P3fkcFIFimpXcGoJz1RHq9xBbShBj+tKpmtFNQb41EjzM3fgHi3HLcWsWXswVZmGjENJ
         f4MvxsS12uW2NO/C3uGv+HmCg3CS5cqjh1GyjX5inkcgRflZfOPr7twbP2h1etf6zqVy
         O/wwZ4aU9Z0oyKsmUkYjpRPrqZgQD4dG8n4GdtUnpi/p5iXkxHX9tUJ+I8y7O4Bj4/kZ
         KxzQ==
X-Gm-Message-State: APjAAAUADQXMP5RyIwgFdEEKdoh3gjsRoo0CEnMoEZ0Xg/8BVdeOl7pA
        jg6ZfaY9ubbA2HFAosR4WD32hP0I4yHn08QyYgsKDQ==
X-Google-Smtp-Source: APXvYqxew37x4qIOkX9sj1ov4mBsJNCzvs222fQfCHXveouCBpwbU1FzNHV2qrpqyXGu32xEGqWjYfUMDoYi7nJaWok=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr37988191ljb.74.1554262467447;
 Tue, 02 Apr 2019 20:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-27-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-27-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:34:15 +0700
Message-ID: <CACRpkdbQZ80EpLxJbCqROa2Zxh3GibHSGmiGfR7CckJPAoCb3Q@mail.gmail.com>
Subject: Re: [PATCH 27/42] drivers: gpio: rcar: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:58 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Geert's review.

Yours,
Linus Walleij
