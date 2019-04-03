Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F1C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A07720674
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyD78TZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCDwI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:52:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36565 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfDCDwI (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:52:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so13538648ljg.3
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kg3WUa3CkCPyjjbhF0hOtQWsJmh9cExSsQakBS9fveI=;
        b=RyD78TZAxKA3ie7m03JtN5qUC8/Iaz6k16FIqQoqig2jPtyBVzCSxcMdJlEf+QEy90
         dzJ2Thkf8UQknpto25seUQSk499WvnST8woBVeQ6BVEABrvJG3JHEl2U/eRMAueLNpLl
         oxrAAUdFwxrFxuqTXint1gEqfwYupcxzxj0J1bsLsG1hqh1lHCof9ZnhoZClIgkICUwS
         sUHLnuX9egFaXk42UT792I15F5+trizSv+b7G03SPFarEydfXA66yLU3OM2MCsegdqN5
         davDZ5yIQOi30jGcvgcU1Rb9EYYm9CNLlclHE9bX4fJNyDhjM09ViKtTSjV0t5Qt3yoi
         lNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kg3WUa3CkCPyjjbhF0hOtQWsJmh9cExSsQakBS9fveI=;
        b=mAWoKvnKICLWYYwFjh5Yb26UPB1WJa2L36u2O8F/Am8BHIUP0ibtaAxvc6L0E/e+N1
         2siQpPxY2B/Rw5KScNkGwIOVhQzvt344vs/e17kfoZ8nPgsph8Zdb0HYFMi3x1RO2MyO
         FVMZkTxMxBGzoRym1sAk7z/O2dMVOZ7wLiFZJEbCaqYqZnLzcZ+bLcfchHCvK6vdWQ2y
         URss9hstF2jwa9NqmkfA9RSk05GZ6Hfnl196mLW8543LNLLR/kajxSbK6zUoRZyAqKLI
         c+qMxHnVF2t/CEH7YmX9lzVY19JcccnBvbBpOe84zJBCwgVdX28PXp+PeWmejvdcszVA
         Obhw==
X-Gm-Message-State: APjAAAXMv57CYPM26vwk12349g8DdQ6tMzvStojwswBmLdt4VXfiEvEm
        vtkBTqyGl6eD9rU1rsfrClucVhKCOM8JCW3sCcLXIg==
X-Google-Smtp-Source: APXvYqwu95SiNvGUSW3Na0JcXSGZvxzEgGJoSGGgx/uhoxot61MOWQd9qrZQucB2UWwmumcvfIt/NdzafNySEfCewpY=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr27125108ljz.25.1554263525916;
 Tue, 02 Apr 2019 20:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-38-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-38-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:51:53 +0700
Message-ID: <CACRpkdYEAZPS9t2JiMuRF6ojYiz+=WEe=hvrPw853TwSVc1kog@mail.gmail.com>
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:56 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> this driver deserves a bit more cleanup, to get rid of the global
> variable giu_base, which makes it single-instance-only.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Holding this back until we have more consensus and some ACKs.

Yours,
Linus Walleij
