Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE05C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CCB20652
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ar7jDLQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDCDmY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:42:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfDCDmY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:42:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so5103386lja.8
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=Ar7jDLQToKPs/nL1ig+8Lc+BWdDiUFBGOkCPU+MPJDPuzsqzcUce14b/xgex8wSXEU
         5adVDvq7Tof/CzTOT93yw0MzZOL57yOSnEq8z3rWQvpT1ijheQY8mxbju+fwwYLTAljr
         FmALyJ5ZO0jWjnPleTeyw3lXwtSz6s+cZaegxs2DNLE/RobJMeu2auXtH9PyCHwVzZ59
         a7m++mH+W67N5kZn6PI39PesFpapnsvm0X4GBFY7enY63WBbfNi7IwG2o+tYJ3EQJcci
         l6UojTTaiBMRdtdvDMHmtKIYgigrCgsGjTIQ5v1JyBTyuJdfgWPGm6had/4zNZH7qcFM
         0VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=jVOP392QmzrTl3OyOM2B9wt0hED0Tm6r8lF8DzV+gnm18GP6Wp+RWL435NhmJ8/xmw
         GxIdXd2RTw4DOM6k3mtooG0wPJOa+BHbJ6veDnSIHfjFInlCaJMd2obXz6ZWi4yKhJOm
         vbllVjqbyUNRkGB8vhbQ6yYnBVEu4KG5/9n0F4Nn6Tp2gMEr/qd51YCT16nhj/EZCPCI
         Og9u3GNgNgSeRaLUBOA9xAz3mJMLziCd6QwQr95IyEGHo9TPSMA/VH/u0tx6p5ZADURd
         nKNMtkzpUtVS6olzQOnzZCSRu1tB4oUH8d9vUkepKDpHcIw8GaKj3whEpfMTwyp8MYNA
         iNRg==
X-Gm-Message-State: APjAAAWeT+M5ld9u+4i1OOtuo5/0iRceWAHJrYWqS3rtBqxkG1g6xrc2
        gnUwB7S/tH1sRiMltOHcplj8HLdS2DDqqVy7Nqj57A==
X-Google-Smtp-Source: APXvYqxYyLl/gAg7LNkCQqzWUJfjzmpc8RtRRtGaYDQNczCZ/hwV9pvp8KN8jnKzYCb1e4+CmoRubstnLsmNNCgJhA0=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr37528579lje.138.1554262942183;
 Tue, 02 Apr 2019 20:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-30-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-30-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:42:10 +0700
Message-ID: <CACRpkdb2Not7o=zCXiHjFK765rFjvV7kuSOyUNrGq9JKU4ARZQ@mail.gmail.com>
Subject: Re: [PATCH 30/42] drivers: gpio: sta2x11: use devm_platform_ioremap_resource()
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
