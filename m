Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A92BC4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2642146E
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8QAW9kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDCC3t (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:29:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44303 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfDCC3t (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 22:29:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id v71so5658193lfa.11
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n40Gmtanin2LRj3c84+mc3xFGY0g/YNWV6TPA8Bz1eY=;
        b=l8QAW9kK6K8C+7fIgC6llonrFej8Bcc4h0e1KUwrxA4OVmJFNkVcgn2UyE12ckmDxC
         XrJVMDGvhXFHOI4rH6G8U9uPze+iGSuzdOm7NdGzL1tFeKH1aX4Nfjf1QsId/0Zos+2Q
         22M9Otu8g+pbrOmn3i51IKkrGoIgcX3qRjLCb63pyo88Y40jRGaPEkFsWoMTVqPnM2/G
         tLv7foK/dpybzaPQEZaHqur+dXTCNscH7MBV+rk9j7Rk+IF1hqDAqf9xZJM83UrxKYKs
         0K0kqgWhPrRDdk/7QLyw6ps4j0Ri1MOn+q9BzdNFoHzp6jkHovDAAx0rVFQkCaJEGaUq
         bKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n40Gmtanin2LRj3c84+mc3xFGY0g/YNWV6TPA8Bz1eY=;
        b=nd9jMxbkn8jvQJdmJWoERFELwNmSI96HY3wew1shBMZuvNs0fOvfUXbc+wYrpVaTGE
         E4Iik0WyqDGPTdCe2J5SZvgNNH5PHyz/tD1sz4wVP1SMeZETQAt0HoPV1KuTb0gJyGgX
         RWlPQqQwnex7YIfl8xw1pfAB3VBjSa8/Js5EfxWiEJ4PN1ylnZ3lP8beGET6vQjAdH4J
         0re53/OinSld4xonlBv4MbMmV5QrkQEsw5M6ssVJu2a+NGdB60mdtyrhsLkLx/I31WPx
         yoGza3t2LMwbcY06j3szmQsw4zgAqLMv40wWmL9w/Em4a2WjNsdlgBRTLunjwIPz+v1B
         /jKQ==
X-Gm-Message-State: APjAAAUWnN5bBHIRXEfVwMsJFeZtinnlF0LupE68ttAibNzSxW3dXrtj
        6fNEqbW++bxTukrcvbs2PpPuM4EigCkS0bpFP/GiIQ==
X-Google-Smtp-Source: APXvYqzejlF8ovyHuaAy6JGMq2uGvdmf/TxlUGTBW1AoyHaRM7Vqw5CHmJj8r60PHA7GrMI9mc+XBoJ+fUyLTMwvzm0=
X-Received: by 2002:ac2:4192:: with SMTP id z18mr9149812lfh.96.1554258587676;
 Tue, 02 Apr 2019 19:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-12-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-12-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:29:36 +0700
Message-ID: <CACRpkdYX-xPGE61L5OCpB8JLGcO5GPcPy0Td2FiMziMrRDt+Hg@mail.gmail.com>
Subject: Re: [PATCH 12/42] drivers: gpio: grgpio: use devm_platform_ioremap_resource()
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

Holding this one back so you can fix the bug pointed out by Thierry.

Yours,
Linus Walleij
