Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C10C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887852084C
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mw8gOlJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDCC1v (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:27:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45850 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCC1v (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 22:27:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so10457868lft.12
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtAzbbTpYWm3tVKs04V+l57uF8B+h/6NgprBGPnZSRs=;
        b=mw8gOlJQyzm1Y7BKI1LFzb+UUYWVc5AMv0r35B7azMcUHvsy+LMbGCEN4aoCf1dOLI
         ySadbse9YQxxK9pa/dwXf8+L4jfOR4f9MutjQ6E7TkZSEQ6fdtiAkri59BpA6WLjvhi4
         xCkcRG9kMhfuFisB/E70Y7WmE4do/xCihigqlsO1ob5t/tC6+yQYCu1FJAeo4WrgtbEQ
         BsA6LH9jU7ZjW98ZOn/kbeC1+XQWFPaFMZoUVbYlnuP0+ILSjXGKlJgzQ4phagZKbbmG
         86A7Z9GlbHOqt9V1gSgflek6au2TU1O7JhEFjyaF6neR3Jm/QMK+IOLshzrhILF/oA2f
         OLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtAzbbTpYWm3tVKs04V+l57uF8B+h/6NgprBGPnZSRs=;
        b=k53N0UoAkkacAfPjvE+04Xmj+I1xH0UqEsXV3TZSV1KoqUAlMHl5hW2Q3MMnQh1B81
         NQwRU8p6HDpWNUvNEPzypNZT5mHreFMfrYVjRwkvN43ZdW+OcwfhCHj2l/036oi620rs
         cCHWiFuah7DjAn+LOZYyGkOulcGkm/A2/NGY7xHubOUkivJ7rJ1AqEssJqsdw6uU/CEB
         PWaR4v0fBFswa1rXcMeXLLyMBH6bZJRCD7xRsVVxLjvUfYXDtlVWASOGI+nCvjVifJAp
         aHhCLVATg+TlNsyWRe6LKElPWY2Va6/NypqIdelqvTQHakSSvPRd8+k2080gVvwZQN43
         fuSw==
X-Gm-Message-State: APjAAAWXQD9s1CS44ReMmg70G+Zfa12htwyGhYHzP4Gxr9Tti7Dsrf9J
        Wg1viyf6wkOf1Hc5mLamPgbyJGmZFbTdMmmQBWErrg==
X-Google-Smtp-Source: APXvYqxab7wOrozXeZGoqw1ODDCRuiSEFwVhYIrjKk+PrzQp2+B+8S2/BmWz4LxJIGY45RcAihAN1FheplC/9k53Zds=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr11140922lfh.103.1554258469204;
 Tue, 02 Apr 2019 19:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-10-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-10-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:27:37 +0700
Message-ID: <CACRpkdbkrmpUpn4FxNzgjD+j4UKgBLYz8OPX+5gEkCZc+PvGyg@mail.gmail.com>
Subject: Re: [PATCH 10/42] drivers: gpio: ep93xx: devm_platform_ioremap_resource()
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

Skipping this patch for now because of the bug pointed out by Thierry,
BTW rebase on my GPIO "devel" branch after I applied the
uncontroversial patches (most of them are obviously correct).

I know it is not super easy to build all of those systems so cold
coding is fine with me, I will find any remaining bugs for sure. :D

Yours,
Linus Walleij
