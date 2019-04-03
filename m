Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C639C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B81720882
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1woiTDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDCDzH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:55:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45496 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDCDzH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:55:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so10558745lft.12
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=L1woiTDuO+XuU9uAEhcLUJVwGcHNVeNAThUH9QDtfeLxHL9l3Z7qpb9c+Zvrwt3/cn
         yMz4YBfDSIEmOfiTlzTSa54x/KCQ8/bLvqje6H9GJWNUSSwjv0SkaDRUYe31lvhyyXpL
         +kpUV62y6huzj3v35EGmev18x4Z7l2EPjmEBYxTc1hgsVKUJIl8ltEJ2GNnuRH4IGO4S
         CSdPJfwG59dh1rRPhSfJNf6E0kiGiGzkY+HmYgh9VSwkLzovMraQ7+bxaeQYqqAMcl1p
         raHhDT1cbgOUiTnt6WUEQbibk6OhaqoPR0pi34YfSH51t0sOXVWmHofQ+/I9qk3bRuYH
         f5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=tovY5nSqIDTgJNEELZLSD/DTkOr0kGK+YqDWX+W6sm9SuOcoqY3EZwsD+vXngyY46T
         fWGdku1DB+Z4lqReBFKdpeaipqDxsrG6HSrbyhtvZtv6r/0fZHghW0ZWX4qd1ZAkzcuM
         YcQszfx1Y1qEz+orwCjvVtnbbvDCZ5kum8Uu3zjXG4q+aESv7ljZiXpCufVB+t+8+uM4
         LCMOldKokDKQAf/d3gSOFia5nvBuTJDwjwR4JLGebM0/SduyiVvvUe2hiNb50v2YkGJ2
         syGq8I5T3l1JTDN2RqihxRTPf8JUA+vkC5XD0q5Y9ssLnn01fHJhUUrbxt2xrgmi+G+4
         t2WQ==
X-Gm-Message-State: APjAAAVrqaDm2jjaDZ0JtyPUBsqnoLsJZ8xP/I4hwlA0VxYSmyOtFxx5
        biZYlTquxYjCKtw3xn7rUfDLw72USFTmPhKjVzPdDg==
X-Google-Smtp-Source: APXvYqxWpI4BsMuMKPnXoOc8h357I5LzDG4UhGupkQrGbJO0KjNt6+BgxthytA7i0ad9bv+tGSHEY1s3hXG0xi1226s=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr37573324lfy.128.1554263705575;
 Tue, 02 Apr 2019 20:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-41-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-41-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:54:54 +0700
Message-ID: <CACRpkdYuNqj+SKMs_OWFF6pzj-uk62nNnhFHAgmUVp1gmiWZhA@mail.gmail.com>
Subject: Re: [PATCH 41/42] drivers: gpio: xlp: devm_platform_ioremap_resource()
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
