Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB11C4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFC207E0
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyGeAX+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfDBJAe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:00:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38493 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfDBJAe (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 05:00:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id a6so8403657lfl.5
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=kyGeAX+6loCtDRSQFYtFQVQrjLKRVhQzAx+gJwDVfvnchTPnRnnjQfqlXzgSS9wyF5
         4TCpzfSXR5mQOl3e/mMZaT85aum1xxnOnMWoIIfSBfpUPn94sg0QwwxIaYGtsRtFshhm
         3mLi4A0hjTlz6+1gHxIcIkZGtkweN3Fhgbcrtyt65+By1zL+Cb9mj4t0tLPRlzl70Vk0
         PJKLRRBF7yOnypBz+YDogoyFm1RFq1mt8RrnF7NJQ9juRg3D/eb1dshh5nZSy9v97nnb
         I9TpEo5EGV6Q+PGvkgXLxxvmg48ngoiu7DjcYKYILlYD//1Z5M2TLN10/DzczGLP2V3P
         YZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=Ovm7lC9/Y6kOwErqE3knwVjZPe6i9hbSs6UK6qAn/NpuMgjtvTMTjvg9O6gEYuBySD
         sdGMXevJq8yy5LY0icZf9rfUTkgh1D7D/if7v2SDSx5nHprQ/QH5XbQHNMJRg42YahLF
         gmp1kEPxOacHSwKocPx+OXb5mfhbX7Bv00R2NLzMbdrapDOr2IUcI4pcHaae5AQEMVn4
         OVwN68OXEwKxKsiZ+8bP5RrGMuA4wfYD6JNR2NPhKIH6DW1WpBUco51LeeT4GrFg65Lz
         bkmU9lpUCQ2N07VPUnlOvQqLWa/Tn2N4YCa2PwGvFHbw4oxyd623A46Er02JaRiaJDMj
         JjlA==
X-Gm-Message-State: APjAAAWmKEyLkXo7BYwXqewnUNUGpZ9GJl5dRDJa/XQDC/LdCd3qeMqh
        xucwZd2eyinylyfRBVQTyC5Cdz7j/9cmiVMmG4B+HQ==
X-Google-Smtp-Source: APXvYqwbSJaAqTX9CxD4ZOjsVNtLtwJ8emyPA4U6UvuYIwZ+VHDNnwow4so8SpX9gkMCdCMeONmPZJGaXOPnMG2ozf4=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr8600479lfh.103.1554195632445;
 Tue, 02 Apr 2019 02:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-6-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-6-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:00:21 +0700
Message-ID: <CACRpkdbsjPRU+HPditfF9WgwZuajwQZb_0M1YLyC7V7--scK=g@mail.gmail.com>
Subject: Re: [PATCH 06/42] drivers: gpio: cadence: use devm_platform_ioremap_resource()
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
