Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECCC4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBA3208E4
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmY8gXBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfDBJEn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:04:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44411 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDBJEn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 05:04:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id v71so3567190lfa.11
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfjTMt38drQF2ZeNKh0D4h5huWYelq/lQZojYMb5Wr0=;
        b=TmY8gXBSVmBCDM78j/p4VRHBWr0CbE9QvMl6dWxaQ6jHUDJvE8ql7ztJ8zJXVxPnB4
         NQNjb1nbMVM76EESuYBmNMo+o8l2ZYk7dzcAydIeI/q3VbcqlDbyhxRe+lyB+/gwr7Ik
         uzOSZiYVwG8J/YDwNuE0nSeQEHToUiU6pZuF4003yMl3gTfj7dYy9oeD4CgX9jBiOiTd
         N26kiSJgKU6hEVGxWbEzTcfbA4WdZcmJCCcs8c3hIngll/ehQ7k1jWQHnm0mDRbVjYiJ
         +qapoITVW50P/KkZrgAFkMOH70XHw2UGtCj5woxeFIRn6Q0DdLLfLjHbIc/6XDmh/Enf
         d1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfjTMt38drQF2ZeNKh0D4h5huWYelq/lQZojYMb5Wr0=;
        b=T/zzTvqsZNxJi/NGDVJ1kWjMlTQPv/Ujsv24C9xKvFy0G0c3Yr2AZiWYYfoc7gTcw+
         6ucP8HqUHOwrcnATCoG09jyDxyl4que6kOrJl7ct4yaHUxHqSkArxAf+jXTT0aMs0Z1Y
         tjpfcsbKolF06H2o8IVbzILNf7M7PQT3BiiFFQKsBQtRHc9p7luWGL/G9IHCyEXoy/w1
         bycJCopLPHEk+wrebrFJg3mkruTdlnz4enC/XOfMH2kVyzvDX5nTGsU4fYOfKECuqq90
         f7v1TKW53oBfgxnqarkAD+fDmDbyeLSAxL1DMxHl7s8Bet7FlCUymTeHjH9yT6gHRz3Y
         fycw==
X-Gm-Message-State: APjAAAU39QjZfymxkbhMPaL3Yan5yJ9/b0Zd+Qn9Jej2RutY9wxPgzOV
        uwLlfL1Tjqs0Uds/PGR0NorvIP+8gjxUoFZq1THoEg==
X-Google-Smtp-Source: APXvYqzAUMQvQqf8pPeVYLAXYjfBr8PmBdjZgNDzcJoyrod0gdqm9izzdkfzLQlhxU3PFvS8rAQq0DpwwiszU5v06XE=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr1658614lfk.138.1554195881960;
 Tue, 02 Apr 2019 02:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-29-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-29-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:04:30 +0700
Message-ID: <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Baolin's ACK.

Yours,
Linus Walleij
