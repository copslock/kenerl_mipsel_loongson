Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47597C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E95206C0
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcAB0HiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDCDyH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:54:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46479 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDCDyH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:54:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so13470880ljk.13
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=FcAB0HiV0D1wFCvN9UUzHqpaC207tyOdgYm1iEJYLy0dNqPi266F18yQVZKiyknSlp
         b1z56pB+uNGJ/rIkXwlgwYrtmHGJ8thEIybVfwmggv3AZQxlHjdXgNiXlGkm8HsI5qef
         MmJrxkq4SMZDcaEGxYxI0QDRtPsBcXvaiiQaYZXv13mmOVd3R5M7kDh0fqq85df+tzWu
         jsM6UsKfcu1hcxCEZ/PPn13rFD52nlxao9FgjSEJ7QLhyN6JuOHwwJWwfMTr0V2EmqWB
         6ub0AmwJOVlpUUBieKlaQRKydk7Kj9TEkTW5gFuQyD6imxMJzciXxgVsCpE+2i7VSZw5
         zNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=nsFQQtQ1fasBo/P7tNkdk+yLQm2Xejw3bqw6IYUJ22x36AhI55J9P6YOJXPWqkYbIs
         ft2aT51FmkOQ2OnUaFAEEUe1B/u/ez9bgerstfZWoUVGExTiT3QaYcqyRiIB8rZ8bMvJ
         F8C+5mweZ9ulC3IPCFbp7AH/wcTbLq/Q57SE0mMqi/Z5gNw7yn1djJ7PtYHvN6oONMas
         y070eP5JQ1gWi4Oq38IF/XFzvlIGvRaVkM3FLh0gpH+VHt22VWHcxakQoQlYT68wpKK0
         6D1Aj8tEC5r/s10qwqIzN75F0d5E6EURFmGnWi5NxBnDlatKCVsxH78WkVKhG+/baTj3
         bMPg==
X-Gm-Message-State: APjAAAWTbhXcRBveFrUi6PT9zVagJGQ+m+Y2pQGfXb0RF97rpXb4Q7sF
        SUOczHVJHbsTmCIu5AjpDOb9hyPBbLVxK6MCp8TREQ==
X-Google-Smtp-Source: APXvYqxpGZ8c4d+OSFL/TNeuciBdHc9lLiobnkh6xiQtgKYgSxn7sYqrFHvUVMCI1A2jtUm1B/dtL78/EX5uSaumg4k=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr37551304lje.138.1554263645732;
 Tue, 02 Apr 2019 20:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-40-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-40-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:53:54 +0700
Message-ID: <CACRpkdaVooHsLtJM1P6kSUd92qdP3E7vdus8+cOWGpqdMa=7DA@mail.gmail.com>
Subject: Re: [PATCH 40/42] drivers: gpio: zx: use devm_platform_ioremap_resource()
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
