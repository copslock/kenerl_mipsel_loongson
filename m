Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D1C4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD352075E
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxF+Iewx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfDBJB3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:01:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43290 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfDBJB2 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 05:01:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so10806329lja.10
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=OxF+IewxRbr2zL2pxnfBtePhhgZRVEhiGqzL8uhWYM9HXtkYsBiTxd1BbzFxUxt0KA
         lziow7+FWufGOfOw+LbJJx/toY/CJLHywvVw6rW17TOEjT+X1gF+JkS0bxP+FXHfFDrh
         L45TpvoJglts9/l2Sn96+JLrntBN5tQh8goNCogQgMQWsgado5ql48UdbXQfRZPmpMmH
         z5pWsDLG3ES1R3eSKAvyAazo7x7fBrq4yaouVtY04uQNYMvVP4EPVdoqTKOJpmJwUrFI
         H7UIkEb1ouemFdw30mqBPN0TNE4emnYYpTradb36HYMHxMxQxzoJjHbeCxn2T/sqpHBT
         lpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=sVr1wLgNNa6orXShX0yIVHiy/p9IR1ZrOqpHRaflPUU2BOmqnwaJOA5DDGpsNwxDXq
         9Kp76WSyg+wLxhWC6u14DMe01HsA5W90CfY1HrG95dHrVpb4jEukSWMhAdhtAM81/Xgk
         UnTtjusN/wSCM4qipxdLn7b3WmtEYAos5z1w0slvp+CW6A0qCcONfwrpnNBjQntsKjic
         Aa1Azw+ejfJzQ3gWywOBaB8Azsp65Zc5ZrL/Bbc8WqIEdSawz4XAvNQtJVo24ogvFQBH
         k7lseizuquF7Wnbdel7Fdo84umEGipuZNivXPqU5UxkLobvpN77KoZyeunKWSno+FUMU
         aRgg==
X-Gm-Message-State: APjAAAVB8mtrsDQkochgR/iz+YjiuatLJvzyZBDmI/0iQmJjTef4e4Eu
        XzGbPFjwD0GUqx7hiwCRDRD+QBTB2zenLbiCGQdLaA==
X-Google-Smtp-Source: APXvYqyRs9O0HwXfMKbSAM5pEankx2i6ZFOMi/8KlNVr0ZVbJAEQbkcB8HSJvMo7dkvoTFxXqOiSUhk7RHtOmKylV0o=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr24401076ljz.25.1554195686501;
 Tue, 02 Apr 2019 02:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-7-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-7-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:01:15 +0700
Message-ID: <CACRpkda8g1ns5kpd9WzZsR_j5Pnh4icBkKtCJTRvjizEicP2bA@mail.gmail.com>
Subject: Re: [PATCH 07/42] drivers: gpio: clps711x: use devm_platform_ioremap_resource()
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
