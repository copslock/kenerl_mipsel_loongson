Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB70C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584B621473
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3w42pDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCDq1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:46:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45168 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDq1 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:46:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so13474411ljd.12
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7I5f3oaAeKB060KJpT0+lcuFqJQiqbew6eG6riAmH8=;
        b=T3w42pDiBLhnH/V2Kk83/FpvlKZNVmyCEwxNrk9Czh8azYZW3B6fyI8A1ZTUc3qonu
         /Mv3CabOzwCXE1aDYX70wW2fcxa5Gt6Chb/n9yoERIRSJ5fExVSS1ugeciBLhc4hXACt
         wBF5MlXr0iJjNbXGRypMtTd8nnbiLDVCX0vs3hzNy/8i0xOtNSIm8cZ1xQOhTuRgI1xS
         36y1V0FZ7SqXZdALkCyA6uy+nAUSz+ziOfzRP9WHrpKCsL6DUcfJYIYXTldVu8FbE6m6
         0i9KE2BMb+bH/nWCjuTci2biuiGKdACEM2mbkOxcR5FAr53Gw+SzmxhBKsSTGR54YlO3
         Z1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7I5f3oaAeKB060KJpT0+lcuFqJQiqbew6eG6riAmH8=;
        b=HZG3rLDQz8NvvNRXtnWhmPSxWQ7rJ1HScSdtD86aZJ+zUA8mhjQfwAlv+3x/IJSeAs
         1cxP/A2fV2e/g+orFz3PNcNgRlCq6ZjKYKPt73TwhsoolZXfkb8QovTVswkohT6Gavx/
         3VjvLCsXT9fajDe1fJhHeuHLM7QX+83CmznFP52jSoevKbnaFd3kiJGpkx9vvwnQ68/7
         CRMQfRmQtL+VX+fk1VrTEUxF4TZ95YN+dSTFhEi5z1b/yH9+WeqLnUr7CNdYfHu/VgTA
         p2DPwoure19JXYiuT1oPeP9AtrlvnWiks+/ErLCc0VSZx0zuyE7MajUcZlcpUH8J4iwh
         AmZA==
X-Gm-Message-State: APjAAAWFpSX2j46aG02R6HTd1e/NwmtcM/xyiTTmwWXTnePZy+s0JpY/
        7Q5JVsJ7ME4hcbFZObwP6i3vlUjCjTeeA70XJJgiTQ==
X-Google-Smtp-Source: APXvYqxF6qJAp4q2p2Llv1t7vPeGJkuP4A5obKVl56/8Xg6EVT65dWOAWAKTy/TgoOA4MOJ9kNO7MzPy4ApRZBP3WOw=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr27114047ljz.25.1554263185262;
 Tue, 02 Apr 2019 20:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-33-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-33-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:46:13 +0700
Message-ID: <CACRpkdZ0zzJkPfPGQS7ha4n9QYm_oaFQisvvo9ihpv=FAndG6w@mail.gmail.com>
Subject: Re: [PATCH 33/42] drivers: gpio: tegra: use devm_platform_ioremap_resource()
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

Patch applied with Thierry's ACK.

Yours,
Linus Walleij
