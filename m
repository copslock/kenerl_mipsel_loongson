Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4BC4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABFC20882
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 09:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXttMIzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDBJKu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:10:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35502 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfDBJKu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 05:10:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so11435311otp.2
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXZ0694S7fFzp5Y3g6ww3d5ergdGQYmUb1qBPSGUqb4=;
        b=FXttMIzIsP71KjSeodaDsnif8KC8LaNlL3Cwfnj9hLZ0Xp0O7pd1ka/F3P2OQrn9gp
         t5N4x+abBKqy1Bi82RjDD1TccBPW1ZHpTDsIVA0oTu4+7UG9IW8hEQs92yb1vcyZGzLJ
         pP9N85f1V9GaROM6f6apIIj8yKTNKJN1/hFMZrc9/uIuvKaTa3JhDI3hAbqIUaRf8Yin
         xxVmhKtA/hd6tRsVyKUZ8rest6nNfcVu99UYxTAy5vTxz5Qp0lNU09B7/FuISmdnN4pZ
         0W3fyQ0NsN0MRNuaYuFGeVG85qCgrJ80j3vb4MzQVjPpBQZFLhK/YNRcdn7mjXxfoOy+
         4Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXZ0694S7fFzp5Y3g6ww3d5ergdGQYmUb1qBPSGUqb4=;
        b=KNyh0aI1gwBeyyYE+RueK8dOsnsSX+IqcmDiI3PDqePdl7YyRVkKE6d7ryD5m0vSAi
         w9juzV5aITtVCTAdHLeh7hdm05D7LzfJFNKyEmrsbGLHv+rLNOVGvm4H07k/7d3R8tT0
         bxCvmrsIx4EXaNL64cKgF3ANoF8ow57pXwoWKw7MgxcGTQDXM5Jp0hcThXXhroz0FUK2
         tWlv0KJFopyfC8CnJfjgfvZkiL4Lx+swqK9yeTagLhTMK8UtWcGihRTd9ta4XJMwG6SF
         ztrZ5HoQ1LDE+A/A6h5Lmohi7PDeVwEn8LqgynA0mnv+2Jty57a3lehfrn04Lg99cwiT
         S2Zg==
X-Gm-Message-State: APjAAAUy5cO/Ll/y7EPCLhe+gElOyxH71A6jlfS6KCSxMBGXOw5tDH8y
        4+X2b867M7BpfhYhF4x9kqu/ALONq/svQAL2tfMA+A==
X-Google-Smtp-Source: APXvYqz1MJ8bMDmcZW1WgEYchJMU4A9Q2Irypej5jBC2LEJOWBDCMbDy5VRyiIwuhZoQgWi1vgQSiZxPkh1DGVYN44U=
X-Received: by 2002:a05:6830:1446:: with SMTP id w6mr35990731otp.157.1554196249559;
 Tue, 02 Apr 2019 02:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-29-git-send-email-info@metux.net> <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
In-Reply-To: <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 2 Apr 2019 17:10:38 +0800
Message-ID: <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
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

Hi Linus,

On Tue, 2 Apr 2019 at 17:04, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>
> > Use the new helper that wraps the calls to platform_get_resource()
> > and devm_ioremap_resource() together.
> >
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>
> Patch applied with Baolin's ACK.

This patch had some problems which I've pointed out and I did not ack
this patch. Please do not apply it now until fixing the problem.

-- 
Baolin Wang
Best Regards
