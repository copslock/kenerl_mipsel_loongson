Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8877C4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8505B20883
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkvHpshG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfDBIyg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:54:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44754 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbfDBIyg (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 04:54:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so10781874ljg.11
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcgRygwxJ6p3YumI3VfX53m7wDZg8Ls0PelR4RJThXg=;
        b=nkvHpshGbeLFj0DsNJWbcQSKDAE9kMyCZ7+t5yRXovS3IGMrEaKtG0yYDoliaShKIn
         PEvL1N07XDZIFzGHulZXuZ0o0017ikPvuOY3jXtAODqwyLUD4OklgoiHJbD7I+kgYg5c
         biPi8sOR6X21awYEjgBYBesTGJhKug0p7Pn9NoMnjG0JXE91tr2iQmAlGiijbq3gPuBr
         b6bmhPk1KX7L/8eNgxQp8ktEX+JanUtDid2vK4FTbJtUKmEks5i3OJfPcZRGqUtQJzk6
         E5sAeYBZo7xfIqxqiaAqOhbS61ZSyuSknICX1mO89BZFSJ+gt8lVQ32ZntneORNLjs/S
         ZFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcgRygwxJ6p3YumI3VfX53m7wDZg8Ls0PelR4RJThXg=;
        b=GdFKOsPQry23ty5e8uKqBMaWiZ7ksO6ZYdlmlQGD+dN3ghdKGS/J+YxQQGGOc9yHiz
         DWzcEvtg0sAuVtKv9G/0Hnimjz2XvQTzKkFNitFfuNIZi9Qd7DD2d61+G2WS2XrSh6d3
         8bK7HXZ+lse+9FeFRB1Q+bXRWETLykLFkaxo/mYgbE8rfYlwQ5gybwGgDLOE9bCdaWJ2
         J8+zmLCMoV/opw/TvV8r5TEitJdEL90T5uc4b0QlMOApX9ciGqQY+dy3PpJH4HPuL9sC
         ZtGiGbF1wQgLC7RL/BjLIy0QKu0aijQnH4o71WeI5GjnpCYmtzAnErEUuuprF1GOPJ+i
         Qjhw==
X-Gm-Message-State: APjAAAWCu6vBsmwjf7F7ElBlolORD/DPJJauDTvh3Z+/7qOdldvCcqig
        l939FtERLn61e4d6ndAgD0ONHMRa9pci2ueIqbFl3Q==
X-Google-Smtp-Source: APXvYqzrMvRM4u96Qj2wgqZSpLaMpHo9pOhxXtzN0I80Lh29SQ0yBHKGWtcfsufgFC49MOM+OPB2ju49EnMD0HjXKUY=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr34732866lje.138.1554195274024;
 Tue, 02 Apr 2019 01:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-3-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-3-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:54:22 +0700
Message-ID: <CACRpkdaB2mLFStOrZu45VoP6V16JMZSPciMBaPZvz1e2nB7Qcg@mail.gmail.com>
Subject: Re: [PATCH 03/42] drivers: gpio: amdpt: drop unneeded deref of &pdev->dev
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

> We already have the struct device* pointer in a local variable,
> so we can write this a bit shorter.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Thierry seems to have spotted a bug in this patch so please
resend it fixed (I will apply some others though so no need to resend
all).

Yours,
Linus Walleij
