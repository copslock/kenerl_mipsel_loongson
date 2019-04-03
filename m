Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09860C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC46F2146E
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rADu4pUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDCCby (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:31:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34167 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDCCbx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 22:31:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so10501523lfe.1
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=rADu4pUFlQSiHHu/Yqux0TNpXg6OZP6olXelwlE4ZXBss8K/Xi624k4/xgYnjLPaFk
         6LHu6eDr2M3sovRjGbR8BWhTyw9LHHkdr3dEsL5jFKebYZmLHWYeMRWNshN+v3cWqJR2
         NHEZHidADGIga2q9OdQlQFYvnrzkSvtr9otJk6g8leCX23F9fCN9GpUd+61GUhoQhguv
         jh+Z4bLHhoqOntN2Sd/rI0vaCz3tujgUP8cy2Pxm54EkxJDz7oyelrHEp5+mcy3zwNKB
         Zw7jk0XjOWNla4QtVb8viJ226GvzVmo5Y7J6LOVc3F9EUsKda5rhk6O2EwAc4MT291ET
         GzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=tgwzRcobqATgtkyej6UDAqAdrNuGoSX9RAcEUoV61a/HmCpbhEEnBWKsOYSTVDsAA5
         lIn0BcNF5R1Kq68j/woibrKC9ggJBb12CYrC7B7ss98uaxRRwqjYsbOVzlfD+X1Rnnvp
         LgICvmtIbRS2XJ3qaWKHTbHqkTcfsQ+WCXkkKBaZj008Nhn2XY+jpJw6Z5bLVDq5i5Ra
         V9FJ7t+jWJ86swKz1FSyrA7woW2zDriBH6n1/ZswVjogBSr+RAp3+4zAJzXO6sTh4ksz
         wTjWvz9UVMJ3U5SJ4U8EVF53ITlHgI4kM7oTUiVQKCLwGXeMkCskA9Jf2VOzW+zr5am6
         EK7Q==
X-Gm-Message-State: APjAAAW/eSPWbA44n1t6FzeqWDhL2j5rIVyDG7TZxs6xpRgC5hAtlr8c
        q3LKNLPSzm+9PAQypNXMlfQ5aJfLdgoam9C2zxTLRA==
X-Google-Smtp-Source: APXvYqxpOXnm+lNb+lUoj3jKVOOzDHN+QTHRqeWf1baOh4qBvQpU26Ose0cmBhzuKT2woltxTRzl5P+I+4msmnykh/Y=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr11148707lfh.103.1554258711918;
 Tue, 02 Apr 2019 19:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-14-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-14-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:31:40 +0700
Message-ID: <CACRpkdYTHOps3PRXvX0c1hz2=POCpGxaWbTPRd0paWbv+sDHSQ@mail.gmail.com>
Subject: Re: [PATCH 14/42] drivers: gpio: iop: use devm_platform_ioremap_resource()
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
