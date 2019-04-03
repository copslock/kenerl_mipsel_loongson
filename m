Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07583C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5B62146E
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNO02wrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCCeU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:34:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43550 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfDCCeP (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 22:34:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so13379431lja.10
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73ZkZUgkUuZQK7LGV80tvF14Mb93y9TFKlB/wlbdK9U=;
        b=GNO02wrd0qC9l8HJUlDZf+R/EWlcmeGpnGCL/k0YHyYWvQNtuHj5RflUR2hQ9KDmRe
         WSVU+HAKcD2q5/CI1CpXshQaEo+52MuIjcMClMcyCUV/xNDBN2edJ3uG1L+nVHGMWZDA
         dN4qHHTAn3wo7/LGtTxjpMmzOOTnzM6XHmTZLZAT6gX/8Z2gdDtksHr0Pva+hHkPz0ep
         weIC0hC+IR/NbbZeaSUqO89NdPTWXfi8MMleeAdqae5/JBBaG4KxUDwf9lmd8rsUF8Mh
         2FbiAdeZdBvNSgqIzv+G21LK9LxYP8R/BIu4vC+fHC3Z2N9MxYHpCIiPSrIYiC/vD+xC
         IjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73ZkZUgkUuZQK7LGV80tvF14Mb93y9TFKlB/wlbdK9U=;
        b=ZUCjdUZJGs1OTZXwXnZtGtxJJvP2ultZU8ey4WTz5DAP6SvNlCP8rpN6mD+T6FfVhG
         cfR8Rkv1bjFmoIMLlqthMRHT/iE/U7lSJSizWK+ddBusu/GOlOlXyMPRLFYxKHZ+Hzmg
         fxvnEKTqCCQ7OdlJcQWbgehBAdf7tSxrvCNr4Zgz/IieAbKZY/2jUgbzwpUWghrJeF9U
         y25QSXN6I0oxf7aO6TUSu8JMvXq15fl3yxfvfJQb3sDL7ySVWDhJ+PHTheZrqt/3bZz+
         01Ql0lsPE48oI9zFdxX7EVks8DUU0dvOFqQZShVZpW4MbD5wP8emVbnB+qCpdjIwBF+z
         RUuA==
X-Gm-Message-State: APjAAAX/3RMF7oO6WLz6yB8H6zcVpzNQJaRl5Amr3NGPdfU2QRiL2PXO
        XbdKs6fPVt41m9MQy9LOfJ2erNh2W1Ac0CGIcLuF5Q==
X-Google-Smtp-Source: APXvYqxUTntwDkNZQEqlHd6+GypniVK5KCFvKuk+8ovxaW8CZH1GqYjreaSGoeHxUSPtJhPu1cobJU0anDrQsvoM7TI=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr22937294ljg.103.1554258853023;
 Tue, 02 Apr 2019 19:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-16-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-16-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:34:00 +0700
Message-ID: <CACRpkdY6fSGJYWq78vTtwfHYauv4ej9nmiBQF7J6EgXid5F0mQ@mail.gmail.com>
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
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

> don't need the temporary variable "dev", directly use &pdev->dev
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Dropping this patch following the discussion. I like it better as it is :D

Yours,
Linus Walleij
