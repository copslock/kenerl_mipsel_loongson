Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3EFC4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F320674
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKdNLirk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDCDxN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:53:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38456 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDCDxJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:53:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so13511895ljg.5
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=oKdNLirk+FdQMRSr7cf0MHJ+1UecP755xDyeuROadPcrJDkMfuEaZ2y1Lx+nUvTHas
         2uHQWwrpQLqr8MY6yGo5CJZIjqN24aSW4sEQWy+sgbqinO4qM1oitj7C0wBYt0XwJBCF
         /nZ7VOTD+xosmtI5GKA+p9EeeZoj/TXeyjOnIRaYG7NwBvjDrkt+EBlYhp5FFEfeDQvG
         bIYUbvVyi5iv8lOEiaTilE1XtpZBXV0BW8KY3AUoXv9Is828pXa9XLpC3UPjEKyy6nAk
         IWcBkEZbGiK3t/L6svLJVESWlRZNXKT6/8bGJx6pdVti9IIUvKOpPiCJfnJtL9ofh6rv
         ZBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=g4FTKB8TTbPv7aOxal83N2L2sQ7keWX2UCk9O83ri2wqV1F707WQKLuNluklMoiuXT
         cWZ031M+Qlu83GGZBMR1mHbnav6n8/rAzvNaq8K+cYXuO9O5jYDGgSCEXtmVGZ/C9/Wu
         /ahkrevq2XGCedlEwWu8zscpguP7R+89zJR8RajtKtad/+Q+Yq9kJHfLdpuSsNJrHr4G
         sKGYwP77g3Zkk3H7fY8FedhAlYP1X+K3YnM/76MLKYCLQYdH9hCdk5bgyL34UrVHACn3
         ET+4z0OKRtF2ZNeXGE+yAb985hyxveNVq5I1KzcvWKSS0KtvAp9+KrAPwcdDSOE8oAlS
         aYRw==
X-Gm-Message-State: APjAAAWM/IH07ocbHRx6Vjjxk4v0/xCHQUxv5DOIMiOMgfXIFxkuziLK
        yGV2AtgfBbCne2g1Ks9M5WBDe6IptD73NMWS5sEulg==
X-Google-Smtp-Source: APXvYqzTtbKVqg9Qh5s9cSbyc810FptuR375oOebYDXR0z1Np4n8sG5ptWdFdiap6BGGBoKTGLh7UeRhYqdLZO+xs+E=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr5127087lja.49.1554263587643;
 Tue, 02 Apr 2019 20:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-39-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-39-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:52:56 +0700
Message-ID: <CACRpkdYo-no4P2nFoepCE93G+X4UYw1+OEJTGSZZY_W5e3yJSg@mail.gmail.com>
Subject: Re: [PATCH 39/42] drivers: gpio: xgene-sb: use devm_platform_ioremap_resource()
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
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
